Return-Path: <linux-wireless+bounces-20403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AA6A62D39
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 14:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B9177E2D
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE861DC9BE;
	Sat, 15 Mar 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="T3hfxvQS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212461862;
	Sat, 15 Mar 2025 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742044164; cv=none; b=PTWtmcyd573roCvHYYBrfFCe7q9qFHjq+mzLyvSXbA1r4FPyigNITB56usXt3/+svxW5g3RcrfzEHul6TJEWtIf3slaReDh55PBs7GfGAJqRaYsa/WUe79v4FyDqTyZBzB7reV3arbF/8JkXtqcgc9Oy4a2Jeytth3C8qumHHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742044164; c=relaxed/simple;
	bh=ka/9HjQteP+lsd/qliHZFPqBYpxHTM8lQfKFAIpmTVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXzMdpiAhTb4UQoTMSUG6UwgJI7iqhPJRW39WUSo8aGTkjWGAi16N8t88o8NIuq/zhiXou+p2s3nsu8L2CJ8J4r+8Ae7FiCyKcD45Pfp9KSlufbz/Dd4pTt8TMmt0kpRs/8e9k+ub/Iwe2dvShK7EU/UGXndvlEniwmGz+tv7ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=T3hfxvQS; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id C280363449;
	Sat, 15 Mar 2025 16:01:45 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c28:7d5:0:640:285a:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id F34DB60AD1;
	Sat, 15 Mar 2025 16:01:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id T1FSYvMLouQ0-acRp91rH;
	Sat, 15 Mar 2025 16:01:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1742043697; bh=re3pHChC+mQHbRAssqFb1hdzEHJMrzvzoEtkuNzfrNo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=T3hfxvQSn8Y94kNXoMdFBRMuyqLYdNiaHP0PyjPdhPiYUCNaBoGZwUu4lHh/V4SMs
	 FVAe7ha3WQMbUL8Mwxnzv02b6CZL5ZJTxIugzxn5e351Qdadxg0LXXxXCVFCSxiWKR
	 +nkpGz+x/Ed6tG6d9h6JpGCKLUhJM0yzYMz/dbCM=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] wifi: mac80211: check basic rates validity in sta_link_apply_parameters
Date: Sat, 15 Mar 2025 16:01:16 +0300
Message-ID: <20250315130119.75937-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When userspace sets supported rates for a new station via
NL80211_CMD_NEW_STATION, it might send a list that's empty
or contains only invalid values. Currently, we process these
values in sta_link_apply_parameters() without checking the result of
ieee80211_parse_bitrates(), which can lead to an empty rates bitmap.

A similar issue was addressed for NL80211_CMD_SET_BSS in commit
ce04abc3fcc6 ("wifi: mac80211: check basic rates validity").
This patch applies the same approach in sta_link_apply_parameters()
for NL80211_CMD_NEW_STATION, ensuring there is at least one valid
rate by inspecting the result of ieee80211_parse_bitrates().

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: b95eb7f0eee4 ("wifi: cfg80211/mac80211: separate link params from station params")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>
---
v2: Fixed the patch subject to provide a complete description.

 net/mac80211/cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9351c64608a9..e7c429aef980 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1909,10 +1909,11 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	if (params->supported_rates &&
 	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
+		(!ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
 					 sband, params->supported_rates,
 					 params->supported_rates_len,
-					 &link_sta->pub->supp_rates[sband->band]);
+					 &link_sta->pub->supp_rates[sband->band]))
+		return -EINVAL;
 	}
 
 	if (params->ht_capa)
-- 
2.47.2


