Return-Path: <linux-wireless+bounces-30058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B990CD7EFB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 04:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C625300C1B2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213142C3251;
	Tue, 23 Dec 2025 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uktxXBCM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F752C1590
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459234; cv=none; b=JbDL+ez1BKh7VumY738d9sMxrtRcRT5TDVlHytpEWApxl17Zw9P7lcSbGpCJfV5iu8+avvtX8DkYmIPu4L9euFZSXNFsbAgVbSx50hJTW+rQtnmehaWrbIrPJyZGqZ+n+LN9FfWWduimCdgIRYIILyvcdaCLAhRgInAsY8Jz6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459234; c=relaxed/simple;
	bh=DbV0qoBzIy5wBm63kzuqmNLoln6t3BM/BxTp5cYhkCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjAQGVXOgpIJib34Kt6BtHbvVp9H5TJS4BILgZY0GLKwPP1i/5HPV5ZI0MPo7D4IU4R3T9/x2ZOcrKr4k39FLrljA//RR1mOo4a07yvPphnWOPexCzLRFJbmRhHSCT4LoB83tiy0tgiZ8B4PUxSCF2g9NQOVbZLD0QOPTQOTVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uktxXBCM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BN377RS0571124, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766459227; bh=rYx5ol7JLcIvX9yUliF61rpfDzp+gWAYFxRxOKea5Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uktxXBCMWYEOpe8yJeRP72jHqMLhPiq/nPZzy0+zTM0V1O4OVKosBBNXetHwYf1+5
	 GiRVpaROoM+kx+iaJJARy4sa3d31cSm93cTpwmuYJAqRgqIIz3AfgWUywOUP+3fUvs
	 tBYMVf97yNO6Tm9jof+pruOsH+LeJoja/XPoql9GLVT3CPBhm46Ps+eRFEqn2c6iUc
	 SWLituul4w7DbCtTyfRKP5JGpMaRWmCN1GU8uFjUX4WRxEeTvHmvLge3jjjLpm61Lx
	 CikgXhvSieiBfcUq2lVOd+VTxJa2Ghx3NNavKfY3GHw0qeD+yJ+NecgfMWrVA9H0lx
	 j2caZsOQfiOvA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BN377RS0571124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 11:07:07 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Dec 2025 11:07:07 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 23 Dec 2025 11:07:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v3 01/12] wifi: rtw89: 8852b: increase beacon loss to 6 seconds
Date: Tue, 23 Dec 2025 11:06:40 +0800
Message-ID: <20251223030651.480633-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251223030651.480633-1-pkshih@realtek.com>
References: <20251223030651.480633-1-pkshih@realtek.com>
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


