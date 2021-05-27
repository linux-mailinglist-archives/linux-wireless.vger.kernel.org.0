Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D8392CD6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 13:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhE0LhR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 07:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhE0LhQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 07:37:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1AEB613D3;
        Thu, 27 May 2021 11:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622115343;
        bh=TJknkpMyZT/wY84jq9Xil6QwGq+ffNfouQm2ahZK/m8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJ7HAD46Ii3KYzgrM3dvPRKqJ4D2MoUSXe+kCW82Z3XRxuXmuBiEFCj5knBMXo3N9
         0Rw0cpPJqUpolhT+LrxbWtA9XoL3CyFLKEo7ft7y5HFEgct/dLxmu5fxGPVGtP3ENn
         zm9KEyAiP97acDkGCaOkAHmW8l2+reUeJ+8qdJKE98Q7wAwqylb/0W7x/F6zZu42p0
         aFQBX3PplXZZRezyx2HQMem34fhbx5Qj5LSDlvgx7c0mDOjL2+mTEslO40Gd1D20fL
         z8P6vrRpzv/uLzwTvXhP98mZMkvCPBrqPPx3bVUISmiRmmZElNeUOHKl3zIZIxixi+
         55vAVAR0wfvXg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        shayne.chen@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 3/3] mt76: testmode: remove undefined behaviour in mt76_testmode_alloc_skb
Date:   Thu, 27 May 2021 13:35:30 +0200
Message-Id: <1892c389b06aabc59ff9e01d53fc14cf0097c17d.1622115194.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622115194.git.lorenzo@kernel.org>
References: <cover.1622115194.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rif of an undefined behaviour in mt76_testmode_alloc_skb routine
allocating skb frames

Fixes: 2601dda8faa76 ("mt76: testmode: add support to send larger packet")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/testmode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index c516469278a4..c6a85a0cfc89 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -159,12 +159,8 @@ int mt76_testmode_alloc_skb(struct mt76_phy *phy, u32 len)
 		head->len += frag->len;
 		head->data_len += frag->len;
 
-		if (*frag_tail) {
-			(*frag_tail)->next = frag;
-			frag_tail = &frag;
-		} else {
-			*frag_tail = frag;
-		}
+		*frag_tail = frag;
+		frag_tail = &(*frag_tail)->next;
 	}
 
 	mt76_testmode_free_skb(phy);
-- 
2.31.1

