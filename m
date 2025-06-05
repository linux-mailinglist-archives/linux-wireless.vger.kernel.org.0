Return-Path: <linux-wireless+bounces-23770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DE1ACEFE3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 15:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECC7179011
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450DE225A34;
	Thu,  5 Jun 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rfZhXYjF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F2218E91;
	Thu,  5 Jun 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128596; cv=none; b=neoFo22ofVweNb5iRMzWBb7JAFOUC3JMChRSPIYAxd7HrP7aZSiA67WmZtTTcFE2e5z8IS3vbya0mkGY9H1LekeYQO3xCo/pCCd5HMKIfc3uP8rkSBe7X3c38VMFqMw5+gzRP+XEBE3IlB4ix1xkTr5VxJxn972BlXhT1oGwyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128596; c=relaxed/simple;
	bh=0qx6Hubyt4O4AdYD0nN1QeadlJ17tKUMfZHsy1X6CrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=caFJreBMT9gRaJovj4CK1akbKe5zBdbBn8ocxUH2SMXEMivLvJvQLHg3hRU5mec7/l/M3UnMRvgQanpu1MRcKwBAZBpO75Kh61+Krrt5MrRy0v4YkjmFLyfCNLywT1B8b1C4zgHFbZh74rhUN3dGJbKu2ttAX2vBtH32cUnT+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rfZhXYjF; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0E2D81FC21;
	Thu,  5 Jun 2025 15:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1749128591;
	bh=1/K0m/4uJlUAUHLqOtNd4YAqnOEAV+gHKTqgtCKKZUc=; h=From:To:Subject;
	b=rfZhXYjFZ0lSsAvHxA2NUfIDac5g86VXo5YqgRjL0BKCUksdF1ySd7Vw3rpxi2AWc
	 CiwfvaM7s2yoHU5TiCKifO3CQ6gRhK4nWBNRI9BtNfEbNQjcsOi8krIKgH7qbFK1uX
	 KYH0BV9zWoP8rKjQdIl0T1jfGYPyDbeETy3ct0WSJXZCag+57wsoCqT5VITdVyg6Sr
	 VZKd8pgZkfiFjvjeG3olv+AdY3xMWmZDobUoHG0uM1VPtpnli+ZAKgpw+h5GbKLVEJ
	 gxWmoS9JSNflWOxsIusbtn/ZRM6+qUGy+j4dVSPAlKjZBPXUKlF9gnNaWGwE5Pxa+G
	 Oh5Dqld9jUFTQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2] Revert "wifi: mwifiex: Fix HT40 bandwidth issue."
Date: Thu,  5 Jun 2025 15:03:02 +0200
Message-Id: <20250605130302.55555-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This reverts commit 4fcfcbe457349267fe048524078e8970807c1a5b.

That commit introduces a regression, when HT40 mode is enabled,
received packets are lost, this was experience with W8997 with both
SDIO-UART and SDIO-SDIO variants. From an initial investigation the
issue solves on its own after some time, but it's not clear what is
the reason. Given that this was just a performance optimization, let's
revert it till we have a better understanding of the issue and a proper
fix.

Cc: Jeff Chen <jeff.chen_1@nxp.com>
Cc: stable@vger.kernel.org
Fixes: 4fcfcbe45734 ("wifi: mwifiex: Fix HT40 bandwidth issue.")
Closes: https://lore.kernel.org/all/20250603203337.GA109929@francesco-nb/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: fix reverted commit sha
v1: https://lore.kernel.org/all/20250605100313.34014-1-francesco@dolcini.it/
---
 drivers/net/wireless/marvell/mwifiex/11n.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11n.c b/drivers/net/wireless/marvell/mwifiex/11n.c
index 738bafc3749b..66f0f5377ac1 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n.c
@@ -403,14 +403,12 @@ mwifiex_cmd_append_11n_tlv(struct mwifiex_private *priv,
 
 		if (sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
 		    bss_desc->bcn_ht_oper->ht_param &
-		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY) {
-			chan_list->chan_scan_param[0].radio_type |=
-				CHAN_BW_40MHZ << 2;
+		    IEEE80211_HT_PARAM_CHAN_WIDTH_ANY)
 			SET_SECONDARYCHAN(chan_list->chan_scan_param[0].
 					  radio_type,
 					  (bss_desc->bcn_ht_oper->ht_param &
 					  IEEE80211_HT_PARAM_CHA_SEC_OFFSET));
-		}
+
 		*buffer += struct_size(chan_list, chan_scan_param, 1);
 		ret_len += struct_size(chan_list, chan_scan_param, 1);
 	}
-- 
2.39.5


