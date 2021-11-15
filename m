Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7945014D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Nov 2021 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhKOJ2u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Nov 2021 04:28:50 -0500
Received: from smtpbg704.qq.com ([203.205.195.105]:40071 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237707AbhKOJ2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Nov 2021 04:28:13 -0500
X-QQ-mid: bizesmtp54t1636968132tgkosmaa
Received: from localhost.localdomain (unknown [113.57.152.160])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 15 Nov 2021 17:22:11 +0800 (CST)
X-QQ-SSF: 01400000002000B0B000B00C0000000
X-QQ-FEAT: bOEXdVvRX8Y572JsKxccmj89e1WDJA+VIFcPTVPcE5+QP2APXfGS2txs/OTS3
        fmVzyUb9hg+EHZ4POH+fuvLED/JaUPK+ao9eIl1YSdAAMxy5+mHKz+XF/xsSHVIDrAnmd6N
        GT8X1ksrxzTfUmj4vgu3HNScOQCgtLkVVbLBFy+hHddk5rEIZfywl0p0IfbpFOtkEMs2nZ7
        g9XZ8252jg8T260MFnmerxeiT2PB3CBUltwaOjvkl3eTMpPSMyAA2vI/cOj48dKwALrtltk
        a6LcXe+34WnfBM6Q7ylL2/aXkuj16nO1gL4si2oAxU2aJFZox83PrgBTGqa825JpgfMlNXa
        rapg92CQauO5c2DNo08gW8CMqiJ3scFage9xINp
X-QQ-GoodBg: 2
From:   liuguoqiang <liuguoqiang@uniontech.com>
To:     johannes@sipsolutions.net
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        liuguoqiang <liuguoqiang@uniontech.com>
Subject: [PATCH] cfg80211: delete redundant free code
Date:   Mon, 15 Nov 2021 17:21:39 +0800
Message-Id: <20211115092139.24407-1-liuguoqiang@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When kzalloc failed and rdev->sacn_req or rdev->scan_msg is null, pass a
null pointer to kfree is redundant, delete it and return directly.

Signed-off-by: liuguoqiang <liuguoqiang@uniontech.com>
---
 net/wireless/scan.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 22e92be61938..011fcfabc846 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2702,10 +2702,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	if (IS_ERR(rdev))
 		return PTR_ERR(rdev);
 
-	if (rdev->scan_req || rdev->scan_msg) {
-		err = -EBUSY;
-		goto out;
-	}
+	if (rdev->scan_req || rdev->scan_msg)
+		return -EBUSY;
 
 	wiphy = &rdev->wiphy;
 
@@ -2718,10 +2716,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 	creq = kzalloc(sizeof(*creq) + sizeof(struct cfg80211_ssid) +
 		       n_channels * sizeof(void *),
 		       GFP_ATOMIC);
-	if (!creq) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!creq)
+		return -ENOMEM;
 
 	creq->wiphy = wiphy;
 	creq->wdev = dev->ieee80211_ptr;
-- 
2.20.1


	
