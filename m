Return-Path: <linux-wireless+bounces-34335-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM2zI9DPz2m50gYAu9opvQ
	(envelope-from <linux-wireless+bounces-34335-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 16:33:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D2F395469
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 344273007E22
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC143A3E96;
	Fri,  3 Apr 2026 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="priP8ox7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC05372B57
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226526; cv=none; b=oSpR66dYeFoyBZ9mainuk+Ntp52bLPtGEnqFnw6zLPzkp44CgFwLazpUT4oU0OEQ2snFCKZHsP5PoG2E9a+nt78KYxWl8QYb6XP1nMqFDwGAfENIa5Y2G34nIBHKslkfO2GM7AWUB71qql+pT/tRB59v8XLX4Ow+Yl3Dgwo8BLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226526; c=relaxed/simple;
	bh=RJ6BfBs2cg5fVezKtqw8Bob69Xqa3EmITQDtJKX7JGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODYx9dqmxydKuV0/+q2xt8Du09zgDf5Md+ceypc6h8INIoiGxZkYtL1VQIXP1P1jfOIqWjWKnlDZs2YKY+oIs00QLrC0h6n+puSkXL/2zwhqly8F9eysdssBIVZppQ5DewUFzEaOfZVq1kwCGpOPGUlWYpf2HGzD40u1/YzPXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=priP8ox7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so15042115e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775226522; x=1775831322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=suEtQKUX6Z61pg63PiNop+AK0vw5RMvZBTGJaTl/P3c=;
        b=priP8ox7CMmAd+oUl1KYYEnWDj6g/V0dVX9SdjkCykQrT0FdEI532e3g5d6dThNvP6
         L3kU2Dm2XjFvikf58pcLdJ7oO725ob+GDno7qnDtP4veVjg3B1cnYULkH3J9m4hLtcHA
         9f5KkStIm+7Z2MuS1zPt8qkd33bGhhBXmMJRgScp4bwxJ6JQ2uaHlsRHIUNR1hDS0Qls
         ZjzxyTpp92WvCsGfAk4Rk2UJeU3/sSaQCSqeRMXF37SZcfpkUaSjEK9g+B62u5VznVKX
         6W0dCkGbHK0cQQJh7G3zU0VAVuzwyZfchFRlrXXGopHfDlM1eJH5w6i+W4kaWe3PwsRk
         KMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226522; x=1775831322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suEtQKUX6Z61pg63PiNop+AK0vw5RMvZBTGJaTl/P3c=;
        b=c41G2vyCd0XQzj50LQryq2WxZ50S278mlEqulh2LbfD8Zb4XbI1Z2kDRqmjnxa7izb
         SxUiWw8NIbnwQDhVImoeTqYwpmg4CS07oDJ6vHh80OkltWeY93pOVOie77aImOjDMxyy
         FSl+lpZRimZ3zg2MXGsNpuzhlVsy3typtRtjWZ34rbjAR+cPgOiHQzMB/N2Kc8iccf7r
         A/ZpFM9bsx7VIszvj31F3zzH9OFc7ZceFfd3BlVFUUkUuY2+xXr3HCjfU8CVYeS+NWVJ
         I5TN8mafCU0Y+RDuhNu0JhKgolvsc24b2RzaxxUtbUh4x1f7v73jx1oy5CmAY9YatGpf
         cS8A==
X-Gm-Message-State: AOJu0YyKhDFUJ2QiKkhF+YG+ygOq0EZjXJzDs4QCGLB22IU1QScnX4QN
	b/WbmM/P67nrn+X+Rn59Yb7iACEf4iRFtsvVkGXhAcfTi/JpDdrNaDuBFO1Gkg==
X-Gm-Gg: ATEYQzzrKV3zWdaQTkJN83YYL9IyDuaFQlbjNe16fQ9m9UrSkdE+NekBGQvNWOkcrK8
	pw9UXgjzHaMvx6BBtpK4UrbjANL/ZfNb2o8cZnfTrI2xg3wdHNEFdkddwLz3SNQHhiMdQ5pxkdm
	Vi+8BHv6OCmQZFDBmQ1+my9kskz3PJZNTqSfQ6UjPx1T8Ha5fV108wD2t5fY+ETfdxVH9c6V2co
	3QohmTa341GqsffUJeziNBsrJt4St0RNt27w8tec6o4CKn6mA6NKjMroABBIe0ee24ANTKBmlrJ
	uFAI6j8WaIXrZquv+wokSqIdVl+JBp6CMmdFi8HhbN8duzJ3B7H1X0DK6qbX4PvuLUhi6229Q8A
	5bRwLVOv7n5n26ttXOpIRO9JMCuIRQ/4b7c1sMc94E/S7Lk325nc6HzpY23DuJohJr/Y1c7Hvb1
	3rdZtsl/+HSQQSYapjTn8jGbWpAF2KgHGNMBKKy7t4SV0t6lLAUTzOFTgq
X-Received: by 2002:a05:600c:4e42:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-4889949c0f1mr50132195e9.10.1775226521934;
        Fri, 03 Apr 2026 07:28:41 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e49229sm20926785e9.15.2026.04.03.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:28:41 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v6] wifi: ath12k: avoid dynamic alloc when parsing wmi tb
