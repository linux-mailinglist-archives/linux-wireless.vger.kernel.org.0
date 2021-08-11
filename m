Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD53E9A8B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhHKVqK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:46:10 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:41006 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232251AbhHKVpb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:31 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.133])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2E5DB2006C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:53 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0D470B0001A
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:53 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id B71AC13C35A;
        Wed, 11 Aug 2021 14:44:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B71AC13C35A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718292;
        bh=gUPiTybpfYVVAaa4aO4DhSlMYPp2lnOkKNBbDZU5id4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmo1z4L1/g2sDos3kVaWIjEY4G4JQEHkhSaABvFCBnT3sxHK8+XfiFAa9r3EPoFxW
         MLO3fqKgbliV0hVvI8Lx0WibI2/O47jb87B305PLhj1sORRJqqC6hEH4Pi2gRVUnph
         TDnbFeKuxxugDMivTOieOaDPh/n4XUElrx4jWDew=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 15/15] mt76: mt7915:  poll mib counters every 200ms
Date:   Wed, 11 Aug 2021 14:44:39 -0700
Message-Id: <20210811214439.17458-16-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718293-cqEXlPYjl6Td
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Instead of every 500ms, this will do better job of catching wraps
of 16-bit pkt counters.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index ba1c71bee149..77d7477f8667 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2362,7 +2362,11 @@ void mt7915_mac_work(struct work_struct *work)
 	mutex_lock(&mphy->dev->mutex);
 
 	mt76_update_survey(mphy);
-	if (++mphy->mac_work_count == 5) {
+
+	/* this method is called about every 100ms.  Some pkt counters are 16-bit,
+	 * so poll every 200ms to keep overflows at a minimum.
+	 */
+	if (++mphy->mac_work_count == 2) {
 		mphy->mac_work_count = 0;
 
 		mt7915_mac_update_stats(phy);
-- 
2.20.1

