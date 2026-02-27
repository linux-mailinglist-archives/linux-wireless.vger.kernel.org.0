Return-Path: <linux-wireless+bounces-32241-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB4iONEZoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32241-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:13:05 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 428711B2878
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794F7313C8E3
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100183451AB;
	Fri, 27 Feb 2026 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="IoK9gRBp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C3335BB4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165516; cv=none; b=D0yCBlM2XOcTv7HknY3vVxIYllRb+DoVfWc9TJDZXL06fPRLNf5lI1BcTfPvhuN7+VNHa7kQpPHgwaenCaROO/0oVVyWuSGD4GiQILT4+0jvYxRE7F3BxUrA5HeBWdgTPeJBV1VMZmNVNNvYU3IpjXgy9egT53ez4Bjz4HyliRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165516; c=relaxed/simple;
	bh=vy7XNMxuQ7AbyTLOqr77rS5LlTP5gAOX+bqrHNJln2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aygy8mClmVDc1oCjPtO327t9jHVjKdfcB55mBLWtd4MXKxqQJLW94ETyE7S/g0cI6+OjNypQNF5/a+QCQKmjUQbUo7qU9oCGmb+qmv3PklEUgreawhux/LZglHdt4R1GMfynUEC1/Dq7EdeEixkXDBoYddgvakuGDsOUiWAVFe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=IoK9gRBp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adbfab4501so7205765ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165514; x=1772770314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXUsZc14cx6f+44y1z+Msjo626SfqQ8RfWUyyFwp0vc=;
        b=IoK9gRBpKySknoSMZAuaCHdSPWohQFokFk7qIi2uSk0dsTR8VuBI+2WkipEhBdLMTv
         yWAyDPOXC1EIjWjjinOTCcnsGNg83zuSSesU4CPOLWh/bUOMXIsmPZ9o9rURmkAkEpKn
         8EwpQbWpxuhWuB3miCpyS9P9jO2+Xrmb7afLC1SQr9QU5w2CmtILNHNT6hjTuKhap8bK
         6/fWRo4iuRvoga/4IDJyFGaXwTsdnp/N1G+2BTmXUkCZD8Qv+D4iZtLEprQzjLPuuH4m
         +1MwfAoYTeslAHNTOGcIdGosGYF4eMbQMCvfksHW7k8dgCS3L2y1Bgpqf4r9fwEFkX1u
         N1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165514; x=1772770314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXUsZc14cx6f+44y1z+Msjo626SfqQ8RfWUyyFwp0vc=;
        b=lP+oAtHoM9klY0JzsZL1pk0WsUhVyjqN0VAEmQnz8wcXd+v38NSQsb/1Fmd+ZRMZgy
         Ibtqfk/y7MNjNSdHWcFOAq81SetKEf52FuVgspplEZou7J67UCTci3ccbYCYUJnu2BzT
         AhNEI1BxQOVIAwn18lgEoGMGO85pxaYk3/XD9fi2sSyNWn4ArZwjyqCpIJbzl/+dTrCk
         dUxM6moaYcKQ3mnzLYbJTeFrAqqGC0KPezX+1LN7hlQZs1CvIFALdQi0QFVA4qVoBX1J
         vjIOoqKkPzCZQhPZCPfZy8w/1IQUS+GX/2GNUqz5vePk2T0dB7nysiXWSlkJ+AOoYdHX
         JU7w==
X-Forwarded-Encrypted: i=1; AJvYcCX+ydn3bekfWQY0cEAcXH5BjlwsXcvAY0/kCFnCzq45m5DEgX/Wg/OKSIub89rbkRFYFyFYMToGxsv4DLY7Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyffnakTyB1guAaU4mHMGMEpSIhW+Ho+s3QlnOdIaiWsZCNSKmf
	vCHgFsHVSIPOhd+WAQ6vcLxP9eJpKEya+O/R+mqIBZi5aQ7AJkgap6uVQH6HD/fE/SM=
