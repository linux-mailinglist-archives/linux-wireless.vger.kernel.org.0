Return-Path: <linux-wireless+bounces-32769-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LG2IK/nrmlRKAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32769-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 16:30:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CE23BB11
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 16:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F04031DA26D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 15:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928C3D3013;
	Mon,  9 Mar 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icc81Nr6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4203D6CB0
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069655; cv=none; b=krpKNRyujlnZFbW/DTSyOws9LCpHo9t1BYk67Y/F7K7AVHEHG0ZAdUV2T9W3vxIvGu6NiBSy5Vv38PjUx2IJ+6JpJR3H6AiucSkmAPvpvMEvv2tJd3s0A2UtuewOI16kcFTK0aLnU6evLT72GxP8Kun1oF4he1+7M3CmTmzevwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069655; c=relaxed/simple;
	bh=ZdQApQA+b6MyB6KOA6Qh5Pp8xgZ4mDd2ZLb4e9y5vNc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHFV+0BsS9XA4etleyPPCuDhtYPqK54aOE4FBB+CqqEHT3rk+h5EnY6U2kw/ueGcPUp+YsmQmi1YQn4AWJ52ofWZGtGVre/5CqJ8EhYAw+T2v1BPhQeI5c5uY315IxBytsY3P5pBx7UYFO2nB4hV7NHR2ijN+AznALbF/gAY0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icc81Nr6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439bcec8613so6130093f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773069652; x=1773674452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/6LEz4YQxVekCdPCfPPKI1tzPq3wraX1+loD9w8RnQ=;
        b=icc81Nr6IzMMWAWdtTRCsIKuT3iKEVeT4kDPt/cy0BMlOpElGV5n4uSONJygpdtbfw
         wgKTO88bIQAZCLywdZGjJ3R9F6k/G86fpRKp8nEyqqzNj8umPPkUcDDCbMlGwJ0FVh8L
         mEoiUcwlIByRQLJ1BtcFH7gAVuJbFpNnbRo/5s3epKcuogddqgCjRMNi/40XlEOVWsmK
         5AnRElzEOGPtolivVzLRHqfsNoILTqyWmXGzGRY9wRfohARPGxz8JvCruj4byyul5htp
         c7jZ1kAaIXV7ehlDwJr/T1os+BARBmJXAO0a5mfmj96vdh5A8JpDQ5Fa8aP5ZHVcucrk
         R7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773069652; x=1773674452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/6LEz4YQxVekCdPCfPPKI1tzPq3wraX1+loD9w8RnQ=;
        b=aC8kPH6vgyyh0Ds0CEtx/HwnpgQx+Ul1fUhOebecwer/TYyDIpEgkrIReIbrMc0bMI
         EUBb7bFQkc7KehvfxsbZXuZxuaY0m+TxGGSYTk1nCgtbrFKtP9nMLyc+JGo/rKS+mopL
         1Hz/eaAPq6j3f+JFHhkj0PIcZfQPnoQ043JFc1FC3XaeLrL6njryAcfRvAFB8giCPF18
         8vhM5qAypapi0otDl/6/VQXaXHtuoCZs/MlKfosJ/YDBVmdT0/2l5QTojscRcxtJTHvF
         GvXezSihqbVpV8y66PjdkZtppZsaTS0eUZ+k2zYzv0b/Zxg3dYnhRt6ug8p5G+WqlmEx
         8TLw==
X-Gm-Message-State: AOJu0Yxmm1nwFJvzW4rj0m0F4fBwpbEAP69VB5rO0XM1SLkfSvj/hV1T
	2BzppK1Dniz/tWW8QVywaU/sra37RHbUkrJl0iK4t+tOdBce6s+7f++BSvrLeg==
