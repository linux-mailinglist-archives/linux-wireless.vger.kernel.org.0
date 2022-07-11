Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4F56D265
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiGKBJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGKBJR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75240B485
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o15so3577033pjh.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oL39zzxpS0oN7YLsNwfPuUDWDQJZalCgqn70twVNd4s=;
        b=rxxdUGCDzbkmT+x7kGNtSqYrX+gQ9KBO/68RspFK3IZEyyEiTNxrAQbxAk8uDvVtTh
         E+ldQEdXzIvuK6UvkLpKPVdZW5DUhbPJ747mJsLYxOFFLRANJcJAeT8wwWCFmvswKhDX
         5fUa9XvkLCG3r2zLmYcP7hWJ1xuk0YzG6RpA205UYuvKbuHrRI/cFyNdlPQzUcEB8A7t
         7260XpL0gGZHx0AqJs9+MKp9rr5zCyyIFkzmDG/k30xU0eo/fP57NF8RT6K6LV+kpNk+
         T2ovr3cB3gYIe3rcPJeqQQc+8tG+yUfwNjxAe2eJ48dGKs067xj1FOqxyHbU4GrmEwyr
         p8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oL39zzxpS0oN7YLsNwfPuUDWDQJZalCgqn70twVNd4s=;
        b=3s9uivsqALKuGtkHN2GVU4XW1fFiQHocYW+LWY/NEtWsSykNvVhFpRHm8hC2i1EK4u
         3lbD+dY6f9/KvgOxMDVk6H0vdELiXbDhBRVVZTsl5q3lQ1+bKz3w9ZLKZEXtm902MxAu
         Lfm+9sZBNfXgW3oCyTWMO6uMbBF57f+ViEdhUlNHWUllyv/jT6E2eAJuvrW+lspAbCXR
         GTHNO4t4tqxpzCjSVY9V8S5iX1gGf1Tmsun04C5e0t6GnIjo6YGq2gpk2y58nGi50wFX
         huS06IPI0cj0cwsC46SoqHruxqr14H1R6IU60kwd90HKuJJ1VjDilSlIlSjUixjZMP4d
         x6qQ==
X-Gm-Message-State: AJIora+jCEsi4JFNbHWdInnH2RvstnaOnSlNFucuUwH5fxohPcAI/dwH
        MtY9QBWlAAYKHV0M0Pew1LmEIbWKSA+smWtS
X-Google-Smtp-Source: AGRyM1u0A/ptDvOrOcQ7GOSnb2y/d2GyhHFBmAqDy5JrBK2zwPZVarNQJVcQxNVuL35IBg+mDWZSZA==
X-Received: by 2002:a17:90a:fa05:b0:1ef:89d1:1255 with SMTP id cm5-20020a17090afa0500b001ef89d11255mr14694363pjb.73.1657501755105;
        Sun, 10 Jul 2022 18:09:15 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:14 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 08/12] cfg80211: S1G rate flags
Date:   Mon, 11 Jul 2022 01:08:12 +0000
Message-Id: <20220711010816.45927-9-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
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
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 include/net/cfg80211.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7859b8b11968..47f71fb5d07a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1608,6 +1608,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
  * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
  * @RATE_INFO_FLAGS_EXTENDED_SC_DMG: 60GHz extended SC MCS
  * @RATE_INFO_FLAGS_EHT_MCS: EHT MCS information
+ * @RATE_INFO_FLAGS_S1G_MCS: mcs field filled with S1G MCS
  */
 enum rate_info_flags {
 	RATE_INFO_FLAGS_MCS			= BIT(0),
@@ -1618,6 +1619,7 @@ enum rate_info_flags {
 	RATE_INFO_FLAGS_EDMG			= BIT(5),
 	RATE_INFO_FLAGS_EXTENDED_SC_DMG		= BIT(6),
 	RATE_INFO_FLAGS_EHT_MCS			= BIT(7),
+	RATE_INFO_FLAGS_S1G_MCS                 = BIT(8),
 };
 
 /**
@@ -1634,6 +1636,11 @@ enum rate_info_flags {
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
@@ -1645,6 +1652,11 @@ enum rate_info_bw {
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
@@ -1667,7 +1679,7 @@ enum rate_info_bw {
  *	only valid if bw is %RATE_INFO_BW_EHT_RU)
  */
 struct rate_info {
-	u8 flags;
+	u16 flags;
 	u8 mcs;
 	u16 legacy;
 	u8 nss;
-- 
2.25.1

