Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324C4FAE3E
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Apr 2022 16:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiDJObD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Apr 2022 10:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiDJObC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Apr 2022 10:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433C026119
        for <linux-wireless@vger.kernel.org>; Sun, 10 Apr 2022 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649600929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DJKeFhtLpKk6FDJW/lbe2K7P+qz//7PVM7l0qdrV7nk=;
        b=Q4Ui/eD2s21ztiNU3djz3S34ysKV9/je0RsZlFQu8JQeTavQVCpvl1FMM7YapztFNjOlAF
        NosJ/aCUiIlZQjWJlhrlUqGV2ezTkn3gcH5+q9frvdCZkMoZvROrImjjwQ9IBiY/sVSwCf
        NTZA4XiZ/hXPv4gIS4Dcy0+dUxOuDC4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-0WRERW4cMdev5ny2MkFE6Q-1; Sun, 10 Apr 2022 10:28:48 -0400
X-MC-Unique: 0WRERW4cMdev5ny2MkFE6Q-1
Received: by mail-qt1-f199.google.com with SMTP id bt12-20020ac8690c000000b002ee65af14d0so219894qtb.22
        for <linux-wireless@vger.kernel.org>; Sun, 10 Apr 2022 07:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJKeFhtLpKk6FDJW/lbe2K7P+qz//7PVM7l0qdrV7nk=;
        b=5vN/X/WpvARqiihL5LRFiNc82MkyDfqW8kUT7/qzPbbG1TAqAL4I9PkXD62UOK+VXm
         B60qt0kspHKBOk8lkUgqforZXepnYW+srR7dpZ62BQDMuqzJZhLNwUIUw4J7zDzUKkMh
         ZKAa19nn2R0GSyad4JuWYUAqZKtPR0hFiDPtqGBMzRsj1ZoTB8ITXx1Xul6C1rRgYvP2
         wOeHf59mQgx7QlW7CURmmPOVVt1OapsRh5C6SCbqUF2QGDzCuiR8tYI41kPE0xCzQDFS
         Ka/fWDlTSN5fghnRWUCnmfMxrFmtb6e3Khpj3oGgHm0/omesyXT5OJB8NZgcYLoQSYHJ
         CifA==
X-Gm-Message-State: AOAM530hkq24eeJ/XuISDIb2PKljUAoTE6tZ1TCzN8uIlZuQ73gDHrSk
        8R8Cl6UOGy/sLKofsIZIyku08J6Tk806dgALBTB3v21aA1jvDIfaPGu3hv3DGlx7KpXqfm8M7yT
        FOF4iC/m0IQt8khpuPzJswfrRD/U=
X-Received: by 2002:ad4:5be4:0:b0:441:2daa:4ac2 with SMTP id k4-20020ad45be4000000b004412daa4ac2mr24249399qvc.29.1649600927252;
        Sun, 10 Apr 2022 07:28:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFzRe0p2MiMwbGaTAQ5TqH6l2IimoFAQLL0viIb2Czmoff0lqgANdpkFxb7kuOZY7Do6IZvQ==
X-Received: by 2002:ad4:5be4:0:b0:441:2daa:4ac2 with SMTP id k4-20020ad45be4000000b004412daa4ac2mr24249380qvc.29.1649600926994;
        Sun, 10 Apr 2022 07:28:46 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b00680af0db559sm18285558qkb.127.2022.04.10.07.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 07:28:46 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     luciano.coelho@intel.com, kvalo@kernel.org, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, emmanuel.grumbach@intel.com,
        ayala.beker@intel.com, johannes.berg@intel.com,
        colin.i.king@googlemail.com, keescook@chromium.org,
        gustavoars@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] iwlwifi: mei: clean up comments
Date:   Sun, 10 Apr 2022 10:27:33 -0400
Message-Id: <20220410142733.1454873-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SPDX
*.h use /* */ style comments

