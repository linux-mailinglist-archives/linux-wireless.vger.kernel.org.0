Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721D5ADEA6
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiIFEtN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiIFEtM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4836369F58
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:49:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o4so10059928pjp.4
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gEzSj0cQ8tFtuGpVrdD28/ELiDwSc22eP11NGOwvdoM=;
        b=Aog6gX14ezGtmnLOC584TyaW1aHnPNepiCAHP3dqIjWQ6dbXitAZF0DBYUEnnCXMFU
         di0/z8OW3cSyU0o/fbTTzlg7BsieIcH4r0kEznPwUXNlc74FctlDH3KicJFoOJNL0gE3
         /67E8kIhojYLuKhYxO+YDyk8RfA7eEI4pXLszEfSPnVQnw/xKC8fYcD0pchpQTQDvGUJ
         f785VPfqqF95P28IH4DuwmIe61TqNdStSxq/31wIt6294JLBZIhUyp0CRFgwmt+S9Mtv
         Heekjc8iCh6BbOH9s3QCKxqWYibdbPIw+mc+FVmX3YRI17D/UsHCKd2U5QPMdH+/nm7S
         Cfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gEzSj0cQ8tFtuGpVrdD28/ELiDwSc22eP11NGOwvdoM=;
        b=BJcDSvuGWxUQZSvsJR4sjcB0uMoDCY1CLKLbyuUh+WBt/J6JKsLV3uuEM5/HjWIZXp
         qLN78jFMhFKaD+yul0WRQLyep7lTak4ywqERqH+qJMGX/3roH5Okf6lPflt2D3gxB11i
         0XgutiwcyJ9uu7SNkCr1PWPycRujqja1+v0B5LjcOrlHU2mWU+Vywws6SAseG3qFMsu2
         /e6lCYXDyCjicHw3bVg03k0FLNWVGjvAJFLdu1hHtX8sEGTu1O5EfnYhKpgVHMlOtKAZ
         gxBUycsubDGR3IWh4a0MdfbWM7p+kIil/+PBDMrlXxZCXh44FBhbNaF06Ci5J2+Jbp0O
         Y5Yw==
X-Gm-Message-State: ACgBeo363gOSBtrolpHsGcolwtrP4uAXVkZgJGznkADv1GW4ebYG8NId
        AgcpjBbHoa2SwiFAoc0Ns7Ldjw==
X-Google-Smtp-Source: AA6agR4B+DsDTzKvx86Qd+C8RiVEGbDgmaxo/vuYLt6MQuA6DhXpfH3LqICEbh7lnRv0MNDI5SN69A==
X-Received: by 2002:a17:90b:3a89:b0:1fe:4d6d:bd75 with SMTP id om9-20020a17090b3a8900b001fe4d6dbd75mr23420137pjb.199.1662439745745;
        Mon, 05 Sep 2022 21:49:05 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:49:05 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 08/12] cfg80211: S1G rate flags
Date:   Tue,  6 Sep 2022 16:48:08 +1200
Message-Id: <20220906044812.7609-9-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Increase the size of S1G rate_info flags to support S1G. Add flags for new
S1G bandwidths and S1G MCS.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 include/net/cfg80211.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b750b2ad246b..281775f6b3e0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1660,6 +1660,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
  * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
  * @RATE_INFO_FLAGS_EXTENDED_SC_DMG: 60GHz extended SC MCS
  * @RATE_INFO_FLAGS_EHT_MCS: EHT MCS information
+ * @RATE_INFO_FLAGS_S1G_MCS: MCS field filled with S1G MCS
  */
 enum rate_info_flags {
 	RATE_INFO_FLAGS_MCS			= BIT(0),
@@ -1670,6 +1671,7 @@ enum rate_info_flags {
 	RATE_INFO_FLAGS_EDMG			= BIT(5),
 	RATE_INFO_FLAGS_EXTENDED_SC_DMG		= BIT(6),
 	RATE_INFO_FLAGS_EHT_MCS			= BIT(7),
+	RATE_INFO_FLAGS_S1G_MCS                 = BIT(8),
 };
 
 /**
@@ -1686,6 +1688,11 @@ enum rate_info_flags {
  * @RATE_INFO_BW_HE_RU: bandwidth determined by HE RU allocation
  * @RATE_INFO_BW_320: 320 MHz bandwidth
  * @RATE_INFO_BW_EHT_RU: bandwidth determined by EHT RU allocation
+ * @RATE_INFO_BW_1: 1 MHz bandwidth
+ * @RATE_INFO_BW_2: 2 MHz bandwidth
+ * @RATE_INFO_BW_4: 4 MHz bandwidth
+ * @RATE_INFO_BW_8: 8 MHz bandwidth
+ * @RATE_INFO_BW_16: 16 MHz bandwidth
  */
 enum rate_info_bw {
 	RATE_INFO_BW_20 = 0,
@@ -1697,6 +1704,11 @@ enum rate_info_bw {
 	RATE_INFO_BW_HE_RU,
 	RATE_INFO_BW_320,
 	RATE_INFO_BW_EHT_RU,
+	RATE_INFO_BW_1,
+	RATE_INFO_BW_2,
+	RATE_INFO_BW_4,
+	RATE_INFO_BW_8,
+	RATE_INFO_BW_16,
 };
 
 /**
@@ -1719,9 +1731,9 @@ enum rate_info_bw {
  *	only valid if bw is %RATE_INFO_BW_EHT_RU)
  */
 struct rate_info {
-	u8 flags;
-	u8 mcs;
+	u16 flags;
 	u16 legacy;
+	u8 mcs;
 	u8 nss;
 	u8 bw;
 	u8 he_gi;
-- 
2.34.1

