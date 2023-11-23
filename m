Return-Path: <linux-wireless+bounces-10-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC257F68FF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CA428193B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCB93FE43;
	Thu, 23 Nov 2023 22:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gFbNtIOw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1707D67
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Pw7ikaLund/3cz5pLyerBidDni0/DRZLHwuJ+uXbv/o=;
	t=1700778476; x=1701988076; b=gFbNtIOwmr7hLPft+3xdhIzCnPQk3opY4vJofR5P94OowpV
	2UQv8vSZhLblO07nZXQK2U8R4u7i0aZIYP2BbDYryNA2NExOgczkodD/dlKSDTT1wqxf+czxYgJJz
	TOKayB1Z53fgQLJBZXNq2xra94L4DNYAgBWvnUTgE3IcDvxCSwhEfxmPaApUrVKI+UZLkIbYyCcaw
	cawIzDct3z/7g+7zcCm0ddof+7t91ddFIVXSnjv5fBYIqjmIL5kXS7Mb3dOTeGuS7lUwgOLJUzM+O
	9wWZwUZhYNa/ABS6rsbaRMqRMWGjhlv9h2JsdkKIId0Ux/epo/3Tv4xK5LGOoXxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IAs-00000001Y53-0foW;
	Thu, 23 Nov 2023 23:27:54 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH v2 03/13] wifi: mac80211: remove extra element parsing
Date: Thu, 23 Nov 2023 23:14:40 +0100
Message-ID: <20231123231436.507e99367629.I112b1ef00904c4183ac7644800f8daa8a4449875@changeid>
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

We already parse all the BSS elements into elems, there's
really no need to separately find EHT/ML again. Remove the
extra code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2cdafabe46e0..d3b32fecc91d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4940,32 +4940,12 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			(IEEE80211_CONN_DISABLE_HE |
 			 IEEE80211_CONN_DISABLE_EHT)) &&
 	    he_oper) {
-		const struct cfg80211_bss_ies *cbss_ies;
-		const struct element *eht_ml_elem;
-		const u8 *eht_oper_ie;
-
-		cbss_ies = rcu_dereference(cbss->ies);
-		eht_oper_ie = cfg80211_find_ext_ie(WLAN_EID_EXT_EHT_OPERATION,
-						   cbss_ies->data, cbss_ies->len);
-		if (eht_oper_ie && eht_oper_ie[1] >=
-		    1 + sizeof(struct ieee80211_eht_operation))
-			eht_oper = (void *)(eht_oper_ie + 3);
-		else
-			eht_oper = NULL;
+		eht_oper = elems->eht_operation;
 
 		if (!ieee80211_verify_sta_eht_mcs_support(sdata, sband, eht_oper))
 			*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 
-		eht_ml_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
-						     cbss_ies->data, cbss_ies->len);
-
-		/* data + 1 / datalen - 1 since it's an extended element */
-		if (!(*conn_flags & IEEE80211_CONN_DISABLE_EHT) &&
-		    eht_ml_elem &&
-		    ieee80211_mle_type_ok(eht_ml_elem->data + 1,
-					  IEEE80211_ML_CONTROL_TYPE_BASIC,
-					  eht_ml_elem->datalen - 1))
-			supports_mlo = true;
+		supports_mlo = elems->ml_basic;
 	}
 
 	/* Allow VHT if at least one channel on the sband supports 80 MHz */
-- 
2.42.0


