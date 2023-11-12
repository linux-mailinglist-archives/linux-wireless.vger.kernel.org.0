Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86557E9139
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjKLOgm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 09:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjKLOgk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 09:36:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F0F2D5B
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699799797; x=1731335797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dN+HYs9Jz972l1dYiObo3VtC0jUjqPql+zQFKw3tAJM=;
  b=LbmsL8E8l+Aq6ts4zZGJoQcy8NnCkDu0hjNx32zGuQu2hSt4uq6vSh0j
   WLnt+Xhvw6xR0axGl0J7BmBSNTClV7D7sQiXRdwS86sSZMpayF4XMuU3/
   3L4PPETUzwqfvLJP5grG0HIofsdytCbAJG1i6cS9x8kD3uJAXjf0uVoXs
   0nQDNu8qAZnT4jVy2kWxqCyuAJzpIbg4+RbT0ufgBs7RdRsNkdkNuNxan
   a1jm3O6OxYMTDAyMnRhk+gQj6yvmend8biVJERXim9g0hQJIa0XZqbnNY
   Qn7D+vt9yMYPRxRZwW8CKvKODhae+iB2UwjUjdsFerMXsXjuhKCpFyBRd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="421430979"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="421430979"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 06:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="887733051"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="887733051"
Received: from miryamfx-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.lan) ([10.254.153.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 06:36:31 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        pagadala.yesu.anjaneyulu@intel.com, gregory.greenman@intel.com,
        Linux Regressions <regressions@lists.linux.dev>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        =?UTF-8?q?Nikl=C4=81vs=20Ko=C4=BCes=C5=86ikovs?= 
        <pinkflames.linux@gmail.com>,
        Damian Tometzki <damian@riscv-rocks.de>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v4] wifi: iwlwifi: fix system commands group ordering
Date:   Sun, 12 Nov 2023 16:36:20 +0200
Message-ID: <20231112143620.36619-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
References: <20231112095943.19353-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The commands should be sorted inside the group definition.
Fix the ordering so we won't get following warning:
WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg))

Link: https://lore.kernel.org/regressions/2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.com/
Link: https://lore.kernel.org/linux-wireless/CAHk-=wix6kqQ5vHZXjOPpZBfM7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com/
Fixes: b6e3d1ba4fcf ("wifi: iwlwifi: mvm: implement new firmware API for statistics")
Tested-by: Niklāvs Koļesņikovs <pinkflames.linux@gmail.com>
Tested-by: Damian Tometzki <damian@riscv-rocks.de>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
v3: remove ChangeId
v4: add the required tested-by and link tags
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index fef86a8b4163..1627b2f819db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -550,9 +550,9 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
 	HCMD_NAME(RFI_CONFIG_CMD),
 	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
 	HCMD_NAME(SYSTEM_FEATURES_CONTROL_CMD),
-	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
 	HCMD_NAME(SYSTEM_STATISTICS_CMD),
 	HCMD_NAME(SYSTEM_STATISTICS_END_NOTIF),
+	HCMD_NAME(RFI_DEACTIVATE_NOTIF),
 };
 
 /* Please keep this array *SORTED* by hex value.
-- 
2.41.0

