Return-Path: <linux-wireless+bounces-24632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F57AEC1A6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 23:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C7D7AC175
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE01F37D3;
	Fri, 27 Jun 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="1WDXOyjm";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Pgzx7g+2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5252ED17B
	for <linux-wireless@vger.kernel.org>; Fri, 27 Jun 2025 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058111; cv=none; b=jRlho7XE7eYT3Wd+mSOMh9UScOTODYcZ3MbUujinHicwtJw91+Mxs5Rjzj95OscM/y99riyHubAfdwPWiTDayoRnt8nLg1uI9QErqXeQCJgY1BGaPSVRAhXRzHfGIi2QWC+a3T+hVAR8pFGiUHf/N+wvhcQBZvzQliVO34phDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058111; c=relaxed/simple;
	bh=HUmZknJWh+4IbGoKHMlrRE2bwWFAclzczTpLLSJQjFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUqjN+dA54aSj1+8K+aslCZ/iZgFWh5A4PwURtwE68ac7CzzV5GknBk8kjqLkd7msC1LWkrMgNpuzbJ+aP/bSnkdsLLaC8qAg6fEnBCndA5VcbPmNcG4jPL3o/Fmroo9vlEHC2guGIZPKuBKrzHt8N116caQuEpJ9+WarJnWxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=1WDXOyjm reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Pgzx7g+2; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1751059010; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=7qQapT4Ems7IYz4MpjuzCT6uqTNZKqM/89+kD4lotE8=; b=1WDXOyjmueLhML330NnAIJLqyP
	jXSkRzpXK/stLujULH9fnhlQvhqtkP9dAlc3moegitMGZEJLLFPnsTW81lyswqxog0xDWQPZPdAvQ
	utJX5kYz+BvqjBKjZeOJ7tyupDSoQArxPyGoSt6SioVhkeOgIA5LYSB50VLCKxkIsX+ittnJsbxGr
	JicMSDHcxpj56w2EFNkeXtlfDGGg0GXgu+i00+yhXZoytnDLAgJ8j76dpUrxOHxt4fP2teA6sloay
	laNCxYOs+Fpfz1u5JcTvDariRq1aysvvf1eLHzSlfYyeSsaGDClGMBj0e4oWH2WGJ8uibs7M3YbA0
	mNdhhaXg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1751058110; h=from : subject
 : to : message-id : date;
 bh=7qQapT4Ems7IYz4MpjuzCT6uqTNZKqM/89+kD4lotE8=;
 b=Pgzx7g+29BURU60bWXXXlT0xEtMZCyg/4DabmCE8E2Xhbd3jwSPmbT/6h1O9q9+0ex8iD
 NbijfrdraP5YJ8DvpnRGaAopcUtg9qQWjE5R4O5fnC7URdImXKXzYOzLUJBiP/HId0yXlUG
 WMfcs55pLwy+tglhQ23F/KlVh2tHllx1Hb3jYh1PNDW6WePIxs3eEomrJTbCjvigXJVvhvN
 ZlRdtSlZuYQlvtvVZQfx8e4C7lK34e5htT/L409ojY7hg/iMDpNYscKqDx7WES8rX8wqvj7
 V4cZGoesaN1O6gX9aJSVaJhWF52/RuZHpZKjI4PSqaBaAkWgawMBGcTOnJwA==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7V-TRk3Xd-0A; Fri, 27 Jun 2025 20:56:25 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uVG7U-FnQW0hPw4yg-n6Sv; Fri, 27 Jun 2025 20:56:24 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH wireless-next 2/3] wifi: mac80211: Check link id at station
 removal
Date: Fri, 27 Jun 2025 22:46:48 +0200
Message-Id: <d02c46bd94d9899811da57ea36b23668042721ba.1751057146.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1751057146.git.repk@triplefau.lt>
References: <cover.1751057146.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 1NNVm5NgDSGU.4s_2QdjCYnm9.SC9mZgUaQTm
Feedback-ID: 510616m:510616apGKSTK:510616so1T645gTN
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

hostapd can remove a non-MLD sta connected to one link of one MLD AP
several times. If the sta roamed to another link of the same MLD AP
between two of those removals the wrong sta_info could be removed.

To fix that remove sta only if it is currently using the link specified
in NL80211_CMD_DEL_STATION if they are any.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/cfg.c      | 3 ++-
 net/mac80211/sta_info.c | 7 ++++++-
 net/mac80211/sta_info.h | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..3dfe8e0759bb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2195,7 +2195,8 @@ static int ieee80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
 	if (params->mac)
-		return sta_info_destroy_addr_bss(sdata, params->mac);
+		return sta_info_destroy_addr_bss(sdata, params->mac,
+						 params->link_id);
 
 	sta_info_flush(sdata, params->link_id);
 	return 0;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 61583173629e..7e58ae507a14 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1530,13 +1530,18 @@ int sta_info_destroy_addr(struct ieee80211_sub_if_data *sdata, const u8 *addr)
 }
 
 int sta_info_destroy_addr_bss(struct ieee80211_sub_if_data *sdata,
-			      const u8 *addr)
+			      const u8 *addr, int link_id)
 {
 	struct sta_info *sta;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	sta = sta_info_get_bss(sdata, addr);
+
+	if (sta && link_id >= 0 && sta->sta.valid_links &&
+	    !(sta->sta.valid_links & BIT(link_id)))
+		return -EINVAL;
+
 	return __sta_info_destroy(sta);
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 7a95d8d34fca..653eda1c2466 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -878,7 +878,7 @@ int __must_check __sta_info_destroy(struct sta_info *sta);
 int sta_info_destroy_addr(struct ieee80211_sub_if_data *sdata,
 			  const u8 *addr);
 int sta_info_destroy_addr_bss(struct ieee80211_sub_if_data *sdata,
-			      const u8 *addr);
+			      const u8 *addr, int link_id);
 
 void sta_info_recalc_tim(struct sta_info *sta);
 
-- 
2.40.0


