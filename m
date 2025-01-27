Return-Path: <linux-wireless+bounces-17993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146E4A1D0E5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D403A2BE5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 06:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F415852E;
	Mon, 27 Jan 2025 06:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IUUuCeA7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0D927701
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737959215; cv=none; b=l1cjypyFcUQWv+BNwMsn1fO7reVphPGNTaTC4PT41R7z1dxHlTpr5qxWess2Ced4F+4pQWcUyVcpRUS+y9mdotfZ8ke3dr5sWNHy5H7cnVzkALoLcrAQUD/9rF1JIUWNDI3UVKVXLidqlzxIb4kjNKDs/V4urBzJ+Q58kU2RAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737959215; c=relaxed/simple;
	bh=oIcRSy8WLjSxA6FMNmnPtrCiXXSYxrAkc6ITYMKMZoU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lstS/Koc61sCcMKkaKcCoV91MfHVhgT1PnBjwjNsBE33Qvx083HFNQDfjOsFzU8uTXcc5dfKteiOlqwiFJI1fK+SqEbcdTTj96pM9oZ+QpIQJj21rCHhVyjqw4WV17fRDBaHVNYOYkZcnhKLd7uMuhoEz4AlebfqSTEtdbwEtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IUUuCeA7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R6QmLhA2604868, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737959208; bh=oIcRSy8WLjSxA6FMNmnPtrCiXXSYxrAkc6ITYMKMZoU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IUUuCeA7pC2kAuECl47rOVBJlEqJmLORPPYQnL2/2dyPTqXQ89ZnPNGIUsUx6ugU5
	 x+cMd49Q5QqFIJ1+FvHhXqhgEBltbN0rLwoXcihOmUBk12sH8KG2NbH2ROyR8mAQU9
	 buL8QZS31ePDwFebpZIDt5DgbXGymHo08CEAhpnc+JsAIUgyi2EtuTCBBeM6HlMcxe
	 XVki/CirVnZKIRIsQFB+6OB5XF9PGMo0Yf4y2LA+crjef2nRRI747JQZw2ehLezL+h
	 JOY2B8+jNUVCzpP4ZC7qMgJPs/fYubXh/vNyA2BMHDFSkU3/X9ug+izfAdrT+BMjjp
	 qmWZrkRmiEFqA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R6QmLhA2604868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 14:26:48 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 14:26:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 14:26:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 14:26:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 4/7] wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for RTL8814AU
Thread-Topic: [PATCH 4/7] wifi: rtw88: Extend rf_base_addr and rf_sipi_addr
 for RTL8814AU
Thread-Index: AQHbcEV7qBlnHgzxok+ZT6p8H5/N1LMqJ9/M
Date: Mon, 27 Jan 2025 06:26:48 +0000
Message-ID: <38390e3d612e42b09e8763b1de486e0d@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>,<241f642c-b31f-4b52-be65-515269769a2b@gmail.com>
In-Reply-To: <241f642c-b31f-4b52-be65-515269769a2b@gmail.com>
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

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> These members of struct rtw_chip_info each have a size of 2. Increase
> their size to 4, which is the number of RF paths the RTL8814AU has.
>=20
> This is required to read and write the RF registers of the RTL8814AU.
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>=20

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


