Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB42252C9E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgHZLlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 07:41:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbgHZLgi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 07:36:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBYwZW136003;
        Wed, 26 Aug 2020 11:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=i9IEF04lloPCY2BXKlzUh8baD/0kEGW5us6maMcfgLE=;
 b=XrQX+cynp0UrQP6cRjccIkFR7WzFtkKUxNmnodPyQL6lGUu7kAEFcV1Q2+ZE/qxwEUxY
 PRlmSmO5gEYZPcZlvUsFSssPdkY+NTjpZi0c+ueLrfbu7wVGZMxZiGwpnSv7czroVQlk
 JQYrvS75TQazMRiNCr7c3rFtQYeYa5CPcw1xWVZVazhWoOecKuqcRkK+NbMmdAjg7WL9
 S7Rc2Tf2vX5KkumwVYk4YUQ2FzOPGCqhvN88/YzQWk8Nuu0pHf0rKNJAAolJ3NZCQtN/
 iAkARXMz6wcixhQZxD9qKaHCwHpVEHsrqHIJRKDFabaQuxAYRv3w6/bQXoQ/OUOctWxm Hg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 335gw81p8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 11:36:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07QBUEMr001026;
        Wed, 26 Aug 2020 11:34:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 333rua2bqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 11:34:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07QBYOLR022202;
        Wed, 26 Aug 2020 11:34:24 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Aug 2020 04:34:23 -0700
Date:   Wed, 26 Aug 2020 14:34:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Govind Singh <govinds@codeaurora.org>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] ath11k: return -ENOMEM on allocation failure
Message-ID: <20200826113417.GE393664@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260094
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Returning PTR_ERR(NULL) means success, but we should return -ENOMEM.

Fixes: 1399fb87ea3e ("ath11k: register MHI controller device for QCA6390")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index d7e60dc5b300..aded9a719d51 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -220,7 +220,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 
 	mhi_ctrl = kzalloc(sizeof(*mhi_ctrl), GFP_KERNEL);
 	if (!mhi_ctrl)
-		return PTR_ERR(mhi_ctrl);
+		return -ENOMEM;
 
 	ath11k_core_create_firmware_path(ab, ATH11K_AMSS_FILE,
 					 ab_pci->amss_path,
-- 
2.28.0

