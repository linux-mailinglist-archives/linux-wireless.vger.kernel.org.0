Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA15746E558
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhLIJT3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 04:19:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46708 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhLIJT2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 04:19:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76B9DB823BD
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 09:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFC8C341C8;
        Thu,  9 Dec 2021 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639041353;
        bh=xwYdGutxAfsG1PdhuXlI/5zQ4TyEWKUigSAODOE4Hg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6qQvVvN1Y38C1lSb866t5LRXYjr4DVfie3epTJGfxnHAJhnvROBj09hBggqJwepa
         Hbr2IEST5OFgRPC9pBvKe6dIfvXjKQsBlxs2XA0TJvT5o7oyTg7kFxqmGv/r9LZH7U
         2mfal2EfUS/gRh9ycjH5LSC3FmgphaL0bUQyn6urnBAm8Ylc849bozOHf9Ylco2ZYi
         dKeP64B3IN7WhfG716J6pgUCfmwSB1d6l0my0Py2TT91woxYkN7newCrwgO4dx3+B4
         /u83p3WktZxcH3wrko9FiHkpKFvlF8uPE+eIaYQePZLuEod3dT5qtfC5qKSL+N4bBB
         BsuvhNG0bJTrA==
From:   Kalle Valo <kvalo@kernel.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath10k: wmi: remove array of flexible structures
Date:   Thu,  9 Dec 2021 11:15:45 +0200
Message-Id: <20211209091545.6098-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211209091545.6098-1-kvalo@kernel.org>
References: <20211209091545.6098-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

I updated to sparse v0.6.4 and it warns:

drivers/net/wireless/ath/ath10k/wmi.c: note: in included file (through drivers/net/wireless/ath/ath10k/core.h):
drivers/net/wireless/ath/ath10k/wmi.h:3481:34: warning: array of flexible structures

Fix it by changing the type to u8 array, in struct wmi_phyerr_hdr_arg it's
stored as a void pointer anyway.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/wmi.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 01bfd09a9d88..4abd12e78028 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3478,7 +3478,9 @@ struct wmi_phyerr_event {
 	__le32 num_phyerrs;
 	__le32 tsf_l32;
 	__le32 tsf_u32;
-	struct wmi_phyerr phyerrs[];
+
+	/* array of struct wmi_phyerr */
+	u8 phyerrs[];
 } __packed;
 
 struct wmi_10_4_phyerr_event {
-- 
2.20.1

