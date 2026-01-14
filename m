Return-Path: <linux-wireless+bounces-30805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFA5D1BFD3
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA8753006701
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8D248F66;
	Wed, 14 Jan 2026 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RJbKmLvr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63921ABD7
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355379; cv=none; b=aTm+YKnnjJfjK/VCGa7OLMS6EEy55sKYGVM8l57b0a43uveULG/OZiTPiUEepWwwrJ73/PoDR1HgHu4Z8Ud6XWKd66gNLnNWEXLqi38BBZxR6kT0ucoEkoJcCiWQf4G+ZtDUTOxjUXZa0oyOYcO4GZOchr7KuUL8i0Y2QPcATjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355379; c=relaxed/simple;
	bh=1AoILnnkO4BrsPoOQuRvc9AomLcIBvtd0lz0f4Fmhkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AezHAoP6jtx7DAMJ/mEqQPnUKHu98HAOWqPl0OEqIyZNF46cI87YJU+O86vM6ddGmVkUPgRuCXKseod+3fM6M3GpyK5Apy4VgCycQtjdji/aYFSXWaq6A5tMIMr4oDmUpCU0FVFk3v9ymmlD928NzIZDMQf0aqob1nO8Qow4sTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RJbKmLvr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1naZbB001878, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768355376; bh=eb4LW4XID6Lr3z1QyvLORJNlRFf/Rzxl+N3J5bOCFSA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=RJbKmLvrA4a5E2AKcHoyp6S11PwVx2THIkFaBiIZXSK+FberxOJUqPE2AuVOYeBzV
	 6cqKgvFYh9y6L54lN7sO35p6bNzonFGMrhLdUq1V8L9EJ1EOuODUyFgU6K6dUdeYmT
	 FNfToGCwi4HvOLqYvrSXRej9TAHUmWXbIRgF9YbX36V0feYhrAvnVcA1wAB379NQd4
	 qu6hD+BsCd+5YJGUjCqoLPufziy43knwuZfXHcOQhQMRuXEOufTNjhL2UnKwXMhpfE
	 pIuCSKjSpxcNToYwK0di2FLeA8NTal8iNIt38GWJGpe3XWbYKqPQY9nOQazmYG9riP
	 osM7R5jUYCWcA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1naZbB001878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:49:36 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:49:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:49:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <isaiah@realtek.com>
Subject: [PATCH rtw-next] wifi: rtw89: Add default ID 28de:2432 for RTL8832CU
Date: Wed, 14 Jan 2026 09:49:06 +0800
Message-ID: <20260114014906.21829-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Shin-Yi Lin <isaiah@realtek.com>

Add 28de:2432 for RTL8832CU-based adapters that use this default ID.

Signed-off-by: Shin-Yi Lin <isaiah@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
index 2708b523ca14..3b9825c92a0d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852cu.c
@@ -46,6 +46,8 @@ static const struct usb_device_id rtw_8852cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0db0, 0x991d, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x28de, 0x2432, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35b2, 0x0502, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&rtw89_8852cu_info },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x35bc, 0x0101, 0xff, 0xff, 0xff),

base-commit: 292c0bc8acb687de7e83fc454bb98af19187b6bf
-- 
2.25.1