X-Gm-Gg: ATEYQzwhm87S2pFtgiK5ThlwWG9+YYliEzv0vDNjVrLKKbxQKDWr0bmzYcPI/uZOs90
	KasZB6j57z6eSyQGpbfj7DiWau37kr750kjIvfAVJpMUAeU3qD3yWJ3gKyz0X/iqTY8kLmBKsa1
	7GdyB1nQdECMWhxZNTGy+c0pi/LXKp0EU9gRyc6YFNCX7QUdgDs/qlAijCD7LJT+TE8zojW85yB
	9+dXFgwvSDEKf1pOOI1Gi47yzQqAPO5QmL72tIHQNNA1ROAV3WQrMp47+2nXBeqe+C+VdGBH+Q0
	sktjI4TIqQ4NWGtaRxftAUuFe8qohMil2wikp50/XC486BwouI60oxLgCr+H/Zi5aErm/Q1spHT
	JfAj+wrkw+dQ/0sAmRUk3KOjbxd7j84XKnT7UCoHmPAWp8GqYg3uF5eizanAg2GiwL2Iv0nERet
	uLK055d41SnRhopJ8TVWL5eeVqZkbirokQA+/c1ceyMJOg4kRAXR3scgdQ
X-Received: by 2002:a05:600c:8b62:b0:485:309c:2984 with SMTP id 5b1f17b1804b1-48530bab0a8mr114078395e9.13.1773069651191;
        Mon, 09 Mar 2026 08:20:51 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48539e574b5sm115979495e9.8.2026.03.09.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:20:50 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing wmi tb
Date: Mon,  9 Mar 2026 16:20:50 +0100
Message-ID: <20260309152050.191820-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB2CE23BB11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-32769-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.978];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On each WMI message received from the hardware, we alloc a temporary array
of WMI_TAG_MAX entries of type void *. This array is then populated with
pointers of parsed structs depending on the WMI type, and then freed. This
alloc can fail when memory pressure in the system is high enough.

Given the fact that it is scheduled in softirq with the system_bh_wq, we
should not be able to parse more than one WMI message per CPU at any time

So instead lets move to a per cpu allocated array, stored in the struct
ath12k_base, that is reused accros calls. The ath12k_wmi_tlv_parse_alloc()
is also renamed into / merged with ath12k_wmi_tlv_parse() as it no longer
allocs memory but returns the existing per-cpu one.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
changes from RFC:
  - rebased on ath-next 8e0ab5b9adb7
  - converted missing call sites ath12k_wmi_obss_color_collision_event()
    & ath12k_wmi_pdev_temperature_event()
  - changed alloc order & cleanup path in ath12k_core_alloc() as it seems
    it confused people
  - used sizeof(*tb) in ath12k_wmi_tlv_parse()

Note I did try to move to a DEFINE_PER_CPU() allocated array but the module
loader complained about the array size. So I stuck to the per ab alloc. 
---
 drivers/net/wireless/ath/ath12k/core.c |   7 +
 drivers/net/wireless/ath/ath12k/core.h |   2 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 178 ++++++-------------------
 3 files changed, 51 insertions(+), 136 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c31c47fb5a73..c1de70b24828 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2258,6 +2258,7 @@ void ath12k_core_free(struct ath12k_base *ab)
 	timer_delete_sync(&ab->rx_replenish_retry);
 	destroy_workqueue(ab->workqueue_aux);
 	destroy_workqueue(ab->workqueue);
+	free_percpu(ab->wmi_tb);
 	kfree(ab);
 }
 
@@ -2270,6 +2271,11 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	if (!ab)
 		return NULL;
 
+	ab->wmi_tb = __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
+				    __alignof__(void *));
+	if (!ab->wmi_tb)
+		goto err_sc_free;
+
 	init_completion(&ab->driver_recovery);
 
 	ab->workqueue = create_singlethread_workqueue("ath12k_wq");
@@ -2317,6 +2323,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 err_free_wq:
 	destroy_workqueue(ab->workqueue);
 err_sc_free:
+	free_percpu(ab->wmi_tb);
 	kfree(ab);
 	return NULL;
 }
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..ebe7b94fd712 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -19,6 +19,7 @@
 #include <linux/average.h>
 #include <linux/of.h>
 #include <linux/rhashtable.h>
+#include <linux/percpu.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -937,6 +938,7 @@ struct ath12k_base {
 	struct device *dev;
 	struct ath12k_qmi qmi;
 	struct ath12k_wmi_base wmi_ab;
