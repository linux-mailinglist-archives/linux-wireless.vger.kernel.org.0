Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24A1461697
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345372AbhK2NiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:23 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49790 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1377721AbhK2NgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:17 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgm9-0012xo-Lk; Mon, 29 Nov 2021 15:32:58 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:37 +0200
Message-Id: <iwlwifi.20211129152938.690c735dc565.I3a12ea2785ff7fd58b69cd462ed441d75174a163@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH 05/16] [BUGFIX] cfg80211: check fixed size before ieee80211_he_oper_size()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We need to check the fixed portion is present before calling
ieee80211_he_oper_size() so that we don't access fields in
the static portion that don't exist.

type=bugfix
ticket=none
fixes=I130f678e4aa390973ab39d838bbfe7b2d54bff8e

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-on: https://git-amr-3.devtools.intel.com/gerrit/332428
automatic-review: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Tested-by: ec ger unix iil jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
---
 net/wireless/scan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 3fd0757ead29..fddcb60b5b60 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1802,14 +1802,16 @@ int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 
 	if (channel->band == NL80211_BAND_6GHZ) {
 		const struct element *elem;
+		struct ieee80211_he_operation *he_oper;
 
 		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie,
 					      ielen);
-		if (elem && elem->datalen >= ieee80211_he_oper_size(&elem->data[1])) {
-			struct ieee80211_he_operation *he_oper =
-				(void *)(&elem->data[1]);
+		if (elem && elem->datalen >= sizeof(*he_oper) &&
+		    elem->datalen >= ieee80211_he_oper_size(&elem->data[1])) {
 			const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
 
+			he_oper = (void *)&elem->data[1];
+
 			he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
 			if (!he_6ghz_oper)
 				return channel;
-- 
2.33.1

