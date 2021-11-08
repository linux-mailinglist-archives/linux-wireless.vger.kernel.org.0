Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED06A44821D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 15:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbhKHOuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 09:50:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4584 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237063AbhKHOuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 09:50:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8DkQhT013229;
        Mon, 8 Nov 2021 14:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=0kRUpv/kET8bKLmhWa3Fvva6qxoBxtCLX8aHQAROLtk=;
 b=E1HL10FlSOGj2D1hrL7wOgSaKxx/lCLnwFX5JArsBEwmw/9mmR4NxWsZV9Dxi4gEJVwP
 Kj0gKYH8PD/H46EOmVcaAV/XIT33YjCHltfTOL08iTxY/j6sERi2lXslJRXb/Id9jZ7n
 GvRQ7+/6gu8PbW8oCxEQVOyJPaeJb+ynjj/2UVkqQRCZ5P82EJQoPpmWVcTfn/LWddUh
 3BlhWVcXecZ0tI0ioTxWyce5+qmaGrk3dI7LFsTO/yfR6NIwGT5juSyTpl1oj89c5VCn
 HZuosfBPF1yzhqtSAWY2bZnZvVyqIzAr5pwlF37TMlBExEcfPcn7E7+AVgzXLEqgAbxZ TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6st8kk20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 14:47:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8EecUm176294;
        Mon, 8 Nov 2021 14:47:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3020.oracle.com with ESMTP id 3c63frbd70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 14:47:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChzkTbUMPaenOPlL/a27G27tAjOM7APUyh5GLkzStBRAsQfOnZNM9279hPNuqLm1FW2tU6Gn/SPnLk+yQIz46biMRoh5Ui1RQCTh00upd5QUXli1GBlPITuUn2IAJYFpA+dO+q0PQn5r9Ktgt2CgKaSpe7pmxUrZCn58uvZfMro7JSZMxfVHWVNQ+mL4GrI7Ds7WWLH5BUCVxcpk4h9HlvjNOHXH7pVLutfsXCKaq3neywZQzaptK+9A+KlokWBGyGoxLE+9UR1mKhiZe6JGBYEwwdMbl1f/CqWWMbrY/tg5XXXJj9thvEn2OwAT+e/B+a6lJSrIQvGhM0l0bZ0oTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kRUpv/kET8bKLmhWa3Fvva6qxoBxtCLX8aHQAROLtk=;
 b=S5Qi8KYBklYH9ya5L+enUxjBtuLQ0SaawEqkpuyjgczwut379iyc4oQUyYLrw+G0lCoQP+4E3d3aYMGIUMM4UdHddaKwtwy4ct3n/e1qKmhzr2JViE4U2Ml6Jza/ILLkBUE8ToUuGw4uCbUwSgyh5oCQiTy3LgEj2GNuyYJtlhicvwlPDW6e8GOWilDJFM1Q/D+aZP0kqWjG8eWsYQUEFdbatbTlu0hwy+a6rRcfj0WmtFEFBk1dHmS7NM8sb+E9W9EhSUtUeBECq6qif7fW7JOJkaBT9sdofJrAQ7MTTIYPlDqHZpJRogGhNVXO238hbjEbLdjA9AFxwQ2aRhGeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kRUpv/kET8bKLmhWa3Fvva6qxoBxtCLX8aHQAROLtk=;
 b=UQfYMyjTZCAX10ukeWkeSPs4RRI0cSXe61jeZtXb7hqduCZmoL/IicNB7pDvDGbL6c2OEqhkIi1ViGQ/O4fxl8TJr6EK5KNCXx4fAMJl1BHM+7mF4ZRJW51Kg20iwovPKkkM8VA6cAErnm22Q8McZIglxCTZwnlrH9+oO4IDeGw=
