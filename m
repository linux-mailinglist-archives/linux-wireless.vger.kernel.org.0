Return-Path: <linux-wireless+bounces-38117-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pn+bBhQdPmrl/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38117-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:32:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 886086CAA77
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:32:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=BYWaTcNn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38117-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38117-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C62430B12B5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C243DB623;
	Fri, 26 Jun 2026 06:31:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B33DB32A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:31:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455472; cv=none; b=ANhXUDmx4UObC5bWTRUT3viPskvHX7haeN6H9hQDD50qoj4qIYRrMX0tuAMKZpuYq7KeX9zXR3knvl+K/30skrwNdvKYbTHh6svmAtaMCsBzoo384jDCYBunP7nDIyWcn28t4d2BMn/u5Qg9CxgiTYvvFSLOFaQK4fSBvX5RiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455472; c=relaxed/simple;
	bh=nBfV/O8Xfi0M3Ncbgd71FULLiDKcosN9UVkG7dh0bt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myrR8nADU94k3oc2U+SpqiE251Xob7n5fRYM4/pBz41rJEnFZ5LwtOYKSnvIMiJP7sMnoHaDIyt37WdsN4zJFy/pB0ouJiHbeRkFYvZXiBgm0ARwQC6FiReTKlhYkpZ/tUR3oC/gHgJX8yC41oo92AMiZHhRO8UsjbVr9VVFHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=BYWaTcNn; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139b914bab6so963128c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455469; x=1783060269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsJuVc8APNdt6FnYDE9gJ8ybo7oZZfDLotB1bM9RCHk=;
        b=BYWaTcNn3yzwXfohDYv6LUc5q9hgmK0lwiKPekd3EyGjmu6d6cCWYErTfdrFolWWlg
         L/2C5dU37xYmSlb10UtX2q/U0zvbaAgDEHyaYcpGv+1nmvy98GdsCQAwWG6XMhMgIHT8
         Hh4BhGNmZ+YbyLoT1Mqeg6Z65Vd6YrRk6SiI5oRP4l1/kyeLdwObCalaCVQid+2b6fvD
         T2rIZOOA1vhbfPwBSNeRIKpVdvSdG2M/rSU3NyjP8vyIBjCNcAfRnoNydomD8IywXnkt
         5Lrw8b5OZrDedPm7RIkxRXbLAwzsyZ1/aGd3YXtDF+gijeVmDgsK07SnRCxSAqw1TaYM
         chUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455469; x=1783060269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YsJuVc8APNdt6FnYDE9gJ8ybo7oZZfDLotB1bM9RCHk=;
        b=HvGjWawDrEvcSa9lUdoPoH6IdPiWQfKRu0pSlGaeRoN2ZCmiURHMSFFEeLtb8z0DB8
         BInVPQhAZpvvPmy7l8aTTsrSY5SShKaN0LGnvTC+rFJS/JoM/Epz8GRZvjZKruPSea7B
         3lKVA48m5tfUG7fQlG3WXcwaILX76LyF0FVRyzhAWgj6CoGUbwhbzdBL+gdp0g/QhXD1
         wPU54VpEUUFgJ/5E9Ome9/cB512SkWY29oZ5EZLmgXC6a/fkUftCsw1mgOR9HmfI6Q5F
         qO5LkEKXjDS3Y6vBjYjpxwuo/sIWYE2HCz+IxPxs99s/+oNGgVyJ8CcPCgoMQNyjCMIV
         ipnA==
X-Forwarded-Encrypted: i=1; AFNElJ9zlEd5idNqzPOQUv46FCGEK1Y68m4FD1ItHAzZ4Ye360gyNUVKRX1k55LVOOWaibID1RmVBuVzFnzSVageSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU44kkdQdQqufXzuHg8xoua4byzuCjsZ28/uUqEfhwH7pVZwEK
	/gCTn4MNizhZw11N4xBl3L2jkm7+O1dQLoLzBKO6z63HRkGguXKzyr3yLl2G0YRf6RY=
