Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1559946B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 07:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241654AbiHSFWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 01:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345893AbiHSFWu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 01:22:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF53E01D3;
        Thu, 18 Aug 2022 22:22:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J50BA7004325;
        Fri, 19 Aug 2022 05:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=MXvSJM/Ph18dyOaeQzjXhLJjEE5DijqexP5Ld0pMpPw=;
 b=pGgYX5ZgbwfjR33VWpiZv5n027BUtJhC+JHNoHdiLEzcBxyDKcSHE6NIsBRKsl61IFqP
 zbELeDXPoYwE3S5RrFk3+sx1tgokz+7hqGcI5NH54DaS00WWq7dQkX5xAuApYdG/f393
 hWB197asSElOndihUKhDjVB7Csl43ArIutmmXexmYa/B/6zcXS+4YTUQ4bdVqFuoSk9g
 iecCbwpdrxQauKvoCZWoU5kYgIlBDgITXCdUuexAYTxnxFV3X9vhLYWdUPB4MskpMC/l
 6vxyaz3fM8wkZjNk4Gc1UMenpMH7V0DW0wpT4T++oKizOb3z9od44bLhUg8oWlhgsgAk cQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j23yug0t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 05:22:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27J0Gt5V020887;
        Fri, 19 Aug 2022 05:22:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c49ffg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 05:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OamdRW8Eajvtmip7rtuVehavjsDV5w58bqq66RXoL2Yq1CPm42CtAK+npGljcVDuegWkkZR6WfeQfaB6Cmox4e4GTd8I7Bxl2qaKjaECIt+p7DQHs6rkdUYvSsD3xhkLPmLT8ZQO/0oHhy+DnN03CKZ/xX5M9QMYT+CcZzgb/xXEXKnGainS9QcLXcaIQckwdFRv61hMwrn+AHDAsyAXX/rqtZNYmL0hSB0BPjyQBqG9tjgeS4NEcbY/NX2NAYDJzNDl2uhnMW1onwgJt+tCqOZFaFvNohSsX76AiTIKacvBceOv2SRcdDGygPfYHYEWyEJaSbuMX9yvV1xKfPwcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXvSJM/Ph18dyOaeQzjXhLJjEE5DijqexP5Ld0pMpPw=;
 b=Dau5uDpwBTzJov6MyiOb/NOeyvPkNTILIqv5Fp2NU7hFzMPIjxSMhc9I06pSalX7hqeU1YNTRctBSCXaP/ndxkgUMxdra3JHzDtAAT6XdB0icP8Iv76u/lvW016DMCq161U86qwMjXsCN09TQlFV6pdJZ/0ArWKVNtEmYp8ptF/adEVWSDIjDZReb8BzbyOiS88e2S5GL5MlVRf6N+royUBvY7RtNqP2qR/trWiu3ctTuU1C3l3ur4TgC0ih4azjQbo10RqtznsJ/3I7Tbaspur0FkKEna0sO2rtSq0l0orfH66i9r5wp23teq2r9ux7tLW2D4l3HcQxoEkM03q7iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXvSJM/Ph18dyOaeQzjXhLJjEE5DijqexP5Ld0pMpPw=;
 b=NyGqteWpKiLCifJrU9YbpB2gIYi/PbTWWWFsI6rAZyKYyobs78LcriH9dWnVS9ImctSXzlTVPt+4FG/rn9WGlqYS0wKbJjzuk+5u591CaNFYJBDzoU/QciTSq2839f76MXmGioWElh+zQIz0BwAsYf5BaMxsz48t7AM+YRTPdZw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4124.namprd10.prod.outlook.com
 (2603:10b6:5:218::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 05:22:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Fri, 19 Aug 2022
 05:22:42 +0000
Date:   Fri, 19 Aug 2022 08:22:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jes Sorensen <Jes.Sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] wifi: rtl8xxxu: tighten bounds checking in
 rtl8xxxu_read_efuse()
