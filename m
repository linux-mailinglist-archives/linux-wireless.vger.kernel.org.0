Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5A579C81
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jul 2022 14:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiGSMkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jul 2022 08:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiGSMjs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jul 2022 08:39:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFB35C36D
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 05:16:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j1so16849582wrs.4
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwHEqLtmk8HL9Ww//S4odt+l7hi4xgTWmrkBY/CKPIs=;
        b=LpB8xZ3c3oJCofhYLr0Aci6sZg7GIE7XY84Jv5nKBLVuLZca/QxAIxl6401SHm3Z+B
         u+43Ax7Lm4VJamAWdpMgaRPqj/4jn7YvOqGGfhp1wCmjpmmQTqoLMsEEeNVluRVj+8Ze
         gU8THpjakerIOcg977kDnXi1NsRjg58lVshlqMqdyGGSyjKEvZmKQ5FzBbFQqtcn5+Bp
         wJ8WeIGJeQpCAJNdB0AMIy5MbgizzI8JwGjnikUm4ogQp7Qhj1V+npTL0jpbTGy99aj7
         HhSQJ1jqZX/EMD2Z7shmGiZnX0r2zNhMprwMJ7qo+tb8IH5u4gMqBX1Hw89FQaZPYD8X
         pKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RwHEqLtmk8HL9Ww//S4odt+l7hi4xgTWmrkBY/CKPIs=;
        b=2H5vo8jqBBUH326PdWF56TGhKLUHeg4m3aIyYGgPSrpk1nv7Zc3PnLXlxXsvRU5VnW
         NAXUhxxZYg6BKxA+9+qGOcp8DP991u4OMZShy4qz3buchNzJQZTM92ZSk5MqVDKrX8YK
         fQO4QuD0MMM2VzXtSCVBtrEl64cx6PwMJ8IG6w3qqjFBUAj4CAN3KAnzKQB/Shb4DyVi
         5dSfngZzu9D1EP0TjmUOXEu6F+P6x4mhVUUD+dJheWVQGdp9k5PNFArrYEbyeNQrgVKT
         o8y2wU27GGHqcmaQ4G2qn245OXMyDPyrD8Nkt5IfKF9XnFGzpFCmAnASEQ3rMwsMm49I
         9xrQ==
X-Gm-Message-State: AJIora9/MMT0dcoN2Vb/wX/wXhny8jQePYvjIsthR4Y/ec4efIDqvWW1
        YIQw6g6zUx5/qE01RrLio89pug==
X-Google-Smtp-Source: AGRyM1s3zxtxoKLdZ+vw6fUumL7goNqELxEg9O+CuOzIE91gPcd25P5HMdSfpIABSiU07nK5cJRSog==
X-Received: by 2002:a5d:6112:0:b0:21d:774e:df1c with SMTP id v18-20020a5d6112000000b0021d774edf1cmr25456862wrt.109.1658232962787;
        Tue, 19 Jul 2022 05:16:02 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c34d000b0039c5642e430sm14423812wmq.20.2022.07.19.05.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 05:16:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@kernel.org, loic.poulain@linaro.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH 0/4] wcn36xx: Add in debugfs export of firmware feature bits
Date:   Tue, 19 Jul 2022 13:15:56 +0100
Message-Id: <20220719121600.1847440-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series tidies up the code to get/set/clear discovered firmware feature
bits and adds a new debugfs entry to read the feature bits as strings.

cat /sys/kernel/debug/ieee80211/phy0/wcn36xx/firmware_feat_caps

