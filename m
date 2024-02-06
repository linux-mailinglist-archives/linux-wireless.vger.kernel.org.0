Return-Path: <linux-wireless+bounces-3181-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E97184AB1F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 01:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FD91F24B8C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 00:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2D21362;
	Tue,  6 Feb 2024 00:37:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C581373
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707179824; cv=none; b=T4TvupzUvkCNWbhIQlRsjB9dr1BX3NrMDCPk4k9Vf9xkJ/9Tb6EIB4pw2fb5wApa4oJ7PZCn2++QTchokMRiizG6K0M11WZ0wKi1ZxLh0zGT2OBJ9iAUaYluuezb2VyBG6KnIKd1SSgwlHh/SB/RziYEuCRRhgHyIIJRgrkJcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707179824; c=relaxed/simple;
	bh=RRNiUJW23npH9e3BUMPGpxCAWkbaRa2JGLoTUHMdpc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5eZc/igNxK7RZQgwbAiHr8k8Utfxy31KT56HYQhGZTdgeRusB9QKbTx1qvU1eo3lLJGSs66ZM7Pct6ocb8N++UsEsa95MbXYE1cITXjPksUv6MMne6MVlNelTq4FCoOp3FO0R9+p3bGHeXrp+WHo+TEJlJvWLVaABTVXGWidow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4160aa1gB3438781, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4160aa1gB3438781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Feb 2024 08:36:36 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Tue, 6 Feb 2024 08:36:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 08:36:36 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Tue, 6 Feb 2024 08:36:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v3] wifi: rtl8xxxu: update rate mask per sta
Thread-Topic: [PATCH v3] wifi: rtl8xxxu: update rate mask per sta
Thread-Index: AQHaWBYF7zDVDwY1+EGQA/lkHaVU+rD8dxvg
Date: Tue, 6 Feb 2024 00:36:36 +0000
Message-ID: <1c59d20d51324b8bb7863580774199cf@realtek.com>
References: <20240205093040.1941140-1-martin.kaistra@linutronix.de>
In-Reply-To: <20240205093040.1941140-1-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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



> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Monday, February 5, 2024 5:31 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH v3] wifi: rtl8xxxu: update rate mask per sta
>=20
> Until now, rtl8xxxu_watchdog_callback() only fetches RSSI and updates
> the rate mask in station mode. This means, in AP mode only the default
> rate mask is used.
>=20
> In order to have the rate mask reflect the actual connection quality,
> extend rtl8xxxu_watchdog_callback() to iterate over every sta. Like in
> the rtw88 driver, add a function to collect all currently present stas
> and then iterate over a list of copies to ensure no RCU lock problems
> for register access via USB. Remove the existing RCU lock in
> rtl8xxxu_refresh_rate_mask().
>=20
> Since the currently used ieee80211_ave_rssi() is only for 'vif', add
> driver-level tracking of RSSI per sta.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>



