Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA66FA967
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 06:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKMFPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 00:15:48 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52540 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfKMFPr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 00:15:47 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAD5A64X022265;
        Tue, 12 Nov 2019 21:15:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=fYQTauQNC0MAoFWL7Zs+9Y3ugiCBdGCUNsP72L/xVrI=;
 b=TjAsk2HJuS5jBzcBcfpwmfr4efF5QCogd7EeRRQTaHsHlRWmxQBe3REvv7zVP1qnvm3I
 mo/RQt3Hof0nl6V1KGNsiPilL2XfhZAWBHYU3bqC7fH/ysFrRfGYxsho2lJ5941v+Ees
 O/jbpKO57tkYJoLGIHZwzzRYxiIC8K/spbg3Bnz4LQDc2rNjcqWe0xyo3GVTHsaoM6i5
 JI8ny8tFW4wfJurqj9sw6q3ygziYZGWmJ+lhT5DRXMZgSqAlB9t/caphhxST22/7tqwR
 NupFvti7HlomKzvW2TeuvaLzAaHRD6Q9BRorPiUXCiYa6WMENBf9nv4evS2FiEf3Bqep tg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w5wurxcmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 21:15:46 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 12 Nov
 2019 21:15:44 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 12 Nov 2019 21:15:44 -0800
Received: from testmailhost.marvell.com (unknown [10.31.130.105])
        by maili.marvell.com (Postfix) with ESMTP id 50FC53F703F;
        Tue, 12 Nov 2019 21:15:42 -0800 (PST)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Sharvari Harisangam <sharvari@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: [PATCH 2/2] mwifiex: do not download TX packets if interface has not resumed
Date:   Wed, 13 Nov 2019 10:45:32 +0530
Message-ID: <1573622132-16181-2-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1573622132-16181-1-git-send-email-gbhat@marvell.com>
References: <1573622132-16181-1-git-send-email-gbhat@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_10:2019-11-11,2019-11-12 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sharvari Harisangam <sharvari@marvell.com>

mwifiex_queue_tx_pkt would queue the TX packet to driver queues
and before return, would invoke main_work, which in turn would
download the packet to firmware. In case the card is in sleep
state, driver would wakeup the card(via interface).

During resume it is possible that, the applications send packets
even before interface has completed its resume. If driver try to
access interface register(to wakeup the card), it would lead to
invalid results.

To avoid this, don't invoke main_work, when hs_activated is set.

Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index a9657ae..7b5cf2c0 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -808,6 +808,11 @@ int mwifiex_queue_tx_pkt(struct mwifiex_private *priv, struct sk_buff *skb)
 		mwifiex_wmm_add_buf_txqueue(priv, skb);
 	 }
 
+	if (priv->adapter->hs_activated) {
+		mwifiex_dbg(priv->adapter, ERROR, "hs_activated: queue TX\n");
+		return 0;
+	}
+
 	mwifiex_queue_main_work(priv->adapter);
 
 	return 0;
-- 
1.9.1

