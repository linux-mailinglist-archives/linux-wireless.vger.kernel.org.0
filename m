Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2999B4BE386
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357928AbiBUM0x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 07:26:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357897AbiBUM0w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 07:26:52 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B9313E22
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 04:26:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c6so26215892edk.12
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 04:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXtFK9XIWdkXWHWTAWeRWZH7ZkcOfy+R1WHS0XSQvFY=;
        b=qdtUwIxZq6krEOxRrY6aH4UnuIHbE0uKsTU6XOt67NwnQBohbqH53jUZZjGy4f4C7L
         TwU7r0jtKyeyOfHt0sN8wyCC8GeqjE5OEaPsLha6H/z1SqIwYMSObdoekdCxeJL+zRuQ
         h3Hej11KDvauh8xp4WVh9zlpJauClSPAjFS/ZNJC+D8CwluPPftHqbIa+cFhrcUpw5ET
         duzKoGUfqGKEaxHDvg1UgRF4AQ6WfP7hIX8pM8o2hg/u8KMedoOwIV2svzHFwp4KGU9o
         v9UNBfgHssuW5SE6q95ZhNZNrtck108hU3OL/I21ue6lX9/rKo0fdgRpBFoY3eP11iPY
         v9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXtFK9XIWdkXWHWTAWeRWZH7ZkcOfy+R1WHS0XSQvFY=;
        b=c+QgF6R9q0b2cvJdsLVqeA0/IxSbSDnXTwRVLo8Q2pb7gUr0es5KIYMcjNefmmL4LS
         54e1zhEs9ud6ZnPSStneuc4muGhGj6YCL++gfZysK8+rJA7dcI8+s64TyYyTWu2C7/HU
         njOLa05y1Q79P4UkuXwWhzNiPDwKvLLZjXiy8uYLFgKn6TIkBL6rPj1igpxHJee5FDrZ
         dkg44krsushue3yaROh75R04BEorVqJXnH28ZjsE29IGPOkuh7BD/80tczMLAnyII4Nn
         Y/s9ORPqE7u67Y9j//ypE5e1gtvhAyDTFIDCJTU2HVcaOA/G4ygyrsj6Xq8Tgu/DoGSd
         +7pA==
X-Gm-Message-State: AOAM532xBG9gPBdYnzI1cUXluPFNbPQ492XZCPTCheSBymdrDZqXQ848
        DI6Pg4w+GXyzwW8BwR+L9Ec=
X-Google-Smtp-Source: ABdhPJyS1HuFg/g1gO0muNEi+yK1UaqwaM4CiNTxSlM1/FdKMzuVfJMST5j7OdXRaWrM71VppzevGQ==
X-Received: by 2002:a05:6402:270a:b0:410:63d:a66d with SMTP id y10-20020a056402270a00b00410063da66dmr21293487edd.48.1645446387711;
        Mon, 21 Feb 2022 04:26:27 -0800 (PST)
Received: from picci.homenet.telecomitalia.it (host-87-17-90-61.retail.telecomitalia.it. [87.17.90.61])
        by smtp.gmail.com with ESMTPSA id d18sm5115236ejd.95.2022.02.21.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 04:26:27 -0800 (PST)
From:   Francesco Magliocca <franciman12@gmail.com>
To:     ath10k@lists.infradead.org
Cc:     dan.carpenter@oracle.com, rmanohar@qti.qualcomm.com,
        linux-wireless@vger.kernel.org,
        Francesco Magliocca <franciman12@gmail.com>
Subject: [PATCH v2] ath10k: fix pointer arithmetic error in trace call
Date:   Mon, 21 Feb 2022 13:26:38 +0100
Message-Id: <20220221122638.7971-1-franciman12@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reading through the commit history, it looks like
there is no special need why we must skip the first 4 bytes
in this trace call:

trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),
			 hw->rx_desc_ops->rx_desc_size - sizeof(u32));

found in the function ath10k_htt_rx_amsdu_pop in the file htt_rx.c

i think the original author
(who is also the one who added rx_desc tracing capabilities
in a0883cf7e75a) just wanted to trace the rx_desc contents,
ignoring the fw_rx_desc_base info field
(which is the part being skipped over).
But the trace_ath10k_htt_rx_desc later added
don't care about skipping it, so it may be good
to uniform this call to the others in the file.
But this would change the output of the trace and
thus it may be a problem for tools that rely on it.
Therefore I propose until further discussion
to just keep it as it is and just fix the pointer arithmetic bug.

Add missing void* cast to rx descriptor pointer in order to
properly skip the initial 4 bytes of the rx descriptor
when passing it to trace_ath10k_htt_rx_desc trace function.

This fixes the pointer arithmetic error detected
by Dan Carpenter's static analysis tool.

Fixes: 6bae9de622d3 ("ath10k: abstract htt_rx_desc structure")

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1

Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
Link: https://lore.kernel.org/ath10k/20220201130900.GD22458@kili/
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 9ad64ca84beb..e01efcd2ce06 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -429,7 +429,7 @@ static int ath10k_htt_rx_amsdu_pop(struct ath10k_htt *htt,
 				RX_MSDU_END_INFO0_LAST_MSDU;
 
 		/* FIXME: why are we skipping the first part of the rx_desc? */
-		trace_ath10k_htt_rx_desc(ar, rx_desc + sizeof(u32),
+		trace_ath10k_htt_rx_desc(ar, (void*)rx_desc + sizeof(u32),
 					 hw->rx_desc_ops->rx_desc_size - sizeof(u32));
 
 		if (last_msdu)
-- 
2.35.1

