Return-Path: <linux-wireless+bounces-23078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 635F0AB9DFB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D7F173F63
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 13:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E672601;
	Fri, 16 May 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r41OFq5m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9347132111;
	Fri, 16 May 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403470; cv=none; b=JGjaivJMRyHe/h96wo41GwbjtVE4CCIzej4alhkgpOQ0ympww/JG6dAvN7hf2Q+rf4iWMKTG5XZ58r68EFWjUWGDQYshkBQykckotoywj8BKPXVGItV37W0ulxm3W3tz9JIfsdvV7/1d7ey7Hwz6OoaSm8mAtrPcOSzVQsBSBmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403470; c=relaxed/simple;
	bh=UO5COJwLunfQkJ0IseRANaLKRFoZaYHPD/nywAmitNA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=I07faU5vpjekLVJbYVISENHG0hBmywsWUu1HYGlJ0PhAJ++/HOPPdJE0r739ep9QU9zo0qF6C92vRl2kic0nHI0Eu7J2CpDF1Fj4NeDHLUbdry3TA8rzXxGky8zKMugZymiLTYB28/bqd04r3fP92mdc1BWGv1SIQnCWthRn36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=r41OFq5m; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1747403454; x=1748008254; i=markus.elfring@web.de;
	bh=UO5COJwLunfQkJ0IseRANaLKRFoZaYHPD/nywAmitNA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r41OFq5mcbBkCHEVjv85plhQWVc8A5GZmaFap3mV1M7S7G5XA5Z7RHjwdGCkyZ5+
	 eS/aFNXj9K4L3/lwQPjzMmylHRSfGr8PQM4BftYc5GDdVB4I1+P2HFHt//6sAEfZz
	 SoblIfq4wYMh76064w6ZUiaM8mKBrukCfajg0X7BKT3XvOUmWTO0x+DIUuMJnKMWN
	 x3SSdKtUWPugZzb5ax3T9tpsrjJvmAQqgXeMhV/wOYPqd5YH+17gjx0T80GIAzPwF
	 JF+4NQvdxd4H9vbDiAEFbFzUSOcBw4dge4CVvJl9mAiQMrWetppKl8RldjLmv3HJz
	 EPOZ/VPwTckRRByOGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.218]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHWj-1uRjpr05kz-00SyGn; Fri, 16
 May 2025 15:50:54 +0200
Message-ID: <22ba7622-a838-47a8-b0f8-29a90d6df34c@web.de>
Date: Fri, 16 May 2025 15:50:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-wireless@vger.kernel.org,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250516083842.903-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] wifi: wilc1000: Add error handling for wilc_sdio_cmd52()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250516083842.903-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wvPKIqwNlwdJ+3qyvQ13V1xe2fDlQc9TjkNtNq6k1vkiNlYHWqv
 r0FJSlZ9/snVxnSZN+A4NB50jvx7DweMqmZ2fNpRrR3UeQ+dZwrRt5egnNVNbl9/0gR42Bg
 cyxX0SMlrGfTqd2Y2DVc/Hsb0f01I/lWXqK9I+MOqo/+20MCSKDf5Dgcp+6bsOOWSmjK9xa
 IbAT+PzFahwPlVTNKtqyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A6cV/us5kUc=;yQpV0bwcnIbLYQEbDS6fAy3jHOz
 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

=E2=80=A6
> Add error handling for wilc_sdio_cmd52(). If wilc_sdio_cmd52() fails,
> log an error message via dev_err().

Please avoid duplicate exception handling code.
Can another jump target become nicer for this purpose?

Regards,
Markus

