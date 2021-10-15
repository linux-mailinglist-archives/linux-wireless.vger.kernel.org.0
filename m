Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9642F1F8
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Oct 2021 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbhJONRx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Oct 2021 09:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbhJONRv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Oct 2021 09:17:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD6FC061570
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r7so26492122wrc.10
        for <linux-wireless@vger.kernel.org>; Fri, 15 Oct 2021 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cX6ee/zMZHAq3yMrIa9rFmJR1PDVem3FHyhI2fReY3k=;
        b=zOWa4hAhdDGgUSv8hwQwPHdCT9+dVorGNtMNG3d4cvMgDEKy/ja8dimVWiy2e3t+dV
         xV0P+lO/CXkegSVGK8KOu05VqACwWBHq1KvVr6ZEjZMObb1KW3SItd2MH/8cRiTfbyt2
         O8MR1h38v3knt3APD2lMU4v7fZiRznQdBrrC9gFbO0vkPm3POchXGyYE0BKoD5Uypogt
         8SdTGXDXkvPiZ3fVBsyyioUIx4+nq/5yRn97xHbGVBE40Vjk2Ad66NkLNTlbzj9HKQgf
         hmMA48GQlEfTX0C6fapmyP/AB1Z5hoQVPnvjhPJFb6oMfMij5Z5X0Nk9PxSeFnKep+Jv
         Pa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cX6ee/zMZHAq3yMrIa9rFmJR1PDVem3FHyhI2fReY3k=;
        b=VholfMtsZwmZnt7s+Y76Ou4NkZ8FRtgadIkfCJVSLS4J5s8JdzmYnJbZXF3hJ2OLKw
         U2w1yxEQqMnbHyH5MIJjgPelhvRczlPUHR1Anh5Cjaz3/LKzta4uBNbHlGmul+RrK6k7
         vJ11szANGgKPUXF3ccsV6V+kqIYKcB/9dcxEHVzeI2T2u7KoCuaDLz5jYFWAR0i0B+D+
         FuBeDrNVYf9kov+1VX9ZBxHhVDq9Sp/7crUNRBUmrZ6Mab0/JfywaUkb7u22+jY58gA+
         cv69CqAXq9eadOUgylRFZIASEM5FFr+lQ6T4zdg77Nd2sorq33UMQfmyt+G3FFyqssb+
         gOLw==
X-Gm-Message-State: AOAM533Z2ehCRi8zZ+GS9HFzBGPNBy6p0x5NQLyllXRUcsIYfOmAiipT
        za/UgtAGqg5pcUvhuR7xtc3mXw==
X-Google-Smtp-Source: ABdhPJy4cDpFVCyp/YZCUdG/Mqv32CkiljU3j3+TFthOOKFnc7DVUFLxtpAEbwDJInuVjApdb47QzA==
X-Received: by 2002:adf:a48f:: with SMTP id g15mr13741561wrb.259.1634303743282;
        Fri, 15 Oct 2021 06:15:43 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e8sm7091716wrg.48.2021.10.15.06.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:15:42 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 0/4] wcn36xx: Fix DMA buffer allocation and free logic
Date:   Fri, 15 Oct 2021 14:17:37 +0100
Message-Id: <20211015131741.2455824-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

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

Bryan O'Donoghue (4):
  wcn36xx: Fix DXE lock layering violation
  wcn36xx: Fix DXE/DMA channel enable/disable cycle
  wcn36xx: Release DMA channel descriptor allocations
  wcn36xx: Put DXE block into reset before freeing memory

 drivers/net/wireless/ath/wcn36xx/dxe.c  | 75 +++++++++++++++++++++----
 drivers/net/wireless/ath/wcn36xx/dxe.h  |  2 +
 drivers/net/wireless/ath/wcn36xx/txrx.c | 15 +----
 3 files changed, 68 insertions(+), 24 deletions(-)

-- 
2.33.0

