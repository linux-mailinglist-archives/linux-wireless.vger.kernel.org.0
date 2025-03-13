Return-Path: <linux-wireless+bounces-20296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A58A1A5ECF1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7481882485
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A028211285;
	Thu, 13 Mar 2025 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KA1Kcb3u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A9212FA1
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850728; cv=none; b=n4+0JPki3d1q8Ky/JMfTC/8Y/Olojevt6XUT0DturqCSuaKWl4j7fMsuC7n7+RMeD8bWxfopM5We4T1AfA35tRiN8gSAuHzdMPq0LN6b8guEmYLigGWRKPaQKuGPLQKymlcgM1Q33dXk3QNzUaVDOM0vsAroGPWXd0t26+tx2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850728; c=relaxed/simple;
	bh=ehdEyZ7t2NqjkWQJiH9DLFhJ2Wh+aNXA1q2mvFdlbuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hsXrIPfyvwfLS3yg+00SyQnqtUGHpt8W7LXe/+XfEYwuf66r7xLEg1urmrjm+STN/tGRen4t5J+ohud5VseQJsHvsNbpYvx1EaDDCjVbMvs6fi9h8h14nmJZqrpAOVzMfFwazYtv0VnHMcRxm+HaxQKBLBJKV8FCB7kvqPGKUgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KA1Kcb3u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52D7PFtM4749306, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741850715; bh=ehdEyZ7t2NqjkWQJiH9DLFhJ2Wh+aNXA1q2mvFdlbuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KA1Kcb3uM7hyDM14Gu5/NdxgVLliT04J9sJlkpXsfJnsD7WgrGg+x6A5Fa/l8MJAT
	 ygUZqvjBvoE6pBF1yknm/ciMtDOAJlEjOin5g6uLa3a/2bubKXbn9TEZbjyJaHmXMt
	 4+Kc8uv4Wbo4UbskDARQ8ikJ8tuZsCZFFaQh7mVp0tDiCsDiM04Rk0MfPwdJaEjH6S
	 Sp0nhtINrP3irXboRuMavivPwBOuWXZ8OEtpPKqWAGaDxV/SAE1D5Ijhz7padNCrZH
	 LH3LRUHzHBy1hVpb18ll/s5ygPySOBobtVG6UbRK/7xLn5zyDPNkyIpxASDLhj4RH1
	 pQdvj/IRkWZlw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52D7PFtM4749306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 15:25:15 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 15:25:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Mar 2025 15:25:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 13 Mar 2025 15:25:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-firmware@kernel.org"
	<linux-firmware@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "usbwifi2024@gmail.com"
	<usbwifi2024@gmail.com>
Subject: RE: [PATCH] rtw88: Add firmware v33.6.0 for RTL8814AE/RTL8814AU
Thread-Topic: [PATCH] rtw88: Add firmware v33.6.0 for RTL8814AE/RTL8814AU
Thread-Index: AQHbk9bmGrCyI8cApEKNr4dejN/4S7NwqjFA
Date: Thu, 13 Mar 2025 07:25:14 +0000
Message-ID: <09b00f3c6d554ef0ab76065284eaf0ec@realtek.com>
References: <20250313051501.2519-1-zenmchen@gmail.com>
In-Reply-To: <20250313051501.2519-1-zenmchen@gmail.com>
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
> This file contains the firmware v33.6.0 for RTL8814AE/RTL8814AU and
> was extracted from the vendor driver v5.8.5.1_35583.20191029 from
> https://github.com/morrownr/8814au
>=20
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

I have confirmed the content is identical to official release, so

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



