Return-Path: <linux-wireless+bounces-22938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD0AB6C62
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 15:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7443ABD49
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A745B28DD0;
	Wed, 14 May 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="X2KJ17ih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7814AA9;
	Wed, 14 May 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228541; cv=none; b=J9FSq+QvuCLvltci+J+bxSBw6zDR9uRvWQSixe9Co78g0wi9X/e/EHrK0VNLyZv35p1JLjTnEFxqZ7j45x13uZ4lK+CEkiBeNswZvHM6lwDcUMAzPDrkpMGD++u3MlBrAluIeFMR0Q2Av0HdBwDY2Qmkz57/qy61eRWLUh9KxRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228541; c=relaxed/simple;
	bh=FZHRZmibNVKSe41yuOXiAs9hx4wzzfN6h/VdvLZyzh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=WZKD+JvxGd9x2aaKoeTWCtY4zKZ59qVl2S0Vy2O5If8TN+YISyc1l8etjHXMM7RieCFZwetdu2DJnChf0yab7yGQeSxoGVUUYPc2J/8vEefPRhqdoDBE3GD1DXyxtOH/+H1BAAftAf/DKcJY/pse41IsAItZah/W/gChXX7mNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=X2KJ17ih; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id B0DBD2FC0050;
	Wed, 14 May 2025 15:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1747228529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UizUCsRI54NulxCIGiE3a13b3aowPXbAgl8KTCDAKHE=;
	b=X2KJ17ih4v72TpBy4Wxw0AnqbqoLTHpfV8Uyd7xh7vrzDT43wIrmqx5W7QtvwU2ExLFx4z
	42dpGu1epMreLztFrYMKbW9lC6h6n3yTUyMpmChmxDAkaGDcb0gI7eODxDpwmj1cRi5N9p
	TIhRB+2QqYWCxpF8ilat2iL0k8WcsIo=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <8db21316-9db2-4ef8-95ca-bec9b6623211@tuxedocomputers.com>
Date: Wed, 14 May 2025 15:15:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RE: 6 Ghz frequencies always listed as disabled in newer kernels
 with Mediatek MT7921K (RZ608)
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
 <Mingyen.Hsieh@mediatek.com>, Slavi Pantaleev <slavi@devture.com>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
References: <18be5ba2-6dc4-4766-9944-59cb46c8dfaf@devture.com>
 <SI2PR03MB532296077BDB2BEBE79DDB2885FC2@SI2PR03MB5322.apcprd03.prod.outlook.com>
Content-Language: en-US
From: ggo@tuxedocomputers.com
Autocrypt: addr=g.gottleuber@tuxedocomputers.com; keydata=
 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
 bsxTTcOuRnk=
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>
In-Reply-To: <SI2PR03MB532296077BDB2BEBE79DDB2885FC2@SI2PR03MB5322.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yen,

Friendly reminder of this topic.

We have the same problem with RZ608 and RZ616: All 6GHz channels are
disabled by mt7921_regd_channel_update().

Is there anything I can do to help?

Regards,
Georg


