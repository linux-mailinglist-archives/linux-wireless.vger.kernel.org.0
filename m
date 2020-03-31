Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B76C19A279
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 01:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgCaX2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Mar 2020 19:28:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40688 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731331AbgCaX2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Mar 2020 19:28:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so8775852plk.7
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2020 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Z8cmhwuoJ6u8AGRS/dfIKVisxO68J07MsOpXpZDmdM=;
        b=JUYNbgTpWax7Ku6wOjJuqQJJYZTVA/HreTkJ69PConpbyyAeU3V71ZNQab7NA5TIpf
         cmkjrHFeq182quUPpJjTKKlPfMjo507RgbfR8fXfXvWazK+et/8RgN4z73vrFmzhdiSA
         Grl+iuRqZ2CMr3nQnvQ8AbzX5LptRuW245U/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Z8cmhwuoJ6u8AGRS/dfIKVisxO68J07MsOpXpZDmdM=;
        b=h61Z1rwc2JP+MIuShylq7k6AFCoyZ6djNqzKnYKjuN6WqSes5aQ7Kr16K0TqxPJ3/h
         J+QxLe8Y26EVMhpXKYlUXhI2XtJzNy39yd8FsXH6hE9yRm69+gzjWXyDu63S2RSxaHch
         p9Pa2dh3MAkqXEDAyyTYxxhoh4KsuONNNK4dqNh1qvEUelEtWkJc0tEsy8qTSYx/FPFY
         0fwBGQGFKRwXDRrg0OP+vgRITQ+tMQIbLmilh1XLTjn1n78DeTZFVmbcGX59A+JF32Qg
         bYdV/QgMEcQfKdeLvtx4s0KwB61fMXpmH8EAbjRe/hCw7mKIwel7/pBxABEacBFX0vIk
         00lQ==
X-Gm-Message-State: ANhLgQ1ofzs5EwUmv7U9GyVg1HlpUO+LQ/r0Y1m38f/GrJI0ZObIy8xE
        gRJeW+PEDHZaPyIldM21bdhmuQ==
X-Google-Smtp-Source: ADFU+vs3eNiEE5RHfj6QE+2GjQj/xvk59auQXexJGGvRINiyVJE9gTmIokldfeJ5umXf0U2vsT8klQ==
X-Received: by 2002:a17:902:562:: with SMTP id 89mr19231902plf.249.1585697325427;
        Tue, 31 Mar 2020 16:28:45 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id r70sm185395pfr.116.2020.03.31.16.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 16:28:44 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] iw: 'phy <name> reg get' shouldn't dump all domains
Date:   Tue, 31 Mar 2020 16:28:33 -0700
Message-Id: <20200331232833.142026-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Right now, 'iw phy ... reg get' gets translated to NLM_F_DUMP, which
dumps all domains. But this command really is looking for non-DUMP
semantics -- it only wants the domain for the specified wiphy, or (per
the kernel's choice) the global, if the wiphy doesn't have its own.

We can achieve this by skipping the handle_reg_get() -> "reg dump"
indirection.

[ with a wiphy-specific domain ]
Before:
  # iw phy phy0 reg get
  global
  country XX: DFS-YYY
  [...]
  phy#0
  country AA: DFS-BBB
  [...]

After:
  # iw phy phy0 reg get
  phy#0
  country AA: DFS-BBB
  [...]

[ without a wiphy-specific domain ]
Before and after (unchanged):
  # iw phy phy0 reg get
  global
  country XX: DFS-YYY
  [...]

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reg.c b/reg.c
index db1b12906519..3dc4b0eec679 100644
--- a/reg.c
+++ b/reg.c
@@ -256,7 +256,7 @@ static int handle_reg_get(struct nl80211_state *state,
 }
 COMMAND(reg, get, NULL, NL80211_CMD_GET_REG, 0, CIB_NONE, handle_reg_get,
 	"Print out the kernel's current regulatory domain information.");
-COMMAND(reg, get, NULL, NL80211_CMD_GET_REG, 0, CIB_PHY, handle_reg_get,
+COMMAND(reg, get, NULL, NL80211_CMD_GET_REG, 0, CIB_PHY, handle_reg_dump,
 	"Print out the devices' current regulatory domain information.");
 HIDDEN(reg, dump, NULL, NL80211_CMD_GET_REG, NLM_F_DUMP, CIB_NONE,
        handle_reg_dump);
-- 
2.26.0.rc2.310.g2932bb562d-goog