Date: Fri,  3 Apr 2026 16:28:41 +0200
Message-ID: <20260403142841.1105780-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-34335-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4D2F395469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On each WMI message received from the hardware, we alloc a temporary array
of WMI_TAG_MAX entries of type void *. This array is then populated with
pointers of parsed structs depending on the WMI type, and then freed. This
alloc can fail when memory pressure in the system is high enough.

Given the fact that it is scheduled in softirq with the system_bh_wq, we
should not be able to parse more than one WMI message per CPU at any time.

So instead lets move to a per cpu allocated array, that is reused across
calls. This memory is allocated as needed and refcounted to exist only
as long as one struct ath12k_base lives.

ath12k_wmi_tlv_parse_alloc() and ath12k_wmi_tlv_parse() are merged
together as it no longer allocs mem but returns the existing per-cpu one.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
changes from v4:
  - moved to a single instance, refcounted per cpu memory alloc
  
changes from v3:
  - simplified ath12k_core_init() with a single statement
  - move perpcu.h include directly to wmi.c

changes from v2:
  - removed now superfluous return in ath12k_wmi_event_teardown_complete()
  - moved ath12k_wmi_tb declaration to wmi.c & added two functions to
    alloc / free it
  - removed useless error message on memory allocation failure

changes from v1:
  - rebased on ath-next 27401c9b1432
  - changed wording according to Jeff's comment
  - moved alloc/cleanup to new module_init/exit functions in the
    ath12k module as per Baochen's comment

changes from RFC:
  - rebased on ath-next 8e0ab5b9adb7
  - converted missing call sites ath12k_wmi_obss_color_collision_event()
    & ath12k_wmi_pdev_temperature_event()
  - changed alloc order & cleanup path in ath12k_core_alloc() as it seems
    it confused people
  - used sizeof(*tb) in ath12k_wmi_tlv_parse()
