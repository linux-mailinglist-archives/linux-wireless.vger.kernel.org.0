Return-Path: <linux-wireless+bounces-13771-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FA996267
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD65A1F23378
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A81188CC4;
	Wed,  9 Oct 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="IfABApi6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FB1885A6
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462364; cv=none; b=QOvqo/eWSYLGe9uiF8cQygZd7EejgbbTIsfTe1WmIUqlFa1PcDrwij0DgMT1xh2x4irW9Q5JPvC/+aeh2c5RGziTV+vHSuwOras8MCiZQEAswwcy38I9b1zKapfE3a+jo3r+OqqRytMi232a54ZeK8JUqsboXAOLyZdFcZ73zoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462364; c=relaxed/simple;
	bh=dFhbS7xLehSrIrwcUsWLVUkW18BRdBqb/hce7X3b5xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFdtO9bMTquliDa22Zpdxl8cjOAsC4px4SwvBgNKn/8t9yYYgSDBP/Omyl1/uvm2c/hJkbeCRV8+a9P6+R0O3COABp5NhOpDKPVxL7LHrHTcKBoDDu7U819LTL5nVqj4C9SubSG8BI9JTXz8aXMHJglk8iAQU7SiyA2PGr/W/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=IfABApi6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=p/xRrdutwkUzpmwjSM2Y8O9DsLB8sCu8/v60pB+dPXg=; b=IfABApi6tHUxLEijp8Apr6p3XD
	kYCUPQXZ61gA0MarBq9XOMiPGt7wS2zt8w8WpKk6DosOy5m8BQGOvzgoVEVYjGwDjtY17v39QLxly
	G3lJd8MipP5JvDu4TijTrVfPAKHJTuWuqxFSL5VR2PYIPqHfzq8Mf1u684Su51bpr33Y=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1syS13-006e0I-2i;
	Wed, 09 Oct 2024 10:25:53 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v5 04/11] wifi: cfg80211: report per wiphy radio antenna mask
Date: Wed,  9 Oct 2024 10:25:45 +0200
Message-ID: <e0a26afa2c88eaa188ec96ec6d17ecac4e827641.1728462320.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
References: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With multi-radio devices, each radio typically gets a fixed set of antennas.
In order to be able to disable specific antennas for some radios, user space
needs to know which antenna mask bits are assigned to which radio.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h       | 4 ++++
 include/uapi/linux/nl80211.h | 3 +++
 net/wireless/nl80211.c       | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e4441e4536ae..636b9b32aa31 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5436,6 +5436,8 @@ struct wiphy_radio_freq_range {
  * @iface_combinations: Valid interface combinations array, should not
  *	list single interface types.
  * @n_iface_combinations: number of entries in @iface_combinations array.
+ *
+ * @antenna_mask: bitmask of antennas connected to this radio.
  */
 struct wiphy_radio {
 	const struct wiphy_radio_freq_range *freq_range;
@@ -5443,6 +5445,8 @@ struct wiphy_radio {
 
 	const struct ieee80211_iface_combination *iface_combinations;
 	int n_iface_combinations;
+
+	u32 antenna_mask;
 };
 
 #define CFG80211_HW_TIMESTAMP_ALL_PEERS	0xffff
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d31ccee99cc7..1b8827f920ff 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8036,6 +8036,8 @@ enum nl80211_ap_settings_flags {
  * @NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION: Supported interface
  *	combination for this radio. Attribute may be present multiple times
  *	and contains attributes defined in &enum nl80211_if_combination_attrs.
+ * @NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK: bitmask (u32) of antennas
+ *	connected to this radio.
  *
  * @__NL80211_WIPHY_RADIO_ATTR_LAST: Internal
  * @NL80211_WIPHY_RADIO_ATTR_MAX: Highest attribute
@@ -8046,6 +8048,7 @@ enum nl80211_wiphy_radio_attrs {
 	NL80211_WIPHY_RADIO_ATTR_INDEX,
 	NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE,
 	NL80211_WIPHY_RADIO_ATTR_INTERFACE_COMBINATION,
+	NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
 
 	/* keep last */
 	__NL80211_WIPHY_RADIO_ATTR_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7f3bd35c8a3b..ab87587df408 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2431,6 +2431,11 @@ static int nl80211_put_radio(struct wiphy *wiphy, struct sk_buff *msg, int idx)
 	if (nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_INDEX, idx))
 		goto nla_put_failure;
 
+	if (r->antenna_mask &&
+	    nla_put_u32(msg, NL80211_WIPHY_RADIO_ATTR_ANTENNA_MASK,
+			r->antenna_mask))
+		goto nla_put_failure;
+
 	for (i = 0; i < r->n_freq_range; i++) {
 		const struct wiphy_radio_freq_range *range = &r->freq_range[i];
 
-- 
git-series 0.9.1

