Return-Path: <linux-wireless+bounces-1585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB95826AF5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EF6281296
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121212B6B;
	Mon,  8 Jan 2024 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cvW3LHww";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nq7yZq1j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00081125A5
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <7b9bab65-c588-469e-a17e-cae6426694be@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704706953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJax41yavA+S3Jwcz/pXwyBa81HNwofMqjydAjpZZYw=;
	b=cvW3LHwwzIvsMufxLViCYycdWk8+osHvags05/Iqh6i50ElObLanFr8000WsW9lCHmUdL6
	LiJXG6LeqFn+6kO8JQnusaOSmtT5c25zoZHa3QWBRyM3/0G9pxNavVZkpMU6bORCV0NPRK
	KSuXT3OBpJVfptpCBNfrokbADcbcWTEOvs5Uh0sDKSPoN8pBxIagSs7Yhneha4SR6zKVH0
	ZJIty4bDffwrcbD8Xx6iehyHNYdTECSi20BOBpc86elqe7JWSbjhAVp6sgDeocsuUcT3dE
	YYAc63jHF6WZJbX/MApuVAeduAHcf0xGhavozuPYEo5t9rpRLzwieRuXrqu/vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704706953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJax41yavA+S3Jwcz/pXwyBa81HNwofMqjydAjpZZYw=;
	b=Nq7yZq1jlAlUlbuwTeEDenWKgHBM3dN4s49Cxxt//1U0MZDUqaS8X7ZBoDT+A/sR07CH/2
	uQRK7mPjeWeNeNCg==
Date: Mon, 8 Jan 2024 10:42:32 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 13/21] wifi: rtl8xxxu: support multiple interfaces in
 watchdog_callback()
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231222101442.626837-1-martin.kaistra@linutronix.de>
 <20231222101442.626837-14-martin.kaistra@linutronix.de>
 <CAKFoaw3gz+kQMJJUEdDFvOCxQwqYZ0ijTNT2Z-YHiwC_Rv6puw@mail.gmail.com>
 <9b9f18d7528b46eaa3dc459cca745de9@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <9b9f18d7528b46eaa3dc459cca745de9@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.12.23 um 06:22 schrieb Ping-Ke Shih:
> 
> On Fri, Dec 22, 2023 at 6:16 PM Martin Kaistra
> <martin.kaistra@linutronix.de> wrote:
>>
>> Check first whether priv->vifs[0] exists and is of type STATION, then go
>> to priv->vifs[1]. Make sure to call refresh_rate_mask for both
>> interfaces.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> 
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> Logically, this patch is fine to me, but I would like to know if you have
> tested two STATION interfaces connect two different AP? Especially, one AP
> is 802.11g mode and the other is 802.11n mode, so we can clearly know this
> patch is expected.

Yes, I did try to connect the two interfaces to two different AP (on the same 
channel) at the same time, and it seems to behave fine.