X-Gm-Gg: ATEYQzxU+nUArIYihtgrho0SYSiAByqfcmRg/tvuiuULDW+h5Dt/4N/XwFZHJW7z4hJ
	u0ekvLSbpuvltx9X8p/aAU83hXIpaGPv2PXicVHEGw55BVsTb8IQoXUbCcWC9SQLvvWdObTuW0L
	zN81fmRrJGy0X6fxADejDDoeFaZz/uuihlWELZQMIlqRVnP73MMy+7kAipc+q345h6pmyQSJnsU
	i94wZONK51ER2elb2ePbPXJZic08QMVFqjc83M7zAEtiHqoxdoQDBDcWXIbuh2Nkfx2mWR88bdC
	3+tQvbFUnc7eKnrRL2rFmUlS+Wrs4sXRha15N0NauclpU6/lPcttbK5hlmfgtSslOH2MOdLuxh7
	OrhnH/oQItKvGCcQYK3NNqvxveSQVaGuOXxAVgoKgxD+cdy7OrIcvShYZNaiKTgW6k0VdSMzXnt
	1Bh6tUSQ5ipuf2qGznGm5bZG8Zg4d81VIW5ylSTez04RUQNSk634JL2Yizn/jclcRpIL/RpYWFG
	GghNYmktf7orVXB3uRlzst1I5/bB6bIhW1ZPcY3ow==
X-Received: by 2002:a17:903:1a26:b0:2ad:ba3a:3827 with SMTP id d9443c01a7336-2ae2e4f42a9mr14135095ad.54.1772165513577;
        Thu, 26 Feb 2026 20:11:53 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:11:53 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 02/35] wifi: mm81x: add command.c
Date: Fri, 27 Feb 2026 15:10:12 +1100
Message-ID: <20260227041108.66508-3-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32241-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim,req.pn:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 428711B2878
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro/mm81x/command.c   | 619 ++++++++++++++++++
 1 file changed, 619 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/command.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/command.c b/drivers/net/wireless/morsemicro/mm81x/command.c
