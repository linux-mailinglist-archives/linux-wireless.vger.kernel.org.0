Return-Path: <linux-wireless+bounces-10971-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D913894823F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486ED2837C4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147AF16BE04;
	Mon,  5 Aug 2024 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="ezQDe0zX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730FD166F3B
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885821; cv=none; b=SAh02CitXvNedRhhIeRm9BhamgGN1DUYvu5ACk6F8R6EXV1+qoU+r46aevRC8226XbMb/iN8k9BdeC5Sl+PZO2mAYKB7K6aPY11czJmIWQunZdN03eSIJNhPJ1rj+ANPunbp1v3swhcCG2lO2B66dE7xEShM43ScIqL4ZCl75Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885821; c=relaxed/simple;
	bh=hSejJxif2Z42ZWmrWymPYvNDn4fkiywAb6dhrGg0L9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buM0n+hUQEcJ/CI8eDnhxyjFIUT+DhimI0FFk+sfcLFMLMBFPgDti4ydZIx+QzzOmJQHouWgKjVWeUvUiJXaD3LXoIyfh50WECPQzCKRQgWaJYijYQ4eeBTp0mWec4oIX2cGsVTZ8h98+V1iydsd/kZkm6ezexyPbUHa/PZzlNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=ezQDe0zX; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CTw/dAm0owD3Ec4g9+Ipal0aOOfQmrw0Sp4U/Z0tMZ8=; b=ezQDe0zX3SA89o9Wo3rtAIqJJK
	ca0gXe+tr69mrVhJVrdwBTT6triwJLVLXvZkiRrkUpIWsK7X9MtvgG81N/EKbSH0PEUA4pB+c8SKA
	4PTQlFUzUVc7zo6oww6c+35zXWOo40QHAP+HUhPTL1aeFhPwCP4ggoD5FSwjGbemVdEE=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb3Iu-00EHlS-1y;
	Mon, 05 Aug 2024 21:23:36 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 4/6] wifi: mac80211: support per-radio driver start/stop calls
