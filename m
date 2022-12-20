Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8061A6521AE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 14:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiLTNrs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 08:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiLTNrp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 08:47:45 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C971A22D
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 05:47:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b5da1b3130so142185267b3.5
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcgDWqDheThjRXXFGj0gWh3czRr93SHptgyK9gwkHMs=;
        b=ZC0+SAETXBB3RZKWhpHbvJX7NhkHhCL7vhPQgpl0xkYEOcxseRdeg1DRJUq6yq5YHo
         H0WNAbV8DSn/6OPuNZTGmwKJfERguGtCfqHSyyHOPdfmwA/Lyx/opSVBomOXktorCev/
         x1AsisksBbg1XWv4OZbDzGPQghLLWqBhpGNyv3n9YtfmAQzeq+gsAhyINDxBNzyw2nY0
         0+qyqS+yH+eUOEClGL3KijmFFtwMB+h8CE8SglNEmXzVJiDmfjzcLJz0rDP5KGlxUC16
         GGWyPR9IrGIXX7R3NHG1UYn4ZawBytAuhUG2lUfZXg8xIkTXu0CepPQGYyCF+g9IJECW
         2D7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcgDWqDheThjRXXFGj0gWh3czRr93SHptgyK9gwkHMs=;
        b=s+X86A7eu/39GykrQrL3IYQ4/0JRzutdwQl84FHWvhKQbBHOqfkRVAIn2apQouYIHg
         OxL7RnRvms3m74cnoUtP4AeyoBjw1iqcW5pcp1FW+oV0M8MOGgOwoOhq6mZhnTXwdGkG
         HtM/vAWsbKVNvAjcyFDc4uHPfPW29KCn/L6qHStI5rwlgF19cSWmysi4JzmDQk2/Jv9j
         S6WLcpfRGPUiWDWt5QCuTEmjI1ogbH8L7o6SJRHOUa9EV4sp20bf2AvvhH3FAkDMY97L
         TKoKoEJ3SXf0okkGwSXhG6g0b79Cv/eJ6T/qOpW28KlNeEYgvUnRXr0/mQZbKLhZwzS8
         rAQw==
X-Gm-Message-State: ANoB5pn3oUtMzibLLDGRSBDcnlYUBLHKKFyacEVxLjLxucJNm+HqU/aF
        gahmAsuaIeQauKG4Wt6Z2zOMLG/sK5g=
X-Google-Smtp-Source: AA0mqf4uhNNTK4lK3stWE/fZpckCiEmSss6Ps+ZyNi1bT6E0nvASeUfEKB7pqIkYZzm1alJEec3ytjKxIDI=
X-Received: from jaewan.seo.corp.google.com ([2401:fa00:d:11:106a:a96e:332:fe4])
 (user=jaewan job=sendgmr) by 2002:a05:690c:386:b0:3ba:2984:8f75 with SMTP id
 bh6-20020a05690c038600b003ba29848f75mr4309030ywb.222.1671544060440; Tue, 20
 Dec 2022 05:47:40 -0800 (PST)
Date:   Tue, 20 Dec 2022 22:47:33 +0900
In-Reply-To: <20221220134233.2307164-1-jaewan@google.com>
Mime-Version: 1.0
References: <20221220134233.2307164-1-jaewan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220134733.2309329-1-jaewan@google.com>
Subject: [PATCH v2] iw: info: fix bug reading preamble and bandwidths
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

