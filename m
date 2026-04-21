Return-Path: <linux-wireless+bounces-35188-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHcxBR7u52mhCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35188-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:37:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6077143FC95
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7153305E9E1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 21:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790C3DCDB1;
	Tue, 21 Apr 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXO9/kcq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD73783C4
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807364; cv=none; b=b1keiKUuANJkIafMtTt5LAKmV98hiNCpQeqb5G9O3os1NAMixJp42G0kqfRIv43VrQSKLW6osMFbUfdq92ktNfoPzCyx8Z1kPLxO4EZbsytrqw6JiTeldworVeCu6f/hmQKFn0H756sLTSJ+HXy9CoK4+1JxFl8qNUldXQaDnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807364; c=relaxed/simple;
	bh=9I5kveaAdNuut0UZl02P16NYapFegdWhGD5fkgRUZTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUJl3bZGj4vu28kH/sqGP5RyCUlPF6x8P+6KgPAFVFsVXjQ9QItzhyyt6EuZrUT12iB3Q6PZzHvfVBWT1/mKLY5zAyNr56bSnZTpdv2L41ARs0rY6SwV+lOQT3nHrAXTxCPUxAa6/BygO7tLrPF8AzXFeh9hSm87Y9nVrSvzMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXO9/kcq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so2713336a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776807362; x=1777412162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXmPZkb/Svwu6Il6bmZz1uAoo07kk+9/HvI68DRq0LI=;
        b=NXO9/kcqjqml/jhDCJ9NWVoHNi1oWnaz98qerEqtJYIb+HHK7e/4H+WQ61hlte1nWB
         1CwWTkfSomjXmnsIIvwFz2dKV33WHKSncO96NxLfpwmk6j5IPUPOpOIDlbl6G/35pdDh
         AClvcdV9Ac7Ps5kKojBsiigdaE4zS9IVoJaxk4jFeHoRGx2wwSUdHzUPxakhoSUKgv+e
         Gp7JorTH7+0nMn/4WzMwwoX/fUs5w2lRC1nU7iRXMnka4c7lhwmT+EacA6DxIyAysd9P
         BdxgvwMQaEm5rZZirbtDIdJnXyJOssHgPTYws8kbkV8ZlPleTnXqofRUIrXimURI5TF5
         CtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807362; x=1777412162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXmPZkb/Svwu6Il6bmZz1uAoo07kk+9/HvI68DRq0LI=;
        b=h2IySCSrXaaTFkAaCvBbn8/Tv2qTFAydNcDp+ioDTMJyUpTVCHlAbpefKnvaQwPirn
         ekrraJBXJqaUrrAwJclphtr2QeSIHwpicI7A0A2drcRhuZrBjeWne3iC7r+U3JtYXskh
         dBWDacpxeCFR+1f3D21y/6qlQ5u1YBdJlO3fJJj/GWOgDMx5nLFPcqihB3am3dQ0DGek
         1eOYDvF5/dPvXzytFxRnuNYQpZtkdaBVtuHu1gruyFSiEtHCIf8+LT+Vo0YVyRKiKgQR
         Y7m7f+mpc/tAl8PobmUBqdYVrJFDjYBEksCtySE3C/p5ZcCTOMnVr/Yis3zf9UwSVFXk
         FKSA==
X-Gm-Message-State: AOJu0YzNW9eApYc8FlhfKTeEhGXAI62OGNx8+fAZWZHqVY4+E/EmitU7
	3OCDNrpM+/CvTq+pI+nMxWBiRQnog6ZB0Ymgc5hag5Q6r16dfgbU5ZPk3vZFcQ==
X-Gm-Gg: AeBDievqUvU8XwlQTmyVESmTNoHsrgKmGEwDhdICFfZClh5xnvRVKxqu1b5bKgK2wbm
	qdC6Rb69YUJeB95ueEgTNaKS7jB5h8ownbgTzCEmO+M+4In9YwTbuMpbsAORALtuqYgwPJEXgzu
	19lFjI7SYZ3o1Gdi6KvzVd3GyHWxvZPYO0UDbTtQvHFTXXJ8uQ9j6bL6SftKTRpbSe/F9F8ni+k
	tu97Lsu3RKV+/Pb/JAHZxghIkjBwJYvvU9LifuM2xC0MAbQo7PkUqAGQpFqmagm8EywwjjhytMK
	4ffkAcvGOq7wEvHtLXpizTvU2xzgBsKGlEPztQ8EuHxuY1/QWELJxbBoc0E9/yWbfo12TNp2Is4
	s1BvYlVwNJnBCaizhC1OZqYOzlXt75D9YczrqGH1NoEE+ufllWX34w90waLNheKl6Eecy+7xIPW
	gsgD5vOIMINGcHqYJe4ZasjHQ+iCi8fFbMzgNeIigMnBsJCKVVuMkMQvAaA/8/wNvlYTO9ebAnr
	Sqh
X-Received: by 2002:a17:90b:2e4e:b0:35e:579a:7e9a with SMTP id 98e67ed59e1d1-36140204c56mr15021196a91.7.1776807361797;
        Tue, 21 Apr 2026 14:36:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8be])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm14352270a91.10.2026.04.21.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:36:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 ath-next] wifi: ath12k: use kzalloc_flex
Date: Tue, 21 Apr 2026 14:35:44 -0700
Message-ID: <20260421213544.6238-1-rosenp@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-35188-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6077143FC95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation before any potential accesses.
kzalloc_flex does this anyway for GCC >= 15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 v2: reword last comment.
 drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++--------------------
 drivers/net/wireless/ath/ath12k/wmi.h |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fbdfe6424fd7..32d590504a80 100644
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
index 5ba9b7d3a888..5f150f21c146 100644
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


