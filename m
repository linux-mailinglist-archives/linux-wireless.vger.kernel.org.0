Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4E83F21DE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbhHSUuq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 16:50:46 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:52998 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235560AbhHSUup (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 16:50:45 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.129])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E3DEF1C0073
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:07 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C3804500083
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:07 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 30B2213C2B8;
        Thu, 19 Aug 2021 13:49:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 30B2213C2B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629406196;
        bh=jaPe5aCo0puDjlL/Yjg9OUAOkqrjKfpVDF9GVEcjijs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c89LeZ6zBc/c3MNaoMRFLMq9gHBzbTEyoO6G2ada7Jp8yzuJeY/3wTMj1Ri+1L4jw
         ENf4NfVsbqd/ebOIgKqBp/apEq2/ptG10ahg8tcZNnsTzHOWhs2cs+3cRoawCagEr/
         tDX+CS0XQ8+I/aGXySASzuIvffThsROzH+xEuS0U=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v8 6/9] mt76: mt7915:  add note about TXSFM 0x2
Date:   Thu, 19 Aug 2021 13:49:47 -0700
Message-Id: <20210819204950.12150-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210819204950.12150-1-greearb@candelatech.com>
References: <20210819204950.12150-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1629406208-ZlXnlBwbafOy
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This format is not supported by any current hardware,
add note to mention this.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index ccce994dc07a..65dba1061376 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -347,6 +347,10 @@ struct mt7915_tx_free {
 
 #define MT_TXS4_TIMESTAMP		GENMASK(31, 0)
 
+/* The F0 variables are for TXSFM 0x0 and 0x1.  The F1 variables
+ * are for TXSFM 0x2 aka PPDU format.  TXSFM 0x2 not supported
+ * at this time.
+ */
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
 #define MT_TXS5_F0_QOS			BIT(30)
 #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
-- 
2.20.1

