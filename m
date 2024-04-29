Return-Path: <linux-wireless+bounces-6956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F908B4F59
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 04:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFDF9B20AAA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841F10F7;
	Mon, 29 Apr 2024 02:08:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBD37F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714356532; cv=none; b=qByE1ymttA0wQh9/XLfOGMv7Lcta8q4nEICcYhanHs/KJazFM6sBUzlk3xssACSdNr3yAkcKf2CqiNK8tqT+RcFP/HWSlZqHPeLxkkyPUGyo6l+uid4xjA9EFfOPyJ4cZDkdQZYyR6koW7B7SMz++bH9asFKtnoiYhUt+e92/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714356532; c=relaxed/simple;
	bh=KcsijeCsQhkzdFCgbhdQMS0wkCDWmOgxjHwclWPp3y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIfeSFX2yZmuLNy5aPF0V23StczCFK70g18cO7qe3kTh6Uzdm/qQN8ESeOI+lTWqJ1xVsI9HO9fHa4EOMLqrrZlGpQSRcQGejaVNNV1mFj5reAG25ZEuGdWs8LWPdJxFN1z+QI6Jd3cy69fFFWZy0FRnXexdKUsQQVOOq8OheNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T28jB722936855, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T28jB722936855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 10:08:45 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:08:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:08:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 29 Apr 2024 10:08:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtl8xxxu: remove rtl8xxxu_ prefix from filenames
Thread-Topic: [PATCH 2/2] wifi: rtl8xxxu: remove rtl8xxxu_ prefix from
 filenames
Thread-Index: AQHal+TL9DGQ28poFEyAvI0oRcqRl7F+hGlg
Date: Mon, 29 Apr 2024 02:08:44 +0000
Message-ID: <7b492ab5ef5d48a6937485aaba8754fd@realtek.com>
References: <20240426141939.3881678-1-kvalo@kernel.org>
 <20240426141939.3881678-2-kvalo@kernel.org>
In-Reply-To: <20240426141939.3881678-2-kvalo@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Kalle Valo <kvalo@kernel.org> wrote:
> The driver is already in a directory named rtl8xxxu, there's no need to
> duplicate that in the filename as well. Now file listing looks a lot more
> reasonable:
>=20
> 8188e.c  8192c.c  8192f.c  8723a.c  core.c   Makefile  rtl8xxxu.h
> 8188f.c  8192e.c  8710b.c  8723b.c  Kconfig  regs.h
>=20
> No functional changes, compile tested only.
>=20
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>


