Return-Path: <linux-wireless+bounces-14230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D9D9A49B8
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2024 00:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CD11F246A6
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FF11898FB;
	Fri, 18 Oct 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEfuZZiY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3A188A18;
	Fri, 18 Oct 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729291261; cv=none; b=a9Z1+oaAczWOj3p3P6nVoWRgKeo5GOBwL0sfsIehCirvKTf8BQVG7+1O7Go9cmw4w9V8u9+L9w2clZUfhAkFi2KG4PuotiUsoh+LInj8XZYeGk8uR7x5szgp0ZdE5YZMYXoHUXhGUWIaDYga/ntF9esSHvfARsU0BRNAOCur7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729291261; c=relaxed/simple;
	bh=AkeNo/tk92UbTjmdHz4UbsBIgtAYxTSYnCUb4J5AiLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aibnaq+lxQmAfPMzHABl42O8KU9C6AVmh45mgq5cuxRkeA108cA5jzv5wydakP6egINFP0S1ztATx8NrabVv7wjdbG1dK8I5BUAi/eQHcOFxZM9gjDcoYtCokFb/98g9xiiEccyymvYlKbsHgwVDxSiT9KsrkYDHuUgLwDnRW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEfuZZiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1664C4CEC3;
	Fri, 18 Oct 2024 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729291260;
	bh=AkeNo/tk92UbTjmdHz4UbsBIgtAYxTSYnCUb4J5AiLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEfuZZiY9ByqoBy8I9AFOCFq56jmWhFmK3zzcnvop+h9aWq7A+ljGSoa9190KOHR/
	 0fEUhaMJN/fJ5fOnfuVkRFYyupkZJiQXG5SL3Ey+TFv5t9IKI3o3Nvh3KW/0oASXo+
	 s+Im/aKJLt99jnQ47Bv8Ir0EHb4AFlT9S19UcRSVMZhTqV0HMIhqRh/jwNof13Kud0
	 kTTuFHD4AsPqXtGSrJoQlbh222xkJaBv9sEdIquJrAH4wTsrsb8GHvOvUvcJfwJLbg
	 8k7HV+wnkclc+mvhu96OHF6/qkIy5hxjpj0jaAnYWztQ/ssbeiDEi/f6TjL/uPRy05
	 DMbLkZgVUnYlA==
Date: Fri, 18 Oct 2024 15:40:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Kuan-Chung Chen <damon.chen@realtek.com>,
	Chih-Kang Chang <gary.chang@realtek.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] rtw89: -Wenum-compare-conditional warnings
Message-ID: <20241018224058.GA2635543@thelio-3990X>
References: <20241018152311.4023979-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018152311.4023979-1-arnd@kernel.org>

