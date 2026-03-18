Return-Path: <linux-wireless+bounces-33381-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJs4IUNgumnFUgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33381-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 09:20:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E482B7C7E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 09:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFB4F3012BEC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F137AA6F;
	Wed, 18 Mar 2026 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nummela.org header.i=@nummela.org header.b="aKB4R1gE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps-8cfc3056.vps.ovh.net (chai.nummela.org [51.195.103.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4670377544
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.195.103.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821986; cv=none; b=urJOmzmmyyLaEATAurMFkKvFiXihzpXlxqstBkZSXlIYYdfr+9C6G1mzOc03EFHLAnKf/mfL0RkbA42Qt0ijJtVUVo5mzhLJOOlXxF38RbyGPQIpYiHo/cP2sG3yRnK+MTbZMK32cZBhrmXEpFFOwxfIMEpp4fcZ9lO4nl/qtcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821986; c=relaxed/simple;
	bh=FpRbdc3HDsOSqOTz9pwbO89vBDY/p+22PsENIVxBf3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oCJEBQWpdBmoBEM+HqHlF5vEejPpzF8hP/kl+/V7UWgylL/jec4q1xw54tOo6PUP45NDT0yeotLdFGn874Az/tIGOIhnLx2kmLwnftyVyliJLHZDOed21iOUQTDFFo+jwEjOsCzQdGvnRHbVc/gX9K3xHIad3I0O8KtJnaNQ/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kempower.com; spf=fail smtp.mailfrom=kempower.com; dkim=pass (2048-bit key) header.d=nummela.org header.i=@nummela.org header.b=aKB4R1gE; arc=none smtp.client-ip=51.195.103.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=kempower.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kempower.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nummela.org
	; s=20250215; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pcyZ2BZoXNVrrRh8CINMT1A158yGcjcaYxEAdjxiCuU=; b=aKB4R1gEugaD//tBsAnEXxUW1x
	b/uY3QmFQh+apL4gIkt3xAmS7mw/dzrsysYeiZQhDFzi2LNTtrRgel9eQoMz+Jl1ihlhAozIUDu5F
	GktFvVZ/O9V1jYY1T/gBkJuIIcBbcL2wejzqu7HJ+/5DgJ2EOSaAh1zSg2cHn1FfMV/2p91TtEST8
	HFVBofd5Jycw/qr5R+TUTFxe8GUieWwklU7Z2EJYv1Hur/kYUOHcoQnTi7wZZROEsblH2VBkazGqW
	0e4XCJo6jdPC0BGX8nCf9c1FvQ9/2vU9l98DDztMsy98VjR62q2E3NDCVvAjRRl5MSCAvP4JcBVta
	fWYX6/Mg==;
Received: from 109-204-177-37.cust.valoonet.fi ([109.204.177.37] helo=vige-ThinkPad-P16-Gen-2.nummela.org)
	by vps-8cfc3056.vps.ovh.net with esmtpa (Exim 4.96)
	(envelope-from <ville.nummela@kempower.com>)
	id 1w2m7v-0000vr-2d;
	Wed, 18 Mar 2026 08:19:39 +0000
From: Ville Nummela <ville.nummela@kempower.com>
To: linux-wireless@vger.kernel.org
Cc: Ville Nummela <ville.nummela@kempower.com>
Subject: [PATCH v3] wifi: rsi_91x_usb: do not pause rfkill polling when stopping mac80211
Date: Wed, 18 Mar 2026 10:19:12 +0200
Message-Id: <20260318081912.87744-1-ville.nummela@kempower.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[kempower.com : SPF not aligned (relaxed),reject];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[nummela.org:s=20250215];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33381-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nummela.org:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.950];
	FROM_NEQ_ENVFROM(0.00)[ville.nummela@kempower.com,linux-wireless@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kempower.com:email,kempower.com:mid]
X-Rspamd-Queue-Id: 28E482B7C7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Removing rsi_91x USB adapter could cause rtnetlink to lock up.
When rsi_mac80211_stop is called, wiphy_lock is locked. Call to
wiphy_rfkill_stop_polling would wait until the work queue has
finished, but because the work queue waits for wiphy_lock, that
would never happen.

Moving the call to rsi_disconnect avoids the lock up.

Signed-off-by: Ville Nummela <ville.nummela@kempower.com>
---
Changes since v2:
 - Fix whitespaces
 
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 17 ++++++++++++++++-
 drivers/net/wireless/rsi/rsi_91x_usb.c      |  2 ++
 drivers/net/wireless/rsi/rsi_common.h       |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index c7ae8031436a..3faf2235728b 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -325,6 +325,22 @@ void rsi_mac80211_detach(struct rsi_hw *adapter)
 }
 EXPORT_SYMBOL_GPL(rsi_mac80211_detach);
 
+/**
+ * rsi_mac80211_rfkill_exit() - This function is used to stop rfkill polling
+ *                              when the device is removed.
+ * @adapter: Pointer to the adapter structure.
+ *
+ * Return: None.
+ */
+void rsi_mac80211_rfkill_exit(struct rsi_hw *adapter)
+{
+	struct ieee80211_hw *hw = adapter->hw;
+
+	if (hw)
+		wiphy_rfkill_stop_polling(hw->wiphy);
+}
+EXPORT_SYMBOL_GPL(rsi_mac80211_rfkill_exit);
+
 /**
  * rsi_indicate_tx_status() - This function indicates the transmit status.
  * @adapter: Pointer to the adapter structure.
@@ -422,7 +438,6 @@ static void rsi_mac80211_stop(struct ieee80211_hw *hw, bool suspend)
 	rsi_dbg(ERR_ZONE, "===> Interface DOWN <===\n");
 	mutex_lock(&common->mutex);
 	common->iface_down = true;
-	wiphy_rfkill_stop_polling(hw->wiphy);
 
 	/* Block all rx frames */
 	rsi_send_rx_filter_frame(common, 0xffff);
diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c b/drivers/net/wireless/rsi/rsi_91x_usb.c
index d83204701e27..8765cac6f875 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -877,6 +877,8 @@ static void rsi_disconnect(struct usb_interface *pfunction)
 	if (!adapter)
 		return;
 
+	rsi_mac80211_rfkill_exit(adapter);
+
 	rsi_mac80211_detach(adapter);
 
 	if (IS_ENABLED(CONFIG_RSI_COEX) && adapter->priv->coex_mode > 1 &&
diff --git a/drivers/net/wireless/rsi/rsi_common.h b/drivers/net/wireless/rsi/rsi_common.h
index 7aa5124575cf..591602beeec6 100644
--- a/drivers/net/wireless/rsi/rsi_common.h
+++ b/drivers/net/wireless/rsi/rsi_common.h
@@ -79,6 +79,7 @@ static inline int rsi_kill_thread(struct rsi_thread *handle)
 }
 
 void rsi_mac80211_detach(struct rsi_hw *hw);
+void rsi_mac80211_rfkill_exit(struct rsi_hw *hw);
 u16 rsi_get_connected_channel(struct ieee80211_vif *vif);
 struct rsi_hw *rsi_91x_init(u16 oper_mode);
 void rsi_91x_deinit(struct rsi_hw *adapter);
-- 
2.34.1


