Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470B135ACE9
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbhDJLUX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Apr 2021 07:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhDJLUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Apr 2021 07:20:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6373C061762
        for <linux-wireless@vger.kernel.org>; Sat, 10 Apr 2021 04:20:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e12so8050177wro.11
        for <linux-wireless@vger.kernel.org>; Sat, 10 Apr 2021 04:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNk4SAcoFIrAv/6JBtW/nm47KG5kv09NGIDqM5Ffj2o=;
        b=C1eddsIoHRarSTa0/4YP7UJVFW4tFw/CooKAyxaG8cC+tO5Ay6+sBCKGwGiV8btTcR
         pz5CBXGzNNSetzE7BIeQhaFa6pJ9ot8mVblGkm/9yUnMdd68iF+Eb3YjRsckAo8NVOEs
         Drb2/8PqU8sg4TbqMQd969VnYM/5YOmkbdH2YFtra4QFovyuaSxFOcUcxOyEZjKKIOk1
         XIg4q8pZK1EFUGWFxVS7JqV/EbZsmmdarr4SSJr+FTbjDGu39P4APUS3FaL2TNGzdqJF
         EVM+4sok9OpIbjwLzsXx9SaaYFvG4LyEo01z9RcjQ4An/bofBKKTlxbm24LAebYptETz
         Vc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNk4SAcoFIrAv/6JBtW/nm47KG5kv09NGIDqM5Ffj2o=;
        b=smF8CDegQo2lUwmCchwD+FMkth9F++z4x++YEE/vpxRrS4fHRatPl1CY0PcO0visp5
         9mRpT9a2RBttYuf17CwJyojqoedAgGuZtlW/V/J2paAEszW2LNNcLLg2BHrIucXgLiOC
         lIfeE2CYcmVoX62A2yO74bOVAqRxiN4PxeOgCZ2gjVSfB4YZSTjqSi6Gg7V+Qz7/500+
         RlZofE3FJpzXRDyG4igxo4LEHOyFkbP8AchYZ2cc9ZaAb6Np9/BDU1KfOl8Uz5zNTYbr
         rT9XUbKh3rvwCwrzlOUrxcOubniRmuDoSpiecQHteS1ryyw5ubKxwVaqUU/bYiGt+RQQ
         u7Rg==
X-Gm-Message-State: AOAM530kJU9Xa9Vnl69jQNVsMfbD0FxNEnM7kVzzBNuBnuFIfyzE6DGc
        ivJRYnkboabWPy7FgA7aXto=
X-Google-Smtp-Source: ABdhPJxGJRnNR265Hb0n9mTCdrmDoyWqystZxk3bKnFpMQCAkMRTqUc/pvU0mtUNUQJsPH9PgXnp4g==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr22053565wrx.306.1618053606741;
        Sat, 10 Apr 2021 04:20:06 -0700 (PDT)
Received: from paula-ultrabook.fritz.box (dynamic-2a01-0c22-a41a-e200-35a1-ce2e-1cf4-ff60.c22.pool.telefonica.de. [2a01:c22:a41a:e200:35a1:ce2e:1cf4:ff60])
        by smtp.gmail.com with ESMTPSA id j123sm7545118wmb.1.2021.04.10.04.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:20:06 -0700 (PDT)
From:   Benjamin Aschenbrenner <benjamin.aschenbrenner@gmail.com>
To:     johannes@sipsolutions.net
Cc:     benjamin.aschenbrenner@gmail.com, linux-wireless@vger.kernel.org
Subject: [PATCH v2 2/2] iw: fix ftm_request missing arguments segfault
Date:   Sat, 10 Apr 2021 13:19:37 +0200
Message-Id: <20210410111937.32813-2-benjamin.aschenbrenner@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210410111937.32813-1-benjamin.aschenbrenner@gmail.com>
References: <20210410111937.32813-1-benjamin.aschenbrenner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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
@@ -282,6 +282,9 @@ static int handle_ftm_req_send(struct nl80211_state *state, struct nl_msg *msg,
 	const char *file;
 	int err;
 
+	if (argc < 1)
+		return HANDLER_RET_USAGE;
+
 	file = argv[0];
 	argc--;
 	argv++;
-- 
2.30.2

