Return-Path: <linux-wireless+bounces-33679-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCpwHAGzwGm5KAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33679-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:26:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E37992EC337
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 04:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2B5930062FF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 03:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64F4202C5C;
	Mon, 23 Mar 2026 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jYlsbLN6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C91514F8
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774236414; cv=none; b=pJIs9l3ru6m1WltdY3zuqIggdoke9JZkE7DaYqJPdUF6tz4sCHOJ0WzQZ9t5vgnO0EJL7gS6LKBaCburOcJ8G/lgH/qbfd+GYfFOJAQnB41NqiIZpXp4U+QH0834sv/9IKmduiee5yVPFy2wj6RL0ZYKvNG0KmNW/VeLGpI58ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774236414; c=relaxed/simple;
	bh=sNHFVVYYtjcvX0N3phMz0d2RTJDR90YFDB7bazXpBaY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mO+ksfme3ahm4bVfjIIfy5svMZc/VMzJr8U6eY54usIPeNngpr/XNVGApxRvK7yiUwVe0fLf3cUnSP2WtrHtAmXsifden5boCLN83BmRUZJ1HFsXpXUMGshGOGSMYhoGRIoNXgnw+DUhZrjZ2hkhKdxp+LgaxSv7IcBn6oqqUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jYlsbLN6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N3Qo7N22376727, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774236410; bh=RFGqjeC/NiDOiasU+zOcoLai03Jc9WEcmiUWCkSvY8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jYlsbLN65cSwPQBF0fsAXHMwbnU3+oWhC3xVwycIhUAqIR3Gpm/rif1BWR0R8e5yL
	 yUSPBAcJh+npYpJuuwomzGq1d5Kll6rwfJ7qQLsa+/5g6N/uqnNDwYouuaXb+S3Lun
	 LiIfQ+rJL5DqJTHvyoPkDSmDJIo804AJ98WOporKsVwfg7ihu72gFDnRp27jIypHFw
	 /IdgL9NbuXn8qJW/gP+26+yhSIAmN7x7AvU7QLtLy1QeeJrIuJee/3Hba33dhOs5IW
	 y7/bdNcK1OIQfWu0D5L/FllI+NT04b8LYe+CQO2aaxMwezU3aJuo6YLtVtx5JGce2A
	 2IwAy4Y/WkasA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N3Qo7N22376727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 11:26:50 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 11:26:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 11:26:51 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 11:26:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 7/7] wifi: rtw89: 8922d: add set channel of RF part
Date: Mon, 23 Mar 2026 11:25:56 +0800
Message-ID: <20260323032556.19825-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260323032556.19825-1-pkshih@realtek.com>
References: <20260323032556.19825-1-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33679-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E37992EC337
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The set channel of RF part is to configure channel and bandwidth on a
register. The function to encode channel and bandwidth into register
value will be implemented by coming patch.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c | 33 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h | 14 ++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index f6b36b90dec8..137e98b8883e 100644
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


