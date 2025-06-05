Return-Path: <linux-wireless+bounces-23746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B5ACED49
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 12:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C018B1783D2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61E206F27;
	Thu,  5 Jun 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Xw/U0uZ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30463C17;
	Thu,  5 Jun 2025 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117815; cv=none; b=Odq/1D9AW5YUhsMSAOkyiSLP27cUHVgD/0mSwt4F3MFq0mO6Kb8Uh9sII/um34l3CtujJrlgCzbL1UuNb/NCirVGlsLWVcyjbK+6GocTlojw1Nm6XEF6OV+hLvpFWrPTJlm18PMzjBsLHOEHazm4/aS810b2PT4+YmxAABIVZ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117815; c=relaxed/simple;
	bh=FA/+BHeifIxqogwcWZmS8wqgT9vJObq/p6nrNOEyb80=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r8E0XRs18YQAqjIGWxu6CXD9iLtivbGqyCqxmlCX42fkCQA6jlE7OA9BLpggAp/NWqeEwr773VnYwo6KXfp2QtRUhSnp68nQZpkVwoJUSE1H7Vq/9xe0L8n4rRKhp8VA+vcYphWMXvn/93heEtKGc5hRl+ryEcSD7H3PCzAejSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Xw/U0uZ+; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 28EAD1FD24;
	Thu,  5 Jun 2025 12:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1749117808;
	bh=iegZH7tcjxXe+6mQln8FYa5oEl858U3Y7zsMG9yiJS0=; h=From:To:Subject;
	b=Xw/U0uZ+3T939JRocOy6a+7VSv+x8VZEXaLHOkU1e/YA9ciISbUxG5NGRLHkm+pI+
	 7iKjMqByc2w8S0XIV7RNhM+nw+Xaty8cN5v4ocuqJ85rmunreiSRWEoRDNon1pLImj
	 ymKg1QBTcSdiHpes92K1L/NnIYPWQu3jTXDfPXxOm+5jSw5pP1nKg2rVUuN+rjPYbQ
	 NIWTwsnf23fFy5gIl4gc04gqQaJUamNKgvUjGZKUl2t2l2WF6JG8Fh97vZlpIM19fV
	 h7II2LB0aylJUdxqYp0Ix47vkhOBh1AyAkbEdEvvylPiw5kuWsR7KArUOcICT4A55f
	 YWJ9LCikEhkSA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v1] Revert "wifi: mwifiex: Fix HT40 bandwidth issue."
Date: Thu,  5 Jun 2025 12:03:13 +0200
Message-Id: <20250605100313.34014-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This reverts commit 34253084291cb210b251d64657958b8041ce4ab1.

That commit introduces a regression, when HT40 mode is enabled,
received packets are lost, this was experience with W8997 with both
SDIO-UART and SDIO-SDIO variants. From an initial investigation the
issue solves on its own after some time, but it's not clear what is
the reason. Given that this was just a performance optimization, let's
revert it till we have a better understanding of the issue and a proper
fix.

Cc: Jeff Chen <jeff.chen_1@nxp.com>
Cc: stable@vger.kernel.org
Fixes: 34253084291c ("wifi: mwifiex: Fix HT40 bandwidth issue.")
Closes: https://lore.kernel.org/all/20250603203337.GA109929@francesco-nb/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
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