Authentication-Results: realtek.com; dkim=none (message not signed)
 header.d=none;realtek.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5553.namprd10.prod.outlook.com
 (2603:10b6:303:140::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 14:47:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:47:26 +0000
Date:   Mon, 8 Nov 2021 17:47:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw89: add Realtek 802.11ax driver
Message-ID: <20211108144711.GA9468@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Mon, 8 Nov 2021 14:47:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83a21e4b-9522-48d3-baa1-08d9a2c6ae49
X-MS-TrafficTypeDiagnostic: CO6PR10MB5553:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5553258562FA95B41357EB038E919@CO6PR10MB5553.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WWN6pFuN5N+8GFFe2AeyL26l9fxLydMnaZyKiXjbdunZaMWFCymBBayf5fGKYWunYkPhoV5nsX6zPfHKwrYD/lelYx3wbXWQBwDsPPt0Mnh2ALlV0irVtbxIDU5klzc5ztr/C1H4qEO5z1gcvUUmbPDD7YTk+Xm5W4cHf6JNOMdEmv7hcAfKkIvjS4I9hGR+XCs8nuCprwMvzzmLtjBpb4Bl2YQT43c03W5gqqxdpMZPB71Iwv27Xrvn0pm+n0HuYTrODcodQ67Fclh0lX1EvvUO4ud9zVN7ezP3ysI+A1ysyaa5Q6s5FXtnPaYfEvJiUB5WIK55cmp04NI7VRhFI3uRkemfuSkI7JztNFLN6siKjCV0l4hEkJYb6C87XaOi+ecVYJlMJUOApIWzZMD8eiYDreMtMbl94aBbdGOU/fIrIfs3sXDVWXc5DR7He7HXSZM1Jtt/9rdx3RNmBlMi/PtHI1Rto+7dvk+4DUwymfm7DXrJOgd76k6M7D6I6l6mf7gi7C2flAOhl30ITqChwvYLbHgJSlU4t54rIgzYrtjomsVaNjxajd0WkV6/td0QAeN7tEmJEgZr8qq6i8oTnmAfs516TaefwH1b987JevF8m51eSvI1wGLOyUf2uK3KiMoOdjynAItAQveruhX5iih3ksX2ZFgu224m5LYfTi1S6F4Rib1EVMAimgMuHCpm1ExN3d+cQAl04d2LZes8rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(1076003)(956004)(8676002)(83380400001)(8936002)(66476007)(186003)(5660300002)(33656002)(66556008)(33716001)(9576002)(38100700002)(6666004)(38350700002)(4326008)(26005)(508600001)(316002)(52116002)(86362001)(55016002)(6916009)(2906002)(44832011)(66946007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AIr5gCPAbK+klnmfyX5kuDd0oTHFhS10yL/UcxwVqBAINFRzzNHpmJ6o7vR8?=
 =?us-ascii?Q?+7Wez1+rkLwrZFHkiz3SaeZrRA/Jh3AnP4uc0GyRRgohNG2zv8VFkn/tTjJG?=
 =?us-ascii?Q?N7AZKg3EnoystSi2eUPtAZ5Q0pDX8zmZbPpjbdRVit4Fr+kwPlhD53y+397f?=
 =?us-ascii?Q?88W+hRMTL2jZOZMAVR9ZJKp1wBGrUbLAdcHXDj48NgNZmzLF3iiEH8g00y/s?=
 =?us-ascii?Q?RpN9E4UQMwxdu57TBku+X3L1radl0Nc0xmydpSRdzt7BQYG0nYOVKJZWjKKR?=
 =?us-ascii?Q?TQMWRPW1VATGn8XrsW0Ou1LBwWFnxva5v24NZG2cj9F9j1Oa3Q2qL0cLLqA2?=
 =?us-ascii?Q?Nfkhr2Zpji07DB+kdIjn5SO/BbJVOlT50/Y4eveqCW+gOzDDPGBeSJEduHMH?=
 =?us-ascii?Q?peT3rbX222ywIifV8kAwb7pdVIlI2jwkQRGlXFV2Culd0AYrY/IwC3fsJZL9?=
 =?us-ascii?Q?mJDfJ+cr1YQKdG2w7/i6lZ09kWZwZwHPzFhNHZop23JAF3f4ZJPMgqmEipL8?=
 =?us-ascii?Q?fnZiEEVWgeUFFth7/7VUAsS2OZNtqwJ2hMRjKWPjWhetaWEZ9Z51yk1RP2Pb?=
 =?us-ascii?Q?O+GZVH8pOB+WDgX6NaxCaaFPU0MVu1vFeuWkyrORcYJApzYdcidjMRvc+iZ9?=
 =?us-ascii?Q?AT4DSClEMUQPIjJIUWS9dPTJbQxs7WFmMzXr4U9Q0mpoD8xlhR50VXXPbV+V?=
 =?us-ascii?Q?WQh1JPmpi1kc8lvhetLqm59uZ2O4Dx9uSFiXcgovFTiCCEvPEktGYAbVvQNF?=
 =?us-ascii?Q?xY7Iq628uIueNGpPg7TEfhEPOcWanMucch1lN9o10kwlO5KoK0xUBzkdSE4N?=
 =?us-ascii?Q?nDmPRZdmr3jOvaDRrpwtODvcgZt6w0MpZn8MiH3kV/I9CExv4NN41Nayz9i+?=
 =?us-ascii?Q?1Eo6cAhyOcS/J7KVm4WEzpEwolRBOKrGtWPvuyz+In6lk4Dip3SmLhH598re?=
 =?us-ascii?Q?bNOODmT+ChggOaR4olQnWzEtQOrqD7gRlzahXm3jmihNBSnJYWw76ijIU81a?=
 =?us-ascii?Q?57BWqrte0wMScPB6KsulOXbpRsZVEW8xlPu6x316WJ3Ec6QaY+W9PZtKCxq7?=
 =?us-ascii?Q?6BKmgUZWGAxHYGxQ5T2U0H4Ku3M9eUthEHoGAs5GY1rxcl/CciTcSavJHByA?=
 =?us-ascii?Q?pj6Ft48oMLEXsnW/1Wf6c0vY6be3zmZjOJWUporOTX24J2MQxuAbIzVIEcFE?=
 =?us-ascii?Q?bWGjAj+GlWRbRp+7vtH1BPEoaiFgyUljn5tfWNWV9KHls+M1R+sPahkT6688?=
 =?us-ascii?Q?DgICIQI5CUgqBrUaaJo8t4CN/G+pAVfBySfzmqAOjYw5MXmOVC695CmIdxJm?=
 =?us-ascii?Q?iXVJAMspfWvB8H53nOD0UMgouQwD5/mHw0dwn2i9q/7FwgDyULeH3TcuRN/I?=
 =?us-ascii?Q?N6V7o4zBUcgrW7O2HosO20EejjXmHAipuJoDewC4YADbR2W54/vtqss622x6?=
 =?us-ascii?Q?tiDfJwnYSuP1mObcfN+0qP88CKBNgkTB4pBdEy3HVsqQVaAFKf+to7zpWQkj?=
 =?us-ascii?Q?DLnRmgYGlPm8vKjxYmJe1ms/IwRjfpExoh0lwC3RzKy/qzrT8ZrFmJCEq3d2?=
 =?us-ascii?Q?MBGyIIg7e5XmEBMuhWj989CvZ6F/S6Xt88hog7BXgVI3mVUOvf6Nb4x8Z7/u?=
 =?us-ascii?Q?xioU23M/8qeCPFe5cqnvW32lOmwgBMhYEppR5D6xfgYozW5RRo+e2YuqHNYd?=
 =?us-ascii?Q?0gnmghoXpt64jj+WHEZKHeN+9D4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a21e4b-9522-48d3-baa1-08d9a2c6ae49
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:26.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9FCnMsYxj5KVcGZ34RW7SvbZdVi6ZjRBe+tJjt11WsJmAjhqnbgf1doISyGZU2YYYIa4F5suTiuB0aNod6DP32FdH/fpXIBe2B8IBgNEPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10161 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=951 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080091
X-Proofpoint-ORIG-GUID: ASx63Ii9brAn7ASG3dZgCjZjCx4fvLXo
X-Proofpoint-GUID: ASx63Ii9brAn7ASG3dZgCjZjCx4fvLXo
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ping-Ke Shih,

The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
11, 2021, leads to the following Smatch static checker warning:

	drivers/net/wireless/realtek/rtw89/mac.c:586 hfc_ch_ctrl()
	warn: array off by one? 'cfg[ch]'

drivers/net/wireless/realtek/rtw89/mac.c
    568 static int hfc_ch_ctrl(struct rtw89_dev *rtwdev, u8 ch)
    569 {
    570         struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
    571         const struct rtw89_hfc_ch_cfg *cfg = param->ch_cfg;
    572         int ret = 0;
    573         u32 val = 0;
    574 
    575         ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
    576         if (ret)
    577                 return ret;
    578 
    579         ret = hfc_ch_cfg_chk(rtwdev, ch);
    580         if (ret)
    581                 return ret;
    582 
    583         if (ch > RTW89_DMA_B1HI)
                    ^^^^^^^^^^^^^^^^^^^

    584                 return -EINVAL;
    585 
--> 586         val = u32_encode_bits(cfg[ch].min, B_AX_MIN_PG_MASK) |
    587               u32_encode_bits(cfg[ch].max, B_AX_MAX_PG_MASK) |
    588               (cfg[ch].grp ? B_AX_GRP : 0);

This is an unpublished Smatch warning which uses an "assume every >
comparison should be >= wrong until proven otherwise" approach.  In
this case, Smatch can't tell the size of the cfg[] array.

Manually it looks like cfg can only be rtw8852a_hfc_chcfg_pcie[] which
has RTW89_DMA_CH_NUM (13) elements.  Is there a reason why we don't use
the last element?  Also it's puzzling that the last element is
FWCMDQ instead of H2C.  So maybe that's the reason?

    589         rtw89_write32(rtwdev, R_AX_ACH0_PAGE_CTRL + ch * 4, val);
    590 
    591         return 0;
    592 }

regards,
dan carpenter