Date: Mon,  5 Aug 2024 21:23:32 +0200
Message-ID: <85f5dcd7432c2b82dbf8de5df09d44935ebeecfe.1722885720.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Radios are started/stopped based on the vif allowed radios. This allows
drivers to keep unused radios inactive.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h     | 13 +++++++++++++
 net/mac80211/driver-ops.h  | 32 ++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/iface.c       | 37 +++++++++++++++++++++++++++++++++++--
 net/mac80211/trace.h       | 10 ++++++++++
 5 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7bee2d912efe..d0dcd66e565e 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3827,6 +3827,17 @@ struct ieee80211_prep_tx_info {
  *	you should ensure to cancel it on this callback.
  *	Must be implemented and can sleep.
  *
+ * @start_radio: Called before the first netdevice attached to the radio
+ *	is enabled. This should turn on the per-radio hardware and must turn
+ *	on frame reception (for possibly enabled monitor interfaces.)
+ *	Returns negative error codes, these may be seen in userspace,
+ *	or zero. It can sleep.
+ *
+ * @stop_radio: Called after last netdevice attached to the radio
+ *	is disabled. This should turn off the per-radio hardware.
+ *	May be called right after add_interface if that rejects
+ *	an interface. It can sleep.
+ *
  * @suspend: Suspend the device; mac80211 itself will quiesce before and
  *	stop transmitting and doing any other configuration, and then
  *	ask the device to suspend. This is only invoked when WoWLAN is
@@ -4440,6 +4451,8 @@ struct ieee80211_ops {
 		   struct sk_buff *skb);
 	int (*start)(struct ieee80211_hw *hw);
 	void (*stop)(struct ieee80211_hw *hw, bool suspend);
+	int (*start_radio)(struct ieee80211_hw *hw, int idx);
+	void (*stop_radio)(struct ieee80211_hw *hw, int idx);
 #ifdef CONFIG_PM
 	int (*suspend)(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan);
 	int (*resume)(struct ieee80211_hw *hw);
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index d382d9729e85..cedc12b98bbb 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -90,6 +90,38 @@ static inline int drv_get_et_sset_count(struct ieee80211_sub_if_data *sdata,
 int drv_start(struct ieee80211_local *local);
 void drv_stop(struct ieee80211_local *local, bool suspend);
 
+static inline int drv_start_radio(struct ieee80211_local *local, u32 idx)
+{
+	int ret;
+
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (!local->ops->start_radio || local->radio_data[idx].started)
+	    return 0;
+
+	trace_drv_start_radio(local, idx);
+	ret = local->ops->start_radio(&local->hw, idx);
+	if (!ret)
+		local->radio_data[idx].started = true;
+	trace_drv_return_int(local, ret);
+	return ret;
+}
+
+static inline void drv_stop_radio(struct ieee80211_local *local, u32 idx)
+{
+	might_sleep();
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	if (!local->ops->stop_radio || !local->radio_data[idx].started)
+	    return;
+
+	trace_drv_stop_radio(local, idx);
+	local->ops->stop_radio(&local->hw, idx);
+	local->radio_data[idx].started = false;
+	trace_drv_return_void(local);
+}
+
 #ifdef CONFIG_PM
 static inline int drv_suspend(struct ieee80211_local *local,
 			      struct cfg80211_wowlan *wowlan)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3be9f8149117..acc1a2d0f30f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1332,6 +1332,8 @@ DECLARE_STATIC_KEY_FALSE(aql_disable);
 
 struct ieee80211_radio_data {
 	u32 monitors;
+	u32 open_count;
+	bool started;
 };
 
 struct ieee80211_local {
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 4db867ae97f0..20a4a19c8ba1 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -578,8 +578,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		spin_unlock_irqrestore(&ps->bc_buf.lock, flags);
 	}
 
-	if (going_down)
+	if (going_down) {
+		for (i = 0; i < local->hw.wiphy->n_radio; i++)
+			if (sdata->wdev.radio_mask & BIT(i))
+				local->radio_data[i].open_count--;
 		local->open_count--;
+	}
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP_VLAN:
@@ -714,6 +718,14 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	if (cancel_scan)
 		wiphy_delayed_work_flush(local->hw.wiphy, &local->scan_work);
 
+	for (i = 0; i < local->hw.wiphy->n_radio; i++) {
+		if (!(sdata->wdev.radio_mask & BIT(i)) ||
+		    local->radio_data[i].open_count)
+			continue;
+
+		drv_stop_radio(local, i);
+	}
+
 	if (local->open_count == 0) {
 		ieee80211_stop_device(local, false);
 
@@ -1294,6 +1306,16 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 					   IEEE80211_TPT_LEDTRIG_FL_RADIO, 0);
 	}
 
+	for (i = 0; i < local->hw.wiphy->n_radio; i++) {
+		if (!(sdata->wdev.radio_mask & BIT(i)) ||
+		    local->radio_data[i].open_count)
+			continue;
+
+		res = drv_start_radio(local, i);
+		if (res)
+			goto err_stop;
+	}
+
 	/*
 	 * Copy the hopefully now-present MAC address to
 	 * this interface, if it has the special null one.
@@ -1444,8 +1466,15 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
 		atomic_inc(&local->iff_allmultis);
 
-	if (coming_up)
+	if (coming_up) {
 		local->open_count++;
+		for (i = 0; i < local->hw.wiphy->n_radio; i++) {
+			if (!(sdata->wdev.radio_mask & BIT(i)))
+				continue;
+
+			local->radio_data[i].open_count++;
+		}
+	}
 
 	if (local->open_count == 1)
 		ieee80211_hw_conf_init(local);
@@ -1462,6 +1491,10 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
  err_stop:
 	if (!local->open_count)
 		drv_stop(local, false);
+	for (i = 0; i < local->hw.wiphy->n_radio; i++)
+		if ((sdata->wdev.radio_mask & BIT(i)) &&
+		    !local->radio_data[i].open_count)
+			drv_stop_radio(local, i);
  err_del_bss:
 	sdata->bss = NULL;
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index dc498cd8cd91..0b6b4ebc681a 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -342,6 +342,16 @@ TRACE_EVENT(drv_stop,
 	TP_printk(LOCAL_PR_FMT " suspend:%d", LOCAL_PR_ARG, __entry->suspend)
 );
 
+DEFINE_EVENT(local_u32_evt, drv_start_radio,
+	     TP_PROTO(struct ieee80211_local *local, u32 idx),
+	     TP_ARGS(local, idx)
+);
+
+DEFINE_EVENT(local_u32_evt, drv_stop_radio,
+	     TP_PROTO(struct ieee80211_local *local, u32 idx),
+	     TP_ARGS(local, idx)
+);
+
 DEFINE_EVENT(local_sdata_addr_evt, drv_add_interface,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata),
-- 
git-series 0.9.1

