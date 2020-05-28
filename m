Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9641E6B19
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406629AbgE1TfF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406628AbgE1Te5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:34:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A80C08C5D1
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:34:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIo-0054OL-FS; Thu, 28 May 2020 21:34:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 07/24] mac80211: add HE 6 GHz Band Capabilities into parse extension
Date:   Thu, 28 May 2020 21:34:30 +0200
Message-Id: <20200528213443.a13d7a0b85b0.Ia07584da4fc77aa77c4cc563248d2ce4234ffe5d@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajkumar Manoharan <rmanohar@codeaurora.org>

Handle 6 GHz band capability element parsing for association.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Link: https://lore.kernel.org/r/1589399105-25472-4-git-send-email-rmanohar@codeaurora.org
[some renaming to be in line with previous patches]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h | 1 +
 net/mac80211/util.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b7935f3d000d..dac016636d12 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1494,6 +1494,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_he_operation *he_operation;
 	const struct ieee80211_he_spr *he_spr;
 	const struct ieee80211_mu_edca_param_set *mu_edca_param_set;
+	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
 	const u8 *uora_element;
 	const u8 *mesh_id;
 	const u8 *peering;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 20436c86b9bf..5d2c5ae8aadb 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -936,6 +936,10 @@ static void ieee80211_parse_extension_element(u32 *crc,
 		    len >= ieee80211_he_spr_size(data))
 			elems->he_spr = data;
 		break;
+	case WLAN_EID_EXT_HE_6GHZ_CAPA:
+		if (len == sizeof(*elems->he_6ghz_capa))
+			elems->he_6ghz_capa = data;
+		break;
 	}
 }
 
-- 
2.26.2