new file mode 100644
index 000000000000..d756bcf5a318
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/command.c
@@ -0,0 +1,619 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/slab.h>
+#include <linux/atomic.h>
+#include <linux/workqueue.h>
+
+#include "debug.h"
+#include "command.h"
+#include "mac.h"
+#include "ps.h"
+#include "hif.h"
+
+#define MM_MAX_COMMAND_RETRY 2
+#define HOST_CMD_DEFAULT_TIMEOUT_MS 600
+#define HOST_CMD_POWERSAVE_TIMEOUT_MS 2000
+
+struct host_cmd_resp_cb {
+	int ret;
+	u32 length;
+	struct host_cmd_resp *dest_resp;
+};
+
+static void mm81x_cmd_init(struct mm81x *mm, struct host_cmd_header *hdr,
+			   enum host_cmd_id cmd, u16 vif_id, u16 len)
+{
+	if (len < sizeof(*hdr)) {
+		mm81x_err(mm, "Invalid cmd len %d\n", len);
+		return;
+	}
+
+	hdr->message_id = cpu_to_le16(cmd);
+	hdr->len = cpu_to_le16(len - sizeof(*hdr));
+	hdr->vif_id = cpu_to_le16(vif_id);
+}
+
+static int mm81x_cmd_tx(struct mm81x *mm, struct host_cmd_resp *resp,
+			struct host_cmd_req *req, u32 length, u32 timeout)
+{
+	int cmd_len;
+	int ret = 0;
+	u16 host_id;
+	int retry = 0;
+	unsigned long wait_ret = 0;
+	struct sk_buff *skb;
+	struct mm81x_skbq *cmd_q = mm81x_hif_get_tx_cmd_queue(mm);
+	struct host_cmd_resp_cb *resp_cb;
+	DECLARE_COMPLETION_ONSTACK(cmd_comp);
+
+	BUILD_BUG_ON(sizeof(struct host_cmd_resp_cb) >
+		     IEEE80211_TX_INFO_DRIVER_DATA_SIZE);
+
+	if (!cmd_q)
+		/* No control pageset, not supported by FW */
+		return -ENODEV;
+
+	cmd_len = sizeof(*req) + le16_to_cpu(req->hdr.len);
+	req->hdr.flags = cpu_to_le16(HOST_CMD_TYPE_REQ);
+
+	mutex_lock(&mm->cmd_wait);
+	mm->cmd_seq++;
+	if (mm->cmd_seq > HOST_CMD_HOST_ID_SEQ_MAX)
+		mm->cmd_seq = 1;
+	host_id = mm->cmd_seq << HOST_CMD_HOST_ID_SEQ_SHIFT;
+
+	mm81x_ps_disable(mm);
+
+	do {
+		req->hdr.host_id = cpu_to_le16(host_id | retry);
+
+		skb = mm81x_skbq_alloc_skb(cmd_q, cmd_len);
+		if (!skb) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		memcpy(skb->data, req, cmd_len);
+		resp_cb = (struct host_cmd_resp_cb *)IEEE80211_SKB_CB(skb)
+				  ->driver_data;
+		resp_cb->length = length;
+		resp_cb->dest_resp = resp;
+
+		mm81x_dbg(mm, MM81X_DBG_ANY, "CMD 0x%04x:%04x",
+			  le16_to_cpu(req->hdr.message_id),
+			  le16_to_cpu(req->hdr.host_id));
+
+		mutex_lock(&mm->cmd_lock);
+		mm->cmd_comp = &cmd_comp;
+		if (retry > 0)
+			reinit_completion(&cmd_comp);
+		timeout = timeout ? timeout : HOST_CMD_DEFAULT_TIMEOUT_MS;
+		ret = mm81x_skbq_skb_tx(cmd_q, &skb, NULL,
+					MM81X_SKB_CHAN_COMMAND);
+		mutex_unlock(&mm->cmd_lock);
+
+		if (ret) {
+			mm81x_err(mm, "mm81x_skbq_tx fail: %d", ret);
+			break;
+		}
+
+		wait_ret = wait_for_completion_timeout(
+			&cmd_comp, msecs_to_jiffies(timeout));
+		mutex_lock(&mm->cmd_lock);
+		mm->cmd_comp = NULL;
+
+		if (!wait_ret) {
+			mm81x_err(
+				mm,
+				"Try:%d Command %04x:%04x timeout after %u ms",
+				retry, le16_to_cpu(req->hdr.message_id),
+				le16_to_cpu(req->hdr.host_id), timeout);
+			ret = -ETIMEDOUT;
+		} else {
+			ret = (length && resp) ? le32_to_cpu(resp->status) :
+						 resp_cb->ret;
+
+			mm81x_dbg(mm, MM81X_DBG_ANY,
+				  "Command 0x%04x:%04x status 0x%08x",
+				  le16_to_cpu(req->hdr.message_id),
+				  le16_to_cpu(req->hdr.host_id), ret);
+			if (ret) {
+				mm81x_err(mm, "Command 0x%04x:%04x error %d",
+					  le16_to_cpu(req->hdr.message_id),
+					  le16_to_cpu(req->hdr.host_id), ret);
+			}
+		}
+		/* Free the command request */
+		spin_lock_bh(&cmd_q->lock);
+		mm81x_skbq_skb_finish(cmd_q, skb, NULL);
+		spin_unlock_bh(&cmd_q->lock);
+		mutex_unlock(&mm->cmd_lock);
+
+		retry++;
+	} while ((ret == -ETIMEDOUT) && retry < MM_MAX_COMMAND_RETRY);
+
+	mm81x_ps_enable(mm);
+	mutex_unlock(&mm->cmd_wait);
+
+	if (ret == -ETIMEDOUT) {
+		mm81x_err(mm, "Command %02x:%02x timed out",
+			  le16_to_cpu(req->hdr.message_id),
+			  le16_to_cpu(req->hdr.host_id));
+	} else if (ret != 0) {
+		mm81x_err(mm, "Command %02x:%02x failed with rc %d (0x%x)\n",
+			  le16_to_cpu(req->hdr.message_id),
+			  le16_to_cpu(req->hdr.host_id), ret, ret);
+	}
+
+	return ret;
+}
+
+int mm81x_cmd_sta_state(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 aid,
+			struct ieee80211_sta *sta,
+			enum ieee80211_sta_state state)
+{
+	struct host_cmd_req_set_sta_state req;
+	struct host_cmd_resp_set_sta_state resp;
+
+	memset(&req, 0, sizeof(req));
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_SET_STA_STATE, mm_vif->id,
+		       sizeof(req));
+
+	memcpy(req.sta_addr, sta->addr, sizeof(req.sta_addr));
+	req.aid = cpu_to_le16(aid);
+	req.state = cpu_to_le16(state);
+	req.uapsd_queues = sta->uapsd_queues;
+
+	return mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			    (struct host_cmd_req *)&req, sizeof(resp), 0);
+}
+
+int mm81x_cmd_resp_process(struct mm81x *mm, struct sk_buff *skb)
+{
+	int length, ret = -ESRCH; /* No such process */
+	struct mm81x_skbq *cmd_q = mm81x_hif_get_tx_cmd_queue(mm);
+	struct host_cmd_resp *src_resp = (struct host_cmd_resp *)(skb->data);
+	struct sk_buff *cmd_skb = NULL;
+	struct host_cmd_resp_cb *resp_cb;
+	struct host_cmd_resp *dest_resp;
+	struct host_cmd_req *req;
+	u16 message_id = 0;
+	u16 host_id = 0;
+	u16 resp_message_id = le16_to_cpu(src_resp->hdr.message_id);
+	u16 resp_host_id = le16_to_cpu(src_resp->hdr.host_id);
+	bool is_late_response = false;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "EVT 0x%04x:0x%04x", resp_message_id,
+		  resp_host_id);
+
+	if (!HOST_CMD_IS_RESP(src_resp)) {
+		ret = mm81x_mac_event_recv(mm, skb);
+		goto exit_free;
+	}
+
+	mutex_lock(&mm->cmd_lock);
+
+	cmd_skb = mm81x_skbq_tx_pending(cmd_q);
+	if (cmd_skb) {
+		mm81x_skbq_pull_hdr_post_tx(cmd_skb);
+		req = (struct host_cmd_req *)cmd_skb->data;
+		message_id = le16_to_cpu(req->hdr.message_id);
+		host_id = le16_to_cpu(req->hdr.host_id);
+	}
+
+	/*
+	 * If there is no pending command or the sequence ID does not match,
+	 * this is a late response for a timed out command which has been
+	 * cleaned up, so just free up the response. If a command was retried,
+	 * the response may be from the retry or from the original command
+	 * (late response) but not from both because the firmware will silently
+	 * drop a retry if it received the initial request. So a mismatched
+	 * retry counter is treated as a matched command and response.
+	 */
+	if (!cmd_skb || message_id != resp_message_id ||
+	    (host_id & HOST_CMD_HOST_ID_SEQ_MASK) !=
+		    (resp_host_id & HOST_CMD_HOST_ID_SEQ_MASK)) {
+		mm81x_err(
+			mm,
+			"Late response for timed out req 0x%04x:%04x have 0x%04x:%04x 0x%04x",
+			resp_message_id, resp_host_id, message_id, host_id,
+			mm->cmd_seq);
+		is_late_response = true;
+		goto exit;
+	}
+	if ((host_id & HOST_CMD_HOST_ID_RETRY_MASK) !=
+	    (resp_host_id & HOST_CMD_HOST_ID_RETRY_MASK))
+		mm81x_dbg(mm, MM81X_DBG_ANY,
+			  "Command retry mismatch 0x%04x:%04x 0x%04x:%04x",
+			  message_id, host_id, resp_message_id, resp_host_id);
+
+	resp_cb = (struct host_cmd_resp_cb *)IEEE80211_SKB_CB(cmd_skb)
+			  ->driver_data;
+	length = resp_cb->length;
+	dest_resp = resp_cb->dest_resp;
+	if (length >= sizeof(struct host_cmd_resp) && dest_resp) {
+		ret = 0;
+		length = min_t(int, length,
+			       le16_to_cpu(src_resp->hdr.len) +
+				       sizeof(struct host_cmd_header));
+		memcpy(dest_resp, src_resp, length);
+	} else {
+		ret = le32_to_cpu(src_resp->status);
+	}
+
+	resp_cb->ret = ret;
+
+exit:
+	if (cmd_skb && !is_late_response) {
+		/* Complete if not already timed out */
+		if (mm->cmd_comp)
+			complete(mm->cmd_comp);
+	}
+
+	mutex_unlock(&mm->cmd_lock);
+exit_free:
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+int mm81x_cmd_add_if(struct mm81x *mm, u16 *vif_id, const u8 *addr,
+		     enum nl80211_iftype type)
+{
+	int ret;
+	struct host_cmd_req_add_interface req;
+	struct host_cmd_resp_add_interface resp;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_ADD_INTERFACE, 0, sizeof(req));
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+		req.interface_type = cpu_to_le32(HOST_CMD_INTERFACE_TYPE_STA);
+		break;
+	case NL80211_IFTYPE_AP:
+		req.interface_type = cpu_to_le32(HOST_CMD_INTERFACE_TYPE_AP);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	memcpy(req.addr.octet, addr, sizeof(req.addr.octet));
+
+	ret = mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			   (struct host_cmd_req *)&req, sizeof(resp), 0);
+	if (ret == 0)
+		*vif_id = le16_to_cpu(resp.hdr.vif_id);
+
+	return ret;
+}
+
+int mm81x_cmd_get_capabilities(struct mm81x *mm, u16 vif_id,
+			       struct mm81x_fw_caps *capabilities)
+{
+	int ret = 0;
+	int i;
+	struct host_cmd_req_get_capabilities req;
+	struct host_cmd_resp_get_capabilities rsp;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_GET_CAPABILITIES, vif_id,
+		       sizeof(req));
+
+	ret = mm81x_cmd_tx(mm, (struct host_cmd_resp *)&rsp,
+			   (struct host_cmd_req *)&req, sizeof(rsp), 0);
+	if (ret)
+		return ret;
+
+	capabilities->ampdu_mss = rsp.capabilities.ampdu_mss;
+	capabilities->mm81x_mmss_offset = rsp.morse_mmss_offset;
+	capabilities->beamformee_sts_capability =
+		rsp.capabilities.beamformee_sts_capability;
+	capabilities->maximum_ampdu_length_exponent =
+		rsp.capabilities.maximum_ampdu_length_exponent;
+	capabilities->number_sounding_dimensions =
+		rsp.capabilities.number_sounding_dimensions;
+	for (i = 0; i < FW_CAPABILITIES_FLAGS_WIDTH; i++)
+		capabilities->flags[i] = le32_to_cpu(rsp.capabilities.flags[i]);
+
+	return ret;
+}
+
+int mm81x_cmd_get_max_txpower(struct mm81x *mm, s32 *out_power_mbm)
+{
+	int ret;
+	struct host_cmd_req_get_max_txpower req;
+	struct host_cmd_resp_get_max_txpower resp;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_GET_MAX_TXPOWER, 0,
+		       sizeof(req));
+
+	ret = mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			   (struct host_cmd_req *)&req, sizeof(resp), 0);
+	if (ret == 0)
+		*out_power_mbm = QDBM_TO_MBM(le32_to_cpu(resp.power_qdbm));
+
+	return ret;
+}
+
+int mm81x_cmd_hw_scan(struct mm81x *mm, struct mm81x_hw_scan_params *params,
+		      bool store)
+{
+	int ret;
+	struct host_cmd_req_hw_scan *req;
+	size_t cmd_size;
+	u8 *buf;
+	u32 flags = 0;
+
+	cmd_size = mm81x_hw_scan_h_get_cmd_size(params);
+	cmd_size = ROUND_BYTES_TO_WORD(cmd_size);
+
+	req = kzalloc(cmd_size, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	buf = req->variable;
+
+	if (store)
+		flags = HOST_CMD_HW_SCAN_FLAGS_STORE;
+	else if (params->operation == MM81X_HW_SCAN_OP_START)
+		flags |= HOST_CMD_HW_SCAN_FLAGS_START;
+	else if (params->operation == MM81X_HW_SCAN_OP_STOP)
+		flags |= HOST_CMD_HW_SCAN_FLAGS_ABORT;
+
+	if (params->use_1mhz_probes)
+		flags |= HOST_CMD_HW_SCAN_FLAGS_1MHZ_PROBES;
+
+	if (params->operation == MM81X_HW_SCAN_OP_START) {
+		req->dwell_time_ms = cpu_to_le32(params->dwell_time_ms);
+		buf = mm81x_hw_scan_h_insert_tlvs(params, buf);
+	}
+
+	req->flags = cpu_to_le32(flags);
+	mm81x_cmd_init(mm, &req->hdr, HOST_CMD_ID_HW_SCAN, 0, buf - (u8 *)req);
+	ret = mm81x_cmd_tx(mm, NULL, (struct host_cmd_req *)req, 0, 0);
+	kfree(req);
+
+	return ret;
+}
+
+int mm81x_cmd_set_txpower(struct mm81x *mm, s32 *out_power_mbm, int txpower_mbm)
+{
+	int ret;
+	struct host_cmd_req_set_txpower req;
+	struct host_cmd_resp_set_txpower resp;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_SET_TXPOWER, 0, sizeof(req));
+
+	req.power_qdbm = cpu_to_le32(MBM_TO_QDBM(txpower_mbm));
+
+	ret = mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			   (struct host_cmd_req *)&req, sizeof(resp), 0);
+	if (ret == 0)
+		*out_power_mbm = QDBM_TO_MBM(le32_to_cpu(resp.power_qdbm));
+
+	return ret;
+}
+
+int mm81x_cmd_set_channel(struct mm81x *mm, u32 op_chan_freq_hz,
+			  u8 pri_1mhz_chan_idx, u8 op_bw_mhz, u8 pri_bw_mhz,
+			  s32 *power_mbm)
+{
+	int ret;
+	struct host_cmd_req_set_channel req;
+	struct host_cmd_resp_set_channel resp;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_SET_CHANNEL, 0, sizeof(req));
+
+	req.op_chan_freq_hz = cpu_to_le32(op_chan_freq_hz);
+	req.op_bw_mhz = op_bw_mhz;
+	req.pri_bw_mhz = pri_bw_mhz;
+	req.pri_1mhz_chan_idx = pri_1mhz_chan_idx;
+	req.dot11_mode = HOST_CMD_DOT11_PROTO_MODE_AH;
+
+	ret = mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			   (struct host_cmd_req *)&req, sizeof(resp), 0);
+	if (!ret)
+		*power_mbm = QDBM_TO_MBM(le32_to_cpu(resp.power_qdbm));
+
+	return ret;
+}
+
+int mm81x_cmd_disable_key(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 aid,
+			  struct ieee80211_key_conf *key)
+{
+	struct host_cmd_req_disable_key req;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY,
+		  "%s Disabling key for vif (%d):\n"
+		  "\tkey->hw_key_idx: %d\n"
+		  "\taid (optional): %d\n",
+		  __func__, mm_vif->id, key->hw_key_idx, aid);
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_DISABLE_KEY, mm_vif->id,
+		       sizeof(req));
+
+	req.aid = cpu_to_le32(aid);
+	req.key_idx = key->hw_key_idx;
+	req.key_type = cpu_to_le32((key->flags & IEEE80211_KEY_FLAG_PAIRWISE) ?
+					   HOST_CMD_TEMPORAL_KEY_TYPE_PTK :
+					   HOST_CMD_TEMPORAL_KEY_TYPE_GTK);
+
+	return mm81x_cmd_tx(mm, NULL, (struct host_cmd_req *)&req, 0, 0);
+}
+
+int mm81x_cmd_install_key(struct mm81x *mm, struct mm81x_vif *mm_vif, u16 aid,
+			  struct ieee80211_key_conf *key,
+			  enum host_cmd_key_cipher cipher,
+			  enum host_cmd_aes_key_len length)
+{
+	int ret;
+	struct host_cmd_req_install_key req;
+	struct host_cmd_resp_install_key resp;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY,
+		  "%s Installing key for vif (%d):\n"
+		  "\tkey->idx: %d\n"
+		  "\tkey->cipher: 0x%08x\n"
+		  "\tkey->pn: %lld\n"
+		  "\tkey->len: %d\n"
+		  "\tkey->flags: 0x%08x\n"
+		  "\taid (optional): %d\n",
+		  __func__, mm_vif->id, key->keyidx, key->cipher,
+		  (u64)atomic64_read(&key->tx_pn), key->keylen, key->flags,
+		  aid);
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_INSTALL_KEY, mm_vif->id,
+		       sizeof(req));
+
+	req.pn = cpu_to_le64(atomic64_read(&key->tx_pn));
+	req.aid = cpu_to_le32(aid);
+	req.cipher = cipher;
+	req.key_length = length;
+	req.key_idx = key->keyidx;
+	req.key_type = (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) ?
+			       HOST_CMD_TEMPORAL_KEY_TYPE_PTK :
+			       HOST_CMD_TEMPORAL_KEY_TYPE_GTK;
+
+	if (key->keylen > sizeof(req.key))
+		return -EINVAL;
+
+	memcpy(req.key, key->key, key->keylen);
+
+	ret = mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			   (struct host_cmd_req *)&req, sizeof(resp), 0);
+
+	if (ret == 0) {
+		key->hw_key_idx = resp.key_idx;
+		mm81x_dbg(mm, MM81X_DBG_ANY, "Installed key @ hw index: %d",
+			  resp.key_idx);
+	}
+
+	return ret;
+}
+
+int mm81x_cmd_cfg_multicast_filter(struct mm81x *mm, struct mm81x_vif *mm_vif)
+{
+	struct host_cmd_req_mcast_filter *req;
+	struct mcast_filter *filter = mm->mcast_filter;
+	u16 filter_list_len = sizeof(filter->addr_list[0]) * filter->count;
+	u16 alloc_len = filter_list_len + sizeof(*req);
+	int ret = 0;
+
+	req = kmalloc(alloc_len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	mm81x_cmd_init(mm, &req->hdr, HOST_CMD_ID_MCAST_FILTER, mm_vif->id,
+		       alloc_len);
+
+	req->count = filter->count;
+	memcpy(req->hw_addr, filter->addr_list, filter_list_len);
+
+	ret = mm81x_cmd_tx(mm, NULL, (struct host_cmd_req *)req, 0, 0);
+	kfree(req);
+	return ret;
+}
+
+int mm81x_cmd_cfg_bss(struct mm81x *mm, u16 vif_id, u16 beacon_int,
+		      u16 dtim_period, u32 cssid)
+{
+	struct host_cmd_req_bss_config req;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_BSS_CONFIG, vif_id,
+		       sizeof(req));
+
+	req.beacon_interval_tu = cpu_to_le16(beacon_int);
+	req.cssid = cpu_to_le32(cssid);
+	req.dtim_period = cpu_to_le16(dtim_period);
+
+	return mm81x_cmd_tx(mm, NULL, (struct host_cmd_req *)&req, 0, 0);
+}
+
+int mm81x_cmd_config_beacon_timer(struct mm81x *mm, void *mm81x_vif,
+				  bool enabled)
+{
+	struct host_cmd_req_bss_beacon_config req;
+	struct host_cmd_resp_bss_beacon_config resp;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_BSS_BEACON_CONFIG,
+		       ((struct mm81x_vif *)mm81x_vif)->id, sizeof(req));
+	req.enable = enabled;
+
+	return mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			    (struct host_cmd_req *)&req, 0, 0);
+}
+
+int mm81x_cmd_set_ps(struct mm81x *mm, bool enabled)
+{
+	struct host_cmd_req_config_ps req;
+
+	if (!mm->ps.enable)
+		return 0;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_CONFIG_PS, 0, sizeof(req));
+
+	req.enabled = (u8)enabled;
+	req.dynamic_ps_offload = false;
+
+	return mm81x_cmd_tx(mm, NULL, (struct host_cmd_req *)&req, 0,
+			    HOST_CMD_POWERSAVE_TIMEOUT_MS);
+}
+
+int mm81x_cmd_cfg_qos(struct mm81x *mm, struct mm81x_queue_params *params)
+{
+	struct host_cmd_req_set_qos_params req;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_SET_QOS_PARAMS, 0,
+		       sizeof(req));
+
+	req.uapsd = params->uapsd;
+	req.queue_idx = params->aci;
+	req.aifs_slot_count = params->aifs;
+	req.contention_window_min = cpu_to_le16(params->cw_min);
+	req.contention_window_max = cpu_to_le16(params->cw_max);
+	req.max_txop_usec = cpu_to_le32(params->txop);
+
+	return mm81x_cmd_tx(mm, NULL, (struct host_cmd_req *)&req, 0, 0);
+}
+
+int mm81x_cmd_rm_if(struct mm81x *mm, u16 vif_id)
+{
+	struct host_cmd_req_remove_interface req;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_REMOVE_INTERFACE, vif_id,
+		       sizeof(req));
+
+	return mm81x_cmd_tx(mm, NULL, (struct host_cmd_req *)&req, 0, 0);
+}
+
+int mm81x_cmd_set_frag_threshold(struct mm81x *mm, u32 frag_threshold)
+{
+	struct host_cmd_req_get_set_generic_param req = {
+		.param_id = cpu_to_le32(HOST_CMD_PARAM_ID_FRAGMENT_THRESHOLD),
+		.action = cpu_to_le32(HOST_CMD_PARAM_ACTION_SET),
+		.value = cpu_to_le32(frag_threshold),
+	};
+	struct host_cmd_resp_get_set_generic_param resp;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_GET_SET_GENERIC_PARAM, 0,
+		       sizeof(req));
+
+	return mm81x_cmd_tx(mm, (struct host_cmd_resp *)&resp,
+			    (struct host_cmd_req *)&req, sizeof(resp), 0);
+}
+
+int mm81x_cmd_get_disabled_channels(
+	struct mm81x *mm, struct host_cmd_resp_get_disabled_channels *resp,
+	uint resp_len)
+{
+	struct host_cmd_req req;
+
+	mm81x_cmd_init(mm, &req.hdr, HOST_CMD_ID_GET_DISABLED_CHANNELS, 0,
+		       sizeof(req));
+
+	return mm81x_cmd_tx(mm, (struct host_cmd_resp *)resp, &req, resp_len,
+			    0);
+}
-- 
2.43.0


