Return-Path: <linux-wireless+bounces-33763-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBqHDX8uwml5ZwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33763-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:26:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31834302DEB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 07:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 606CD303D0E7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23123A380F;
	Tue, 24 Mar 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KichJrf8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A28280309
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774333311; cv=none; b=Y2EIYMu8KqUP32P1cs7bLYd0x/HXho2/LoGShaN+hY164MmjmhYITBdhRQR+FbmRmum82nikfZ42WiBwdeZw/ioVLzUrBCCRPkiLJVVB8Z7pO5+L5plAApsYOAa9/msgJePVNEwplDlhl8k98CIcVovPLigGA5Vp3C/u/9RV1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774333311; c=relaxed/simple;
	bh=zT9ckByibOTrlTzjnWBNx3cPdait9pVeRxPxPaYiFM4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMaRyW/ER/m2qhi1bfeoUGLm4zMNw2EJ3d6W0B6m4S4Z2dlIjfNAeb99kgq9sR6DNCeXvwyhqxzjjLHU6SzgyFI/oHSqVuZueVn85/7shXatQCCU05Q/g+lrqOCDPmuMffm9kQUxvNvQc6ElnkSMvcXPeGNUTh+nUjH8NNq23+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KichJrf8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62O6LlvgE557375, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774333307; bh=hIyiXnD3qsKt5RAbEY0cpDqpOMf+3nSU9SCoDs2RCcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KichJrf8tQnzUCwBBlw/BLglHmVc/4wOlQBrKqWZ0vXOoIYBnAi6efk3DNR58T+v6
	 5pzLwqH+6DduR6/HNjxtPWx2BglImW1hAnpD8FGUFksf+dWO8WG99Bl7iNIP61GXFZ
	 RWqhqwFLyoUr+5Wv1MjAi+2YCRwJn/rjDdBXVULQLLtYVDWCqcBN9ib1J9a8lt0qib
	 LeQA6SvA5964JUuW7sH21MwPrCvLP4WgGO3d5PkJO58fiTuAr9RdMjT1+YbpmfNm6m
	 X80ZoOrRyhR8GAuLwD3P8Ms9RQSCmfInnRhsCRI+nW3Dnt/58IXt0gnW8NvG298X7h
	 tSFQ537JZRUYg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62O6LlvgE557375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 14:21:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:21:48 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 24 Mar 2026 14:21:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 14:21:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 rtw-next 7/7] wifi: rtw89: 8922d: add set channel of RF part
Date: Tue, 24 Mar 2026 14:20:49 +0800
Message-ID: <20260324062049.52266-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260324062049.52266-1-pkshih@realtek.com>
References: <20260324062049.52266-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33763-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:email,realtek.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 31834302DEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The set channel of RF part is to configure channel and bandwidth on a
register. The function to encode channel and bandwidth into register
value will be implemented by coming patch.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c | 33 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h | 14 ++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index cae92e2abd85..1b5fc6c9ea85 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -8,6 +8,7 @@
 #include "phy.h"
 #include "reg.h"
 #include "rtw8922d.h"
+#include "rtw8922d_rfk.h"
 #include "util.h"
 
 #define RTW8922D_FW_FORMAT_MAX 0
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
new file mode 100644
index 000000000000..6b35d196cb81
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2026  Realtek Corporation
+ */
+
+#include "phy.h"
+#include "reg.h"
+#include "rtw8922d.h"
+#include "rtw8922d_rfk.h"
+
+static
+void rtw8922d_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     const struct rtw89_chan *chan)
+{
+	u8 synpath;
+	u32 rf18;
+
+	synpath = rtw89_phy_get_syn_sel(rtwdev, phy);
+	rf18 = rtw89_chip_chan_to_rf18_val(rtwdev, chan);
+
+	rtw89_write_rf(rtwdev, synpath, RR_RSV1, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, synpath, RR_MOD, RFREG_MASK, 0x30000);
+	rtw89_write_rf(rtwdev, synpath, RR_CFGCH, RFREG_MASK, rf18);
+	fsleep(400);
+	rtw89_write_rf(rtwdev, synpath, RR_RSV1, RFREG_MASK, 0x1);
+	rtw89_write_rf(rtwdev, synpath, RR_CFGCH_V1, RFREG_MASK, rf18);
+}
+
+void rtw8922d_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	rtw8922d_ctl_band_ch_bw(rtwdev, phy_idx, chan);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
new file mode 100644
index 000000000000..03af1f0497ac
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2026  Realtek Corporation
+ */
+
+#ifndef __RTW89_8922D_RFK_H__
+#define __RTW89_8922D_RFK_H__
+
+#include "core.h"
+
+void rtw8922d_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx);
+
+#endif
-- 
2.25.1


