Return-Path: <linux-wireless+bounces-35870-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED0YLG23+Gn1zAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35870-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 17:12:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA774C07E5
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B0FA30167AC
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CA3DE44C;
	Mon,  4 May 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNFu3G2A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE433D9DBB
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906201; cv=none; b=gZ41iNgl8TjGZFh3JbpSPIHmN/XFTwB0wq2i5S4WX5PUJsA812EBFwvLPz1HL39mlWZQIjNZRU7fKot0Mmm0tVNFXxM8krhacPVDaalbj9wTsspanenqYVbiBb1qwG6bcItfEPAq7gGtzbmqtY+qFHCgoPC+cJQff7XPReHxzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906201; c=relaxed/simple;
	bh=tqvm43wvsR8GFjbtDI0arKFPhNLZMxt0mILMOUmpHSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fex9U/67KhwYmTAz3tP0fO4440GYou2Q7kywXTPT0nvWSlcLLGYJ3pLuorxpIO/MP/STB4JgoY/NIW0+Ec0RS7jDVjLztViaXBuhK43mJcRR5INS6WX8HP1y/8A+kWk1tgaOpUc+UmjhGOJLAw/BLxU+lraXnDqr9zI71XqhQDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNFu3G2A; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777906199; x=1809442199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqvm43wvsR8GFjbtDI0arKFPhNLZMxt0mILMOUmpHSg=;
  b=dNFu3G2AKfWpIeFQIB915wp2hdR4lqu/5T6OLbc3Ay7zyUdH9hkBxf5q
   5mRiKE5/HgIW7Es23v/cfqkNQZSkztMZ9BP5dKl8ru05aE8tZYSUX3Qfg
   pDbxudOziepVdJGUVMbI1+TjGv3HcpTii4w8BGYl7HqLZqiyiJyPNu/wk
   QPxUJjmtmB/Z4MrVz1TYD8ARQlElXqYocntdOCVp9F0gqSJ3ytJOhbTSM
   5C1chN+kgtRcTprSOBaqWBOABoiPcdzVZA7VMW7Nk+ZqSnufoMi8D9/Hu
   q7HyLLd5yEFoH+WAb1J/h8IgcJ0K9Emx+FoLdesWXQSio+h6S8GLAsF9g
   Q==;
X-CSE-ConnectionGUID: r/mmQojIQmOnhQmsJhmxDQ==
X-CSE-MsgGUID: pouUrof8TtOQX8eRkjxQhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78694447"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78694447"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:49:59 -0700
X-CSE-ConnectionGUID: +uDe2K0MQBSPIEWH2B6HyQ==
X-CSE-MsgGUID: vhYZaEyuS1mbc55hKie8qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="259182110"
Received: from arjan-box.jf.intel.com ([10.88.27.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:49:58 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-wireless@vger.kernel.org
Cc: Arjan van de Ven <arjan@linux.intel.com>,
	Bongani Hlope <developer@hlope.org.za>,
	linux-mediatek@lists.infradead.org,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon
Date: Mon,  4 May 2026 07:51:06 -0700
Message-ID: <20260504145107.1329197-1-arjan@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502125824.425d7159@bongani-mini.home.org.za>
References: <20260502125824.425d7159@bongani-mini.home.org.za>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CA774C07E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35870-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arjan@linux.intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mediatek.com:email,nbd.name:email,hlope.org.za:email]

This patch is based on a BUG as reported by Bongani Hlope at
https://lore.kernel.org/all/20260502125824.425d7159@bongani-mini.home.org.za/

When a channel-switch announcement (CSA) beacon is received,
cfg80211 queues a wiphy work item that eventually calls
mt7921_channel_switch_rx_beacon(). If the station disconnects
(or the channel context is otherwise torn down) between the
time the work is queued and the time it runs, the driver's
dev->new_ctx pointer can already have been cleared to NULL.
mt7921_channel_switch_rx_beacon() then dereferences new_ctx
unconditionally, triggering a NULL pointer dereference at
address 0x0:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:mt7921_channel_switch_rx_beacon+0x1f/0x100 [mt7921_common]

The same missing guard exists in mt7925_channel_switch_rx_beacon(),
which shares the same code pattern introduced by the same commit.

Add an early-return NULL check for dev->new_ctx in both
mt7921_channel_switch_rx_beacon() and
mt7925_channel_switch_rx_beacon(). When new_ctx is NULL there is
no pending channel switch to process, so returning immediately is
the correct and safe action.

Fixes: 8aa2f59260eb ("wifi: mt76: mt7921: introduce CSA support")
Reported-by: Bongani Hlope <developer@hlope.org.za>
Oops-Analysis: http://oops.fenrus.org/reports/lkml/20260502125824.425d7159@bongani-mini.home.org.za/report.html
Link: https://lore.kernel.org/all/20260502125824.425d7159@bongani-mini.home.org.za/
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>

---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |    3 +++
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |    3 +++
 2 files changed, 6 insertions(+)

--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1503,6 +1503,9 @@ static void mt7921_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	u16 beacon_interval = vif->bss_conf.beacon_int;
+
+	if (!dev->new_ctx)
+		return;
 
 	if (cfg80211_chandef_identical(&chsw->chandef,
 				       &dev->new_ctx->def) &&
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2392,6 +2392,9 @@ static void mt7925_channel_switch_rx_beacon(struct ieee80211_hw *hw,
 	u16 beacon_interval;
 
 	if (ieee80211_vif_is_mld(vif))
 		return;
+
+	if (!dev->new_ctx)
+		return;
 
 	beacon_interval = vif->bss_conf.beacon_int;
 

