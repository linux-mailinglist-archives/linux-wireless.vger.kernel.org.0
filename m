Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2F7488588
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 20:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiAHTIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 14:08:19 -0500
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:45406 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229538AbiAHTIT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 14:08:19 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.66.135])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id ED84A1C0071
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 19:08:17 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CCB684C007B
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 19:08:17 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 39AFE13C2B0;
        Sat,  8 Jan 2022 11:08:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 39AFE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1641668897;
        bh=vCD19AV8X1SIgerqo55s/x/8MGrMoDcFg4XS4yCBhY0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZnPSp3RO54IZpGZgR+ERT2exYxwACAzv25KihopZcY2cZxRnxyM2DLI31ktOb6UsT
         7caLLQFc/HqnG2C3YnW7g8XDqUL4/hhZqHny/93+v/W5TnaPkKvYGouysBP5WRtx0t
         fParHtrbRWVCAQuqu0surbEcZVDoC6O/WvtXG2TQ=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76: mt7921: fix crash when startup fails.
Date:   Sat,  8 Jan 2022 11:08:14 -0800
Message-Id: <20220108190814.3841-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1641668898-avXO6vJk1COK
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

If the nic fails to start, it is possible that the
reset_work has already been scheduled.  Ensure the
work item is canceled so we do not have use-after-free
crash in case cleanup is called before the work item
is executed.

This fixes crash on my x86_64 apu2 when mt7921k radio
fails to work.  Radio still fails, but OS does not
crash.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 6073bedaa1c08..9b33002dcba4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -272,6 +272,7 @@ static void mt7921_stop(struct ieee80211_hw *hw)
 
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	cancel_work_sync(&dev->pm.wake_work);
+	cancel_work_sync(&dev->reset_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
 	mt7921_mutex_acquire(dev);
-- 
2.26.3

