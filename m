Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7485C7E536E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 11:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKHKcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 05:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjKHKcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 05:32:04 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95B210D5
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 02:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=L0U3X4ZpEmVlHrsxv9nJ17V3OEox2HSupJWJgiueLbY=;
        t=1699439522; x=1700649122; b=Vr/UvACKYNBzZ0n8+NtnDPkRnklN6Ur764cjVepnY4v8zRJ
        q8ufOFNHCxQS/KH/uSZSf7O55XhDim9c1LaMNBVNgRIXA5Vy32Ec19YWvQIyWcRqGWxDVKHs8tZhW
        D7hmlGOHMQAh+miLYJuSjNZkuAO8TydJ1f/aVemBXsjyOCbS9N1MHWybr0vRW+nA91zH7zTfZxOSe
        0SSJUKn4ATrrDTRnZhHMH0byqQRF0S+J8z2wmAVlvutcYlFdB/oHZxwDTnHifQJ9APuUDckpsjoCF
        2DB4RVEBFP9TMXmteLPJGj1M4a2bx1rYq8dYNsHZUis4n/7YA5r2npP2Yh5WV5NA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0fqo-00000000SWa-2OXp;
        Wed, 08 Nov 2023 11:31:58 +0100
Message-ID: <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 08 Nov 2023 11:31:57 +0100
In-Reply-To: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2023-11-07 at 14:08 -0800, Ben Greear wrote:
> Hello,
>=20
> I think this lockup is because iw is holding rtnl and wiphy mutex,
> and is blocked waiting for debugfs to be closed.  Another 'cat'
> program has debugfs file open, and is blocking on trying to acquire
> wiphy mutex.
>=20
> I think we must not acquire wiphy mutex in debugfs methods, somehow,
> to resolve this deadlock.  I do not know a safe way to do that.

Hmm. I almost want to say "don't do that then", but I guess you're just
randomly accessing debugfs files.

I guess we can at least make the mutex acquisition in debugfs killable
(or interruptible), so you can recover from this.

But fundamentally this is probably not really even a new issue.

I don't know how to interrupt a specific task that's stuck in a specific
debugfs file though, e.g. when removing them.

johannes
