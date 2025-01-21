Return-Path: <linux-wireless+bounces-17768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04528A175C6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 02:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACB5188A085
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 01:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A86460DCF;
	Tue, 21 Jan 2025 01:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="krykIqCz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989F63CF;
	Tue, 21 Jan 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423197; cv=none; b=bAwBeoiQh2TnPFAaMRf/d/ZlNjp/MguCVyE9Q5CEPTstpjf0bW8eeQmG2voYxh0mhOmg/rcT1nfz9hdifZ5Ff2+M4dDXVnSERq8OyFk84zUrIARQ8s9GUPCTzlMwCHOF41sI7jDkATcrKiT/+lq9S5CXTnm1I1g+j2zwNQMxTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423197; c=relaxed/simple;
	bh=FSuJ2W6Lh0X5jaOlFuhVfFnT4IY+Gy9ojrhrnMFXP1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gcd+xRzMPrCcHPhDe63EqvpQw18kZCCMMy6p5Lmij59+OZl7QXMPPlXAYu9oK99UBo1Mg8XHhhOGF9YhcDhn/Msw2T1uZHjacP38refx+UHr3vnAunjgnpoEewcnx/IYOCT4vseI3eRouIDJ8vH1R8p+jrCJF6fGl9g5I4LiXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=krykIqCz; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=SJUGpUBSW1oOW5FDsxGOKULZzDSIWuSUdkKEV1N8D3k=; b=krykIqCzKE7jxE7G
	l4zxuQlCSwBaCC2DHU1Z47+mWiwev1PvmrmoTwalHPuCQmySKSsvzqhQSU9BWR1hVRQqm/t5P8YzW
	yY39IOm6EJyou6Rc8V1VeHeMTDs1URU8V52MK94FqV5YFlshfwvf1nWuqRyIAaOYdpzX+5EXds8bN
	xTut/1Woo+jVigLWoOlN4SxozYW/5XzirH44vrna9tZQTeLi7jj1BCrvVtviSQtVxwGA1Jwy7IGue
	+qJYSMH0oslc7XTd6WiWxxz88om7CPuFQm91SvuklCaKr4zO0w+RxqLBU+E4ylL50bjUsFddPmgVy
	oi7V0zYWHczhwLK6ug==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1ta38X-00BEI2-1X;
	Tue, 21 Jan 2025 01:33:01 +0000
From: linux@treblig.org
To: kvalo@kernel.org,
	libertas-dev@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] wifi: libertas: Remove unused functions in main
Date: Tue, 21 Jan 2025 01:32:58 +0000
Message-ID: <20250121013300.433538-2-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121013300.433538-1-linux@treblig.org>
References: <20250121013300.433538-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

lbs_data_rate_to_fw_index(), lbs_enter_auto_deep_sleep() and
lbs_exit_auto_deep_sleep() last use was removed in 2010 by
commit e86dc1ca4676 ("Libertas: cfg80211 support")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/marvell/libertas/decl.h |  4 --
 drivers/net/wireless/marvell/libertas/main.c | 40 --------------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/decl.h b/drivers/net/wireless/marvell/libertas/decl.h
index c1e0388ef01d..ea69007a2958 100644
--- a/drivers/net/wireless/marvell/libertas/decl.h
+++ b/drivers/net/wireless/marvell/libertas/decl.h
@@ -64,11 +64,7 @@ int lbs_resume(struct lbs_private *priv);
 void lbs_queue_event(struct lbs_private *priv, u32 event);
 void lbs_notify_command_response(struct lbs_private *priv, u8 resp_idx);
 
-int lbs_enter_auto_deep_sleep(struct lbs_private *priv);
-int lbs_exit_auto_deep_sleep(struct lbs_private *priv);
-
 u32 lbs_fw_index_to_data_rate(u8 index);
-u8 lbs_data_rate_to_fw_index(u32 rate);
 
 int lbs_get_firmware(struct device *dev, u32 card_model,
 			const struct lbs_fw_table *fw_table,
diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index 78e8b5aecec0..e7fa27a7de81 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -79,26 +79,6 @@ u32 lbs_fw_index_to_data_rate(u8 idx)
 	return fw_data_rates[idx];
 }
 
-/**
- *  lbs_data_rate_to_fw_index - use rate to get the index
- *
- *  @rate:	data rate
- *  returns:	index or 0
- */
-u8 lbs_data_rate_to_fw_index(u32 rate)
-{
-	u8 i;
-
-	if (!rate)
-		return 0;
-
-	for (i = 0; i < sizeof(fw_data_rates); i++) {
-		if (rate == fw_data_rates[i])
-			return i;
-	}
-	return 0;
-}
-
 int lbs_set_iface_type(struct lbs_private *priv, enum nl80211_iftype type)
 {
 	int ret = 0;
@@ -802,26 +782,6 @@ static void auto_deepsleep_timer_fn(struct timer_list *t)
 				(priv->auto_deep_sleep_timeout * HZ)/1000);
 }
 
-int lbs_enter_auto_deep_sleep(struct lbs_private *priv)
-{
-	priv->is_auto_deep_sleep_enabled = 1;
-	if (priv->is_deep_sleep)
-		priv->wakeup_dev_required = 1;
-	mod_timer(&priv->auto_deepsleep_timer ,
-			jiffies + (priv->auto_deep_sleep_timeout * HZ)/1000);
-
-	return 0;
-}
-
-int lbs_exit_auto_deep_sleep(struct lbs_private *priv)
-{
-	priv->is_auto_deep_sleep_enabled = 0;
-	priv->auto_deep_sleep_timeout = 0;
-	del_timer(&priv->auto_deepsleep_timer);
-
-	return 0;
-}
-
 static int lbs_init_adapter(struct lbs_private *priv)
 {
 	int ret;
-- 
2.48.1