On Fri, Oct 18, 2024 at 03:23:07PM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is one of three drivers that trigger -Wenum-compare-conditional warnings
> with clang:
> 
> drivers/net/wireless/realtek/rtw89/core.c:1806:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1806 |                 return eht ? NL80211_RATE_INFO_EHT_GI_0_8 :
>       |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1807 |                              NL80211_RATE_INFO_HE_GI_0_8;
>       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/core.c:1810:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1810 |                 return eht ? NL80211_RATE_INFO_EHT_GI_1_6 :
>       |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1811 |                              NL80211_RATE_INFO_HE_GI_1_6;
>       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/core.c:1813:14: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1813 |                 return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
>       |                            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1814 |                              NL80211_RATE_INFO_HE_GI_3_2;
>       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/realtek/rtw89/core.c:1818:15: error: conditional expression between different enumeration types ('enum nl80211_eht_gi' and 'enum nl80211_he_gi') [-Werror,-Wenum-compare-conditional]
>  1818 |                         return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
>       |                                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1819 |                                      NL80211_RATE_INFO_HE_GI_3_2;
>       |                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In this case, all four warnings can be easily avoided by splitting the
> function into two separate ones, in a way that helps readability as well,
> at the expense of a few extra source lines.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I agree this is slightly less compact but I think it is more obvious,
especially in the face of the warning.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 48 +++++++++++++++++------
>  1 file changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
> index bba5bde95bb4..62e873fa1659 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -1858,32 +1858,58 @@ static void rtw89_core_rx_process_phy_sts(struct rtw89_dev *rtwdev,
>  					  phy_ppdu);
>  }
>  
> -static u8 rtw89_rxdesc_to_nl_he_eht_gi(struct rtw89_dev *rtwdev,
> -				       u8 desc_info_gi,
> -				       bool rx_status, bool eht)
> +static u8 rtw89_rxdesc_to_nl_he_gi(struct rtw89_dev *rtwdev,
> +				   u8 desc_info_gi,
> +				   bool rx_status)
> +{
> +	switch (desc_info_gi) {
> +	case RTW89_GILTF_SGI_4XHE08:
> +	case RTW89_GILTF_2XHE08:
> +	case RTW89_GILTF_1XHE08:
> +		return NL80211_RATE_INFO_HE_GI_0_8;
> +	case RTW89_GILTF_2XHE16:
> +	case RTW89_GILTF_1XHE16:
> +		return NL80211_RATE_INFO_HE_GI_1_6;
> +	case RTW89_GILTF_LGI_4XHE32:
> +		return NL80211_RATE_INFO_HE_GI_3_2;
> +	default:
> +		rtw89_warn(rtwdev, "invalid gi_ltf=%d", desc_info_gi);
> +		if (rx_status)
> +			return NL80211_RATE_INFO_HE_GI_3_2;
> +		return U8_MAX;
> +	}
> +}
> +
> +static u8 rtw89_rxdesc_to_nl_eht_gi(struct rtw89_dev *rtwdev,
> +				    u8 desc_info_gi,
> +				    bool rx_status)
>  {
>  	switch (desc_info_gi) {
>  	case RTW89_GILTF_SGI_4XHE08:
>  	case RTW89_GILTF_2XHE08:
>  	case RTW89_GILTF_1XHE08:
> -		return eht ? NL80211_RATE_INFO_EHT_GI_0_8 :
> -			     NL80211_RATE_INFO_HE_GI_0_8;
> +		return NL80211_RATE_INFO_EHT_GI_0_8;
>  	case RTW89_GILTF_2XHE16:
>  	case RTW89_GILTF_1XHE16:
> -		return eht ? NL80211_RATE_INFO_EHT_GI_1_6 :
> -			     NL80211_RATE_INFO_HE_GI_1_6;
> +		return NL80211_RATE_INFO_EHT_GI_1_6;
>  	case RTW89_GILTF_LGI_4XHE32:
> -		return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
> -			     NL80211_RATE_INFO_HE_GI_3_2;
> +		return NL80211_RATE_INFO_EHT_GI_3_2;
>  	default:
>  		rtw89_warn(rtwdev, "invalid gi_ltf=%d", desc_info_gi);
>  		if (rx_status)
> -			return eht ? NL80211_RATE_INFO_EHT_GI_3_2 :
> -				     NL80211_RATE_INFO_HE_GI_3_2;
> +			return NL80211_RATE_INFO_EHT_GI_3_2;
>  		return U8_MAX;
>  	}
>  }
>  
> +static u8 rtw89_rxdesc_to_nl_he_eht_gi(struct rtw89_dev *rtwdev,
> +				       u8 desc_info_gi,
> +				       bool rx_status, bool eht)
> +{
> +	return eht ? rtw89_rxdesc_to_nl_eht_gi(rtwdev, desc_info_gi, rx_status) :
> +		     rtw89_rxdesc_to_nl_he_gi(rtwdev, desc_info_gi, rx_status);
> +}
> +
>  static
>  bool rtw89_check_rx_statu_gi_match(struct ieee80211_rx_status *status, u8 gi_ltf,
>  				   bool eht)
> -- 
> 2.39.5
> 

