Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D693949FB26
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiA1N6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:58:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35392 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244098AbiA1N6s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:58:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8277661DB4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F68BC340E7
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jan 2022 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643378327;
        bh=w2NfqzqLbY4UJIkqm3znw60RHsmhw/tt+K7W7yrkujk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MG5fmctaSvwJPrk0TILzkcOwVEmeNZxlVwsGig9d5kaXcaNhpp4j5heifizW2abax
         +D9aI5Za5y22QjFzBbMBzL06Nu4bjlzWExXcUA0zIWTMUf8k/kZzXhQgsSMD1DIhLs
         bbCtIT6qEahi2RTmne2gbdxL3M2TuG1mlVK3fSVfF1F4YTLFwDaBHbo+3aTCbMxxlj
         j2/rNuheAR0l77dtxaWhEYRHaa1gNdraxi3zu1E75apS1lZ3QfUC86BX06NeB4cAbN
         H9qzMTG/PsxAGLjmT5zCAZYcB32zn0t2tTDz1pXiTKUgs67ZJkF8SGza+0qHt1ifwT
         IGQ9KEWt7nhjA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH wireless v2 4/4] MAINTAINERS: add DT bindings files for ath10k and ath11k
Date:   Fri, 28 Jan 2022 15:58:41 +0200
Message-Id: <20220128135841.1926-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128135841.1926-1-kvalo@kernel.org>
References: <20220128135841.1926-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The DT bindings files were missing for ath10k and ath11k so add them now.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 37573c9af10a..67e0bb93076c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15889,6 +15889,7 @@ S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath10k/
+F:	Documentation/devicetree/bindings/net/wireless/qcom,ath10k.txt
 
 QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@kernel.org>
@@ -15896,6 +15897,7 @@ L:	ath11k@lists.infradead.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath11k/
+F:	Documentation/devicetree/bindings/net/wireless/qcom,ath11k.txt
 
 QUALCOMM ATHEROS ATH9K WIRELESS DRIVER
 M:	Toke Høiland-Jørgensen <toke@toke.dk>
-- 
2.20.1