+	void __percpu *wmi_tb;
 	struct completion fw_ready;
 	u8 device_id;
 	int num_radios;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 8e13c3ec1cc7..73bbb2eb4fce 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -289,29 +289,19 @@ static int ath12k_wmi_tlv_iter_parse(struct ath12k_base *ab, u16 tag, u16 len,
 	return 0;
 }
 
-static int ath12k_wmi_tlv_parse(struct ath12k_base *ar, const void **tb,
-				const void *ptr, size_t len)
-{
-	return ath12k_wmi_tlv_iter(ar, ptr, len, ath12k_wmi_tlv_iter_parse,
-				   (void *)tb);
-}
-
 static const void **
-ath12k_wmi_tlv_parse_alloc(struct ath12k_base *ab,
-			   struct sk_buff *skb, gfp_t gfp)
+ath12k_wmi_tlv_parse(struct ath12k_base *ab, struct sk_buff *skb)
 {
 	const void **tb;
 	int ret;
 
-	tb = kzalloc_objs(*tb, WMI_TAG_MAX, gfp);
-	if (!tb)
-		return ERR_PTR(-ENOMEM);
+	tb = this_cpu_ptr(ab->wmi_tb);
+	memset(tb, 0, WMI_TAG_MAX * sizeof(*tb));
 
-	ret = ath12k_wmi_tlv_parse(ab, tb, skb->data, skb->len);
-	if (ret) {
-		kfree(tb);
+	ret = ath12k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath12k_wmi_tlv_iter_parse, (void *)tb);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return tb;
 }
@@ -3913,7 +3903,7 @@ ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *sk
 	u32 vdev_id, evt_type;
 	u64 bitmap;
 
-	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	const void **tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
 			    PTR_ERR(tb));
@@ -5714,7 +5704,7 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
 	const struct wmi_vdev_start_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5724,13 +5714,11 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
 	ev = tb[WMI_TAG_VDEV_START_RESPONSE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev start resp ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
 	*vdev_rsp = *ev;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -5809,7 +5797,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processing regulatory ext channel list\n");
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5819,7 +5807,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch reg chan list ext update ev\n");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -5849,7 +5836,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	if (num_2g_reg_rules > MAX_REG_RULES || num_5g_reg_rules > MAX_REG_RULES) {
 		ath12k_warn(ab, "Num reg rules for 2G/5G exceeds max limit (num_2g_reg_rules: %d num_5g_reg_rules: %d max_rules: %d)\n",
 			    num_2g_reg_rules, num_5g_reg_rules, MAX_REG_RULES);
-		kfree(tb);
 		return -EINVAL;
 	}
 
@@ -5859,7 +5845,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		if (num_6g_reg_rules_ap[i] > MAX_6GHZ_REG_RULES) {
 			ath12k_warn(ab, "Num 6G reg rules for AP mode(%d) exceeds max limit (num_6g_reg_rules_ap: %d, max_rules: %d)\n",
 				    i, num_6g_reg_rules_ap[i], MAX_6GHZ_REG_RULES);
-			kfree(tb);
 			return -EINVAL;
 		}
 
@@ -5884,14 +5869,12 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		    num_6g_reg_rules_cl[WMI_REG_VLP_AP][i] >  MAX_6GHZ_REG_RULES) {
 			ath12k_warn(ab, "Num 6g client reg rules exceeds max limit, for client(type: %d)\n",
 				    i);
-			kfree(tb);
 			return -EINVAL;
 		}
 	}
 
 	if (!total_reg_rules) {
 		ath12k_warn(ab, "No reg rules available\n");
-		kfree(tb);
 		return -EINVAL;
 	}
 
@@ -5993,7 +5976,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						      ext_wmi_reg_rule);
 
 		if (!reg_info->reg_rules_2g_ptr) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 2g rules\n");
 			return -ENOMEM;
 		}
@@ -6027,7 +6009,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						      ext_wmi_reg_rule);
 
 		if (!reg_info->reg_rules_5g_ptr) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 5g rules\n");
 			return -ENOMEM;
 		}
