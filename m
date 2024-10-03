Return-Path: <linux-wireless+bounces-13433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABBD98E91F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 06:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945EB1F2625A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B13FB8B;
	Thu,  3 Oct 2024 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vcSHzj06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD23E499
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727929628; cv=none; b=DQANp0rQ2Ul1KB+zHOWOmYgVkd4D3Mh1UqqVc6b2DR0Fd/5+nrSk2FzVsShS4o1htcbaLwbT2QIFQ6KXuNmIiRugVOHuDs5u4eOHaG/aeUI7oUbV1rXj8Lzl4rAUQmOThV9KxCwy3ghZTn3rbnZgTAmc9EijlNCz/4IUHC1c4VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727929628; c=relaxed/simple;
	bh=V5BCtoBCp4sAuK7Ux3YfUslHV1S3c6yoz4Qo3OB7al8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LGi9iAUCoc4NjuMFchjCIMF+m+rseUOs2zRijlBRZIoO2465who7BwVOw9ISmue9ta5E+Y/+KJ3mV4xNptUkNkzS5JZd/PE5G8reErRXYU9IqAPRCHYXN4Q0dbaUELAIXSc5jqJE939V4To5nKBKuKpzbIBGtIbF4s7p2bmJFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vcSHzj06; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4934QcdpE3499976, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727929598; bh=V5BCtoBCp4sAuK7Ux3YfUslHV1S3c6yoz4Qo3OB7al8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vcSHzj06OOS1ZJjGK4onxdjfNFv3vhs9rBItKhEtFhbvf/B+RYHeQlMEi0RUUfant
	 sNltqzO1gqid9rZxapWDYWTozJEAO0fANN30nZx2kwcdrJ+91un1MNpjoCRiEB+YoZ
	 XNYpCCsYPq1Ai0gooc9TAyFH7Ve6p++xjJ62Ys7KwGUfgbqDj+pmZWfNAPoRemqhsE
	 V7TQmnJeYkKVWSfJ+DKST3EDTP3jALAT02Nr47FWrbqkwDHvwKq13VI+X/E27wrVfP
	 x5d2akNnZrQzPgP0oOgzG3nteCj/uc9aGbiY1mZ8TyPbybo9w0egEH8O+k5RBejes0
	 PTR5VghMR/xhg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 4934QcdpE3499976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 12:26:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Oct 2024 12:26:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 3 Oct 2024 12:26:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 3 Oct 2024 12:26:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>, Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sascha
 Hauer" <sha@pengutronix.de>
Subject: Re: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
Thread-Topic: rtw88: alloc_skb(32768, GFP_ATOMIC) fails, driver gets stuck
Thread-Index: AQHbE3sze1NKG9K1hEinqRz3ygF0uLJzTWdKgAEc4MQ=
Date: Thu, 3 Oct 2024 04:26:38 +0000
Message-ID: <58f2db72612544c9a5f27e524f213243@realtek.com>
References: <6e7ecb47-7ea0-433a-a19f-05f88a2edf6b@gmail.com>
	<baca0d5d-072e-4003-ab4a-ecc524d6b89b@gmail.com>,<878qv693g7.fsf@kernel.org>
In-Reply-To: <878qv693g7.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback


> I did a quick look and in wireless drivers some of the alloc_skb()
> callers print an error and some fail silently. I think we should start
> printing errors for all alloc_skb() calls. Thoughts?

I think we don't always print an error because TCP protocol can guarantee
reliability and packets lost are normal. Also in memory limited platforms
it might be regular that fails allocating memory causing flooding log if
we always print an error.

Maybe print with rate limit is a choice? But this kind of log seems=20
unnecessary and annoying to users.=20


