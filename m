Return-Path: <linux-wireless+bounces-20488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38208A66EFC
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 09:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEBC189191F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C31DF251;
	Tue, 18 Mar 2025 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dQsOhIVk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8E1F09A3
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287758; cv=none; b=MkU1woONw8yn0FQ9Rx5g8Qo3o6h+0MLqgZqtflnLhWVMfOx2sq4kB73svqgRA7rpgRh3+BPv4vU+lXFK7/vtyA2etw5WPprMD1X4rfQSNX9i3KfADNNBxU90YqxbSvaWw5kh4odSO59q9Xrxc5UVKA+aIE3xwrh8N9kBDJnuHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287758; c=relaxed/simple;
	bh=mWHg8e9lLOChlYYR8tnlPW+CvHa8hkh7Vg5Lb7bJSZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWaf5IvJGx5jgOtgDiSQEAsnvr6xRyZw5JaoAGKmWgYpgLocEECShh4mQtl6mxb/Dm+VRTr7QkBUfANYqwsRbLQk8c8x2H/ta0+trupWOddZDQusKjoBMrSSXuWlPnGfLUc4F3kBY4kGxJJAYDBXp1B7tbuIzOpwLXIKABrZAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dQsOhIVk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=5EPCC4KvL8uQ30Gby7vro9CyuiEbTvjXe424Lj1BhHw=; t=1742287752; x=1743497352; 
	b=dQsOhIVki0XCKhtEySzVfJ3gHwPGN1ENsdHrzTS7/sKimoPVdsfYvtmf5jhaX3kyAMEpsezX9Gd
	Pjk9ymsQOJzusT47s6PM/k5l1j4wTXvy6sILxawVX6lOzoI1c/CDzh8devLnK6hlBlQXqrcJAUGJ8
	KNntpT+LNRZ9AGTdK/jF4MZLBEFIZlkMRt3Ipp0Yjt1Q2669DJ49Ylv14WZWb0NjDLFWYD6fCTxah
	O1EkwU/o8el7M5EG3vN/eBPNb/rtFL+OjSI6Qea4TYbV+gvsLH/vuGgKvbLbH6HZbrNsAuiVpF3F6
	GfaAKlol1rOypfVvDnftyMNB0PwJtUBM6c9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuSdD-0000000FAZd-2qBk;
	Tue, 18 Mar 2025 09:49:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] wifi: nl80211: re-enable multi-link reconfiguration
Date: Tue, 18 Mar 2025 09:49:01 +0100
Message-ID: <20250318094901.3e43980d0dd6.Ic6ed3d184e5be8ba47c6affa7271daaf824fd823@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

With the recent fixes, we can re-enable multi-link
reconfiguration. Also add a CMD() entry to allow
userspace discovery for it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 299d575cf60e..2b9f50ad7470 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2773,6 +2773,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			CMD(update_ft_ies, UPDATE_FT_IES);
 			if (rdev->wiphy.sar_capa)
 				CMD(set_sar_specs, SET_SAR_SPECS);
+			CMD(assoc_ml_reconf, ASSOC_MLO_RECONF);
 		}
 #undef CMD
 
@@ -16557,7 +16558,7 @@ static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
 		req.ext_mld_capa_ops =
 			nla_get_u16(info->attrs[NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS]);
 
-	err = -EOPNOTSUPP;
+	err = cfg80211_assoc_ml_reconf(rdev, dev, links, rem_links);
 
 out:
 	for (link_id = 0; link_id < ARRAY_SIZE(req.add_links); link_id++)
-- 
2.48.1