@@ -6046,7 +6027,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						      ext_wmi_reg_rule);
 
 		if (!reg_info->reg_rules_6g_ap_ptr[i]) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 6g ap rules\n");
 			return -ENOMEM;
 		}
@@ -6061,7 +6041,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 							      ext_wmi_reg_rule);
 
 			if (!reg_info->reg_rules_6g_client_ptr[j][i]) {
-				kfree(tb);
 				ath12k_warn(ab, "Unable to Allocate memory for 6g client rules\n");
 				return -ENOMEM;
 			}
@@ -6096,7 +6075,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processed regulatory ext channel list\n");
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6107,7 +6085,7 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
 	const struct wmi_peer_delete_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6117,7 +6095,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
 	ev = tb[WMI_TAG_PEER_DELETE_RESP_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer delete resp ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6127,7 +6104,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
 	ether_addr_copy(peer_del_resp->peer_macaddr.addr,
 			ev->peer_macaddr.addr);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6139,7 +6115,7 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
 	const struct wmi_vdev_delete_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6149,13 +6125,11 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_VDEV_DELETE_RESP_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev delete resp ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
 	*vdev_id = le32_to_cpu(ev->vdev_id);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6167,7 +6141,7 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
 	const struct wmi_bcn_tx_status_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6177,14 +6151,12 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_OFFLOAD_BCN_TX_STATUS_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch bcn tx status ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
 	*vdev_id = le32_to_cpu(ev->vdev_id);
 	*tx_status = le32_to_cpu(ev->tx_status);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6195,7 +6167,7 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
 	const struct wmi_vdev_stopped_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6205,13 +6177,11 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
 	ev = tb[WMI_TAG_VDEV_STOPPED_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev stop ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
 	*vdev_id = le32_to_cpu(ev->vdev_id);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6350,7 +6320,7 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	const struct wmi_mgmt_tx_compl_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6360,7 +6330,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_MGMT_TX_COMPL_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch mgmt tx compl ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6370,7 +6339,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	param->ppdu_id = ev->ppdu_id;
 	param->ack_rssi = ev->ack_rssi;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6533,7 +6501,7 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_scan_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6543,7 +6511,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_SCAN_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch scan ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6555,7 +6522,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	scan_evt_param->vdev_id = ev->vdev_id;
 	scan_evt_param->tsf_timestamp = ev->tsf_timestamp;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6566,7 +6532,7 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	const struct wmi_peer_sta_kickout_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6576,7 +6542,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	ev = tb[WMI_TAG_PEER_STA_KICKOUT_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer sta kickout ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6584,7 +6549,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	arg->reason = le32_to_cpu(ev->reason);
 	arg->rssi = le32_to_cpu(ev->rssi);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6595,7 +6559,7 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_roam_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6605,7 +6569,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_ROAM_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch roam ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6613,7 +6576,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	roam_ev->reason = ev->reason;
 	roam_ev->rssi = ev->rssi;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6647,7 +6609,7 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_chan_info_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6657,7 +6619,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch chan info ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6674,7 +6635,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ch_info_ev->mac_clk_mhz = ev->mac_clk_mhz;
 	ch_info_ev->vdev_id = ev->vdev_id;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6686,7 +6646,7 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_pdev_bss_chan_info_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6696,7 +6656,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_PDEV_BSS_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev bss chan info ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6714,7 +6673,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	bss_ch_info_ev->rx_bss_cycle_count_low = ev->rx_bss_cycle_count_low;
 	bss_ch_info_ev->rx_bss_cycle_count_high = ev->rx_bss_cycle_count_high;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6726,7 +6684,7 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
 	const struct wmi_vdev_install_key_compl_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6736,7 +6694,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
 	ev = tb[WMI_TAG_VDEV_INSTALL_KEY_COMPLETE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev install key compl ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6746,7 +6703,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
 	arg->key_flags = le32_to_cpu(ev->key_flags);
 	arg->status = le32_to_cpu(ev->status);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6757,7 +6713,7 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
 	const struct wmi_peer_assoc_conf_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6767,14 +6723,12 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
 	ev = tb[WMI_TAG_PEER_ASSOC_CONF_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer assoc conf ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
 	peer_assoc_conf->vdev_id = le32_to_cpu(ev->vdev_id);
 	peer_assoc_conf->macaddr = ev->peer_macaddr.addr;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6792,7 +6746,7 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
 	const void **tb;
 	int ret, i;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6801,7 +6755,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
 
 	ev = tb[WMI_TAG_11D_NEW_COUNTRY_EVENT];
 	if (!ev) {
-		kfree(tb);
 		ath12k_warn(ab, "failed to fetch 11d new cc ev");
 		return -EPROTO;
 	}
@@ -6814,8 +6767,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
 		   ab->new_alpha2[0],
 		   ab->new_alpha2[1]);
 
-	kfree(tb);
-
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
@@ -8567,7 +8518,7 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 	const struct wmi_pdev_ctl_failsafe_chk_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8577,7 +8528,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev ctl failsafe check ev");
-		kfree(tb);
 		return;
 	}
 
@@ -8591,8 +8541,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 	if (ev->ctl_failsafe_status != 0)
 		ath12k_warn(ab, "pdev ctl failsafe failure status %d",
 			    ev->ctl_failsafe_status);
-
-	kfree(tb);
 }
 
 static void
@@ -8664,7 +8612,7 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
 	const u32 *vdev_ids;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8676,7 +8624,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
 
 	if (!ev || !vdev_ids) {
 		ath12k_warn(ab, "failed to fetch pdev csa switch count ev");
-		kfree(tb);
 		return;
 	}
 
@@ -8686,8 +8633,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
 		   ev->num_vdevs);
 
 	ath12k_wmi_process_csa_switch_count_event(ab, ev, vdev_ids);
-
-	kfree(tb);
 }
 
 static void
