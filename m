Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0B76521A3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 14:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiLTNmt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 08:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLTNmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 08:42:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD119C34
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 05:42:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a5-20020a25af05000000b006e450a5e507so14367790ybh.22
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oYAVZngUdmk1RtZxmwOEx5HBTEmaaTCX2EY39AknqTs=;
        b=bOTaR34OXnc70kInhPqCsbZtNSJhJ6u3rSgmMTqPO+gn7q3iTJI3NcYCZi79+K+Ut9
         qAXNKGNuYKMqp5KaDU++/mIPuL0DRl7Y54FL4x3Rf7eWtLik/ecRtNj5I1jD/j5eD4OO
         l9bj14PZFtb9Zq8QK/+bibrlNRnwV+b2uaj9VWvS59omzbFaBKm/6uqDqOZhDSZRyx+u
         MPcs/PCGBhDWfZUs7gIlPBc9kwl1a/sbgL0kqerkYUeFNWv8Mc0kC02m+KWCx+KV1SKZ
         mJAMgfwnJM3+UzcFwweLuYGg99/gz2blqyav7f5Q4S9mu1Um6c8++PhOxIsHiPao7TCe
         Tkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYAVZngUdmk1RtZxmwOEx5HBTEmaaTCX2EY39AknqTs=;
        b=lE0HkcmvHpNZ1bEbyU9GFrK+D0UoYH9f4UqXx+xiwh4GFnY2R6W32ubt4Ne+FA7xFx
         ogLDI/CGKdX0XTRQLUP+oYBTVJ708RR7P6Kc5hby8GFuBKMJgBl4KLpCLqqaoSBpH7lh
         NCRvYGFtOnGbvatnqDhQCm21y2Rp/NsPsOuK+/XgjAih66I/jkjv9bZwR2hKPLmCulbd
         oiIMXCsYSVgIZQ+miBk4awaBiKH5NcRB+PotzWdAnIqssJUxcyj+S9yiaj+0EN7oVk5V
         ytHX6aPl1nX0QviLYLOtdKFccQ6InKBwUYZE6Xlfocn63XVVjrf20/N47TzN2b/+AXP9
         mfYw==
X-Gm-Message-State: ANoB5pk3VDStczXXSN01GqKQYaica7j0hmFcH3hro+rha6JixuqaIOuP
        uGlIlvjOdwoVlU+D7Ljpp8jvPQcoi5E=
X-Google-Smtp-Source: AA0mqf4WHxq9rNM4J6ySR5ARSMCFDd45pcwlTs+LPYhODFCWNOWdHl+qkqgEylS1eDWAHlLmp0Hy1q+hjis=
X-Received: from jaewan.seo.corp.google.com ([2401:fa00:d:11:106a:a96e:332:fe4])
 (user=jaewan job=sendgmr) by 2002:a25:6844:0:b0:6fa:1ef3:d720 with SMTP id
 d65-20020a256844000000b006fa1ef3d720mr38507793ybc.224.1671543763031; Tue, 20
 Dec 2022 05:42:43 -0800 (PST)
Date:   Tue, 20 Dec 2022 22:42:33 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220134233.2307164-1-jaewan@google.com>
Subject: [PATCH] iw: info: fix bug reading preamble and bandwidths
From:   Jaewan Kim <jaewan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Jaewan Kim <jaewan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Jaewan Kim <jaewan@google.com>
---
 info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git info.c info.c
index eb257f8..98461a4 100644
--- info.c
+++ info.c
@@ -197,7 +197,7 @@ static void __print_ftm_capability(struct nlattr *ftm_capa)
 	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PREAMBLES]) {
 #define PRINT_PREAMBLE(P, V) \
 	do { \
-		if (P | NL80211_PREAMBLE_##V) \
+		if (P | BIT(NL80211_PREAMBLE_##V)) \
 			printf(" " #V); \
 	} while (0)
 
@@ -215,7 +215,7 @@ static void __print_ftm_capability(struct nlattr *ftm_capa)
 	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_BANDWIDTHS]) {
 #define PRINT_BANDWIDTH(B, V) \
 	do { \
-		if (B | NL80211_CHAN_WIDTH_##V) \
+		if (B | BIT(NL80211_CHAN_WIDTH_##V)) \
 			printf(" " #V); \
 	} while (0)
 
-- 
2.39.0.314.g84b9a713c41-goog

