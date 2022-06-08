Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76EDF543A34
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 19:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiFHRY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 13:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiFHRYP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 13:24:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C39CCE13
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 10:17:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so34223462lfa.6
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jun 2022 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpjl51ad3OaV2kJ/1acaT/For92q++jfArA2A/2WOtM=;
        b=N/yMTENlBF8+Zhl/eoc9KcY0gfHscZmwdCWiZr7Pt37e7+2TzUMZoTdgSCfZBWC/W4
         KBLCU8a9TBqqAy9QWS6yItziBwmdTjFk7fAFPyUE7nWl8a2vxH/eImaTGpJzwCw76FZZ
         RGgSnqg3PCTI7YcqixFnp9bSHEuuS4naZr3RdpKvi5ahqne0qBL1ewxiEjTQWvORZz60
         FMyyUXz9yvRaahzaeBiVCUfYXxyRzLIIz5t7DAmh0Wt6+FYDXxCLGxzMRfaGFEepmmgH
         9hJahu5pN0Rd5wFXkYnOeI3QS94iblQtIzYIqnQPBUqi/eylCiSqH04yw1MCczi+PlDo
         8lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qpjl51ad3OaV2kJ/1acaT/For92q++jfArA2A/2WOtM=;
        b=Y42ABEyGX+zjqq0fxkzoOi+Cszvy3BCXmWkLnI2u1itZJooLjNAoz5l2PYxhHIjyZW
         /BkJXNMJ0q3hfK5F/SIrEB558oLfJL1xMOLhae9KukPs4x6oSGw+4rPHMd636OJsku7V
         3029TuXi+mx2U0+m3QDahSI1U3Fuid2bcjtfVNG6l5NnOpFHPql5dwJ9f3V3wZrO8/8m
         J07lHOjzh+pL3IQuO2wPk6WYyMQnHqo671lWZl3g8m+A3nsGl7A1e/rZDfiPE3Dk2zo+
         dLXTuN/X3ma1YGmbTcxMK74Ec2uvUvDQNe58GujJ10q0y+G1CP6gfgE6KvQznmaNsC+u
         fC5A==
X-Gm-Message-State: AOAM531diFbmRuhhG5FMEAh3WlQ/iBaIjWdknP7hY2JeDslOOUXFHWSd
        zGoWsSrKh4mjpA+XZgWpg1VS9OfCNdtB
X-Google-Smtp-Source: ABdhPJyV3PgiJcCmJExS0tQ/dN4TKzSZKz+OlgxQDRCbuIIrWUZg6F/IOMvhIwhntJKkvHMwlDj+Tg==
X-Received: by 2002:ac2:4e6c:0:b0:477:b6c7:25fd with SMTP id y12-20020ac24e6c000000b00477b6c725fdmr22237561lfs.240.1654708654452;
        Wed, 08 Jun 2022 10:17:34 -0700 (PDT)
Received: from localhost.localdomain ([95.161.223.113])
        by smtp.gmail.com with ESMTPSA id f23-20020ac25097000000b004793b9c2c12sm1621085lfm.124.2022.06.08.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 10:17:33 -0700 (PDT)
From:   Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To:     linux-wireless@vger.kernel.org
Cc:     Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH] iwlegacy: 4965: fix potential off-by-one overflow in il4965_rs_fill_link_cmd()
Date:   Wed,  8 Jun 2022 20:16:14 +0300
Message-Id: <20220608171614.28891-1-aleksei.kodanev@bell-sw.com>
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

As a result of the execution of the inner while loop, the value
of 'idx' can be equal to LINK_QUAL_MAX_RETRY_NUM. However, this
is not checked after the loop and 'idx' is used to write the
LINK_QUAL_MAX_RETRY_NUM size array 'lq_cmd->rs_table[idx]' below
in the outer loop.

The fix is to check the new value of 'idx' inside the nested loop,
and break both loops if index equals the size. Checking it at the
start is now pointless, so let's remove it.

Detected using the static analysis tool - Svace.
Fixes: be663ab67077 ("iwlwifi: split the drivers for agn and legacy devices 3945/4965")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/net/wireless/intel/iwlegacy/4965-rs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 9dd2d890e35f..c62f299b9e0a 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -2403,7 +2403,7 @@ il4965_rs_fill_link_cmd(struct il_priv *il, struct il_lq_sta *lq_sta,
 		/* Repeat initial/next rate.
 		 * For legacy IL_NUMBER_TRY == 1, this loop will not execute.
 		 * For HT IL_HT_NUMBER_TRY == 3, this executes twice. */
-		while (repeat_rate > 0 && idx < LINK_QUAL_MAX_RETRY_NUM) {
+		while (repeat_rate > 0) {
 			if (is_legacy(tbl_type.lq_type)) {
 				if (ant_toggle_cnt < NUM_TRY_BEFORE_ANT_TOGGLE)
 					ant_toggle_cnt++;
@@ -2422,6 +2422,8 @@ il4965_rs_fill_link_cmd(struct il_priv *il, struct il_lq_sta *lq_sta,
 			    cpu_to_le32(new_rate);
 			repeat_rate--;
 			idx++;
+			if (idx >= LINK_QUAL_MAX_RETRY_NUM)
+				goto out;
 		}
 
 		il4965_rs_get_tbl_info_from_mcs(new_rate, lq_sta->band,
@@ -2466,6 +2468,7 @@ il4965_rs_fill_link_cmd(struct il_priv *il, struct il_lq_sta *lq_sta,
 		repeat_rate--;
 	}
 
+out:
 	lq_cmd->agg_params.agg_frame_cnt_limit = LINK_QUAL_AGG_FRAME_LIMIT_DEF;
 	lq_cmd->agg_params.agg_dis_start_th = LINK_QUAL_AGG_DISABLE_START_DEF;
 
-- 
2.25.1

