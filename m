Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265EC4560E1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhKRQs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:48:59 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:43380 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233671AbhKRQs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:48:58 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.11])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D4235A006D
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:45:56 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A9138140074
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:45:56 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 3598913C2B4;
        Thu, 18 Nov 2021 08:45:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3598913C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253956;
        bh=pYbYvFE9OMQb7Mx+QIXSGwlDawmUxO7+5qx4TL0qExs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d3YTud4ZRWMEisQkM2UX+Hj4x9HdxgRwSoYfBRKnsKvQ764M5PgI5DIeC+lQ5nC5e
         zO//rOoATg8JXWU1qe/NsJk35SUV/xtkS5WOVL4VnZ3k6FgM8ZBG89wkX+Q7Lu134b
         NnMJ3vjJOPq/Z9H4uqdEvalrtZ61vI1USO+aiN+Q=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 4/8] mt76: mt7915: add note about TXSFM 0x2
Date:   Thu, 18 Nov 2021 08:45:45 -0800
Message-Id: <20211118164549.3863-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164549.3863-1-greearb@candelatech.com>
References: <20211118164549.3863-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253957-8oPKwJIxSuel
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This format needs a special command to enable, and is not enabled
by default.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 7a2c740d1464..b66e740832e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -348,6 +348,9 @@ struct mt7915_tx_free {
 
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
+/* The F0 variables are for TXSFM 0x0 and 0x1.  The F1 variables
+ * are for TXSFM 0x2 aka PPDU format.
+ */
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
 #define MT_TXS5_F0_QOS			BIT(30)
 #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
-- 
2.20.1

