Return-Path: <linux-wireless+bounces-35296-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE6EBkkY7WkKfQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35296-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:38:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC24678BC
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 21:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA6CC300462E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8154CB5B;
	Sat, 25 Apr 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrbQH6pH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695AD1C01
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777145926; cv=none; b=e74Md3Vi8048dzLc8h+u8iwyQMyHyeG+5thFuyrKd5hPlCZh5dOYzWckEBSMO++py1NcKKFBcTf98EqLljXw0n8zk1pbrObv/h47ujTZqkqrozrITAkVrVHLGlW4UVqnKzaMLuecRgeYYtd3U8Df6VNAzn91kHT/pCabr8HxN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777145926; c=relaxed/simple;
	bh=JBrXGC28Je23WkfEiYwvh3zt6q8iKv5/pIu4f3Mqi8o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jpkNPZDjhjpwJ0v2dNm+rkxJsCsjZfgbI7ifGcQ3UeAF/kCm6tEWomgLHbPUNvKgw1j6XIl6vQGVQwhXla5SwlT1uA8JRRGwtWk2dTNQvFdvLvH/+3RZiNCet10g+eq7hnxEMCWo3Rc0xm9k/OoziegkbX2qodPGRZEceXz1gVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrbQH6pH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so82497755e9.0
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777145923; x=1777750723; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0//BxmX34FX+vQqy1Jl47xwelXWYMP6jw+RpriRlIpQ=;
        b=QrbQH6pHlnS5/KapvaiIJ4vqiPh/Ltt8tvfyTZ7xE37EnI4lsubKZ0j5RPFu4de9ni
         NQ24l5OpREGMmWakLiE4OjE4MRP3YcQp0+WmQBASAk40pjnZwlwvM+O/bbjUhXDaIUCP
         K/nVsZiq5QC5uLPaISV8FsylAt6Umq7Pwe6PbrKRGvKva3iwys/cpHMlKgLM1j+ZztgF
         H9Pdr47ROljgdeU+jC/dOk7/HUpyfQ2JrsEB8mJX/2umRUpa7nKx1Sjmel3gDY5Rd25+
         1Aw5tF5OwhrcVdSieTIOvuOqm+sVYhG+HVUOp05M2mBQpvz7mgrex3LbudxsHLm0nWGf
         wPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777145923; x=1777750723;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0//BxmX34FX+vQqy1Jl47xwelXWYMP6jw+RpriRlIpQ=;
        b=tIupom3szj8gh8jMZAR+jN4FKiym9QwMbWWmvJv02FMG75i1NOReFSykGvq5xdxGpZ
         CVUtkVxJeHy2ydeQtdwZBQuxp3fktwVTiVYoPqfux+uRRleXqQx3Pug8CAbiG5KYvUvF
         uiiPKoLziyFGImhTO1P4wpREVu1e/laYZKTs2u+bVzd2wEY68yY7s6iOf2DsAgf0536F
         bMtkMYfuHKCRgaWjlanTYevqZi91RW6x3muDExQ195mjsEJgnfdcW9YOnU7Bwo+lrn51
         7KZcbVzysFnLgAiMBqnYDMxkrdibDrVThHsy71b27L+MQFhj7W4SDwz6NBDQpffqQyFv
         mo7A==
X-Gm-Message-State: AOJu0YzjXyHkJX50npvOEY9fFUwOdJIL1bfalJ40kGurRvb0BqMCygc+
	uZyalCbMZxCXp2c4PV8YvJ12IUNfRCOExx/DHzK83iMdDjySitW5gpvP7t5x1Q==
X-Gm-Gg: AeBDiesW/tAcew2Gae+JU/7EcgFRAT7bhnZlF09A4WU4FIH7tGxqe6vJkDW5GPJ1i3S
	bXix7rBXjmZlg0sCMXsvUp/h9+8AhjwQNK8FiQmAi3H9v7spZHV3EixSl1L/84woTiMpl7ZAQgZ
	cA1m4s5u8puetyFMP2RSJLg7Xkl1/BVnHPryicDZpti3NZIZoMHteDpfuFRBJMI97tm92olFyGd
	l+4NTXlPKXQBv1Vm8+xFYrE0CjEvk/zXMVSRS2lV6QXOVRPtdBbFA1y0QUrUQR1DNxGws3dSSvA
	B6ZKQQOmB05sMqbw7ALCSUo88F1T29xT6i/4CTUgqFiv0A+Oyuxfp4jHNWyBV42HKQsJN2QFWIx
	PhWqDZ7TkTp0iHtqeQo56QLqWZiasWRgGGOhAnahaveneta9T32h/ucAFuk/tVulrignMPZ4BLw
	LMtS1fn8RbgbLtt4D3baTKhQk0RCzd9aipEDs6oBwGV8W3cwUTzNI=
