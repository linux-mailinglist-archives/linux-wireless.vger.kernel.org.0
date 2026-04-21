Return-Path: <linux-wireless+bounces-35191-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO8DKnYE6Gl2EQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35191-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:12:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0616C440751
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 705A23056635
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878E3822AA;
	Tue, 21 Apr 2026 23:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRI9YAwP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88237AA9E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813144; cv=none; b=hrozopUFiYHXrGKopq9PxTFuqTgANxIoXhoVmzeR7mEqqFhCuW/vTvwTt/PjXyeJJxMQzQDVQk3Su1EfpJuIAL4OBdjmuJv7B8KWDJu2PlwYcRN+XACoFXmwt0UXdUQi+oJqm36UUmojFl5wlrzsL1or7/g4fjlqa2zNH6hv8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813144; c=relaxed/simple;
	bh=gpp9xmU85YlFb/u4oByGfsxZtY8GvWmQndeL55+bGKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYhucuiZyWWP2ORP8ObJOCC7SyWMwDbDO5i1degvxgVRdwt0W3niUb+Ztn3RGFvjuaLnN+SXNcL2+t5BSkrXdQqffuFzr5WEtdnH/IHWHYcRP7hXYEEpUrkrQMxb4Wpxsq4nnSVjunSiaNPVm+tscOmwHURepCvcjh7w9dqy/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRI9YAwP; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3286508a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776813142; x=1777417942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTFjozRKzlcsUeI3wET9p6IVNlwFbfMKkKPMEGBJgq8=;
        b=RRI9YAwPtcS3VFPVwr3ZDxaOJhi/WTERvXxBsnW8ojtwEn9e259j/NK9w+pViSK6PY
         m29WAIO9jd4onNbLXUzQOz10KrshW32dvnnvgjWD69c7yRGp0NwBVzH9Q/HZkwKrBcjX
         gn23EvjBaBi4zC8TWZbqEMWAZMiXN+it9J0Ij8AnDZ2ZpjCvLMWByJVl43hU3qOhhE+R
         Wj+ho7ZTJkSXdOcWHMwhBQbEWwX+ospBamj9I476tCT78ySmwY6cKDPxaN7ohuuSREVk
         pkQrlvkddO1mmi/tJDLP2tLihhxHoLUB/oossZ0SQOBoOBORtRkP6hZqFF0e6I+iSCJu
         jywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813142; x=1777417942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTFjozRKzlcsUeI3wET9p6IVNlwFbfMKkKPMEGBJgq8=;
        b=nmHhOtySjlDgmUCvvJt+ZIjlbHcnSJwZzl82jkwiWJ3NC5ji0xiiwIKkKPBrmaparb
         aSWGx1Cdwf6Mv8WPyG/I3XJfDINZ+P7ivMUCxWI8vWhUUXAmJmMx33I3xM2ZjzhQouWA
         qKkhOEUwBFF+3lVN4ufgbVllAoSxKwlMIh/wg06saeSmYcDrTmwZqvPZC/Ec6kAqOjGH
         6lTVeuV3m9hjUTHeI0GH2eecVO2eoZQFPPb9+018HNWNzJEKrc4J5mgELyGSiyWenM+O
         fakvpepa0AkG5Q869KDXB7G/+ktaiNSg8BOboEZNHXau027Bo90TeZ34fASJ7QGV2rrQ
         2C2w==
X-Gm-Message-State: AOJu0YzDXeZxPzZJ06GRLrT/02150l/whTEgOwsuD2bOWwLV9/fENjlz
	uXlvuTfJzPGS8ei1v9qY5BlcfnICXWOLn3ma9pSz+vwcJx1L2mZKxW6bWrhTrw==
X-Gm-Gg: AeBDieuM7VU7aC8FW1o2ueZj57krFk5Xqipz39ygTPQecYBDr5W0uok8sFdUlhy7Cx7
	Dyw/t4aIQPX8GTaM9UlPqjvzOY5DEWqEJPcPh0e3kn/mLyIe/ggeJBn36Drqzr6Q1OYqWcr9W2C
	KAgUUjgBICgb1qchmd6bLMDMhCHrHTeeyFYogFMQJ9sxfwi9bsxdyCHIfxgUWbZq1lBWmbsfUss
	G8LHEoX9OSpZuDVd5mCfIUPKGbeRnfI+Xwka+dZ/c/a+oBRqs2MhgobgJoLrdxX4soUMQqDVACt
	TzTo/qErgFsP/FoETpqFXE2xgPjcwGM0cK0tYd5cbz2BJNDalqK5OP3YUgOjELTsEQfbQPfk8Nx
	gsjct1Fxnc+5ihn6au7jfD8phtjAzz/uTiF5OVMt8aKekU6hSQlNnJG0gBki8NNcH0jBqysD7T2
	B/LhMIARko8svYDUk+MYWfZlpKLOjpi42XwKz8kF6HWxmOfHS3agPBgNa5yWH3v3kxBA==
