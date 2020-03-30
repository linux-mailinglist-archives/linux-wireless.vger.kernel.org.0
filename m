Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D14E21973D3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2020 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgC3FZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Mar 2020 01:25:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:40684 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgC3FZf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Mar 2020 01:25:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200330052532epoutp03e6ac006f16216ff8665d7f6d6300c1ae~A-Z-2mjQe1632816328epoutp03C
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2020 05:25:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200330052532epoutp03e6ac006f16216ff8665d7f6d6300c1ae~A-Z-2mjQe1632816328epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585545932;
        bh=g7ucxEv2KLCs/+6yXO7PIROft+/NEWLtfTbNPQuUzck=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ABHbM2GvjN4OzE6l1hg1ESxthI64cQ2u6LOFXQLhX7JRbPz31xNc1cdse3XBtq2H8
         odtunOcCW9fgrI1JFhQ57rsMMaQJZj4r5AEMez8PrZnijAZmD7NvCL6NA4s3WPj4Va
         AJWGsrMpHzZYR8f6tYBQaGF1lHNPKbr0boe9Jh3E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200330052531epcas1p12d3fbddab49e500a7c8caf575e71e19d~A-Z-bLBly2591925919epcas1p1I;
        Mon, 30 Mar 2020 05:25:31 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48rLWq0l8YzMqYmD; Mon, 30 Mar
        2020 05:25:27 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8A.B3.04140.1C2818E5; Mon, 30 Mar 2020 14:25:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433~A-Z1oNNAC2591925919epcas1p1z;
        Mon, 30 Mar 2020 05:25:21 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200330052521epsmtrp28c3574ee5ce1964a730e08d68350efca~A-Z1nUhT10519805198epsmtrp2d;
        Mon, 30 Mar 2020 05:25:21 +0000 (GMT)
