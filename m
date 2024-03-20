Return-Path: <linux-wireless+bounces-5009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C66881749
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A4B28360D
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD2D6E2B3;
	Wed, 20 Mar 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvFbRt8h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6576DD0A
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959096; cv=none; b=ALI5rDMd/41dDcvRiB4jWqFNbdruku8QnduWHIxvij++n3PEzTvTdaDL+fDprmJpcj/tktga61bH8s8uUmrsKZaCe21xvht0ZQpq8WIO8opRRNKp4ajD11RCNh43t81NLY2NVSkzZUcbYelPXlFgVaa+OlFGyvad84nOq8sKsHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959096; c=relaxed/simple;
	bh=MjWyDUC/nS4snXHHsGdZsklEOiCdmd1uzg7HZvh8mDE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=srYK3WIr3RtXMySMjuRkXoBHw1anhkAG7ZGQqi7bB8PPQE9w2FuBuxiRNn0NP3o5xJRJMQtwjUyW/M8REb7NFnWLKeZg43KckkY5XwP8t76l3gfmc1kDMzlXextq4mUuqC13JlA+6rl7x8d0dbd8gPmsTNXwlwtakyOjLbrDE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvFbRt8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19E3C433F1
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710959096;
	bh=MjWyDUC/nS4snXHHsGdZsklEOiCdmd1uzg7HZvh8mDE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VvFbRt8h1UaqH/hqkAxW8rrJtqCksQjEsyiPrwuK6ZVd556URRciN9uNnmrdWEeb7
	 EE7jtiHlWGidXxFqVjzVwNKHGvFf2DH++UBxz+SE8Nsvp1y1/UIQHS5aktLjzyYW0q
	 AIWJctyg0U4j04o8qy+6p5j/VziVZgpnKcbHLn/V+TOjVt2SEY77g6q993Yd2koCVM
	 PXv3PmTWcuJL5WoLW1acVcuJuvgBQJrT11hzOAlqdVNwKEemkoNgxpGo/nZydEojqe
	 Ho27gXygwD61rmRvCyGjvQhwkVIWMEZS6Y0pnop/0/oJUw6e8ochi4NCFDb1+MKPBP
	 VkoGK+JVLQJJg==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] wifi: wil6210: fix sparse warnings
Date: Wed, 20 Mar 2024 20:24:49 +0200
Message-Id: <20240320182449.3757215-5-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320182449.3757215-1-kvalo@kernel.org>
References: <20240320182449.3757215-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Sparse warns:

drivers/net/wireless/ath/wil6210/fw.c: note: in included file (through drivers/net/wireless/ath/wil6210/wil6210.h):
drivers/net/wireless/ath/wil6210/fw.h:96:47: warning: array of flexible structures
drivers/net/wireless/ath/wil6210/cfg80211.c: note: in included file (through drivers/net/wireless/ath/wil6210/wil6210.h):
drivers/net/wireless/ath/wil6210/fw.h:96:47: warning: array of flexible structures

I decided to remove the combos field altogether and just do pointer arithmetic
instead. Not pretty but I didn't want to waste too much time on an orphaned
driver.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 4 ++--
 drivers/net/wireless/ath/wil6210/fw.h       | 1 -
 drivers/net/wireless/ath/wil6210/fw_inc.c   | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index dbe4b3478f03..8993028709ec 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2735,7 +2735,7 @@ int wil_cfg80211_iface_combinations_from_fw(
 		return 0;
 	}
 
-	combo = conc->combos;
+	combo = (const struct wil_fw_concurrency_combo *)(conc + 1);
 	n_combos = le16_to_cpu(conc->n_combos);
 	for (i = 0; i < n_combos; i++) {
 		total_limits += combo->n_limits;
@@ -2751,7 +2751,7 @@ int wil_cfg80211_iface_combinations_from_fw(
 		return -ENOMEM;
 	iface_limit = (struct ieee80211_iface_limit *)(iface_combinations +
 						       n_combos);
-	combo = conc->combos;
+	combo = (const struct wil_fw_concurrency_combo *)(conc + 1);
 	for (i = 0; i < n_combos; i++) {
 		iface_combinations[i].max_interfaces = combo->max_interfaces;
 		iface_combinations[i].num_different_channels =
diff --git a/drivers/net/wireless/ath/wil6210/fw.h b/drivers/net/wireless/ath/wil6210/fw.h
index aa1620e0d24f..2079a90ec260 100644
--- a/drivers/net/wireless/ath/wil6210/fw.h
+++ b/drivers/net/wireless/ath/wil6210/fw.h
@@ -93,7 +93,6 @@ struct wil_fw_record_concurrency { /* type == wil_fw_type_comment */
 	/* number of concurrency combinations that follow */
 	__le16 n_combos;
 	/* keep last - combinations, variable size by n_combos */
-	struct wil_fw_concurrency_combo combos[];
 } __packed;
 
 /* brd file info encoded inside a comment record */
diff --git a/drivers/net/wireless/ath/wil6210/fw_inc.c b/drivers/net/wireless/ath/wil6210/fw_inc.c
index fbc84c03406b..c3c0b289dcf3 100644
--- a/drivers/net/wireless/ath/wil6210/fw_inc.c
+++ b/drivers/net/wireless/ath/wil6210/fw_inc.c
@@ -212,8 +212,8 @@ fw_handle_concurrency(struct wil6210_priv *wil, const void *data,
 	}
 
 	n_combos = le16_to_cpu(rec->n_combos);
-	remain = size - offsetof(struct wil_fw_record_concurrency, combos);
-	combo = rec->combos;
+	remain = size - sizeof(struct wil_fw_record_concurrency);
+	combo = (const struct wil_fw_concurrency_combo *)(rec + 1);
 	for (i = 0; i < n_combos; i++) {
 		if (remain < sizeof(*combo))
 			goto out_short;
-- 
2.39.2