X-Received: by 2002:a05:600c:3110:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-488fb739ce4mr509648355e9.4.1777145922705;
        Sat, 25 Apr 2026 12:38:42 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc10777csm765204525e9.8.2026.04.25.12.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 12:38:41 -0700 (PDT)
Message-ID: <092f18cd-f3a6-4e3b-b0de-1cb23615e86b@gmail.com>
Date: Sat, 25 Apr 2026 22:38:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 art1310@proton.me
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next] wifi: rtl8xxxu: Detect the maximum supported channel
 width
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 68FC24678BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35296-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,proton.me];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]

Some devices malfunction when connected to a network with 40 MHz channel
width, because they don't support that.

RTL8188FU, RTL8192FU, and RTL8710BU (RTL8188GU) have a way to signal
this (and some other capabilities) to the driver. Get this information
from the hardware and advertise 40 MHz support only when the hardware
can handle it. We assume the other chips can always handle it.

RTL8710BU needs a different way to retrieve this information, which will
be implemented some other time.

Fixes: dbf9b7bb0edf ("wifi: rtl8xxxu: Enable 40 MHz width by default")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221394
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192f.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8710b.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c |  1 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c  | 64 +++++++++++++++++--
 drivers/net/wireless/realtek/rtl8xxxu/regs.h  |  2 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  7 ++
 11 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
index 93f11ea26b90..3f3fe5b1d486 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1867,6 +1867,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.has_tx_report = 1,
 	.init_reg_pkt_life_time = 1,
 	.gen2_thermal_meter = 1,
+	.hw_feature_report = 0,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
index 13a6d9b22edb..4aac2a598ba7 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
@@ -1746,6 +1746,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.init_reg_rxfltmap = 1,
 	.init_reg_pkt_life_time = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 1,
 	.ampdu_max_time = 0x70,
 	.ustime_tsf_edca = 0x28,
 	.max_aggr_num = 0x0c14,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index cbf72fa317d3..56657051c82e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -724,6 +724,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.supports_ap = 1,
+	.hw_feature_report = 0,
 	.max_macid_num = 32,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
index bc2c5c07c4de..6e6ccd23660c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
@@ -1752,6 +1752,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
+	.hw_feature_report = 0,
 	.supports_ap = 1,
 	.max_macid_num = 128,
 	.max_sec_cam_num = 64,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
