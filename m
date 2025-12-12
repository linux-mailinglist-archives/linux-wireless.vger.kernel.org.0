Return-Path: <linux-wireless+bounces-29688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02ECB7BA4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E52F2301C918
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DEC256C8D;
	Fri, 12 Dec 2025 03:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="p0uxoH1s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2E21E091
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509212; cv=none; b=aU3BNvWunInWIZQ4fxDF8V84gnouCMA/Py+GyBudsKnQuv8rOy7/0YgsTLaRwJeZ1lE8395se+XkD/LSUXb7t2KRQdHUJBJK38UxnpzpoP3ipDvwymJiZOeuvTSLPGMezt9HF9zo7FKZw25W7wqvlEzs7Ge46If4NvIE7jCouLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509212; c=relaxed/simple;
	bh=DbV0qoBzIy5wBm63kzuqmNLoln6t3BM/BxTp5cYhkCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iS9/1ujl2FKp4Q1yHDqrgCGCfNXcIkIwzbfdsa5wprMtcV4Ap7giFXsmdvrsdlIxHhTevxmRTSswemCc+6J8Bc7R8zYzuAT6rFLEMe8mqx6t5gkdVXct/Xc38N0CdGKqXyV54rzr+9uJ5G2QUdaQeKejfbojn1vuw82LKNXGHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=p0uxoH1s; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3DQKd83507554, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509206; bh=rYx5ol7JLcIvX9yUliF61rpfDzp+gWAYFxRxOKea5Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=p0uxoH1sT/WVWHHaV/sXniLZFcyoTf6ILnu4Y0vmF3RXFzLPIy/jzTaYBCn74YWIS
	 1W4hFa67Mnf1rIdH+EE3WE3OrseqKsfii4yYsrB0WWiIiv8Eh869kxzrb1A+UbkWDb
	 Ju8P5oiQjqR2aBmjzPTMpfw8dqws16LRi+lYgUuT431y0PPV9+FKhIBdXq1xS76RQB
	 AqWvvEwfkCz3Kc2kIwp4gY/HkJ6LUbXXmFXZjMIuaoA8p12GneLuadFtSj1vt7x3y1
	 7u+kB9ya+id48qozvn4QRP80Yb2D+2zUQyTZqiAUEqAwjgJH+FBe1gDpHAjXM74fid
	 BBzMxyRaItHEw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3DQKd83507554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:13:26 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 11:13:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 12 Dec 2025 11:13:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/12] wifi: rtw89: 8852b: increase beacon loss to 6 seconds
Date: Fri, 12 Dec 2025 11:12:52 +0800
Message-ID: <20251212031303.19882-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212031303.19882-1-pkshih@realtek.com>
References: <20251212031303.19882-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Kuan-Chung Chen <damon.chen@realtek.com>

Intermittent beacon loss from a specific AP can lead to
disconnections. Increasing the beacon loss threshold
helps stabilize the connection.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7b9d9989e517..0f278476d55b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -837,6 +837,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 7, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 15, BEACON_LOSS_COUNT_V1),
 	__CFG_FW_FEAT(RTL8852B, lt, 0, 29, 30, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, CRASH_TRIGGER_TYPE_1),
-- 
2.25.1


