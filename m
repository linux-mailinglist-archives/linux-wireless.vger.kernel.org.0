Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79276C25AC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 00:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCTXfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 19:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCTXfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 19:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C7B31E38
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679355293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eLRNau9yfu5hUtNACbqD47eGjINw3xSx6xkN8nR2nXo=;
        b=ftsUeORo919szKTO1NisJUIbZ98MbRl142IwhMnQRmUP7ToeRFgyRNvIruhYgRODrTwp/P
        HFtkWD3Gd7bwct2L7i2XGuVP6Zz5KZCAsazfu4G1BlZFhP9gvrHLo/PwF3kKus9ZbtxSCY
        OtRzp+C6v64LrLk7SM8fhCJi+V9OH3M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-PUMiOc4lNuSaLjeZIFkoaQ-1; Mon, 20 Mar 2023 19:34:52 -0400
X-MC-Unique: PUMiOc4lNuSaLjeZIFkoaQ-1
Received: by mail-qv1-f71.google.com with SMTP id e11-20020ad4536b000000b005a9292e8c2bso6918157qvv.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 16:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLRNau9yfu5hUtNACbqD47eGjINw3xSx6xkN8nR2nXo=;
        b=uOwFfSiwkuw2rWsPd9Bj3LXW4EvQb0Gxc9nLFCMr9dmAs/EhflDY8ISXtPrrkRs0Wp
         2niYwO27p8UAhczS1qhCmSpkjERYrpvnFKsRLnUHu4UAnkyRmyDV4NeLx++SqT+MeceL
         DXERLceinDrIC6O6N56dXjVcGYqPorpcfd1tuHq/4BQbjmuC6BaOcifxcF6ydwleuKgK
         DNQpMtPqKoHzBTTNan6nhlUvmRE7lXGWiRf9c4K8B/tDb36QGFS+9K8cBEcNofTCbnhu
         ZwCUwxu+i6oMo6nL4Qm6IuXC7r9uSxM9cmQTcqOMgVakYT34zkde2vC8LQOrZClF+oty
         q5JQ==
X-Gm-Message-State: AO0yUKXdYu4GAcmmlWYnmLdcTgtdJIRH6vwRSgUjGcIXvfex37BrR/2J
        dYG4zuPewlQGvsaSElav0la2ij5+eRT3u5XTVPpVa7Wk+fDlL7Y1dAecw9egMc7UNi2SvPz6ejF
        SKl2iJqRGmXFbLqa3bGULLOMsMUQ=
X-Received: by 2002:ac8:590d:0:b0:3bf:c407:10c6 with SMTP id 13-20020ac8590d000000b003bfc40710c6mr1680915qty.13.1679355292033;
        Mon, 20 Mar 2023 16:34:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set/MSGMYSq3HoZIhVmyS6T1eXwZz2enrFbuKq9nPI2QR/JAsY9RsSg0g8FFAWo/GPQAdeced0g==
X-Received: by 2002:ac8:590d:0:b0:3bf:c407:10c6 with SMTP id 13-20020ac8590d000000b003bfc40710c6mr1680898qty.13.1679355291794;
        Mon, 20 Mar 2023 16:34:51 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 5-20020a370b05000000b0071eddd3bebbsm8312839qkl.81.2023.03.20.16.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:34:51 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     tony0620emma@gmail.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] wifi: rtw88: remove unused rtw_pci_get_tx_desc function
Date:   Mon, 20 Mar 2023 19:34:48 -0400
Message-Id: <20230320233448.1729899-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

clang with W=1 reports
drivers/net/wireless/realtek/rtw88/pci.c:92:21: error:
  unused function 'rtw_pci_get_tx_desc' [-Werror,-Wunused-function]
static inline void *rtw_pci_get_tx_desc(struct rtw_pci_tx_ring *tx_ring, u8 idx)
                    ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index b4bd831c9845..6a8e6ee82069 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -89,13 +89,6 @@ static void rtw_pci_write32(struct rtw_dev *rtwdev, u32 addr, u32 val)
 	writel(val, rtwpci->mmap + addr);
 }
 
-static inline void *rtw_pci_get_tx_desc(struct rtw_pci_tx_ring *tx_ring, u8 idx)
-{
-	int offset = tx_ring->r.desc_size * idx;
-
-	return tx_ring->r.head + offset;
-}
-
 static void rtw_pci_free_tx_ring_skbs(struct rtw_dev *rtwdev,
 				      struct rtw_pci_tx_ring *tx_ring)
 {
-- 
2.27.0

