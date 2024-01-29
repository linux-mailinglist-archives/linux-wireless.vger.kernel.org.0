Return-Path: <linux-wireless+bounces-2704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC6841300
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D611F27738
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5E2E657;
	Mon, 29 Jan 2024 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="J+mim1Fb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762242C6AA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555103; cv=none; b=ZJX/qHQOuDUR5KUuDnpDwJyRVlvbYd+j40ZcAD8+XZ3KLALw/RlVkTifVk3idRqcHou/QSLaF/oarA6zQfrL/E+UWke0/Jd0rOyyzQ/4zZ7QkMcXsaknMysAW6+823Pl76hlm3r+V9x1JiRzxpohQ2qKOSJrBseGHRjfL9EQBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555103; c=relaxed/simple;
	bh=dsT/kS56HWf/EoStEE1TEp6zjQVYMJxCe71V/+2qaNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ngmc5hwBYIeORDF4+dJzmZeqytla06vBraRCCH298qDKItyMAyo1n8NAJ7hV3IbxaicUVpuJPSDYj4ieCXHGGy1GaMexGyof5kE8ANUu8U2ScTWqdec2IyALeLy20JmUKIBVfNhG0KO2G/wzHV1JK6N472gIejbN0HDwUd9pIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J+mim1Fb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=9Iv6N1Vq2eZm/90oh/4vYTqUWGL5mKAxEZvaAx1sBtQ=; t=1706555101; x=1707764701; 
	b=J+mim1FbXvYAcfDB3igPHOzey220uD2H6W7WgOLxQTbtqT2rcqRCfo8kWL4GQqocvQhvzZGFQTh
	sRxqZZ/RWkIrYN3sMX6cV5QKZBZDcZvUXPvU6NbuM79cv3BUTjxYuV7x/fKtLhT+adiw2HlfojZOJ
	rz748HgkmZ/UtlSn6D+2R0Rkq+StTGviaRdfFMIORii1e6aIt1dPlGPaQVt8Bn/8MUWwrKZhCfV+H
	4UCV3wsS4lS11CSXcC9NEv34rbZFlVw9R+RD6XpEmxXUbzHYJmBDnelaTGDi5Hy/IJso0bwQ76DHP
	4J5yp5zgXJJL1JrgQQlKlEWfZuToEKqNE9oA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWwE-0000000506V-4BE0;
	Mon, 29 Jan 2024 20:04:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/2] wifi: mac80211: add/use ieee80211_get_sn()
Date: Mon, 29 Jan 2024 20:04:56 +0100
Message-ID: <20240129200456.f0ff49c80006.I850d2785ab1640e56e262d3ad7343b87f6962552@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This will also be useful for MLO duplicate multicast
detection, but add it already here and use it in one
place that trivially converts.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 7 ++++++-
 net/mac80211/rx.c         | 5 ++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index d9d2c1253157..b9367d5f04c4 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -9,7 +9,7 @@
  * Copyright (c) 2006, Michael Wu <flamingice@sourmilk.net>
  * Copyright (c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (c) 2018 - 2023 Intel Corporation
+ * Copyright (c) 2018 - 2024 Intel Corporation
  */
 
 #ifndef LINUX_IEEE80211_H
@@ -808,6 +808,11 @@ static inline bool ieee80211_is_frag(struct ieee80211_hdr *hdr)
 	       hdr->seq_ctrl & cpu_to_le16(IEEE80211_SCTL_FRAG);
 }
 
+static inline u16 ieee80211_get_sn(struct ieee80211_hdr *hdr)
+{
+	return le16_get_bits(hdr->seq_ctrl, IEEE80211_SCTL_SEQ);
+}
+
 struct ieee80211s_hdr {
 	u8 flags;
 	u8 ttl;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 615795c4b052..16d8783a469d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -1251,8 +1251,7 @@ static bool ieee80211_sta_manage_reorder_buf(struct ieee80211_sub_if_data *sdata
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	u16 sc = le16_to_cpu(hdr->seq_ctrl);
-	u16 mpdu_seq_num = (sc & IEEE80211_SCTL_SEQ) >> 4;
+	u16 mpdu_seq_num = ieee80211_get_sn(hdr);
 	u16 head_seq_num, buf_size;
 	int index;
 	bool ret = true;
-- 
2.43.0