Message-ID: <Yv8eGLdBslLAk3Ct@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d204a448-8b20-434a-5c8a-08da81a2d71d
X-MS-TrafficTypeDiagnostic: DM6PR10MB4124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8B97Gw6st15ofTP2vznYMaUwJ2GpjOrlmCRvpuhrD1OWo6UInnKqzlvGrQtmcPSh/Riz0oPVLB9CqQStfkFaYqvcJnRBipeX26cJVihZqAKgRx4h/A9etopmvwWBTzvzymkI35hI1EdnTzOUYCxLBNCREkQZWmDHmRDjtw2DzovbJcskoHopzse5ub5WCmGJg6mq0X9JaEBwIYGtsE/2QRzWBofSRWrUbI2BjpZSyrWtKol7mqheCUXWSI1y9d8QycWJbCjVJIW/jvy9UYnKIqc01aMtCwUeKDUDqezY2WoDz2TTlJk2zAb1V9HmhpRbFHF31IdYk1fEnesIwUd21LUkD/R0oYud7UFMA2qgQGSBOS79PAHzjGVkfG8z2l+Qsei6VrOSqb+fTqnv/ErEB0NHSpi1/ntWcXZtTW40CjkyjmwUsBNC/7xzUljshBVWVUpohiSAUNgfmUc9L9O2tzB9Kuz9kpnrdQ4vcRmOdaXuWJEp9SWy+X/j8i62uf5uMQ/36UtqD/jXcMoKb9nzujYbahUQUayfwU6R2ahv0edsFdEU6SXLL9gm2M/3wuEpl0/eR/OVI5/LZWK9SNQrFuXuzSP0dZRT0tLi3HDZ653PBD4h8Gi2jLeWM4vYykoVpOV6WMgwwo7sFog6Q6OTfg11OJmPelGzAEaWe4D7cJ4IP5Evu3lSD85XwNQPjCI/3swt4phr2sDb9JYz28uNs/bl0mxYzVeAdpKpxDF0sv5ORAYPfRGueeG7FaFVuY7PDpXOBsN2LlwUomZt+xBtgg3b+s85xqXSYc0g/uxTzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(84040400005)(6916009)(41300700001)(52116002)(186003)(478600001)(6512007)(26005)(9686003)(33716001)(83380400001)(44832011)(316002)(6666004)(6506007)(2906002)(8936002)(6486002)(5660300002)(8676002)(66556008)(4326008)(66476007)(66946007)(38350700002)(86362001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MgFJ1EB9aIsSBlo4VGbMq4RlyiorINTjqCj4r2StFLPIVR6igNLLXIjAgPTY?=
 =?us-ascii?Q?Jj/ecu0BKGYJF1jgtnWXFT4i3CSH9iTCAnj+FzvAfaEbFbf7kG5ZK7Jk6jUx?=
 =?us-ascii?Q?boTp+N5AdNEaiUD+2bViiaHv+iWTAw29juloL0C6OVteq17cA0qLQHC8oBB2?=
 =?us-ascii?Q?LT75cs5BrxyuPjoDWS9Ue41KOa8poLEp87l82xZLVZi4r2p1Aau4FEPpRGkg?=
 =?us-ascii?Q?LainPesPoYhdZuZnabv03bS6mhVmCswGGjDILy4Cz5Yd55PCQpe0iathgrfO?=
 =?us-ascii?Q?qATEGfqVPL46ZQ4GAHAdl02Gh1yyvmwfkC9uwJ4+ANVcACBIegCpbGYTwwU8?=
 =?us-ascii?Q?0I2cuhrpT/WNbXpS4YIwngjCiPsAZg+MZtcayIr59BVh6DZ72KJtdIc9fKX/?=
 =?us-ascii?Q?bABpe9/oog3PJbX6HBS2h/g+dinXxvK/lsuf9tEblSfIYRopeRtEqu//xCB5?=
 =?us-ascii?Q?+aleCrqoGZGGzY1u2pYhX/RBT9QzbABS2slcPreWtyPEW7i6KctnieJdSDJk?=
 =?us-ascii?Q?S87R+2zxizMTq1pOVWzAY97v1gTQpno+GQXJ8D7nDIrEcj/ZO6SKg+tLqX3w?=
 =?us-ascii?Q?C0oJwRKV9h11KA7Gixn66nfG6yg5RCihZUsaPQkwDYw+Qd8VVSIasQIDOFDD?=
 =?us-ascii?Q?rSDFq/TZGHG+MEE6DSAPrHy8Rviqsr2GWVHOJtspXukuobrvbysBg2GcUcPB?=
 =?us-ascii?Q?FTECTDVSqbM+2gqAW01UZ92MQJxR8CwQ4Nvrq8fqm148Psuh/B6413ABQVVq?=
 =?us-ascii?Q?xy32N5+mB+arkdWWCFkMrCeztMHwPmBkJ1NqXWAIiUhZmp+yZrJeIJMChNgK?=
 =?us-ascii?Q?RsC8GLCTEjrrsdydCFjXSYjCoJycMK0X/pxaj7KKjUdIx6wzrHx/NHFiL4XY?=
 =?us-ascii?Q?lsYvk/pFZoNdvKGUokNLKdYRYrLHALNUeIsTqv++iXY4iJQ7PYc3DEW77yt8?=
 =?us-ascii?Q?+SCJDq8xDrDhkgZegH9nn1JNhRUQ/p7CgDjgmIk+4mYDiM4qt2aCY09xMGZF?=
 =?us-ascii?Q?fgBn0KRIGqvk01ZSEHKIsIG0NTay23c9sAiFTUAIfZeyBU9N0vxBMi3rVLB/?=
 =?us-ascii?Q?/LTatmfxuMBFs+tZkxmIJ+euGZG3MulM+ix3Bg+eUwCfh0G89O6o3vNqNCea?=
 =?us-ascii?Q?pIniG4U8UbotcR6vSWNYaJ7X0qNLayLvBYGqjZ+jmoaU151kNw5HWARCmXeB?=
 =?us-ascii?Q?3kTDGBLs/5sxMsNpRA3REE9KGGQHeYTwFXs0T4X3JIEnO/HGDQXQgSpvoDW4?=
 =?us-ascii?Q?aCB7N8RpgKfzW6yJOGgc6Wx4hJ2mIIRAp0yCcLDvCRK++FMi6SvcNYKkxY1E?=
 =?us-ascii?Q?hfSWoJ/yhMhkAm8KEbkS9/GY9f5hJNovngqk2p29LeGsxJvyVpyC1qahTOXX?=
 =?us-ascii?Q?NJ9FULcwQEmUhvwV6jNepxHZZZhVY9EZwSSqyOuU0hUdg7oDUQiV93Ffw37q?=
 =?us-ascii?Q?Lsq1kL0FIYYmV++WQwSYJjq0gXScP24SqWH92QjStfuV4I0kdxRLh+0Wn+m7?=
 =?us-ascii?Q?Wczpigh7QG0fqTi/xy8gNlo6wTYY6CVPBqinGn1nVsP60HeAjcArkuzONBLD?=
 =?us-ascii?Q?b8y+60y1gx7REGUZ/ea7xUbpy9jWdgISND9WWyBnYgBTOJjElKzw2aJoyW4E?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u4hEgz+OF0WumieFLahLYAXXh2fUDN65X6/gSzQapHE8YfqPYknr+ldMwQa+19QU4NJcQRb411pQy/OP/zWjEn682uoQRvouhYeHCEio2IPDYDBp+qVh/EiPprJTLU4GWfBZvQilUzJJrR0MusG4c5TsaHx2xRS/mA5/cnmt2+kqajRAHXo3lCFGLFgkSbRyS5EKx9pb7OC+HqchrFLfw2VZ9i0TkKE8P/+iG38D/D7kNcl/woPr5lz7TY2w8UhIfLiAx/STM46sFxMH0DpdGOrTM6XuckrVDFa8oQvLhCAXPBfpc2Zn0TytThsKj3jNf4ao59Ea49b5EF6RJAmSKs8aBOIO2shUdSSzoJ7LawqgD1wRL8gp6FTnrf1Vf4qql9LRTfYm/ZpRJXM1RqX4ZwsXUHxM6F2/Q0Z6v5qTd8dCZ2c8Y3Xr6I/LVplQres5QZvbwSpHyNjl0mnM+44RT53uhT6VkityzVun5epcCGOcYXZpGbjuMMvv0pvPmHK5z/MbjdNw8Uyo9Vl+GXe/3JiJXXp2tt/jHMuJW/kTOztaCW9RncjKqynuggdi4WsQlBkhAoQydWWYn+aaxZIfwo4e0TzwmtM42Mnm6ED6cvT5xxuLMp079+WbuWzw0oaTIFqFdOtfU7neWY41Ii9c7UaT3PBiwNBjobUPfCyoc33JkLEKKPLWNmEhI6dJPIpC4BId6kONypoFcPFH322EBRt2d9wdBc94eD+JKT9MpZiraTpmoQ/o7nMovU2Z8Pzzdm96Pq5aU2fP7xxsI+ZY02oXTs9Y90TPam9jrbBc31L/wq5HHryCORY7xVYtTWjebGP1k3zHS5F3LruLAkw9BmPlbpNcm8cgOZIk/9l2RaySK+J9XYwq3XCboxoiPQRzFLU+onn++mcTrEXQMvf+CYHbCwc/qff0W+Iqrzqho7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d204a448-8b20-434a-5c8a-08da81a2d71d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 05:22:42.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvNJjh14P3GeVgRzPdQVS9Dp3LkwFZA3vcRCf778YnezHX+fNjvyB7XA8lwzINVMv9RRr7gLtre+pL13PZ90mNSI1CErqrHlnOLf5LE7XyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_02,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190022
X-Proofpoint-ORIG-GUID: 4K1ZV9AHU5hmVi4jsdmeZ34jgfeKkI0Z
X-Proofpoint-GUID: 4K1ZV9AHU5hmVi4jsdmeZ34jgfeKkI0Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There some bounds checking to ensure that "map_addr" is not out of
bounds before the start of the loop.  But the checking needs to be
done as we iterate through the loop because "map_addr" gets larger as
we iterate.

Fixes: 26f1fad29ad9 ("New driver: rtl8xxxu (mac80211)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index c66f0726b253..f3a107f19cf5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1878,13 +1878,6 @@ static int rtl8xxxu_read_efuse(struct rtl8xxxu_priv *priv)
 
 		/* We have 8 bits to indicate validity */
 		map_addr = offset * 8;
-		if (map_addr >= EFUSE_MAP_LEN) {
-			dev_warn(dev, "%s: Illegal map_addr (%04x), "
-				 "efuse corrupt!\n",
-				 __func__, map_addr);
-			ret = -EINVAL;
-			goto exit;
-		}
 		for (i = 0; i < EFUSE_MAX_WORD_UNIT; i++) {
 			/* Check word enable condition in the section */
 			if (word_mask & BIT(i)) {
@@ -1895,6 +1888,13 @@ static int rtl8xxxu_read_efuse(struct rtl8xxxu_priv *priv)
 			ret = rtl8xxxu_read_efuse8(priv, efuse_addr++, &val8);
 			if (ret)
 				goto exit;
+			if (map_addr >= EFUSE_MAP_LEN - 1) {
+				dev_warn(dev, "%s: Illegal map_addr (%04x), "
+					 "efuse corrupt!\n",
+					 __func__, map_addr);
+				ret = -EINVAL;
+				goto exit;
+			}
 			priv->efuse_wifi.raw[map_addr++] = val8;
 
 			ret = rtl8xxxu_read_efuse8(priv, efuse_addr++, &val8);
-- 
2.35.1

