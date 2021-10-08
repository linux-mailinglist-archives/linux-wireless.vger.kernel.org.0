Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9644E426B63
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 15:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbhJHNCc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 09:02:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36266 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230258AbhJHNCb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 09:02:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198CC4OZ001315;
        Fri, 8 Oct 2021 13:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=IRswdLGVu3YGDX1iA1Yi7sYMeikMxoaawbnHL22RkXU=;
 b=ncTIbqlyTQhrXpyPKJe/Pa5c4+I1h0LqkCikYWzVtjuEUXyLrUo80mFzfywEq5llgIUF
 gfa4dREpslY9cJeN23kxfcYG72AIs1qksQyd7CvepHcnIgxwj/aNeMpSD+tRZimDQ9ob
 9v5iP+rAPkaPuptq4RHcDGesb562/1Xx3gYJVKN5kJrGBveQXIooI6cLfgDpeIXAnY9D
 0Ljzi++oIpUjKV6lI83UEZTZsLoknHxNQT/68oZS8VOFBU3hflLJAKZTyctEuUI2BnR5
 Dfb4EmcrInY1tYVKuCWj5Y3wyuNd/oZoFJbW0XUHKiw19DKC/uY1PrGo5dHjLDr69bjy 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bj1ecqgr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 13:00:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 198D0Bkg024317;
        Fri, 8 Oct 2021 13:00:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by aserp3030.oracle.com with ESMTP id 3bev7xy5q9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 13:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOG18Io4yWtssY8fcRa5P9QXJZLwnE5HyeOdh9/XO36hEpxSt/J+q/e5aaFWZunv0YOTw34OWjQ65zH5NJS/vPT7CXXqH+xNPQMLO1IfyKuo3UK/T8/yv73Y2+Z3EDuOouZm3g7uEMP4MKoE34ps+mPrzAY7/dZmzM4WdvGNbHp86aezglJw6LkERXKhIY2BZiri+rJWv2RtDA/lJ6W46nUvoFO3RgU9KssgeVApfs65EJ8tk2xDBVJ4IAK4iWbD9oMA+bwkyIsPX60ezWvi5lTJb021DROUbCyEfkbsDshlwQlMREjkD5SazSg7apvMYBiM75mB60LwbNDh3xQxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRswdLGVu3YGDX1iA1Yi7sYMeikMxoaawbnHL22RkXU=;
 b=YP8mHGzyU/j4LYcsgwUFUYGZSRVm1aICOZyDJGF0XuUE6fjG6z020zTZMkKnJXlNbqHyuJSkOVVAfmLOffBT9lv7wpU7yf/ghMKCtPxlJsbWDaJXXRM0AwElSr0eBZIl3fZRtU8cCgVK0iq34xMgaQGhwYsCtw3+ivy6rmJrGhoUKFKwiG21WN1xWWbIKNCOvTfCjqSL6Ds51LMWAMbDcsdsfy1FVZwlYFc4hEO7qvNhUOsJa2NcnDDm5EmJ9ZFM6o7ZYIB81m1Lh8dHJWFdDrbOls7cJAeoa59qPxtifbYdkgjnVH2zY9hA7O9TEY4SZHiFBXR9cX8MWZWibROpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRswdLGVu3YGDX1iA1Yi7sYMeikMxoaawbnHL22RkXU=;
 b=z1g5Tw7VBSkvaz22rG0wivMG9xDcXH4NaRZGfgA7gYJ30ly73JRj/SIIo3uCCh4Up9SxuUfQ66Duy8jPj9MjBvoqnGV6TM5IxOsds+X5Mxg+KO38qIrHoq9Msvx5JE+NOESSvJsMqB/aAqK8mVDYeRTqO30jgj/CQXBsV01lOXU=
Authentication-Results: nbd.name; dkim=none (message not signed)
 header.d=none;nbd.name; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1999.namprd10.prod.outlook.com
 (2603:10b6:300:10a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 8 Oct
 2021 13:00:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.025; Fri, 8 Oct 2021
 13:00:21 +0000
Date:   Fri, 8 Oct 2021 16:00:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] mt76: implement functions to get the response skb for
 MCU calls
