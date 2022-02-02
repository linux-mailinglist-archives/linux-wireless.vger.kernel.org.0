Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868074A7136
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 14:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiBBNFm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 08:05:42 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10820 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230488AbiBBNFl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 08:05:41 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212ADrA1004746;
        Wed, 2 Feb 2022 13:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mZ7UxdKdLiVu3o1HZLix+xoQyIxsSvDgxOBH4rJMT7w=;
 b=FagDLQoQsX8aK52fNzhSapnlNq53PQlG/wUztPWoF0DhX/KKwyjp7euaroR3tEKkfh/M
 hPMTvofyCzZn3mIIirHi++hbBb+1VTSOMga7VXah+6B9ViWfgsGeMDmex/lCUP9VzZ9A
 C8Dk5dBZYUea5/zmkr/jrRoC1SVGiXXTpGh7zzOcn6mF9JTLJPv++vqnDJO/CU32JTRf
 1pORmjtCMtAZAyDqagPy2Er0i1SCv2o+ScEVMCfuFlCgkvex/ko0OVizyJq50DEK8PP3
 LsZVsxafRElf2shTBBy+S6rvE2bQ9oyjrgpAvY5QC7gnGqAsiWqSw61+tahyL7dU8LCn Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjac5xfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 13:05:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212D1oYj184391;
        Wed, 2 Feb 2022 13:05:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by aserp3030.oracle.com with ESMTP id 3dvumhbdee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 13:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV8uNChmnJ+e3Po4L6yS15jaGHRVIEf1c3NPwkqGtl01ef1QwxQRc12fzWBt2QMZvSFqfJojPQJPWJf+Pj42wjwa+5050kKA60OuUBpfKyYeCNulN21MsWkbrSQjj5HxMTKbSoc9IurgaKEyvY2ANprdQ5ULhNzmODeOlvBgmMH+S8msPjx9gLcoQJ/OmcpuupKKqnmOGO+UbSgEWgZYWlYCOtyOHMZrFs6MnwKfmWJMA9gaC5f/aMRScFOvAWAAFF32DbvWPe/1YvpPdOY7JxKH/ROjlgrQfXDiCeijVlsYeoFQBcJJgmnm0jdaK585Wh3Rhc24u/ZqJ/3hOx0bAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ7UxdKdLiVu3o1HZLix+xoQyIxsSvDgxOBH4rJMT7w=;
 b=kkJXgPoiDS4HARZCvTuDojn+IygrmR8kesGB1xCucLCinYQD0+cA/JBRwkBuQ0u2N0NaXD426hFDt2a58ljkCS98w1eOf5tFcANShjG8m4vS7dSqm8YEU4oGs84kDJfES7d0nEJfhN0W90Vj3vk3d2GmVRXIlnNpBo0bCsueDy9ceqiNJQbPvwtII0vopw+H8CwN9IlejNlsxEptk1hPdf+/kWIf3lxmxZurWNiMoKxh1uYvVe+HyU/aiDmCFKz+H3f4Y31ajZ508GOS+XvYB6HVh07FM+pbj1RY7xnNEJdvZTCPRv1oEjOcIUUXWWEHWROWJxf5Ig/wkUjFWlG0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ7UxdKdLiVu3o1HZLix+xoQyIxsSvDgxOBH4rJMT7w=;
 b=UOIWy/QdmQJC0e4GGNnbJoFzEZi9jdLvNP64h+1gqjWGtfD5rCnYvPswo12fzBw/KOl3LiDKfJFSND4Kb6CD36CZtw+ylHyaIfdKDqFqeBcOB7nPHazaoUyMaRxTT0VRvzQzCQ41RKTFDSpaI2S+Uezm7AE7cEqbuXU+ZN4Jlp4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3232.namprd10.prod.outlook.com
 (2603:10b6:208:126::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 2 Feb
 2022 13:05:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Wed, 2 Feb 2022
 13:05:30 +0000
Date:   Wed, 2 Feb 2022 16:05:10 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Po-Hao Huang <phhuang@realtek.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] rtw88: fix use after free in rtw_hw_scan_update_probe_req()
Message-ID: <20220202130510.GA27283@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYBP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::18) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fcaedd9-3993-4526-7b73-08d9e64cb002
X-MS-TrafficTypeDiagnostic: MN2PR10MB3232:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB32327EEF86088215032FEA788E279@MN2PR10MB3232.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:326;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UVaAYu9vtIm9+l1Q1IEzgdjmR5b4V65kPgPOsunhFfyby2AqG4TeImLkyKpcD9lTSJt3yCsoAwYJYsAey9nKBpdnoxRtC0jtNXKHXHr9k+8FF2H9VMNlDmLjzaADZqS+9433+uItPlAgOVyAIoIwsBNRgxo64AuLswx8UbGl+VUcA2WfWLJpgXSjwXjqPObH4j+9aKLR0l9JcJfarl5/+/bvLfJGegxwoOHTreA2X3Yj0Zl86q8QzZEfykcUO2iRY56/4g/3eec51b1sr4c+UkvLjNcwJswWAHk9o54Vjx27GnEWFx7enB3bJlywBngsosi2FfzwgTWYk4bLen2C/tRemkehu4DlAimBjqATPgPcRiyLoIRKa3nc3/eBQXOwafJxfKXfJumCiy5kzbNmbnVAgQqzkWxewKf+fHTeEHEnxxUnXGkjMheYdliyOXajwCMPQcjblCPXmu7PrwqkYEjULXnaUp+yOrB5aVlsU+tfUDZJTFOV5bmUkbuUS9XXJleKtRmw4/8xr+yfhWQFIDXQYp1pmZI5D93eW8Ew0Jyh8WwF4iYDqQ0p2q/MQ2qHRMNiVA9Tvtx+Ns8GGqx1GtL6wS0Qv4A1K1tk0OfdLC0eY81fmkQXbgqBNDhH18wR8hJ0KbeibYB32n1p5D7oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(9686003)(52116002)(5660300002)(44832011)(8676002)(33656002)(2906002)(8936002)(4326008)(66476007)(66556008)(66946007)(1076003)(54906003)(33716001)(86362001)(6486002)(186003)(38100700002)(508600001)(6512007)(110136005)(316002)(83380400001)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q71/wi7ka+jrdrFIkCThDXZzqLAidF1ArJogtSGLGPFq/aeObjJrssjiFOnC?=
 =?us-ascii?Q?aZ/oXABrNpgiAiNDcrLSuaNUsuhU6iWIXThu3ag1z9FtynAU4ulPlD9jCOAd?=
 =?us-ascii?Q?WJdK0cGqgJ0y69lIDY9bh1pZhBWX4ODzwcUjsd8zTbGmc89DvSQgk6Yz6R/F?=
 =?us-ascii?Q?/w5Vn4e6OvcCFFnnU+HqEF63ZjsoKJy/ssEiDeCAyamaxq6HGKqk2EKdJYyE?=
 =?us-ascii?Q?vkzmlqL+Z58u3TwdF8n8LxVxpn6Wqi0+7nMCOFegOhcbWYQ9Kxk1rKGmwO0o?=
 =?us-ascii?Q?pfQNBoIAH2KKwg3NqAESsyWaXmXZ3TaZuHDS06qbLK+gA9qvX7HM+WsZPn8t?=
 =?us-ascii?Q?ObHRL+qkFyI2TGHcks7YpyGYmkW9yYtC7j+9ZKIV3v98/mgsxc08QVSLuWf1?=
 =?us-ascii?Q?S92ieqzt2E2jIBHp5vGo3+9gI8vk+2HpjPwzF4O1fIsIYuXb/pg9Zw5pDMXq?=
 =?us-ascii?Q?5ItkKpJ1i1b/PyBFjPA9iLwFnYnJme5XyhSoSJf8N1vdyBx2TZ2h0D7cINNC?=
 =?us-ascii?Q?OLM8xWG6cHVLHnzwr2Y41cDSOrXP9USAaxbcOCOK6XDJS3SB7v7Ts/vqCpcy?=
 =?us-ascii?Q?EBZWJod9TdjtZU/QeJ0WE/5+duleIxSWyom5t+iCRMN+tk/U8fCJDecTZkc4?=
 =?us-ascii?Q?MipKbd3VHpmLYYz9AKcG6NVIKmj3lzqkbqN4aGD7dQq8mLbO0lmO5WzB4k1L?=
 =?us-ascii?Q?YIUpau0TQ0cN3ZI3cEWLD0ObmPIizZklbiqir4OnZqLwW9e3M6axm0CUj4Tj?=
 =?us-ascii?Q?C3RZAZ5kOG0P9A3Xp5GU62AwBGsiwFQ+96C4kYDRuj5lVPniWrqP+5HQYL2G?=
 =?us-ascii?Q?Ts/NEOX9pG5OCwrRZUyfNWKwZFQ+PFMwRt2jvVebLBaYzNUXJ5tcW1BxvrRn?=
 =?us-ascii?Q?aSazgyq6UQx9Oth2mHFqjS8sZfUzpwK+6/gD4Cp6K7MQy9Z4tvcYSWAbIgVT?=
 =?us-ascii?Q?Q3dDiCxcRDdFUJdFT52te6W1ccR43K5uDBYY4+WoQKGN1UpWnno3XUCU6glw?=
 =?us-ascii?Q?x07ln2Hc4S04HUe6mE0pSXB1Vxk68DGKhY/+CXOHIr9aQwUNxoeg7BtK4k3/?=
 =?us-ascii?Q?eCXXqhtrrdK1Nr2cB92a0EnJmUuA3g/W7ieQJwRZlf8M7rxKKkrGMuZNnoAX?=
 =?us-ascii?Q?tfYidfYpGSqQPbkcmytNS3gHusfTM8YlS2h7QRAvtCzzsPneECKzQg4zv9dl?=
 =?us-ascii?Q?YGdqRlwKKhaDgelyKtAsEsHQ2gIFCSS2RXy36YIwH+d4kvw6xKzSBWvJ5TDA?=
 =?us-ascii?Q?w6RHr3MkjEpIjmjOFDkTM5sKDopZecAvjhw+s423YtxsTCd2d22fMbiESCt0?=
 =?us-ascii?Q?K1uc5cwyn4Nf6hR8TCdDqulWd7Myiw8nTg6Ir65YbbLQugQsdRgkzec1Q6qA?=
 =?us-ascii?Q?UMoLu8ylRQOYuntED8hc05M6fduPeet+nUprhSTGRDmP/ICtb1O6VqChLUbe?=
 =?us-ascii?Q?ag3lneSoEC+MXC6X/r+CswEVjtbBv+TfktLegbbDKu+NGo9nd3hbD+pu7zm8?=
 =?us-ascii?Q?M5lzXViFVDqeIexac/+dMr2UZ7OOCRscjRLHYahzpVq8iwJGHwNz1D7pp3NH?=
 =?us-ascii?Q?E5haTKS8VCf6+d538aMVnjiq99rn8k+3nNSVCSDkNQeSE6r9R21orzVBX1Xo?=
 =?us-ascii?Q?euLEfdsL2AUWOx7j0V2ZkEnzTCo0sPGPZgM53SZI8n18IoyyJF+JgpLcywxY?=
 =?us-ascii?Q?GX3kj3tQKktExzo9chGgHCD/M1irIeSHk/Dtw2z6ljhN08dt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcaedd9-3993-4526-7b73-08d9e64cb002
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 13:05:30.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTLJScu+pU6Yg25Tjy6daWMZDU+7+ydScB7UIODGRCeJtoDpAkZhobo7mRf0wYIOoqE1+ClK3sRyBxbxpb8p/BeuFJcMaxbeOJ3kiwT+QvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3232
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020071
X-Proofpoint-GUID: 9BJ4mw3Scgq3bvHdLgz1spYIkU4H3mUS
X-Proofpoint-ORIG-GUID: 9BJ4mw3Scgq3bvHdLgz1spYIkU4H3mUS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code needs to use skb_queue_walk_safe() instead of skb_queue_walk()
because it frees the list iterator.

Fixes: d95984b5580d ("rtw88: fix memory overrun and memory leak during hw_scan")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ce9535cce723..2de0bb67bac6 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1864,7 +1864,7 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
 {
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct sk_buff_head list;
-	struct sk_buff *skb;
+	struct sk_buff *skb, *tmp;
 	u8 num = req->n_ssids, i, bands = 0;
 	int ret;
 
@@ -1889,7 +1889,7 @@ static int rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev,
 	return _rtw_hw_scan_update_probe_req(rtwdev, num * bands, &list);
 
 out:
-	skb_queue_walk(&list, skb)
+	skb_queue_walk_safe(&list, skb, tmp)
 		kfree_skb(skb);
 
 	return ret;
-- 
2.20.1

