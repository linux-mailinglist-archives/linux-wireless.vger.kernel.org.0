Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98E85685C8
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jul 2022 12:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiGFKjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jul 2022 06:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiGFKj2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jul 2022 06:39:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851602716A;
        Wed,  6 Jul 2022 03:39:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2668RIs5010983;
        Wed, 6 Jul 2022 10:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=0h8KdLN7z1jQezMPl+y6V7vvZEqcMX+c5LRC3dt1IhY=;
 b=PNSV6FOLlo6zoOHwTikNUaVsO/fYi3nlew9zN2xQu/8CXoKfv46okUyA/gw/+pp0GGw0
 taaG6ik9d38K6JS2MJ8xmeKPKJTqlA6Ruj2kZX2tXmYuEdTTdNKyN7Ixh5hovq+8GJdX
 r/eBdRjY0geUGLCEcu5L8luNF7vIsAqvYYc3KoYglinLIMJafFIxe6Paxr6BbvsiwO0v
 gNyMOGcUB6N4sWWjUQeNVH/V3vomdvjZIxhUZcRmwUiR9Fy6uGXqdkUPKikMqOQ7lMzv
 SqnFeFA99U2+gt2LPUL0ulg5hoUJorhqvus6T+cSXbPBwbuNUN36wqGK3g/JH/q/9qJg wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyhksb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 10:39:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266AUwJC027953;
        Wed, 6 Jul 2022 10:39:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud0q5xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jul 2022 10:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auZ6Hv5i7vDmvXTN4JEwxGrFM/1jFfHkz2zshmkHkD1H588u+uyauISdbjI/TseU8EEXrDChRJOrA8Y07UTYS12krh32pUOL9IWNjIfUAtA+S/cYc+GidBjd3TRx7kxJi+vqUtnSGH99zlx9SFnwOkrLK8Ln6WYQdyFt4Xu4ggweOm4rw2VmOA2SGYY2xr4RFWz95NdDNoPuQkQy7aDvxf2SFmCwxd+MB2s0dj85Oi+gfbdxzQtTN5Z4M4FHHq+kIAx8UUX//Edzd9DGX16rHQiDHz1BpgYUlheCYimfukH+XlzYrbLdATCr9YOmspzR4Z2nW73LLRvZ2vmOWowZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0h8KdLN7z1jQezMPl+y6V7vvZEqcMX+c5LRC3dt1IhY=;
 b=CbskXY+6KO7Flm8mBfUB/eGJ3XQgdwQn+tP6Y/jgad41gX6SLDydqcwNEFznrvQLgjmYD1Mc3xKSP6kHFEhrEqoOycY/BL1jSQYxgeJuB4ByOz4zpoDFO0/ITaxghNCX6BXeGMc/c7mn/dEDSwqHwSjqVanJrSu6Q66f/yiWFw1MQSmf7/ly2uLvbNRQgXU2/kKE4zrJz7WyJzKjyeRo1ztcVEYZ0CK9aLuJhh6aB3jPBkDqZgyCSwBM3T5fcEbD7UIsK8FTcJU4OCXajuECVHc6EaoROs8aPrbufAwBOYTCDLQmaq9/CxqB+j+Rw+AlNSCKeZf+Rbhe/D8n+MyEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h8KdLN7z1jQezMPl+y6V7vvZEqcMX+c5LRC3dt1IhY=;
 b=nHbdNwmNmVR7OleiuMFlQHTxStRvvzw+54zbvCFbfZqpVEuFkkVe08B0bI+VAWfaZyGYBXPzSM6trgSrA/3GuzGQRHCZSrVUJgcoX+N9AM7VMl0VBpugwpLyzmxGGDfB6B9E7TEpQlv33OfOkH9YO4yfQNEHPbRDvVdETY+NX4s=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by MN2PR10MB3920.namprd10.prod.outlook.com
 (2603:10b6:208:1bc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Wed, 6 Jul
 2022 10:39:19 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e038:d513:8896:32f4]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e038:d513:8896:32f4%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 10:39:19 +0000
Date:   Wed, 6 Jul 2022 13:39:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] wil6210: debugfs: replace in wil_link_stats_write()
 in wil_link_stats_write()
