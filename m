Return-Path: <linux-wireless+bounces-17783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1407CA17A65
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 181933A3E1A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE81C07D9;
	Tue, 21 Jan 2025 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCEsuQp+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7971BB6BC
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452554; cv=none; b=FZG20uZJVWHzfcWgYc9bRcIPb/2uacFp9g24RF35pKwcMZ8U+xMETwXqMTpWKNNCm9Uen56sTnenIBfJ3Iq26scnqoEN14OlOCLTJnBZ76aq6tX7ZrKnyIi+h+SjTgpiDhnEECAqSmQwfFvyq03HhNpunirjsS4mI/uq+wVRoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452554; c=relaxed/simple;
	bh=cAfX7fcHFWdj5Pvm5xn94yz/8OXZ6znIyUFzEZge/c8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kLucOC2iVaeWmq0BeB6mzoUMf0c1aSXlq7BmMW/DF1IWhbsobEh3f/l+ssy3z5EbIQz3I2bjoFHR5d5mHNg9r2EqqBQ4d0gmtrGgoUwVzltsJNr0+ucI7Ow9eA1eDRLgyVMAjKGbiyuu5ECSbfrJIpFKgZ7EWuNI+ZmXOkaUAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCEsuQp+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862f32a33eso2423449f8f.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 01:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737452551; x=1738057351; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZAjJjL9qQDRRPSaaVZccUdHxjtJV8yhZw2hQGDUwyI=;
        b=MCEsuQp+p876YoOPfU4q+c8OePCdyKpC4uqipHct/pR2MERH3zZYmKkpkB5pWDmKD2
         HmgCLwPY4JemtH6L32hHfOjvhn//qyvX0SHUftZIC0nwzxHHQdAKuunAPEQ09iQbPgkE
         hhEc+Kev1jebaHu5AY+7NIn5a6Wb/6KUGfMr8BwyIq2Z9oDYelo7pTGyQjJKRo1XwVVi
         hBotsedZwpzyhCQypyvxd1BpOQm9eJFUeSr4lEPowLkdtIMeaJoTEX8zguNbELafdE+1
         VB/RJHFIQ62asQs//cd6ZR1kcUsL56ToGG7T/iXCcGJIDWrHY+4DS1tzddZD9yquK4Bw
         FD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452551; x=1738057351;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZAjJjL9qQDRRPSaaVZccUdHxjtJV8yhZw2hQGDUwyI=;
        b=TozPaHtADkB4GRiKhtGkYv8Lb+0gEcoGNDVEmJ2yp6aB4TvJeRHJmw908+zV9bOfA0
         3avXF86QLFXG8tHFz3Lta2xSKdCfcSoaKGvm2i0I7uc1Uy9OHnuMVj2iiItDH+5l3whS
         S/6ToHrn0UQb3JBrnmbuxD1FWQwz/UQUTDydJRQwJLiFB87TCy5YyoqQfDsxhCLGtV1/
         5WdDlX52whahD11Fmyu5TsYOHL8C4GChQvj3jW9924Ow5HGRc1kOb0mxrH6tA1x9r06d
         /FKpw+YyHwMBPbdLrYyel7XrHMBrp8DbzZF+oZOj/wXrevhlPm4NJG1yaD/8JZyP1jnw
         G9Dg==
X-Gm-Message-State: AOJu0Yw7ix+C9CHKqL35h8XoLq9aGZ+ripPqR5Co9gInsDbPUofAzsN+
	YJCm7M2i9U0+UlcHygMgoK98Hm2kDq6q17xN+ZUOBaJRCoU4oOWl
X-Gm-Gg: ASbGncuqKsNhFPsZqeKcMYHmT7M9vaoIcLWitxjEQk+aLA97jJoK96xUzqHezKTHCdA
	/IedeYAr03DGI88dcuOkkPwf1Om1q1UcTfAwgIDF+81WMXhwEokCFQRHpUm9OuWSJpL3bKiyZMV
	eafvZNJw+5Vj60sfduIj1LqKj8txjXC4mz/ixAT0wHlaTyI7qjc6WEHsR07feWCbdsp2MiUkjNt
	bvAJRjg6gzyNFxqM7ahiGxlE68o8+/UyYVry1y1PBvZT4HIs/L5qtbzWJlRxmgZEvryRFA6ltRO
	K394g5o+n09n
X-Google-Smtp-Source: AGHT+IFzkNnW6b0iMTCoqCvVh44YaE0Zb4MJBHDXLxLoDLkLH7ZlaEsA/M6oKR4+cnPj+4z3meDpeg==
X-Received: by 2002:a5d:6d88:0:b0:38a:41b6:d685 with SMTP id ffacd0b85a97d-38bf564d621mr15132107f8f.3.1737452550699;
        Tue, 21 Jan 2025 01:42:30 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3215023sm12702939f8f.9.2025.01.21.01.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 01:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 10:42:29 +0100
Message-Id: <D77NIYIWDCDL.ZSULBU6766SX@gmail.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: add support of station average signal
 strength
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Vasanthakumar Thiagarajan" <quic_vthiagar@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250117172819.3357534-1-nico.escande@gmail.com>
 <7bf33a7e-c77c-a99f-bffe-2501f0971b2e@quicinc.com>
In-Reply-To: <7bf33a7e-c77c-a99f-bffe-2501f0971b2e@quicinc.com>

On Tue Jan 21, 2025 at 9:53 AM CET, Vasanthakumar Thiagarajan wrote:
>
>
> On 1/17/2025 10:58 PM, Nicolas Escande wrote:
>> This adds support for reporting to the kernel the average rssi. This is
>> done the same way as it was done in ath11k. A simple ewma (with the same
>> parameters) is updated with each rssi update.
>>=20
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>=20
>> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.h   | 5 +++++
>>   drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
>>   drivers/net/wireless/ath/ath12k/mac.c    | 5 +++++
>>   3 files changed, 12 insertions(+)
>>=20
>> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wirele=
ss/ath/ath12k/core.h
>> index ee595794a7aee..9408d8a528580 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.h
>> +++ b/drivers/net/wireless/ath/ath12k/core.h
>> @@ -1,3 +1,4 @@
>> +
>
> ???
>
> Always ensure a clean checkpatch run.
The worst part is I ran it but failed to understand why it was warning me. =
I
thought this was due to some existing problem before my changes.

Anyway I was stupid, I reposted v2 to fix this.

>
> Vasanth


