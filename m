Return-Path: <linux-wireless+bounces-23546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A192ACC463
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C5D18935E0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014BA226D08;
	Tue,  3 Jun 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Dzp9Udt7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC924227E9B
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946852; cv=none; b=sVhUm30SJWF9sxTGMTgiwXp3aP3dg2F6iwLBru1YVsEEfxK4IvaiFleoMP41ZlKDAw1aQ1ch5g5+L271RW/ghMnJ/ygDHtXXrwktJ/tx3yfZPoh494f8Z30I9FEBimAQuAsD9Hob0QhOhBGSAyopUQS0U5XxGU8SYt3FbuQla1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946852; c=relaxed/simple;
	bh=v7zBSG7olmCeG4gl01X01XXFrXsbVghOVYDCkedNy20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnCJ92o3zvy2AYU46ebCyLIVUavkbekEhIdX2PLBpLcbqLRNIecGEHIWUc9WLML1TSBjsCwILiMNeF8cAkXkGdXs8acSyAG5P9WNlHelZTyumNH4mBWmOS9lMi4kqT0f28ZTHrWoERqDq14IH106smZC0W/PH+OTkAmgNG37vco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Dzp9Udt7; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748946851; x=1780482851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v7zBSG7olmCeG4gl01X01XXFrXsbVghOVYDCkedNy20=;
  b=Dzp9Udt7RJdWSI5CzfcTXHn26grZN0eGKzQG1O+fiSSiqG42yvYNDJ2O
   F0Fx5AzueK78Kxsc70ktF54DwHZgaGhcTXkrAqUiXx92rAxXnEk0vAm4W
   WQTfk2MCFCKWpF0TgZt6aI+BzaXcz3J+H2WuBfPIHMvabwsSrjHFRgAK3
   w=;
X-CSE-ConnectionGUID: Ap4fr8CZSieWWMmf+odctQ==
X-CSE-MsgGUID: 8llYkxBkRc22MGNzz8EErA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="87132005"
X-IronPort-AV: E=Sophos;i="6.16,205,1744063200"; 
   d="scan'208";a="87132005"
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:34:09 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 12:34:08 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 12:34:06 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 5/5] wifi: mac80211: reject SET_BSS if any changed AP BSS param is not supported
Date: Tue, 3 Jun 2025 16:02:52 +0530
Message-ID: <20250603103252.18039-6-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
References: <20250603103252.18039-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
 MUCSE827.infineon.com (172.23.29.20)

The userspace can change more than one AP BSS Parameter in the SET_BSS
operation. Incase if any BSS param other than the list of parameters
currently supported for explicit configuration are passed by userspace,
reject the entire SET_BSS operation.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 net/mac80211/cfg.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d9d88f2f2831..c57d6f995fa7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2751,6 +2751,20 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	struct ieee80211_supported_band *sband;
 	u64 changed = 0;
 
+	/* Reject the operation if any of the AP BSS params that got changed are not
+	 * supported by the driver for explicit configuration.
+	 */
+	if (params->changed &
+	    ~(CFG80211_BSS_PARAM_CHANGED_CTS_PROT |
+	      CFG80211_BSS_PARAM_CHANGED_SHORT_PREAMBLE |
+	      CFG80211_BSS_PARAM_CHANGED_SHORT_SLOT_TIME |
+	      CFG80211_BSS_PARAM_CHANGED_BASIC_RATES |
+	      CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE |
+	      CFG80211_BSS_PARAM_CHANGED_HT_OPMODE |
+	      CFG80211_BSS_PARAM_CHANGED_P2P_CTWINDOW |
+	      CFG80211_BSS_PARAM_CHANGED_P2P_OPPPS))
+		return -EOPNOTSUPP;
+
 	link = ieee80211_link_or_deflink(sdata, params->link_id, true);
 	if (IS_ERR(link))
 		return PTR_ERR(link);
-- 
2.47.0


