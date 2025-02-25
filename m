Return-Path: <linux-wireless+bounces-19436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBFA44DCC
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B210F7ADC9B
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD55C1A2C0E;
	Tue, 25 Feb 2025 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="OiY8pWUu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B04320F076
	for <linux-wireless@vger.kernel.org>; Tue, 25 Feb 2025 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515438; cv=none; b=MCTC90PaHCgPmK06ft1xx2O7wM8+XG9tiX9Mp0uXLz8yQ3nVUkZPWGZABedrVVWj1jy8FZCA51SUL8IwF/IxJ58TI7V07pHvJpDxLOhbpm5GlbW4CsQeO035DKjRgwMZbATuWrM8fFGAaqreSsHXjPOk88LWkhQdRnGkpYiWhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515438; c=relaxed/simple;
	bh=zpqxHNRaenkGuedEg4/NJehrctVDnKdUUWoxUDt3T84=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H24pVEXzavezInWWbYxKmW195JJCiFYdWpyeWFDi9KineZGBXXwZ5R1ogCpjprEkleD82nqPlIHVB91du+QFMWiV38hdCzRvvQVpkbdGTrNNcqokGFuhdKmsJ8pk9R671WkybzdT5CpaVinmukFxlqNDKLVlDxcVC4aAaa9wru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=OiY8pWUu; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ddEKFNBMWrwFPRZWSXDOK2tE9dDPr/CxnE1hX85HFRU=; b=OiY8pWUuNsdIqjOiiJhxJn63KM
	THH6dgsiO3camPoUPzjpJNpNqZxp0bS+DrDjPyACAN3whpgSJOujjOgjyiZEQL06067yXTzroDAZs
	bFCCaRnI1J9bjrxWUXFPTBHIgGrFSQ3vP8conrS9nEpCI5U7mbZQfv3/nC3VZWbtaEoI=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tn1ZT-00ASIZ-2N;
	Tue, 25 Feb 2025 21:30:27 +0100
Message-ID: <da6e61d7-0457-43d6-8ce9-a5a94ecf431a@nbd.name>
Date: Tue, 25 Feb 2025 21:30:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: mt76: mt7915: fix broken background radar implementation
To: lukasz.michalski@onet.pl, linux-wireless@vger.kernel.org,
 lorenzo@kernel.org
References: <003401db8476$348684c0$9d938e40$@onet.pl>
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
In-Reply-To: <003401db8476$348684c0$9d938e40$@onet.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lukasz,

On 21.02.25 16:35, lukasz.michalski@onet.pl wrote:
> Currently enabling background radar in hostapd results in unreachable AP.
> There is because of mistake in enabling background radar implementation for
> mt7915 mcu driver - 3rd and 4th parameters are swapped.
> mt76_connac_mcu_rdd_cmd requires rx_sel as a fourth parameter but this
> parameter is provided as third argument.
> Fix was tested on mt7981 and background radar works now correctly. Other
> mt76 drivers do not have similar issues.
> The issue was also described here:
> https://github.com/openwrt/mt76/issues/958
> 
> Signed-off-by: Lukasz Michalski <lukasz.michalski@onet.pl>

MediaTek informed me that MT7981 does not actually have background radar 
detection in hardware, so this patch can't be merged.
We should instead change the driver code to refuse attempts to enable 
background radar detection on this chip.

- Felix

