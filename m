Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238E0200B72
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2020 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgFSOaJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jun 2020 10:30:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53094 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgFSOaI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jun 2020 10:30:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JEDIFx158879;
        Fri, 19 Jun 2020 14:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=B/h4/Smp0b+GZtYXT6WoZKLL0Di7be3tZw+sca6yhxU=;
 b=dXxPQTrfkwbSmVjHZu3Y0c+Jap5JtawE0xiYy7epxZj/QQqeTULL7gf0U8U24Cgk7yOk
 Is04EMvpx9/lhlDucePvHb5TE+DZtvWKjaFdXEHUS68hp4JZdhx8oAIHsizZqUn14RfM
 zD3LsKO961e41aN52dc53PPjaGaSU0OaiPgpxrkGxPVQsrDrsqwcHbabT4ccykm4jlwq
 u3krZgjb2wvkIsohYtKtLHWxVLTFLncy5Yw/NR8+/XU10bfUzH+UvFtufNiyeHxlylN+
 MUmJSC1XpQsZD8E1vlHtq0/BxtYK20jXV42wBHR+Q4QwQm/VY3OryxYv2+g5K7SStS5z 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31qecm5ju6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 14:30:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JE9Og7111375;
        Fri, 19 Jun 2020 14:30:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31q66vm0j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 14:29:59 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05JETw3q008177;
        Fri, 19 Jun 2020 14:29:58 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 19 Jun 2020 07:29:28 -0700
MIME-Version: 1.0
Message-ID: <20200619142922.GA267142@mwanda>
Date:   Fri, 19 Jun 2020 14:29:22 +0000 (UTC)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] ath11k: fix uninitialized return in
 ath11k_spectral_process_data()
X-Mailer: git-send-email haha only kidding
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9656 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 malwarescore=0
 clxscore=1011 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190106
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is a success path where "ret" isn't initialized where we never
have a ATH11K_SPECTRAL_TAG_SCAN_SEARCH and then ret isn't initialized.

Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 1c5d65bb411f..bfbf905f7507 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -677,7 +677,7 @@ static int ath11k_spectral_process_data(struct ath11k *ar,
 	u32 data_len, i;
 	u8 sign, tag;
 	int tlv_len, sample_sz;
-	int ret;
+	int ret = 0;
 	bool quit = false;
 
 	spin_lock_bh(&ar->spectral.lock);
-- 
2.27.0

