Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75505788FD4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 22:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjHYU0n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjHYU0R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 16:26:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498181BE6
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 13:26:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5009d4a4897so1997994e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 13:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692995173; x=1693599973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xaM+n+aR2UDKZm7iUT7Gwvf5Tkj3K+ENTupiFy9EIRM=;
        b=d+6hXyfJgp8FYokh0gN/o+8H/Ee5pknYUTber0r6DT528COCq9eOW9kcWGXq+nzMhp
         Ww/cKDdjj5io9Q+Y9ycxvOXRDW4tIOwHe5CzrKtvSJKhmiM5s7JDe4b1LU+UnnL/x0wf
         7iRGGWJHUrE9aEQjBu+nivWQQH2UioGGvqlxFeyaYPtQXEg386jCSgOzz0FpgiXNeXu7
         uLRF49iYzhYRPOZ9dAaWo/OulR7XPo+EoSHzzbeouFZi/wa1VGuD29WB3JyX/EitOaVU
         20+XJ5R+/9p0874Wsao8RxXhCrBsF/rAaIeXtYoTl5zFGCB2vBntt1Frtml9Ai+Heqfh
         k2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692995173; x=1693599973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaM+n+aR2UDKZm7iUT7Gwvf5Tkj3K+ENTupiFy9EIRM=;
        b=Th9KQXflEdt+aDhY+MxXT9hQJFUcCYEvykZL3JtO7hAhkivzw6g9TRespnSHYw5T/q
         yE9vikUV0S4blG6OASoneWa2Ej+uDItsVJdVh71HLG3QG423ua4bmaHR67Idbe6lt8Y6
         4HQa+MhXWkbkvnlQPn5Y1N9giDI7m7zl+BbXV/Gnqmy8hGA2ZcgFM30OkGGsUA1lu8q2
         nhn1AqmIeltQDymczdcpq7oh0fMXYc/K3/reqaXg9seCjxkpTpE+pp/HPddiHZCspC6F
         4fOGM+rU4bmX0bMALXUMbba6sV4Q/l/NeSAM41t8EgDzIzo+/UnUhPB0mI9owFOT2qDw
         VDVg==
X-Gm-Message-State: AOJu0YxoAuctgrtXtXrZrcM0R2rJSdDISxF8MN5jBosMmyyRaGKcZftI
        If85ecJ7E2Lqi/S3phVx9CoVtg==
X-Google-Smtp-Source: AGHT+IHZWQsa/eM+b5ORUmm3jdem8a1l1zQoP4lM0kndRlNsDKQy0J1qYugkxq0XETuiLLIQcirrIw==
X-Received: by 2002:a05:6512:10d6:b0:4fb:744e:17db with SMTP id k22-20020a05651210d600b004fb744e17dbmr16923065lfg.1.1692995172974;
        Fri, 25 Aug 2023 13:26:12 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id eq8-20020a056512488800b004fe4aef5b18sm410359lfb.164.2023.08.25.13.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:26:11 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] wifi: ath10k: Default to board.bin for legacy board data file
Date:   Fri, 25 Aug 2023 23:26:10 +0300
Message-Id: <20230825202610.1580132-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Default to 'board.bin' for the legacy board data file, in case the
hw_params array doesn't list hw-specific board data file name (e.g. for
WCN3990).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6cdb225b7eac..806e5968e0ef 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -1271,11 +1271,6 @@ static int ath10k_core_fetch_board_data_api_1(struct ath10k *ar, int bd_ie_type)
 	char boardname[100];
 
 	if (bd_ie_type == ATH10K_BD_IE_BOARD) {
-		if (!ar->hw_params.fw.board) {
-			ath10k_err(ar, "failed to find board file fw entry\n");
-			return -EINVAL;
-		}
-
 		scnprintf(boardname, sizeof(boardname), "board-%s-%s.bin",
 			  ath10k_bus_str(ar->hif.bus), dev_name(ar->dev));
 
@@ -1285,7 +1280,8 @@ static int ath10k_core_fetch_board_data_api_1(struct ath10k *ar, int bd_ie_type)
 		if (IS_ERR(ar->normal_mode_fw.board)) {
 			fw = ath10k_fetch_fw_file(ar,
 						  ar->hw_params.fw.dir,
-						  ar->hw_params.fw.board);
+						  ar->hw_params.fw.board ?:
+						  "board.bin");
 			ar->normal_mode_fw.board = fw;
 		}
 
-- 
2.39.2

