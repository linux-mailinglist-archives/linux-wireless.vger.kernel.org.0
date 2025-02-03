Return-Path: <linux-wireless+bounces-18284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F82A2535B
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 08:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD79A162881
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 07:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542C1F5437;
	Mon,  3 Feb 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqial1KN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKTky4ow"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F71E7C34
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569357; cv=none; b=OXc3DGSCBCfjFb41G+gWtCRekqvha/ybVrY7aPW7Yom2K/YgZ/HU2iEdB0jFyXEtYw48RHDbWis3UOnE6ds73xPyNqaK+IBzbOAeF/339dQCTeqkzHdOJSWa2FJGPfI3G6KdOeYxCvK31KMehipaC/CNrG0Mulnm6xUCsCkQidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569357; c=relaxed/simple;
	bh=cB/6R/uPmo6nYAsKqz2dT25TCb3S/99YqDPNmbePsB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKNd56IJrQ3GvBzqniq5WekQizTvEtEkryjA4MIW8aWFGPOezVX+7RRzITvmupetY1rUSuMsUWLMZtUu/iwyd+4Yt1q5sHWd99iUejugW2fsxDz+xTLspyADBdj7+TEfkfhqBAKyeWtM2qFsygTc08lu/k8NxGGW4hiGmMMcdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iqial1KN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKTky4ow; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <19b8059a-c5f6-4467-8b42-31e70b9fe1f3@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738569354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqAdnxTeWR2og1f8+dCmfZgZ3A2auklMtjMbaPTk19M=;
	b=iqial1KNCVKsA46MkErqkJJZWxV3lnBLrREERCVkjGi8k0PtHSEg4JOlpQqLD7WFfYQRZJ
	0Abmqsxl1+OiTWTatrYSHINOKCJyOHmOM+ORYDK7io8LWk3iw4jpbUkO47n4YJkziztYuA
	mixD4xJxaHRGUIWAPWgAa0rEf2XRdCJVy+dHTSupejEvMnGbbXxp+OYD2jJUMES6Zw9LmA
	yiRnFM039WN6fFRxr8jzHfIxUkGLDbT0La57ZFcXDCQDCqgTzk55PoFvPsNtvqXXwYYbKU
	SKdd52zHtzN4Wdcb5Qpai1wstpPEKibAr8xL4kbGMMlV0IHX5hhIUeV9RWn2ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738569354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqAdnxTeWR2og1f8+dCmfZgZ3A2auklMtjMbaPTk19M=;
	b=xKTky4owNtQbGmvLt+ZFvdeM92vIS5RSvPi3wg4lRN1xLdxk6csw0CVOpQm0u/B/pmCfcP
	gcRK6Wro14bpYbCQ==
Date: Mon, 3 Feb 2025 08:55:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU
 (RTL8188CUS)
To: Ping-Ke Shih <pkshih@realtek.com>, Ezra Buehler <ezra@easyb.ch>,
 linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Reto Schneider <reto.schneider@husqvarnagroup.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>
References: <20250122071512.10165-1-ezra@easyb.ch>
 <393aa422-3ac8-40e7-aa2f-62956a844005@RTEXMBS04.realtek.com.tw>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <393aa422-3ac8-40e7-aa2f-62956a844005@RTEXMBS04.realtek.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 03.02.25 um 03:40 schrieb Ping-Ke Shih:
> Ezra Buehler <ezra@easyb.ch> wrote:
> 
>> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>>
>> This allows the driver to be used in wireless access point mode on the
>> AT91SAM9G25-based GARDENA smart Gateway.
>>
>> Unfortunately, the data throughput in AP mode appears to be lower than
>> with the vendor driver (or in STA mode). Especially when sending, the
>> data rate is significantly lower. My measurements performed with iperf3
>> and an Edimax EW-7811Un (VID: 7392, PID: 7811) showed a maximum TX rate
>> of about 4 Mbits/sec compared to the ~24 Mbits/sec measured with the
>> rtl8192cu driver.
>>
>> Although the performance might be good enough for our use case, this is
>> something that should be further looked into.
>>
>> Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> 
> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.

Is there a reason for not setting macid in rtl8xxxu_fill_txdesc_v1() and 
rtl8xxxu_update_rate_mask() like it was done for the gen2 case?

> 
> 4828f572b20b wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)
> 
> ---
> https://github.com/pkshih/rtw.git
> 



