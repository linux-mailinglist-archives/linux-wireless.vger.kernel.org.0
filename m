Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AF432A27
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Oct 2021 01:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhJRXRh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 19:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhJRXRh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 19:17:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F1CC06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g25so44055503wrb.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 16:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxJc19+xGG2KeUw0OLBGrzXvKmvySEBx4x1YN9MLuvM=;
        b=sVOrB1kf1vMgiFV7vSHlqtj+2BEDuIhHuopjQAuMcPkzvUQn6Sxdj7nM3aW+IbAmxn
         82/Li1aTp2PEjv8uPJshDsZ2ELVRTSNF1wOvk11jSZFCvh6aYi/H0whDdMJLQxy/6x9L
         aXWiK84t21JvNT8uk6k5OK66ASA5IF3fKhdK0KVK5YVTjbLynCu3BfooZavJ+Ci7/Rot
         INWGkGJNjhkutiCJDfWZRORWp5sr+UjNV3c+It3woUsy5HLXcqz9qirvK41oExHVqGbt
         m4OU0r5qkk/HOeXGoMZckD4nbQzodqBVee6t15rZGXth3EWC0xylO915E4Oc2j0fAnba
         QT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxJc19+xGG2KeUw0OLBGrzXvKmvySEBx4x1YN9MLuvM=;
        b=72n89GnYa7CJdS1rKanxaqEGj+dBh4wVbWEZg6lFu7QHQKSSirOKVWIRWMbknIuPDS
         u4aGrsfOMz+fVtidF/mIld1zs4D8Vv8PHUTrnC/BqOocAHp+5fSJ4jWx7Fx1TmTwjDKj
         JBnWEZhFGXBnA0tRDjl15ACqqYnvDT/UrFiKTy9WS3CwQXTrRSY61LMCGvoWcsxS0OEX
         r+G5hJJxb8V5jleAW3lBNMOr2PbRxJQ552Y/CAF2MgM3H04M2sWg6APRTDDv2snNx77G
         Hnbk7KLUSqOEkrJBCvxgumVZ0bCITojUKeJoIy8oJB7cSeHcdDSw6DEsSuptzr6XLFuE
         I4Fg==
X-Gm-Message-State: AOAM533RDjCH8JuZeNvm+WyRQjTIn5Dm9WoeAwNr8xbJSlQAvNohQ1DS
        XqW2e78pH+ZZmoJ0iAN27YCXUKQU60LYVQ==
X-Google-Smtp-Source: ABdhPJxuo030Og0QOIIgXYaA8AQim7kwKwZBQJBTEg4Fy2z0ZINhXmBE8i69grMM4QWR0E+MXnki2g==
X-Received: by 2002:adf:c78d:: with SMTP id l13mr38620310wrg.134.1634598923872;
        Mon, 18 Oct 2021 16:15:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s8sm3685379wrr.15.2021.10.18.16.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:15:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, johannes@sipsolutions.net,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 0/5] wcn36xx: Fix DMA buffer allocation and free logic
Date:   Tue, 19 Oct 2021 00:17:17 +0100
Message-Id: <20211018231722.873525-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

V2:
- Functionally decomposes the DXE reset in an additional patch.
  Since we call this logic more than once, it should be in a function.

- Leaves as-is the DXE reset write.

  Johannes Berg asked me if we are sure by the time the write to the reset
  register completes that DXE transactions will be suitably quiesced.

  The answer is:
  1. I believe these writes are non-posted writes
  2. Downstream doesn't poll for DXE reset completion

  So on #2 I have no real data for or against a polling operation, my tests
  indicate the reset indication in the register is atomic and as far as I
  can discern that also means DMA transactions are terminated.

V1:
Digging around through some bugs reported from an extensive testing cycle
we've found that wcn36xx has a number of unexplained RX related oopses.

In at least one case we appear to have DMA'd data to an unmapped region.
The written data appears to be a correctly formed DMA buffer descriptor - a
DXE BD in WCNSS parlance, with an AP beacon inside of it.

Reasoning about how such a situation might come about and reviewing the
run-time code, there was no obvious path where we might free a BD or an
skbuff pointed to by a BD, which DXE might not be aware of.

However looking at the ieee80211_ops.start and ieee80211_ops.stop callbacks
in wcn36xx we can see a number of bugs associated with BD allocation, error
handling and leaving the DMA engine active, despite freeing SKBs on the MSM
side.

This last mention - failure to quiesce potential DMA from the downstream
agent - WCNSS DXE despite freeing the memory @ the skbuffs is a decent
candidate for our unexplained upstream DMA transaction to unmapped memory.

Since wcn36xx_stop and wcn36xx_start can be called a number of times by the
controlling upper layers it means there is a potential gap between
wcn36xx_stop and wcn36xx_start which could leave WCNSS in a state where it
will try to DMA to memory we have freed.

This series addresses the obvious bugs that jump out on the start()/stop()
path.

Patch #1
  In order to make it easier to read the DXE code, I've moved all of the
  lock taking and freeing for DXE into dxe.c

Patch #2
  Fixes a very obviously broken channel enable/disable cycle

Patch #3
  Fixes a very obvious memory leak with dma_alloc_coherent()

Patch #4
  Makes sure before we release skbuffs which we assigned to the RX channels
  that we ensure the DXE block is put into reset

Bryan O'Donoghue (5):
  wcn36xx: Fix dxe lock layering violation
  wcn36xx: Fix DMA channel enable/disable cycle
  wcn36xx: Release DMA channel descriptor allocations
  wcn36xx: Functionally decompose DXE reset
  wcn36xx: Put DXE block into reset before freeing memory

 drivers/net/wireless/ath/wcn36xx/dxe.c  | 83 +++++++++++++++++++++----
 drivers/net/wireless/ath/wcn36xx/dxe.h  |  2 +
 drivers/net/wireless/ath/wcn36xx/txrx.c | 15 +----
 3 files changed, 74 insertions(+), 26 deletions(-)

-- 
2.33.0

