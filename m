Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E65A2CFD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Aug 2022 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiHZRAu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiHZRAp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 13:00:45 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A71BC80E
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:00:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso8659264pjk.0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cAmRLOTm/YIdX7Lx7jAm2pYzm8lrQiOwQoZv0peuAxs=;
        b=FvqzwxrhmgT+ZlSeOB5ijNu8CUB2D1AhBZkmXY3N6KRGs6+3s38HWfS6Tj9ZKBrl5F
         J+8BHwkKa9i2u6/1whLOMlSe/sJEcb/fYlUOvAsUMIvaC5sdbyYLN4GWHk+XeYzuABWz
         DzlxaPDKMqjhyp+pWEZKguEVA82EqhSQF9+Z/xUhZl+W37YjWLLcoJy9/Q2vgt217Mvd
         yYPxSo+dRF2gSdKeOwlo4E016hKkoG8kNIZLSNxGy8FUF+wPMrRzcyz8nFQDcuCe4G2L
         uTDDzFj/KvxhlQBC64INrMM2QGlGhqVwlxUKT2shrGr8eymlGHf7QW692g7tDy9BDB30
         HMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cAmRLOTm/YIdX7Lx7jAm2pYzm8lrQiOwQoZv0peuAxs=;
        b=YWZsBd1Qbej/H/sjC9OSLG6l9/en2kJy/bvvO/5O3RDrai58O2Cbtd3NPO0aBXuQmp
         8GcDwwNS8xLXOVmNXNzS5hO+D+9nSH5cSsO/y/p8kdvX4+vm+iIRhtmJ+j4h101gm7xe
         IEkMO71PlmLVRpljAx/VPqphxok1fMf8QydMq+EqE8Lqs5qhb5GvxMqXVAq8enHPT6d6
         kjosr+Sr4mSzXbCN//Ecuc5aeCIJif+xfHYSwWRArNTViDrpof/3vGTVVDr90Xpof4Uz
         alTKz038d04n1bfM1mStMlvPz/mzuRTERxTMFl+6Ga3k3Wr5748UAq/atRZpNrsFlbwu
         H8qA==
X-Gm-Message-State: ACgBeo0so9XbWjwXjFOg7bmrnV1cAhzteLu0PJ9xl9T+zr3d91YrhxM3
        o/f0o+4OL/IZ5AuO4QYZzT0zf4fCS2Y=
X-Google-Smtp-Source: AA6agR7Qwy36zRAvmlaEYra9VRjLgAM1zeVj+6LQl92FD91gH4Y2Gx3bR22h6M7zD7Ft2Jw5pV9Fxg==
X-Received: by 2002:a17:902:c102:b0:172:ce4b:870c with SMTP id 2-20020a170902c10200b00172ce4b870cmr4385549pli.155.1661533242130;
        Fri, 26 Aug 2022 10:00:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id y9-20020a634949000000b0041d322b3bf6sm1685034pgk.77.2022.08.26.10.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 10:00:41 -0700 (PDT)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/2] include: nl80211: Add POWERED_ADDR_CHANGE feature
Date:   Fri, 26 Aug 2022 10:00:31 -0700
Message-Id: <20220826170032.2860883-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220826170032.2860883-1-prestwoj@gmail.com>
References: <20220826170032.2860883-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new extended feature bit signifying that the wireless hardware
supports changing the MAC address while the underlying net_device is
powered. Note that this has a different meaning from
IFF_LIVE_ADDR_CHANGE as additional restrictions might be imposed by
the hardware, such as:

 - No connection is active on this interface, carrier is off
 - No scan is in progress
 - No offchannel operations are in progress

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 include/uapi/linux/nl80211.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d9490e3062a7..57ead424a0c3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -6174,6 +6174,14 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_RADAR_BACKGROUND: Device supports background radar/CAC
  *	detection.
  *
+ * @NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE: Device can perform a MAC address
+ *	change without having to bring the underlying network device down
+ *	first. For example, in station mode this can be used to vary the
+ *	origin MAC address prior to a connection to a new AP for privacy
+ *	or other reasons. Note that certain driver specific restrictions
+ *	might apply, e.g. no scans in progress, no offchannel operations
+ *	in progress, and no active connections.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6241,6 +6249,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_BSS_COLOR,
 	NL80211_EXT_FEATURE_FILS_CRYPTO_OFFLOAD,
 	NL80211_EXT_FEATURE_RADAR_BACKGROUND,
+	NL80211_EXT_FEATURE_POWERED_ADDR_CHANGE,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
-- 
2.34.3

