Return-Path: <linux-wireless+bounces-16907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE3A9FEA54
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B9818835C1
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93CC191F88;
	Mon, 30 Dec 2024 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bgUDk4ok"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD85EAD0
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735586784; cv=none; b=EGTxa3ahZ2M4RgHZnPOUN91L/uTAokI8/IbjeebRQnH3E+7WhbyJ7q5rcxg9Z3FQMPp19pEGnQx+8EsdHP1tnND4no7UPyEqhnttQdusLQlfRyymzvrhsIkCr47PN8qwKBeElo7wd7niGaAaUzneJmWAwKmNftR2hc0L9Vv3j2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735586784; c=relaxed/simple;
	bh=3E2YWKkd9uaBCMhIzlgDN21dOXXKTEJWo7ufyWWd9v8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDfxvCSc5cUcttUPwWJLppyQ+JLVyvrQelW6Hxi6N9xlJTsvIYA0yWsD5+44WoGU+/9W3qPNFhy+jdgMaiuEevto7roClxBjtKg5r0PwGhkeiFRAsBXO63AicoBzGPWAHea4En4ZMmaaJxOu2nmcr+kqh59ad0KrBmUKsqM4Hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bgUDk4ok; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uvDeDR9Oa70KelI0kN2Nd7YiH226dpawgt4F8xNVEXc=; b=bgUDk4okfWHD2WCrHdBvM6GV0b
	WbuZ7TyM6QWA8yPr7UO8sUOBOdogfTF2mA/G3A6+byxX8W1KN+jHsi3N6EVoFrlR0JNFt/b9E9+w7
	KgIC7R6Qim+i4zkXzSykmkB0rf0IyrTtr17ZGb3cBhhn32UB19EGPUvZhCLn1pq5WSRk=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSL4s-00GKGy-24;
	Mon, 30 Dec 2024 20:05:22 +0100
Message-ID: <0ec8b1bd-6bd8-49e9-86c1-33ba36709331@nbd.name>
Date: Mon, 30 Dec 2024 20:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7921: avoid undesired changes of the preset
 regulatory domain
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, lorenzo@kernel.org
Cc: deren.wu@mediatek.com, Sean.Wang@mediatek.com, Soul.Huang@mediatek.com,
 Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
 robin.chiu@mediatek.com, ch.yeh@mediatek.com, posh.sun@mediatek.com,
 Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
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
In-Reply-To: <20240412085357.13756-1-mingyen.hsieh@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 10:53, Mingyen Hsieh wrote:
> From: Leon Yen <leon.yen@mediatek.com>
> 
> Some countries have strict RF restrictions where changing the regulatory
> domain dynamically based on the connected AP is not acceptable.
> This patch disables Beacon country IE hinting when a valid country code
> is set from usersland (e.g., by system using iw or CRDA).
> 
> Signed-off-by: Leon Yen <leon.yen@mediatek.com>
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> index ef0c721d26e3..3c9a5fcd6924 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -135,6 +135,13 @@ mt7921_regd_notifier(struct wiphy *wiphy,
>   	dev->mt76.region = request->dfs_region;
>   	dev->country_ie_env = request->country_ie_env;
>   
> +	if (request->initiator == NL80211_REGDOM_SET_BY_USER) {
> +		if (dev->mt76.alpha2[0] == '0' && dev->mt76.alpha2[1] == '0')
> +			wiphy->regulatory_flags &= ~REGULATORY_COUNTRY_IE_IGNORE;
> +		else
> +			wiphy->regulatory_flags |= REGULATORY_COUNTRY_IE_IGNORE;
> +	}
> +

Sorry for the late response, I just noticed that I completely forgot to 
review this one.

In principle, it makes sense to me to ignore the country IE in this 
case, however I don't understand why the change is done in the mt7921 
driver. Isn't this a generic issue that should be consistent across 
drivers and thus better handled in mac80211?

Thanks,

- Felix

