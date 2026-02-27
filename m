Return-Path: <linux-wireless+bounces-32243-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAsMNicaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32243-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:14:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BFA1B28DE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CE23169AB5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B904345CA1;
	Fri, 27 Feb 2026 04:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="sT6LeXAh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE2346760
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165530; cv=none; b=NNRLrKCurX8QVQvHSX3tneEttQraWTCdm2Ta4yuLDVESdyI4RMfGpHLeyNQQliUKuM36Wovo4DY7Jxv3jloiNzGN2fhaXFzS3j9o5YB87658VR7gS8AxZgken7YC97MQeXIPslE+XKKQioUTYdv5cye6hNJNK1EbtStQAWDXN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165530; c=relaxed/simple;
	bh=AfFojZTD1Xr7koan/o3B8JJTER7itgnPO1Kc0nwJjYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu3fbXUTRVCh+bweaSMuKdgnhR+Av7FwZ28cUqipZOCV+DU/Dh1+55UyN9p078YCDEapWaOpTcOK/hcquMkwxU7vGadMmkQu07uThGB9cMeIat164TOZqUHv35bt9zST7bpL1GPEuFjpX6kli50VK21dXls5FemUU13QJfzZ4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=sT6LeXAh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aadc18f230so10449005ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165528; x=1772770328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lJyXPCVkDkCgM3QxVgeEIYgT0nrdocKVqL44vq3geA=;
        b=sT6LeXAhmkpr5wtmsTJ4b5Yl7hN52NO3PMlsf4WcVg+nWJOMP7Cexyh1oHUNdaDffq
         p9av+X9BkSHYMUDPj95B3aNb+wH5Uw66yZ9D9dT2IoWBhETdVN1HcgLxR0POE3t8D28x
         heHhrsWTbxflVje1nRnpS1UYlaOIytufiLVyzOBXmJU37Y/yLHWvh8A50V0rsCrkvzMQ
         sWmHIaRyZcu5jk80DU9KHD3MJwG1/k/9UoXu5Xcl8UCfzXKiSzwQrAITjKj/6YIq90Om
         QkFObq/qfehZ5AfFRR2Q7tYSs+MzlW/jkLozJ5ie11ti4JqLPkhYbnGX49RcjGUyMGbR
         esVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165528; x=1772770328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7lJyXPCVkDkCgM3QxVgeEIYgT0nrdocKVqL44vq3geA=;
        b=Ftyld1hFC6Wk33ugfhmoD+8nz/sSIvv8x5O960ARpJJXLTWjQFfICgwR95/5Zg6LdF
         rqr0RttAy2YWkjQYfekypmtX9+6N9BldySpJElQnPxYj1jsIoEfg5ORvxggVGFtT9EXe
         YaKdUUDqj34ULxFVzP1GgAr2OxdePmuR6WRSzSNXo3QUjZv9Gm4yOjqAID9YiQGsciOG
         2t/H6j8rPJBlumtTJI9LDO6WnfpJK3poS7QCU8Xg/5ObTpSI/oks7urLKZPZk+HYrTER
         VSoDYLydCEPRpg1qdMtSbcfIXwByUbSP88IgxC71lI57KbbbFcGESTI5z7BYf1aCaOpy
         CBHg==
X-Forwarded-Encrypted: i=1; AJvYcCWZPidEto+5Jv484ZJLB6tylPLJ6f4gAvGTXDvHDC4guG8J4vNTwQW3XhqUGMcSH7/v3oF72N/W2o2gD40K7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO+0m/aI0emEivGlIbb90MOB7b/PmxTiI7lCqt0F4AQOjSPV04
	QC2SYbLpA8BSViGXnr+Myd0yYziiv/Niz0Po1OwMeiLjyL05aiFNfFRmEItVCGYKr8Q=
X-Gm-Gg: ATEYQzwVwPxuJWuTW6zR2JC7H0d2QWKrktiP3m2JCkmfy7tJTzdvBKHlbdadnM9wcyI
	HuKc0W3qztlAotEJ5wy3wXy0Q9PCogTH6h8UpoI3c4YVEpOR57UU9xLsCnYER2lcYhQMMP2LIVE
	dSuWA9zdhfofWh09oiy03P/DHtdjZABK7UFEQKauV31E7ZPelXxxki7EpuHwYu7l7PjeaiFK3+4
	40E/rUFQr4b681YHz2/UA8tKCuBUgGpg0vNvLFO+gYAWqgd+LSApktIML9kJ/Kc5GLKiFOkAbm0
	GFo5bPr1snj0XA9vwYceWVJ98ozC/jFYDpVjBDXHyMEn4e8EYsncN2uavBlLmSK6/gOmJiVz8Rx
	rVae8CBBaeT7VRlaVuTyqHhfw8fOs5iSBlOCv3giNz8EoRWdyVstvJWgkRiwLA0/oKdRFbm22NP
	Mxvfd8wL8yXPWiUxYTvMhij0lHLT3GEDF1Q8QyFjGTRBV+98sq8WKoKVQJPZVn6IR7n9PfB4DsT
	jMFZatU+8ZVp5Ntpueu7bxzN/OwcZa1aHB8nBh4qQ==
