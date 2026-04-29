Return-Path: <linux-wireless+bounces-35614-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDnKE5rz8WmElwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35614-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 14:03:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 613DA493D87
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 14:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF6CC300722C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70D3F0AA8;
	Wed, 29 Apr 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtDHKvPW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2C38F233
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777464176; cv=none; b=J8kqxLqyPHEEsCSKg+oXjqkQQtptVm3Yu8YSWkg5d+S/UE6W6CjWzPh8aJHRFaPR2b0ucuQx4MQOREADJXL8xwgdEWFnMwSUS3MKEiZODJU4e1tZ1TIGw6c3ofJF4aXIuL1qwEAk1rJJIv+DwY6CjbGo3PjuChV+v2NR7Vgq7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777464176; c=relaxed/simple;
	bh=Btt5AWL4J+pxEmZ5z3ArQwdwOTxwGaW3oW6AdEo6LPk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cM3FSLED8LWiBoOgHTg/Zg0N37uGhp9CRk+U23dTECUZfchtqGXs8pALRd/ibmSY0cZQdjYmWZebB4eLB2AMZ0zoCmzoGPEyN91pTHnVYOzfkWg2Har316PPEsBf1JREDwPaz94cGy2wDe8mKMIaARbgJdSiyVqE0m6d052Tkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtDHKvPW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48896199cbaso123010095e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777464171; x=1778068971; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNYEHzIbNwkk5VUjtPZI7CbKKl29OrD5tx8EXZGFXkI=;
        b=JtDHKvPWDp13lkHifaa5PUeDtv6vnOLX79UMwa2qlluKR9x3b8RXCmT9PAt9KRnb3O
         naqe2QT+DDrJl2jR+Oi+2LnrdgzxlkvvtWwodQu60ep00Aluo8JRaAjS1JNuWhJNsOXA
         l99Z0Nezt9E8IlBEP0NtJagl7WCO4Ox33q0RL7fzbXKeL2FMi0pX64mxT9iK01TFzpKP
         yqZ+kKFP183j/dBh/TtXGWT8vsLyc5qbzvo8Z5YVhAJ0aQmtsmjnXUVYsNzHUgvBh8uw
         zqyMMCHuxUE5pCgi58y0VjucSPlI8/mmTjnLF+iU4nYkmQVJJ58/+iU3AyNFOuA6PeyZ
         mgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777464171; x=1778068971;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNYEHzIbNwkk5VUjtPZI7CbKKl29OrD5tx8EXZGFXkI=;
        b=lCMbSRHcupmGHsBsJkJxjM1UbF0ijOYAy6MLcpJxqzzeNd/MFROZxkbXjKtIMzqfDr
         h13Tye8tkBNTwtZhD0JpoY1s/P612BBdRKkmgBdUafjk4PWKJa/EN4OfYgC13ATpi7X9
         VLlAS8wY9zwiFtTH3CDvLyYtnkQTJjVjHbqY4cz/mu2ChqyLaLVs78TesJQhMdqQK5H5
         Jh+hc//FXmXh78DERD3tNwWzAHXLkpm3TcVxPJEjQjWU4zCFovFMcB4zDUkSlt8Sccz3
         Kkx0gKaSRlOqfkQP5cP21e9UUj34zxSGzHN9jFoNZNorOgPGNPuc66e45uxaQfajAvQH
         DQuQ==
X-Gm-Message-State: AOJu0Yyfhr55JM9RdCArF42iQcXuKz60VKd8LdtGcG4Dc0YUQWq4PvHq
	6Mqe+owZyUSePA54svA5d1BeGwcjijP7ojM3B/VP80XFoGYFa6K7AmICCjxQYQ==
X-Gm-Gg: AeBDieu0t+lbyCx/8DpvTvYBb14Oz34d3vCr7jp/Fnhu2GZJxNG72r4Ec+La7xlgs8C
	i7cHzcU3yjhGwJffemYiGZyjZLLwPv+deOaxLPXMe7YnlGSg3CaS+t3bpuHYHrpBGgokp3N/qiq
	2FyTUhFTf2DLMA6WPv9x0Lfhj7/EILv33l6FwD7P08dk2G+BJg+7hNlyn2koJcpjZSfpH0cAaJA
	ThnGSmCJp1qspV06i5+3zNzDhXu6GxOQbbUk5BE5kgviAYQ1ptHtgpyLoFciXcn7ZA1LAwW9o7q
	o3g6+87tyaG4ypgJd4p/o/X4+6w5k6oJReczu3FMC/V5fKwqxfVssmSNtgYazIRplOdOofmboPd
	gDZB/a0gNqbFlC9s76dt2/QKkK6xA8FNLAjAPQ1JuhhXXIfo6gVzqd+hcili7VrfmWBdpTjprGY
	c3zmWLt5E4c1Cynhp2hZ/Qh5c0Vq4xxIO+6GRd/ahZwHTkCx12wII=
X-Received: by 2002:a05:600c:6209:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-48a7ada0423mr84813255e9.3.1777464171040;
        Wed, 29 Apr 2026 05:02:51 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc1cbf3sm55211925e9.5.2026.04.29.05.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 05:02:50 -0700 (PDT)
