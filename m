Return-Path: <linux-wireless+bounces-23550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE7ACC468
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B53E165C6C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48E5226D00;
	Tue,  3 Jun 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="YSM+Yybn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7D53365
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946905; cv=none; b=n7jg2k4F5dlpf7nHKSUfusQF4ng16GZ8YQAAVU7ztjNrzAvFSjsl1q1NkDcOJaU11lEH+LYukfqk5B1xey3mK4dgKq9XmNhb4lzKjEKAETWmL8V46u9qTZvcid/alwxgO+abEvtDBSkU+6YnRnNamtmvJxgjwrCep02HGcUT6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946905; c=relaxed/simple;
	bh=OmhfM5l0F6ZhYAzFl+0A6VmNjBv+K1QrKB9WIAp3zMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XesuUT2Cs09EgK36QlbgGd0vyUtO3dk5iTUwRIYINBJuDn0/bkMoMsJ5+2/T7qq3bCuedsijSd3Uu5h9awNOKfU6ygWM/jzBIXOH75D3DeklgDpIRw188yatBaNBgEWZMyl3vHunZ9a0K86VpfCTiQnSxQn5KudRDyHCbR4z6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=YSM+Yybn; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748946903; x=1780482903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmhfM5l0F6ZhYAzFl+0A6VmNjBv+K1QrKB9WIAp3zMk=;
  b=YSM+YybnhMab32f1SvVl2dWau0d3Ry2nIGhGuxPdVQRLZ9JemsrDMNo0
   GGtUgU2KRqLzFXVdO3ji2IkrB2Bqdt3bqTPXknHl1QIeUqJz89wUv6iPM
   oJ2suiBiaKkyp2g4RLOeYL8uKMGLetpCt5vpPy9jHpWJ9YV7/tCSq5BdQ
   A=;
X-CSE-ConnectionGUID: 4o/r49c7TU+Hg2exKOm3xQ==
X-CSE-MsgGUID: sjq+3EDyR6yrISelyms7aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="87131965"
X-IronPort-AV: E=Sophos;i="6.16,205,1744063200"; 
   d="scan'208";a="87131965"
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 12:33:52 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 12:33:51 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 12:33:49 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 3/5] wifi: wil6210: reject SET_BSS if any changed AP BSS param is not supported
Date: Tue, 3 Jun 2025 16:02:50 +0530
Message-ID: <20250603103252.18039-4-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

The userspace can change more than one AP BSS Parameter in the SET_BSS
operation. Incase if any BSS param other than the currently supported
"ap_isolate" is passed by userspace, reject the entire SET_BSS operation
instead of misleading the userspace that the operation is fully successful.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 5473c01cbe66..fbf7e21d91fe 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2416,6 +2416,13 @@ static int wil_cfg80211_change_bss(struct wiphy *wiphy,
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	struct wil6210_vif *vif = ndev_to_vif(dev);
 
+	/* Reject the operation if any of the AP BSS params that got changed are not
+	 * supported by the driver for explicit configuration.
+	 */
+	if (params->changed &
+	    ~(CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE))
+		return -EOPNOTSUPP;
+
 	if (params->ap_isolate >= 0) {
 		wil_dbg_misc(wil, "change_bss: ap_isolate MID %d, %d => %d\n",
 			     vif->mid, vif->ap_isolate, params->ap_isolate);
-- 
2.47.0