Message-ID: <20211008130007.GA23161@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::17) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0084.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:22::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend Transport; Fri, 8 Oct 2021 13:00:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 882c29ee-a057-4376-2bee-08d98a5b95db
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB199916488B4D4C8EFEB36DD28EB29@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7iGKSflt+QaL3tbaJfOrCLW+Kxf3WBSICT/y/SGpvVkiBHgeFVMFNkV+IVQDXaumnj6bdWfAyEjh7ZbFjVQdThhvQCqjDN/FeDJAc/0ICn+YkWAIyT5dbgAwc0xoqypfE0/C25SkFC6QM8MVf7wpOae3PAgnD+jz0tSHvcX1y3t5QfINNLbIWUQhRfnxjFbZ5WWprsL6q/IkyfgGnBkkFEpkKLMfb3SuyQ+Q3LQa3kvSDFMw+JI163zdP7GKhwfuNkt5il593RRDDP8+8GccmjaX27FYm8Ubc1fz4NY4d4DuIgFJrTywooFFFHC7qb1IiszPsn6xR/DvYRaaIGHHOjDzCj4PZA1vPUh7htEtNMswmU5QAHbVzmAfEpn2HmYF4HohThPvlbGsdW8oaxwtqNggnKS15PKoJ2oEAtMuWFK+zuZM5TXZ8gHYh3NgHeYBCAxyX5tk48VQEou/xAgSTnWk6EKK1MX/cGvEVJUaXoIy0nU1UkfkbSO1AcZi5j6zlG11g2G7gZ26jEv5WSyjxB97uPO+gVh/YuXpAfisVeEHU2o5Yr9yZkxiCD+XFdF/+d3tqTY1rsCkp3OVKiBNeqoestT6qOHcCaRzXKay05ahG9w0iiB+r7s0IrUHuu/sJn84CTmbwlCWiVouULq2yVtmGu2XhjBUSsg0ZlzWFRmHb42f1SFxM0OrNt+2yBqwcxU0gh8WtTLIN6HHcQsTOBzRQl7+e3pKZuR7MPi1GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(4326008)(6496006)(2906002)(52116002)(1076003)(44832011)(33716001)(66476007)(8676002)(6916009)(66556008)(33656002)(26005)(956004)(8936002)(186003)(9686003)(508600001)(38350700002)(316002)(38100700002)(86362001)(6666004)(66946007)(5660300002)(9576002)(55016002)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIyW4T5iVYXMMdF6l5NSCl5WGX8AL84Ucwr9OpNX2a14CisGX45DuSLoMq2S?=
 =?us-ascii?Q?aCGd3ObIyCDCP4XeOGZpIQOa2MM2XT4xAGCLwKLEmeglrzqVWVc98m6H9WTL?=
 =?us-ascii?Q?heKj2JxEc+YTACIm4y8sLkURVOQO03TynCVQZcqI/x2zoGMUCBtJHFjg9LRV?=
 =?us-ascii?Q?0y555R7cuRF0tbVJxJURh350Q/zu/6KUJ+9vELQXszc3x7OAOclVkjeAWMN0?=
 =?us-ascii?Q?Mp6dYI2+3EP723POqMglnvvAJGRoZr8Io08pr/S/tCDCJtV7FGx/ZbnujPLM?=
 =?us-ascii?Q?Jw3NLmAReh9s7PdOhPG+aBu0Dc64OJZYB847lqI/JOpN8upiR/g2AWS/D317?=
 =?us-ascii?Q?VE6clZSwvq4ooPJDOlzEfBKviMprc4jA38ZjGOiagjlucL6ymdwA59Xg/n6T?=
 =?us-ascii?Q?TRC86JKjlzL02gkTHe0Z4HPjaJAN1vO65B8rsUXA6MP1benswawvksyEUafT?=
 =?us-ascii?Q?C5cu+8Yfw5RzLgX2B7IV1vWI0dPz9Kqjy/bE2sJre2MruQ1b3wb3fJPPeXHE?=
 =?us-ascii?Q?vAhtu+8WaUC6lX8MNUIc4V6AvEP8N4bis1B+cvdmp/ILy9wbAoK9z8tWiDYB?=
 =?us-ascii?Q?xM6BZsasSIr5CERJCqigmC6oldqJUBsEPzzk6/yU/H3kXkdrXDrFsJOuooFJ?=
 =?us-ascii?Q?dpsNAaq6AQj+Izoc+6vwiA22lG0LrGzIDLmSEYwZdNzwn5wWC5Ooel0byMmp?=
 =?us-ascii?Q?bywB9TQX2NV/0U3eugW0j7kVqpZJVvMIR7VxXX+0Zj3XoFN6URef+oaDKoha?=
 =?us-ascii?Q?KYigui7WG804zmZriOJHyUAJp8ZYcLpZqGrSPiK5YOG2AhmvFk4Kg26FqCBP?=
 =?us-ascii?Q?izJYxoLLIMsqmlmLAPSS4ZxIGfDOa1UXy3XkUK5SSFPUODeODQLA0M/ftJKj?=
 =?us-ascii?Q?nHEwPgiWyE1jU15wCnZChYrezRGyTliHej+Jrwe0VbeyVwv6v75RVScVr4YJ?=
 =?us-ascii?Q?C9fTWL3rKi9UtdZ6eBnVJLkmf7Go1pYY+ijT13NWNuKZblfQuFasA6tR/2my?=
 =?us-ascii?Q?VJrL2VPfDM/y1NdeciMPtIhIbI+YX3KwpurLyPYW9T58fbfR0zw/d5in6DUN?=
 =?us-ascii?Q?u6j+ZqX4ETURhzkpzhPPBgqY+OjAX4fyLCI1+N9+YAZM9ANOPkN6YZdad9h7?=
 =?us-ascii?Q?FJOoQeAFEvsEMGoUb4uWHyjqXEIluT9xBD4Jt5ZffUKjs38p+sGmuI/+BqlJ?=
 =?us-ascii?Q?KhGijWyepGcNc+U72auRXjW2HwUo8YgM7UY3OeAHVTRgLUlNmdCIj6MFOe2v?=
 =?us-ascii?Q?+mxCb1IXDaMBaQYdqYgQOxExoLrIbXGMpnR3mnzv9tOu2V2rAtWQBcykxkcz?=
 =?us-ascii?Q?JmgqjDGiIxKQe6I7XXeGMqrT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882c29ee-a057-4376-2bee-08d98a5b95db
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 13:00:21.3859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M3ZBqjCdqw7pP5bqffM41WMA3mk/mxGQlDEO2ySm/zx3Dfuh75FD3ljjcyVCHfb21/AO0pKoqXw3H3xBJ6oYz4lyITkKTBix97PS8pXnek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=741 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110080078
X-Proofpoint-GUID: Rp5o-IG3YSaXRCx7y-imedcosxxWlb-x
X-Proofpoint-ORIG-GUID: Rp5o-IG3YSaXRCx7y-imedcosxxWlb-x
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Felix Fietkau,

The patch ae5ad6272d25: "mt76: implement functions to get the
response skb for MCU calls" from Sep 30, 2020, leads to the following
Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7921/mcu.c:1151 mt7921_mcu_get_eeprom()
	error: potentially dereferencing uninitialized 'skb'.

drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
    1136 int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
    1137 {
    1138         struct mt7921_mcu_eeprom_info req = {
    1139                 .addr = cpu_to_le32(round_down(offset, 16)),
    1140         };
    1141         struct mt7921_mcu_eeprom_info *res;
    1142         struct sk_buff *skb;
    1143         int ret;
    1144         u8 *buf;
    1145 
    1146         ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
    1147                                         sizeof(req), true, &skb);

If mt76_mcu_send_and_get_msg() calls the dev->mcu_ops->mcu_send_msg()
then "skb" is not initialized.

    1148         if (ret)
    1149                 return ret;
    1150 
--> 1151         res = (struct mt7921_mcu_eeprom_info *)skb->data;
    1152         buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
    1153         memcpy(buf, res->data, 16);
    1154         dev_kfree_skb(skb);
    1155 
    1156         return 0;
    1157 }

regards,
dan carpenter