Am 12.02.25 um 03:18 schrieb Mingyen Hsieh (謝明諺):
> Hi Slavi,
> 
> Thank you for reporting this issue.
> I will look into what went wrong.
> 
> Best Regards,
> Yen.
> 
> -----Original Message-----
> From: Slavi Pantaleev <slavi@devture.com> 
> Sent: Monday, February 10, 2025 10:56 PM
> To: Felix Fietkau <nbd@nbd.name>; Lorenzo Bianconi <lorenzo@kernel.org>; Ryder Lee <Ryder.Lee@mediatek.com>; Kalle Valo <kvalo@kernel.org>; Matthias Brugger <matthias.bgg@gmail.com>; AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>; Mingyen Hsieh (謝明諺) <Mingyen.Hsieh@mediatek.com>; Deren Wu (武德仁) <Deren.Wu@mediatek.com>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org
> Subject: 6 Ghz frequencies always listed as disabled in newer kernels with Mediatek MT7921K (RZ608)
> 
> 
> External email : Please do not click links or open attachments until you have verified the sender or the content.
> 
> 
> Hello!
> 
> This is in regard to Bugzilla Bug 218731 - Tri-band AMD RZ608 (MediaTek
> MT7921K) has 6GHz band disabled in kernel 6.7+ despite working in <=6.6
> 
> URL: https://urldefense.com/v3/__https://bugzilla.kernel.org/show_bug.cgi?id=218731__;!!CTRNKA9wMg0ARbw!hwgyrPE5EUmlhv276MLdhh3io-OmXeYvNMVGUpAUbJ7wgc9z8WI4fZoD0Ze1WlIlqf_1qrieE1unap_P8_E$
> 
> I'm in Bulgaria and `iw reg get` reports this:
> 
> ```
> global
> country BG: DFS-ETSI
>          (2400 - 2483 @ 40), (N/A, 20), (N/A)
>          (5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
>          (5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
>          (5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
>          (5725 - 5875 @ 80), (N/A, 13), (N/A)
>          (5945 - 6425 @ 160), (N/A, 23), (N/A), NO-OUTDOOR
>          (57000 - 66000 @ 2160), (N/A, 40), (N/A) ```
> 
> For testing purposes, I've also tried switching to another regulatory domain (`US`, `DE`, `SE`, `NL`) via `iw reg set ..`.
> 
> Regardless of the regulatory domain, `iw list | grep -A 15 Frequencies` always reports the 6 Ghz frequencies as disabled on newer kernels.
> 
> As the original bug reporter has discovered, the regression begins to appear in kernel 6.7.0 while it isn't present in 6.6.30.
> I've done a bisection and the results are like this:
> 
> 1. [bad] mainline (954a209f431c06b62718a49b403bd4c549f0d6fb)
> 2. [good] v6.6.30
> 3. [bad] v6.7.12
> 4. [good] v6.6
> 5. [bad] edd8e84ae9514e93368f56c3715b11af52df6c3b
> 6. [bad] 89ed67ef126c4160349c1b96fdb775ea6170ac90
> 7. [good] b827ac419721a106ae2fccaa40576b0594edad92
> 8. [bad] d1a02ed66fe62aa2edd77bd54e270ebc33bd12ff
> 9. [good] 3abbd0699b678fc48e0100704338cff9180fe4bb
> 10. [good] 5a423552e0d9bb882f22cb0bf85f520ca2692706
> 11. [bad] 56a7bb12c78ffa1b02e154b1d779ed2a1555fa3c
> 12. [good] a3c2dd96487f1dd734c9443a3472c8dafa689813
> 13. [bad] 089482a06b74a40d45773b1871182e8f04be026b
> 14. [good] fce9c967820a72f600abbf061d7077861685a14d
> 15. [good] c948b5da6bbec742b433138e3e3f9537a85af2e5
> 16. [good] 9585316a2aaf773a67846bdc8bbdd4df1e9622fa
> 17. [good] 51ba0e3a15eb1643116a93674e230e11b9499592
> 18. [bad] 09382d8f8641bc12fffc41a93eb9b37be0e653c0
> 19. [good] 4fc8df50fd41c2762d893211487be0ecb24c6a05
> 
> 09382d8f8641bc12fffc41a93eb9b37be0e653c0 is reported as the first bad commit.
> 
> URL:
> https://urldefense.com/v3/__https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux/*/09382d8f8641bc12fffc41a93eb9b37be0e653c0__;Kw!!CTRNKA9wMg0ARbw!hwgyrPE5EUmlhv276MLdhh3io-OmXeYvNMVGUpAUbJ7wgc9z8WI4fZoD0Ze1WlIlqf_1qrieE1unR0MDLCs$
> 
> Regards
> 


