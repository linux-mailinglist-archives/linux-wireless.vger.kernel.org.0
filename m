Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7A34484A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Mar 2021 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhCVOzo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Mar 2021 10:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCVOzc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Mar 2021 10:55:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C896C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 07:55:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d10so8315007ils.5
        for <linux-wireless@vger.kernel.org>; Mon, 22 Mar 2021 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NkJHhEPuDaKXUGRD/9F779JBbJEyfcdNzitG5OgY/kk=;
        b=H/BFoGrSo4BxXK/BMfwXxHdVzTgE+RX8T9zI6iBVtXwNDC1QmPE0xk+5R/e5kBqEsO
         rajIc2LCemHx/8K4AS76ZTmKfr2DVXUwECtinUFm6k81LCuUKQZd4DzUbqeHdixgdBNQ
         1IfcukXJVpVDNe6DqEau47u/ECxefy+DZYxb47t17iw0pS3p6fubMNmszAWzZCOQaTPV
         TdLE5Zq3H0mD0lXsD9EU4xMbG5A5BogMZVsHa67b3LF4e0pakndi1rdV2/Upg16W2qiU
         U86Nd4DLdB1kWT1IUyYX2B8ZPLlpIJnVhbu4/A/qczvsmpt2z9XFcXmnzP2os+bukMGd
         gbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NkJHhEPuDaKXUGRD/9F779JBbJEyfcdNzitG5OgY/kk=;
        b=PWAAsG55gH/aPf7s1FfRg7kcLn59rncaFAvzXEfYiVO8/6iXXM7kuuSf6F72ByL2FF
         Cdqs6xUYlDCXZxoqbpc1o9W6JGsR+lEft8Nzk0vzwfeOMlWg1SfXa3eMzb7Wn1yjsxw5
         +5bOVY/vsLbwXavBwn6IMP3qFTa/Eh/tjc8ku7OcBdaq//WbW5NxL9Qw/L7M5HRclhaS
         Sub1yxdDdeESr9n0Dhe7M5mSVb76Le8JqLzHNB6mhnd8N4JCl5emJmiFpxixFODROB3H
         OnvWAx7FuZBBQ00BsoZ2eiWRevojRqosYSmpSd8XIYeHoEffGa45eoDl4IIGW1kgOFQQ
         InQA==
X-Gm-Message-State: AOAM530vMYO52mCmtfpv0ullalfE6wLiMWI6emUHqm82WR7gqbidNujF
        HCWITwdEGXhJWsFOp+oOVe+AfWMEhS+rc2WQnaY2ODdKMFg=
X-Google-Smtp-Source: ABdhPJzY8VxLL2G1zWYYSm2CrhO/GnqNWuUDRAOTxlpsu+kJZgiTjj7p+JdHZw1VdL4jsQAiD0aI4ghVWUPp2JjZO/8=
X-Received: by 2002:a05:6e02:1baf:: with SMTP id n15mr369554ili.190.1616424931581;
 Mon, 22 Mar 2021 07:55:31 -0700 (PDT)
MIME-Version: 1.0
From:   Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
Date:   Mon, 22 Mar 2021 15:55:20 +0100
Message-ID: <CAASiZWagFdx+5Nfq383zgJkMcL_T_hqVeWTgPx2ej8J6U=DfLQ@mail.gmail.com>
Subject: [PATCH 2/2] iw: fix ftm_request missing arguments segfault
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
Date: Mon, 22 Mar 2021 15:19:00 +0100
Subject: [PATCH 2/2] iw: fix ftm_request missing arguments segfault

When expected argument <config-file> is not passed to arguemts iw
segfaults.

Example: iw wlp2s0 measurement ftm_request

This fixes it.

Signed-off-by: Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
---
 measurements.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/measurements.c b/measurements.c
index 635d942..80fe785 100644
--- a/measurements.c
+++ b/measurements.c
@@ -282,6 +282,9 @@ static int handle_ftm_req_send(struct
nl80211_state *state, struct nl_msg *msg,
     const char *file;
     int err;

+    if (argc < 1)
+        return HANDLER_RET_USAGE;
+
     file = argv[0];
     argc--;
     argv++;
-- 
2.30.2
