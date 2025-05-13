Return-Path: <linux-wireless+bounces-22897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1103AB4BCF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 08:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F021F3BDF96
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 06:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D491E8333;
	Tue, 13 May 2025 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bg+gaLj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13BE1E9B2B
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116886; cv=none; b=r16DjdxA3ScbCKJQib0NunW+W7c8CPO6m8yO5MPhYr33Yhtp5TM8yB0+p7UeqVUWqnOPEB/TwrhjiVScUBXNGyQ+9CK0veXU2SQQYmkEjDyo05/DnQb4jINfEo7V07Qt1hTdAweP4AfQ1iPzQF60tZFjbOR+dzHEMMI92OQhR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116886; c=relaxed/simple;
	bh=bUNoTSq6nABPCXD16NULVrJA8BUL4j8tgITcoKSZl+Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DRDaYOOzkSHpdsqNI3U6Tp6OWR4ZsDV5z95SsGhoukrL9cgrdD5Q9oIfu5KSVOVUjhnZj371sI9OLnl+VNqa1nzKZSD2SzzlQygD+C3GJJMGjXJI5TbOVoURjY0D0Qr18w/xws0ZHUN+wHqpy4KPN35kS7s/xCXEPOtNhV3fST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bg+gaLj9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D6EdVwA3824002, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747116879; bh=bUNoTSq6nABPCXD16NULVrJA8BUL4j8tgITcoKSZl+Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bg+gaLj9C8nh7h//0Xx34VuPPVoqHd/hKCJ3YIKm6ZGYNjn7hafJOru+I2pu8pos/
	 EgJY15TcsjjTY2Snzt+l8nGL/XQM4AoY4tDllAk0NH2KdlDzZScg/rB+d5ru537tn+
	 RIF4Xu64bK3grO1RUKVQWpO+YOCbeOVW4orRBAXKV6qn5LPtTVAA3iCDr05njG9Hc6
	 cgxdTTbjJrh7uAgbhzVxxCfiwJGw/D281gWB6RMC3+4cYsftSluKadh5TNSsnMN4xp
	 GK6xJI08qyCypuZ+XwwHsPcs7GUwSYqJPohilTKQWW5emSNcCfFc308mThRRYVFySg
	 yxN6FPfM4FLsQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D6EdVwA3824002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 14:14:39 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 14:14:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 14:14:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 14:14:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 13/13] wifi: rtw89: Enable the new USB modules
Thread-Topic: [PATCH rtw-next v1 13/13] wifi: rtw89: Enable the new USB
 modules
Thread-Index: AQHbvTbaUiHk1gQ4e06Y3a5WvdB6vLPQIgag
Date: Tue, 13 May 2025 06:14:38 +0000
Message-ID: <9c17098cf14c42a99aa4f0688531ccfb@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <42c89728-134d-41a8-bc7b-8d95940b202b@gmail.com>
In-Reply-To: <42c89728-134d-41a8-bc7b-8d95940b202b@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBFbmFi
bGUgY29tcGlsYXRpb24gb2YgdGhlIG5ldyBydHc4OV91c2IgYW5kIHJ0dzg5Xzg4NTFidSBtb2R1
bGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4NCg0KDQo=

