Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758AF219EC2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2020 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGILG6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jul 2020 07:06:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGILG6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jul 2020 07:06:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069B1qeN029112;
        Thu, 9 Jul 2020 11:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : sender
 : to : cc : subject : message-id : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sIyc7+eDMvD9MJhujp4zGcvwx5knSLBQdXBNBAbm5Yk=;
 b=P011PvI14FwMg2hbHOCInwZdHSCtknhgLFttIiU/v8tb4Ixp/kVZUrgsB24sJTBN8v5e
 mDhqWOBdfVYcE9TAvjxQCpbk14kKFbD4PyHQEDpDszNRBSGCys2699lT6WuH5y/hq53m
 ZqTCBFMaYQkw0qSydx3BIkKzuiuAwpvGAQ3CRczf8oEXHsaZSp6wy8IT9BnAd4E7szzC
 NBTwJTznillI/eJ/fkW6CnF1OhK1iZ89go5kaVShUgxWJXgMFsepuFUg6N13tnnQljZT
 nZEZ+lnNB0y3/9jBP9stkBX9FxGwaFM7pzEBY9G7QxL129sAaHFfY27kuiTX/hHrlmJC 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 325y0ah09c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 09 Jul 2020 11:06:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 069B3KOf133525;
        Thu, 9 Jul 2020 11:04:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 325k3h0uv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Jul 2020 11:04:47 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 069B4jje005437;
        Thu, 9 Jul 2020 11:04:45 GMT
Received: from kadam (/105.59.63.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jul 2020 04:04:44 -0700
Date:   Thu, 9 Jul 2020 14:04:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        YF Luo <yf.luo@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Chih-Min Chen <chih-min.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] mt76: mt7915: potential array overflow in
 mt7915_mcu_tx_rate_report()
Message-ID: <20200709110435.GM2549@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709104738.GB20875@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007090088
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Smatch complains that "wcidx" value comes from the network and thus
cannot be trusted.  In this case, it actually seems to come from the
firmware.  If your wireless firmware is malicious then probably no
amount of carefulness can protect you.

On the other hand, these days we still try to check the firmware as much
as possible.  Verifying that the index is within bounds will silence a
static checker warning.  And it's harmless and a good exercise in kernel
hardening.  So I suggest that we do add a bounds check.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2:  Fix a typos in commit message.

Normally for networking patches, when we change the declaration block,
we must update the order to make sure it's in reverse Christmas tree
format.  This code wasn't strictly in reverse Christmas tree order
originally because we needed to initialize "wcidx" before we could
initialize "wcid" etc.  Re-ordering the initializers makes the diff
slightly larger than people might expect but it's a required part of
networking patches.

 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index c8c12c740c1a..8fb8255650a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -505,15 +505,22 @@ static void
 mt7915_mcu_tx_rate_report(struct mt7915_dev *dev, struct sk_buff *skb)
 {
 	struct mt7915_mcu_ra_info *ra = (struct mt7915_mcu_ra_info *)skb->data;
-	u16 wcidx = le16_to_cpu(ra->wlan_idx);
-	struct mt76_wcid *wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
-	struct mt7915_sta *msta = container_of(wcid, struct mt7915_sta, wcid);
-	struct mt7915_sta_stats *stats = &msta->stats;
-	struct mt76_phy *mphy = &dev->mphy;
 	struct rate_info rate = {}, prob_rate = {};
+	u16 probe = le16_to_cpu(ra->prob_up_rate);
 	u16 attempts = le16_to_cpu(ra->attempts);
 	u16 curr = le16_to_cpu(ra->curr_rate);
-	u16 probe = le16_to_cpu(ra->prob_up_rate);
+	u16 wcidx = le16_to_cpu(ra->wlan_idx);
+	struct mt76_phy *mphy = &dev->mphy;
+	struct mt7915_sta_stats *stats;
+	struct mt7915_sta *msta;
+	struct mt76_wcid *wcid;
+
+	if (wcidx >= MT76_N_WCIDS)
+		return;
+
+	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	msta = container_of(wcid, struct mt7915_sta, wcid);
+	stats = &msta->stats;
 
 	if (msta->wcid.ext_phy && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
-- 
2.27.0
