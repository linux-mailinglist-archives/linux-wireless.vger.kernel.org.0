Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E71B58F485
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Aug 2022 00:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbiHJWsa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 18:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiHJWs2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 18:48:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50A26134
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 15:48:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso4396041pjg.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Fr762XHXTJUrM/94JI732q3jnJdS0jEuFn+HNA6g/hA=;
        b=O5zB5Dyd2Tet9BYnY2+2DhPjstWcGuQ5FbqgoK2YxgQeL4GTerjldo7J/QbBezhq4i
         FDAvf200KFy668T1+8IlCJo4lw6RB1w45LpezQ5S8NDZeFEFJDTqu8qib4oltT5eXkxK
         xqnu0LVfxW1KELLaWd4r0hXk33NbdbLZC6l0KC4LEjnB6b+OYHDSFn0l5WD7MoRQY1UC
         1EzStbw0AcPOoAKb1vxWkpIDDh7iHyqnaCmiGwvJ9TnueBq8PaJxzcGrESxdsMrkiTx4
         SVwPNv/PrF6gZ9Lc1sUGcFSDvG+mvaA/BeEgJOE9hC7XDZS2xEZUpzibKpvpTOyalKbq
         D8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Fr762XHXTJUrM/94JI732q3jnJdS0jEuFn+HNA6g/hA=;
        b=aoL7vKQe5TNMSQqs/pogs1mVWpts0Ih/m+8V8dlRNXzfku/lYDohBJtlF4nkbcYkd/
         D8M+H2uD+H7+i0PIJdtoqfFNyiqLPQ8lDSocztIzBJRjbppb5Oq74fjwhFHeSU6EV6oT
         BKrrwWdCeC5yINSXUrBZgF8WmvQSZIOedhReurjm97+XtRWN979aLAIfPhmdj7RcNgUj
         /oR4Sdsq2K0pRDB/8v7Hop59OxnvQxI/zGgiMiR1zY5ROfffnL6iijnYGGvxEKbnSb6H
         iUenKgIvQm4r7DwyMFRPPpmtg0xffUnkA727cV36215h3iccHkuMD91mB7wNjnDw/TOV
         uoww==
X-Gm-Message-State: ACgBeo31reP7Ws8RWe1ZFZnOdse5AnK3u1rKUrT1/OnBxdC5UPyND2s1
        96fUCcXsuSZV6JOkDO/ijB38yvZnoW70ay7P
X-Google-Smtp-Source: AA6agR6VWhiM3CDfgDlpmC3HU5fXubpNeuQbUQQscW1uxSruSs8oDgw/yeZSZ4Ph5H9UQeUIAV2oIQ==
X-Received: by 2002:a17:90b:4f8d:b0:1f3:1785:8981 with SMTP id qe13-20020a17090b4f8d00b001f317858981mr5882754pjb.227.1660171707285;
        Wed, 10 Aug 2022 15:48:27 -0700 (PDT)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id g27-20020aa796bb000000b00525496442ccsm2480818pfk.216.2022.08.10.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:48:26 -0700 (PDT)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] wifi: ieee80211: Fix for fragmented action frames
Date:   Thu, 11 Aug 2022 10:48:04 +1200
Message-Id: <20220810224804.2137240-1-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
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

The robust management frame check ensures a station exists for
the frame before proceeding, but there are some action frame
categories which don't require an existing station, and so the
_ieee80211_is_robust_mgmt_frame function peeks into the
action frame's payload to identify the category and filter them out.

In some scenarios, e.g. DPP at S1G data rates, action frames
can get fragmented. This commit adds an extra check to ensure
we don't peek into the payload of fragmented frames beyond the
first fragment.

Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/linux/ieee80211.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 55e6f4ad0ca6..5da9608fdce3 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4124,6 +4124,7 @@ static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
 
 	if (ieee80211_is_action(hdr->frame_control)) {
 		u8 *category;
+		u16 sc;
 
 		/*
 		 * Action frames, excluding Public Action frames, are Robust
@@ -4134,6 +4135,17 @@ static inline bool _ieee80211_is_robust_mgmt_frame(struct ieee80211_hdr *hdr)
 		 */
 		if (ieee80211_has_protected(hdr->frame_control))
 			return true;
+
+		/*
+		 * Some action frames do not have a STA associated with them,
+		 * so we rule them out from the robust management frame check.
+		 * The category is within the payload, so we only proceed if
+		 * we're checking the first fragment.
+		 */
+		sc = le16_to_cpu(hdr->seq_ctrl);
+		if (sc & IEEE80211_SCTL_FRAG)
+			return false;
+
 		category = ((u8 *) hdr) + 24;
 		return *category != WLAN_CATEGORY_PUBLIC &&
 			*category != WLAN_CATEGORY_HT &&
-- 
2.25.1

