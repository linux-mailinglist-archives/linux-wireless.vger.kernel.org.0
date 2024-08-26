Return-Path: <linux-wireless+bounces-11973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B695EF58
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554471F22AFB
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A3217AE1C;
	Mon, 26 Aug 2024 11:01:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF35152160
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670105; cv=none; b=pDCh02SY8tzS3S5UqoKBOrmlR4TJ5vazYtU64eLGzngOZf/ezj+eVm6LjoTTinSaHRqZTk42+pG7R5tcC7L64XP0PjUFB25W3AmL39BWimPKUsjsfx3XoFx5I79qLy7oyYA4adGn7fegVxrMohLgDLX/oOgoUWbWWQpReY9HVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670105; c=relaxed/simple;
	bh=oP/5zh96YHmOzbehuFJEdLwjUWFwN7Db7OG+I/u7VYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deCtxJoahHt2Y+ZnUcu/1Oj/qvXUxRjNzWPneYyBtvoF4rJ0SdlEF00S/cxdGqzjA4kLA2WbjHVZjBVkVnI6H8XQX99urPnwXWznJBV807DguUIx6nzDuuDWrKBHc8098uHZh/fr5yWCsKLygtZX0W5oDLhU9mZjajpcEG2m/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-00047a-Ly; Mon, 26 Aug 2024 13:01:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-003Ae8-10; Mon, 26 Aug 2024 13:01:32 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-2v;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:27 +0200
Subject: [PATCH 06/12] wifi: mwifiex: make region_code_mapping_t const
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-6-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=2526;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=oP/5zh96YHmOzbehuFJEdLwjUWFwN7Db7OG+I/u7VYY=;
 b=Z76tG7ngSA7CBZOgPbu5/+V5naLh8Dh6Oa+Eu0tjZR/mqsrl1ifdTRVp2KiRZhctr+RJq4GV0
 OLIRvbbQukJBeJGHHby9Lk7ZYzL7xQ4MeJixdmksQAJT0xN80JREQ0l
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

region_code_mapping_t is not modified and shouldn't be. Mark it const.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 2 +-
 drivers/net/wireless/marvell/mwifiex/cfp.c      | 4 ++--
 drivers/net/wireless/marvell/mwifiex/main.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d3e1424bea390..8cf6267b03579 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4701,7 +4701,7 @@ int mwifiex_register_cfg80211(struct mwifiex_adapter *adapter)
 	void *wdev_priv;
 	struct wiphy *wiphy;
 	struct mwifiex_private *priv = adapter->priv[MWIFIEX_BSS_TYPE_STA];
-	u8 *country_code;
+	const u8 *country_code;
 	u32 thr, retry;
 	struct cfg80211_ops *ops;
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cfp.c b/drivers/net/wireless/marvell/mwifiex/cfp.c
index d39092b992129..47c93dca6041b 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfp.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfp.c
@@ -153,7 +153,7 @@ struct region_code_mapping {
 	u8 region[IEEE80211_COUNTRY_STRING_LEN];
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
index ce5b80af305a0..56f413cb6eb30 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1569,7 +1569,7 @@ int mwifiex_add_wowlan_magic_pkt_filter(struct mwifiex_adapter *adapter);
 int mwifiex_set_mgmt_ies(struct mwifiex_private *priv,
 			 struct cfg80211_beacon_data *data);
 int mwifiex_del_mgmt_ies(struct mwifiex_private *priv);
-u8 *mwifiex_11d_code_2_region(u8 code);
+const u8 *mwifiex_11d_code_2_region(u8 code);
 void mwifiex_uap_set_channel(struct mwifiex_private *priv,
 			     struct mwifiex_uap_bss_param *bss_cfg,
 			     struct cfg80211_chan_def chandef);

-- 
2.39.2


