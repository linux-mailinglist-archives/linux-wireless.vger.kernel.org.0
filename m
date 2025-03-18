Return-Path: <linux-wireless+bounces-20494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209EBA6744A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 13:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54839188F4DB
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FCB8479;
	Tue, 18 Mar 2025 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nO3jBkZw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7F290F
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302216; cv=none; b=gNHKrLuWOafFBqMnbokk7/Cggcs0WNRKbMkpF3eXrkb5Hex/dOb0dipIYtq72FgPr28iZi+Z2J0hwCLd1zpI4w67qC7DGaD9DBs+XHOl2mbemxuFFxISZODUTmbNvAGDlf+qFWFTqlgr4rE1oc2vFynm62mzeeOUwQNXUlapXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302216; c=relaxed/simple;
	bh=uKI6wZxpBorfdAv7anMA+DXIMD8DywWnWPs1hpq93Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HnF9GyK68o+/e40bSDzDH+AW8QYEU9GaoA91umzBKMqJZBl/Lga/H/WhvKgmYZ7iIIOezIXswoGMH5stg4ngPbs+A+kLVjQ+mrpwD89NnNn22JaeEMn9W0W80UDXRfCHdpo/GInPsilkzQL2bOeEUP8bq0Riqb84Oa4Y8eJ55SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nO3jBkZw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=vvMy5FpQloptZ2RxAHwVPBhVRkUoIkCV+N6DBD/dGHc=; t=1742302214; x=1743511814; 
	b=nO3jBkZwqVhcfjzJ8grZ0TUlu/UsrHgN3oOREqZvPDcBUvE/GAPIigUfc6NL3yc38JvZxLRXjLO
	/YvWxxWBBMlPen/9a56mZg4ELbezjzlzofXup+Y2hlQLBU3TP3dU91oYZpVp7NrHWouDsXTd9oE3Y
	W37S1Vg88sYJ6MHb9nrznKIi/tYkICiHA6oKuyH3utGOhM9PFJCdsKGlwprvX2kIInRlm9PvAyNyj
	C2pkpE93eEXQ0pbtdRS7ghm6CB5se6QYLnxm4jNnTZ9/sD3LKpupMUCYEloBJ6JQqZ9ol+rMsmD/2
	xs+FWkgixrA20vzp4RIc4t71ZcMQDIAnEzPQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuWOY-0000000FHmz-3xQA;
	Tue, 18 Mar 2025 13:50:11 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v3] wifi: nl80211: re-enable multi-link reconfiguration
Date: Tue, 18 Mar 2025 13:50:08 +0100
Message-ID: <20250318135009.a95c43837a0f.Ic6ed3d184e5be8ba47c6affa7271daaf824fd823@changeid>
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
index 1a9fc403d50d..f039a7d0d6f7 100644
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
+	err = cfg80211_assoc_ml_reconf(rdev, dev, &req);
 
 out:
 	for (link_id = 0; link_id < ARRAY_SIZE(req.add_links); link_id++)
-- 
2.48.1


