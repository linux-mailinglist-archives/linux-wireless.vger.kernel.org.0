Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90865665F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiL0BJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Dec 2022 20:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiL0BI7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Dec 2022 20:08:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7521B2
        for <linux-wireless@vger.kernel.org>; Mon, 26 Dec 2022 17:08:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y66-20020a25c845000000b00733b5049b6fso13090582ybf.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Dec 2022 17:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSKHTQgZwAQVzHTWysu9ex9mSD6XR3P2ALxQ/CwbTU0=;
        b=P+E12Re73EyAMSrWj/JbR2XI2Y1f7eotV2BhQQs4sArAqkppwSTrKcqXDkXEHeJDJt
         d/Mr+qa/WOoHh4I7fsm3jryx+Wbgsodrot409vYQjBPuwbGcyL4rP6i0PFPyzNUC4pN0
         7fQMuTQS2PXrD5LvlqPLHiCcVeem9wJHTDDjYFyKUafFG7yqg6yv5lRzFcB+vVVueXDZ
         QqN9PCiGvye+MmaN/axaWSXNoEco0fZohUWwo4MyOm0hMdOayJXiaLyVCSTbj5YjIcF1
         ek8tfEUk75yY74FFxuCzqcQxiEfYgpK05yYvXfsB3l50mTQO5pAhWNXQJQP0yCV8Owv4
         9U0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSKHTQgZwAQVzHTWysu9ex9mSD6XR3P2ALxQ/CwbTU0=;
        b=HIydNremSCOyY96l+56bxbdmiULc3qajTBXSIzXrUer3n5yf68z2RJMPae7LagT0u/
         jW2ShFzt07KBPlRD+0+C/PkGtBHUJkbvy7DLWH1PPqSMs9X7lbgZ+ukZzAtj0i+wvCZk
         gq1PVnv5BojY7/R6bYuW5mTBEaJcS3LtKMD1j75r6ZiSy3L9bbudBt0eolxh1TMkaKwB
         JWkHxxtc8tWrYs1A0z1fftoBtZD/YPuCnGuMH/TJ/JRhxLjtU5ddlP+XUU2AV2RjSWIL
         Wij1Ty00hPya9gZiM+YAKkHrzTdW6GxPXyjvy03OQ/IG2IyR46feDd7MVksf9Z7biQDP
         t/wg==
X-Gm-Message-State: AFqh2koAtqo4XnGn2H4GhbfSvE79QIDalNr55D0tBEHBvuqG85VBCXay
        MdbbRv6xvWSBAn5A2bPKUPMlp5H5tho=
X-Google-Smtp-Source: AMrXdXvR3dQlaMOPSn2kk7KSQrz5NdY1R11aSTtVzA2Ny2WZRXahNolqb5XHsvuQOcO95cls2TnPGos++z0=
X-Received: from jaewan.seo.corp.google.com ([2401:fa00:d:11:6115:d386:ab9b:f146])
 (user=jaewan job=sendgmr) by 2002:a25:d80d:0:b0:77f:a797:27f6 with SMTP id
 p13-20020a25d80d000000b0077fa79727f6mr522980ybg.70.1672103337237; Mon, 26 Dec
 2022 17:08:57 -0800 (PST)
Date:   Tue, 27 Dec 2022 10:00:34 +0900
In-Reply-To: <20221220134733.2309329-1-jaewan@google.com>
Mime-Version: 1.0
References: <20221220134733.2309329-1-jaewan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221227010034.1399587-1-jaewan@google.com>
Subject: [PATCH v3] iw: info: fix bug reading preambles and bandwidths
From:   Jaewan Kim <jaewan@google.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Jaewan Kim <jaewan@google.com>,
        Kalle Valo <kvalo@kernel.org>
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
Reviewed-by: Kalle Valo <kvalo@kernel.org>
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

