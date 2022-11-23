Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04325636BEC
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiKWVEf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 16:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiKWVE1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 16:04:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4C7942C3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 13:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669237465; x=1700773465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UeNpFjsiwxMxVHoRyyJ0/446Wcdz6wPlsmRbLv5yre0=;
  b=DLi/RfxgkwYmYngeSpq2wBYAnJkXXOZWZYYCa55yAyUrdAjfr/pKAfxw
   7Q8X4VU5AmJ+xy2EYCpl6iFp2JOHJz4zC/31tqtlG1+SFXCDn0ve0dpqq
   mrHesOJcY6ROWj8adaZm8pjwWX3cUzGZGUoaXZcLSrMVDWaVzgX4n2Lk+
   zjfLUFqXxOFZ+JVrmGu9UNg059qUm8/ozNC1sgTjhRfzxI5bkMQdTIyN/
   eYUysDQg2IsTjUXWrNVtajfL+m7kQ5z5F9vK2z4FB+DRxwfS6o/26Zbhm
   iAL8Amtp44EARH5B1TFg1+XsllAkAdOgDz9rO3ycyb8gjj8KSmrkxoKnQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="293864731"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="293864731"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:04:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="619761793"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="619761793"
Received: from stopaz-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.194.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 13:04:23 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH 5/5] wifi: iwlwifi: mei: fix parameter passing to iwl_mei_alive_notif()
Date:   Wed, 23 Nov 2022 23:02:09 +0200
Message-Id: <20221123225313.83c2251055c1.Ia028357e7ab36dfc2abf85106a5926ee7893a408@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221123210209.2941641-1-gregory.greenman@intel.com>
References: <20221123210209.2941641-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Pass true explicitly to iwl_mei_alive_notif() when we can be
sure that Alive notification was received. The issue was discovered
by Smatch.

Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/Y3uYUEFnMiBY2ABQ@kili/
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 2f4c9e653e99..0a41cd0ab243 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -418,7 +418,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 		return -EIO;
 	}
 
-	iwl_mei_alive_notif(!ret);
+	/* if reached this point, Alive notification was received */
+	iwl_mei_alive_notif(true);
 
 	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait);
 	if (ret) {
-- 
2.35.3

