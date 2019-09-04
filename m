Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E30A8DE7
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 21:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfIDRu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 13:50:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:33471 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDRu5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 13:50:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 10:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="194814949"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 10:50:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 85455D0; Wed,  4 Sep 2019 20:50:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] brcmfmac: use %*ph to print small buffer
Date:   Wed,  4 Sep 2019 20:50:52 +0300
Message-Id: <20190904175052.77596-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c     | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5dcaaf65799e..dd6303f5f72e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -4222,10 +4222,8 @@ brcmf_parse_vndr_ies(const u8 *vndr_ie_buf, u32 vndr_ie_len,
 
 		vndr_ies->count++;
 
-		brcmf_dbg(TRACE, "** OUI %02x %02x %02x, type 0x%02x\n",
-			  parsed_info->vndrie.oui[0],
-			  parsed_info->vndrie.oui[1],
-			  parsed_info->vndrie.oui[2],
+		brcmf_dbg(TRACE, "** OUI %3ph, type 0x%02x\n",
+			  parsed_info->vndrie.oui,
 			  parsed_info->vndrie.oui_type);
 
 		if (vndr_ies->count >= VNDR_IE_PARSE_LIMIT)
@@ -4349,12 +4347,10 @@ s32 brcmf_vif_set_mgmt_ie(struct brcmf_cfg80211_vif *vif, s32 pktflag,
 		for (i = 0; i < old_vndr_ies.count; i++) {
 			vndrie_info = &old_vndr_ies.ie_info[i];
 
-			brcmf_dbg(TRACE, "DEL ID : %d, Len: %d , OUI:%02x:%02x:%02x\n",
+			brcmf_dbg(TRACE, "DEL ID : %d, Len: %d , OUI:%3ph\n",
 				  vndrie_info->vndrie.id,
 				  vndrie_info->vndrie.len,
-				  vndrie_info->vndrie.oui[0],
-				  vndrie_info->vndrie.oui[1],
-				  vndrie_info->vndrie.oui[2]);
+				  vndrie_info->vndrie.oui);
 
 			del_add_ie_buf_len = brcmf_vndr_ie(curr_ie_buf, pktflag,
 							   vndrie_info->ie_ptr,
@@ -4386,12 +4382,10 @@ s32 brcmf_vif_set_mgmt_ie(struct brcmf_cfg80211_vif *vif, s32 pktflag,
 			remained_buf_len -= (vndrie_info->ie_len +
 					     VNDR_IE_VSIE_OFFSET);
 
-			brcmf_dbg(TRACE, "ADDED ID : %d, Len: %d, OUI:%02x:%02x:%02x\n",
+			brcmf_dbg(TRACE, "ADDED ID : %d, Len: %d, OUI:%3ph\n",
 				  vndrie_info->vndrie.id,
 				  vndrie_info->vndrie.len,
-				  vndrie_info->vndrie.oui[0],
-				  vndrie_info->vndrie.oui[1],
-				  vndrie_info->vndrie.oui[2]);
+				  vndrie_info->vndrie.oui);
 
 			del_add_ie_buf_len = brcmf_vndr_ie(curr_ie_buf, pktflag,
 							   vndrie_info->ie_ptr,
-- 
2.23.0.rc1

