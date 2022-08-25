Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC17E5A1668
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiHYQKk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242959AbiHYQKi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 12:10:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E4DE94
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 09:10:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFcwA1030009;
        Thu, 25 Aug 2022 16:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=dlO19t4tVNcIU7V0quc7O/JiYCvpjGlleAf8B7Bw5e8=;
 b=T6s/NCj2BbYW6wBNcTvKzvpS0P2umzSKorP6EC0jvOe3DoKpwlwgflB8IuZZfcMKq2PS
 W7xoVj4tNS9iZAcAbQ4ddCXNwFwUPYdhdbfmg7/0PCxh0e27PkulOoLDcmQg5k1V1LjT
 ub1165aRoCic26OnZ3hD8oLH2xtRCb7tucVS5GqgU99UGjQrur/Y4A7cMgcn1DMVJbJb
 4efWStSJ9hhf4soIIDzvVxmgUcRq5F5+mUbkhRHH48cvEN1/j7z+JXpoEY6pxbSIoDfc
 ulF1diHdyn76+VQeMvjKXBMnnf1Qj39SnGABq0C5NCm99NqE84VGKomfoi6SxreGtzUM bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w23y24k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:10:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27PFJIoM009535;
        Thu, 25 Aug 2022 16:10:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6n2dpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 16:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpFqQCH6GOyE12Sh+LwWYiKbwCECsQ6VI/TK9WPFTnW76f8fIliOyMsn7+lgQKjJ6OkhdcqtFT7rzJbhrnLoYMSNlZMVLQkEEKBp4iBJYM7gkVLCBy6AiM7y7ZwwcSp/afPsZDNqdl7nWnZg9oc/kKMyWqZz+CNRVJrj/MwFbiG7lwzxAqy5YRxeXYiJgpyHwuYbt4Fpq2fzlwVXDguXINXVewrvH+hgmEpBEZJoqRtse4Gsv8QOxlY/zDOGK4SmnUtxzL3FaaeAXnwgww/OXjVwdoZM+bV/ZF+JML/C/qybx6kTOmZodxT3c4NL3bLvc8a55kq/m8J2QvBwug0R1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlO19t4tVNcIU7V0quc7O/JiYCvpjGlleAf8B7Bw5e8=;
 b=Dz0zBWPu5Ml2l65y/jwjJUWcxVhH2kRJ5ILAVMV0tTqegL/2rLbeEjd1rKdfjoLb+BYRdjvkCovrVJFZmMZSXqeq+o0hGqhifMzNjRoBjVZ8K6xuzVD3BrQA3QWrP2l9rW9eEyDkU4JzSfvJd+IXFnFKszveJejSQJOfEXKKFl3Ux0QtcKLBG0+K4WcxjMeA65+QuZI1WBezzWI20LeuCPDCN6/Cghp3E7Cy441MyKvTxb3752J0sn/PmvBRqvf+ZKEYfy9wcpGtuzh0dQTrfVKYbWIqgv0dcgO/E38QsuMeYshraYC1aHcnzRwcMqkdhWGtDd9YEXIhwaJeEkvVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlO19t4tVNcIU7V0quc7O/JiYCvpjGlleAf8B7Bw5e8=;
 b=gEZpBRymNkJUlWG9vT3Jl9RK+4Tqt55BYqodzhwlS6kqaFMZsQgwjybcINnVaQboJoYiRU/9sXBiPj0eTsJeNAzPsBmz8V9u4K2ZAxAk5LC7jUocIIxUEZenrw83pc3VjgIwrk93bt7B1qrv4SI1ucv0KTwZoamLmtwSzPPQcN4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM8PR10MB5496.namprd10.prod.outlook.com
 (2603:10b6:8:23::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 16:10:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5546.024; Thu, 25 Aug 2022
 16:10:21 +0000
Date:   Thu, 25 Aug 2022 19:10:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     robdclark@gmail.com
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [bug report] wcn36xx: check dma_mapping_error()
Message-ID: <Ywee5H+m/4Y5lXq4@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0136.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 948a570d-81b6-475e-dc18-08da86b44f31
X-MS-TrafficTypeDiagnostic: DM8PR10MB5496:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0v43N9Naa0g78dBid/pMLln8c4TmP2S+w+NXBQDSM70wmnG9SDo1EEDrr04xhQ5laqfxzBBsBmRIptLZ8zn7AGDoMFzUKFf+PNFT2ce1Kp60s4WGO29TUd/RzfUHjIHlkKirQPDekAxRVmaCj95tT6uUY4XyU106YV/+wqwc0hg9lbdjtH2aeypHykBe9m1vMDsXhLwO8V+ihcoV/ifj0dvJtng3QybaP3NlY657ii6pJgeNeWv3MaX60Xmr5y8roT6GX6ZjbljVPnO7IjBzmtZaCV1P+8Ss9ee+QGFUTY6NeGXGxM3GwgbnFVNyX9+GMHiGGW/aZWCbDoVzjt3J+f9ycu67vcKPMNI1skza1q+IgbnoEK6VUBehVn/tgFA3NQSxkdSDK9T3bR7oNBl1W9BbAmM5QPT02G4c2EtAXPXS7y30pvudQLdAIFsVj+BbqRz8JpbEP7H/Z/KWuML1lCyOYo3eNYcOeuyTIzqWMoNgBo8N+Awo7PrqMfNl3DRlH0v4/RdApJd3Nbcol4woEUpUIASk8NHDotZFe9fwzt5pTvOM2w9oh3ESnH7CdZXUGLYTzyrzOM6uecMkiC7El+6Cmh2u5DQixwCPFIPjCW92CcNGQHCKTUwdZV+L9RO2cX6s2Bl32SU6xHZMRc1iVN6a5r1cbgZHENVUMjdwxoG2rUW7RjwSNAfoNQzinjszoxFh+GIqErdaQtHExocFF2c2HC4SrXjNZNld6a2jtaLJ1ix7PQjMnLjJHg6e9j21Mp1EIxXmIaeuzxyhw7Gv+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(346002)(136003)(39860400002)(396003)(186003)(9686003)(38100700002)(6506007)(66476007)(4326008)(38350700002)(6916009)(316002)(86362001)(66556008)(6512007)(66946007)(6666004)(8676002)(26005)(33716001)(52116002)(41300700001)(6486002)(478600001)(5660300002)(2906002)(44832011)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?do43q6JVuEZ2XGad9Coamf683HgbqEjF6aqZCLwaNQRy739CmROCiQ6kw6Lg?=
 =?us-ascii?Q?U/ty59D0UNU1gRs0dsXXRs59QRHvuGcQZ5AqmC8xw91vfsOOVY7Gqszjq0+D?=
 =?us-ascii?Q?wjb95AeLTV+poSWlgOxIZwlKRPvrMEaFLzWuU0MTWoxqkHvrTUiylkwLeXio?=
 =?us-ascii?Q?vFNY2CpdrsM1QrMcrXIEUD9O0uk2aIQHanq1clYqF1ty+ieV+GCVjizYgf9S?=
 =?us-ascii?Q?SHPvPqRJIEuUb3kD65GAAy9GNy6FqgR2fnvKMKlRD/Nrle2QfXBjTvkSKQZ2?=
 =?us-ascii?Q?u84EKtttencQIKaBq2wjLTwpNQA1lSbF3BTxzF8YCglyrJSI55G/U+i0EYpE?=
 =?us-ascii?Q?9V8hIvCIgUBFb0ASMdZrxBRSQh1UGM/D5XNQqMJHPddvWkboP4NXX+5iztqN?=
 =?us-ascii?Q?E4h913QXZK2BCTepEBrq4U4/eo+U+YhoDYxa9fflqEOBkHBCKX6z6e8qInkD?=
 =?us-ascii?Q?E2k11aSyA/jWvAJsgWYio6JMNWgEepQXoDdADvC4D9Qe6BNe8LcMYUGbvgbh?=
 =?us-ascii?Q?Xj/Uz9MRuoVvvS9mxS5vpTuGC+VQJRLQdgWq6eP0KlCRN+Z5g982S9HxPueh?=
 =?us-ascii?Q?EAn1RI52WRhQjULFSkOn4NIeKV7UsG7ObISRLEj5R7bOGKR9s5MARa0Yx706?=
 =?us-ascii?Q?tGrl2mTZyKtSsUn3MFlaywh92UcK9t5SUFT1FPJoDayULQlibYR0Egqg89x7?=
 =?us-ascii?Q?ngpAdXT1C2YY3/JLR3mxVfBCAkgmavfGoPuf7uzW1O0NtR2Xgibo8U4/6VHm?=
 =?us-ascii?Q?86Cv5w+cmi6162yhkJ5YzXg0J/K22hQc94b4AopsUNaIWzETlIOcL8h/6Vk+?=
 =?us-ascii?Q?QwWNVfsHBY1mOX8RY86qeb55hhAfbLH/9iOG/+pdDGSftKPD3dBrvTyxX9vR?=
 =?us-ascii?Q?t9rmiYkziDQ3OTHsNxK6iXLR0HkcjXFcaEX4rGE/eT4sdizV5KjZRLCImKR9?=
 =?us-ascii?Q?OVeO1F/Fi6gBdoa90WfHEpS4UOHnb4BcaL5Hk8NCqWIr1gwD/LxADl3K34fe?=
 =?us-ascii?Q?oykxFXz6Y7GoL3bx1BqTjevfAwJcv3+TwR76CpeNUBsFkGC2/yTr99IHCu63?=
 =?us-ascii?Q?WQycSdRdAkYx/Gu4SIPf25VlXgrMidR0EivFgXQR2zU8mVJaqmNe6VG0hBEq?=
 =?us-ascii?Q?yGK3Oxl1rfLSTEvWtFrt83rEohuFQFvmAlmN5O7iwxkwuPCqAq5xZq/1MyQ6?=
 =?us-ascii?Q?k+Pu14xMW9/jKNsqmPzFZPw1iqRLN80EZO7Qp44BZB1a3yfsxhL0b2bvyEpj?=
 =?us-ascii?Q?Wk29jF8scahjw+dnfpJAQYsJDMxojOLdi9dO7p5rrKtd8X9EZiKaxU78Va94?=
 =?us-ascii?Q?5otopSMcbEMsh+5+IAPu3GgvfEIfjfF+m2X9ZNu+Ej3OrVYExzsb6d8aSHSB?=
 =?us-ascii?Q?XfuEFcXJZHNr2f4DSqLMdpXFxMxsTeDs03nD0/i803qEVvqSp2iwqIPlwBeS?=
 =?us-ascii?Q?q/zjL2RivTf+XTlAzqY+ll6aviOX8vO+9+glCo1KUgyKYVYr0I7bhbYmldm8?=
 =?us-ascii?Q?cnUiS9ce74jQOn6eYKh8+gAZKpGsGVh43ehmOz5posyt2kMtqP3nJGpt/ChB?=
 =?us-ascii?Q?7ChwHTo6vFB/C1hjFd0Wv/QD0D5HnJyrxrzMloyZ82gq388sgktL/2NDUXe3?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948a570d-81b6-475e-dc18-08da86b44f31
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 16:10:21.1467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhUdoioOHshZvx3VCCaJ7ISgnyTAXVfzBW2r2BstwIA7OAC9VvDv9QkrwPKhcyp7PnMfxnyQFVazyZ6ymWLxH/wEGnLM8hqxqwxoxmXsTAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR10MB5496
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=724 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250061
X-Proofpoint-ORIG-GUID: qqapVCaf4r9E_wNASik7IA4VW9tHjvdZ
X-Proofpoint-GUID: qqapVCaf4r9E_wNASik7IA4VW9tHjvdZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Rob Clark,

The patch 4165cf7ba52a: "wcn36xx: check dma_mapping_error()" from Jul
3, 2017, leads to the following Smatch static checker warning:

    drivers/net/wireless/ath/wcn36xx/dxe.c:305 wcn36xx_dxe_fill_skb()
    warn: 'dxe->dst_addr_l' is not a DMA mapping error

    drivers/net/wireless/ath/wcn36xx/dxe.c:805 wcn36xx_dxe_tx_frame()
    warn: 'desc_skb->src_addr_l' is not a DMA mapping error

drivers/net/wireless/ath/wcn36xx/dxe.c
    290 static int wcn36xx_dxe_fill_skb(struct device *dev,
    291                                 struct wcn36xx_dxe_ctl *ctl,
    292                                 gfp_t gfp)
    293 {
    294         struct wcn36xx_dxe_desc *dxe = ctl->desc;
    295         struct sk_buff *skb;
    296 
    297         skb = alloc_skb(WCN36XX_PKT_SIZE, gfp);
    298         if (skb == NULL)
    299                 return -ENOMEM;
    300 
    301         dxe->dst_addr_l = dma_map_single(dev,
    302                                          skb_tail_pointer(skb),
    303                                          WCN36XX_PKT_SIZE,
    304                                          DMA_FROM_DEVICE);
--> 305         if (dma_mapping_error(dev, dxe->dst_addr_l)) {

I'm so surprised that adding this check fixed a bug.  There is an
addr_l and addr_h (presumably for the low and high bits of the address?)
The ->dst_addr_h is never used.

A 32bit dst_addr_l can't be equal to DMA_MAPPING_ERROR unless it's a 32
bit system-ish.

    306                 dev_err(dev, "unable to map skb\n");
    307                 kfree_skb(skb);
    308                 return -ENOMEM;
    309         }
    310         ctl->skb = skb;
    311 
    312         return 0;
    313 }

regards,
dan carpenter
