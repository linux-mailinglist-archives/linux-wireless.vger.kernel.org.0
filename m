Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C924200DE
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Oct 2021 10:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhJCIjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Oct 2021 04:39:46 -0400
Received: from unicom146.biz-email.net ([210.51.26.146]:63995 "EHLO
        unicom146.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJCIjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Oct 2021 04:39:45 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Oct 2021 04:39:45 EDT
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((LNX1044)) with ASMTP (SSL) id XKJ00046;
        Sun, 03 Oct 2021 16:31:46 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2308.14; Sun, 3 Oct 2021 16:31:47 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <luciano.coelho@intel.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] iwlwifi: mvm: Use kmemdup() instead of kzalloc and memcpy
Date:   Sun, 3 Oct 2021 16:31:44 +0800
Message-ID: <20211003083144.217955-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   20211003163146c565c7ce0e91ad08bcd63cca1b366d29
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

fix memdup.cocci warning:
drivers/net/wireless/intel/iwlwifi/mvm/rfi.c:110:8-15: WARNING opportunity for kmemdup

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
index 44344216a1a9..1954b4cdb90b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rfi.c
@@ -107,12 +107,10 @@ struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm)
 	if (WARN_ON_ONCE(iwl_rx_packet_payload_len(cmd.resp_pkt) != resp_size))
 		return ERR_PTR(-EIO);
 
-	resp = kzalloc(resp_size, GFP_KERNEL);
+	resp = kmemdup(cmd.resp_pkt->data, resp_size, GFP_KERNEL);
 	if (!resp)
 		return ERR_PTR(-ENOMEM);
 
-	memcpy(resp, cmd.resp_pkt->data, resp_size);
-
 	iwl_free_resp(&cmd);
 	return resp;
 }
-- 
2.27.0

