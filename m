Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD9B1E64C9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391380AbgE1Oy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391230AbgE1Oy0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:54:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B0AC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:54:25 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrc-004vYI-5y; Thu, 28 May 2020 16:50:32 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 22/24] mac80211: Consider 6 GHz band when handling power constraint
Date:   Thu, 28 May 2020 16:50:18 +0200
Message-Id: <20200528165011.d7b0436c8ffc.Id8ed3bb8000ba8738be5df05639415eb2e23c61a@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Treat it like the 5 GHz band.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9fe4ca42b7aa..5922464dc453 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1533,6 +1533,7 @@ ieee80211_find_80211h_pwr_constr(struct ieee80211_sub_if_data *sdata,
 		chan_increment = 1;
 		break;
 	case NL80211_BAND_5GHZ:
+	case NL80211_BAND_6GHZ:
 		chan_increment = 4;
 		break;
 	}
-- 
2.26.2

