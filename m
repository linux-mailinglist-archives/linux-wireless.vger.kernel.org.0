Return-Path: <linux-wireless+bounces-8450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308C8FA714
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 02:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C41C22060
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041CF818;
	Tue,  4 Jun 2024 00:35:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305C67FD;
	Tue,  4 Jun 2024 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461349; cv=none; b=OBj6Bmq3rZ99U4ylTuKkGjbg7xPDTXHBOkesGIwnqv5mJHwRtfp3wpwtPtqcw58fTptYAiH39hYXNFqhaSH4LGr5g1x+nlygOt9gfJR4IHr8A+koDO+fYKWoLAExjWwthUqqQaU92YYb3TPpBwyLG5htfXEiH0FbLYtv7KUUOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461349; c=relaxed/simple;
	bh=mc3T7X/7KmZ+nx7G2b5CJFKMscc7z4qeRh9L5JZzvb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cOI+k8FWXkPX6cssQnqj5vhHif2f6CATpvvsa+gcsWAeqOD5BbFVCXrSbwZS/Om8AaO5WvtNLRUa76ad+n7YveyGw3IsGxUJNm75woe09kNRCFZqlJyWFvei+toTOyeXMNothlLJSYGriKWD4ItxP6nZtOHpdWfGuCMVsC6Jf5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4540ZRoR43544825, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4540ZRoR43544825
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 08:35:27 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 08:35:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 4 Jun 2024 08:35:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 4 Jun 2024 08:35:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 5/6] wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()
Thread-Topic: [PATCH 5/6] wifi: rtw89: use 'time_left' variable with
 wait_for_completion_timeout()
Thread-Index: AQHatZbao81hPkddpUyWjWsMJ9aM8rG2wuZA
Date: Tue, 4 Jun 2024 00:35:27 +0000
Message-ID: <1fca9d83960442b0b637d4e9586766bf@realtek.com>
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
 <20240603091541.8367-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240603091541.8367-6-wsa+renesas@sang-engineering.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeo=
ut' to
> store the result of wait_for_completion_timeout() causing patterns like:
>=20
>         timeout =3D wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
>=20
> with all kinds of permutations. Use 'time_left' as a variable to make the=
 code
> self explaining.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



