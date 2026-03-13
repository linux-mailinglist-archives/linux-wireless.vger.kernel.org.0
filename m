Return-Path: <linux-wireless+bounces-33172-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OExeEyZXs2kRVQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33172-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:15:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A289027B7ED
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 01:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6D0A3145B57
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469118FC80;
	Fri, 13 Mar 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O76BbDku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A54F13A3ED
	for <linux-wireless@vger.kernel.org>; Fri, 13 Mar 2026 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773360897; cv=none; b=aTA07/ZuuPxl1w6ozqKaku8fer7QeiPWkEgo7zxgg3pqzM3Atar9Ks8KqPi5M+Trf0AejtMJRfz7RvipbeCN+o2Mc5lsCN+oiqi/+yn1A7phUEhzZLrY84f3mRPHHd22cJ++1IUabPS+fnp/KnkfOO1SR+GrpOy4v6KpxvNdrag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773360897; c=relaxed/simple;
	bh=MPvp3uLpYzLrrjOQiqIHZIR+DFjBEGgkZpOibNsBV8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/ao+NhHemRpJs4BvYaMb69mewBWhRJwGR3I+sO5gRiSWiN3yUkvU0En1Q3kWBR855OXUW+Zhv0hjMfdJwWDWUekIb9g2rXDYW+4XHb52LEu3cVuFsihyEAjigethZfXqvlYN7xsZupM2XEHqwvrZE1CBTEre9ZgggpDFDeVOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O76BbDku; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7985ce90542so17733047b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773360893; x=1773965693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc7T6F+QAAK7xJvWNMAT28cNkHEqvmKrsbYs4miggWQ=;
        b=O76BbDkuck5vvz7A8wf9+5wypQdsSgZjWV7PzA3HgzjIigk0kIoiKe/+dKdgiaQVAa
         Oe9kWixok3PxxopqDz8o9k8uW6ba66uZpRNJPV/amtcu99gS8lB6yE9bKY38FcSYIm1d
         2OCpRriHUduMKb4e0k2ET/4fB4MMzPQNogHP2NiZordYGC+sWEqLSkoSa0kXrIFVjqa3
         s349IlnEhNLI9Haf/lcFLmsCkUBe2L05bQP04i33zASuxAdW4IzGk8qllpqmDWgnrqGb
         5T7achmq+ebfl3Zl2GuKnAY1RJ2EVFuHD30q90ve+IcPvTCTSMsWTz3JZn7EuS9u1g/g
         /nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773360893; x=1773965693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc7T6F+QAAK7xJvWNMAT28cNkHEqvmKrsbYs4miggWQ=;
        b=pAN6aTVAskeaB0QmiCAWOybkxPZa1QENn+qB0l4+dnQfJ08VF3k9AKGY20svVtERr7
         gsnDK8EycJCK24w2tIClaiuBTGSZ4FMPlRPYWVHYBp+VAJXhcoGJrr7vzkYZExwnI+Nw
         Xey3larL2zC2xGpvG1w6gv6qgjp4aM2y41lhTWgaK4/wgTGOmLwA80q0Uaz4NRtXU5t1
         86uXeE1d0+ZozBHbCegwx3NUDHFq2YNeX2FBM5dGFHohV1rN3qdAyuEAZplCuWY29+bL
         Odx0s+0xvXXXF/xz2GF/aDylKSoxULB2LuYurlxvgi2/5rORJpNJyZsfLZNGclm+c2xA
         5ozA==
X-Gm-Message-State: AOJu0Yxc/DvfU8J6QdmTpJRoTD5hcJJmmXqaFeoMAiqL/9WYLJTqMkdS
	YnF1IY4Y31XfemCPv5KPppqT5tRhQMCwWH+NvkZpzniFt7uneel0I64psUaWLNED
