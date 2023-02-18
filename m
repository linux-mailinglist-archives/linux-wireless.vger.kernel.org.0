Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E769BB86
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Feb 2023 20:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBRTLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Feb 2023 14:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBRTLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Feb 2023 14:11:10 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9815558
        for <linux-wireless@vger.kernel.org>; Sat, 18 Feb 2023 11:11:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id y63so549978pgy.13
        for <linux-wireless@vger.kernel.org>; Sat, 18 Feb 2023 11:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zf7rG+fsrika4LatxPpr29R818vMyi25upFsjiFQJTc=;
        b=ctH6tO0PO9+X0z8t2xtsfOvZcQXeTlzJ7NRXDmELZRHe+Ec46ycsz+chjFuq2v13kG
         7Cm8TeygFCjPFMXhvPZ7IxPBDuhdFuD6OFb7Yzmn9lTKNPT3j0hm/ima2fpt7euvm1MY
         lSQM+5DnQ9g4jgXCllSbpa7usFJ0vlwGRTHDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zf7rG+fsrika4LatxPpr29R818vMyi25upFsjiFQJTc=;
        b=gfiVQtVPuT6B37nSpOmo9Bfs04rfjgh8E18jTkqLiUvP/JJGOk9J8848Pk8d0XBzoT
         slAjSl39ZS5KV7xXEY6EblapR38CZdwWppor5v2TNTQ8+uDKtZT10pmJXlqzZnNDl/Il
         /uo/aPzNtTfk9Fm/STqaAiCA/vkDSmcmEZPVO0W9uqSFOR8H7Tr4Gr84vgTKqSCkxrJG
         fzvCPMcgBI1GN/OMRKuYx43uFIpI0ksHJZg6RBHoJGcFniF6KO1Us7gd/d4jjpNnXPj3
         X18BbGsiTb9i3RwJyObIKt9NiqNSQNS88xnqt8e6fKfvgh0IJ6Itj9TMZ2xw8Ld1O1c+
         cp7A==
X-Gm-Message-State: AO0yUKW6U7Qs8aNwKisgNU0OPRzaWPO3O9PCq101JwE7jifI9+nmLlBH
        guqxhygFwJhFi0NThTDSt+iON0pAArn0AQw5
X-Google-Smtp-Source: AK7set8K28w3uKPotk+c9h8F2CTsRMf6Mt14uP3+vjktHG27okpeTcXywcuKRUrZToP+0eRq9oHiNg==
X-Received: by 2002:aa7:9506:0:b0:5a8:aa77:1835 with SMTP id b6-20020aa79506000000b005a8aa771835mr4963220pfp.33.1676747462224;
        Sat, 18 Feb 2023 11:11:02 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k18-20020aa792d2000000b005a8b28c644esm4925819pfa.4.2023.02.18.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 11:11:01 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: dvm: Add struct_group for struct iwl_keyinfo keys
Date:   Sat, 18 Feb 2023 11:11:00 -0800
Message-Id: <20230218191056.never.374-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2903; h=from:subject:message-id; bh=6ocLfuLUjbHMLL3EssbDtFFXg555hqCuVMArd3yFm64=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj8SLD0yPX6FR7+Ky4Sm+eLKdlJc0JVCY7rZy1tsxd CLQhp2WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY/EiwwAKCRCJcvTf3G3AJiymD/ 9g1362ck2iM1XQp/7+Yumk1DkPuUGDlhNkg07IPRr/Kp88Q7ZdiOrZLW4SrMunolnRZhKstjflj+GW z3rEomGJjTeZ0aTviKU8bPHectrVXlnbYG87hAeV5hneIcB+GgMzUecLsRBQc5rTZQ6u+qTQeEJcdk L2AEaxSeglKM+ADCDtBwYLzpNivNBOPKeiugRsLDCDEOTHI6khqu6z2+7XV5aEe+lqtMMMlhNq+iyG H79XSkCx/6rfeIgzEjNCUluknMczJ6XicYCEKf5mBI+nnKDe+eTqx/HtQKgrJaEeYoIa6wz/h6v7gN 3BpCsgJbP/HJCMD622gBgzNYJ6w1lpwH93K4HEmTGbkWAigbbcpaGOQSuEoa0tKaUGAymi+ClNK4g8 Mc/I3OhcP42LiR8Wxk01c7FgXCwtHQxJVEcSKdI1aPsieYXzE8HWy5GeNvVCdKYWosB9G/tFKR5MdU SK8x9l1EyyYPX54Wxn6+87HeTxf6UdddjKRcVVtAUuaJPhBDb31jyV9JnpCoX1yfNPzhUpMt3a6UOI B8boiLn5Eu/e0+Qxuj3nN4SG+Af16pN7RIXu0RIvVUR2mLlO7enI0b8GIy+lBPGmFzOhgBw2lK9Q6g Cj2FJzTbsq1AivdRNhSK4OcnTL87RcezT3i5MQD7N8nUeesuvUK6DdynRkoA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Function iwlagn_send_sta_key() was trying to write across multiple
structure members in a single memcpy(). Add a struct group "keys" to
let the compiler see the intended bounds of the memcpy, which includes
the tkip keys as well. Silences false positive memcpy() run-time
warning:

  memcpy: detected field-spanning write (size 32) of single field "sta_cmd.key.key" at drivers/net/wireless/intel/iwlwifi/dvm/sta.c:1103 (size 16)

Link: https://www.alionet.org/index.php?topic=1469.0
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Benjamin Berg <benjamin.berg@intel.com>
Cc: Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h | 10 ++++++----
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c      |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
index 75a4b8e26232..0eceac4b9131 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/commands.h
@@ -783,10 +783,12 @@ struct iwl_keyinfo {
 	__le16 tkip_rx_ttak[5];	/* 10-byte unicast TKIP TTAK */
 	u8 key_offset;
 	u8 reserved2;
-	u8 key[16];		/* 16-byte unicast decryption key */
-	__le64 tx_secur_seq_cnt;
-	__le64 hw_tkip_mic_rx_key;
-	__le64 hw_tkip_mic_tx_key;
+	struct_group(keys,
+		u8 key[16];	/* 16-byte unicast decryption key */
+		__le64 tx_secur_seq_cnt;
+		__le64 hw_tkip_mic_rx_key;
+		__le64 hw_tkip_mic_tx_key;
+	);
 } __packed;
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
index cef43cf80620..a1c9e201b058 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/sta.c
@@ -1093,14 +1093,14 @@ static int iwlagn_send_sta_key(struct iwl_priv *priv,
 	switch (keyconf->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 		key_flags |= STA_KEY_FLG_CCMP;
-		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
+		memcpy(&sta_cmd.key.keys, keyconf->key, keyconf->keylen);
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
 		key_flags |= STA_KEY_FLG_TKIP;
 		sta_cmd.key.tkip_rx_tsc_byte2 = tkip_iv32;
 		for (i = 0; i < 5; i++)
 			sta_cmd.key.tkip_rx_ttak[i] = cpu_to_le16(tkip_p1k[i]);
-		memcpy(sta_cmd.key.key, keyconf->key, keyconf->keylen);
+		memcpy(&sta_cmd.key.keys, keyconf->key, keyconf->keylen);
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
 		key_flags |= STA_KEY_FLG_KEY_SIZE_MSK;
-- 
2.34.1

