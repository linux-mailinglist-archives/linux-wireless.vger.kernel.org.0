Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF0410FB3D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2019 10:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLCJ71 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Dec 2019 04:59:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLCJ71 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Dec 2019 04:59:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB39mqEV046169;
        Tue, 3 Dec 2019 09:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=GMmw6G30mIhLrf+EFWdyjTxFBTqyY4JokeFFwksph9A=;
 b=lOxFiOmjrnmy0QWfJXoLjFbVVNQiOi9BcydMqsyoOtXJNRNIf69qDGV+Tgv8qtxhfBi5
 FCwlr9xl8hv7MDb0gfxcMj7tEE2juMPv8E3mK11eDOMOR7HWm1XUXR/3+Ub405ap2yh5
 VlWiSAFyuAkTUqjyT7Uy1T40M78PduaBCooZcFJgoi9fQz4SRM9T3v6AqdgxKw2K2S7I
 2sjT9xRdR33uWSimE7axv4w4nacVeGD2R3PBatj39nhMSAn2T4vaXoe2gb2ONNqlRa9e
 MWLySRIaiQSgQE+ClNkHW5Q9zs2j3hkbDxfmWzMIXbXLCOoLfR/MTcwdZ0TmDOIbtKFr MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wkfuu6me6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 09:59:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB39m0SB020392;
        Tue, 3 Dec 2019 09:59:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wnb7xcq00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Dec 2019 09:59:13 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB39xBMV022039;
        Tue, 3 Dec 2019 09:59:11 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Dec 2019 01:59:10 -0800
Date:   Tue, 3 Dec 2019 12:58:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <frankyl@broadcom.com>
Cc:     Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Naveen Gupta <naveen.gupta@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, kernel-janitors@vger.kernel.org
Subject: [PATCH] brcmfmac: Fix use after free in brcmf_sdio_readframes()
Message-ID: <20191203095855.c4fradmsixgbq7mc@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912030080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9459 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912030080
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The brcmu_pkt_buf_free_skb() function frees "pkt" so it leads to a
static checker warning:

    drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:1974 brcmf_sdio_readframes()
    error: dereferencing freed memory 'pkt'

It looks like there was supposed to be a continue after we free "pkt".

Fixes: 4754fceeb9a6 ("brcmfmac: streamline SDIO read frame routine")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static analysis.  Not tested.

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 264ad63232f8..1dea0178832e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -1935,6 +1935,7 @@ static uint brcmf_sdio_readframes(struct brcmf_sdio *bus, uint maxframes)
 					       BRCMF_SDIO_FT_NORMAL)) {
 				rd->len = 0;
 				brcmu_pkt_buf_free_skb(pkt);
+				continue;
 			}
 			bus->sdcnt.rx_readahead_cnt++;
 			if (rd->len != roundup(rd_new.len, 16)) {
-- 
2.11.0

