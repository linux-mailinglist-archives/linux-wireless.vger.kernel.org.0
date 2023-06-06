Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9272448D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 15:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbjFFNgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 09:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbjFFNgR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 09:36:17 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32262E7D
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 06:36:16 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3A68FC40064
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 13:36:13 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.35.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 720EF13C2B0
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 06:36:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 720EF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1686058572;
        bh=xXOBm3hN5zWTUJDyMBsRO4pzPzydCp3UA+ujNqIkQZQ=;
        h=To:From:Subject:Date:From;
        b=La+Hd3QXk6k50Zw7bVyIdyQ5cFOUecJ6HzxrAVVsjJsZcv94J10MZFgXErF+dnome
         I0iwpid5E5YEoxctfYwwk+VaPtbh1NcQV0e5ETVxY1AkouoIyzXXUftdV5WIDbDEd2
         a+7C12POhyRqYjwScp6YoZGedmeU3fogarbYv3i8=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlwifi: tx-fail reported with zero retry count.
Organization: Candela Technologies
Message-ID: <6b920700-e9a2-bbeb-98ce-7a2d09e76975@candelatech.com>
Date:   Tue, 6 Jun 2023 06:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1686058574-NTfbrG0krV2p
X-MDID-O: us5;ut7;1686058574;NTfbrG0krV2p;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It seems that when tx fails (due to TX_STATUS_FAIL_LONG_LIMIT in this case), the
retry-count is sometimes reported as zero.  I would expect that it actually must have retried
many times (15 it seems?).  At least for fail-long-limit failures, is there a known constant amount of
times the firmware retransmits the frame before giving up?  If so, I can just hack that
value into the retry counter in this case.

Debug patch:

[greearb@ben-dt5 iwlwifi]$ git diff
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1cddc65dd51e..6544dabb092b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1929,8 +1929,14 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
                 mvm->ethtool_stats.tx_mpdu_attempts += info->status.rates[0].count;
                 mvm->ethtool_stats.tx_mpdu_retry += tx_resp->failure_frame;
                 if (cb.flags & IWL_TX_CB_TXO_USED) {
+                       u32 idx = status & TX_STATUS_MSK;
+
                         mvm->ethtool_stats.txo_tx_mpdu_attempts += info->status.rates[0].count;
                         mvm->ethtool_stats.txo_tx_mpdu_retry += tx_resp->failure_frame;
+                       if (idx != TX_STATUS_SUCCESS) {
+                               pr_info("txo tx status failed: %d  tx_resp->failure_frame: %d\n",
+                                       idx, tx_resp->failure_frame);
+                       }
                 }

                 iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw,


 From dmesg:

Jun 06 06:29:40 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
Jun 06 06:29:43 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
Jun 06 06:29:48 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
Jun 06 06:29:49 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
Jun 06 06:29:52 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
Jun 06 06:29:57 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 0
Jun 06 06:29:57 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 0
Jun 06 06:29:58 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 0
Jun 06 06:30:01 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
Jun 06 06:30:02 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
Jun 06 06:30:03 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
....


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
