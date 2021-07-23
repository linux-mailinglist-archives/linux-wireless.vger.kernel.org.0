Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8843D3D19
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 18:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhGWP0S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:26:18 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:38728 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229780AbhGWP0Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:26:16 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.17])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 44E1E20061
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:49 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 16F1C680088
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 16:06:49 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id E2AC213C2BC;
        Fri, 23 Jul 2021 09:06:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E2AC213C2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627056394;
        bh=3eYDjQjfNrOOKrwUhrouxondpht/GxRSvL2juR/uuJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fymkf7jpLesDT7WZlrq/saw6UDaXYIyF8jzWfywdoWM2anaQkKxyznYwDFJWicbVW
         Ucu8FsQoIS6BGCKuAYjXpGsbvQvnI2a4OXpIH5M5GgT7LMoM+nROF065/kCn/Ecw1n
         5F92Q/Iuj6w9zdYZ0VE5azm2bPfcnB5P160A1dew=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 08/11] mt76: mt7915:  Fix SGI reporting when using tx-overrides.
Date:   Fri, 23 Jul 2021 09:06:20 -0700
Message-Id: <20210723160623.14709-8-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723160623.14709-1-greearb@candelatech.com>
References: <20210723160623.14709-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627056409-tE9JnHryqKLY
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The station wtbl logic to read rate-ctrl settings does not work when
fixed rates are used.  So, read sgi settings from the txo configuration
in this case.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 23c9125e19c8..74f567393656 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -176,6 +176,15 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 						       rx_cur);
 		}
 
+		/* If we are in tx-override mode, then wtbl doesn't provide useful report
+		 * for the SGI/LGI stuff, so just get it from the override struct.
+		 */
+		if (msta->test.txo_active) {
+			msta->wcid.rate_he_gi = msta->test.tx_rate_sgi;
+			msta->wcid.rate_short_gi = msta->test.tx_rate_sgi;
+			continue;
+		}
+
 		/*
 		 * We don't support reading GI info from txs packets.
 		 * For accurate tx status reporting and AQL improvement,
-- 
2.20.1

