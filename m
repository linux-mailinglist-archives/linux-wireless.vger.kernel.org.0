Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281DA5A5947
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiH3CVD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiH3CVC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:21:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579037FFA4
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z3-20020a17090abd8300b001fd803e34f1so7859526pjr.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PS78Y6Cc1leof3wv7vMwmck9H+AaNqnxAUUmZvGqIsU=;
        b=elAKci7qbregr6JktXP+ihUWumpJssCmWqf2bgrfBCbTLJIXE3jR3cLEoVOicjCcLe
         uwotTugvJHxjfOW3qSzVehPnwAC3+Mv6by6p7EorKHTcyQU79ME8+RaY6bzU/6uAvlyb
         x3RODYKzEnYUDFbSkNTinxRCDZLZ+z0z7kU4O/BbB+ADm77eBYGqRm+NB8UlXm2B0pjk
         RJS44KbWWOsrqD5nhsLZRXBueUDNHOsSnGoye0574vQ1Hfjg8/fAYku7+iVct6o7MEIQ
         FanR9dX6t3V7+QOwfUMQNHuQuqO8jwnpHRkLWFBpJarqF6KDA2Z+ZU1v0jN5kYvhqevQ
         xVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PS78Y6Cc1leof3wv7vMwmck9H+AaNqnxAUUmZvGqIsU=;
        b=e3AOp85ouXFSgmTomsykbh+6EqBHQZmbWpjbgHDxhwpqttbWD9sz9zob8EFpxcQTMy
         jlN6lYr195GVYYL8WXAzoLXxKZ7uWvROffudFAHUm8zBdllwne7VbD1wuRmlVsChl8Kx
         kr+4n5I9fyqFE4LVw+39fJFuIQiJe+IT0cWJTmWnTcBB3Zk5Cdie5TGJ6miGNssKKfVz
         oHSbp4CRAwI1K2lZtXpgamaHZZa5xsZmFcqI4rQK2+K99CBy93rmM5C4XSpvztXwOWL8
         1Z8hydsDdw+/xzU25Qp21a3vzxVL1Ff7yQBFoG9iUapZrFY/4nNRppKTuWQmLhTbUlBs
         rARw==
X-Gm-Message-State: ACgBeo0JELQTRnqisG7NxIL9nJTGLrh8+NCIKhuRwOiZxFIUJsEXntjT
        x9hKl9Kk6/5YlEvIphEP2xLYnEjYC9Ng3zbd
X-Google-Smtp-Source: AA6agR7eyYrgRs5sSjXS45b5rcVrClKrr7Uze/qNoH1XRiYNWmt9vaCxWwMIiSx9z1kGiGap6ZjCHA==
X-Received: by 2002:a17:902:f686:b0:175:44a:c707 with SMTP id l6-20020a170902f68600b00175044ac707mr3418477plg.62.1661826060903;
        Mon, 29 Aug 2022 19:21:00 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:21:00 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 08/12] cfg80211: S1G rate flags
Date:   Tue, 30 Aug 2022 02:20:13 +0000
Message-Id: <20220830022017.51017-9-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
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
index f462dcdd023a..cdd43ba9c62e 100644
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
2.25.1

