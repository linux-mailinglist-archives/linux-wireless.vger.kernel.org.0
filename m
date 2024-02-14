Return-Path: <linux-wireless+bounces-3598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6918552EC
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D50291007
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628A613B7A5;
	Wed, 14 Feb 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cg0h1YJE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F713A88E
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937730; cv=none; b=OKeucoURkp7Ul90M8D7x4QtVD826/Seep6nY3DWrwGOZ4jmi+ceVyCNm2MD5sECFa0pbDOJNmAuSGTM3C/jM5IMhu5NoPLPyEO6/gWsNfgJL7xyoOoyizzT8UUWWo1FUlCZ4fA8RhPhZF2usbGtpULg0whxoWUzGdhJVrtdEi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937730; c=relaxed/simple;
	bh=qfFJAi8r9o44mYw1y9EBBjtz5sR47TyPXvZ3KMUpPr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Upm4zOl3ntOcIaYLPLKVCyxVOEFkfJYbEB6G0pIN8+8Z9o5L+NhSmc18QmOskbDUD7llwkYBVoADjkV06P1rxd1ss/nMZzqUfx/UKYfIUzAigK0+4hVhH5DkldmGnyvABf0OW7aJFlt+IdkIM9sc6Tn5JfebECCZ/UDuWGzgT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cg0h1YJE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Z4Iv4XBNJ6zEuSaaf+83iwTpEVjuDkNHFoodGQse414=; t=1707937728; x=1709147328; 
	b=cg0h1YJEspLcTdkiVNZ+C/xoFtJvIWksroJSJXG1MhGqdDk72OhRpFZoMqknE/3UDnbpeHQpUzp
	mO4DgKUuTIuxt7lT3tZe5TSHHgnq0eygRRq7uXt4oc8YXn3cdldNkvE0E9TNx927T+S/OLLs0Wi9K
	z0sh6VxPeo8EIlSZW8FDmHxllewVOUHBTDQo9nG9WCZPa+jTP2tbP83XRDoklde6s0b7hpqtJDlOd
	2Qpg7GqpKtcOMu6Dfw/7bMRPTky6G2iRNHRby4MtWAo/Ym7kQToMZEIBfhF+DkWOAVrelpJWv1eX/
	a+p1Szj829Kw1YF4mS/7SF6RnrYpn4bDmaqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1raKce-00000009KR4-3ow9;
	Wed, 14 Feb 2024 20:08:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: use IEEE80211_MAX_MESH_ID_LEN appropriately
Date: Wed, 14 Feb 2024 20:08:43 +0100
Message-ID: <20240214200843.dc7298f78375.Iba0b6907957abfc4c157005c70ec455e7573cc85@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Even if that's the same as IEEE80211_MAX_SSID_LEN, we really
should just use IEEE80211_MAX_MESH_ID_LEN for mesh, rather
than having the BUILD_BUG_ON()s.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/nl80211.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2b54fdd8ca15..39481e7b9e14 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6204,7 +6204,7 @@ struct wireless_dev {
 			int beacon_interval;
 			struct cfg80211_chan_def preset_chandef;
 			struct cfg80211_chan_def chandef;
-			u8 id[IEEE80211_MAX_SSID_LEN];
+			u8 id[IEEE80211_MAX_MESH_ID_LEN];
 			u8 id_len, id_up_len;
 		} mesh;
 		struct {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bd54a928bab4..5655981e0bff 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4202,8 +4202,6 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 		if (netif_running(dev))
 			return -EBUSY;
 
-		BUILD_BUG_ON(IEEE80211_MAX_SSID_LEN !=
-			     IEEE80211_MAX_MESH_ID_LEN);
 		wdev->u.mesh.id_up_len =
 			nla_len(info->attrs[NL80211_ATTR_MESH_ID]);
 		memcpy(wdev->u.mesh.id,
@@ -4309,8 +4307,6 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_MESH_POINT:
 		if (!info->attrs[NL80211_ATTR_MESH_ID])
 			break;
-		BUILD_BUG_ON(IEEE80211_MAX_SSID_LEN !=
-			     IEEE80211_MAX_MESH_ID_LEN);
 		wdev->u.mesh.id_up_len =
 			nla_len(info->attrs[NL80211_ATTR_MESH_ID]);
 		memcpy(wdev->u.mesh.id,
-- 
2.43.0


