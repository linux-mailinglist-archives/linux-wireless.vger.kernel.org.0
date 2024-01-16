Return-Path: <linux-wireless+bounces-1972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8782EDB1
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 12:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9252F283A10
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 11:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2C1B7FD;
	Tue, 16 Jan 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErOtbSE0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7ilUB8c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEB1B7F3
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <7b45d86b-d5ed-4e1a-b514-7388211d7860@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705404515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hl0H3p8Sh3Dy9IeQhdQ52crr+xmEhu3aDrtjLPTG0Y=;
	b=ErOtbSE0u0dzzBpK0Wfa9+7z1KuNj1ZPGbJKVnuSBXVJGSk3JhtdCfzHaAvZDo9+xNaybT
	27gkkeOrtFpaFp3ZgIJ88SjTli8LYXxDmFtB/62PysvXERqFSkW8/6yRRzMLqy6yxY3yj0
	YL9c+lX+EVwpXI3q6PBVBcOP08ZHZdJKwOPxcNUGzvj5UdTDjMBxTrpD/jeZDZudqdc66R
	IrSHTIYmjPLzwJbqPmJGdzYnC1/vU+raNM/SEIMa7AHrB/uEEmIV9GT9ZCzWmgJkw4x7Uq
	y1HcEtq0ffmav1vBXGj2D9Cf6Tqg8cHAeHLeDQntvnCVzpLUxa8iIrThEzlhUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705404515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hl0H3p8Sh3Dy9IeQhdQ52crr+xmEhu3aDrtjLPTG0Y=;
	b=t7ilUB8cRGH/E1M+V4WqXcIYzLGdaMkh4i/AcjYiWjJNxDSmbdI+agz7e4wr1LnDJEtUl+
	NYzNI/I4nOU0EoCQ==
Date: Tue, 16 Jan 2024 12:28:34 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: rtl8xxxu: add missing number of sec cam entries for
 all variants
Content-Language: de-DE
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Bitterblue Smith
 <rtl8821cerfe2@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240116095001.399500-1-martin.kaistra@linutronix.de>
 <87y1cpfs49.fsf@kernel.org>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <87y1cpfs49.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kalle,

Am 16.01.24 um 12:13 schrieb Kalle Valo:
> Martin Kaistra <martin.kaistra@linutronix.de> writes:
> 
>> Commit b837f78fbffa ("wifi: rtl8xxxu: add hw crypto support for AP
>> mode") introduced max_sec_cam_num as a member of rtl8xxxu_fileops.
>> It was missed to set this number for all variants except 8188f, which
>> caused rtl8xxxu_get_free_sec_cam() to always return 0.
>>
>> Fix it by adding the numbers for all variants. The values are taken from
>> the vendor drivers and rtlwifi.
> 
> Does this fix a user visible regression? It would be good to add that to
> the commit message. I can do it, just let me know what to add.
> 

Yes, traffic to encrypted networks was broken for all hw variants except 8188f. 
This was reported by Zenm Chen in [1].

Maybe you could add something like:
[..]
caused rtl8xxxu_get_free_sec_cam() to always return 0 and therefore breaking 
encrypted traffic.

[1] https://lore.kernel.org/linux-wireless/20240111163603.2325-1-zenmchen@gmail.com/

