Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6C77E5C87
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 18:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKHRjv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 12:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKHRjt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 12:39:49 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10412C6
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 09:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=iq5fM7FvOFiDjLW606q4Nyi2S5VuQsA6L45P/6qWeng=;
        t=1699465186; x=1700674786; b=ogyot235u2LNSSD2L/CFD7YBRuGVcvN0NfO7e3JziUEsw8L
        bAj/5c3Ow38MdR1XIz/A9tG+JAPJ0QkrDcVMGzW0+MKC0jR5wqZaPmwauy/LIqvsNH6+UXgHNA0ok
        Hv45RTjXNITvXksjHCowWGF/Bc9oA6v01SzOV4EbzA41st4qWNjPkk11NyJIbcl60r0Ak/cUHN4LU
        rhVmgLSDSe2VsHVOsndHBbRiPBdOn6uAqCBehx+CcS6IUOVW5i+OTnep41HUsrj79uxPbERECEW2X
        g/lqOGkhXvU0+jOS9V/BPm/b1UQGKKW9Y0hqO+V6y8Lw2Vy0OWNFCNArMr9Pmmbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1r0mWj-00000000f4f-2AgZ;
        Wed, 08 Nov 2023 18:39:41 +0100
Message-ID: <2c079a7405e81715e6ded79cd5fe1d990b458418.camel@sipsolutions.net>
Subject: Re: 6.7.0-rc1 + hacks deadlock bug, wifi netdev delete + cat of
 debugfs file.
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Nicolai Stange <nicstange@gmail.com>
Date:   Wed, 08 Nov 2023 18:39:39 +0100
In-Reply-To: <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
References: <56d0b043-0585-5380-5703-f25d9a42f39d@candelatech.com>
         <cb377661e760d7728d11bd155b016f852b2681eb.camel@sipsolutions.net>
         <e8e38526-665d-6a88-b433-6f40b1182b57@candelatech.com>
         <d77c0a76201f77b7e86c2f200d2fea5cb6bffb94.camel@sipsolutions.net>
         <dd6c7cf2-1955-4c70-fd2f-ffe2915111f4@candelatech.com>
         <0cfd8ae0577e52fe8db41dbfb37ee5197a1857d6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-11-08 at 17:07 +0100, Johannes Berg wrote:
> > =C2=A0From the backtrace in the removal logic, it seems that something =
waits
> > for a debugfs file to be closed.
>=20
> Yes, debugfs remove waits for it to no longer have active users, but
> that cannot succeed because the users are blocked on acquiring the
> mutex.
>=20
> > Maybe the logic attempting to get the
> > mutex in debugfs can check if file is waiting to be deleted,
> > combined with a try-mutex-lock logic, and bail out that way?
>=20
> I don't know if there's a way to check that, but I'm also not sure how
> you'd even implement that?

Is it likely that we have lock contention for debugfs operations?

If it is relatively unlikely, then maybe just doing a mutex_trylock()
and immediately failing the operation with -EAGAIN could be a solution?
Obviously userspace would need some retry logic, but that is simple and
it could solve the delete problem.

Benjamin
