Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C4F78AA31
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 12:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjH1KUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjH1KTn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 06:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562A7122;
        Mon, 28 Aug 2023 03:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F235863829;
        Mon, 28 Aug 2023 10:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5FAC433C7;
        Mon, 28 Aug 2023 10:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217944;
        bh=EJ+2FRpR64R9HkOHWigcvnITZ7Gh2+h4XI0tdaeTp7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0f24V8eHxBu/CUCHrpDw+I0tVx7Nx2Dk2R39xGzDdwAPt17w82A6tnCpAzn35U7X7
         rLaoWFoBELRwhQaJYccj6gBAfOz8Z86gwcnvLVYtYO620mkRESmdPKNJFA+zylPtjk
         svITJUDb1v/cFrZFolK+M5G6tcGNAYOFM82aqnt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 010/129] wifi: iwlwifi: mvm: add dependency for PTP clock
Date:   Mon, 28 Aug 2023 12:11:29 +0200
Message-ID: <20230828101157.719066172@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 609a1bcd7bebac90a1b443e9fed47fd48dac5799 ]

When the code to use the PTP HW clock was added, it didn't update
the Kconfig entry for the PTP dependency, leading to build errors,
so update the Kconfig entry to depend on PTP_1588_CLOCK_OPTIONAL.

aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_init':
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294: undefined reference to `ptp_clock_register'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294:(.text+0xce8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_register'
aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301: undefined reference to `ptp_clock_index'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301:(.text+0xd18): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_remove':
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315: undefined reference to `ptp_clock_index'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315:(.text+0xe80): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319: undefined reference to `ptp_clock_unregister'
drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319:(.text+0xeac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_unregister'

Fixes: 1595ecce1cf3 ("wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202308110447.4QSJHmFH-lkp@intel.com/
Cc: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Acked-by: Richard Cochran <richardcochran@gmail.com>
Acked-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230812052947.22913-1-rdunlap@infradead.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index b20409f8c13ab..20971304fdef4 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -66,6 +66,7 @@ config IWLMVM
 	tristate "Intel Wireless WiFi MVM Firmware support"
 	select WANT_DEV_COREDUMP
 	depends on MAC80211
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  This is the driver that supports the MVM firmware. The list
 	  of the devices that use this firmware is available here:
-- 
2.40.1



