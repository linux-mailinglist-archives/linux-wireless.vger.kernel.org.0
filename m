Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E04D5152A5
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379353AbiD2RuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 13:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379338AbiD2RuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 13:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C91388B0B
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 10:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCA52623CF
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 17:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A832C385B0;
        Fri, 29 Apr 2022 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254410;
        bh=4mwK6qWdAhd6G6Sj+v3rf9e/RqWjjC7elnY1zmzB6vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvlqVZx23VRqSjP1UIEma4IGq/yoTQk7Wsf8BsDP1NiZB84XNEK2am3NKKU3jcxDe
         awsyyNkQm0Fz4UK+OkGN+9R3p4YmknmL25XrWox6Cxw6liNTdE+XGDg9uJtEZven5N
         3FjM185ekNdu/8TRw4zUG9OqrRTsUKQo4DB0eyZHtD0amTK1fHy0pxXcHCmJRIHkyz
         FQg7GyMkcGRs6Wkj5TCd8T5X07KNasHKV5Y7ZU3KqgC6rGjAxM5R/rPqe4F66XAlhY
         1qTP0FrA2Ax2iEu8T7Wf8NXuRPTo9cVidfxTn8PXaZFfNjhq9fYZhPWKlaeamIY8cb
         FxCXzKPvxHJiw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        tony0620emma@gmail.com
Subject: [PATCH wireless-next 1/3] wifi: rtw88: remove a copy of the NAPI_POLL_WEIGHT define
Date:   Fri, 29 Apr 2022 10:46:41 -0700
Message-Id: <20220429174643.196994-2-kuba@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429174643.196994-1-kuba@kernel.org>
References: <20220429174643.196994-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Defining local versions of NAPI_POLL_WEIGHT with the same
values in the drivers just makes refactoring harder.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: tony0620emma@gmail.com
CC: kvalo@kernel.org
CC: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/realtek/rtw88/main.h | 1 -
 drivers/net/wireless/realtek/rtw88/pci.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 17815af9dd4e..2019c908fd5f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -17,7 +17,6 @@
 
 #include "util.h"
 
-#define RTW_NAPI_WEIGHT_NUM		64
 #define RTW_MAX_MAC_ID_NUM		32
 #define RTW_MAX_SEC_CAM_NUM		32
 #define MAX_PG_CAM_BACKUP_NUM		8
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a0991d3f15c0..cf7177b00092 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1703,7 +1703,7 @@ static void rtw_pci_napi_init(struct rtw_dev *rtwdev)
 
 	init_dummy_netdev(&rtwpci->netdev);
 	netif_napi_add(&rtwpci->netdev, &rtwpci->napi, rtw_pci_napi_poll,
-		       RTW_NAPI_WEIGHT_NUM);
+		       NAPI_POLL_WEIGHT);
 }
 
 static void rtw_pci_napi_deinit(struct rtw_dev *rtwdev)
-- 
2.34.1

