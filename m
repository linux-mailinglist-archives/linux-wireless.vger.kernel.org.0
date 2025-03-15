Return-Path: <linux-wireless+bounces-20402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8417A62CBC
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 13:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF1A189C2FE
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54A51F4CA7;
	Sat, 15 Mar 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="FcQHHpN6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6B15C140;
	Sat, 15 Mar 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742042173; cv=none; b=OsYQ2e2Pyd0CRsgU/TScum+bi0uiWU4LHT6d+qay783oSLRqE9SzsBdC3YAYCapllUZd5DHJLGfFTmF66B4tppmnJ9j60BatZMeeWiRBIgQDIZjywoZJ1KxZtsJY8OAehA2HHOKH1G+x9ExVxRK3wvnILLRZSbKHTsExFokm05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742042173; c=relaxed/simple;
	bh=oN9HWcuh4F8+f9HPJdYxr/wST9imw7WuzHDngWGt0N0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2mTXWZ75/lpvIk2BbCN43mIVXZhvGLkyjuOWSDAr8kNaLVpqI4gWLfpS204O+7cBx+oXv8L1vX72zEupsL1YmRWXuX1x8IBPybvAPCETZnrT2tnfMSJa2i2AYaT3eGp8RDlzcM6kGAujiju4ElrX6ADlJzLIil3rLO1CqhxnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=FcQHHpN6; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id BA76763143;
	Sat, 15 Mar 2025 15:30:49 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c27:153f:0:640:5e4f:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 291F960B61;
	Sat, 15 Mar 2025 15:30:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YUEkhaMLnKo0-HtcZrsFh;
	Sat, 15 Mar 2025 15:30:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1742041841; bh=9J6oKvW6KDTaSvr9oja02aRy6UsaDX0Qo0S3KNyGeBw=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=FcQHHpN6PFybtcR7mMztZxxU36eVyMuMPHUCAy8XSzByrXQHo/aQ4xkjpNklc4rSo
	 tEB01dqzOJOwDTHhr8aN5HqWO51GZil3jkkRloIaV2TmGQaRq31ONMiIJ4ULydHpPM
	 KUnFrGWdATYuXrqgu7kIXnxLyoyUM+m7l3z7/I1k=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: mac80211: check basic rates validity in
Date: Sat, 15 Mar 2025 15:29:26 +0300
Message-ID: <20250315123001.58020-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When userspace sets supported rates for a new station via
NL80211_CMD_NEW_STATION, it might send a list that's empty or contains
only invalid values. Currently, we process these values in
sta_link_apply_parameters() without checking the result of
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