X-Received: by 2002:a17:90b:3b89:b0:35f:b1f3:ac12 with SMTP id 98e67ed59e1d1-361403cb172mr19257134a91.4.1776813142527;
        Tue, 21 Apr 2026 16:12:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8be])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc575bsm14881131a91.4.2026.04.21.16.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:12:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 ath-next] wifi: ath11k: use kzalloc_flex
Date: Tue, 21 Apr 2026 16:12:05 -0700
Message-ID: <20260421231205.77361-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35191-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0616C440751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation before any potential accesses.
kzalloc_flex does this anyway for GCC >= 15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: reword counting variable comment.
 drivers/net/wireless/ath/ath11k/mac.c | 71 ++++++++++-----------------
 drivers/net/wireless/ath/ath11k/wmi.h |  2 +-
 2 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4a68bb9ca4fa..b5f3d7221b5f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4228,13 +4228,14 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, req->n_channels);

 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}

+	arg->num_chan = req->n_channels;
 	ath11k_wmi_start_scan_init(ar, arg);
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH11K_SCAN_ID;
@@ -4262,38 +4263,27 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		arg->scan_f_passive = 1;
 	}

-	if (req->n_channels) {
-		arg->num_chan = req->n_channels;
-		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-					 GFP_KERNEL);
+	for (i = 0; i < arg->num_chan; i++) {
+		if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
+			     ar->ab->wmi_ab.svc_map)) {
+			arg->chan_list[i] =
+				u32_encode_bits(req->channels[i]->center_freq,
+						WMI_SCAN_CONFIG_PER_CHANNEL_MASK);

-		if (!arg->chan_list) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-
-		for (i = 0; i < arg->num_chan; i++) {
-			if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
-				     ar->ab->wmi_ab.svc_map)) {
-				arg->chan_list[i] =
-					u32_encode_bits(req->channels[i]->center_freq,
-							WMI_SCAN_CONFIG_PER_CHANNEL_MASK);
-
-				/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
-				 * flags, then scan all PSC channels in 6 GHz band and
-				 * those non-PSC channels where RNR IE is found during
-				 * the legacy 2.4/5 GHz scan.
-				 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
-				 * then all channels in 6 GHz will be scanned.
-				 */
-				if (req->channels[i]->band == NL80211_BAND_6GHZ &&
-				    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
-				    !cfg80211_channel_is_psc(req->channels[i]))
-					arg->chan_list[i] |=
-						WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
-			} else {
-				arg->chan_list[i] = req->channels[i]->center_freq;
-			}
+			/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
+			 * flags, then scan all PSC channels in 6 GHz band and
+			 * those non-PSC channels where RNR IE is found during
+			 * the legacy 2.4/5 GHz scan.
+			 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
+			 * then all channels in 6 GHz will be scanned.
+			 */
+			if (req->channels[i]->band == NL80211_BAND_6GHZ &&
+			    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
+			    !cfg80211_channel_is_psc(req->channels[i]))
+				arg->chan_list[i] |=
+					WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
+		} else {
+			arg->chan_list[i] = req->channels[i]->center_freq;
 		}
 	}

@@ -9736,19 +9726,14 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,

 	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, 1);
 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}
-	ath11k_wmi_start_scan_init(ar, arg);
+
 	arg->num_chan = 1;
-	arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-				 GFP_KERNEL);
-	if (!arg->chan_list) {
-		ret = -ENOMEM;
-		goto free_arg;
-	}
+	ath11k_wmi_start_scan_init(ar, arg);

 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH11K_SCAN_ID;
@@ -9769,7 +9754,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH11K_SCAN_IDLE;
 		spin_unlock_bh(&ar->data_lock);
-		goto free_chan_list;
+		goto free_arg;
 	}

 	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
@@ -9779,7 +9764,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "failed to stop scan: %d\n", ret);
 		ret = -ETIMEDOUT;
-		goto free_chan_list;
+		goto free_arg;
 	}

 	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
@@ -9787,8 +9772,6 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,

 	ret = 0;

-free_chan_list:
-	kfree(arg->chan_list);
 free_arg:
 	kfree(arg);
 exit:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index baed501b640b..b2dade0516ac 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3423,7 +3423,6 @@ struct scan_req_params {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 *chan_list;
 	u32 notify_scan_events;
 	struct wlan_ssid ssid[WLAN_SCAN_PARAMS_MAX_SSID];
 	struct wmi_mac_addr bssid_list[WLAN_SCAN_PARAMS_MAX_BSSID];
@@ -3436,6 +3435,7 @@ struct scan_req_params {
 	struct hint_bssid hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
 	struct wmi_mac_addr mac_addr;
 	struct wmi_mac_addr mac_mask;
+	u32 chan_list[] __counted_by(num_chan);
 };

 struct wmi_ssid_arg {
--
2.53.0


