Return-Path: <linux-wireless+bounces-19045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E677A37BA2
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCFAB3A6B3A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF9F18FC74;
	Mon, 17 Feb 2025 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qfOKpa+v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495C18DB3A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774644; cv=none; b=dqzovaOUAWXp3Maq9/5mxjspH2VIeH/ajdXCB4q5tLb2iXi3QS5sPxBX8FGN1nnCzM1AXYTlBaJTR74k2fGn4iWQG8/kBbRcxcLuoUDmmtrI7+RDCKjZvgxShotwu0+3oec72y7lOcmFzyMgzLHihyMhjdrloa9JTCeAopihYUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774644; c=relaxed/simple;
	bh=0MJUI2BXR43+gA3+wdie390XOzYSm1KOBLoHr2UTJ+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bhxMxCMDNvGafc5lBwstHZQtV+oBeJvolFxqEjVdc7kn3WnZPgF0NXR1TxjeQaWhZLBjpLsNfvpeTBUurDYutv/yLZsa3jIXplvZIjgIHIjGQtwTRf4Sd/5U1A+u+9UUJkoazxuwKKxcO0nL4bwH9Afp8cbSbJwknqgU8nwRYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qfOKpa+v; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6i0BM12646770, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739774640; bh=0MJUI2BXR43+gA3+wdie390XOzYSm1KOBLoHr2UTJ+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qfOKpa+vfG2JJ3S3GeDKIJL2dHY5QMS0aqE6tqXYusBYi17FwdX7YVLk0waO1/q8D
	 R66/T4OEXFGZkuRZoH6tkTUHtxP+e+mADfOZLSpoQKeEV8LG+i8F0KdIXXYTpf5bQE
	 PhUXq9E4M5Lu/dNErkKgPxSUUZxOva4EQcm59mIZAxj40NzBq0hhxSm/8b8ALjFN0/
	 kifEeGQ/ZkO/6bjnnxrCFrbaHi/q/Q6esBVT+Ui8GhGBGI9yWcWpuSacGOzoUuVPKS
	 cR8LGxgXg2jQPOnMPj25jAYfH0HaFT2k4pD3thmUF3empRSao7ljahZkKhhLc2N3HD
	 TXcAsS4v+wIrQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6i0BM12646770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:44:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:44:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:44:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
Date: Mon, 17 Feb 2025 14:43:05 +0800
Message-ID: <20250217064308.43559-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217064308.43559-1-pkshih@realtek.com>
References: <20250217064308.43559-1-pkshih@realtek.com>
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

The sb_sel_ver is selection version for secure boot recorded in firmware
binary data, and its size is 4 and offset is 58 (not natural alignment).
Use get_unaligned_le32() to get this value safely. Find this by reviewing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 17f80f1f23df..abbf420463bd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -324,7 +324,7 @@ static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
 	if (!sec->secure_boot)
 		goto out;
 
-	sb_sel_ver = le32_to_cpu(section_content->sb_sel_ver.v);
+	sb_sel_ver = get_unaligned_le32(&section_content->sb_sel_ver.v);
 	if (sb_sel_ver && sb_sel_ver != sec->sb_sel_mgn)
 		goto ignore;
 
-- 
2.25.1


