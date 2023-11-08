Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12E67E5ACA
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 17:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjKHQHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 11:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 11:07:40 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C351BDD
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 08:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xevv7QApejG4zXuC1/zRUIZNlTtqET4PBxf/zQd4GFk=;
        t=1699459658; x=1700669258; b=tcyCjy4RTKQ+uhXcsY71GoNYJM+RXmORpquBJ1zfNdPu6V5
        7JCo5nTHeJfgd3/ij3Gwg9yxFkwB0MyreuyTDKkH3fSkw8H9E2ZD6RYh7y7+5ooaccc75F+KHR+VB
        K3p0WkJWTyyNSTvc7rrfTj16Lt/ZZ9y+/C90NKg5tB1S1n8ERuZai/Kc0d6U3J3b43uw+TUYHz5eh
        cHrxiPdpYlExnBKb8cs4v9ih05cBKckltSMnW56qyWID8zfzsBVwK4WaKfUue7K+ph0TZfM+EusUU
        FlHsQlQOXgVab5Yy4+eA5s8hSh/xeynPJGuvIhkQ8zy18PAhHaFLi4TXva3PoDAg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0l5c-00000000bUP-13WF;
        Wed, 08 Nov 2023 17:07:36 +0100
Message-ID: <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
Date:   Wed, 08 Nov 2023 17:07:35 +0100
In-Reply-To: <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
         <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
         <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
         <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
         <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-11-08 at 07:55 -0800, Ben Greear wrote:
> On 11/8/23 7:44 AM, Johannes Berg wrote:
> > On Wed, 2023-11-08 at 07:07 -0800, Ben Greear wrote:
> > > On 11/8/23 2:31 AM, Johannes Berg wrote:
> > > > On Tue, 2023-11-07 at 14:08 -0800, Ben Greear wrote:
> > > > > Hello,
> > > > >=20
> > > > > I think this lockup is because iw is holding rtnl and wiphy mutex=
,
> > > > > and is blocked waiting for debugfs to be closed.  Another 'cat'
> > > > > program has debugfs file open, and is blocking on trying to acqui=
re
> > > > > wiphy mutex.
> > > > >=20
> > > > > I think we must not acquire wiphy mutex in debugfs methods, someh=
ow,
> > > > > to resolve this deadlock.  I do not know a safe way to do that.
> > > >=20
> > > > Hmm. I almost want to say "don't do that then", but I guess you're =
just
> > > > randomly accessing debugfs files.
> > > >=20
> > > > I guess we can at least make the mutex acquisition in debugfs killa=
ble
> > > > (or interruptible), so you can recover from this.
> > >=20
> > > If we can detect that the phy is going away in debugfs, then we could
> > > return early before attempting the lock?  That would catch most thing=
s,
> > > I guess,
> > >=20
> >=20
> > I don't think it would, it would still get locked on the mutex first.
> >=20
> > >   but still a potential race since I guess we'd have to do that check
> > > w/out locks.  Can we do a try-mutex-lock, if not acquired, return if =
wiphy-going-away,
> > > else sleep a bit, try again?
> >=20
> > That's kind of awful though? And it's not just the wiphy going away, a
> > lot of the debugfs files can go away individually (per station, per
> > link, per key even!).
>=20
>  From the backtrace in the removal logic, it seems that something waits
> for a debugfs file to be closed.

Yes, debugfs remove waits for it to no longer have active users, but
that cannot succeed because the users are blocked on acquiring the
mutex.

> Maybe the logic attempting to get the
> mutex in debugfs can check if file is waiting to be deleted,
> combined with a try-mutex-lock logic, and bail out that way?

I don't know if there's a way to check that, but I'm also not sure how
you'd even implement that?

johannes
