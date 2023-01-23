Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04C67765B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 09:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjAWIhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 03:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjAWIhZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 03:37:25 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F821CAFC
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 00:37:24 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id j16-20020a056830271000b0067202045ee9so6903992otu.7
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 00:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0mK2gsoCtl4YUCKnSrL6Jh9HbWOZuwz1LQAYPc4ESbs=;
        b=fcay3T2ZC35q3/2qPRcPsZj60U+fgn4jFnwaFxjdPARDTeli/xDUVuNV3Jskgw1G0D
         EqI31AlHBn0HgYVQTt/XV9U2MYA653ZsQOEawmJkBT+5KE1920aornQGmmc7Zd98VAXX
         9j9j7HMdleq+Lu0PqHuI2qD1YMz/F8mfgShiUAn1TgpD9LgrVdD5uo7HmCl7rf3Ushfy
         3RPCVV1RieRPOfwZep3wq7H9LlFTc8IDiBcHnIsKGwDleW5fhy5/LmW0xhtzPjaehsfI
         5taSzF0MAzPbQyIDryI43TxBEAeCfs4J+CraH6VLZZAfJd1lKEu4hIjHLE8FZnE8WlgV
         6QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mK2gsoCtl4YUCKnSrL6Jh9HbWOZuwz1LQAYPc4ESbs=;
        b=pINaidnKLPGwYSkWBq6UYBMxvkKR29LgQnWUPCMKdUhzM/GjKG5xOWKvUhvF/DRiTi
         DCb2rcpZpx1Eyg9hIYtr8+xsv+1hX1pkATCjUNFZgYjmjeiYBtTMHjoW5FFLetcok56J
         X/ArNYRp2QLSxVMs4xsv/0VkBqWTumCuvHJBdP4lo+N7GLy+mCrtbSu7rfvtBqv8YINU
         A8cyrA/Bpd86xdXmpB/ZUwfN/tVTq+eN5xtRSJ/g++ZHC2BupWhlOli85FCLYbImzgIM
         WvTi5stUBhnZ909CCDTAY7zrT+XssYkmPge52JaWKXs8sfpgTqTn7/nJQTWqczJspmNX
         4hyw==
X-Gm-Message-State: AFqh2kpSTw1ju8gjHM/rj0SGT+ZbgEEIYFwdOs6Zn+spNowW79q8+JPj
        3n5+NaGgiZtbeTaHTf38JGaJAh/NjaTnot/GLSOsoSZa2gCvkQ==
X-Google-Smtp-Source: AMrXdXvQd9Y+c0i1b4jIsp8LDoUJmpeZSOddgJBlQ9C2kLF0+1Kd6j0Sy0jB662A/061eWiZYLSqtO0OyZcAmMSjW8M=
X-Received: by 2002:a9d:68c9:0:b0:684:c4cc:6a38 with SMTP id
 i9-20020a9d68c9000000b00684c4cc6a38mr1650275oto.306.1674463043099; Mon, 23
 Jan 2023 00:37:23 -0800 (PST)
MIME-Version: 1.0
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 23 Jan 2023 14:07:10 +0530
Message-ID: <CABPxzY+_Mjercvvh5XHmtHdNCKXDupVbL4PKXgzZPiUesRsRMA@mail.gmail.com>
Subject: iwlwifi: Monitor mode broken with 6.1.0
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Emmanuel Grumbach <egrumbach@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am using the ath.git (ea726a8d305a : was testing external Atheros
cards) + linux-firmware (bb2d42d) and the monitor mode stopped working
with iwlwifi. There is a warning from UBSAN: "UBSAN:
shift-out-of-bounds in
drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c:657:22".

The root cause was this c6ce1c74ef292 which defaults the assignment to
0xFFFF and then that was being used for the shift.

I have tried to fix the warning with the below patch (just for an
experiment, not a proper one), the warning is gone, but no frames are
seen in Wireshark.

Below is the version information, any help is appreciated, monitor
mode is important for me.

lspci: Network controller: Intel Corporation Wi-Fi 6 AX201 (rev 20)

[  +0.003790] iwlwifi 0000:00:14.3: api flags index 2 larger than
supported by driver
[  +0.000046] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version:
89.3.35.37
[  +0.001519] iwlwifi 0000:00:14.3: loaded firmware version
72.daa05125.0 QuZ-a0-hr-b0-72.ucode op_mode iwlmvm
[  +0.034887] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6 AX201
160MHz, REV=0x351
[  +0.000083] thermal thermal_zone7: failed to read out thermal zone (-61)
[  +0.122144] iwlwifi 0000:00:14.3: Detected RF HR B3, rfid=0x10a100
[  +0.065701] iwlwifi 0000:00:14.3: base HW address: 4c:79:6e:90:94:71
[  +0.019826] iwlwifi 0000:00:14.3 wlp0s20f3: renamed from wlan0
[ +14.210987] device mon0 entered promiscuous mode
[Jan24 18:20] device mon0 left promiscuous mode

---
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 83abfe996138..591f9fdd0ec4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -654,9 +654,13 @@ static int iwl_mvm_mac_ctxt_cmd_listener(struct
iwl_mvm *mvm,
                                         u32 action)
 {
        struct iwl_mac_ctx_cmd cmd = {};
-       u32 tfd_queue_msk = BIT(mvm->snif_queue);
+       u32 tfd_queue_msk = 0;
        int ret;

+       if (mvm->snif_queue != IWL_MVM_INVALID_QUEUE) {
+               tfd_queue_msk = BIT(mvm->snif_queue);
+       }
+
        WARN_ON(vif->type != NL80211_IFTYPE_MONITOR);

        iwl_mvm_mac_ctxt_cmd_common(mvm, vif, &cmd, NULL, action);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 515dd3e0730d..784a7f72b819 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2084,6 +2084,7 @@ static int iwl_mvm_add_int_sta_with_queue(struct
iwl_mvm *mvm, int macidx,
                }

                *queue = txq;
+               sta->tfd_queue_msk = BIT(*queue);
        }

        return 0;
@@ -2092,11 +2093,15 @@ static int
iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
 int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
 {
        int ret;
+       u32 tfd_queue_msk = 0;

        lockdep_assert_held(&mvm->mutex);
+       if (mvm->aux_queue != IWL_MVM_INVALID_QUEUE) {
+               tfd_queue_msk = BIT(mvm->aux_queue);
+       }

        /* Allocate aux station and assign to it the aux queue */
-       ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, BIT(mvm->aux_queue),
+       ret = iwl_mvm_allocate_int_sta(mvm, &mvm->aux_sta, tfd_queue_msk,
                                       NL80211_IFTYPE_UNSPECIFIED,
                                       IWL_STA_AUX_ACTIVITY);
        if (ret)
