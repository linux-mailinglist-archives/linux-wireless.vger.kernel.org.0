Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5D14B1A8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2020 10:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgA1JUP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jan 2020 04:20:15 -0500
Received: from mr85p00im-ztdg06011801.me.com ([17.58.23.199]:47625 "EHLO
        mr85p00im-ztdg06011801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgA1JUP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jan 2020 04:20:15 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jan 2020 04:20:15 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1580202648; bh=V0acQkFtVBEhicZNBgiCSt96A7INB6wqYehf/lJnTmw=;
        h=From:To:Subject:Date:Message-Id;
        b=g905ABIiULL1SM7JbILnK9mN3owG+upmmeXjOutodiEdDTUfdIWROUJwQ+6VUAhL8
         cDJdWIU69K26hjiuIYpBVerlirwidLpwTxc/hJ3ACGOycIwyFl18MF1+3FGTohYG7u
         zgC+JMHBl4elVFBT3a85ytKY0hBjsS1oQ30pUM31Hk2toHPoy0hEzfdvm4I9WnRrgZ
         I0q5faPYEsiEsy5FUywLBCQiyMwNRWuZPgE+WvZDoH8mJKGcfc0YJWLLUNXE9FQACT
         a33KnW40F3W0mrfWSFxVF4qzhNKVrhVTpO+B8H8bYmDGai3wS2napZ8Wj2nvRuxvBO
         6o7sFX18DXPJA==
Received: from stitch.danm.net (c-73-98-236-45.hsd1.ut.comcast.net [73.98.236.45])
        by mr85p00im-ztdg06011801.me.com (Postfix) with ESMTPSA id 529DBC092E;
        Tue, 28 Jan 2020 09:10:48 +0000 (UTC)
From:   Dan Moulding <dmoulding@me.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        luciano.coelho@intel.com, linuxwifi@intel.com,
        Dan Moulding <dmoulding@me.com>
Subject: [PATCH 5.5] iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices
Date:   Tue, 28 Jan 2020 02:10:22 -0700
Message-Id: <20200128091022.9202-1-dmoulding@me.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001280076
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The logic for checking required NVM sections was recently fixed in
commit b3f20e098293 ("iwlwifi: mvm: Do not require PHY_SKU NVM section
for 3168 devices"). However, with that fixed the else is now taken for
3168 devices and within the else clause there is a mandatory check for
the PHY_SKU section. This causes the parsing to fail for 3168 devices.

The PHY_SKU section is really only mandatory for the IWL_NVM_EXT
layout (the phy_sku parameter of iwl_parse_nvm_data is only used when
the NVM type is IWL_NVM_EXT). So this changes the PHY_SKU section
check so that it's only mandatory for IWL_NVM_EXT.

Fixes: b3f20e098293 ("iwlwifi: mvm: Do not require PHY_SKU NVM section for 3168 devices")
Signed-off-by: Dan Moulding <dmoulding@me.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 46128a2a9c6e..e98ce380c7b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -308,7 +308,8 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 		}
 
 		/* PHY_SKU section is mandatory in B0 */
-		if (!mvm->nvm_sections[NVM_SECTION_TYPE_PHY_SKU].data) {
+		if (mvm->trans->cfg->nvm_type == IWL_NVM_EXT &&
+		    !mvm->nvm_sections[NVM_SECTION_TYPE_PHY_SKU].data) {
 			IWL_ERR(mvm,
 				"Can't parse phy_sku in B0, empty sections\n");
 			return NULL;
-- 
2.24.1