@@ -8699,7 +8644,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 	struct ath12k *ar;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8710,7 +8655,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev dfs radar detected ev");
-		kfree(tb);
 		return;
 	}
 
@@ -8749,8 +8693,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 
 exit:
 	rcu_read_unlock();
-
-	kfree(tb);
 }
 
 static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
@@ -8761,7 +8703,7 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
 	int ret;
 	u16 length;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
@@ -8772,14 +8714,11 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
 	ev = tb[WMI_TAG_ARRAY_BYTE];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch ftm msg\n");
-		kfree(tb);
 		return;
 	}
 
 	length = skb->len - TLV_HDR_SIZE;
 	ath12k_tm_process_event(ab, cmd_id, ev, length);
-	kfree(tb);
-	tb = NULL;
 }
 
 static void
@@ -8792,7 +8731,7 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 	int temp;
 	u32 pdev_id;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ath12k_warn(ab, "failed to parse tlv: %ld\n", PTR_ERR(tb));
 		return;
@@ -8801,15 +8740,12 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev temp ev\n");
-		kfree(tb);
 		return;
 	}
 
 	temp = a_sle32_to_cpu(ev->temp);
 	pdev_id = le32_to_cpu(ev->pdev_id);
 
-	kfree(tb);
-
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
 		   "pdev temperature ev temp %d pdev_id %u\n",
 		   temp, pdev_id);
@@ -8836,7 +8772,7 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
 	const struct wmi_fils_discovery_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab,
@@ -8848,15 +8784,12 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_HOST_SWFDA_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch FILS discovery event\n");
-		kfree(tb);
 		return;
 	}
 
 	ath12k_warn(ab,
 		    "FILS discovery frame expected from host for vdev_id: %u, transmission scheduled at %u, next TBTT: %u\n",
 		    ev->vdev_id, ev->fils_tt, ev->tbtt);
-
-	kfree(tb);
 }
 
 static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
@@ -8866,7 +8799,7 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 	const struct wmi_probe_resp_tx_status_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab,
@@ -8879,7 +8812,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 	if (!ev) {
 		ath12k_warn(ab,
 			    "failed to fetch probe response transmission status event");
-		kfree(tb);
 		return;
 	}
 
@@ -8887,8 +8819,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 		ath12k_warn(ab,
 			    "Probe response transmission failed for vdev_id %u, status %u\n",
 			    ev->vdev_id, ev->tx_status);
