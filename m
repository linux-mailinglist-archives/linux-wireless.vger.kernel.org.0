Return-Path: <linux-wireless+bounces-20409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D4A62FDC
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 17:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C28C1896F44
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A16201270;
	Sat, 15 Mar 2025 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="obF8/dha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1DC1DFDAE;
	Sat, 15 Mar 2025 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742055231; cv=none; b=FmjJmrxWCbaOqXrLptk/nBQePywrkgYnI+R3168oC5mhps4H4mxZwmihZSqZXEE2g8LNRThv9J1/EaAVbNRGnO1WihyWTt1a7GXfTbXyowhpKFld9iVACoJvPaxVJyNkgQYwXQIue72CfE8SqHSSmz8u2sZyHIPr08PSH3fDJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742055231; c=relaxed/simple;
	bh=y8MgAkStiT8tolKeBIFk0ywBLGTvKxVWNNSI8aghLOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqkB+fAkHX+snSKhHqCjN254IPkQa5m9vjGmUFEwl3imeYyhOnMeovgafERv55oBoXUOXHL06lGOAaVoc+Ou+V4J2jL/JFn2pct/75XEsuM7LBISoVRyTJcK7yHsujhN/UTI9pqZycE42sjQrzVSATx95a7wb74DJKGamsR0zbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=obF8/dha; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:6100:0:640:f888:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id AABA460B74;
	Sat, 15 Mar 2025 19:13:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id RDIF5oOLlmI0-t8z3VJeh;
	Sat, 15 Mar 2025 19:13:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1742055215; bh=iDre0Mx+4FFuNw7KnuY7ck2mNKZRvmk1vRQXXtTAhVs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=obF8/dhaj8qgPnD7Fjpw7l+ZRF7m/5A65IP5UEMogc39HtbZkMixkOP+4tAUikOAw
	 zgRjcwbFdSv/xLWoTPjFeSauVM4nbzdKKftx8+k67OZYU/gsvSi03I1/XNciqWTmwT
	 SFqKygB1P/LAEggoWFfc+BQnXZcE666Bfypu02rA=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Mikhail Lobanov <m.lobanov@rosa.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Mikhail Lobanov <m.lobanov@rosa.ru>,
	Shaul Triebitz <shaul.triebitz@intel.com>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v3] wifi: mac80211: check basic rates validity in sta_link_apply_parameters
Date: Sat, 15 Mar 2025 19:12:50 +0300
Message-ID: <20250315161253.19399-1-m.lobanov@rosa.ru>
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
v3: added the missing if as Christophe Jaillet (christophe.jaillet@wanadoo.fr) noticed.

 net/mac80211/cfg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9351c64608a9..b4d18172da16 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1909,10 +1909,11 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 
 	if (params->supported_rates &&
 	    params->supported_rates_len) {
-		ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
-					 sband, params->supported_rates,
-					 params->supported_rates_len,
-					 &link_sta->pub->supp_rates[sband->band]);
+		if (!ieee80211_parse_bitrates(link->conf->chanreq.oper.width,
+					      sband, params->supported_rates,
+					      params->supported_rates_len,
+					      &link_sta->pub->supp_rates[sband->band]))
+			return -EINVAL;
 	}
 
 	if (params->ht_capa)
-- 
2.47.2


