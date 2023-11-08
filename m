Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2747E5A4D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 16:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjKHPoN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 10:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKHPoN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 10:44:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74591FD8
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=vpwYn3KEH/zaoEbPKqDidZ55d5D05uT+mZA8mgFTcEs=;
        t=1699458250; x=1700667850; b=bO0qnQJqxSDp4UnP3Qwm54WMVYpR1luMFEcJERfPY9ntaS0
        uZK57YGWt8I3zl/xLfhmWqYW+4F1A2c13N8OwTvOHuKtgDwlgROG5TFPKyfjEfcqT2ygFUc2DAv5B
        smh/qB35GKUXgj8nOdoIAODedQozrhCUbC1XKYq527dEClo6eHfXx84iCD9DBgdQcMgG/oxXQK08t
        pcPnrlKkqjKFc7qyTJrOnySjBhrMgwAUF6vGC6jRBzS9qzyCG1+uGj79WshNR/dR9doVfaEwGC5L+
        2nGYEI31cQuN5BhNWcvEkKJZnjON9A6ss5uBO1YMffiRO9ZmD2vcq5RIH0winzQg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0kiu-00000000aj1-1TgM;
        Wed, 08 Nov 2023 16:44:08 +0100
Message-ID: <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
Date:   Wed, 08 Nov 2023 16:44:07 +0100
In-Reply-To: <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
         <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
         <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-11-08 at 07:07 -0800, Ben Greear wrote:
> On 11/8/23 2:31 AM, Johannes Berg wrote:
> > On Tue, 2023-11-07 at 14:08 -0800, Ben Greear wrote:
> > > Hello,
> > >=20
> > > I think this lockup is because iw is holding rtnl and wiphy mutex,
> > > and is blocked waiting for debugfs to be closed.  Another 'cat'
> > > program has debugfs file open, and is blocking on trying to acquire
> > > wiphy mutex.
> > >=20
> > > I think we must not acquire wiphy mutex in debugfs methods, somehow,
> > > to resolve this deadlock.  I do not know a safe way to do that.
> >=20
> > Hmm. I almost want to say "don't do that then", but I guess you're just
> > randomly accessing debugfs files.
> >=20
> > I guess we can at least make the mutex acquisition in debugfs killable
> > (or interruptible), so you can recover from this.
>=20
> If we can detect that the phy is going away in debugfs, then we could
> return early before attempting the lock?  That would catch most things,
> I guess,
>=20

I don't think it would, it would still get locked on the mutex first.

>  but still a potential race since I guess we'd have to do that check
> w/out locks.  Can we do a try-mutex-lock, if not acquired, return if wiph=
y-going-away,
> else sleep a bit, try again?

That's kind of awful though? And it's not just the wiphy going away, a
lot of the debugfs files can go away individually (per station, per
link, per key even!).

So really what you'd need is a debugfs-level infrastructure to "send a
signal to all the things that are keeping the file open"? I suppose that
could even be done, in theory, but not in wifi by itself.

> Or, can we grab rtnl before we even open the debugfs file, like in the .o=
pen method?

Not RTNL, but rather wiphy mutex, but the question still stands - but
no, the open method has the same problem. If we acquire it there, it
still goes through the proxy fops in debugfs, so it'll still wait for it
to be done. It'll just shift the problem to another place.

> Or can we remove the debugfs files after rtnl but before we lock the wiph=
y mutex
> in the destruction path?

For some maybe yes, but for a lot of them like link/sta/key removal not
really.

> I have been running similar code for...like 15 years, and haven't seen th=
is particular
> deadlock before, so I think it is at least exacerbated by the locking cha=
nges.  Or maybe
> I had particularly bad luck yesterday....

Oh, it almost certainly did get at least worse or perhaps introduced by
(a) moving everything to a single lock and (b) moving debugfs file
removal under the lock.

johannes