index 94cb5809bed0..57c902f2c2de 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
@@ -2075,6 +2075,7 @@ struct rtl8xxxu_fileops rtl8192fu_fops = {
 	.init_reg_rxfltmap = 1,
 	.init_reg_pkt_life_time = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 1,
 	.ampdu_max_time = 0x5e,
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x1f1f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
index 5bf04ea82f6f..43804677349e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
@@ -1853,6 +1853,7 @@ struct rtl8xxxu_fileops rtl8710bu_fops = {
 	.init_reg_rxfltmap = 1,
 	.init_reg_pkt_life_time = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 0, /* TODO, it's different */
 	.ampdu_max_time = 0x5e,
 	/*
 	 * The RTL8710BU vendor driver uses 0x50 here and it works fine,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
index 303f89395952..621703d8ae2d 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
@@ -633,6 +633,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.hw_feature_report = 0,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
index bb747420ff7e..52b0e90338ef 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
@@ -1747,6 +1747,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 0,
 	.ampdu_max_time = 0x5e,
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x0c14,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 2c56d7df92a7..506633b3b51c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/iopoll.h>
 #include "regs.h"
 #include "rtl8xxxu.h"
 
@@ -3936,6 +3937,46 @@ static inline u8 rtl8xxxu_get_macid(struct rtl8xxxu_priv *priv,
 	return sta_info->macid;
 }
 
+static void rtl8xxxu_request_hw_feature(struct rtl8xxxu_priv *priv)
+{
+	if (!priv->fops->hw_feature_report)
+		return;
+
+	rtl8xxxu_write8(priv, REG_C2HEVT_MSG_NORMAL, C2H_HW_FEATURE_DUMP);
+}
+
+static int rtl8xxxu_dump_hw_feature(struct rtl8xxxu_priv *priv)
+{
+	static const u8 bw_map[8] = { 0, 0, 160, 5, 10, 20, 40, 80 };
+	struct rtl8xxxu_hw_feature *hw_feature = &priv->hw_feature;
+	u8 feature[13];
+	int i, ret;
+	u8 id, bw;
+
+	if (!priv->fops->hw_feature_report) {
+		hw_feature->max_bw = 40;
+		return 0;
+	}
+
+	ret = read_poll_timeout(rtl8xxxu_read8, id,
+				id == C2H_HW_FEATURE_REPORT,
+				10000, 800000, false,
+				priv, REG_C2HEVT_MSG_NORMAL);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(feature); i++)
+		feature[i] = rtl8xxxu_read8(priv, REG_C2HEVT_MSG_NORMAL + 2 + i);
+
+	rtl8xxxu_write8(priv, REG_C2HEVT_MSG_NORMAL, 0);
+
+	bw = u8_get_bits(feature[6], GENMASK(2, 0));
+
+	hw_feature->max_bw = bw_map[bw];
+
+	return 0;
+}
+
 static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
@@ -3982,6 +4023,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	 */
 	rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);
 
+	rtl8xxxu_request_hw_feature(priv);
+
 	for (int retry = 5; retry >= 0 ; retry--) {
 		ret = rtl8xxxu_download_firmware(priv);
 		dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
@@ -3997,6 +4040,12 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	if (ret)
 		goto exit;
 
+	ret = rtl8xxxu_dump_hw_feature(priv);
+	if (ret) {
+		dev_err(dev, "failed to dump hw feature\n");
+		goto exit;
+	}
+
 	if (fops->phy_init_antenna_selection)
 		fops->phy_init_antenna_selection(priv);
 
@@ -7876,15 +7925,20 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	sband->ht_cap.ht_supported = true;
 	sband->ht_cap.ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	sband->ht_cap.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
-	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20 | IEEE80211_HT_CAP_SGI_40 |
-			    IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+	sband->ht_cap.cap = IEEE80211_HT_CAP_SGI_20;
+
+	if (priv->hw_feature.max_bw >= 40) {
+		sband->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
+		sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
+	} else {
+		dev_info(&udev->dev, "hardware doesn't support HT40\n");
+	}
+
 	memset(&sband->ht_cap.mcs, 0, sizeof(sband->ht_cap.mcs));
 	sband->ht_cap.mcs.rx_mask[0] = 0xff;
 	sband->ht_cap.mcs.rx_mask[4] = 0x01;
-	if (priv->rf_paths > 1) {
+	if (priv->rf_paths > 1)
 		sband->ht_cap.mcs.rx_mask[1] = 0xff;
-		sband->ht_cap.cap |= IEEE80211_HT_CAP_SGI_40;
-	}
 	sband->ht_cap.mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = sband;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/regs.h b/drivers/net/wireless/realtek/rtl8xxxu/regs.h
index 0741db8d08bf..eafaef1438b9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/regs.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/regs.h
@@ -447,6 +447,8 @@
 /* 8188EU */
 #define REG_32K_CTRL			0x0194
 #define REG_C2HEVT_MSG_NORMAL		0x01a0
+#define C2H_HW_FEATURE_REPORT		0x19
+#define C2H_HW_FEATURE_DUMP		0xfd
 /* 8192EU/8723BU/8812 */
 #define REG_C2HEVT_CMD_ID_8723B		0x01ae
 #define REG_C2HEVT_CLEAR		0x01af
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 188f4bbe99cd..b667e5d413ac 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1790,11 +1790,17 @@ struct rtl8xxxu_cfo_tracking {
 #define RTL8XXXU_MAX_SEC_CAM_NUM	64
 #define RTL8XXXU_SEC_DEFAULT_KEY_NUM	4
 
+struct rtl8xxxu_hw_feature {
+	u8 max_bw;
+};
+
 struct rtl8xxxu_priv {
 	struct ieee80211_hw *hw;
 	struct usb_device *udev;
 	struct rtl8xxxu_fileops *fops;
 
+	struct rtl8xxxu_hw_feature hw_feature;
+
 	spinlock_t tx_urb_lock;
 	struct list_head tx_urb_free_list;
 	int tx_urb_free_count;
@@ -2011,6 +2017,7 @@ struct rtl8xxxu_fileops {
 	u8 init_reg_pkt_life_time:1;
 	u8 init_reg_hmtfr:1;
 	u8 supports_concurrent:1;
+	u8 hw_feature_report:1;
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
 	u16 max_aggr_num;
-- 
2.53.0


