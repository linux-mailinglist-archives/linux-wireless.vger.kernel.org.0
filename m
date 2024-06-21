Return-Path: <linux-wireless+bounces-9441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52779912C85
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 19:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25ED1F25780
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112C84DFE;
	Fri, 21 Jun 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ZjmUjBhW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D31C14
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991687; cv=none; b=hTbYhbTsHClnE4Yayt0kHtM0H/X/6Iaz0V0XFPnuG/AXA4dy0MrFQykIClNvUs7+i/zDR+G2kJoOccLwti7Rgdb7p26GJiJoh9sIS3XLNsS3LZ72IEwYpnr8oKP22sOqD/8kmWlX3kHJWAbkXRLRhWpFCL31y6IAzH2STkHREpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991687; c=relaxed/simple;
	bh=DmTg0qbGGUNP9FmxxHT8chJ2uxIWcqtVoG65MSA/ByA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+n9cwcCOysej4ZW+3AOng2LKIwrrMHOsflbt3INVPh/gRyGDzBkWpTaVMgzMjlHOvA8kutIrQ0HeT3LedIgfrmCIcU2sZXK0ZLVHimChzhvhqQ405nsbVaVeO1NHKBvuiSC+ODD2KR0XWEZJYMGj9iYat/s+mWXCgqMAnwqbiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ZjmUjBhW; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t/Ezj8LgwUxdQDYEAFhhTzUXwo0bZEsDEiBWEvtj+gU=; b=ZjmUjBhWDI2eW37Cij417lguFS
	WZKaslecGuefzz/G2liiJPvN+ktBIeeuPcKojq4HUWXSB/9GiIIAsd02PVQq9tnQwAsylcWl8083w
	hccOBWCVe+vRMC00OlTwq7qrCOItd9Pdcb8o/um2u0YDzaY41txRAeXKR3Dx/e7NxgDM=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sKiG5-00FFnk-33;
	Fri, 21 Jun 2024 19:41:10 +0200
Message-ID: <d448ca6a-106a-478f-ad80-5c8730765ca0@nbd.name>
Date: Fri, 21 Jun 2024 19:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wireless-regdb: update regulatory rules for India (IN)
To: Seth Forshee <sforshee@kernel.org>, wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Keshav <the.ridikulus.rat@gmail.com>
References: <20230416013031.158433-1-sforshee@kernel.org>
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
In-Reply-To: <20230416013031.158433-1-sforshee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.04.23 03:30, Seth Forshee wrote:
> Increase the max EIRP for 2.4 GHz to 30 dBm, and add DFS for 5250-5350
> MHz and 5470-5725 MHz.
> 
> Source:
> https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
> 
> Signed-off-by: Seth Forshee <sforshee@kernel.org>
> ---
>   db.txt | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 915a3b94d418..2a7779510cc5 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -850,11 +850,14 @@ country IL: DFS-ETSI
>   	# Table B List of conditions, row 68, wireless device using 802.11a/n/ac protocol
>   	(5725 - 5875 @ 80), (200 mW), AUTO-BW
>   
> +# Source:
> +# https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> +# https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
>   country IN:
> -	(2402 - 2482 @ 40), (20)
> +	(2402 - 2482 @ 40), (30)
>   	(5150 - 5250 @ 80), (30)
> -	(5250 - 5350 @ 80), (24)
> -	(5470 - 5725 @ 160), (24)
> +	(5250 - 5350 @ 80), (24), DFS
> +	(5470 - 5725 @ 160), (24), DFS

What about the DFS region? The DFS channels won't work without it.

- Felix


