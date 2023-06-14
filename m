Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19067308F0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjFNUIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 16:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNUIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 16:08:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63310DC
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=QQLFT6k0ZZYt8uWvR/jmlcthvx+OpBnJbFpqAIa2rRo=;
        t=1686773333; x=1687982933; b=pdSVtSN4r0tWzyvL4AQVtGckd0iDqfKqoGXwrqF0270mMpy
        PvesstTiSej1J27VQtul5tidkai1CiMbU5sK1Fajo6XostwMtrZYHVZkZr9oYCM+tn3fnu83ShNVf
        6iH0xxvZ0ngQl0ya7YtZoDSKKR9CPpm8dJsRA7hQE89fkNDxAH1yTtmI7/F/+97ZNIUiqrBZgQIlx
        x+YGa3cqpnalfQgszpF6e/n3YsnCzXLBvO8UZO3YoGGAQgSXgzUu/JXHh8Ud8GELZ84YG7QCwYF8n
        c/J2zND8l197AwTkuTCETM7e6Eo3iqZs8yfnjCgXhIDE5NZjs3vRTwuCaWMhhBfg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q9WnT-006Kyu-0w;
        Wed, 14 Jun 2023 22:08:51 +0200
Message-ID: <559120af6ed8cdfdee7eaa83531b35de2ce24a0f.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: add eht_capa debugfs field.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 14 Jun 2023 22:08:50 +0200
In-Reply-To: <e81d4d8d-8076-00cc-cb72-8417dc8203ce@candelatech.com>
References: <20230519162324.1633120-1-greearb@candelatech.com>
         <1038a5fd7d658cc29d11a6eb8776255c50e8226c.camel@sipsolutions.net>
         <e81d4d8d-8076-00cc-cb72-8417dc8203ce@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-06-14 at 09:39 -0700, Ben Greear wrote:
> On 6/14/23 01:29, Johannes Berg wrote:
> >=20
> > > +	/* TODO:  Fix and re-add this.  It compiles in 6.4 but not against =
'next'
> > > +	 * according to the kernel build bot.
> > > +	 * PFLAG(PHY, 5, SUPP_EXTRA_EHT_LTF, "SUPP-EXTRA-EHT-LTF");
> > > +	 */
> > >=20
> >=20
> > Well that's because the spec version was updated in wireless-next :)
> >=20
> > So please adjust according to the new fields there.
>=20
> It will be some time before I get a chance to revisit this.  If you can
> accept as is, I'll fix the remaining bits when I move to 6.5 or whatever
> mainline kernel has the updated spec.
>=20

Actually I think it was just this field, so maybe I can just take v1.

johannes
