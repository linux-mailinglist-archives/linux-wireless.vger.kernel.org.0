Return-Path: <linux-wireless+bounces-23565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6982CACCB04
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 18:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF457188F185
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6527023D2B2;
	Tue,  3 Jun 2025 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="kd1xxo07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8D23D284
	for <linux-wireless@vger.kernel.org>; Tue,  3 Jun 2025 16:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748967092; cv=none; b=otqv5z1p7so+DEMD95btgbCndQS0QXZsOKnJ/W0+jbv3s2fDPfx0eqfGLH//GG2TkZ76eXigQDJyYnrOa6/PqSuJEgyeG4iN8VMjbelMZVLWIhMcuDFyIP239P4THEpbpJV/dqyhsVwVR1miilqNYLoPdaL1ZM9Lk9fS3LeajBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748967092; c=relaxed/simple;
	bh=dPk+kEdfKAKBJnA3eb3KRCqH40i51jVmfJUSWu01TeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4zICHcwmYpRndmO3z4RBFUcmhQs6IA7uu/rqoVCZLk85i0mkp6Oc/PCAtMr+702WzfxzKqCTobUGPT95iFIdbScdBS2yfAORkwWNegE7axvxTxOAruEAGZycW/Rk/f/DA0Vv5fcUTf59jM73vrDZyOrPG4D7mk464XKphR0gvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=kd1xxo07; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1748967091; x=1780503091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dPk+kEdfKAKBJnA3eb3KRCqH40i51jVmfJUSWu01TeI=;
  b=kd1xxo07RI2lxDlnr+A46Kme58GWDlPC8l6/gvYtCZnSPgKDB69+7i56
   5x6GMgFvzG/L07T8Jk/4br/jJEO6HNQoUQJTpOuIhI/p+/OVq4efMqQ/E
   QJlAeY4YI9/Epd5ZN8Ml5oGDKrbJQ0SobQr/JUhIwsm+bg0KR5oNfgTGu
   g=;
X-CSE-ConnectionGUID: 2icU39etRPqwT1/xtlo5hw==
X-CSE-MsgGUID: qbgaTObbSHCrmZX23lR5eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="87165286"
X-IronPort-AV: E=Sophos;i="6.16,206,1744063200"; 
   d="scan'208";a="87165286"
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:11:29 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 18:11:27 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Jun 2025 18:11:25 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v3 2/5] wifi: brcmfmac: support AP isolation to restrict reachability between stations
Date: Tue, 3 Jun 2025 21:40:54 +0530
Message-ID: <20250603161057.19101-3-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603161057.19101-1-gokulkumar.sivakumar@infineon.com>
References: <20250603161057.19101-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 MUCSE827.infineon.com (172.23.29.20)

From: Wright Feng <wright.feng@cypress.com>

hostapd & wpa_supplicant userspace daemons exposes an AP mode specific
config file parameter "ap_isolate" to the user, which is used to control
low-level bridging of frames between the stations associated in the BSS.

In driver, handle this user setting in the newly defined cfg80211_ops
function brcmf_cfg80211_change_bss() by enabling "ap_isolate" IOVAR in
the firmware.

In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
 0 = allow low-level bridging of frames between associated stations
 1 = restrict low-level bridging of frames to isolate associated stations

The userspace can change more than one AP BSS Parameter in the SET_BSS
operation. Incase if any BSS param other than the currently supported
"ap_isolate" is passed by userspace, reject the entire SET_BSS operation
instead of misleading the userspace that the operation is fully successful.

Also add an individual check for the CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE
flag, before handling "ap_isolate" value from the userspace. This addresses
case where driver unnecessarily checks the value of ap_isolate, even if the
userspace did not pass this param in the SET_BSS request.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index dc2383faddd1..276d08048cbb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5933,6 +5933,52 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
 	return brcmf_set_pmk(ifp, NULL, 0);
 }
 
+static int brcmf_set_ap_bssparam_isolate(struct brcmf_if *ifp, int param_ap_isolate)
+{
+	int ret = 0, cur_ap_isolate = 0;
+
+	/* In cfg80211, for AP mode, the "param_ap_isolate" value represents
+	 *  0 = allow low-level bridging of frames between associated stations
+	 *  1 = restrict low-level bridging of frames to isolate associated stations
+	 */
+	ret = brcmf_fil_iovar_int_get(ifp, "ap_isolate", &cur_ap_isolate);
+	if (ret < 0)
+		return ret;
+
+	if (cur_ap_isolate != param_ap_isolate) {
+		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", param_ap_isolate);
+		if (ret < 0) {
+			brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
+				     struct bss_parameters *params)
+{
+	struct brcmf_if *ifp = netdev_priv(dev);
+	int ret = 0;
+
+	/* Reject the operation if any of the AP BSS params that got changed are not
+	 * supported by the driver for explicit configuration.
+	 */
+	if (params->changed &
+	    ~(CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE))
+		return -EOPNOTSUPP;
+
+	if (params->changed &
+	    CFG80211_BSS_PARAM_CHANGED_AP_ISOLATE) {
+		ret = brcmf_set_ap_bssparam_isolate(ifp, params->ap_isolate);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.add_virtual_intf = brcmf_cfg80211_add_iface,
 	.del_virtual_intf = brcmf_cfg80211_del_iface,
@@ -5980,6 +6026,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.update_connect_params = brcmf_cfg80211_update_conn_params,
 	.set_pmk = brcmf_cfg80211_set_pmk,
 	.del_pmk = brcmf_cfg80211_del_pmk,
+	.change_bss = brcmf_cfg80211_change_bss,
 };
 
 struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
-- 
2.47.0


