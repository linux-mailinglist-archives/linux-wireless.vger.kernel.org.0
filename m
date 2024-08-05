Return-Path: <linux-wireless+bounces-10947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBB9477DD
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 11:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1351F227E3
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351181527A7;
	Mon,  5 Aug 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="iHM9P06b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18B14E2D8
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848467; cv=none; b=DytUJnJUEaDnIIlrneqc+IHTj64j6Zws1rrHOgS8q54G/lkWNJUy7JlLZAXzuxJGjtG35bFEPFS2BUU73o0H61HJvy7Er9qFU27BrzLIMPN8JNv4zPLfIOTcj7ZLjQxREEz2sJUO2xKaDmx3hNwQL63bHTlVoABazvfneCvHhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848467; c=relaxed/simple;
	bh=mlxx5eekTPig90BkbnC/kNR+uBKNml/7GlB54NTCHnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKP9Wx9j7JWLPeeIZRGPzMaq+RNe3r4+Le/uvSiUvO6LQbCL1er/hjXAUHeTDDK2v0f6dSiMQpdqUElp20VnUbA2PV365LX3zTvtDNEdH7nxjgXTehWwJqrARZX15cxtBu9BcnCkdUxIxMlB60Od2x8R9dAALFy5+mK+xciRDds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=iHM9P06b; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 475911Sw83834729, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722848461; bh=mlxx5eekTPig90BkbnC/kNR+uBKNml/7GlB54NTCHnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=iHM9P06bKZVVIj1613B1J/Hm854/LTWrdGzHixMV+UY8gimegl/smMkbJRJA4U6bG
	 0CWCN4WXN6SB9bS2lDyQv8acmJe/m+sRqEkfsiu3wG1/lCpAQZ4hQt0uda3cc77+/E
	 PffiZ/YaFCp+vreX5RfSbazrb6dQ85QWQizXrx7FzuRdYOKc71UH/qgvHUkTiEX9JP
	 mVHgTlhCIOeeHn22Ypk7M1yDxUbp9NuX/fs639TmYuA1LmZTFXD6co9luIV60EkAOX
	 MKDmsc+N1ZTUFHkPE9p+Q5RIYX7Rnh5ptd39xSTXKAnRiB+xczBbbuKsuVFWyCma70
	 m5Zo+X0y4OqYA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 475911Sw83834729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 Aug 2024 17:01:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 17:01:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 Aug
 2024 17:01:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>
Subject: [PATCH 1/5] wifi: rtw89: 8852c: support firmware format up to v1
Date: Mon, 5 Aug 2024 17:00:24 +0800
Message-ID: <20240805090028.27768-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240805090028.27768-1-pkshih@realtek.com>
References: <20240805090028.27768-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Driver has supported different WoWLAN reason code by commit 0e5210217768
("wifi: rtw89: wow: update WoWLAN reason register for different FW")
since firmware version 0.27.80.0. The old driver can't support two
kinds of WoWLAN reason, so increase firmware format to v1.

Also driver tables of BB and RF registers and power values will be added
into v1 format.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index d9d7b3ff338a..244f50e72549 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -14,10 +14,10 @@
 #include "rtw8852c_table.h"
 #include "util.h"
 
-#define RTW8852C_FW_FORMAT_MAX 0
+#define RTW8852C_FW_FORMAT_MAX 1
 #define RTW8852C_FW_BASENAME "rtw89/rtw8852c_fw"
 #define RTW8852C_MODULE_FIRMWARE \
-	RTW8852C_FW_BASENAME ".bin"
+	RTW8852C_FW_BASENAME "-" __stringify(RTW8852C_FW_FORMAT_MAX) ".bin"
 
 static const struct rtw89_hfc_ch_cfg rtw8852c_hfc_chcfg_pcie[] = {
 	{13, 1614, grp_0}, /* ACH 0 */
-- 
2.25.1


