Return-Path: <linux-wireless+bounces-26154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14EB1A93D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 20:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACD93BFFA0
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 18:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2161BCA07;
	Mon,  4 Aug 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="acFD5vcu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E41EEAB
	for <linux-wireless@vger.kernel.org>; Mon,  4 Aug 2025 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332835; cv=none; b=gp4H0EYAYcVlkJltjx7OQjwgsuDQ31fhYNsjwC336QXp/qiQiMGhSSoOU/Q88UPSppTFKrsLSjmA5r5npMK8oCq6GHsj+an84h1G2govuB1Y5cJPSzIOKaDBrKURm8IKz3fLHtIOY2R+Gp+K4L9TNBuUlHm6IhURc/oFb69+dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332835; c=relaxed/simple;
	bh=vNeTzZJbyCnWdAq40kS/5w4h+QphW1MREuURuxa4I8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ts2BG3LSPuBCUj6z2gAQcX4twNYh3kYr6HnzlOCEUHQqvrLSZK8lrnHHr0btxZpn/7TK+0WXJciIPw1b5k7IJMicfq1wM5r3XUihVbyAlk9hzEjKycsQ3kBLrNEmWFlGoj3b7Un2NpoLEBO7mSB5RhWyuiDPdrHI7MBzopc/G+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=acFD5vcu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0635b326-cb5a-4c6e-a4d6-1926ce737a32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754332827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKDuj+/C6OizSWXnebd3g8mZ40fHWWdL1maxJJb+nCg=;
	b=acFD5vcuAm8BBJeZWJ1P1d2pKzItHR2s1jlhO0XoJeamvtwca24dM+9XzQWqgUNPDuEcSc
	VEBGqIhalp2A1ETkYjRwLOlVbxk2n9R5hNpvNl+5b5ScDAaP02of9wnFh3jcxaDZC6UcUN
	wvfNFa/OYhrluFcR/QNdw7yKDBkpCwY=
Date: Mon, 4 Aug 2025 14:40:24 -0400
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: print just once for unknown C2H
 events
To: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Cc: rtl8821cerfe2@gmail.com
References: <20250804012234.8913-1-pkshih@realtek.com>
 <20250804012234.8913-2-pkshih@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250804012234.8913-2-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/25 21:22, Ping-Ke Shih wrote:
> When driver receives new or unknown C2H events, it print out messages
> repeatedly once events are received, like
> 
>   rtw89_8922ae 0000:81:00.0: PHY c2h class 2 not support
> 
> To avoid the thousands of messages, use rtw89_info_once() instead. Also,
> print out class/func for unknown (undefined) class.
> 
> Reported-by: Sean Anderson <sean.anderson@linux.dev>
> Closes: https://lore.kernel.org/linux-wireless/20250729204437.164320-1-sean.anderson@linux.dev/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  drivers/net/wireless/realtek/rtw89/debug.h | 1 +
>  drivers/net/wireless/realtek/rtw89/mac.c   | 7 +++----
>  drivers/net/wireless/realtek/rtw89/phy.c   | 7 +++----
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
> index fc690f7c55dc..a364e7adb079 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.h
> +++ b/drivers/net/wireless/realtek/rtw89/debug.h
> @@ -56,6 +56,7 @@ static inline void rtw89_debugfs_deinit(struct rtw89_dev *rtwdev) {}
>  #endif
>  
>  #define rtw89_info(rtwdev, a...) dev_info((rtwdev)->dev, ##a)
> +#define rtw89_info_once(rtwdev, a...) dev_info_once((rtwdev)->dev, ##a)
>  #define rtw89_warn(rtwdev, a...) dev_warn((rtwdev)->dev, ##a)
>  #define rtw89_err(rtwdev, a...) dev_err((rtwdev)->dev, ##a)
>  
> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
> index 5a5da9d9c0c5..ef17a307b770 100644
> --- a/drivers/net/wireless/realtek/rtw89/mac.c
> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
> @@ -5813,12 +5813,11 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>  	case RTW89_MAC_C2H_CLASS_ROLE:
>  		return;
>  	default:
> -		rtw89_info(rtwdev, "MAC c2h class %d not support\n", class);
> -		return;
> +		break;
>  	}
>  	if (!handler) {
> -		rtw89_info(rtwdev, "MAC c2h class %d func %d not support\n", class,
> -			   func);
> +		rtw89_info_once(rtwdev, "MAC c2h class %d func %d not support\n",
> +				class, func);
>  		return;
>  	}
>  	handler(rtwdev, skb, len);
> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
> index d607577b353c..01a03d2de3ff 100644
> --- a/drivers/net/wireless/realtek/rtw89/phy.c
> +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> @@ -3626,12 +3626,11 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
>  			handler = rtw89_phy_c2h_dm_handler[func];
>  		break;
>  	default:
> -		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
> -		return;
> +		break;
>  	}
>  	if (!handler) {
> -		rtw89_info(rtwdev, "PHY c2h class %d func %d not support\n", class,
> -			   func);
> +		rtw89_info_once(rtwdev, "PHY c2h class %d func %d not support\n",
> +				class, func);
>  		return;
>  	}
>  	handler(rtwdev, skb, len);

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>