X-AuditID: b6c32a36-fa3ff7000000102c-ee-5e8182c1c348
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.43.04158.1C2818E5; Mon, 30 Mar 2020 14:25:21 +0900 (KST)
Received: from jaehoon-DeskTop.10.32.193.11 (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200330052521epsmtip24df48ed902f0085a57a61982e9fa3eba~A-Z1aAslN1473814738epsmtip2N;
        Mon, 30 Mar 2020 05:25:21 +0000 (GMT)
From:   Jaehoon Chung <jh80.chung@samsung.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] brcmfmac: fix wrong location to get firmware feature
Date:   Mon, 30 Mar 2020 14:25:28 +0900
Message-Id: <20200330052528.10503-1-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRT3u3e7XleL2zL7GJTrktDLteucXfMVPYcVSQZBke6iF5U92Z2R
        VmAaassie1itIpWMMihL02X0cFJiWmkmLdECM1HTEk2xNOxuV8n/fud3zu/7nXO+g6OyEkyO
        p5lsrNXEGEhMIqquXxUcXJd9PEH1+RVN15QNiujRE7kIPVQ4jNFDeUUIPVHah9ET3W4R7f6T
        K6ZL75RgdFvtNYwevN3pS1+aeIJsnKd1fHmDadvOnEa0udlp2jNV5UA7+nBZnHi/PjKVZZJZ
        q4I1JZmT00wpUeSO+MTNiZowFRVMhdPrSYWJMbJR5JadccHb0gx8Z6TiEGNI56k4huPIddGR
        VnO6jVWkmjlbFMlakg2WcIuSY4xcuilFmWQ2bqBUqhANX6jTp9affIBa7kgO992awrLAFG4H
        fjgkQmHN5LivHUhwGeEEsHfALRaCEQDtBS4gBOMA9hc0+s5KTrnfYELiKYBue53Yk5ARkwDW
        j+zxYIxYC2vGGxAP9idIeLqlHPUIUKISgRfqf3oFi4itsOm1y1skIoJgyeURkQdLiQjYWlcm
        EtwCYWnWJCLwC2HjlR4vj/J8zqOr3kch8QKDfS8rZtrbAk+dfYkKeBEcaKia4eVw9MdTTMBH
        YG1O84w4H8CO6mxESKjh87LzPMZ5h1Xwfu06gV4OH09eB4LxAvhjrEDsKYGEFObnyoSSFfD9
        935k1qqrZ1osYC0c6nJiwoIOwun2FnAWBDrmjOOYM47jv3ExQMtBAGvhjCksR1lC5n7rQ+A9
        z9VhTlD6dqcLEDgg50uHa7ISZGLmEJdhdAGIo6S/FNvNU9JkJiOTtZoTrekGlnMBDb/tQlS+
        OMnMH7vJlkhpQtRqNR1KhWkoilwivfjRkCAjUhgbq2dZC2ud1SG4nzwLrMFvvqv06706SOl6
        11T44M6pzgVBkr3FzyK+xbbGVDmVN+THjIGMJCZAcS5M1/Fbhyqp/vi2lpjqpXWOlvDouMxN
        yqKJocK327d/GAz/OjbuU1Rt79J98sm5qD/Q9Cs/JJKrjT3cdFSfh8Q27Ss7t1JdebfHofrb
        vKu9+xZ+b4oUcakMtRq1csw/rnT+DrQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSvO7BpsY4gzM3BSy2L33DYvG5pY3J
        4u3ED2wWb9unMVn8WPSCzeLHoxssFjd+tbFaLFq5kM3i8q45bBZvVtxht5j+YzeTA7fHrPtn
        2Twu9/UyebQ1ZXr0bVnF6PF5k1wAaxSXTUpqTmZZapG+XQJXxuHOjcwFK7kqXiz7w9bA+Iej
        i5GTQ0LARKL7xlm2LkYuDiGB3YwSf1vamSESUhKfn04FSnAA2cIShw8XQ9T8ZJRY+nI1E0gN
        m4COxPZvx8FsEQElid4Lq5hBipgF9jJJXG2+zA6SEBZwlTh96hBYEYuAqsTCGZ9YQGxeAWuJ
        iweXskAsk5dY1PCbCSIuKHFy5hOwODNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhg
        lJdarlecmFtcmpeul5yfu4kRHMxaWjsYT5yIP8QowMGoxMP7YXtDnBBrYllxZe4hRgkOZiUR
        XjZ/oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe+fxjkUIC6YklqdmpqQWpRTBZJg5OqQbGyHXH
        Q5ddnWEdLxl+4dtztyeBDN1tu7mPn7jKdZBDWPVRUXlzYcilBbM0DTs9J+dvSDNbIGQx01da
        M+SQY9u7syaph4V3FRc18Xx/b8L15plFx/7ZDCdFl2s7HgyYeddYuyxShvOcoN9nIfcFrGyv
        2Ot5j/eY5TLzPPPY7+J7iivXIHpRxzUlluKMREMt5qLiRABFpW3lYgIAAA==
X-CMS-MailID: 20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433
References: <CGME20200330052521epcas1p1eedc926d4b11513f8502cf0c90ecf433@epcas1p1.samsung.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sup_wpa feature is getting after setting feature_disable flag.
If firmware is supported sup_wpa feature,  it's always enabled
regardless of feature_disable flag.

Fixes: b8a64f0e96c2 ("brcmfmac: support 4-way handshake offloading for WPA/WPA2-PSK")

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
index 5da0dda0d899..0dcefbd0c000 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
@@ -285,13 +285,14 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
 	if (!err)
 		ifp->drvr->feat_flags |= BIT(BRCMF_FEAT_SCAN_RANDOM_MAC);
 
+	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_FWSUP, "sup_wpa");
+
 	if (drvr->settings->feature_disable) {
 		brcmf_dbg(INFO, "Features: 0x%02x, disable: 0x%02x\n",
 			  ifp->drvr->feat_flags,
 			  drvr->settings->feature_disable);
 		ifp->drvr->feat_flags &= ~drvr->settings->feature_disable;
 	}
-	brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_FWSUP, "sup_wpa");
 
 	brcmf_feat_firmware_overrides(drvr);
 
-- 
2.26.0

