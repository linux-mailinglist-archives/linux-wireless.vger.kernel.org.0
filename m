Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D198435EFA4
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350064AbhDNIag (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 04:30:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54598 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348357AbhDNIad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 04:30:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E8TJSg028328;
        Wed, 14 Apr 2021 08:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=G1fYSfuXOphxN5Fqq4MLcXUEV47D2LMEy9TBOwWoUWs=;
 b=DQ1FBhK6c0FG7yG+fiVSJJx3UvNBWAUmfSnZIKI10i3viOzdQzniVbLzYYzYP3+dmATo
 728xi1nzgMcTu68HXgb2NqjDjFRS3dTrX6By35K5kZeq0qW7jjluULCDcU8/Zl8IDEqN
 mhbWrByZTZzAVnX7KESc79AX7f7hAKdYYY3W1WtT3aTAJBUO6tUiLxCukqmb+bgO5hBR
 McnnSVIuSWK0mgJrFEypcTi6w8wmoTKqdTkxcTBLZlPROEndSBRhn9ttHm1YxfE9Gpop
 3SUgEvZNGQ8rFieeWMz58+cPPVMCJkd6Hi2Bp7tXkea2loCgDfS2VDowlMIWM+ooTx5s HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37u4nnhhca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 08:30:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13E8KOD5080821;
        Wed, 14 Apr 2021 08:30:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 37unxy2e37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Apr 2021 08:30:03 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13E8U1Nx029437;
        Wed, 14 Apr 2021 08:30:01 GMT
Received: from mwanda (/10.175.166.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Apr 2021 01:30:01 -0700
Date:   Wed, 14 Apr 2021 11:29:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        James Ketrenos <jketreno@linux.intel.com>,
        Jeff Garzik <jgarzik@pobox.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] ipw2x00: potential buffer overflow in
 libipw_wx_set_encodeext()
Message-ID: <YHaoA1i+8uT4ir4h@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140058
X-Proofpoint-ORIG-GUID: BEsJqhmg-tg6YZjzmZFU3zGiwmifh5Tr
X-Proofpoint-GUID: BEsJqhmg-tg6YZjzmZFU3zGiwmifh5Tr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104140059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "ext->key_len" is a u16 that comes from the user.  If it's over
SCM_KEY_LEN (32) that could lead to memory corruption.

Fixes: e0d369d1d969 ("[PATCH] ieee82011: Added WE-18 support to default wireless extension handler")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: use clamp_val() instead of min_t()

 drivers/net/wireless/intel/ipw2x00/libipw_wx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
index a0cf78c418ac..903de34028ef 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_wx.c
@@ -633,8 +633,10 @@ int libipw_wx_set_encodeext(struct libipw_device *ieee,
 	}
 
 	if (ext->alg != IW_ENCODE_ALG_NONE) {
-		memcpy(sec.keys[idx], ext->key, ext->key_len);
-		sec.key_sizes[idx] = ext->key_len;
+		int key_len = clamp_val(ext->key_len, 0, SCM_KEY_LEN);
+
+		memcpy(sec.keys[idx], ext->key, key_len);
+		sec.key_sizes[idx] = key_len;
 		sec.flags |= (1 << idx);
 		if (ext->alg == IW_ENCODE_ALG_WEP) {
 			sec.encode_alg[idx] = SEC_ALG_WEP;
-- 
2.30.2

