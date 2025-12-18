Return-Path: <linux-wireless+bounces-29882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE0CCA7AF
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE3DA306802D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3852C11EE;
	Thu, 18 Dec 2025 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="r2vhc+qd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87623EA92
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039499; cv=none; b=BxyxGJ5U+nNvgLhdhhRwYw8txEV9h7xBBjGC6zKjWC/1ZkUb0tZSSffRDg+JJa4xbaWe/6NlNTdLRyCO2JQjMt5iMe0B5MhERtlhAwGuANDX1JhWKpGVPuYzJwyMOGWwpa98eZs1VXo4HUNTcfnY/LF3cZsA2W0tJmoJ/Hm75VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039499; c=relaxed/simple;
	bh=DbV0qoBzIy5wBm63kzuqmNLoln6t3BM/BxTp5cYhkCs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTEpuPyTtPzf3+TD9GlKYqcqbC3JaKg95gsmNICJpni2QIHTmEugoOFWLLjP2AHykRlYtTFx/5ClOqozSmov3OtD2+qqXAXisO5tsWgmW9IntMLksFbIVx0nXHjrtgKRzZMGUoE5p21l9LUVdcmwrfjB4nLv5xMMPmacYktL68Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=r2vhc+qd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6VZVp83322968, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039495; bh=rYx5ol7JLcIvX9yUliF61rpfDzp+gWAYFxRxOKea5Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=r2vhc+qdxZNw3j29Rw2LqxtCgu7edfGlU7ovFy/Kt4egmKUxYzRoYPtrGFbGmfu/+
	 gvZtmX62X6wi63CrsMEkoS0fR863R3Doupr1WYUzoZiD7QlTOQKld9Ma8UeF0Q0+re
	 m3nT0hobA6a38H+DZYME+Wt5v0Z2DhT+rohijO21vC0DTzlqUBHCcMYFcVUsYHOCFK
	 1Wyjbe29I9gvIHMOXkOx8NVmwHidMeHILslBrwEADcmSdA2Kmf+/e6iM5uEVyugk64
	 tDO8+SbbP7gUtkkAe0tLIB4ySbTq9X0/SpCyJ6iHtXsOIjq7Xq0QT8WsEGfwvLiwF1
	 EA0XsdWta6Axg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6VZVp83322968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:31:35 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:31:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:31:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 01/12] wifi: rtw89: 8852b: increase beacon loss to 6 seconds
Date: Thu, 18 Dec 2025 14:31:06 +0800
Message-ID: <20251218063117.26278-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218063117.26278-1-pkshih@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
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


