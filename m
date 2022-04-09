Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5364FA55C
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Apr 2022 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiDIGPW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 Apr 2022 02:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiDIGPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 Apr 2022 02:15:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2FED0AAC;
        Fri,  8 Apr 2022 23:13:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2394Lw54008887;
        Sat, 9 Apr 2022 06:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ooZE9BAWe1N5lQc+of3yV6j4rv2OD92U1XGxFDo8Vps=;
 b=GGjnDfFSY8iR4Sx6wH5LxfPM68cg5CS9tbX/yrN5liEhj/BoBjJpplckJ9/HL9OehfNd
 lHwww+jogQNLLrsQ8WxYNqmwtaG5I7qJEZ5t1ysd1wEoPEEA2d1fDnoS0I53ODHsayjl
 c4y3AuZVevmQsWjEwPdj/OadxMGds+yX9DbGn09H81qhTwDc8+GnIyshIlwiUtrV5USj
 hwVpTQiHBFbASSoV3KbIUwaemrMhSsePqxHnYeUt5oa4KQhK4/Vj5A7zcqG6JrIq7/4I
 7THLEqmw1uRzDbXUFKH3dXce3xd29rBjLI3r8StyYEmkqerMExehkdDp8u9R1CY2F3bX 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0x284gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Apr 2022 06:12:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2396BeQM019398;
        Sat, 9 Apr 2022 06:12:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0jyuv54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Apr 2022 06:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBeSmw8JsBCGd2Gq19IEBDm0cmdglmRKNRlBW+1wRCoY0dxhJR/0gniyZbrhoE+E66VVphGdyRxnwaH91ONa1sV3KnlTgvm5Wwd4txm8sjaVkBPVRfr82Wlt0FkTr7ACLLLOZT1e/NFyGVD6MdaEW61NrLaPTVg1gyBvC+u1FUuPeKzGQxqOe/X7QDTR3fYfcSW/qOS+G0ghf7fS6hrOyWIzFC5eCM2lPANvXPD7K7DiF5lEWuMQgHLdyF1dIGjVSRd11Tww9OLLgKwMZMXIz00MWXqBFwFaMQ7vt5NDc09hsqM2XRXJeP/vC0pGEGE01YaKtPxzpxnCMzzqxDZFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooZE9BAWe1N5lQc+of3yV6j4rv2OD92U1XGxFDo8Vps=;
 b=bvrl7VsnQ0j+c3IdFG0XxXDyTYJ6smgCvTN2ZeYCGmOaNFa63ymfKGtcFcf5UFZh5Ss786DW0lsfmMx6eDYf2GRdSYghbrsXlOJBP9EwKH0zK18ycidZr6e/29ziGwJ+1h9CK9n3E/W3lHqgi5BKvcZHrZ+KQeyl9f7ASlZv1CzKycRz5oCCTUqMJynnOJcczuNBMURxjAJgyzWOmc7oNxz/hmgNv9E9m5haMfKI6E+rYIu7xGOxsnzSQFek4ICmu8te2egBm+pcapBNMXn3J9BFMC601vHWEyzJ1SOdnkN0a6Ia634ZN/E29qPqrJeaPV6PTRQj3SAcU5nnh4TWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooZE9BAWe1N5lQc+of3yV6j4rv2OD92U1XGxFDo8Vps=;
 b=jRNH8VWyKE6UaI1qHPZeGWyXh/XWuvakh3I4h8W7AwL+tz0MW+ONa4+jCv/mtRg9Pe2++0mZAfnh04PZGiZR1Chh28m4dbU6SOwUQP+lfW1OojgC9aGOlY7shwGoDhc3fbW65tyt+QfHEBUBzFQwYKic69ie2+zBQ6yPxiOaGSo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB1681.namprd10.prod.outlook.com
 (2603:10b6:405:7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Sat, 9 Apr
 2022 06:12:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5144.022; Sat, 9 Apr 2022
 06:12:39 +0000
Date:   Sat, 9 Apr 2022 09:12:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Oleksij Rempel <linux@rempel-privat.de>
Cc:     Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ath9k_htc: fix potential out of bounds access with invalid
 rxstatus->rs_keyix
Message-ID: <20220409061225.GA5447@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df66297b-bb5c-4968-305e-08da19eff33e
X-MS-TrafficTypeDiagnostic: BN6PR10MB1681:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB168179B3CA0FD6DF1CB847608EE89@BN6PR10MB1681.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ajXrxpGj8sYy1shevnrYOEgcPuM2psLJULXbv8/E0gh9cSr93zm8e+uYMRCdvm55rHzvk7Bae3I9liDCO1WaaTP9l2f659yM6Tvof15MvtFhfFu+ObRzAmk1bqYp0v//7jI/wp3D9jSF6bai2oH4DPKYtaonXCaFxA0s/xEYuDYEt0453nuRdnfyL4xaC5+Y68QTW/AFYoeliDW3Gx0sfmhQYS1AyOflOoWx1I4UE+7sS4DGgPaMpNVb/eqWkxYOn7yS+J1T+B+2NpKW1IpmdOT+tuiyWLHWPuQiMfczvbHPo4YF8Xha+cZUYh7gdDyWezOIzQhmOcFgoKiQyZZiLWLRveEwElFcpsrxQe56uvFnpc1TQxYu2slZ4sI5pgXqVGEVNlJdwa14o7ks3tMQmzS0f735an1Y+LJ9YCqsKMVhBFa9SyVSyCdRgaMkbGXY3uhM07yvqKl6yv2cyf2wSMZNzQT1O7weYOeqZYcmCeS6E9zdnuwLwBznuzYZwLgB44adgU83OASyyr939XISOsqs7ijAo7uUWlw4lZOJ2j9Zvjq/g/TdqYjzZyouKNUqsjYgZsa8DsETiKummSjPmGyn2GWtoqj3eLbNdpd2nA24b5uO4VKNX0QGFsH4gbIHn4A5YFVOB/WkiEFw+m9EeLU0OpbmkE81awL72LGTOfuxhiVBIsTiKdJVhpPLxAX5D+oHKmRi9Zu96RYpRI6gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38350700002)(38100700002)(33716001)(110136005)(2906002)(8676002)(66476007)(4326008)(86362001)(66556008)(44832011)(66946007)(5660300002)(316002)(6666004)(54906003)(6506007)(33656002)(52116002)(6512007)(9686003)(26005)(1076003)(186003)(6486002)(8936002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6SfwkVIhmsStz16erZKTx29YJRAjnvwRBbL6YQcwCsoIKlZj8FA/nnLSv93?=
 =?us-ascii?Q?pSn+0z0E9P8jyxQ90kt17tcQb0D3UYJ+WPM7+PPsNMIx1DzM9dX4H/RFkZNz?=
 =?us-ascii?Q?JLZVTFoXLYX8fE7QdEAmHTjFJaLv0mXfhHuukKsTqVQIbQAf8HMlCCJYz5+F?=
 =?us-ascii?Q?J2SfOKhvX75gcWHsH5A0sLBCZSBNCNVpJ4hKGZnaM2QMKjW4xCqEA3Td0rnd?=
 =?us-ascii?Q?rwT8fMR4c80IbWEg+rEfA4sM5xpNOp1ejJ3eV6l2TODMPaU9kjXfY6SFUEgS?=
 =?us-ascii?Q?ASdCccG4yRMPiyN0+BQ0KC5sW5aAA/D/0UahqB/8boKIBoA/i8pPyoiznSgy?=
 =?us-ascii?Q?wbXnj0o9NjwAYo6nVtPDBn5WDXC6DMPNqWnpFfKzbqbrgyQcYKV06QjwThYe?=
 =?us-ascii?Q?cW0EjvAuh4AgiOqwnjkA/SPOPW2VoFl73GBu1te3qD4lRvzGtAlOvLWUfnbn?=
 =?us-ascii?Q?/kh7B27Ml64rTV1HkFfWE3V57u0UYXgOQJIOwfpCKyepXa9KaZ/dlzTvOaEn?=
 =?us-ascii?Q?1WfwTuI5GLKD+NMd/gAWvLHN934UWV2KUWDx1cpyMEpsHrLLV/LeFQT88d6y?=
 =?us-ascii?Q?goXOPE4cKcQmBf2jib4gVF6aLWbqiY/8Y0ab3WJuBBJK861OdoDny0ZO/One?=
 =?us-ascii?Q?VU+Dv1EkEOVB4lctDj2AvQpS8u3NTBnlCmHhPHJ5niJ41efbxgMjmuAemAoR?=
 =?us-ascii?Q?9/W/ZfhoTQQ4hPPsj5p3mKoPGVMFW1mPobNl7btYPN1rpRpZcDUrqiJ2xnS1?=
 =?us-ascii?Q?i+2VjkHQjak8VOLfzGrZskn1GurbKChiOOkSXus+rLhbXSoS8IfeOXfT2BNX?=
 =?us-ascii?Q?LNLCLfISkkBuy0Wy5gxfp7w8au37z649vl5FDA0rasJEUOwr70wqk9inC+Vy?=
 =?us-ascii?Q?SZUYyk+KJMRRDw13yQngNQd/vgT7HlglC5/IDWHiUhJqB2vqL2LUqnYXRr5z?=
 =?us-ascii?Q?ciPiKinWxXCf6Atp2Z7DB3rA+WYYMmSy3nkU4ENBA93ItGKaeIXmJ2ZclhLc?=
 =?us-ascii?Q?quaCXkdxriV21bzblivnbodsR7kUcP7HfwxgsgdWQK7GhJ69K69xi3+LWLlZ?=
 =?us-ascii?Q?2zZWw2MNFggaktlaanOMHAGgzBCz5G4mPn/lHUy2+GAtyAZfIFK+kmpwSOR7?=
 =?us-ascii?Q?Uf+9snIRWVHAm1JI1pDsCb+QbeCjY4A9YbGOuERMOU8p00jzfaJFInhxSeXc?=
 =?us-ascii?Q?cke9TLxUb1ZU3upJ6NeolftgF5+IGBxE5vdRkB06+NpiR6+gmQqHC6ANQV5U?=
 =?us-ascii?Q?uthlHUFmmGcFWZpVywyIQehX4GzzRk4ychAWllta/B0f4Mgk29nbkvtI3efk?=
 =?us-ascii?Q?CjeE7JuxqSen1lNfmxC13sLX5B7Lx4OtMbwQebNE6T0Faps2J1ZpbFQB+shT?=
 =?us-ascii?Q?LWanKZ3WVN1oFU/+7qkNnuLaOl4Y58TDmKbELtSnMHx0Po+AMVGXvjrR2D7J?=
 =?us-ascii?Q?f2mSJFfJ6DQS5RZF5lJ0TSR+kYb6V06IumnzNSYQDbGrcSDFLYq2orB+1EmB?=
 =?us-ascii?Q?1zzT3Z882ZByMYHiTAF6j8bMQZqFt98S5EOwwkH4fJVc/wIFOGT8z9cWeBLy?=
 =?us-ascii?Q?Y4Qi3TeNZgTWO+Ysp9MyCOY1HJkDDk7LTx7pbteBXNAwCq9QJXA9Tlqd4bXz?=
 =?us-ascii?Q?HDuzQdghhqzNLg3e5/wCsZlf5y+2b/4112o1tJoTKGCO/rXYsUQ8q2ln2XDU?=
 =?us-ascii?Q?sDy5Xfn0sAMQ1oLOgfbVflrmNrK5zj+h27aDTCxyIEw90OoxplWebA4XJrJE?=
 =?us-ascii?Q?tPiX8UgcW1u1woS43HSMfvj7s6AkGmY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df66297b-bb5c-4968-305e-08da19eff33e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2022 06:12:39.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25umVXnmVHui/QE2v7Q+SeEBB1xvEErA9wW316ywgEVp4Te+XoPbpiG7DUXtPHOiDNmEIsELe62Al3wvL07M0TXavFLwxZTZcYZ+bP285wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_09:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204090038
X-Proofpoint-ORIG-GUID: b21Mvc9aCknaCQo5jcodYuMbh2p-50rn
X-Proofpoint-GUID: b21Mvc9aCknaCQo5jcodYuMbh2p-50rn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The "rxstatus->rs_keyix" eventually gets passed to test_bit() so we need to
ensure that it is within than bitmap.

drivers/net/wireless/ath/ath9k/common.c:46 ath9k_cmn_rx_accept()
error: passing untrusted data 'rx_stats->rs_keyix' to 'test_bit()'

Fixes: 4ed1a8d4a257 ("ath9k_htc: use ath9k_cmn_rx_accept")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 6a850a0bfa8a..a23eaca0326d 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -1016,6 +1016,14 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 		goto rx_next;
 	}
 
+	if (rxstatus->rs_keyix >= ATH_KEYMAX &&
+	    rxstatus->rs_keyix != ATH9K_RXKEYIX_INVALID) {
+		ath_dbg(common, ANY,
+			"Invalid keyix, dropping (keyix: %d)\n",
+			rxstatus->rs_keyix);
+		goto rx_next;
+	}
+
 	/* Get the RX status information */
 
 	memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
-- 
2.20.1

