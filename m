Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A415B0596
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 15:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIGNpz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 09:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIGNpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 09:45:39 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526BC4A13E
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 06:44:53 -0700 (PDT)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1662558291; bh=SrqEawVr+5FHPte1CSGRG/4tZaGnPQ4NzbFMV1G+404=;
        h=From:To:Cc:Subject:Date:From;
        b=A+UQrt+y3EDZUeQ48CHRs1icKpz2DBKA/fejOw3BrdsE3WUxSK6Hlu3fdLt70Awvj
         S6kGeBmNqcqIr56wd532ticDRZn2XXIjkYJoGcqOybnDIKfZ1c/UiWIt7jgf6dgMp8
         uDPjDmLwTAAwJ9wB5Opq3uA6zXiI88mJd01C8jwrbRT+r+By3VyFjgwQ8/EMdprDXE
         5Fvu4naUlzQyTr5onijH1U1MQTAlwy5ZCcXFCMwVaD5pEvCMDRLA5Tw/KGnFOnylgK
         H++OmOobA9BolV8SgAOb8yZOneNULAFpP+K4zhb4db72zaeZ55VArd25AVZNJwBNpN
         hhktSdA61LBZw==
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Cc:     linux-wireless@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] iwlwifi: Mark IWLMEI as broken
Date:   Wed,  7 Sep 2022 15:44:50 +0200
Message-Id: <20220907134450.1183045-1-toke@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The iwlmei driver breaks iwlwifi when returning from suspend; the bug
report[0] has been open for four months now, and now fix seems to be
forthcoming. Since just disabling the iwlmei driver works as a workaround,
let's mark the config option as broken until it can be fixed properly.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=215937

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index a647a406b87b..b20409f8c13a 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -140,6 +140,7 @@ config IWLMEI
 	depends on INTEL_MEI
 	depends on PM
 	depends on CFG80211
+	depends on BROKEN
 	help
 	  Enables the iwlmei kernel module.
 
-- 
2.37.2

