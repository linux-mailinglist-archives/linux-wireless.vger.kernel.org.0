Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82691D0C7A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgEMJkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 05:40:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38976 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEMJkX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 05:40:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D9bI4g016115;
        Wed, 13 May 2020 09:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=tUbhp5PDHMaiVRUsbfWlpquWPTGLCsAhIZ4Fsyrh7bM=;
 b=AfL/iGlNhO77ddwiYBuEHOaTsGZBv/JH3fsascgY72YWvWooTNvylDEoW5luiLz/E+Cz
 IT7P+pkUK7JVBXgllZ2NTPVe40HyKpDYiNey9aJped0dZ7yinQ53l8VJAzpnkPYmW46y
 G3QLmcPwiw/Ko1O3SCNV8DL6y77FLmC6/Obb35gz3Kxk7P3xE3GU3eIlYKIGVY28r6q0
 WbtvetQADT5nAlhoCRgvJik/nWAt8N/bYDFSSppEZ6pXuXqVtmc8yuobErL4AQR1ttr3
 5kC/ePzMSgLIa+hZXxqt8tgmo+4adbQp2LukNE9TYPL9BWDSDKgqQ99Xcft/yTeq7Jz7 gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 3100xwk57v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 May 2020 09:40:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04D9coZe098416;
        Wed, 13 May 2020 09:40:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3100yr0r91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 09:40:03 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04D9dxPs022416;
        Wed, 13 May 2020 09:39:59 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 02:39:59 -0700
Date:   Wed, 13 May 2020 12:39:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] rtlwifi: Fix a double free in _rtl_usb_tx_urb_setup()
Message-ID: <20200513093951.GD347693@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 suspectscore=2
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9619 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=2 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130087
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Seven years ago we tried to fix a leak but actually introduced a double
free instead.  It was an understandable mistake because the code was a
bit confusing and the free was done in the wrong place.  The "skb"
pointer is freed in both _rtl_usb_tx_urb_setup() and _rtl_usb_transmit().
The free belongs _rtl_usb_transmit() instead of _rtl_usb_tx_urb_setup()
and I've cleaned the code up a bit to hopefully make it more clear.

Fixes: 36ef0b473fbf ("rtlwifi: usb: add missing freeing of skbuff")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 348b0072cdd69..c66c6dc003783 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -881,10 +881,8 @@ static struct urb *_rtl_usb_tx_urb_setup(struct ieee80211_hw *hw,
 
 	WARN_ON(NULL == skb);
 	_urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (!_urb) {
-		kfree_skb(skb);
+	if (!_urb)
 		return NULL;
-	}
 	_rtl_install_trx_info(rtlusb, skb, ep_num);
 	usb_fill_bulk_urb(_urb, rtlusb->udev, usb_sndbulkpipe(rtlusb->udev,
 			  ep_num), skb->data, skb->len, _rtl_tx_complete, skb);
@@ -898,7 +896,6 @@ static void _rtl_usb_transmit(struct ieee80211_hw *hw, struct sk_buff *skb,
 	struct rtl_usb *rtlusb = rtl_usbdev(rtl_usbpriv(hw));
 	u32 ep_num;
 	struct urb *_urb = NULL;
-	struct sk_buff *_skb = NULL;
 
 	WARN_ON(NULL == rtlusb->usb_tx_aggregate_hdl);
 	if (unlikely(IS_USB_STOP(rtlusb))) {
@@ -907,8 +904,7 @@ static void _rtl_usb_transmit(struct ieee80211_hw *hw, struct sk_buff *skb,
 		return;
 	}
 	ep_num = rtlusb->ep_map.ep_mapping[qnum];
-	_skb = skb;
-	_urb = _rtl_usb_tx_urb_setup(hw, _skb, ep_num);
+	_urb = _rtl_usb_tx_urb_setup(hw, skb, ep_num);
 	if (unlikely(!_urb)) {
 		pr_err("Can't allocate urb. Drop skb!\n");
 		kfree_skb(skb);
-- 
2.26.2