wcn3680b:
FW Cap = MCC
FW Cap = P2P
FW Cap = DOT11AC
FW Cap = SLM_SESSIONIZATION
FW Cap = DOT11AC_OPMODE
FW Cap = SAP32STA
FW Cap = TDLS
FW Cap = P2P_GO_NOA_DECOUPLE_INIT_SCAN
FW Cap = WLANACTIVE_OFFLOAD
FW Cap = BEACON_OFFLOAD
FW Cap = SCAN_OFFLOAD
FW Cap = BCN_MISS_OFFLOAD
FW Cap = STA_POWERSAVE
FW Cap = STA_ADVANCED_PWRSAVE
FW Cap = BCN_FILTER
FW Cap = RTT
FW Cap = RATECTRL
FW Cap = WOW
FW Cap = WLAN_ROAM_SCAN_OFFLOAD
FW Cap = SPECULATIVE_PS_POLL
FW Cap = IBSS_HEARTBEAT_OFFLOAD
FW Cap = WLAN_SCAN_OFFLOAD
FW Cap = WLAN_PERIODIC_TX_PTRN
FW Cap = ADVANCE_TDLS
FW Cap = BATCH_SCAN
FW Cap = FW_IN_TX_PATH
FW Cap = EXTENDED_NSOFFLOAD_SLOT
FW Cap = CH_SWITCH_V1
FW Cap = HT40_OBSS_SCAN
FW Cap = UPDATE_CHANNEL_LIST
FW Cap = WLAN_MCADDR_FLT
FW Cap = WLAN_CH144
FW Cap = TDLS_SCAN_COEXISTENCE
FW Cap = LINK_LAYER_STATS_MEAS
FW Cap = MU_MIMO
FW Cap = EXTENDED_SCAN
FW Cap = DYNAMIC_WMM_PS
FW Cap = MAC_SPOOFED_SCAN
FW Cap = FW_STATS
FW Cap = WPS_PRBRSP_TMPL
FW Cap = BCN_IE_FLT_DELTA

wcn3620:
FW Cap = MCC
FW Cap = P2P
FW Cap = SLM_SESSIONIZATION
FW Cap = DOT11AC_OPMODE
FW Cap = SAP32STA
FW Cap = TDLS
FW Cap = P2P_GO_NOA_DECOUPLE_INIT_SCAN
FW Cap = WLANACTIVE_OFFLOAD
FW Cap = BEACON_OFFLOAD
FW Cap = SCAN_OFFLOAD
FW Cap = BCN_MISS_OFFLOAD
FW Cap = STA_POWERSAVE
FW Cap = STA_ADVANCED_PWRSAVE
FW Cap = BCN_FILTER
FW Cap = RTT
FW Cap = RATECTRL
FW Cap = WOW
FW Cap = WLAN_ROAM_SCAN_OFFLOAD
FW Cap = SPECULATIVE_PS_POLL
FW Cap = IBSS_HEARTBEAT_OFFLOAD
FW Cap = WLAN_SCAN_OFFLOAD
FW Cap = WLAN_PERIODIC_TX_PTRN
FW Cap = ADVANCE_TDLS
FW Cap = BATCH_SCAN
FW Cap = FW_IN_TX_PATH
FW Cap = EXTENDED_NSOFFLOAD_SLOT
FW Cap = CH_SWITCH_V1
FW Cap = HT40_OBSS_SCAN
FW Cap = UPDATE_CHANNEL_LIST
FW Cap = WLAN_MCADDR_FLT
FW Cap = WLAN_CH144
FW Cap = TDLS_SCAN_COEXISTENCE
FW Cap = LINK_LAYER_STATS_MEAS
FW Cap = EXTENDED_SCAN
FW Cap = DYNAMIC_WMM_PS
FW Cap = MAC_SPOOFED_SCAN
FW Cap = FW_STATS
FW Cap = WPS_PRBRSP_TMPL
FW Cap = BCN_IE_FLT_DELTA

This is a handy way of debugging WiFi on different platforms without
necessarily having to recompile to see the debug printout on firmware boot.

Bryan O'Donoghue (4):
  wcn36xx: Rename clunky firmware feature bit enum
  wcn36xx: Move firmware feature bit storage to dedicated firmware.c
    file
  wcn36xx: Move capability bitmap to string translation function to
    firmware.c
  wcn36xx: Add debugfs entry to read firmware feature strings

 drivers/net/wireless/ath/wcn36xx/Makefile   |   3 +-
 drivers/net/wireless/ath/wcn36xx/debug.c    |  37 ++++++
 drivers/net/wireless/ath/wcn36xx/debug.h    |   1 +
 drivers/net/wireless/ath/wcn36xx/firmware.c | 125 ++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/firmware.h |  84 +++++++++++++
 drivers/net/wireless/ath/wcn36xx/hal.h      |  68 -----------
 drivers/net/wireless/ath/wcn36xx/main.c     |  86 ++------------
 drivers/net/wireless/ath/wcn36xx/smd.c      |  57 ++-------
 drivers/net/wireless/ath/wcn36xx/smd.h      |   3 -
 9 files changed, 264 insertions(+), 200 deletions(-)
 create mode 100644 drivers/net/wireless/ath/wcn36xx/firmware.c
 create mode 100644 drivers/net/wireless/ath/wcn36xx/firmware.h

-- 
2.36.1

