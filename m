Return-Path: <linux-wireless+bounces-33372-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IvdLdxBumnMTQIAu9opvQ
	(envelope-from <linux-wireless+bounces-33372-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:10:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164F2B6373
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 07:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD4E3007CAB
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FABB364043;
	Wed, 18 Mar 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nummela.org header.i=@nummela.org header.b="Vn5g4S9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps-8cfc3056.vps.ovh.net (chai.nummela.org [51.195.103.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289436405F
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.195.103.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814223; cv=none; b=D4WmT9rKq13f5k9ApLtPcKj5kKUbLyI5J5JA4JL4zgepYzfTsEkzvo4jrpzesFXbTWASNqY9BnNDNKB2ZkHrWxAqauiD1GIY0h8y3G+JIiM2kiEle74pe0UvTXpIDx02J3EtQZAFZeV0EhbDVEfDN7uAdFB6HNIgmaJ2u6OADPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814223; c=relaxed/simple;
	bh=PZoKvpUGgQWo7+AWXDAhh2hg6ju0irPvhToARl9BZ8M=;
	h=Date:Message-ID:From:To:Subject:Content-Type:MIME-Version:
	 Content-Disposition; b=D6o0narHp4t3zWKechPNLNgMsJR6h2TtYA/F7C5eDW4RTlIOsFsCJQ3wwBhDYM4lNLlr8Sp5FvYrNw1ek8F/vaQh0bVNmJYB84TM/NqrD7kB8nB/h6nvvdn8XJqgFPITExxDu/SldDMDIHjb1mKy9GnqbhkN5cenjCN28Uwd84s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nummela.org; spf=pass smtp.mailfrom=nummela.org; dkim=pass (2048-bit key) header.d=nummela.org header.i=@nummela.org header.b=Vn5g4S9/; arc=none smtp.client-ip=51.195.103.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nummela.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nummela.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nummela.org
	; s=20250215; h=MIME-Version:Content-Type:Subject:To:From:Message-ID:Date:
	Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=o6yuJGmmK6cQYgJlvy6zmZ+i9aI+lmgMCydHwy+w3Ws=; b=Vn5g4S9//br8zqtUW2lPjEwy4f
	wmBUSd8wU+7HE7g897fCLcuroXkKJxDe+VZGl5s9NprTEjTAwGraOMzQnMHpyNICng0l4o56lj9Bo
	VGlrJBm6ExhYmeirOP91c/VsSD3Xg2jpUpyTDf5uGUVvCJYoQYEmi7Iv0yFzsjkgcd+epQEN+ZY2H
	ac1gcXuOsYrJJwWg07hxlZ8erD/Jne3vconDAvwv0BBZGaHK5YLqziP/LRkzjOAUiOxjlD9/wCdjG
	vHWif26eXtlvapEkAS8rHmN4/0OsC0YF/pz2Ub3Wm6vwHcIAKnWRn2rAVXjU+HgKjJF5RFtIJRQv/
	tdQyvzrA==;
Received: from chai.nummela.org ([2001:41d0:701:1100::a7eb] helo=vps-8cfc3056)
	by vps-8cfc3056.vps.ovh.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ville@nummela.org>)
	id 1w2k6k-0000uL-1G
	for linux-wireless@vger.kernel.org;
	Wed, 18 Mar 2026 06:10:18 +0000
Received: from 109-204-177-37.cust.valoonet.fi
 (109-204-177-37.cust.valoonet.fi [109.204.177.37]) by www.nummela.org (Horde
 Framework) with HTTPS; Wed, 18 Mar 2026 06:10:18 +0000
Date: Wed, 18 Mar 2026 06:10:18 +0000
Message-ID: <20260318061018.Horde.a06VxaHRNwVUkzqm2u-EwFA@www.nummela.org>
From: Ville Nummela <ville@nummela.org>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: rsi_91x_usb: do not pause rfkill polling when
 stopping mac80211
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nummela.org:s=20250215];
	MID_RHS_WWW(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nummela.org : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[nummela.org:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33372-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ville@nummela.org,linux-wireless@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.858];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2164F2B6373
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
Changes since v1:
  - Fix issues reported by checkpatch

  drivers/net/wireless/rsi/rsi_91x_mac80211.c | 17 ++++++++++++++++-
  drivers/net/wireless/rsi/rsi_91x_usb.c      |  2 ++
  drivers/net/wireless/rsi/rsi_common.h       |  1 +
  3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c  
b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
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
+       struct ieee80211_hw *hw = adapter->hw;
+
+       if (hw)
+               wiphy_rfkill_stop_polling(hw->wiphy);
+}
+EXPORT_SYMBOL_GPL(rsi_mac80211_rfkill_exit);
+
  /**
   * rsi_indicate_tx_status() - This function indicates the transmit status.
   * @adapter: Pointer to the adapter structure.
@@ -422,7 +438,6 @@ static void rsi_mac80211_stop(struct ieee80211_hw  
*hw, bool suspend)
         rsi_dbg(ERR_ZONE, "===> Interface DOWN <===\n");
         mutex_lock(&common->mutex);
         common->iface_down = true;
-       wiphy_rfkill_stop_polling(hw->wiphy);

         /* Block all rx frames */
         rsi_send_rx_filter_frame(common, 0xffff);
diff --git a/drivers/net/wireless/rsi/rsi_91x_usb.c  
b/drivers/net/wireless/rsi/rsi_91x_usb.c
index d83204701e27..8765cac6f875 100644
--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -877,6 +877,8 @@ static void rsi_disconnect(struct usb_interface  
*pfunction)
         if (!adapter)
                 return;

+       rsi_mac80211_rfkill_exit(adapter);
+
         rsi_mac80211_detach(adapter);

         if (IS_ENABLED(CONFIG_RSI_COEX) && adapter->priv->coex_mode > 1 &&
diff --git a/drivers/net/wireless/rsi/rsi_common.h  
b/drivers/net/wireless/rsi/rsi_common.h
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



