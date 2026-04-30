Return-Path: <linux-wireless+bounces-35651-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIHsAh3h8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35651-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:57:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9218849D65E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB815300363E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874AB366836;
	Thu, 30 Apr 2026 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="HLnBKu89"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D788364028
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525019; cv=none; b=Hg0jMWdl6a8+h15N7bDD9FWvRFBO7fflH3mWhJZ8HWW3q6xCTPxLRWZB6x+cNZJ12XtY2q9mGG1xawX8y/KEC13xvAKchR2c0bzLis1vcewlVmAkPYM4G54SWfbeNgggEBtgNVVRII7c2td+PMQe7/7JS/4oLtC1JEqW2o69qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525019; c=relaxed/simple;
	bh=nBfV/O8Xfi0M3Ncbgd71FULLiDKcosN9UVkG7dh0bt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDWJwlfsXbaoJeGnqiy5I+jPCyV6R1mPXF8zw4i80kRhoPIFCVe2BiddYZZ7COgIw116PeaqGy6ow2HXf1OZzvq65MxCoANJba3Ry397eRnqd27x2wcHl9Hjrj+G9TT4mC473f8uqf2fBDYBjnkckkmRcDIWsW8Gt/jQIt1mVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=HLnBKu89; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8296d553142so310185b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525017; x=1778129817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsJuVc8APNdt6FnYDE9gJ8ybo7oZZfDLotB1bM9RCHk=;
        b=HLnBKu89uD7IRycniIHioyY9LK24z95uTSc59bYGD27M0LGGDTsdbt9Q3VdipdBF1I
         B+ZhnlByvKbWjAGdG4b04FD0RfdIpFLYaE9MuJi/CGzJHmQmPHs5g/Dw0eXHKdyysX2u
         5ehu6DmNAQLOIeDBwiBqaF5SyZvQ4ha9otcswW7fIlAth5BWcpjjSWIpXa1cTAY1JwZp
         zr6yMMX3Oc/iDVc92lQuBaLps2OfgkTaOsdXJLhNawsoE1x3iS7Bk6zGvJcj4daMR8Bf
         wIaKFzj3UsKNHOa/Detb9zOZ/keF4JYbv6e/IakpY0jhSBJtihwzoWdWmyIkpl8XvMLK
         zIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525017; x=1778129817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YsJuVc8APNdt6FnYDE9gJ8ybo7oZZfDLotB1bM9RCHk=;
        b=HWdoHuIGpL9+vmGHImw0mVbf6o43BlEJYcTWUj7rUAtudI3RfLp3Q22NmtKpT0Nv9+
         vkA2WH2AoXSOVRfUlSXtMUUkvcyA5Qsx5tq61lqHl3GnIZkFb07RxhZbTT/+HviXYdkk
         nFPqARfiMJOlMdOP6Ijti+rjYQJ+DwO2dhiNMbp1Ms/hANxmUIZmTVQtPncVujKfeuOp
         f93QclQyzAvk3j1dliHYhhN3ljhm0ZRI8lt92RNuzLUQKRzu9gg64A1qTI1sKUR4WCuJ
         lbCoVCtlylOh3QlZhxZe0VN5tLcPrTbRbVzS3NYBgMQTzBCCNoy2nVofqbNTN4sXUCmO
         jjOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3yqTdbhSb7wQMEKGinyFW2DuYn+z74bcqG83cXeOyJtMoV8Dwn/ad2IV7PbZ1jBqIqH4B9knBztuN3m4OrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHbtTUn7dP2a640TVd468tRAMpyysigGNfxc62uzQAVhSmlCV
	Zd4I0dbMcKmC1gCVbp35Z0MWmi1kzEJb7vftp9GuNUpXKPx0YXo3f2GCx4NaYCI9JA8=
X-Gm-Gg: AeBDievAodgFqcWDgBt5MnezmBXN+PUKdOkExAtjm+x1Uu55W2LBPhElLr8PMm3Ll+g
	DRbnOdbgW6fwTJw0R5XnRYxiE5sjdOAoJj43BX4CTRGL21fCXboY++ugaQ2dO2Sg4GPqgqskKlR
	SqHCQxqnyAriN3buOxtHGhNClWxhFbOC4E3Pq9coOb2CUiGI5BZt1UZpZQS5aRzLNugJaABY0e7
	z2jOPkyjTUC+G0G/yckBzzOvgbR2ZqAJ+2pWTKeCX0T4Z8DJkN1bxHC9TqFZHxuAJ8ywoKIVTAc
	3BwffFUU5MZYfTAgLoBk7CzaHcGsXH0QbpAYvwTCdH7a5pa7v5ThYsH6F+xG5Xqbp8kV4oAUiSO
	e2bZ0AumJFqtMigvunX6m+j0U2OJpBKrSlyzDjRJkWY+nfkKYEMCdCmHhO6kuLvHPWvMxn8eB0X
	jQfk/7gdCFiFpnjez3H9wkbknhcb5g+Cv1MIg6Dx6aqMIfm17ZS49VDdIl33Kmxvp+wOL1VqQXd
	ZSQHjweX6zohnbgj3c3PzX/7Ho7P4A1sjDbWVwBrg==
X-Received: by 2002:a05:6a00:301f:b0:82f:2d48:f906 with SMTP id d2e1a72fcca58-834fdb82c41mr1678556b3a.12.1777525017503;
        Wed, 29 Apr 2026 21:56:57 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:56:57 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 04/31] wifi: mm81x: add command.h
Date: Thu, 30 Apr 2026 14:55:30 +1000
Message-ID: <20260430045615.334669-5-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9218849D65E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35651-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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


