Return-Path: <linux-wireless+bounces-8314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BFD8D4C32
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7692E287B12
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815681E488;
	Thu, 30 May 2024 13:02:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305017C9EC
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074126; cv=none; b=D9jPI0Xxc0ASVt2c0EjSQTCjJuBvPaE35leVeUmOCkUGn65tZ76l7crodIwGYstAGUtdBLJJimc6dgQ3EZPcQREPsTVbRL44GGcyR8Dj9FnGLDpNrfkQa/Rm3/O6jRXuO2tNUPjR5gZm2c+fj/097m4cLOE6tl2jOXV7DBbFnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074126; c=relaxed/simple;
	bh=Zclcy1rakeT5f0M+PlcV2Mt4kyDmQgT74mkvgQcSmBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SB9ZboDYeNHuBvyiJkPpgTUq29yxdmvtYpV0T/h5oW7Z0cs2eovGBpf0pz6Z3g49UFO2vyR//pbi7oYhZwumZwNLaPkHplFMzztXDYgW7NKLVffyyaq6GZZVD0Q1smwFoujc+7GRDetuSu1gWMpjEdwI72WHoTRftKJGVo6jBMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sCfPq-00061d-1p; Thu, 30 May 2024 15:01:58 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sCfPp-003b90-Hq; Thu, 30 May 2024 15:01:57 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sCfPp-006vb6-1Q;
	Thu, 30 May 2024 15:01:57 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] wifi: mwifiex: increase max_num_akm_suites
Date: Thu, 30 May 2024 15:01:56 +0200
Message-Id: <20240530130156.1651174-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The maximum number of AKM suites will be set to two if not specified by
the driver. Set it to CFG80211_MAX_NUM_AKM_SUITES to let userspace
specify up to ten AKM suites in the akm_suites array.

Without only the first two AKM suites will be used, further ones are
ignored.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Current wpa_supplicant/hostapd only put a maximum of two into the
akm_suites array as well, a patch changing this can be found here:
http://lists.infradead.org/pipermail/hostap/2024-May/042720.html
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index b909a7665e9cc..908dfe01c30d7 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4358,6 +4358,8 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 				 BIT(NL80211_IFTYPE_P2P_GO) |
 				 BIT(NL80211_IFTYPE_AP);
 
+	wiphy->max_num_akm_suites = CFG80211_MAX_NUM_AKM_SUITES;
+
 	if (ISSUPP_ADHOC_ENABLED(adapter->fw_cap_info))
 		wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
 
-- 
2.39.2


