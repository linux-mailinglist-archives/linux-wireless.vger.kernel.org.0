Return-Path: <linux-wireless+bounces-21378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA6FA84098
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F327A17900F
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB8A280CDD;
	Thu, 10 Apr 2025 10:24:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97638281345
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280692; cv=none; b=daEjSlJNi0l5k1KXXfN+IsadUcQBPl3F8m/W8Lz6rHZnIAUJA8w+OyBXYJ2tPef3+tMqoVec6tfh6EIZs/AwYgV6d/867kCQGT0XTyWdwLZocklyh05zIxmNpZXuduRLBi3PQuPWFU64Bof37C6tlCktTzX3ln3HDTimmWBOHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280692; c=relaxed/simple;
	bh=Ys2BPZTfw4wgHFHQdf+XixxFvf910g3Pa5v+0HhjRS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpQaTAQeGnK9e60md1QE7eRg1hyAayoiFPKILBtHBgFhKzT8cqDftFZhGDWJnugxjUjhNG1BEOO7DjcDmHgey3YEZODYlm9T2qcZYsX/vWEanT73yDFoW+HnmN9LptU8z0A7YNg/6ZFKkzYyo4VCPdTy6gTyrLuuDbDfsQGdqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5C-0002DE-5j; Thu, 10 Apr 2025 12:24:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-004Fmx-2h;
	Thu, 10 Apr 2025 12:24:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-002ODU-2K;
	Thu, 10 Apr 2025 12:24:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:24:28 +0200
Subject: [PATCH wireless-next v6 4/9] wifi: mwifiex: make
 region_code_mapping_t const
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-cleanup-1-v6-4-a6bbd4ac4d37@pengutronix.de>
References: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
In-Reply-To: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280668; l=2653;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Ys2BPZTfw4wgHFHQdf+XixxFvf910g3Pa5v+0HhjRS4=;
 b=9HE9kSWgICCfAnvAoyuB73ju3aXHd1XS3O4JyFqjhYxuANvTY7BPPtscmGhzWJJ/b6eRIt2iX
 gBI16V5n4XKDV+myWApK/UrdgLBL1xp8YQrMorM02IgktANvahVxfZw
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

region_code_mapping_t is not modified and shouldn't be. Mark it const.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/cfp.c      | 4 ++--
 drivers/net/wireless/marvell/mwifiex/main.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a099fdaafa45d..33bc5cd3ce960 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4703,7 +4703,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	void *wdev_priv;
 	struct wiphy *wiphy;
 	struct mwifiex_private *priv = adapter->priv[MWIFIEX_BSS_TYPE_STA];
-	u8 *country_code;
+	const u8 *country_code;
 	u32 thr, retry;
 	struct cfg80211_ops *ops;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cfp.c b/drivers/net/wireless/marvell/mwifiex/cfp.c
index d7fd79214bcfb..686bf12b6c26b 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfp.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfp.c
@@ -153,7 +153,7 @@ struct region_code_mapping {
 	u8 region[IEEE80211_COUNTRY_STRING_LEN] __nonstring;
 };
 
-static struct region_code_mapping region_code_mapping_t[] = {
+static const struct region_code_mapping region_code_mapping_t[] = {
 	{ 0x10, "US " }, /* US FCC */
 	{ 0x20, "CA " }, /* IC Canada */
 	{ 0x30, "FR " }, /* France */
@@ -165,7 +165,7 @@ static struct region_code_mapping region_code_mapping_t[] = {
 };
 
 /* This function converts integer code to region string */
-u8 *mwifiex_11d_code_2_region(u8 code)
+const u8 *mwifiex_11d_code_2_region(u8 code)
 {
 	u8 i;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 88bd21fd3c07f..3efdd53c4b59f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1565,7 +1565,7 @@ int mwifiex_add_wowlan_magic_pkt_filter(struct mwifiex_adapter *adapter);
 int mwifiex_set_mgmt_ies(struct mwifiex_private *priv,
 			 struct cfg80211_beacon_data *data);
 int mwifiex_del_mgmt_ies(struct mwifiex_private *priv);
-u8 *mwifiex_11d_code_2_region(u8 code);
+const u8 *mwifiex_11d_code_2_region(u8 code);
 void mwifiex_uap_set_channel(struct mwifiex_private *priv,
 			     struct mwifiex_uap_bss_param *bss_cfg,
 			     struct cfg80211_chan_def chandef);

-- 
2.39.5


