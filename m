Return-Path: <linux-wireless+bounces-14-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191017F6904
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EC9281A45
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020F34D11A;
	Thu, 23 Nov 2023 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aajMN46c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789CFD54
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tM/1/OsfFc09xKH60EPDi8LDQODPMlUF4rRrAn1WasU=;
	t=1700778479; x=1701988079; b=aajMN46cDVeXf/ZI/179mL+YdZ5nsOl8x9vVo2dJfpSxI6X
	ca5k+5dSU51x/NuJ9utNnwZcHxneiVWV4LGmrtXy6vfN2zsYQmNQu6wEDkdY95ji1ZxUsSkFbrYXv
	Twfn+Y2JuoX6cwDa5ndSdtUh4ecv0hZXbw64HFDFeibqC4nFLbSejpln5ToLDSUkJ1XrFWBxS0yA7
	0ckzk65WBXl3udpeY32LFWXokBU/UJvFe36PaMlHlKvkYAQBwEVtHevSVo3ZMPvWVEJk4AgJWI9QB
	Xx2GQjAW0Y4FHs6U58maIRLBST6ac1p19pq43JlDuoi+gVUrcSms6bDlobyARNEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAu-00000001Y53-1EsP;
	Thu, 23 Nov 2023 23:27:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 06/13] wifi: mac80211: disallow drivers with HT wider than HE
Date: Thu, 23 Nov 2023 23:14:43 +0100
Message-ID: <20231123231436.1617dc22842f.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123221436.143254-14-johannes@sipsolutions.net>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

To simplify the code in the next patch, disallow drivers
supporting 40 MHz in HT but not HE, since we'd otherwise
have to track local maximum bandwidth per mode there.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 033a5261ac3a..48e012ee1ae4 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1115,8 +1115,26 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
 
 		for_each_sband_iftype_data(sband, i, iftd) {
+			u8 he_40_mhz_cap;
+
 			supp_he = supp_he || iftd->he_cap.has_he;
 			supp_eht = supp_eht || iftd->eht_cap.has_eht;
+
+			if (sband->band == NL80211_BAND_2GHZ)
+				he_40_mhz_cap =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G;
+			else
+				he_40_mhz_cap =
+					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G;
+
+			/* currently no support for HE client where HT has 40 MHz but not HT */
+			if (iftd->he_cap.has_he &&
+			    iftd->types_mask & (BIT(NL80211_IFTYPE_STATION) |
+						BIT(NL80211_IFTYPE_P2P_CLIENT)) &&
+			    sband->ht_cap.ht_supported &&
+			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
+			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
+				return -EINVAL;
 		}
 
 		/* HT, VHT, HE require QoS, thus >= 4 queues */
-- 
2.42.0