X-Received: by 2002:a17:902:d54a:b0:2ad:bd4c:a0 with SMTP id d9443c01a7336-2ae2e4bba1fmr13947415ad.47.1772165528286;
        Thu, 26 Feb 2026 20:12:08 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:08 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 04/35] wifi: mm81x: add command.h
Date: Fri, 27 Feb 2026 15:10:14 +1100
Message-ID: <20260227041108.66508-5-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32243-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 85BFA1B28DE
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro/mm81x/command.h   | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/command.h b/drivers/net/wireless/morsemicro/mm81x/command.h
new file mode 100644
index 000000000000..67c4f6962e85
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/command.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_COMMAND_H_
+#define _MM81X_COMMAND_H_
+
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include "core.h"
+#include "command_defs.h"
+
+#define HOST_CMD_IS_REQ(cmd) (le16_to_cpu((cmd)->hdr.flags) & HOST_CMD_TYPE_REQ)
+#define HOST_CMD_IS_RESP(cmd) \
+	(le16_to_cpu((cmd)->hdr.flags) & HOST_CMD_TYPE_RESP)
+#define HOST_CMD_IS_EVT(cmd) (le16_to_cpu((cmd)->hdr.flags) & HOST_CMD_TYPE_EVT)
+
+struct mm81x_queue_params;
+
+enum mm81x_cmd_return_code {
+	MM81X_RET_SUCCESS = 0,
+	MM81X_RET_EPERM = -1,
+	MM81X_RET_ENOMEM = -12,
+	MM81X_RET_CMD_NOT_HANDLED = -32757,
+};
+
+#define HOST_CMD_HOST_ID_SEQ_MAX 0xFFF
+#define HOST_CMD_HOST_ID_RETRY_MASK 0x000F
+#define HOST_CMD_HOST_ID_SEQ_SHIFT 4
+#define HOST_CMD_HOST_ID_SEQ_MASK 0xFFF0
+
+struct host_cmd_req {
+	struct host_cmd_header hdr;
+	u8 data[];
+} __packed;
+
+struct host_cmd_resp {
+	struct host_cmd_header hdr;
+	__le32 status;
+	u8 data[];
+} __packed;
+
+struct host_cmd_event {
+	struct host_cmd_header hdr;
+	u8 data[];
+} __packed;
+
+int mm81x_cmd_resp_process(struct mm81x *mm, struct sk_buff *skb);
+int mm81x_cmd_add_if(struct mm81x *mm, u16 *vif_id, const u8 *addr,
+		     enum nl80211_iftype type);
+int mm81x_cmd_get_capabilities(struct mm81x *mm, u16 vif_id,
+			       struct mm81x_fw_caps *capabilities);
+int mm81x_cmd_cfg_qos(struct mm81x *mm, struct mm81x_queue_params *params);
+int mm81x_cmd_config_beacon_timer(struct mm81x *mm, void *mm81x_vif,
+				  bool enabled);
+int mm81x_cmd_cfg_bss(struct mm81x *mm, u16 vif_id, u16 beacon_int,
+		      u16 dtim_period, u32 cssid);
+int mm81x_cmd_set_channel(struct mm81x *mm, u32 op_chan_freq_hz,
+			  u8 pri_1mhz_chan_idx, u8 op_bw_mhz, u8 pri_bw_mhz,
+			  s32 *power_mbm);
+int mm81x_cmd_get_max_txpower(struct mm81x *mm, s32 *out_power_mbm);
+int mm81x_cmd_set_txpower(struct mm81x *mm, s32 *out_power_mbm,
+			  int txpower_mbm);
+int mm81x_cmd_hw_scan(struct mm81x *mm, struct mm81x_hw_scan_params *params,
+		      bool store);
+int mm81x_cmd_set_ps(struct mm81x *mm, bool enabled);
+int mm81x_cmd_cfg_multicast_filter(struct mm81x *mm, struct mm81x_vif *mm_vif);
+int mm81x_cmd_sta_state(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 aid,
+			struct ieee80211_sta *sta,
+			enum ieee80211_sta_state state);
+int mm81x_cmd_install_key(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 aid,
+			  struct ieee80211_key_conf *key,
+			  enum host_cmd_key_cipher cipher,
+			  enum host_cmd_aes_key_len length);
+int mm81x_cmd_disable_key(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 aid,
+			  struct ieee80211_key_conf *key);
+int mm81x_cmd_rm_if(struct mm81x *mm, u16 vif_id);
+int mm81x_cmd_set_frag_threshold(struct mm81x *mm, u32 frag_threshold);
+int mm81x_cmd_get_disabled_channels(
+	struct mm81x *mm, struct host_cmd_resp_get_disabled_channels *resp,
+	uint resp_len);
+
+#endif /* !_MM81X_COMMAND_H_ */
-- 
2.43.0