X-Gm-Gg: AfdE7cm5rceeAIT3zZMxB0Wfz2/X0waYFFX86ePyYVWQAL186kZjvhfQTCDmpO+ayae
	F/omwrZIUi4/MKa3hyKrSV2M3vRH5z9aMrEU5ivLie/U5roIJCbrqXV8qUfYh1hACIgRYU1rTCO
	/HR1e09H+nsAOub6199+t8Zxqk1PEMAmmSG+igFNGb5lR/TEdZb7nnlPanadsBml8b98CvUeYPY
	ZcwvI2bhTTezjkBEHPtKa0N9BdPf/g4MS2hqM46btzS8Neg9HIX/uNEB1OtyYxMa7YGRJGaiZce
	9tnZ6AgnJ9N2PcrIHIibLW/ML+sTuaT/cZngf1LjdOyEle3VSK0eW1P9OwFez+JyR1l/d5RiP7V
	NoHWXSHhe8nPJIf8q1TJwl0j4HwhxuKZUzHuoM8bA74Nk2kcnDXrKSuYOP7DjoxxbTDunytMN7P
	yrZdzhdoiT6R7THxwf9hOjegyvWMDuABIimfGHyCnMOu9k8QuTk0GKyvLPjFe6N6reShoZfFXdo
	rBTMv/IAGja9ClcddH8ZQXse75WVY8=
X-Received: by 2002:a05:7022:ff47:b0:139:ceca:20c5 with SMTP id a92af1059eb24-139dbb90706mr4617763c88.19.1782455468958;
        Thu, 25 Jun 2026 23:31:08 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:31:08 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 06/33] wifi: mm81x: add command.h
Date: Fri, 26 Jun 2026 16:29:02 +1000
Message-ID: <20260626063014.1275235-7-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38117-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 886086CAA77

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro/mm81x/command.h   | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/command.h b/drivers/net/wireless/morsemicro/mm81x/command.h
new file mode 100644
index 000000000000..0ea796f1d878
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/command.h
@@ -0,0 +1,85 @@
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
+int mm81x_cmd_resp_process(struct mm81x *mors, struct sk_buff *skb);
+int mm81x_cmd_add_if(struct mm81x *mors, u16 *vif_id, const u8 *addr,
+		     enum nl80211_iftype type);
+int mm81x_cmd_get_capabilities(struct mm81x *mors, u16 vif_id,
+			       struct mm81x_fw_caps *capabilities);
+int mm81x_cmd_cfg_qos(struct mm81x *mors, struct mm81x_queue_params *params);
+int mm81x_cmd_config_beacon_timer(struct mm81x *mors, void *mm81x_vif,
+				  bool enabled);
+int mm81x_cmd_cfg_bss(struct mm81x *mors, u16 vif_id, u16 beacon_int,
+		      u16 dtim_period, u32 cssid);
+int mm81x_cmd_set_channel(struct mm81x *mors, u32 op_chan_freq_hz,
+			  u8 pri_1mhz_chan_idx, u8 op_bw_mhz, u8 pri_bw_mhz,
+			  s32 *power_mbm);
+int mm81x_cmd_get_max_txpower(struct mm81x *mors, s32 *out_power_mbm);
+int mm81x_cmd_set_txpower(struct mm81x *mors, s32 *out_power_mbm,
+			  int txpower_mbm);
+int mm81x_cmd_hw_scan(struct mm81x *mors, struct mm81x_hw_scan_params *params,
+		      bool store);
+int mm81x_cmd_set_ps(struct mm81x *mors, bool enabled);
+int mm81x_cmd_cfg_multicast_filter(struct mm81x *mors,
+				   struct mm81x_vif *mors_vif);
+int mm81x_cmd_sta_state(struct mm81x *mors, struct mm81x_vif *mors_vif, u16 aid,
+			struct ieee80211_sta *sta,
+			enum ieee80211_sta_state state);
+int mm81x_cmd_install_key(struct mm81x *mors, struct mm81x_vif *mors_vif,
+			  u16 aid, struct ieee80211_key_conf *key,
+			  enum host_cmd_key_cipher cipher,
+			  enum host_cmd_aes_key_len length);
+int mm81x_cmd_disable_key(struct mm81x *mors, struct mm81x_vif *mors_vif,
+			  u16 aid, struct ieee80211_key_conf *key);
+int mm81x_cmd_rm_if(struct mm81x *mors, u16 vif_id);
+int mm81x_cmd_set_frag_threshold(struct mm81x *mors, u32 frag_threshold);
+int mm81x_cmd_get_disabled_channels(
+	struct mm81x *mors, struct host_cmd_resp_get_disabled_channels *resp,
+	uint resp_len);
+
+#endif /* !_MM81X_COMMAND_H_ */
-- 
2.43.0


