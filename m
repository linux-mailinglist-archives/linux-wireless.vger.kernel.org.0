Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9311475F7E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhLORix (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 12:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhLORiw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 12:38:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A60C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Dec 2021 09:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3rZmdTkSnVfeLclPAhYbTFnZ4FIeN0HdEyPAj+H05og=; b=nNmMny0zWY2PPCo0HvxqeWERy/
        8SgGM5rX10DmIe3EprnKbO1IsIk92FGobo2zyR0lVD0+qg2ARi5gC976n0NkL6l2P74vCR3sh+Ba2
        uHXbOkrCFLXKAgkpnPca5jx249Yh0A2/U0hJ2l4TFD0/PDXxMivbNWQ+nah2Ut0n1azE=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mxYEr-0000He-SJ
        for linux-wireless@vger.kernel.org; Wed, 15 Dec 2021 18:38:49 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] mt76: mt7615: in debugfs queue stats, skip wmm index 3 on mt7663
Date:   Wed, 15 Dec 2021 18:38:39 +0100
Message-Id: <20211215173839.20853-3-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215173839.20853-1-nbd@nbd.name>
References: <20211215173839.20853-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware only supports WMM index 0-2 and registers for index 3 return
bogus data.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 6fd6f067da49..b53528014fbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -359,6 +359,9 @@ mt7615_queues_acq(struct seq_file *s, void *data)
 		int acs = i / MT7615_MAX_WMM_SETS;
 		u32 ctrl, val, qlen = 0;
 
+		if (wmm_idx == 3 && is_mt7663(&dev->mt76))
+			continue;
+
 		val = mt76_rr(dev, MT_PLE_AC_QEMPTY(acs, wmm_idx));
 		ctrl = BIT(31) | BIT(15) | (acs << 8);
 
-- 
2.34.1

