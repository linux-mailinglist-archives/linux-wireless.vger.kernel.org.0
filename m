Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5C75E4D9
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jul 2023 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGWUcp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jul 2023 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWUco (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jul 2023 16:32:44 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jul 2023 13:32:43 PDT
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97D751B8
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jul 2023 13:32:43 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id NfdYqBzmMQztPNfdZqOQPG; Sun, 23 Jul 2023 22:25:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690143906;
        bh=fiLQ1tlpJj1LRpew92AztLTpxiVgw4Le/tOPPNtRsXs=;
        h=From:To:Cc:Subject:Date;
        b=r7cvxUQ3Y3BP1WuBmUAe9nDSZNt/2yt0WBoq27TFMwsk1hYI94yjHvxVWlsxK+xGr
         EBxucGGAT6oh9Eu/bkgvIbRgErkMx/6H1gQAJ/E+fq+L3fwSUYIxap5i1g2LSg0NVd
         gXFgGExfH/LcPokz9R30TDg26K1bdeeEDWDtU8auwXAQ4iu3w68jkcco4ZpwmPerbr
         pmy0kwj3AzXqmgERYN60g4QLRZ/8mt8UzcpbyUgO/MB0MIOQ7FFAPvE4KCwC7gsVzI
         2hcVStpXgPQMJRmCwIID7v9ii/m2c2mh6zP2fTQCl6njBwcP9dG6fHnoIHVLs12ZvX
         aAmqpcfBsLxOw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 23 Jul 2023 22:25:06 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
Subject: [PATCH wireless] wifi: iwlwifi: mvm: Fix a memory corruption issue
Date:   Sun, 23 Jul 2023 22:24:59 +0200
Message-Id: <23f0ec986ef1529055f4f93dcb3940a6cf8d9a94.1690143750.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A few lines above, space is kzalloc()'ed for:
	sizeof(struct iwl_nvm_data) +
	sizeof(struct ieee80211_channel) +
	sizeof(struct ieee80211_rate)

'mvm->nvm_data' is a 'struct iwl_nvm_data', so it is fine.

At the end of this structure, there is the 'channels' flex array.
Each element is of type 'struct ieee80211_channel'.
So only 1 element is allocated in this array.

When doing:
  mvm->nvm_data->bands[0].channels = mvm->nvm_data->channels;
We point at the first element of the 'channels' flex array.
So this is fine.

However, when doing:
  mvm->nvm_data->bands[0].bitrates =
			(void *)((u8 *)mvm->nvm_data->channels + 1);
because of the "(u8 *)" cast, we add only 1 to the address of the beginning
of the flex array.

It is likely that we want point at the 'struct ieee80211_rate' allocated
just after.

Remove the spurious casting so that the pointer arithmetic works as
expected.

Fixes: 8ca151b568b6 ("iwlwifi: add the MVM driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've checked in the .s files, and :

Before
======
# drivers/net/wireless/intel/iwlwifi/mvm/fw.c:801: 		mvm->nvm_data->bands[0].channels = mvm->nvm_data->channels;
	leaq	1448(%r13), %rax	#, tmp248

# drivers/net/wireless/intel/iwlwifi/mvm/fw.c:805: 			(void *)((u8 *)mvm->nvm_data->channels + 1);
	leaq	1449(%r13), %rax	#, tmp252


After:
=====
# drivers/net/wireless/intel/iwlwifi/mvm/fw.c:801: 		mvm->nvm_data->bands[0].channels = mvm->nvm_data->channels;
	leaq	1448(%r13), %rax	#, tmp248

# drivers/net/wireless/intel/iwlwifi/mvm/fw.c:805: 			(void *)(mvm->nvm_data->channels + 1);
	leaq	1512(%r13), %rax	#, tmp252

And on my system sizeof(struct ieee80211_channel) = 64

/!\ This patch is only speculative and untested. /!\

It is strange that a memory corruption issue has been un-noticed for more
than 10 years.

So review with care.
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1f5db65a088d..1d5ee4330f29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -802,7 +802,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
 		mvm->nvm_data->bands[0].n_channels = 1;
 		mvm->nvm_data->bands[0].n_bitrates = 1;
 		mvm->nvm_data->bands[0].bitrates =
-			(void *)((u8 *)mvm->nvm_data->channels + 1);
+			(void *)(mvm->nvm_data->channels + 1);
 		mvm->nvm_data->bands[0].bitrates->hw_value = 10;
 	}
 
-- 
2.34.1

