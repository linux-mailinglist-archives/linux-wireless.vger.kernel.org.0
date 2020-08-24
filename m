Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCB24F31B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 09:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgHXH2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 03:28:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55864 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbgHXH2w (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 03:28:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DDE765EE57E064C60290;
        Mon, 24 Aug 2020 15:28:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 24 Aug 2020
 15:28:41 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi83@gmail.com>,
        <ryder.lee@mediatek.com>, <kvalo@codeaurora.org>,
        <linux-wireless@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] mt76:: Fix unsigned expression compared with zero in mt76x02_dfs_create_sequence and mt76x02_dfs_add_event_to_sequence
Date:   Mon, 24 Aug 2020 15:28:26 +0800
Message-ID: <20200824072826.136922-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index ff6a9e4daac0..b29cd39dc176 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -429,11 +429,11 @@ static int mt76x02_dfs_create_sequence(struct mt76x02_dev *dev,
 {
 	struct mt76x02_dfs_pattern_detector *dfs_pd = &dev->dfs_pd;
 	struct mt76x02_dfs_sw_detector_params *sw_params;
-	u32 width_delta, with_sum, factor, cur_pri;
+	u32 width_delta, with_sum;
 	struct mt76x02_dfs_sequence seq, *seq_p;
 	struct mt76x02_dfs_event_rb *event_rb;
 	struct mt76x02_dfs_event *cur_event;
-	int i, j, end, pri;
+	int i, j, end, pri, factor, cur_pri;
 
 	event_rb = event->engine == 2 ? &dfs_pd->event_rb[1]
 				      : &dfs_pd->event_rb[0];
@@ -517,7 +517,7 @@ static u16 mt76x02_dfs_add_event_to_sequence(struct mt76x02_dev *dev,
 	struct mt76x02_dfs_sw_detector_params *sw_params;
 	struct mt76x02_dfs_sequence *seq, *tmp_seq;
 	u16 max_seq_len = 0;
-	u32 factor, pri;
+	int factor, pri;
 
 	sw_params = &dfs_pd->sw_dpd_params;
 	list_for_each_entry_safe(seq, tmp_seq, &dfs_pd->sequences, head) {
-- 
2.25.4

