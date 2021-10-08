Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D994272EC
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhJHVRY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 17:17:24 -0400
Received: from phobos.denx.de ([85.214.62.61]:60206 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhJHVRY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 17:17:24 -0400
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AB799832E8;
        Fri,  8 Oct 2021 23:15:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633727726;
        bh=Ru6Asc7WL3umhKu8earbBiCrHfnXFhGEBWxbcruPTgY=;
        h=From:To:Cc:Subject:Date:From;
        b=rkmMbidpm1YU+1gLYcjMdrIYtT5BYeW+fIZifRulkmdCXiWP1MmH8JB17OSkMV3B4
         Gkq2AfraRqDImjWy+gcbuiF9J6Qr9woa1bQ49SHmOxzGW8kkvgo02R8tx1jSonv7km
         Bnq0oAP+VMfTSAPbSNrPsgFCaNObPSr+SUoqrFoCqbASHDemP+V6hcWSanKnRKFRvL
         i8kefo9Oz4QMLkUoI+8eJC48pc+CtnirxICGD/+DHU3r+FAfk7Vi6OWNkkgT5zbCml
         cJxdPXCr465fuYV3dpg+jIj/4LO0RqVXq/ni3zVuLHLnORAVkGkQI7SW7r/z1ctvTG
         ymMHIap92v4Zw==
From:   Marek Vasut <marex@denx.de>
To:     linux-wireless@vger.kernel.org
Cc:     ch@denx.de, Marek Vasut <marex@denx.de>,
        Dan Moulding <dmoulding@me.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH] [RFC] iwlwifi: mvm: Ignore NVM write status 0x1000
Date:   Fri,  8 Oct 2021 23:15:06 +0200
Message-Id: <20211008211506.226806-1-marex@denx.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When loading custom NVM file on Wireless-AC 9260 160MHz, REV=0x324
8086:2526 (rev 29) Subsystem: 8086:001c firmware version 46.6b541b68.0
9260-th-b0-jf-b0-46.ucode , the NVM_WRITE_OPCODE return status is 0x1000
for all sections. What does this mean is unknown, however clearing the
top 4 bits permits the NVM to be written and the card operates as it
should.

Hexdump of the iNVM file is below, the iNVM file overrides antenna
settings to only use AUX antenna and disables MIMO .
00000000  54 4c 50 2a 2a 4d 56 4e  2c 11 00 00 08 10 21 20
00000010  c0 00 00 02 03 03 02 11  2f 00 00 00 00 00 00 00
00000020  00 00 00 00

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dan Moulding <dmoulding@me.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Luca Coelho <luciano.coelho@intel.com>
To: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 60296a754af2..52921f7e735b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -116,7 +116,7 @@ static int iwl_nvm_write_chunk(struct iwl_mvm *mvm, u16 section,
 	pkt = cmd.resp_pkt;
 	/* Extract & check NVM write response */
 	nvm_resp = (void *)pkt->data;
-	if (le16_to_cpu(nvm_resp->status) != READ_NVM_CHUNK_SUCCEED) {
+	if ((le16_to_cpu(nvm_resp->status) & 0xfff) != READ_NVM_CHUNK_SUCCEED) {
 		IWL_ERR(mvm,
 			"NVM access write command failed for section %u (status = 0x%x)\n",
 			section, le16_to_cpu(nvm_resp->status));
-- 
2.33.0

