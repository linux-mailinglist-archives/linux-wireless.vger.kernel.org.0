Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F526629A6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 16:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjAIPQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 10:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjAIPQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 10:16:24 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C321538AE9
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 07:15:04 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4c11ae6ab25so94414357b3.8
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jan 2023 07:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0svfyUzucdvlYPpxOZgKhxn+Lq7r260gonMfod3PsM=;
        b=kv5wZIDZ3BTk1OWWUCjRhsSC4MrtrkQqg6bvzRWUlM3UbIXrCIwn1oq4kmxAZ4ocLh
         hqSK64g7LIRzl+pAJUmbxguAVrWHnlyoM1dSxr6Rj1KpGrflf54BdRUym77riuECdYch
         zuywqhXpy6ytzNgNCo7Pgs50ZenEGoKwIjQoJ0xY0LQPgb67LL1XaDTEvKKaavGlULk5
         M0/3tsohK5KXDvZCgxUbdtpPNqc4svfiBReyjzd9lh7bP0WiKIkh3Ly2rh2DzkUTVAVa
         jGBzkiE74rmxG09qqkifpRrqnxs+c1kZDdXtOW9zcC0/lawNWJfsJ8Mcb4XUy06rgUfg
         aTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0svfyUzucdvlYPpxOZgKhxn+Lq7r260gonMfod3PsM=;
        b=u8fWnfxMLvjxjms9s2MHk19FGuScdqyZk5EciLKEp/vmAbeSVLjeJh8CodVC36Db6F
         1/8cBWR1GJQITDWcei2DUUFPF2nR34CkDgD6W2K4NeI6kkU7qjSxqIQePxbQfhfpKKO0
         bf3MlQtRGZndVhu+Ab/42VFx0PqYi8bddrfndn5lwCyy8I7XVDRPqX6N+40VZJ8E39Im
         6di6YxpNmIWrWvSxLJ9DrDqHiVzCY1XNDWKhxn/5XhQLiewaEgeQAAw6PfR0vrC0OlVA
         zIXL1uQ5cbl/lnFui1hWlpxfCVWn8SFqa8iD9iMX2tAJKVHIYkcJX/kbInP88CMqXgOH
         xVwg==
X-Gm-Message-State: AFqh2kpI46G0jOgALr6a5RWAFkGSJ1Mvc8KlTpSIY/ZzuJMEdM5DjjX6
        +lyph2JI1DsV+tCN7yjrbSS2Bd0oGTM=
X-Google-Smtp-Source: AMrXdXvLZ3lL83czzvwL+KO2XuybCCIfYmIV8MTWvoiciSxpz5UsmJHpgcWwfcE04Mgb2yDYtt5NZn9sads=
X-Received: from jaewan.seo.corp.google.com ([2401:fa00:d:11:5c59:35ee:133d:ecaf])
 (user=jaewan job=sendgmr) by 2002:a25:b68c:0:b0:7b3:105b:ac90 with SMTP id
 s12-20020a25b68c000000b007b3105bac90mr2436916ybj.196.1673277303781; Mon, 09
 Jan 2023 07:15:03 -0800 (PST)
Date:   Tue, 10 Jan 2023 00:14:55 +0900
In-Reply-To: <20221227010034.1399587-1-jaewan@google.com>
Mime-Version: 1.0
References: <20221227010034.1399587-1-jaewan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109151455.325793-1-jaewan@google.com>
Subject: [PATCH v4] iw: info: fix bug reading preambles and bandwidths
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

Preambles and bandwidths values are considered as bit shifts
when they're are used for capabilities.

Signed-off-by: Jaewan Kim <jaewan@google.com>
---
 info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git info.c info.c
index eb257f8..5229d44 100644
--- info.c
+++ info.c
@@ -197,7 +197,7 @@ static void __print_ftm_capability(struct nlattr *ftm_capa)
 	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_PREAMBLES]) {
 #define PRINT_PREAMBLE(P, V) \
 	do { \
-		if (P | NL80211_PREAMBLE_##V) \
+		if (P & BIT(NL80211_PREAMBLE_##V)) \
 			printf(" " #V); \
 	} while (0)
 
@@ -215,7 +215,7 @@ static void __print_ftm_capability(struct nlattr *ftm_capa)
 	if (tb[NL80211_PMSR_FTM_CAPA_ATTR_BANDWIDTHS]) {
 #define PRINT_BANDWIDTH(B, V) \
 	do { \
-		if (B | NL80211_CHAN_WIDTH_##V) \
+		if (B & BIT(NL80211_CHAN_WIDTH_##V)) \
 			printf(" " #V); \
 	} while (0)
 
-- 
2.39.0.314.g84b9a713c41-goog

