Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6355AE61F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 13:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiIFLB2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 07:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiIFLB1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 07:01:27 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EDD12ADF
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 04:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Z1O5qAHQmSSyMJQ8woz/4kYWWmGM/sPZRLewfXFIl2w=;
        t=1662462086; x=1663671686; b=cktNCGQal4GIqDIaB3VeSwwW/b6zK3OsoyDwD0AEkelxw+s
        LJYSmpDKFR2mboJgMBfHfZ7U44RgeTkJdgUIWxNYu2HDxzMJgzuzYfJyZikbt4XrExWcepK1SPlvJ
        DLA3rb8rzJx82XmiJiPYE9WjutfBDKdWFAaC9G2Hn3mO3RML4IbjAjQ+g3SRgm8+ocW4xK2lN7232
        2E+Jzhb/ApB07iNgIsO8BkdpWPJTFlWxZLFcpGy9xmhJ4ZiOLz/hB9IgT5zGRkEW/ASyHuVrOKrh0
        MG6LWSFaCrOcIbKyW9XvY1viUl97zHS54qUIiIWCeQbOwCdUWztvqiT7hE4GU14g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oVWKZ-009PLX-2O;
        Tue, 06 Sep 2022 13:01:23 +0200
Message-ID: <52e4bd3a7d24fca06a507f86fe23d23a552c7c2d.camel@sipsolutions.net>
Subject: Re: [PATCH 3/7] mac80211: add combined power type definition for 6
 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 06 Sep 2022 13:01:22 +0200
In-Reply-To: <20220704102341.5692-4-quic_adisi@quicinc.com>
References: <20220704102341.5692-1-quic_adisi@quicinc.com>
         <20220704102341.5692-4-quic_adisi@quicinc.com>
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

On Mon, 2022-07-04 at 15:53 +0530, Aditya Kumar Singh wrote:
>=20
> +/**
> + * enum nl80211_regulatory_power_modes - 6 GHz regulatory power
> + *					 modes
> + * @NL80211_REG_AP_LPI: Low Power Indoor (Access Point)
> + * @NL80211_REG_AP_SP: Standard Power (Access Point)
> + * @NL80211_REG_AP_VLP: Very Low Power (Access Point)
> + * @NL80211_REG_REGULAR_CLIENT_LPI: Low Power Indoor (Regular
> + *				    or Default Client)

REG_REGULAR reads a bit weird, and anyway "REG" as the prefix for
"regulatory_power_mode" is a bit strange?

Maybe use something like REG_PWR_MODE_... ?

> +++ b/net/wireless/util.c
> @@ -190,6 +190,66 @@ struct ieee80211_channel *ieee80211_get_channel_khz(=
struct wiphy *wiphy,
>  }
>  EXPORT_SYMBOL(ieee80211_get_channel_khz);
> =20
> +enum nl80211_regulatory_power_modes
> +ieee80211_ap_reg_power_to_reg_power_mode(enum ieee80211_ap_reg_power ap_=
type)
> +{
> +	switch (ap_type) {
> +	case IEEE80211_REG_LPI_AP:
> +		return NL80211_REG_AP_LPI;
> +	case IEEE80211_REG_SP_AP:
> +		return NL80211_REG_AP_SP;
> +	case IEEE80211_REG_VLP_AP:
> +		return NL80211_REG_AP_VLP;
> +	default:
> +		return NL80211_REG_MAX_POWER_MODES + 1;
> +	}
> +}
> +EXPORT_SYMBOL(ieee80211_ap_reg_power_to_reg_power_mode);

What is the use of that, why export it? Same for the other function.

johannes
