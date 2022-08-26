Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B15A2245
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245624AbiHZHuV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245629AbiHZHuR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 03:50:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A91E7B1F2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JZOy3aqcY/5GUTNQZ+lZldjj/GO9rTTjsro1+xq9UYo=;
        t=1661500213; x=1662709813; b=xpPnEsSpdEbGVcKHk3UoO0gqlrZES/Hjp3IZTjpwxNfaxqb
        nwHmyQDTM3lqDNg8A8QNi14gaJvaoDMTW0lRZ5XSwtswcYYFxZ1gZrCT2VuZwKDHE5y5VjBWnvrCg
        a8/4gFTINmYOAbxTQdgw1W7EbJwHU3tMZJ49elX5InWkZbcTxw+V9zibWgc6MiAs1SAV+ASYMmlVY
        hAYn9089b6BHGqBnubeyrDz94nl1pQ4CT/a2lHYxYFt9l76RiyreFjn6oXoLW9sK/+ol/yWIf9+Qg
        LUG/T0xdY5EtU4HpS3qtRcGeSq0zsqYon9EFcJDqh6Ccapv/Z8YBa6sBL+QGUulA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oRU6U-0009aR-38;
        Fri, 26 Aug 2022 09:50:11 +0200
Message-ID: <13b0e503c3b4b87c65da127b5a77547d8e37c9c4.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/2] mac80211: Support POWERED_ADDR_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 26 Aug 2022 09:50:10 +0200
In-Reply-To: <a424a23753eb922c980d54414a0ad0f015f84e94.camel@gmail.com>
References: <20220811231338.563794-1-prestwoj@gmail.com>
         <20220811231338.563794-3-prestwoj@gmail.com>
         <e898282f0766bdf0bd9cbb92d2a3551ff28cdf6b.camel@sipsolutions.net>
         <1cdf35f95aca2a65d0d738544fb04079125b9581.camel@gmail.com>
         <6fa6b1b62f6a1bc945708cca9e27136f1737386f.camel@sipsolutions.net>
         <a424a23753eb922c980d54414a0ad0f015f84e94.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-08-25 at 15:26 -0700, James Prestwood wrote:
> >=20
> > But I guess we could leave setting
> > NL80211_EXT_FEATURE_AUTH_TX_RANDOM_TA
> > to the driver if we think it'd be less risky that way?
>=20
> (I assume you meant this new POWERED_ADDR_CHANGE feature)

Err, yes, copy/pasted that wrong.

> Anyways, is this something all mac80211 drivers _should_ be able to do
> (I thought I remember you indicating this was the case)? I'd hate to
> introduce (expose) a bug for some driver I couldn't test... but also
> the WARN_ON would be very easy to pinpoint what happened.

Yeah, true.

> IMO if mac80211-based drivers should be able to handle this, I think we
> should keep it in mac80211. Any issues that arise would be a driver bug
> that was exposed, and needs to be fixed anyways.
>=20

Agree. And you're setting it early in alloc_hw() so drivers that (think
they) have problems with it can unset it.

johannes
