Return-Path: <linux-wireless+bounces-29010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9851C61F3C
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 01:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1455634FA02
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B309F8834;
	Mon, 17 Nov 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YbCA1fTj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19A747F
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 00:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763339491; cv=none; b=mmYESEW7z7I77mqXtReX0C3alWsLwwL1SyHkw/vlahdYaoBl7u3FsnqSRh8kJORLyd/Amt5lkHrfdtNQzLFkNMa3kp8oFuXRk+Z0Mqzk+RwP9BZIDQLz1PMJKBO3jAMAb2xfkQ/+1sUeQHkP8WtlJJ07/OiupQEknC05ub6ggGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763339491; c=relaxed/simple;
	bh=QpooQcE2pNrxLLIekqyf6ViDRB1LWl8gGkFEKPoF9Go=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K55GhEiPSUB+YhJHOnVPlDvAfU4mwG8zERrBo0l/Fv0mQsdyvk7sI152C/HZmmClDlxChqKfrCvXwwrZ0PIC1g05dhnW/dejrYzH/yDa98M3r9T1B6yNdAbqg1vbXCm5lZV0uC++OF3uSEiDWLmTsnmhq0j7klVglyPzkyCfnwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YbCA1fTj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AH0VMwM42468464, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763339483; bh=QpooQcE2pNrxLLIekqyf6ViDRB1LWl8gGkFEKPoF9Go=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YbCA1fTjUdQDv3Ms56bp4cAzVwG64wuPefE5F1YTDG6r7v/sw6pstffs4Z2zAH4ZM
	 j0vfwtOZkw0b6kdmw3JjhEumj3H2ExlBcyxVXDEG0Hvpf2NUVyCx+425IMviYNlszk
	 QOfyw9G4FeMLkSnXCxGmbtA/J/cMihh6Jf69SUgcIQnkhdMxfeQrERSe4j2U2TkgbU
	 5oC/9pk6XsCAGaGlY5evLXyAXbSxn45Mmaf3Qzj7S0pcCVK3Cq4+Z4AXayNCmENkbI
	 4fTKIZC9xAIiXmTM5K5f2zgGZ2PTNcPKmV9sjJHzqFbbIdt/zeUOylq1Jp6+/RcD5B
	 6CKF7u2CwaLmA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AH0VMwM42468464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 08:31:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 08:31:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 17 Nov 2025 08:31:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "usbwifi2024@gmail.com" <usbwifi2024@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw89: Add default ID 0bda:b831 for
 RTL8831BU
Thread-Topic: [PATCH rtw-next] wifi: rtw89: Add default ID 0bda:b831 for
 RTL8831BU
Thread-Index: AQHcV1LpggTDD4Oj3UaBM0SfG0L1lLT2BD9A
Date: Mon, 17 Nov 2025 00:31:23 +0000
Message-ID: <dc0c6197cda7467d82d01784dc6dd925@realtek.com>
References: <20251116234403.8803-1-zenmchen@gmail.com>
In-Reply-To: <20251116234403.8803-1-zenmchen@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Zenm Chen <zenmchen@gmail.com> wrote:
>=20
> Add 0bda:b831 for RTL8831BU-based adapters that use this default ID.
>=20
> Tested with TOTOLINK X900USM in station mode very briefly.
>=20
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>


