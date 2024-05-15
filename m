Return-Path: <linux-wireless+bounces-7685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C868C6637
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C731F21B17
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5B7441E;
	Wed, 15 May 2024 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D7k2cVhb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A6C74416
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775367; cv=none; b=grGQRnYh/Vx+vAdYEfx5mn515RM7x/vlvnQzP2EdSdwdFzTKazPqIYEIhr/hCOxgN1PV8YrMvoyzGHKUvhvoedb+t9gGGphEXcyWYsRjV0/28up8vTM7S09WcJ47iOCaQiRLmDZ37LG1Nu4a1LpliEBKRA49ZkNPvUHbomDXrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775367; c=relaxed/simple;
	bh=diKJUdrqltDDq72ItvhagNv5YQOX4bos/g65U+9+Bek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sEWmv3sWB1bOmNCUVXbAqzqMWDD8RQ5ds1D2C4Iv7tqfH4dZZtngsm9YJyx1CGE9wWKKMLW3wqlpb6tIWAC/2XLLHLLaHCx3vHpO9nnUIHMJB7sPp/QZA7qi3cZEtk/YY1Uvlwcu/BwmIcoSnlCF211sKlTQKX2LEOfYUT7gj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D7k2cVhb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=fkuhbwjfpmhiKKeaZ7lZ91SaVCGdFoO3hkLfDGnNvfE=; t=1715775365; x=1716984965; 
	b=D7k2cVhb8bbQO3k4qlyZKJrVQbo5ov8q5YiHOGH4anKd7w57RROwfhWAhe7PBBGYefyMJYgAWJn
	SSLub3EnVN0EbhiKwm1Ym3ruj7IYa2NX1M1BCfhcSI+rCs62rBCC3flOhCbWmQmBeTTWqgvQ9y2oe
	1yfs+GoGygW1Dt6Pbmoogj2DlvX2FHHJk2UdDXnYIytwJ4W8CGlDfopydpbDj+G+tAHMQqzN0ICZy
	ozIlxPwhMUbJRD+6ECCcBE1c2XdsGuTCsxpj+yYRGHQc+yn4n31Kxu8/uIdK4znL6fxqb0/9z0UUE
	CA7Exf4MzM3UQcbVrxo1wUGjDNJIjT+PLE+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s7DYA-00000006PX1-2UwG;
	Wed, 15 May 2024 14:16:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+bc0f5b92cc7091f45fb6@syzkaller.appspotmail.com
Subject: [PATCH] wifi: nl80211: disallow setting special AP channel widths
Date: Wed, 15 May 2024 14:16:00 +0200
Message-ID: <20240515141600.d4a9590bfe32.I19a32d60097e81b527eafe6b0924f6c5fbb2dc45@changeid>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Setting the AP channel width is meant for use with the normal
20/40/... MHz channel width progression, and switching around
in S1G or narrow channels isn't supported. Disallow that.

Reported-by: syzbot+bc0f5b92cc7091f45fb6@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3c0bca4238d3..93c313149f57 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3415,6 +3415,33 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 			if (chandef.chan != cur_chan)
 				return -EBUSY;
 
+			/* only allow this for regular channel widths */
+			switch (wdev->links[link_id].ap.chandef.width) {
+			case NL80211_CHAN_WIDTH_20_NOHT:
+			case NL80211_CHAN_WIDTH_20:
+			case NL80211_CHAN_WIDTH_40:
+			case NL80211_CHAN_WIDTH_80:
+			case NL80211_CHAN_WIDTH_80P80:
+			case NL80211_CHAN_WIDTH_160:
+			case NL80211_CHAN_WIDTH_320:
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			switch (chandef.width) {
+			case NL80211_CHAN_WIDTH_20_NOHT:
+			case NL80211_CHAN_WIDTH_20:
+			case NL80211_CHAN_WIDTH_40:
+			case NL80211_CHAN_WIDTH_80:
+			case NL80211_CHAN_WIDTH_80P80:
+			case NL80211_CHAN_WIDTH_160:
+			case NL80211_CHAN_WIDTH_320:
+				break;
+			default:
+				return -EINVAL;
+			}
+
 			result = rdev_set_ap_chanwidth(rdev, dev, link_id,
 						       &chandef);
 			if (result)
-- 
2.45.0


