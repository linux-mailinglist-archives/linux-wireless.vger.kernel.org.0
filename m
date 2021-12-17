Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E8478EDF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 16:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhLQPDd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 10:03:33 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12918 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237648AbhLQPDa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 10:03:30 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHF01Aq010295;
        Fri, 17 Dec 2021 15:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=y1XQkwgUwNHUwWjPFJSV3zLu6XKAraa6EEhTZ84233M=;
 b=HpQxWOkB0krva2LnMAlWH4k8v3G6ub5w4qf54WJ7ox8uehd6YQrY8m9RbA22pUJkvi/b
 XWTjPiOjk7xM+jLhr/JMafsLWmuzsCner40zHBRsrm8LIvvosOnU7hcaHMB7QgHodU0n
 If2KrbSerTcXy8ItSu60Lo+4ImYUupCLM1oWUi7gO+PYqYrhiOq5Svw9QNrWH6MWPhv1
 tA1/e4zhPsevXPdrXfM/u+/+DDc5rgVEJmGQ/8bByS9j9ZTjO4K/RO3cQafikKnQxZyz
 UI0FI4nw9orxFY8An98fCfh1hbNnHIHa5QkEJqT/Go6zZcDfjTv9fphOlDonCf/4ngz7 JQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknp5xxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 15:03:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHEuIPL195204;
        Fri, 17 Dec 2021 15:03:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3030.oracle.com with ESMTP id 3cyjubgy0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 15:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgIhMD8J0vHWzwTLMDZP+GPEKpMoZmu3LnwGvsuGFh5tJDrOekZaIYW4BIvTkDwM0q43x6y8I2RTx7IWtIh26gOQcM+Y4p53+0ObSfgBGoc8TwfsGEskcK/uOxEKagvdURf3KpvXEYyWJb0YQgwI9wJR3e6xr4Mxltyfn+OZlngbsK0Fw5madXxA7HGJGuDCctLtkfWFWOj+eYpJs0FS6PziCIOtLMWGYaQWi2uIiasu/7aFF3OuLmsHRGwVbucZjgs6Mz5yowOt2itksgVEe1VEkoUxNAanLeYtgxSXqXeM4o6tEBuVjFzasNiRo9aaojsiGkYMFnXs65TO/SS0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1XQkwgUwNHUwWjPFJSV3zLu6XKAraa6EEhTZ84233M=;
 b=ad/0JnTCW4hZ1yK9OGUhs/0bINvel/9++4AKoqrEu8u8LBUG1jtauUhbxCwlVBHEsY3rk99nFu7sCIb9MI0EQzQtnTSAtVU/cJsIQIFlCGCWnVxDDijPVhf92co3xAkzQRxKIldErcbxFVsbbHsbGc5Ki1DuC4njYAw8CTMzgHCW132EFKetVaMhGeY4/NBT6Wf8JdX5Pgsw5yBBO1G0a/s7by7MdgAC/HJmme3Xwl8vJeMkUeBGz/oEw4Bmtu5ygxwyBSLYmHyzBQ2tZXnl7S9ks+qTZkZuv1yUxee7ze8nj4uVjUhz/717D5Hbxqk3yiGQdNnATKxbM6lJ9pSaqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1XQkwgUwNHUwWjPFJSV3zLu6XKAraa6EEhTZ84233M=;
 b=VYs5cifN5eCFyQS7si+tdRUsvWMMdtRCQ9DRg2g+IoeufV+yAHO0wYwxvcAgYvoJhGpHCyxqL0LPs2STejE/8ovC/MGhCL1jeaoXiK7InKxQ7U6I0RBMJxd268l6/3d20FYIf5E9xu6aXvEHlGXzdK3kteJ6AvLDypKHoBX63tw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5849.namprd10.prod.outlook.com
 (2603:10b6:303:19b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Fri, 17 Dec
 2021 15:03:25 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 15:03:25 +0000
Date:   Fri, 17 Dec 2021 18:03:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wilc1000: fix double free error in probe()
Message-ID: <20211217150311.GC16611@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AS8PR04CA0019.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f9c579-73f1-46a0-8a01-08d9c16e5ff1
X-MS-TrafficTypeDiagnostic: MW5PR10MB5849:EE_
X-Microsoft-Antispam-PRVS: <MW5PR10MB5849455FD1A8595E2E1513E78E789@MW5PR10MB5849.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3aINGh60vd3XaQUC0W2fmwrC7svzwMC+pjBDa8wJRjeLxIvIrJIsWmUJCM+jo4v0fsQIiuc+8v5qY96+IIMz8K8Xxw7TjZfpahNZYsMzY+icDS4+uIgNJd11EwLuBdNVEW+IbW3z8TY9OiY29gF2Ca3l7wy2XecGcYrpLLyW2K3qFv50OtpwHumZ/VNOXdqEyFZMLqcBAnGr0HJrRMTkQ7gVY62vUZNalhcmPbd+TLfBr2c66anlC5HYjRx13+hPjTTJRxjZXfajg9PWGzYfGMnkP0tPceo8jekw6yJ9JPKzPTiXsqDOuOTmuWJr9IrvW9KqShN0tmaZlhn73oxJkhkemWPnR3U4YvWKP3SW8G9g0NGlzn4PkO0CU/gEV/jJLCAmSH+ukjfi2OLj7i7JWtEMCr30QmOeQdExJ55SOU0rHzmt2WeRc45/McH8+KhRFMQmSrMIDP0oKnQTtuXmmF8ZqYNOL3scONsMuOhrdIbkCv6XYaDob0U3lcepIBY6LIAcw6/Oq7O18mNO0S3wnWJEyAJyxgjeSvbjYN438Dg2xh1xaeogBJ2P/ryz/Q72FP1LVMp+i8z22l/u7UcFQLOGCd/hiPES9i5NWSYWBtWsYTQ0tAZJRllUStljuBJ2OorTfAj+uH1g8k75NazIs9m/9DJGPIjeOgl8xZTA3VPjCroZKq2kwQheVdNAqHqokT0/gJucG5QKqTQozrIAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(33716001)(508600001)(110136005)(38100700002)(4326008)(66946007)(8936002)(44832011)(66556008)(6512007)(52116002)(2906002)(38350700002)(6666004)(1076003)(66476007)(9686003)(6486002)(5660300002)(26005)(8676002)(186003)(316002)(86362001)(6506007)(33656002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A6+W5gao5Bf5p0p1Q6nYbYOGCqhzY+TI+lhqHVh2204tiCsGYPgMfycf2yzr?=
 =?us-ascii?Q?y9xJlnUXAlktw9G20rRAYpzcsndVbPg6oQDmaUxTFNwlthyh7ZuqqcHD1NSQ?=
 =?us-ascii?Q?9SIbFPo2kvxIDnJku4K8VuCNNOHmXHGqrFB3whFi0OWhdPu9HN+BkH8xsAfM?=
 =?us-ascii?Q?VHF75emePJ4IVLJyM65m+wfgAA4dbOwZi8VkY9jHu3/R/YdEudfqBY6sV0ic?=
 =?us-ascii?Q?pBreqE/kDB/YInTqwyIe8YNGKNJpXJLvrbo2oE6Q8vrNTmPRTiLVdGnfXC/n?=
 =?us-ascii?Q?j91eumFfbZED4nMDWthZmQgTAaFC+53ZrqA0fSc14oJH8+2sKUT9ymEPAkpY?=
 =?us-ascii?Q?Z4VKpNzkMaxItyuu2Oi2erK5dW2In49ORbx8nG17e8EtJzWUuJx2FjgX/2nb?=
 =?us-ascii?Q?+6mPkALLdGRLd8vnN3CWXsh7CNF1fpPXPz+L7OQCxuSrrXzgs+HGrK/cn20x?=
 =?us-ascii?Q?KWJaY/poEIgcY4r7mSpE/fvnRd/8teFJx8rAmsPdL3wYPQ4gFb4sAEPQsJxu?=
 =?us-ascii?Q?UPly48mCO29sh1gIQZVpBY4vPrirJG6QgfzANxR5tGl4bzPjHWreyHETyLjU?=
 =?us-ascii?Q?37e2Gqi26xA8bRuS4JejIdupsOF+1zQJN9QcTzVXFBshdHIpEuOUSmnoWBoz?=
 =?us-ascii?Q?ISNxFEWOmoYUmhDPz631UAzjC5ZdxvWcRnwJIuP4tGJ/xaCKjhuYpC8h5StP?=
 =?us-ascii?Q?4T2A8AKG//sDRzPvS1DUldLmjgNCPKLWD7XPEADfXQ3aweRPRye/icMBgGGM?=
 =?us-ascii?Q?W4/dRTh2z1qoPzZDiC0EdfPTXIXjy4xXV/R6XtT/NKD0Ebc4ZahifW399CHl?=
 =?us-ascii?Q?UUPClMYdm+GncVEVpNhzV6JxOdW4nu00Q2O1whbu17gJu+eYg8hwTIQTesGf?=
 =?us-ascii?Q?HMBXB/I/MaTkRyUpuYQ7I7Wcdq8agyzoAuVjxMTHZ7S/I+qZCHMESxcQ05bX?=
 =?us-ascii?Q?67xS4J0HO0NNhAtHu6FTkVqHGVVXkiotuMDYhG3BjdWDN/o2+bSh9ixZLz9k?=
 =?us-ascii?Q?h8o+CH4SrtT1SL3TP6muSBasbOj6GSv0IZ7rY/KZ08G+jWJXSU3pG/nwk9A8?=
 =?us-ascii?Q?TcnDWkuCx7pCxwKbbupD1cjrO7CrLSsnd1nWDU/otRb9B1q8CYNdWKTd0tLJ?=
 =?us-ascii?Q?ZgAtb/aL9rT3idmOEo3Rt5JX1Irui4nfTa2n9tj4rLyZaT0h5Bb4aHX3yCoH?=
 =?us-ascii?Q?6EdsjLIBkcWhQ7lXd6vAiMcO6bUrBXSXJijG0g4fLCB1ZFQ/QNt2c7Rlvjby?=
 =?us-ascii?Q?T1kxSMaVGosf3+UqCddqI4cnlbSM7lq5jClKFPgfuKa946/zjtrTnnOsEzoU?=
 =?us-ascii?Q?mYyGbF7wDNPbho/PNfNdK476WMl2/RnQ/BwZxutOmW+wn1iGnOmx2whp0FtX?=
 =?us-ascii?Q?0mZ/uIvfyi2GlBeyi0Iv/fMAtNZysdY7/Vdo6stLO6yz1VmWARtyXH6x4sNy?=
 =?us-ascii?Q?0xa1dFJ/ns0m1k4S5+uqRA1sCaYP/FDqBqXArRYmIy5GvvTTEKKujAZXM/Yd?=
 =?us-ascii?Q?XkHXMHjjt640w4zYF0/oAfYLw6RGjINMsZSkt58NA3kZpDg0CVb/XeUpWnSG?=
 =?us-ascii?Q?Iq5bakrkAKBmOgE8qLWfwyA621a2vkGhQwOqnM5LXB/9vrzdQYTEpud2gAaf?=
 =?us-ascii?Q?fzeI9o0KVlDalQaasnjI2nFDcuCb9ce9qEC4voMEoE14RSuzCh+Pi3nU1llK?=
 =?us-ascii?Q?hYeGJ5TjN4X5XyfP5inE9FdG5rQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f9c579-73f1-46a0-8a01-08d9c16e5ff1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:03:25.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4L1oEf+VF92jJ1HVmime4e3RFrqQPEyFjhjDgve03Gff35o7BGQ2CzVzLaLQdNW6kg5vyyxqfobV3xLjt6edWf+RydbX2WMzLxB8el8H+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5849
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170087
X-Proofpoint-ORIG-GUID: h5ZdFt3blIF8teXvDG-g7wDKaVimtLzH
X-Proofpoint-GUID: h5ZdFt3blIF8teXvDG-g7wDKaVimtLzH
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Smatch complains that there is a double free in probe:

drivers/net/wireless/microchip/wilc1000/spi.c:186 wilc_bus_probe() error: double free of 'spi_priv'
drivers/net/wireless/microchip/wilc1000/sdio.c:163 wilc_sdio_probe() error: double free of 'sdio_priv'

The problem is that wilc_netdev_cleanup() function frees "wilc->bus_data".
That's confusing and a layering violation.  Leave the frees in probe(),
delete the free in wilc_netdev_cleanup(), and add some new frees to the
remove() functions.

Fixes: dc8b338f3bcd ("wilc1000: use goto labels on error path")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 1 -
 drivers/net/wireless/microchip/wilc1000/sdio.c   | 2 ++
 drivers/net/wireless/microchip/wilc1000/spi.c    | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 03e3485d7e7f..643bddaae32a 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -905,7 +905,6 @@ void wilc_netdev_cleanup(struct wilc *wilc)
 
 	wilc_wlan_cfg_deinit(wilc);
 	wlan_deinit_locks(wilc);
-	kfree(wilc->bus_data);
 	wiphy_unregister(wilc->wiphy);
 	wiphy_free(wilc->wiphy);
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 26ebf6664342..ec595dbd8959 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -167,9 +167,11 @@ static int wilc_sdio_probe(struct sdio_func *func,
 static void wilc_sdio_remove(struct sdio_func *func)
 {
 	struct wilc *wilc = sdio_get_drvdata(func);
+	struct wilc_sdio *sdio_priv = wilc->bus_data;
 
 	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
+	kfree(sdio_priv);
 }
 
 static int wilc_sdio_reset(struct wilc *wilc)
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wireless/microchip/wilc1000/spi.c
index e0871b89917d..5ace9e3a56fc 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -190,9 +190,11 @@ static int wilc_bus_probe(struct spi_device *spi)
 static int wilc_bus_remove(struct spi_device *spi)
 {
 	struct wilc *wilc = spi_get_drvdata(spi);
+	struct wilc_spi *spi_priv = wilc->bus_data;
 
 	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
+	kfree(spi_priv);
 
 	return 0;
 }
-- 
2.20.1

