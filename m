Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74618218695
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2020 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgGHMAT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jul 2020 08:00:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgGHMAT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jul 2020 08:00:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068BuYnJ063072;
        Wed, 8 Jul 2020 11:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=CNkHcVqpr2PvFaU+AfAP4pE+AL29SMeRb57m9uYhXGw=;
 b=HhV3dPcW5rMf+vHN9ggWPIpf1wRhqqf8ZmuHPcRflI2p82WdApvZbPjKLJtZuJqMF5q6
 h4Xe1pZm124+H9X1E+ihPGaRphkTRM3dOX8S1tfXQgEFhqd45Cl4k6URdBmieBbjeu5q
 iCOFDP1nf4+wTCV9TFUDnHS+90Q7l7+6G1G2HoYAlo2fZ7a5wgiNLvej8x6zwyQnUEto
 rzbUko0iMLATCdadZpO3+OuraOmvdeThuC5I0QhMR9P8HX+SqEvu3i6Zri+9MU83a/zj
 ayuCORpaLyireAw9q6P1q44XnbVGqohWhMVTdXb6+MAObvtJu5tpdhoQShxaIkMK83H9 2Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 325bgf0tb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 11:59:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068BxESx146405;
        Wed, 8 Jul 2020 11:59:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3233bqr6v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 11:59:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 068Bx5eZ023965;
        Wed, 8 Jul 2020 11:59:05 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 04:59:05 -0700
Date:   Wed, 8 Jul 2020 14:58:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        Bing Zhao <bzhao@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Marc Yang <yangyang@marvell.com>,
        Frank Huang <frankh@marvell.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] mwifiex: Prevent memory corruption handling keys
Message-ID: <20200708115857.GA13729@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 clxscore=1011
 mlxscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080087
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The length of the key comes from the network and it's a 16 bit number.  It
needs to be capped to prevent a buffer overflow.

Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is from static analysis.  Please review it carefully.

 .../wireless/marvell/mwifiex/sta_cmdresp.c    | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
index f21660149f58..267b02cde30c 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c
@@ -580,6 +580,11 @@ static int mwifiex_ret_802_11_key_material_v1(struct mwifiex_private *priv,
 {
 	struct host_cmd_ds_802_11_key_material *key =
 						&resp->params.key_material;
+	int len;
+
+	len = le16_to_cpu(key->key_param_set.key_len);
+	if (len > sizeof(key->key_param_set.key))
+		return -EINVAL;
 
 	if (le16_to_cpu(key->action) == HostCmd_ACT_GEN_SET) {
 		if ((le16_to_cpu(key->key_param_set.key_info) & KEY_MCAST)) {
@@ -593,9 +598,8 @@ static int mwifiex_ret_802_11_key_material_v1(struct mwifiex_private *priv,
 
 	memset(priv->aes_key.key_param_set.key, 0,
 	       sizeof(key->key_param_set.key));
-	priv->aes_key.key_param_set.key_len = key->key_param_set.key_len;
-	memcpy(priv->aes_key.key_param_set.key, key->key_param_set.key,
-	       le16_to_cpu(priv->aes_key.key_param_set.key_len));
+	priv->aes_key.key_param_set.key_len = cpu_to_le16(len);
+	memcpy(priv->aes_key.key_param_set.key, key->key_param_set.key, len);
 
 	return 0;
 }
@@ -610,9 +614,14 @@ static int mwifiex_ret_802_11_key_material_v2(struct mwifiex_private *priv,
 					      struct host_cmd_ds_command *resp)
 {
 	struct host_cmd_ds_802_11_key_material_v2 *key_v2;
-	__le16 len;
+	int len;
 
 	key_v2 = &resp->params.key_material_v2;
+
+	len = le16_to_cpu(key_v2->key_param_set.key_params.aes.key_len);
+	if (len > WLAN_KEY_LEN_CCMP)
+		return -EINVAL;
+
 	if (le16_to_cpu(key_v2->action) == HostCmd_ACT_GEN_SET) {
 		if ((le16_to_cpu(key_v2->key_param_set.key_info) & KEY_MCAST)) {
 			mwifiex_dbg(priv->adapter, INFO, "info: key: GTK is set\n");
@@ -628,10 +637,9 @@ static int mwifiex_ret_802_11_key_material_v2(struct mwifiex_private *priv,
 	memset(priv->aes_key_v2.key_param_set.key_params.aes.key, 0,
 	       WLAN_KEY_LEN_CCMP);
 	priv->aes_key_v2.key_param_set.key_params.aes.key_len =
-				key_v2->key_param_set.key_params.aes.key_len;
-	len = priv->aes_key_v2.key_param_set.key_params.aes.key_len;
+				cpu_to_le16(len);
 	memcpy(priv->aes_key_v2.key_param_set.key_params.aes.key,
-	       key_v2->key_param_set.key_params.aes.key, le16_to_cpu(len));
+	       key_v2->key_param_set.key_params.aes.key, len);
 
 	return 0;
 }
-- 
2.27.0

