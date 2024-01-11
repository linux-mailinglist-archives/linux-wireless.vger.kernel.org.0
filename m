Return-Path: <linux-wireless+bounces-1754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8FB82B61F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 21:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3673C1F21413
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3251007;
	Thu, 11 Jan 2024 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPI2aLUv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F899482D8
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 20:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68141aa810eso671636d6.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705005575; x=1705610375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfdNmiHl60ZX+THZQpr67MtsGa+3pdDU4ikj94smlTU=;
        b=DPI2aLUvCZsmm2SU6USdxokzhla8HNyJbSMDZAJPOeX3Y2V99DjXTEV//4QJQLme5C
         0HOEzgdvXUYBwcEPptiV3r0XOkJa0R7Mkthc4zDupqOp9XAmFVj/xMczQwGpUmQ3JZAN
         VgHh70LP40eunFONH7aptHg+A8X9pJsqLKdS2aEWn4IltP93aOjZQExmIX/CdjO1W2J3
         XLCM6gDgF5WdQ8RsM1sffbyAx4QuJFJx/i9E4X+BdCBQ6JK/00Guzxp7ZjOvqsl/19el
         gD83hLg8MQwBLQOCndTqMF8n9LbjL5xGcRj3V1oJ7LK1KS/e7CirYXf02rtlYAqVCmxT
         m2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705005575; x=1705610375;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfdNmiHl60ZX+THZQpr67MtsGa+3pdDU4ikj94smlTU=;
        b=njtAUfRAZtxIfWrmqt0Y/ozAG2aS6I1lFl5s5TV+RnR5CBCUuCdQtp81SFSTx+3em7
         Ifc++i5WD32+0Z5NP7BOa7DyYQ6OrYbbS/TMaRTwD8Dv0SVhzzBS0/fd+NZn3QazW/Ie
         gRxVD2jzzRP/YStrZZSpJqk+W+a4fO4CS/6jFZV0BV1gJp2kl9Uutpgz6J2lqlb3G/DW
         B6ubdTC7BOhF9/uEXfzFM81HprW8VY01LEEuwuuFLYIsXDYwW9foF2g24aCH0dpPbA+x
         TkNSZEr5l5zkabsf8jCTXKRQ/8A+1GNyzaklRGpSGIxgE9tsGtWcurXmHgLO4sF1zhUH
         M0Aw==
X-Gm-Message-State: AOJu0YzIdbfMg9RaA4twcTx96h93z8GRRYWLWg20Os/TmKl/YcWMokXr
	xiQoaNa3NL3vSLGQpCwpxaiAGhytoqbylA==
X-Google-Smtp-Source: AGHT+IHhusaJ81nsRruaoSAiO6FUo2GgZZp/KJxYubGglvZcfs+nsymZO4U96yaMo7VQJU12jhQ4pw==
X-Received: by 2002:ad4:5744:0:b0:681:3b95:cedd with SMTP id q4-20020ad45744000000b006813b95ceddmr279995qvx.59.1705005575147;
        Thu, 11 Jan 2024 12:39:35 -0800 (PST)
Received: from ?IPV6:2001:470:8:94a::251? ([2001:470:8:94a::251])
        by smtp.googlemail.com with ESMTPSA id t12-20020a05620a034c00b0078329aeba24sm568522qkm.131.2024.01.11.12.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 12:39:34 -0800 (PST)
Message-ID: <037b6a4e-e143-3b69-2ab2-00c4dee75bda@gmail.com>
Date: Thu, 11 Jan 2024 15:39:33 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than
 HE
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
 Gregory Greenman <gregory.greenman@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
 <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
From: Jonathan Bither <jonbither@gmail.com>
In-Reply-To: <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/11/24 11:17, Miri Korenblit wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> To simplify the code in the next patch, disallow drivers
> supporting 40 MHz in HT but not HE, since we'd otherwise
> have to track local maximum bandwidth per mode there.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> ---
>   net/mac80211/main.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index d48fa1147c14..e05bcc35bc1e 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1119,8 +1119,26 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   		supp_vht = supp_vht || sband->vht_cap.vht_supported;
>   
>   		for_each_sband_iftype_data(sband, i, iftd) {
> +			u8 he_40_mhz_cap;
> +
>   			supp_he = supp_he || iftd->he_cap.has_he;
>   			supp_eht = supp_eht || iftd->eht_cap.has_eht;
> +
> +			if (sband->band == NL80211_BAND_2GHZ)
> +				he_40_mhz_cap =
> +					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
> +			else
> +				he_40_mhz_cap =
> +					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
> +
> +			/* currently no support for HE client where HT has 40 MHz but not HT */
where HT has 40 MHz but not HE?
> +			if (iftd->he_cap.has_he &&
> +			    iftd->types_mask & (BIT(NL80211_IFTYPE_STATION) |
> +						BIT(NL80211_IFTYPE_P2P_CLIENT)) &&
> +			    sband->ht_cap.ht_supported &&
> +			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
> +			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
> +				return -EINVAL;
>   		}
>   
>   		/* HT, VHT, HE require QoS, thus >= 4 queues */

