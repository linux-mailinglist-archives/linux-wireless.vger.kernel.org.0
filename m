Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3575FD0973
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 10:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJIISl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 04:18:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51338 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJIISk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 04:18:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF60261B08; Wed,  9 Oct 2019 08:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609120;
        bh=fkegv0laAJ4hlSt28jWVa0qekMb+Sxt77qJ84+gMelE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqPhkw3uBEJz8M4m+Lj1jqbniDmIHHFmSupmF5tbmv0cPJkgCVUv3/hhUt40HuDUB
         5xhQz0mm33MsG0m8puSAxzo+/4wz2CRP7YChRQvzwcdFYA+idsRWIYqeb2hWPXcA8G
         wJlbtNzMfdSFMY36bAnTrpTJ+ipr+OY5crr/umCg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97BF161A1B;
        Wed,  9 Oct 2019 08:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570609118;
        bh=fkegv0laAJ4hlSt28jWVa0qekMb+Sxt77qJ84+gMelE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aln+meziXaFPjbhKBqCILzpi+ZD34pOOzxhrv3tA4zSLMVwPtp5R54uVm6OghtV8h
         nCyYXGRhCzq+2uG3/lnawZxORkyVLymUN0xgZebjON6UEC2vbsYVWqwdWHv2I7exHM
         IIWwdAxl3hsNTghwhZyeT46fBmcj6o/bp/sgsxQc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97BF161A1B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Wed, 09 Oct 2019 16:18:31 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH 2/2] ath10k: fix memory leak for tpc_stats_final
Date:   Wed,  9 Oct 2019 16:18:09 +0800
Message-Id: <1570609089-22071-2-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1570609089-22071-1-git-send-email-miaoqing@codeaurora.org>
References: <1570609089-22071-1-git-send-email-miaoqing@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The memory of ar->debug.tpc_stats_final is reallocated every debugfs
reading, it should be freed in ath10k_debug_destroy() for the last
allocation.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00035

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 40baf25..04c50a2 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -2532,6 +2532,7 @@ void ath10k_debug_destroy(struct ath10k *ar)
 	ath10k_debug_fw_stats_reset(ar);
 
 	kfree(ar->debug.tpc_stats);
+	kfree(ar->debug.tpc_stats_final);
 }
 
 int ath10k_debug_register(struct ath10k *ar)
-- 
1.9.1