Spelling replacements
commnunication to communication
adsress to address
procotol to protocol
addtional to additional
kown to know
negotiaion to negotiation
mssage to message

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h    |  6 +++---
 drivers/net/wireless/intel/iwlwifi/mei/main.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h        | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mei/trace-data.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/mei/trace.h      |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
index 67122cfa2292..135686bf602c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/iwl-mei.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2021 Intel Corporation
  */
@@ -13,7 +13,7 @@
 /**
  * DOC: Introduction
  *
- * iwlmei is the kernel module that is in charge of the commnunication between
+ * iwlmei is the kernel module that is in charge of the communication between
  * the iwlwifi driver and the CSME firmware's WLAN driver. This communication
  * uses the SAP protocol defined in another file.
  * iwlwifi can request or release ownership on the WiFi device through iwlmei.
@@ -346,7 +346,7 @@ void iwl_mei_set_rfkill_state(bool hw_rfkill, bool sw_rfkill);
 /**
  * iwl_mei_set_nic_info() - set mac address
  * @mac_address: mac address to set
- * @nvm_address: NVM mac adsress to set
+ * @nvm_address: NVM mac address to set
  *
  * This function must be called upon mac address change.
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index b4f45234cfc8..0bb550e364ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1854,7 +1854,7 @@ static int iwl_mei_probe(struct mei_cl_device *cldev,
 	iwl_mei_dbgfs_register(mei);
 
 	/*
-	 * We now have a Rx function in place, start the SAP procotol
+	 * We now have a Rx function in place, start the SAP protocol
 	 * we expect to get the SAP_ME_MSG_START_OK response later on.
 	 */
 	mutex_lock(&iwl_mei_mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/sap.h b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
index be1456dea484..701373006dc8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/sap.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/sap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2021 Intel Corporation
  */
@@ -25,7 +25,7 @@
  *
  * Since this messaging system cannot support high amounts of
  * traffic, iwlwifi and the CSME firmware's WLAN driver have an
- * addtional communication pipe to exchange information. The body
+ * additional communication pipe to exchange information. The body
  * of the message is copied to a shared area and the message that
  * goes over the ME interface just signals the other side
  * that a new message is waiting in the shared area. The ME
@@ -55,7 +55,7 @@
 /**
  * DOC: Host and driver state messages
  *
- * In order to let CSME konw about the host state and the host driver state,
+ * In order to let CSME know about the host state and the host driver state,
  * the host sends messages that let CSME know about the host's state.
  * When the host driver is loaded, the host sends %SAP_MSG_NOTIF_WIFIDR_UP.
  * When the host driver is unloaded, the host sends %SAP_MSG_NOTIF_WIFIDR_DOWN.
@@ -76,7 +76,7 @@
  * DOC: Ownership
  *
  * The device can be controlled either by the CSME firmware or
- * by the host driver: iwlwifi. There is a negotiaion between
+ * by the host driver: iwlwifi. There is a negotiation between
  * those two entities to determine who controls (or owns) the
  * device. Since the CSME can control the device even when the
  * OS is not working or even missing, the CSME can request the
@@ -136,7 +136,7 @@ enum iwl_sap_me_msg_id {
  * struct iwl_sap_me_msg_hdr - the header of the ME message
  * @type: the type of the message, see &enum iwl_sap_me_msg_id.
  * @seq_num: a sequence number used for debug only.
- * @len: the length of the mssage.
+ * @len: the length of the message.
  */
 struct iwl_sap_me_msg_hdr {
 	__le32 type;
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
index 83639c6225ca..15cb0bb4e9dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace-data.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright(c) 2021        Intel Corporation
  */
diff --git a/drivers/net/wireless/intel/iwlwifi/mei/trace.h b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
index 45ecb22ec84a..20ff836733bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/trace.h
+++ b/drivers/net/wireless/intel/iwlwifi/mei/trace.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-only
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright(c) 2021        Intel Corporation
  */
-- 
2.27.0