Message-ID: <c57de68e-5d57-4c26-898f-8a284bb25381@gmail.com>
Date: Wed, 29 Apr 2026 15:02:48 +0300
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
Subject: [PATCH rtw-next v2] wifi: rtl8xxxu: Detect the maximum supported
 channel width
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 613DA493D87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35614-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,proton.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Rebase on top of rtw-next.
 - Add Reviewed-by.
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
index 766a7a7c7d28..fea5aec9ced9 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -1866,6 +1866,7 @@ struct rtl8xxxu_fileops rtl8188eu_fops = {
 	.has_tx_report = 1,
 	.init_reg_pkt_life_time = 1,
 	.gen2_thermal_meter = 1,
+	.hw_feature_report = 0,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
index 3abf14d7044f..5556aad1a7ad 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
@@ -1745,6 +1745,7 @@ struct rtl8xxxu_fileops rtl8188fu_fops = {
 	.init_reg_rxfltmap = 1,
 	.init_reg_pkt_life_time = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 1,
 	.ampdu_max_time = 0x70,
 	.ustime_tsf_edca = 0x28,
 	.max_aggr_num = 0x0c14,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index 444872131c66..508322a8f310 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -723,6 +723,7 @@ struct rtl8xxxu_fileops rtl8192cu_fops = {
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
 	.supports_ap = 1,
+	.hw_feature_report = 0,
 	.max_macid_num = 32,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
index 8e123bbfc665..690ace303150 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
@@ -1751,6 +1751,7 @@ struct rtl8xxxu_fileops rtl8192eu_fops = {
 	.has_s0s1 = 0,
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
+	.hw_feature_report = 0,
 	.supports_ap = 1,
 	.max_macid_num = 128,
 	.max_sec_cam_num = 64,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
index cd2156b7a57a..5f076da4b550 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
@@ -2074,6 +2074,7 @@ struct rtl8xxxu_fileops rtl8192fu_fops = {
 	.init_reg_rxfltmap = 1,
 	.init_reg_pkt_life_time = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 1,
 	.ampdu_max_time = 0x5e,
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x1f1f,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
index 11c63c320eae..a87e692bfc81 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
@@ -1852,6 +1852,7 @@ struct rtl8xxxu_fileops rtl8710bu_fops = {
 	.init_reg_rxfltmap = 1,
 	.init_reg_pkt_life_time = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 0, /* TODO, it's different */
 	.ampdu_max_time = 0x5e,
 	/*
 	 * The RTL8710BU vendor driver uses 0x50 here and it works fine,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
index 4f4493d0bfc2..18e038b82f49 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
@@ -632,6 +632,7 @@ struct rtl8xxxu_fileops rtl8723au_fops = {
 	.rx_agg_buf_size = 16000,
 	.tx_desc_size = sizeof(struct rtl8xxxu_txdesc32),
 	.rx_desc_size = sizeof(struct rtl8xxxu_rxdesc16),
+	.hw_feature_report = 0,
 	.max_sec_cam_num = 32,
 	.adda_1t_init = 0x0b1b25a0,
 	.adda_1t_path_on = 0x0bdb25a0,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
index cc2e60b06f64..e314ef991b38 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
@@ -1746,6 +1746,7 @@ struct rtl8xxxu_fileops rtl8723bu_fops = {
 	.gen2_thermal_meter = 1,
 	.needs_full_init = 1,
 	.init_reg_hmtfr = 1,
+	.hw_feature_report = 0,
 	.ampdu_max_time = 0x5e,
 	.ustime_tsf_edca = 0x50,
 	.max_aggr_num = 0x0c14,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 508137e4a87a..646fe76b086e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/iopoll.h>
 #include "regs.h"
 #include "rtl8xxxu.h"
 
@@ -3915,6 +3916,46 @@ static inline u8 rtl8xxxu_get_macid(struct rtl8xxxu_priv *priv,
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
@@ -3961,6 +4002,8 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	 */
 	rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);
 
+	rtl8xxxu_request_hw_feature(priv);
+
 	for (int retry = 5; retry >= 0 ; retry--) {
 		ret = rtl8xxxu_download_firmware(priv);
 		dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
@@ -3976,6 +4019,12 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
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
 
@@ -7844,15 +7893,20 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
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
index 9fb2583ffffc..eeb18eb0e4c0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1789,11 +1789,17 @@ struct rtl8xxxu_cfo_tracking {
 #define RTL8XXXU_BC_MC_MACID1	1
 #define RTL8XXXU_MAX_SEC_CAM_NUM	64
 
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
@@ -2009,6 +2015,7 @@ struct rtl8xxxu_fileops {
 	u8 init_reg_pkt_life_time:1;
 	u8 init_reg_hmtfr:1;
 	u8 supports_concurrent:1;
+	u8 hw_feature_report:1;
 	u8 ampdu_max_time;
 	u8 ustime_tsf_edca;
 	u16 max_aggr_num;
-- 
2.53.0


