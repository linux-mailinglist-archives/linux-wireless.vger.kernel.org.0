Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC232AFA4
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbhCCA1j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:27:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50220 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446515AbhCBLSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 06:18:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122BF6OW177344;
        Tue, 2 Mar 2021 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=9cmRKCzbFBe71dxo2mYfYCi9TPoq4XL/rApJoJqKCJM=;
 b=qWSDjgU41jeYVJgy8uifz3mIlCftwOzLqCGX6cWqzyV9TJH/eq1L3ddo5irMJ0pDccxX
 AaUeU725aGrr7GB+6eGeNKtIADASg+U5tIW6B8vSrVUc8sgOiqhb5zB+7RT8BjovcJGR
 GVjc0L/0XSTKq2GwL3ss3lmdCcn/Go4biZJqiWXgDFUpuBWfxFZJXBtB7pUvehOX02fe
 Mvd3FKzsOrXhdeYVd4H3FFrQm+yGbQ2Qr+2eM/ur1a3SPbdKY0T1E37NjnJEpvysbkeu
 szjq8bMPICvNrlpcyC7qfw2QaMFODai0Ca/pq8t7wORuZ13QLEB5YDkVJvBQ/PzydHdf Rg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36ybkb7a7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 11:16:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122BF2Fl076188;
        Tue, 2 Mar 2021 11:16:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 36yyyyqtnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 11:16:54 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 122BGral004593;
        Tue, 2 Mar 2021 11:16:53 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Mar 2021 03:16:52 -0800
Date:   Tue, 2 Mar 2021 14:16:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, Jeff Garzik <jgarzik@pobox.com>,
        James Ketrenos <jketreno@linux.intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ipw2x00: potential buffer overflow in
 libipw_wx_set_encodeext()
Message-ID: <YD4enB/Er/5PWgUz@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103020094
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "ext->key_len" is a u16 that comes from the user.  If it's over
SCM_KEY_LEN (32) that could lead to memory corruption.

Fixes: e0d369d1d969 ("[PATCH] ieee82011: Added WE-18 support to default wireless extension handler")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
index a0cf78c418ac..27f15fa40528 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
@@ -633,8 +633,10 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
 	}
 
 	if (ext->alg != IW_ENCODE_ALG_NONE) {
-		memcpy(sec.keys[idx], ext->key, ext->key_len);
-		sec.key_sizes[idx] = ext->key_len;
+		int len = min_t(int, ext->key_len, SCM_KEY_LEN);
+
+		memcpy(sec.keys[idx], ext->key, len);
+		sec.key_sizes[idx] = len;
 		sec.flags |= (1 << idx);
 		if (ext->alg == IW_ENCODE_ALG_WEP) {
 			sec.encode_alg[idx] = SEC_ALG_WEP;
-- 
2.30.1