---
 drivers/net/wireless/ath/ath12k/core.c |   6 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 214 +++++++++----------------
 drivers/net/wireless/ath/ath12k/wmi.h  |   3 +
 3 files changed, 84 insertions(+), 139 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index c31c47fb5a73..6f0f4bfbf699 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -2256,6 +2256,7 @@ void ath12k_core_deinit(struct ath12k_base *ab)
 void ath12k_core_free(struct ath12k_base *ab)
 {
 	timer_delete_sync(&ab->rx_replenish_retry);
+	ath12k_wmi_free();
 	destroy_workqueue(ab->workqueue_aux);
 	destroy_workqueue(ab->workqueue);
 	kfree(ab);
@@ -2280,6 +2281,9 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	if (!ab->workqueue_aux)
 		goto err_free_wq;
 
+	if (ath12k_wmi_alloc() < 0)
+		goto err_free_wq_aux;
+
 	mutex_init(&ab->core_lock);
 	spin_lock_init(&ab->base_lock);
 	init_completion(&ab->reset_complete);
@@ -2314,6 +2318,8 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 
 	return ab;
 
+err_free_wq_aux:
+	destroy_workqueue(ab->workqueue_aux);
 err_free_wq:
 	destroy_workqueue(ab->workqueue);
 err_sc_free:
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 65a05a9520ff..2641a76e9543 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -15,6 +15,8 @@
 #include <linux/time.h>
 #include <linux/of.h>
 #include <linux/cleanup.h>
+#include <linux/percpu.h>
+#include <linux/refcount.h>
 #include "core.h"
 #include "debugfs.h"
 #include "debug.h"
@@ -134,6 +136,10 @@ struct wmi_pdev_set_obss_bitmap_arg {
 	const char *label;
 };
 
+static DEFINE_MUTEX(ath12k_wmi_mutex);
+static refcount_t ath12k_wmi_refcount = REFCOUNT_INIT(0);
+static void __percpu *ath12k_wmi_tb = NULL;
+
 static const struct ath12k_wmi_tlv_policy ath12k_wmi_tlv_policies[] = {
 	[WMI_TAG_ARRAY_BYTE] = { .min_len = 0 },
 	[WMI_TAG_ARRAY_UINT32] = { .min_len = 0 },
@@ -289,29 +295,19 @@ static int ath12k_wmi_tlv_iter_parse(struct ath12k_base *ab, u16 tag, u16 len,
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
+	tb = this_cpu_ptr(ath12k_wmi_tb);
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
@@ -3911,9 +3907,10 @@ ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *sk
 	const struct wmi_obss_color_collision_event *ev;
 	struct ath12k_link_vif *arvif;
 	u32 vdev_id, evt_type;
+	const void **tb;
 	u64 bitmap;
 
-	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
 			    PTR_ERR(tb));
@@ -5714,7 +5711,7 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
 	const struct wmi_vdev_start_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5724,13 +5721,11 @@ static int ath12k_pull_vdev_start_resp_tlv(struct ath12k_base *ab, struct sk_buf
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
 
@@ -5809,7 +5804,7 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processing regulatory ext channel list\n");
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -5819,7 +5814,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_REG_CHAN_LIST_CC_EXT_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch reg chan list ext update ev\n");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -5849,7 +5843,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 	if (num_2g_reg_rules > MAX_REG_RULES || num_5g_reg_rules > MAX_REG_RULES) {
 		ath12k_warn(ab, "Num reg rules for 2G/5G exceeds max limit (num_2g_reg_rules: %d num_5g_reg_rules: %d max_rules: %d)\n",
 			    num_2g_reg_rules, num_5g_reg_rules, MAX_REG_RULES);
-		kfree(tb);
 		return -EINVAL;
 	}
 
@@ -5859,7 +5852,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 		if (num_6g_reg_rules_ap[i] > MAX_6GHZ_REG_RULES) {
 			ath12k_warn(ab, "Num 6G reg rules for AP mode(%d) exceeds max limit (num_6g_reg_rules_ap: %d, max_rules: %d)\n",
 				    i, num_6g_reg_rules_ap[i], MAX_6GHZ_REG_RULES);
-			kfree(tb);
 			return -EINVAL;
 		}
 
@@ -5884,14 +5876,12 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
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
 
@@ -5993,7 +5983,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						      ext_wmi_reg_rule);
 
 		if (!reg_info->reg_rules_2g_ptr) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 2g rules\n");
 			return -ENOMEM;
 		}
@@ -6027,7 +6016,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						      ext_wmi_reg_rule);
 
 		if (!reg_info->reg_rules_5g_ptr) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 5g rules\n");
 			return -ENOMEM;
 		}
@@ -6046,7 +6034,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 						      ext_wmi_reg_rule);
 
 		if (!reg_info->reg_rules_6g_ap_ptr[i]) {
-			kfree(tb);
 			ath12k_warn(ab, "Unable to Allocate memory for 6g ap rules\n");
 			return -ENOMEM;
 		}
@@ -6061,7 +6048,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 							      ext_wmi_reg_rule);
 
 			if (!reg_info->reg_rules_6g_client_ptr[j][i]) {
-				kfree(tb);
 				ath12k_warn(ab, "Unable to Allocate memory for 6g client rules\n");
 				return -ENOMEM;
 			}
