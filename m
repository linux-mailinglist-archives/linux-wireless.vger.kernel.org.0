Return-Path: <linux-wireless+bounces-25927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 961F5B0EE75
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B07189B7D1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47F27E079;
	Wed, 23 Jul 2025 09:30:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54EF28003A
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263029; cv=none; b=fhwlFGEG01/3uGc9QyGkqftPCeHUSOx4fX/oU6uM29UogBjvB5KmLx+1ED8EKUJyj3H37x0nXYJtLzG0qk0S1bxH3wcuPMwl0wF428tMBv7Tws3Zl6ci/c4M1Aobcvs2cOzWuNLsNUsi94iYRz1TRaq0ZYQi1i+RaudKqQORah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263029; c=relaxed/simple;
	bh=1mzKrml5YHqcSVbo4GbtLEdSQopld+oF4f+dPTmw5+M=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=LhvZS31ifaRMdmjWlJiETmHoji2ly8U3849h0PYhk9P+JhwxoeGeqfDzkREzGIOy8LhC6vjqy8fUabZcFFtZZBVogtScvang2jpEALVI87jHZ8BC/1kp7a17MMc8mSwxVgDtZh4UA3uogvmmugnM7B44TNZbPnouSfKasPaIyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bn84R63rTz8Xs6x;
	Wed, 23 Jul 2025 17:30:15 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 56N9U2Tb099339;
	Wed, 23 Jul 2025 17:30:02 +0800 (+08)
	(envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 23 Jul 2025 17:30:04 +0800 (CST)
Date: Wed, 23 Jul 2025 17:30:04 +0800 (CST)
X-Zmail-TransId: 2afb6880ab9c211-19072
X-Mailer: Zmail v1.0
Message-ID: <20250723173004776P6QSjcW7NrlpGYLTFM-yP@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <arend.vanspriel@broadcom.com>
Cc: <liu.song13@zte.com.cn>, <linux-wireless@vger.kernel.org>,
        <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>
Subject: =?UTF-8?B?W1BBVENIXSB3aWZpOiBicmNtc21hYzogVXNlIHN0cl90cnVlX2ZhbHNlKCkgaGVscGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56N9U2Tb099339
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 23 Jul 2025 17:30:15 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6880ABA7.001/4bn84R63rTz8Xs6x

From: Liu Song <liu.song13@zte.com.cn>

Remove hard-coded strings by using the str_true_false() helper function.

Signed-off-by: Liu Song <liu.song13@zte.com.cn>
---
 .../broadcom/brcm80211/brcmsmac/mac80211_if.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index 8ab452cf48c4..aadcff1e2b5d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/bcma/bcma.h>
+#include <linux/string_choices.h>
 #include <net/mac80211.h>
 #include <defs.h>
 #include "phy/phy_int.h"
@@ -540,13 +541,13 @@ static int brcms_ops_config(struct ieee80211_hw *hw, int radio_idx,
 						   conf->listen_interval);
 	}
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR)
-		brcms_dbg_info(core, "%s: change monitor mode: %s\n",
-			       __func__, conf->flags & IEEE80211_CONF_MONITOR ?
-			       "true" : "false");
+		brcms_dbg_info(core, "%s: change monitor mode: %s\n", __func__,
+			       str_true_false(conf->flags &
+					      IEEE80211_CONF_MONITOR));
 	if (changed & IEEE80211_CONF_CHANGE_PS)
 		brcms_err(core, "%s: change power-save mode: %s (implement)\n",
-			  __func__, conf->flags & IEEE80211_CONF_PS ?
-			  "true" : "false");
+			  __func__,
+			  str_true_false(conf->flags & IEEE80211_CONF_PS));

 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
 		err = brcms_c_set_tx_power(wl->wlc, conf->power_level);
@@ -697,7 +698,7 @@ brcms_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		/* Beaconing should be enabled/disabled (beaconing modes) */
 		brcms_err(core, "%s: Beacon enabled: %s\n", __func__,
-			  info->enable_beacon ? "true" : "false");
+			  str_true_false(info->enable_beacon));
 		if (info->enable_beacon &&
 		    hw->wiphy->flags & WIPHY_FLAG_AP_PROBE_RESP_OFFLOAD) {
 			brcms_c_enable_probe_resp(wl->wlc, true);
@@ -716,7 +717,7 @@ brcms_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_IBSS) {
 		/* IBSS join status changed */
 		brcms_err(core, "%s: IBSS joined: %s (implement)\n",
-			  __func__, vif->cfg.ibss_joined ? "true" : "false");
+			  __func__, str_true_false(vif->cfg.ibss_joined));
 	}

 	if (changed & BSS_CHANGED_ARP_FILTER) {
@@ -731,7 +732,7 @@ brcms_ops_bss_info_changed(struct ieee80211_hw *hw,
 		 * Note that it is only ever disabled for station mode.
 		 */
 		brcms_err(core, "%s: qos enabled: %s (implement)\n",
-			  __func__, info->qos ? "true" : "false");
+			  __func__, str_true_false(info->qos));
 	}
 	return;
 }
@@ -908,7 +909,7 @@ static void brcms_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct brcms_info *wl = hw->priv;
 	int ret;

-	no_printk("%s: drop = %s\n", __func__, drop ? "true" : "false");
+	no_printk("%s: drop = %s\n", __func__, str_true_false(drop));

 	ret = wait_event_timeout(wl->tx_flush_wq,
 				 brcms_tx_flush_completed(wl),
-- 
2.27.0

