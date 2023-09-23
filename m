Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705BE7AC501
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Sep 2023 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjIWUJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Sep 2023 16:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWUJK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Sep 2023 16:09:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E179113
        for <linux-wireless@vger.kernel.org>; Sat, 23 Sep 2023 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Y+/vL/8oN97i0mNFQgOviFMY8YQRqWnmHAvN5eOx1co=;
        t=1695499743; x=1696709343; b=swA+NrMR9pTHBH3WAA9fdF2JQqgNxurDwfGoj+jffEPtDtq
        CpCM+EyqC1IbcWZe4IRdiC2HwCLIP4/0If7o9sNJkHkUKiM0BX5D8hZxtRH9I/2mS6ro8xTHqhrM9
        QaNMQI/6kiKgAY0lIylGwPYLG/zKfBmRYO+CTwkwJe1VvQ9UC2M7YVhNVWlKyec7qCXAjdXmRoPb0
        d0NRIAPnjwHl+qVxZs1HyMyG2wlXW10bcJJTKtVklxdoy3XGstDrdg54k1/pPHsRKFX57nTMygoSJ
        WDfo92A5aOG/FWCt2HL8JHEWC+9EauMzrZP8X4yFaAFEmoFaGbKuuJI5Ux8YZuHg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qk8vx-0006ha-2V;
        Sat, 23 Sep 2023 22:08:57 +0200
Message-ID: <75b4b34f9e49e1af2fac5fdf8a1d022f8b0b2d5f.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: ath11k: mac: fix struct
 ieee80211_sband_iftype_data handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 23 Sep 2023 22:08:56 +0200
In-Reply-To: <87ediqa674.fsf@kernel.org>
References: <20230921075440.1539515-1-kvalo@kernel.org>
         <87ediqa674.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2023-09-22 at 12:49 +0300, Kalle Valo wrote:
>=20
> > +		if (iftd->types_mask & BIT(arvif->vif->type)) {
>=20
> Johannes pointed out that I should use ieee80211_get_he_iftype_cap_vif()
> instead. I'll submit v2.

And I'll note that it's not just because it saves open-coding it, also
the BIT(vif->type) in mac80211 will be wrong because it's always STATION
even for P2P-Client, so you need to add the vif->p2p bit in.

We maybe shouldn't have done that ... but it seemed kinda nicer at the
time to treat them both the same except in special cases.

johannes
