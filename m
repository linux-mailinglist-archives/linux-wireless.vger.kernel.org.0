Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE163252A7F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgHZJkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgHZJeY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F728C0617A0
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u18so1074391wmc.3
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oekAdSRdWeQGb7KHnNCwUm4X9s+jdekjgVn8syGtQMg=;
        b=g4XtCs3dFNDuVsKSQJBUwGxM1zqKaMl9GznNvdQ8VL3/b1U5zLzI6WrjAe2SuR0sZD
         oRxiJXmRQILu7EVorZuvPBDgGRVy7dCUO671Trm+oHmwuMY2a9lJ+0yOTBxFEA5fjID3
         uDVKgDV1pTedgO+RkNAGJuTNckTG2AuQvwPE1PBWJVo6TnkjGyw27FQZd0ySwr4vtH0M
         qjymyE86k6OCWULBDmokPuptRPB2KEUWNXYraMZ/v2oinOA3I2FDy0FBNnvxTf2rUvOC
         lu9JGW6ip3oqI2GflDtj5wfdhBbDU8KLFdZFSkYO4xN9I2b/JPUWEyyMKOlD7XNoNUk1
         +O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oekAdSRdWeQGb7KHnNCwUm4X9s+jdekjgVn8syGtQMg=;
        b=BYWoXRXoS6qS0LxJXttHVf5OVzqkdvGMYfHuNLWe+hgdNz5NMNoY78QXhjK1kpOcyN
         W2+PB8fnRQLAx6h+GufdkHtRsb4aiZ+Jnfx6zKmkm94UolP+lnufc7iPEfTotvwL+LsM
         WOXst0f94Jj0JF+mSXhEP2e+P7b88u6ANoZcwdsrFOZ0q9JSdl+7e4Y8oav2DUqXaaCH
         1dhVYBbVq2oXkqqOPcFIBRrliI+pfQfjLUxbxKYtHYe7zUIJ/H8dYDz0/R4xvPRnIbGJ
         DR4wdWD1DdRvyQvbqwg3vFZTWRaMCaYVaa8abSeCJLn797aPLzCR5jS1vn2ysbGk+lNF
         7dIw==
X-Gm-Message-State: AOAM531d5xNto62WkLAn7fyoEKZpGGk/3nFtQPNCl4rFoOqa++fHSX+8
        c8bKeaeIJKx9vyT0aLVJl1hfwQ==
X-Google-Smtp-Source: ABdhPJxSS5yizMJPiOg4v6ECqERxKvdiXFPf9b0px+G5lq6uX4AR6sqMgBcF4cbHJgHX/Xu4ay8IUA==
X-Received: by 2002:a1c:dd85:: with SMTP id u127mr6530261wmg.65.1598434449691;
        Wed, 26 Aug 2020 02:34:09 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Linux Wireless <ilw@linux.intel.com>
Subject: [PATCH 04/30] wireless: intel: iwlegacy: 3945-rs: Remove all non-conformant kernel-doc headers
Date:   Wed, 26 Aug 2020 10:33:35 +0100
Message-Id: <20200826093401.1458456-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/intel/iwlegacy/3945-rs.c:136: warning: Function parameter or member 'rs_sta' not described in 'il3945_rate_scale_flush_wins'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:243: warning: Function parameter or member 'rs_sta' not described in 'il3945_collect_tx_data'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:243: warning: Function parameter or member 'win' not described in 'il3945_collect_tx_data'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:243: warning: Function parameter or member 'success' not described in 'il3945_collect_tx_data'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:243: warning: Function parameter or member 'retries' not described in 'il3945_collect_tx_data'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:243: warning: Function parameter or member 'idx' not described in 'il3945_collect_tx_data'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:429: warning: Function parameter or member 'il_rate' not described in 'il3945_rs_tx_status'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:429: warning: Function parameter or member 'sband' not described in 'il3945_rs_tx_status'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:429: warning: Function parameter or member 'sta' not described in 'il3945_rs_tx_status'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:429: warning: Function parameter or member 'il_sta' not described in 'il3945_rs_tx_status'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:429: warning: Function parameter or member 'skb' not described in 'il3945_rs_tx_status'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:606: warning: Function parameter or member 'il_r' not described in 'il3945_rs_get_rate'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:606: warning: Function parameter or member 'sta' not described in 'il3945_rs_get_rate'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:606: warning: Function parameter or member 'il_sta' not described in 'il3945_rs_get_rate'
 drivers/net/wireless/intel/iwlegacy/3945-rs.c:606: warning: Function parameter or member 'txrc' not described in 'il3945_rs_get_rate'

Cc: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Wireless <ilw@linux.intel.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/intel/iwlegacy/3945-rs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
index 0af9e997c9f67..b2478cbe558e6 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
@@ -124,7 +124,7 @@ il3945_clear_win(struct il3945_rate_scale_data *win)
 	win->stamp = 0;
 }
 
-/**
+/*
  * il3945_rate_scale_flush_wins - flush out the rate scale wins
  *
  * Returns the number of wins that have gathered data but were
@@ -229,7 +229,7 @@ il3945_bg_rate_scale_flush(struct timer_list *t)
 	D_RATE("leave\n");
 }
 
-/**
+/*
  * il3945_collect_tx_data - Update the success/failure sliding win
  *
  * We keep a sliding win of the last 64 packets transmitted
@@ -416,7 +416,7 @@ il3945_rs_free_sta(void *il_priv, struct ieee80211_sta *sta, void *il_sta)
 	del_timer_sync(&rs_sta->rate_scale_flush);
 }
 
-/**
+/*
  * il3945_rs_tx_status - Update rate control values based on Tx results
  *
  * NOTE: Uses il_priv->retry_rate for the # of retries attempted by
@@ -584,7 +584,7 @@ il3945_get_adjacent_rate(struct il3945_rs_sta *rs_sta, u8 idx, u16 rate_mask,
 	return (high << 8) | low;
 }
 
-/**
+/*
  * il3945_rs_get_rate - find the rate for the requested packet
  *
  * Returns the ieee80211_rate structure allocated by the driver.
-- 
2.25.1

