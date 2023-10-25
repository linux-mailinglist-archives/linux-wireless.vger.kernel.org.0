Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D847D5EFF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344725AbjJYASG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 20:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbjJYASF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 20:18:05 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0B710CE
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 17:18:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd73395bceso264541b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 17:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1698193083; x=1698797883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sbb0ysAAPnRKXchGVGieMApmNR4HpfysT2TcBsHKMXI=;
        b=rnMOg1823NlVyDCKd4zGs5/xChCQEZD+Iaqd1h0erIWD4Taivr3qvzXqKtVS2M8N5X
         119d2AA9JJdiAFMEcRAJwJacau9W7PLZRIWFFzFHE6e1jx7M7b3ocygzE7R/3XAfNVoS
         14FHiJr2N1ZMW+7nSQ0xPXYEnyr+U9Ku2elJWBvqO2Zbrw34vOM3dLhrRakGwzuHbcr2
         0mQ+obmuUk5J/NK+MHI5roezq90eF/U3Mf+5dmX0uZz68yggs7mHEl+vfP83rM/QTVFu
         RkO+HOe+g+8Nh9GMcR/ndNrJPo7b9kkN31nhxjiiyacesZDTCB9JXs/+yLL41ax/NYma
         qDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193083; x=1698797883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sbb0ysAAPnRKXchGVGieMApmNR4HpfysT2TcBsHKMXI=;
        b=cIMG3BBAoKBG2nfPDKkU1vUHCfosUK2BlTb+q6VmTylVvwjLRNrBDBTp1VtgmOlT52
         7074dy/O49itfiWyw5WJwjKCpxm1Ayo1J86e8RuczkA+OAx6i8GTHfjpI1K/kIGamcLT
         dBfZRlLGjTW3iEIcO+DeeqQopk5ZgRk6jF66CHIABlNMpKHPpajv7GiyU6qpQoF6e5O8
         5r7RjCMCPpgGucz5JsGMiBiIeGAemrkPvw0htI5lpmGCk5mVfgKbgvYSTvHfuJ2f1qKE
         fQ3Vn1/XEpG4La1aAcq/gNAXhb9hQMVhDg+Zeqj2Cm4AyHW8i1//uWh9H23zwMH/iUb3
         iB5Q==
X-Gm-Message-State: AOJu0YxGYKUejtws0O8OR4hnweZe5HUf1/OtBIyPhwzL/B+CQ7sP8Z1i
        8mm9vX+9r4WgPdwbQE4mnD+EmPToeFs/mncm0T+/t+yV
X-Google-Smtp-Source: AGHT+IGnKq62plopOY4Hy2W8NEAZT0Xx2BMukhhxH3FJYR0FGPzYVLa7KPlYrh0dkz0D2R1TJvj2CQ==
X-Received: by 2002:a05:6a20:8e0f:b0:161:aef5:6395 with SMTP id y15-20020a056a208e0f00b00161aef56395mr5352647pzj.24.1698193082631;
        Tue, 24 Oct 2023 17:18:02 -0700 (PDT)
Received: from liam-xps.sydney.mm.lcl (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.googlemail.com with ESMTPSA id z29-20020aa7949d000000b006be5e537b6csm8176001pfk.63.2023.10.24.17.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:18:02 -0700 (PDT)
From:   Liam Kearney <liam.kearney@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     Liam Kearney <liam.kearney@morsemicro.com>,
        linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2] wifi: ieee80211: fix PV1 frame control field name
Date:   Wed, 25 Oct 2023 11:17:12 +1100
Message-Id: <20231025001711.1751726-1-liam.kearney@morsemicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update PV1 frame control field TODS to FROMDS to match 802.11 standard

---
v2: update comment to reference 2020 version of the standard

include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bd2f6e19c357..d8e878167385 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -172,11 +172,11 @@
 #define IEEE80211_SN_MODULO		(IEEE80211_MAX_SN + 1)
 
 
-/* PV1 Layout 11ah 9.8.3.1 */
+/* PV1 Layout IEEE 802.11-2020 9.8.3.1 */
 #define IEEE80211_PV1_FCTL_VERS		0x0003
 #define IEEE80211_PV1_FCTL_FTYPE	0x001c
 #define IEEE80211_PV1_FCTL_STYPE	0x00e0
-#define IEEE80211_PV1_FCTL_TODS		0x0100
+#define IEEE80211_PV1_FCTL_FROMDS		0x0100
 #define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
 #define IEEE80211_PV1_FCTL_PM		0x0400
 #define IEEE80211_PV1_FCTL_MOREDATA	0x0800
-- 
2.39.2

