Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F0F26FFD9
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIRO3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 10:29:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37960 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIRO3t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 10:29:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IESxEi081676;
        Fri, 18 Sep 2020 14:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=PoAYMXuVIvbXamrr9aIe7UrkFhAqYvW7rwr9JscQebs=;
 b=TaK5ww+Hbzw1TqOcxxs4RGjnpqLFFDsq/bsaNGizC24DIiFBt66KHG+GpypTfA4Wktte
 V3Ym42rTw+31Gt0BVf+koNIYdIQM3FNuS9RKI243YtCnqRjZEQbWR1xUVBgqEvtKJK7H
 nsCSWrVVHVRHOetngy3kOS6OT9g7dTWQtfCf0xvwAHW6EVjxLuEybDxL0zhRmaO/JAMH
 Anxs25UUNIekajAwctgCxoOAX4wtsMh67MDyiFavI4b7jtEaC/1opqxSO/7mQL2vAr2j
 F0D64xLQX2kDuIoAKKJDl1FLh/bIydCUNGqbSsUYF/SnvnUnlzD3ZbMqG27x2itMW6Bt 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33gp9mqfhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 14:29:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IEOwPn088849;
        Fri, 18 Sep 2020 14:27:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33megbhe7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 14:27:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08IERhRC017551;
        Fri, 18 Sep 2020 14:27:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 14:27:37 +0000
Date:   Fri, 18 Sep 2020 17:27:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ath6kl: wmi: prevent a shift wrapping bug in
 ath6kl_wmi_delete_pstream_cmd()
Message-ID: <20200918142732.GA909725@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180118
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "tsid" is a user controlled u8 which comes from debugfs.  Values
more than 15 are invalid because "active_tsids" is a 16 bit variable.
If the value of "tsid" is more than 31 then that leads to a shift
wrapping bug.

Fixes: 8fffd9e5ec9e ("ath6kl: Implement support for QOS-enable and QOS-disable from userspace")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
In the current code if the TSID bit isn't set it returns -ENODATA but
returning -EINVAL here should be fine.

 drivers/net/wireless/ath/ath6kl/wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index a4339cca661f..dbc47702a268 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -2639,6 +2639,11 @@ int ath6kl_wmi_delete_pstream_cmd(struct wmi *wmi, u8 if_idx, u8 traffic_class,
 		return -EINVAL;
 	}
 
+	if (tsid >= 16) {
+		ath6kl_err("invalid tsid: %d\n", tsid);
+		return -EINVAL;
+	}
+
 	skb = ath6kl_wmi_get_new_buf(sizeof(*cmd));
 	if (!skb)
 		return -ENOMEM;
-- 
2.28.0