@@ -6096,7 +6082,6 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
 
 	ath12k_dbg(ab, ATH12K_DBG_WMI, "processed regulatory ext channel list\n");
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6107,7 +6092,7 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
 	const struct wmi_peer_delete_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6117,7 +6102,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
 	ev = tb[WMI_TAG_PEER_DELETE_RESP_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer delete resp ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6127,7 +6111,6 @@ static int ath12k_pull_peer_del_resp_ev(struct ath12k_base *ab, struct sk_buff *
 	ether_addr_copy(peer_del_resp->peer_macaddr.addr,
 			ev->peer_macaddr.addr);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6139,7 +6122,7 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
 	const struct wmi_vdev_delete_resp_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6149,13 +6132,11 @@ static int ath12k_pull_vdev_del_resp_ev(struct ath12k_base *ab,
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
 
@@ -6167,7 +6148,7 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
 	const struct wmi_bcn_tx_status_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6177,14 +6158,12 @@ static int ath12k_pull_bcn_tx_status_ev(struct ath12k_base *ab,
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
 
@@ -6195,7 +6174,7 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
 	const struct wmi_vdev_stopped_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6205,13 +6184,11 @@ static int ath12k_pull_vdev_stopped_param_tlv(struct ath12k_base *ab, struct sk_
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
 
@@ -6350,7 +6327,7 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	const struct wmi_mgmt_tx_compl_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6360,7 +6337,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_MGMT_TX_COMPL_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch mgmt tx compl ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6370,7 +6346,6 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	param->ppdu_id = ev->ppdu_id;
 	param->ack_rssi = ev->ack_rssi;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6533,7 +6508,7 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_scan_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6543,7 +6518,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_SCAN_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch scan ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6555,7 +6529,6 @@ static int ath12k_pull_scan_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	scan_evt_param->vdev_id = ev->vdev_id;
 	scan_evt_param->tsf_timestamp = ev->tsf_timestamp;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6566,7 +6539,7 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	const struct wmi_peer_sta_kickout_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6576,7 +6549,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	ev = tb[WMI_TAG_PEER_STA_KICKOUT_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch peer sta kickout ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6584,7 +6556,6 @@ static int ath12k_pull_peer_sta_kickout_ev(struct ath12k_base *ab, struct sk_buf
 	arg->reason = le32_to_cpu(ev->reason);
 	arg->rssi = le32_to_cpu(ev->rssi);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6595,7 +6566,7 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_roam_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6605,7 +6576,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_ROAM_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch roam ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6613,7 +6583,6 @@ static int ath12k_pull_roam_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	roam_ev->reason = ev->reason;
 	roam_ev->rssi = ev->rssi;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6647,7 +6616,7 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_chan_info_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6657,7 +6626,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch chan info ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6674,7 +6642,6 @@ static int ath12k_pull_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ch_info_ev->mac_clk_mhz = ev->mac_clk_mhz;
 	ch_info_ev->vdev_id = ev->vdev_id;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6686,7 +6653,7 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	const struct wmi_pdev_bss_chan_info_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6696,7 +6663,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	ev = tb[WMI_TAG_PDEV_BSS_CHAN_INFO_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev bss chan info ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6714,7 +6680,6 @@ ath12k_pull_pdev_bss_chan_info_ev(struct ath12k_base *ab, struct sk_buff *skb,
 	bss_ch_info_ev->rx_bss_cycle_count_low = ev->rx_bss_cycle_count_low;
 	bss_ch_info_ev->rx_bss_cycle_count_high = ev->rx_bss_cycle_count_high;
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6726,7 +6691,7 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
 	const struct wmi_vdev_install_key_compl_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6736,7 +6701,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
 	ev = tb[WMI_TAG_VDEV_INSTALL_KEY_COMPLETE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch vdev install key compl ev");
-		kfree(tb);
 		return -EPROTO;
 	}
 
@@ -6746,7 +6710,6 @@ ath12k_pull_vdev_install_key_compl_ev(struct ath12k_base *ab, struct sk_buff *sk
 	arg->key_flags = le32_to_cpu(ev->key_flags);
 	arg->status = le32_to_cpu(ev->status);
 
-	kfree(tb);
 	return 0;
 }
 
@@ -6757,7 +6720,7 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
 	const struct wmi_peer_assoc_conf_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6767,14 +6730,12 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
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
 
@@ -6792,7 +6753,7 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
 	const void **tb;
 	int ret, i;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -6801,7 +6762,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
 
 	ev = tb[WMI_TAG_11D_NEW_COUNTRY_EVENT];
 	if (!ev) {
-		kfree(tb);
 		ath12k_warn(ab, "failed to fetch 11d new cc ev");
 		return -EPROTO;
 	}
@@ -6814,8 +6774,6 @@ static int ath12k_reg_11d_new_cc_event(struct ath12k_base *ab, struct sk_buff *s
 		   ab->new_alpha2[0],
 		   ab->new_alpha2[1]);
 
-	kfree(tb);
-
 	for (i = 0; i < ab->num_radios; i++) {
 		pdev = &ab->pdevs[i];
 		ar = pdev->ar;
@@ -8557,7 +8515,7 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 	const struct wmi_pdev_ctl_failsafe_chk_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8567,7 +8525,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev ctl failsafe check ev");
-		kfree(tb);
 		return;
 	}
 
@@ -8581,8 +8538,6 @@ static void ath12k_pdev_ctl_failsafe_check_event(struct ath12k_base *ab,
 	if (ev->ctl_failsafe_status != 0)
 		ath12k_warn(ab, "pdev ctl failsafe failure status %d",
 			    ev->ctl_failsafe_status);
-
-	kfree(tb);
 }
 
 static void
@@ -8654,7 +8609,7 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
 	const u32 *vdev_ids;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8666,7 +8621,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
 
 	if (!ev || !vdev_ids) {
 		ath12k_warn(ab, "failed to fetch pdev csa switch count ev");
-		kfree(tb);
 		return;
 	}
 
@@ -8676,8 +8630,6 @@ ath12k_wmi_pdev_csa_switch_count_status_event(struct ath12k_base *ab,
 		   ev->num_vdevs);
 
 	ath12k_wmi_process_csa_switch_count_event(ab, ev, vdev_ids);
-
-	kfree(tb);
 }
 
 static void
@@ -8689,7 +8641,7 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 	struct ath12k *ar;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8700,7 +8652,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch pdev dfs radar detected ev");
-		kfree(tb);
 		return;
 	}
 
@@ -8739,8 +8690,6 @@ ath12k_wmi_pdev_dfs_radar_detected_event(struct ath12k_base *ab, struct sk_buff
 
 exit:
 	rcu_read_unlock();
-
-	kfree(tb);
 }
 
 static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
@@ -8751,7 +8700,7 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
 	int ret;
 	u16 length;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
@@ -8762,14 +8711,11 @@ static void ath12k_tm_wmi_event_segmented(struct ath12k_base *ab, u32 cmd_id,
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
@@ -8782,7 +8728,7 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 	int temp;
 	u32 pdev_id;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ath12k_warn(ab, "failed to parse tlv: %ld\n", PTR_ERR(tb));
 		return;
@@ -8791,15 +8737,12 @@ ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
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
@@ -8826,7 +8769,7 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
 	const struct wmi_fils_discovery_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab,
@@ -8838,15 +8781,12 @@ static void ath12k_fils_discovery_event(struct ath12k_base *ab,
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
@@ -8856,7 +8796,7 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 	const struct wmi_probe_resp_tx_status_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab,
@@ -8869,7 +8809,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 	if (!ev) {
 		ath12k_warn(ab,
 			    "failed to fetch probe response transmission status event");
-		kfree(tb);
 		return;
 	}
 
@@ -8877,8 +8816,6 @@ static void ath12k_probe_resp_tx_status_event(struct ath12k_base *ab,
 		ath12k_warn(ab,
 			    "Probe response transmission failed for vdev_id %u, status %u\n",
 			    ev->vdev_id, ev->tx_status);
-
-	kfree(tb);
 }
 
 static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
@@ -8890,7 +8827,7 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
 	struct ath12k *ar;
 	int ret, vdev_id;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse P2P NoA TLV: %d\n", ret);
@@ -8900,10 +8837,8 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_P2P_NOA_EVENT];
 	noa = tb[WMI_TAG_P2P_NOA_INFO];
 
-	if (!ev || !noa) {
-		ret = -EPROTO;
-		goto out;
-	}
+	if (!ev || !noa)
+		return -EPROTO;
 
 	vdev_id = __le32_to_cpu(ev->vdev_id);
 
@@ -8926,8 +8861,6 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
 
 unlock:
 	rcu_read_unlock();
-out:
-	kfree(tb);
 	return ret;
 }
 
@@ -8938,7 +8871,7 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -8946,10 +8879,8 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	}
 
 	ev = tb[WMI_TAG_RFKILL_EVENT];
-	if (!ev) {
-		kfree(tb);
+	if (!ev)
 		return;
-	}
 
 	ath12k_dbg(ab, ATH12K_DBG_MAC,
 		   "wmi tlv rfkill state change gpio %d type %d radio_state %d\n",
@@ -8962,7 +8893,6 @@ static void ath12k_rfkill_state_change_event(struct ath12k_base *ab,
 	spin_unlock_bh(&ab->base_lock);
 
 	queue_work(ab->workqueue, &ab->rfkill_work);
-	kfree(tb);
 }
 
 static void
@@ -8978,7 +8908,7 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
 	const struct wmi_twt_enable_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse wmi twt enable status event tlv: %d\n",
@@ -8989,15 +8919,12 @@ static void ath12k_wmi_twt_enable_event(struct ath12k_base *ab,
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
@@ -9007,7 +8934,7 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
 	const struct wmi_twt_disable_event *ev;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse wmi twt disable status event tlv: %d\n",
@@ -9018,15 +8945,12 @@ static void ath12k_wmi_twt_disable_event(struct ath12k_base *ab,
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
@@ -9099,7 +9023,7 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
@@ -9109,7 +9033,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_GTK_OFFLOAD_STATUS_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch gtk offload status ev");
-		kfree(tb);
 		return;
 	}
 
@@ -9119,7 +9042,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 		rcu_read_unlock();
 		ath12k_warn(ab, "failed to get arvif for vdev_id:%d\n",
 			    le32_to_cpu(ev->vdev_id));
-		kfree(tb);
 		return;
 	}
 
@@ -9135,8 +9057,6 @@ static void ath12k_wmi_gtk_offload_status_event(struct ath12k_base *ab,
 				   (void *)&replay_ctr_be, GFP_ATOMIC);
 
 	rcu_read_unlock();
-
-	kfree(tb);
 }
 
 static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
@@ -9148,7 +9068,7 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
 	const void **tb;
 	int ret, i;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse mlo setup complete event tlv: %d\n",
@@ -9159,7 +9079,6 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
 	ev = tb[WMI_TAG_MLO_SETUP_COMPLETE_EVENT];
 	if (!ev) {
 		ath12k_warn(ab, "failed to fetch mlo setup complete event\n");
-		kfree(tb);
 		return;
 	}
 
@@ -9178,14 +9097,11 @@ static void ath12k_wmi_event_mlo_setup_complete(struct ath12k_base *ab,
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
@@ -9195,7 +9111,7 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
 	const void **tb;
 	int ret;
 
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	tb = ath12k_wmi_tlv_parse(ab, skb);
 	if (IS_ERR(tb)) {
 		ret = PTR_ERR(tb);
 		ath12k_warn(ab, "failed to parse teardown complete event tlv: %d\n", ret);
@@ -9203,13 +9119,8 @@ static void ath12k_wmi_event_teardown_complete(struct ath12k_base *ab,
 	}
 
 	ev = tb[WMI_TAG_MLO_TEARDOWN_COMPLETE];
-	if (!ev) {
+	if (!ev)
 		ath12k_warn(ab, "failed to fetch teardown complete event\n");
-		kfree(tb);
-		return;
-	}
-
-	kfree(tb);
 }
 
 #ifdef CONFIG_ATH12K_DEBUGFS
@@ -11239,3 +11150,28 @@ int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
 	dev_kfree_skb(skb);
 	return ret;
 }
+
+int ath12k_wmi_alloc(void)
+{
+	guard(mutex)(&ath12k_wmi_mutex);
+
+	if (!ath12k_wmi_tb) {
+		ath12k_wmi_tb = __alloc_percpu(WMI_TAG_MAX * sizeof(void *),
+					       __alignof__(void *));
+		if (!ath12k_wmi_tb)
+			return -ENOMEM;
+	}
+
+	refcount_inc(&ath12k_wmi_refcount);
+	return 0;
+}
+
+void ath12k_wmi_free(void)
+{
+	guard(mutex)(&ath12k_wmi_mutex);
+
+	if (refcount_dec_and_test(&ath12k_wmi_refcount)) {
+		free_percpu(ath12k_wmi_tb);
+		ath12k_wmi_tb = NULL;
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 5ba9b7d3a888..4a34b2ca99ea 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -6576,4 +6576,7 @@ int ath12k_wmi_send_vdev_set_tpc_power(struct ath12k *ar,
 				       struct ath12k_reg_tpc_power_info *param);
 int ath12k_wmi_send_mlo_link_set_active_cmd(struct ath12k_base *ab,
 					    struct wmi_mlo_link_set_active_arg *param);
+int ath12k_wmi_alloc(void);
+void ath12k_wmi_free(void);
+
 #endif
-- 
2.53.0