Message-ID: <20220706103901.GD2316@kadam>
References: <YsUx6tbR5jhJc/UH@kili>
 <YsUydUx6FEz1ETq5@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsUydUx6FEz1ETq5@kili>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0060.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::14)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16826982-79e2-4e9f-1f8d-08da5f3bc79e
X-MS-TrafficTypeDiagnostic: MN2PR10MB3920:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4grPq4wk9Il/TWLp+YIB+CZslUJtCxSbErucAAfqnp2cD+hmXW9HmaUhrv44eLPdIOFqKSNdPKAYLObbWVLKq2eVfSdgNnc83Yg5TfYHJRD1cBQZq+P0UUMYaZ3hklfojnXBLR+Be6k2/C5jLs+ZBWsI8mmNgnfM3r2wFiKlOdvGXWXmHKQt5XWYYMdTsYl5voqB/SmW4SoD/Ce4Bc5RmFxg57LFv2C3b7Tsepuc+CNZJ2OYtW8IiJ0qFn1PLKMpbCqVFPffRJkUHCEbH5MSPpaUEHuc/sq8dpeOJp2DdhJePWGEea08BobpH5y9gOfi1PuVVYurdnFDzx6DTvjfSmT5fflzuWCdy8+0DQf7usGibgG/Ym0+2DiTtnB9fzrCvkHxHI8TTR5gK0mY+J7mmrpjI+z5xmMtd0HW+JQe8JYzzNUXZ6/yALyQ8MH+mA2b/eDACk3CMnmO5QUSBcywT09ax1SZjBgq6p0mUnZsMBwysQ3JEfxb7JoXoVYi7D1Rqpznp7XYW50+r7K/RQhoX2tqu5kYIJ6ogo2lK1rS30gPxC2P1mh9hQLRIr4M5Zbkuwrg65N50mxr6GNrLBEiN9W/COmSr3wnR1ecW3K0x6ZJtdETy5CHttde3mFpLd76MmL8JYrLZ+Y9yfuwWGVeGOIuqEZunDVViVJf7QjaJu3A5rArwPNK4jdh+r3j/pky8X8d7HSJszNpivOtx4cjO8O0pH5S+Sxr+q8GBKiBL3GtPvuS7fLtXrZFABksAJc0EfyfTsTGAHFEMnUfG+qMtLX51HTHfvXLJO1XeCwwV+Jnw8LpdE/yI5rhDb+Qr6e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(346002)(396003)(39860400002)(366004)(1076003)(4744005)(6512007)(6486002)(9686003)(38350700002)(54906003)(110136005)(316002)(186003)(38100700002)(66476007)(66556008)(4326008)(8676002)(44832011)(41300700001)(86362001)(66946007)(52116002)(33716001)(8936002)(33656002)(5660300002)(26005)(478600001)(6666004)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7UUWyHdxx9FYWZX/G/sN16WSr6kDw1NgfbcG2LfuqdC0anOFprtaXEawt8Bf?=
 =?us-ascii?Q?LOVbaDLyMzZqEnGz9Y3NnDFSZNdi2JSl7OBCWYlfcOaQmDvePrzRXD4iaBDR?=
 =?us-ascii?Q?xw82KkOOG2UdVPmfn9bEYcg/ON/u0nvfaLw1gmplCw+PlfXl8qDXGMHxmdJK?=
 =?us-ascii?Q?ELUvafN4AaLxZYDXBZvIBSfjngzxwOFlvl0b+eCQyCPL4UxNrkIfO5YvffFt?=
 =?us-ascii?Q?HlkMite/nUpEPlx50IGrY2h7FbSe+XA5wRYoih2JnWacqJzz55YtAHY6YCt2?=
 =?us-ascii?Q?YWfISsGqPyqJqMwOTwURFZBrE5Nqbnt0OceBeqSDvhBFLhbdkn8+7x1Xrpyi?=
 =?us-ascii?Q?i2wCDSPrgUbT/HdD8lhG/NLvMYvr/C2xTX0RxrhvTtI9PzL093nNsao/YzAO?=
 =?us-ascii?Q?rFcBDmoL5R3Eoj0G8DOboBqxGVYP7Mh/jdT3LAhedwzgedabMWjwBFcV75sB?=
 =?us-ascii?Q?CEwiJIxUwshY3CriiIsyFMv3sJaKu+Dut4Bc9VQSTK+cMq8QC0w7B0i981op?=
 =?us-ascii?Q?2vdSTU0bARoz+FeqeYftnNg3yJtBw23tsqSm+X/5WVu69dyIlt2NgD1CkZpp?=
 =?us-ascii?Q?gGS6lq5d0AacoYpv+UbQh2G0x0Kzj6Lqa/MkvTpNyxDCIZFKgj55K+xDhx1R?=
 =?us-ascii?Q?+YYW0Hdu9xvHA/t4UvbG38ZF5EtyVNFxccc0bNAx6engwwyBdcDWn2CqpEVc?=
 =?us-ascii?Q?tXSsL1V63qUDIBqEnLXWnbYHuKWkV64VgKYQb4gM8Eix2BWlnu6GE5sy3aqZ?=
 =?us-ascii?Q?P7JDz2rSx60YVdWm99UXMAou8powsNP7LovLFN4G1EU1S8yzk3uy1L1x40fU?=
 =?us-ascii?Q?gy0V/WpdVxQSHs/ZsthXxuG2I7Cqe5/TZKuNhvULsQKGPv48MOYpg1djqbHt?=
 =?us-ascii?Q?YX4/x6oyXxjC3wCmjh51OcOFgu0HMHZA3Gzv2U9LAvVJynm1OB9wi+yMt1Lx?=
 =?us-ascii?Q?DAYLov6gg0FRGwv2fpZPCS9NHuhcOx25aB2Nu+BKeWWJIIKdtWtd6tJKKCJs?=
 =?us-ascii?Q?ysg+8tNJD47t9PifmZZW3TQIUk4Aw2q0YBZyw/QhKs09x0f2sV885OpRkpYV?=
 =?us-ascii?Q?keXwTOCikt2qv/HQCdT+zNRXsH3x9IC+B9jsFlEWs+1AhbZycVeFbwXXQDon?=
 =?us-ascii?Q?1Wii/Qc7QbSPRMphkMBizFQ5OTZ10EoiBySAIwMcZy6YISPYnaWoNkLiuvBz?=
 =?us-ascii?Q?fMsn3RNK6DoDigkGNbXZ3KG0KTHaLta+KNpHacl2UnywMpIA4mgxHxEcJ66J?=
 =?us-ascii?Q?rQwboUECm1enkDIeL90WMqwdtFbjzxhauD+mUYNc2bB13c342HbspcnQnGhg?=
 =?us-ascii?Q?/qefVtMC6DPNYdqSlTC+PSRgkT9M+ZdbM2JnN9zuAYauz1DyPWlCaJSjnJG4?=
 =?us-ascii?Q?6YI/k2qaLnM7+EjPlYeOlqPHApvyCMQx08+/ETD4C7Tgbq9LWwYIuYI4FfL6?=
 =?us-ascii?Q?F8TX1++/3PsWYvIXY0GWFh/WCwKZBO5yF3Yg1KE/9Sq9G9PeSi+z0oWgtKYA?=
 =?us-ascii?Q?pk2VlI2yXWLGhC0CGZVStam2u2IoWHxfY3Nb3iKFuSQ5CaIa1FVAiiECsWcc?=
 =?us-ascii?Q?yPz1nU4MP/toQcmGjLjRWzuGCocJnjiVyllwehPutubLCoh1sozKd6buT9yq?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16826982-79e2-4e9f-1f8d-08da5f3bc79e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 10:39:19.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkjJAX8GsmxKJ8vQBxFkBqD7gzkoqle4hFnnqbBgusX3EhXF4M5Lzz3JZCiWVCrF6thj9/Ap1MM+TLWfpTuEnOhNE5p3t6ET5Zdm7UWYU10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3920
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_06:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060040
X-Proofpoint-GUID: -NmzE3keN89-KS0RZf-bNN54KnaT9UnI
X-Proofpoint-ORIG-GUID: -NmzE3keN89-KS0RZf-bNN54KnaT9UnI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jul 06, 2022 at 09:57:57AM +0300, Dan Carpenter wrote:
> This code has a check for "if (rc != len) {" so it will fail if the
> simple_write_to_buffer() does not completely fill the buffer.  In
> particular it will fail if "*ppos != 0". Although this code works, it is
> more complicated than necessary.  Just use strndup_user() instead.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

NAK.  This one is buggy.  strndup_user() is too strict.  This will break
stuff.

regards,
dan carpenter