-
-	kfree(tb);
 }
 
 static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
@@ -8900,7 +8830,7 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
 	struct ath12k *ar;
 	int ret, vdev_id;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse P2P NoA TLV: %d\n", ret);
@@ -8910,10 +8840,8 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_P2P_NOA_EVENT];
 	noa = tb[WMI_TAG_P2P_NOA_INFO];
 
-	if (!ev || !noa) {
-		ret = -EPROTO;
-		goto out;
-	}
+	if (!ev || !noa)
+		return -EPROTO;
 
 	vdev_id = __le32_to_cpu(ev->vdev_id);
 
@@ -8936,8 +8864,6 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
 
 unlock:
 	rcu_read_unlock();
-out:
-	kfree(tb);
 	return ret;
 }
 
@@ -8948,7 +8874,7 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8956,10 +8882,8 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	}
 
 	ev = tb[WMI_TAG_RFKILL_EVENT];
-	if (!ev) {
-		kfree(tb);
+	if (!ev)
 		return;
-	}
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
@@ -8972,7 +8896,6 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	spin_unlock_bh(&ab->base_lock);
 
 	queue_work(ab->workqueue, &ab->rfkill_work);
-	kfree(tb);
 }
 
 static void
@@ -8988,7 +8911,7 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
 	const struct wmi_twt_enable_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse wmi twt enable status event tlv: %d\n",
@@ -8999,15 +8922,12 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_TWT_ENABLE_COMPLETE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch twt enable wmi event\n");
-		goto exit;
+		return;
 	}
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt enable event pdev id %u status %u\n",
 		   le32_to_cpu(ev->pdev_id),
 		   le32_to_cpu(ev->status));
-
-exit:
-	kfree(tb);
 }
 
 static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
@@ -9017,7 +8937,7 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
 	const struct wmi_twt_disable_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse wmi twt disable status event tlv: %d\n",
@@ -9028,15 +8948,12 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch twt disable wmi event\n");
-		goto exit;
+		return;
 	}
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC, "wmi twt disable event pdev id %d status %u\n",
 		   le32_to_cpu(ev->pdev_id),
 		   le32_to_cpu(ev->status));
-
-exit:
-	kfree(tb);
 }
 
 static int ath12k_wmi_wow_wakeup_host_parse(struct ath12k_base *ab,
@@ -9109,7 +9026,7 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -9119,7 +9036,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_GTK_OFFLOAD_STATUS_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch gtk offload status ev");
-		kfree(tb);
 		return;
 	}
 
@@ -9129,7 +9045,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 		rcu_read_unlock();
 		ath12k_warn(ab, "failed to get arvif for vdev_id:%d\n",
 			    le32_to_cpu(ev->vdev_id));
-		kfree(tb);
 		return;
 	}
 
@@ -9145,8 +9060,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 				   (void *)&replay_ctr_be, GFP_ATOMIC);
 
 	rcu_read_unlock();
-
-	kfree(tb);
 }
 
 static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
@@ -9158,7 +9071,7 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
 	const void **tb;
 	int ret, i;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse mlo setup complete event tlv: %d\n",
@@ -9169,7 +9082,6 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_MLO_SETUP_COMPLETE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch mlo setup complete event\n");
-		kfree(tb);
 		return;
 	}
 
@@ -9188,14 +9100,11 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
 	if (!ar) {
 		ath12k_warn(ab, "invalid pdev_id %d status %u in setup complete event\n",
 			    ev->pdev_id, ev->status);
-		goto out;
+		return;
 	}
 
 	ar->mlo_setup_status = le32_to_cpu(ev->status);
 	complete(&ar->mlo_setup_done);
-
-out:
-	kfree(tb);
 }
 
 static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
@@ -9205,7 +9114,7 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse teardown complete event tlv: %d\n", ret);
@@ -9215,11 +9124,8 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_MLO_TEARDOWN_COMPLETE];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch teardown complete event\n");
-		kfree(tb);
 		return;
 	}
-
-	kfree(tb);
 }
 
 #ifdef CONFIG_ATH12K_DEBUGFS
-- 
2.53.0


