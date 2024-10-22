Return-Path: <linux-wireless+bounces-14331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9C9AB121
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60074B2327F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC11A2550;
	Tue, 22 Oct 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="M0q1PpH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84E1A0737;
	Tue, 22 Oct 2024 14:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608268; cv=none; b=Wq2IZmnCG+mjRfa3RhrUSUV24nNYZjHg1tB2hKeWDqeONl7NVZLNZIkLx+rt/1UQvpWYaKyJIp3+Z4SIUfwe3ZklqG//yYfgChY7xMaEJ2wf8w8J3fKmb/XT2A1AnXc1mtq5o+zNp2aPnHK/WA6zAXDbbkEdNuEkONtinnu9q0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608268; c=relaxed/simple;
	bh=2QKP5bShhJgstrGjEpmyAJHBDPoJQrvbizAvM/kvMQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbmnD0RfkqOpZying71SJR1+/PudL5ZD2hPyGSx3sv1guJ7yYN8jALFPrOf6N366yfIf/Q4xIvZXZpLUxviGT9JP754xDyGNqZElM3cpqsgpifTWk5sRXs77SSvFtq5NqaTJ9L4UgIpyauuwNViF1xRA7uafX/YG9G4DtXJnGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=M0q1PpH0; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B5B81883D4;
	Tue, 22 Oct 2024 16:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729608264;
	bh=XpHkPMU9+jmzDRCDk3QaPWlsUvggEKn5/K45SclQhvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M0q1PpH0oUl6Cus5XKlSbppFeAItUcnij+MxEsLIZpOzIcOPT1+4vTlqsQKxUfqKt
	 QcCkF10ZOKiqwDGrVuImGWf++kKhnMSqUJQ5oKDghKfInq9VJgcyIIIdDYB7SHO0s+
	 bfjfOqcPIpC6bahy0RYfclJza+zaegY0liKiR2zEKdO0vhhUWNDg4SxytsRPidgkxH
	 8yli49eSfSydAdu/vSwr0sBP0U2GaqwZNnrP42vbVjC3G7GTE7GnSxjCB/WBF8egqJ
	 2LrcmILnCd7DYVIiccdUK9iVoqevfLEfZiC9LLrrLHw7L32GNm2iyKwLClAtbO7rY+
	 T1VVFPALtV/3Q==
Message-ID: <f95fc508-fe6f-4501-9233-07bda0d28d98@denx.de>
Date: Tue, 22 Oct 2024 15:23:33 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: wilc1000: Add proper error handling for remaining
 CMD52
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241018194244.280322-1-marex@denx.de>
 <a6529da9-6333-4516-923d-01f12c439b33@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a6529da9-6333-4516-923d-01f12c439b33@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/22/24 11:11 AM, Alexis Lothoré wrote:

Hi,

>> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> index 5262c8846c13d..170470d1c2092 100644
>> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
>> @@ -769,8 +769,10 @@ static int wilc_sdio_init(struct wilc *wilc, bool resume)
>>   
>>   static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
>>   {
>> -	u32 tmp;
>> +	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
>>   	struct sdio_cmd52 cmd;
>> +	u32 tmp;
>> +	int ret;
>>   
>>   	/**
>>   	 *      Read DMA count in words
>> @@ -780,12 +782,20 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
>>   	cmd.raw = 0;
>>   	cmd.address = WILC_SDIO_INTERRUPT_DATA_SZ_REG;
>>   	cmd.data = 0;
>> -	wilc_sdio_cmd52(wilc, &cmd);
>> +	ret = wilc_sdio_cmd52(wilc, &cmd);
>> +	if (ret) {
>> +		dev_err(&func->dev, "Fail cmd 52, set DATA_SZ[0] register...\n");
> 
> I don't get the log message, why "set" DATA_SZ[0] ? This helper is rather trying
> to read it. Same for the other logs added below
Fixed in V2 , s@set@get@ , thanks !

