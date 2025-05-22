Return-Path: <linux-wireless+bounces-23302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A19AC0A1C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 12:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B191BA24C77
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894C2673BD;
	Thu, 22 May 2025 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ozXMHnmE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD133DB
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911010; cv=none; b=AVY2edko2FDJFD3ut0oU7KxVM9SnpzVmNUP4l1Ie4kXGQHG3PItiX9VCkptLq31gBBUt7COgnlJqNUNNAVwwEmqgbqX4wwotW2V+/oaS/548lw1or6PxSQtJIhH6MG6dM7y1VX1o0zMakBKWxiEaQI/cHDVUNIcknJKpkkzQHqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911010; c=relaxed/simple;
	bh=yzDyjKrYMc/grtsX6be49F8jpsbjU0zAz5u4QZABrO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMbVBDDNzEva0b73tiGoTYK/XK1lvNsopg3atBY1V2RcXsclMajEDT4mugsHFDtmEx4vvaLbmIe0BmL40v2tH0I06sSrvEHzVHDUEQiTDoMKpTIhoAoM0Wvgh4oTnPivfY3s7qO4K6KcAqay08DeEmg/+gdPVELI+9N9KMq/qrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ozXMHnmE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SzfHc04qb3ZiBK7rSUe8RZ+rtYxRyixjojLdqc8M/j4=; b=ozXMHnmEwFFf7jMMorWeqNjQg3
	hIyB41jW1XedXMOLIP42rFVfUoerYG/rK13OSoCVUrxKLuRM8eEO7hiwQHwnMu9thI96+M8rOX8mR
	RXqAR7Y789R7nIstbiGX+zm1NHbeYOyU7Qb2+Fx5/3hAIcJu1+o+0GAmRmcvzyKRU87I=;
Received: from p5b206e31.dip0.t-ipconnect.de ([91.32.110.49] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uI3Uq-0085SC-0o;
	Thu, 22 May 2025 12:49:56 +0200
Message-ID: <5a659f60-896e-4f2f-89c0-141e530c44d5@nbd.name>
Date: Thu, 22 May 2025 12:49:55 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: mt76: mt7925: add RNR scan support for 6GHz
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Leon.Yen@mediatek.com,
 Michael.Lo@mediatek.com, allan.wang@mediatek.com,
 Eric-SY.Chang@mediatek.com, km.lin@mediatek.com, Quan.Zhou@mediatek.com,
 Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20250321013829.3598-1-mingyen.hsieh@mediatek.com>
 <20250321013829.3598-2-mingyen.hsieh@mediatek.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <20250321013829.3598-2-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.03.25 02:38, Mingyen Hsieh wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> 
> Enhance the mt7925 to include RNR scan support. It adds
> the necessary RNR information to the scan command.
> 
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
> v2:
>    - use '= {}' to replace the '= {0}' for short_ssid array.
>    - align with the open paranthesis for crc32_le.
>    - use ether_addr_copy() to replace the memcpy of bssid.
> ---
>   .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 36 ++++++++++++++++---
>   .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 17 +++++----
>   2 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index 243adace8799..22686faca1af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -3078,7 +3079,11 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
>   	for (i = 0; i < sreq->n_ssids; i++) {
>   		if (!sreq->ssids[i].ssid_len)
>   			continue;
> +		if (i > MT7925_RNR_SCAN_MAX_BSSIDS)
> +			break;
>   
> +		short_ssid[i] = ~crc32_le(~0, sreq->ssids[i].ssid,
> +					  sreq->ssids[i].ssid_len);

I had to remove this variable due to a unused-but-set warning. I'm not 
sure if the contents of it should have been stored somewhere in the MCU 
message, or if this was something that ended up not being necessary.
Please review and send a follow-up fix if needed.

- Felix

