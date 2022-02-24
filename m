Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF64C24C9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 08:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiBXHys (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 02:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiBXHys (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 02:54:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047A623584B
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 23:54:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21O7idDt015524;
        Thu, 24 Feb 2022 07:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=XYGMA6xeGs2CfdMfUdNJKWAAP1ofjre7C3l2c7tPNLQ=;
 b=MKPFQxVOVTZpiBzWCYzPonRXwMKz0WbvSmjHzwMdrSyLO50Hztey/s0jCQ/Tb4d0Yf/0
 gRGSboSJpnwOFXvFxdSE3zGzTrd4u7PVgWnK4IYzIPfdnJdDxF+gtsbmQr7ZZ+VtfQG6
 ZAlqD6yxey8YBkNmwD5aQvEaKfytyF4iFACWZJc5+dvC2TbHyxZfk2al671xOq9SYv51
 QDKUO9pP4SqFNWD3JUASaMa0oneeZiy4MzzIkI0W1gHPwqTz4mc86XVfCrdWxPE9SNsp
 V7dsAfctpWhBgHcMgGqg7NLefB+fS/TIGC5ctulGauqN8DhmxOfzQyrwmTIyixoFDAEz wg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecvar67ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 07:54:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21O7peGE022788;
        Thu, 24 Feb 2022 07:54:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by userp3030.oracle.com with ESMTP id 3eannx0nf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 07:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctkLLT3XFICS1kOQ07FBHr/ViN9EsTIWBz6VNFZeLPjD8w1UDNALnIRFqe9mbsa+l0TWFZAt2E6yg0XZ9Gy1GFRgI6JlHsdplGB5dRSdXxpTG9FjgKkdaNcE2gfzFK9OiuteV2fU3abKU5LguAT7/GqYZtFJ0ZOWEKRD/Q5pAHYoZPNWKoVSH7R7BpslZVtliIN8GIA+C9p9Tibmzp7LQxm6mcS4lbqB92yuZDtOwFrkn2Z3qMQsnCFGDudWBlR1Cj5zDnHilpXEOtMFj+cEC6OViCExrvNz+XirPtbAdu2FXiStfMzUkB5KNm28XDFQ4Oc9URQYTrRv5KDWBeuGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYGMA6xeGs2CfdMfUdNJKWAAP1ofjre7C3l2c7tPNLQ=;
 b=ixM0O33zwfeAPPdQIE5nPRKwoiH9L54/qss3lEUvuY+RgEhOuMU0TVWeqIfE2tcKnjlCGi/TTZcQrLJg3LNfWVAWrdjuGg6d9THJT7UGip/HKUf6yXauCJ0Q6l/ur1mYeHEosJNYRm6sZIRQUVMNkAbDbD92nSbFGE/DBC+/6WC+gBAM2QWHRPQ1ZcOKFfLaCGg1PD9U5xO5sqyWtw57PRf6WMZEWXVNxRiemAVtrhVDOpKqoO1PydxpzobSQyl/oHIEL/EPFusYWFtefN2STglWXRkT9zFdjwYLl6iyQgM/EBEyL23Eadh2pl9kq0xFcDxk7ZstHcGrO5PrXQNaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYGMA6xeGs2CfdMfUdNJKWAAP1ofjre7C3l2c7tPNLQ=;
 b=EkWuQDYeRXlj4abpn3Sp02FuWKFaZumG3kT7haTIWYz5B3BcIcHHpQcR444hSPc6scGFJRffz/trZ72+V/wdNhy0jPX+++u5fSGvPDS5P82e4HYfwpN3Q9SB+RXeAwqfgOUxocLV00Yayx5anld2ytQtRBMrUnHJ4+YdrrMUF7s=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4348.namprd10.prod.outlook.com
 (2603:10b6:5:21e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 07:54:02 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 07:54:02 +0000
Date:   Thu, 24 Feb 2022 10:53:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Francesco Magliocca <franciman12@gmail.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, rmanohar@qti.qualcomm.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: fix pointer arithmetic error in trace call
Message-ID: <20220224075346.GL3943@kadam>
References: <20220221122638.7971-1-franciman12@gmail.com>
 <e32de43c-e00a-5766-e988-fe192d36d719@quicinc.com>
 <CAH4F6utmtAM3CzX2_Fbn94Sb-X8m0patPh8yWwbuBB0t1VYH=g@mail.gmail.com>
 <87o82wvhtk.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o82wvhtk.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0067.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11983101-d96a-4cd4-09f2-08d9f76ad2c4
X-MS-TrafficTypeDiagnostic: DM6PR10MB4348:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB43482299CB5F84810A7F466C8E3D9@DM6PR10MB4348.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3qdGOBi7GFKD5aIhkS3DxXnM4P9LShsDCtK8aes0R3MNrabnA7vlKPg/ScaZudXXotsf2fFPIDj8ppNcXA+UX7hCikGSL7Dib8OEwFwH667Nwbgq0FQzqF4dy3X8KtyiHAt4yMFMqFk07gCI/FYOvQPjI+ESMI3OhVBl37I7HfeJn0sLKdEr2+nET0NjDDifYph6RpdpLSp23RcHUgW3Kqn9Aj+Vu7NTTJ8Y+kooU6eYBoAW8yuV2LAPXQHRhvIlnS9LO4q9kMJ7bMY9D3/xNUURO3Fu0np9hE22Qsp2reT+xtHvaEfeH7MxfGIeKcwvMHwbbggdR4BQYhx4/kQ6J2luwrzc3KYCm35d2+ewQjHMJ9uoa7A+PZ6X9iifEl+9UOs757j2v9ixlvJ9Y6CQhos4aMeKnRUWxrCI5t8zviyrRWmE2mL88j9k3XftW+rImB4LWUf8N9uRlnzaovOoWVy4+XRF1vNKfm82X2zoKO2mB+zgY5KlV4YkqnfOYYDFSl7yGSAJesr6y0Hq0TKCiSffimL2COSTaPGvQVJor/4YXb+apvriKuI+/8K/9akZnPdywIjhPoOKB6I7ieUt/pGbTPoX7vvGpaJ+88rZDsci+dzsn/1N8Z/Bwl3wo7mzdk8Fxrwpid+QMIgUrmVWF4HD1jYaS53qlzr7KwiZrgG1YAUmYPtPR7LKP9jfFLOBP1o6v53d+oBy2s1UYCQDkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(54906003)(6916009)(6486002)(33716001)(316002)(2906002)(508600001)(86362001)(8936002)(33656002)(38350700002)(1076003)(52116002)(5660300002)(6506007)(186003)(26005)(66946007)(4326008)(66476007)(66556008)(8676002)(6512007)(38100700002)(9686003)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JN/5zbgQHkc2Rpewnvuh11CZEH4jPlSuuwM5GjkabkpNFqE21/m0tpzYVjQr?=
 =?us-ascii?Q?R+pdTh7xdO2yJBOV9Jy2d8ADUY4S12ffYXQhnR4gqEmnUe3CtgoC7AxjRXsT?=
 =?us-ascii?Q?kac4WcLgLrDL2JiQsycdf+aICcKLmHcT7JKa4chajowkWv0/57Xfmi8ogzRy?=
 =?us-ascii?Q?AGmlgHoLizhEePJHUUhrZL+Cb/je79kZbCmSYUo5LNJk4RNNTrNw0IbClwpd?=
 =?us-ascii?Q?2lWZJlCZSycSy9nW50gRQ8lQlBNGgh3gMcUvxV+/hL28V24B9qdOtxjbnbt+?=
 =?us-ascii?Q?tcP6VkYOaSPyEGbI7to6EiwUU/391BpmagX1Auv9caax/3i7wQf3YuICEDpE?=
 =?us-ascii?Q?YG5jc67TAwMbBiQwoQkTyJM4zvQ2iq4NJlrFWYwzQF/7nPhZQdVYpiH7TWD+?=
 =?us-ascii?Q?102cE9t41FxCWRCPNNKsgxTsGSZWerj7ioGWIlDM6QfupVL7rtLKe1yV8fXE?=
 =?us-ascii?Q?bUBJkXdJEGU0eeuvReJzDVYWe+x8NkwXpyYMk80lgfxCzaHVRorqXdeFIfQ4?=
 =?us-ascii?Q?R5olh6XfMaLRJ9vCyS9CitflTdAaoh0Arj6SD+Mamxfaj0qeirdnABx/IE6m?=
 =?us-ascii?Q?Jkap2OHppzSAAHnRxFUGLOUgv6KfL8Qm6ce0ygDfnONrEGb0e4aJaZzu+ilR?=
 =?us-ascii?Q?fcqyyjoBPL0Ew22jX5Gzx8mJ0zLC3widUWHHyGky9vzD3tdng/V4N92XWxg8?=
 =?us-ascii?Q?v+mBmcCjfch4Vm8sJpGJHB48SQ76HkO2++BsJ3pDDo7ELdS5G0TR3d3QYFwc?=
 =?us-ascii?Q?ea2bLd8wx7A4vu3uPWyIS2sKJ8E3k2/f9776c8gjPhFEmQMDoX659VHBk5Aw?=
 =?us-ascii?Q?cOIK5qSAWGwHcRIpMrBmvmHQ/up85NS1u0IABdBejITAXK6pbWYkRcwb7PqJ?=
 =?us-ascii?Q?gn+YqU/bYrO3qy/QyCjRS+n/jQ+sqL8zM5IMLCCkjLYtA3C+YqLTdyaIBF5m?=
 =?us-ascii?Q?x84AngpeGWfaWxQYrxEz1c1XV6jslnohmdHRJoaYzTB4jCKvcUXfXFxCMYSp?=
 =?us-ascii?Q?AbmnsfyrhcfPuM1L7aHYtR+3Gzd+m2rqcHdSgWyKflwuAy+XI3qA2w93syzT?=
 =?us-ascii?Q?WVxNlZq9sCNRzLk5AqgUiWQoLFYA9ERHbruUrCfRnLHl5YgSVkeZLeCdeZUA?=
 =?us-ascii?Q?y2NJK0xOeEjvLY1ETxP0tefhOiRrr/LyC3nMtIRD9zOCIsrGK7Fgjqjyy6Iv?=
 =?us-ascii?Q?I9W2jjckEvM/FdJXcuoSh2LTdqatCN+mYVke6n+LsOt2HtoAy/A16K8IPiXP?=
 =?us-ascii?Q?GAvEWs4Tdfwf+vMXmj5qhPIkNPTwdiAx/9XkpZCaHMOqRJutSM1+MyfsT2LF?=
 =?us-ascii?Q?orHpR5zyEaEvZ8ff69aQLYmPp5aC0SsgyEsvOzqwyO6FR4ey2YFestdZ1ZYU?=
 =?us-ascii?Q?k6JdnguZae+Pcbh/fLjKuphAzxG+svDevQvjs8JwPORHGn+51rp6vSynC7qR?=
 =?us-ascii?Q?SQnN91gXZKCiVUygHzW2uLjcopHGJmg45T4MJ2JMsEJcnuyqSbZSAS4Na52D?=
 =?us-ascii?Q?ESkCpLBKHTdsxGQ4DutOICG/Nn5vST13cw+4B7oJVxpW3zeiXQ4QmtU38NeM?=
 =?us-ascii?Q?+ye2svzRG9+b65msrweBtHk6QcjK1HxHqtYpq/eYC8h5O3qBuTL04TSpj6LX?=
 =?us-ascii?Q?wwrXNyWEYXnsDOOXFjcpuOozAltwg2yyhYFSY+zvFDkLi81b8DyVi9UFBNch?=
 =?us-ascii?Q?h54Aig=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11983101-d96a-4cd4-09f2-08d9f76ad2c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 07:54:02.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9E19NA5Wic0L0EmS3GlUOpCZwDDY/xxkT5ByW5H/CfmE4Wg4m9wQiBKQAmMFyttvZ9ZXsZdvy1TdL0rOc8HBngkUoYIdhvigD8aqhf1Vl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240046
X-Proofpoint-GUID: mEmj7nS_IZ4Q11yVDyOyVEl89SJzHeZr
X-Proofpoint-ORIG-GUID: mEmj7nS_IZ4Q11yVDyOyVEl89SJzHeZr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 24, 2022 at 09:34:31AM +0200, Kalle Valo wrote:
> Francesco Magliocca <franciman12@gmail.com> writes:
> 
> > Hi, I picked (void*) to be conformant with the other examples in htt_rx.c
> > For example at line 1431:
> >>    rxd = HTT_RX_BUF_TO_RX_DESC(hw,
> >>                    (void *)msdu->data - hw->rx_desc_ops->rx_desc_size);
> >
> > But for me it is ok. Maybe we should fix all the occurrences of this kind.
> 
> Yeah, it would be good to fix the void pointer arithmetic in a separate
> patch. I have planning to enable -Wpointer-arith in my ath10k-check and
> ath11k-check scripts, so patches are very welcome.

Void * casts simplify a lot of code.  Less noise.  More readable.
They're more accurate in a sense because it's not a u8 at all.  The
kernel can't compile with other compilers besides GCC and Clang so why
care about that the C standard hasn't caught up?

What does -Wpointer-arith buy us?

regards,
dan carpenter