X-Gm-Gg: ATEYQzzp4Kqd5Iu/CVg/GDiki5muyge+XqS82hF+ljXyNd0zPQ1zCg28k7iOkoAwjO6
	Ss081ehXxUBFViS5Mf9q+dgHtkjiP3hU/zmnY7I9vw4xym4NERRNh2EuIzDDkiBL62M1XDpGM72
	Vx3sMkr1LM8pmqft2efQ5sWavErdSc3Fi8K18rr/WyqN0svAvPr4AuhdK6hkdSeQdd/icQQtifH
	uAr+Md8XJ9FcFMsDt3LT5DWkhzPEVhIVHFHGRTUSwGOc/+g494kppkc8jdwrDfxFaG5W5j9p8ht
	DGaLE+YFzGHDXio3/TOmXEE4aP2r4fHOVrNB78JYH+3kodM5AAr7MIFsDSMLz1sDgY9DHM60vrl
	hJfcHy0ilCUirt2w1W1b3WWYQo7o1bVkA+xWD6pgyopTtH9zMlSwhWfjMcKJpm0YbHpbnABkYI6
	JcoILi/nMMLgsIz5zATjW+C88NAD5a1o69llrWw5HyEbXF+s78LwhfGnB7dyUcGBD2
X-Received: by 2002:a05:690c:6f13:b0:798:11ac:d0ac with SMTP id 00721157ae682-79a1c1e5451mr16754597b3.53.1773360893250;
        Thu, 12 Mar 2026 17:14:53 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917e1fa3esm41018377b3.18.2026.03.12.17.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 17:14:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH ath-next] wifi: ath12k: use kzalloc_flex
Date: Thu, 12 Mar 2026 17:14:34 -0700
Message-ID: <20260313001434.118010-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33172-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A289027B7ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++--------------------
 drivers/net/wireless/ath/ath12k/wmi.h |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 553ec28b6aaa..b7c43a64e37b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5611,12 +5611,14 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, n_channels);
 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}

+	arg->num_chan = n_channels;
+
 	ath12k_wmi_start_scan_init(ar, arg);
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH12K_SCAN_ID;
@@ -5638,18 +5640,8 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 		arg->scan_f_passive = 1;
 	}

-	if (n_channels) {
-		arg->num_chan = n_channels;
-		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-					 GFP_KERNEL);
-		if (!arg->chan_list) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-
-		for (i = 0; i < arg->num_chan; i++)
-			arg->chan_list[i] = chan_list[i]->center_freq;
-	}
+	for (i = 0; i < arg->num_chan; i++)
+		arg->chan_list[i] = chan_list[i]->center_freq;

 	ret = ath12k_start_scan(ar, arg);
 	if (ret) {
@@ -5674,7 +5666,6 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,

 exit:
 	if (arg) {
-		kfree(arg->chan_list);
 		kfree(arg->extraie.ptr);
 		kfree(arg);
 	}
@@ -13735,19 +13726,13 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;

 	struct ath12k_wmi_scan_req_arg *arg __free(kfree) =
-					kzalloc_obj(*arg);
+					kzalloc_flex(*arg, chan_list, 1);
 	if (!arg)
 		return -ENOMEM;

-	ath12k_wmi_start_scan_init(ar, arg);
 	arg->num_chan = 1;
+	ath12k_wmi_start_scan_init(ar, arg);

-	u32 *chan_list __free(kfree) = kcalloc(arg->num_chan, sizeof(*chan_list),
-					       GFP_KERNEL);
-	if (!chan_list)
-		return -ENOMEM;
-
-	arg->chan_list = chan_list;
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH12K_SCAN_ID;
 	arg->chan_list[0] = chan->center_freq;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 0bf0a7941cd3..190e7a4a92d0 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3586,7 +3586,6 @@ struct ath12k_wmi_scan_req_arg {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 *chan_list;
 	u32 notify_scan_events;
 	struct cfg80211_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
 	struct ath12k_wmi_mac_addr_params bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
@@ -3595,6 +3594,7 @@ struct ath12k_wmi_scan_req_arg {
 	u32 num_hint_bssid;
 	struct ath12k_wmi_hint_short_ssid_arg hint_s_ssid[WLAN_SCAN_MAX_HINT_S_SSID];
 	struct ath12k_wmi_hint_bssid_arg hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
+	u32 chan_list[] __counted_by(num_chan);
 };

 struct wmi_ssid_arg {
--
2.53.0


