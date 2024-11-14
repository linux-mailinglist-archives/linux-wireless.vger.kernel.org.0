Return-Path: <linux-wireless+bounces-15305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B44F9C910A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 18:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E43284723
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 17:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1A18C010;
	Thu, 14 Nov 2024 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y0FRrLGv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B1184528;
	Thu, 14 Nov 2024 17:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606297; cv=none; b=tQVi2MGwI2Zc87cGlR0hrYrAfQn+l9eQVtH4eSJ5RkftC8E1QayohnnPJs3cNQ4/j9VWSB7uvBErWwrLYQA85eEnZ+e/a514f9kWHmD1KWQxPJpcZv72T5q6XUpHIw5qHDWn8gEqZIgayCF8DT07jfjb/tBkdxbPZY+dh1DyaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606297; c=relaxed/simple;
	bh=W+ydQ90TONgAfEYiEluV3t5x57+LGauopTl2uvcI1Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cvFs4G79h/YnTQ24rB4mewa/arwPfXGa2NB/2PwPA8Gd9RNmfk9wl5ef7f3bLqAC3FmGQBoDfjmyAIkauEi6eltK7D/PnfEEn99W+h7aux+TKUVN+Uq8sGbMWQmlDyR2nZxy+t/nVlnp5BGWUX3rN0kPxS/pS1tIg1acMuT9Vmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Y0FRrLGv; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AEHiV5o028815;
	Thu, 14 Nov 2024 11:44:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731606271;
	bh=4PC0ElUC8LkJ1ahDBqmcn8ZSzWDTsMdFJphZeZuf5E8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Y0FRrLGvrlCdACTxe6k6wgplw8zrruA1/pQrLBourkkwkxuvTGh5VvQraIXyAaKDY
	 AAjf/NRLkiThYzo7tvU5mIp6YM39F9GJ+zBtSmAdj7mLLPspsC7Xm+ELC7qdTyUpYB
	 w7FYJvQQ+IM01FMe6b79KxYwW2PdCxh6PmqojOAU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AEHiVYI030179
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Nov 2024 11:44:31 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Nov 2024 11:44:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Nov 2024 11:44:31 -0600
Received: from [10.250.214.214] ([10.250.214.214])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AEHiRr7110038;
	Thu, 14 Nov 2024 11:44:28 -0600
Message-ID: <6bf6412d-8f9e-461d-913c-9718b5f0b8d3@ti.com>
Date: Thu, 14 Nov 2024 19:44:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/17] wifi: cc33xx: Add main.c
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
 <20241107125209.1736277-10-michael.nemanov@ti.com>
 <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/8/2024 1:42 PM, Johannes Berg wrote:

>> +	if (sta_rate_set) {
>> +		wlvif->rate_set = cc33xx_tx_enabled_rates_get(cc, sta_rate_set,
>> +							      wlvif->band);
>> +	}
> 
> you have a thing for extra braces ;-)
> (also in many other places)
> 

Yeah most of those head debug traces that were dropped as part of the 
feedback. Will fix the style too.

>> +static int cc33xx_init_ieee80211(struct cc33xx *cc)
>> +{
>> +	unsigned int i;
>> +
>> +	if (cc->conf.core.mixed_mode_support) {
>> +		static const u32 cipher_suites[] = {
>> +			WLAN_CIPHER_SUITE_CCMP,
>> +			WLAN_CIPHER_SUITE_AES_CMAC,
>> +			WLAN_CIPHER_SUITE_TKIP,
>> +			WLAN_CIPHER_SUITE_GCMP,
>> +			WLAN_CIPHER_SUITE_GCMP_256,
>> +			WLAN_CIPHER_SUITE_BIP_GMAC_128,
>> +			WLAN_CIPHER_SUITE_BIP_GMAC_256,
>> +		};
>> +		cc->hw->wiphy->cipher_suites = cipher_suites;
>> +		cc->hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
>> +
>> +	} else {
>> +		static const u32 cipher_suites[] = {
>> +			WLAN_CIPHER_SUITE_CCMP,
>> +			WLAN_CIPHER_SUITE_AES_CMAC,
>> +			WLAN_CIPHER_SUITE_GCMP,
>> +			WLAN_CIPHER_SUITE_GCMP_256,
>> +			WLAN_CIPHER_SUITE_BIP_GMAC_128,
>> +			WLAN_CIPHER_SUITE_BIP_GMAC_256,
>> +		};
> 
> I don't see you have GEM here, yet you handle it in other places above,
> that seems odd. Also I'm not sure it can work at all now that we removed
> the whole extended IV mess, unless you offloaded that?
> 

This cipher is unsupported. Will remove this and any related code.

>> +	/* clear channel flags from the previous usage
>> +	 * and restore max_power & max_antenna_gain values.
>> +	 */
>> +	for (i = 0; i < ARRAY_SIZE(cc33xx_channels); i++) {
>> +		cc33xx_band_2ghz.channels[i].flags = 0;
>> +		cc33xx_band_2ghz.channels[i].max_power = CC33XX_MAX_TXPWR;
>> +		cc33xx_band_2ghz.channels[i].max_antenna_gain = 0;
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cc33xx_channels_5ghz); i++) {
>> +		cc33xx_band_5ghz.channels[i].flags = 0;
>> +		cc33xx_band_5ghz.channels[i].max_power = CC33XX_MAX_TXPWR;
>> +		cc33xx_band_5ghz.channels[i].max_antenna_gain = 0;
>> +	}
>> +
>> +	/* Enable/Disable He based on conf file params */
>> +	if (!cc->conf.mac.he_enable) {
>> +		cc33xx_band_2ghz.iftype_data = NULL;
>> +		cc33xx_band_2ghz.n_iftype_data = 0;
>> +
>> +		cc33xx_band_5ghz.iftype_data = NULL;
>> +		cc33xx_band_5ghz.n_iftype_data = 0;
>> +	}
> 
> it seems wrong to modify the global data here
> 
>> +	/* We keep local copies of the band structs because we need to
>> +	 * modify them on a per-device basis.
>> +	 */
>> +	memcpy(&cc->bands[NL80211_BAND_2GHZ], &cc33xx_band_2ghz,
>> +	       sizeof(cc33xx_band_2ghz));
>> +	memcpy(&cc->bands[NL80211_BAND_2GHZ].ht_cap,
>> +	       &cc->ht_cap[NL80211_BAND_2GHZ],
>> +	       sizeof(*cc->ht_cap));
> 
> and in particular if you *then* do that??
> 

I see your point. I'll drop the init loops and use C initializers 
instead as this data does not change. Any dynamic modification will done 
to cc->bands.

Thanks and regards,
Michael.


