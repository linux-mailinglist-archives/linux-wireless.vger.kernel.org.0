Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA92A476EB2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Dec 2021 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbhLPKR2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Dec 2021 05:17:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37840 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233295AbhLPKR0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Dec 2021 05:17:26 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG8nHQS031789;
        Thu, 16 Dec 2021 10:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Q1fNDbFLtZJRdRcbaeeLnoQq2qj+VK90jema62o13Jc=;
 b=btKsY71RcrEb5z96MprqjOjsxRUPCSNLMen1ckaknyDwwi22FINYNvlTo9MZlaQG3ifR
 PBUfoOJkiYCnXQde5pR0TTV0fWH4NcWL7NUgnKfgST4HDLu5qXL2hWRVfJGuk4qWlJSa
 su/0eDMyu8+iHnLq5r/E6KMlgJRYiUbh1+paE+Ls0tin6EgZ4q+tT71jJTGO0qzPh0HE
 age7QSARLCZJBbUw4mRUiCaMKc1w+WXNRGwKyN3DqT/xqiXrqIzqmJExZ/703w6fQvVh
 /u+dmbTrAM49i3+VDwsNtUZDH9TtGDC9Apy3JYY9qG7Su1vjavRnROjLr6WU9pMWpSU6 Rg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmcja1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 10:17:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGACBvM061178;
        Thu, 16 Dec 2021 10:17:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3cyju9pacg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 10:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOI1iMGRYIR3MEoLfAyyTjv5ZLpf0qMTGa+XGBpTJa1+jaY3pklxsOsbuMP2IA5ErPfIancNWbtXzOSBZH4LfVGtz+UiSvHED333eA6fmbb0lKKZ405MttC6LTWRg+MhrcretVJfcVCCYc+J/bToGAutga0IwthtTVXQpmDtMMeh2uwu3kIdOXNNH1vWXRNvkGKXaRtTuAi5hGIJrOXmLgDBQgw4ZICnyYjkkqCgFQ3fJmrSP9v28n1EqiHWKtmCy1rCVRxvatUozTjifZRb9ngqhwF6iTJ7TJWVmNPlfHGZa3tnsyrlgJWF2bsA7rhi4MKfKGsDZWETMU54OKegLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1fNDbFLtZJRdRcbaeeLnoQq2qj+VK90jema62o13Jc=;
 b=dDPJJEivO54ux6iD0V5+03YxSDJ3DeLAwD+r9T9ubChmDcuxHKcUbDN7NHG5jrtJ905lVq72GxhiiUiGVW1icLqb2n2GboGU7+HuF3B7RM0tlQTgp9uJoA0M5zEOfQy6A7sueXI9SD0lxrVrY/4JGJW45nxqjObwqQfCa2QE8PxyMk0HEfpMR3TXdSE+OHeMX9EsSnyPTEzqqtx6umNNkAR6BpOvgfOqoFeSLvIDoP1NoUKejk3r5EC57WgILf3JDq6j09d9iwvWsfJEMPnXKc+i2eDSnTlUY4bZT0ExY8nojUEejDmy+cwJeiJNPNs/DIdpThtaG4eFw7aZCaVMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1fNDbFLtZJRdRcbaeeLnoQq2qj+VK90jema62o13Jc=;
 b=wLUVpCYOCXN7D8AQMT0Xryh+CO+4QahQoS7sc0EqOj16GXlhXZ/RSLttGhPD6xLBoZfjHizeUcUq3jS14fe8rFPe+XO5qN9zZ4a1nyqdcRNGkCHgGxW2YsSBc+jDVQgHAFV7GzAsf/DbLAlzI8sQBZ7dT5qRAX3X6CpSCrrEe48=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4449.namprd10.prod.outlook.com
 (2603:10b6:303:9d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 10:17:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 10:17:17 +0000
Date:   Thu, 16 Dec 2021 13:17:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     emmanuel.grumbach@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: mei: add the driver to allow cooperation with
 CSME
Message-ID: <20211216101706.GA20233@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0111.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef57043d-d2c9-4f91-a19a-08d9c07d3ccc
X-MS-TrafficTypeDiagnostic: CO1PR10MB4449:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4449EB3AA8D18741E0DDA0868E779@CO1PR10MB4449.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Os74vRoZt0ckHV96jlfs6tt/LSfpErCaIzywYC0QDB3iKReneBDw9U4lkSlJ86pRScrs9SeB39BV2WttrLGpfzhx4zO+J9N17g5B9Fh+NuTc/hYuf7mKrMTm9RrT8qlZOw2ud0K7SrpkfP1Cd9P/y6IrmObYp0++FueU8UQdf9IeQdi0tu/ectBer2IeeaKj4fHRaY3aNZ+sKMNW3ToTiVppKVII3CEnQa2COaFWpJsIttQw+ElwGGN9eLzkOgJhLrqb3XuavrbdP/++OppqNCOlZug0C8XOjEW5XmDv1w3fcAz/3BYzeRDjjZnKjdTO0ZMS7+qoBbqChlIEyGi1/lhzDz1Skyne5VqzO+P/ddR+hAUGWfzps+8FcigLLsbYA1yl4+AOCetOphnglqaSX8QnidPzLBLLC/IPhtCzyH/0l+kjLPwTEfG4Vry8TK4BujxlFy2vp+9bKmFsGIOe1mRDOz/iYdpI2CE4qQgbz02+jiNfvg8Qc88dY6Hyve66Gn4cu9adulu56lfEoppvJyZuGmnJpSRYfrLINBBGgHQQdckSBfYn1j3sYMtjGex2wm6RF+xMIvaSQ6+9gowfAr6lZTfKAoH9UCFZnT8Dm/jy7f5x4Liq7QaFp+KApikX5Dito9/8UJhbN8j52IIXZFpLJKB7f28Y8WkQ4+R0y+aWl8E5GiEVEYrhaCwKVHt16op1zzCi20TgtRRKGO9aQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(44832011)(52116002)(508600001)(8676002)(6916009)(8936002)(4744005)(186003)(26005)(5660300002)(6512007)(38350700002)(66476007)(86362001)(66556008)(6666004)(6506007)(9686003)(66946007)(33716001)(38100700002)(33656002)(1076003)(2906002)(4326008)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JjJF5YMqUuljFdo+1cedkVazRt88IOpoyW0JeDcNv5ib4QWYZGdMF4jeS4r?=
 =?us-ascii?Q?frfhqvKxpHv33tahrN8qfpvyEyAh1Q+DGtPlO3hKHl/wmAoDA3UJOSNGaqlF?=
 =?us-ascii?Q?QFpcNS8WnwvAQug43REj8rrFELpenAHILMjB3rgdJ72Gl0uookMbKsZkA5zy?=
 =?us-ascii?Q?g9B0xk++fqmFz4M/TWgIrTEnQv3a/xB8tpTk+rSGrvTXz5M/LrlEmlQhaVOK?=
 =?us-ascii?Q?yyiBJo7SUwNDWuW8iX9sF2/jjr01SbSXZdDOMJHBqRrCXpfcqS+ZAH9dE6ID?=
 =?us-ascii?Q?2wAEMQOy+1W+YzpwKCT00quKqC7qnyAYZK/d5YdhMTxAlOxTRwuP+MQ8W7wl?=
 =?us-ascii?Q?YY20XqumiyfZXE4FJBZ4ed4aHNhcvBpUNhLrCPo0ktbWfGyHzP/tf7WaWfKT?=
 =?us-ascii?Q?Jsf13u7B2xFMGNnK5SJecB6OGxmmsYNKtdY1EBqvPra7AYK0dhDA8IpyBNDu?=
 =?us-ascii?Q?/IkCKk1Dx0lQIHkrX3f55lozlmWKrZkvmkgho2FJ5ZsULTRDjB46eAEpa9GM?=
 =?us-ascii?Q?efB8Q8L8Y21yxdlbXdRGOhtxZze311kiT9CkloS2VpqRlb8K5Ufqn1WeS0tw?=
 =?us-ascii?Q?xka75Hn+H/84oXIrGYMoJUIVKE5FvtEs+WGysIjYwsykNX+gevUq0G2TIjH4?=
 =?us-ascii?Q?KIz4El3UCdOWolVkQVbpQ+bYCznU236My2Mv1vVIg1UvIjCSweA6M2lHWBHH?=
 =?us-ascii?Q?wN/B2C+yszy8sfIrv7MZ9vwRNt9OKh2m36C83FNvjVB3QJAT3RY7fAj9DgCe?=
 =?us-ascii?Q?ZQGvwWeMcJJlAyooHbghCgTouotazZvAOjIAv3vTmntdlKwObMIa6mulUNcF?=
 =?us-ascii?Q?qJbaurSPBI0EEEmcwtVFwu6IE6Cx6mbtMtYAFOZPMcN/1AaaWJybKa5jOmW3?=
 =?us-ascii?Q?tQNQ9GdqiEPQ3LbGMDijVB6js0Cnl/QClpuENFqvt0Dt4f7tyjZ1T6hL9m7+?=
 =?us-ascii?Q?xPGvGQ2A5woN5Y1FZUq0CE/Dx1EvwzG27sVsf38a2Cep77maReBtYI35pXkn?=
 =?us-ascii?Q?h445eVThIEuJgVJAn27jdFbNaJaXgCKxBxye5pMaubIZF7WxmTYYdaTJA7gT?=
 =?us-ascii?Q?mfI1QmUYPP5W5wD5vIsu3C5WhHhqGQ+2ws/KGo/yjrmbFHEsjNGOxb+Ji0sj?=
 =?us-ascii?Q?O1RISoLzbcMEjUBmr5AdOBytI7+3WpAMk1oCiGtjUAReml7WXYlETPVrS4sw?=
 =?us-ascii?Q?OOc1+MtIUoXG3hUhW/7jPcRxRL15bxbfkwNOyfxq9zQXOThFBMqw3HCG09J8?=
 =?us-ascii?Q?chKWoEVtdHJ9iT/1cwFTZ6MIdbCyq+Amb0fKwqBkk+dIZ3BcKmMFM7XjFcYN?=
 =?us-ascii?Q?yzO65j8ODKj64Cbe6ESQs0aWkc0mahrAjW1kMpfVKDbTOHnw6lQtAKi531h0?=
 =?us-ascii?Q?u2xXKE707SK/A+k6vZWFWOxFoaodxH2bTPOrCPxEE42FSCXMzD46uwZhFSKS?=
 =?us-ascii?Q?TvNGoqyT/0AxF1kkw381eyexzMw6mmSTS6kNVcc7uofSLxEQr+UYFuHckKGa?=
 =?us-ascii?Q?DlvSfVlGdy+PMTnrApL8UgmiFu5zOL8VZ0JIeDAc1xkfWBIc9gdZ3IWHHNf0?=
 =?us-ascii?Q?aKZmDgrTFi0IGnnpgh3j8HkdhkZwtpTw4Z4V7mDqQsfqI34Aihm44MGDdObp?=
 =?us-ascii?Q?nCH5+T/P7gdWo3FNH5HKbgrEqTT/ZHVeBmiHLglzQSfOCFTok2tnPQicKniD?=
 =?us-ascii?Q?yVhLIrMs1W6QfyzwCqmJnklfLxk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef57043d-d2c9-4f91-a19a-08d9c07d3ccc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 10:17:17.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2g/uOYDIAguhX2DDODTj6bbasuD3DjGOJeTXuaY9Pm1wlmwCFKLGfpAY6CqHTCOoZQvO6ET/JvMkRslHaapcTgAzfNnwnI4sC5p9gauRis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=930 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160058
X-Proofpoint-ORIG-GUID: V1kB8fc186aoHuQmVd4X_C7Nt0K1r8RY
X-Proofpoint-GUID: V1kB8fc186aoHuQmVd4X_C7Nt0K1r8RY
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Emmanuel Grumbach,

The patch 2da4366f9e2c: "iwlwifi: mei: add the driver to allow
cooperation with CSME" from Nov 12, 2021, leads to the following
Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mei/net.c:199 iwl_mei_rx_filter_ipv4()
	warn: taking sizeof binop

drivers/net/wireless/intel/iwlwifi/mei/net.c
    188 static bool iwl_mei_rx_filter_ipv4(struct sk_buff *skb,
    189                                    const struct iwl_sap_oob_filters *filters,
    190                                    rx_handler_result_t *rx_handler_res)
    191 {
    192         const struct iwl_sap_ipv4_filter *filt = &filters->ipv4_filter;
    193         const struct iphdr *iphdr;
    194         unsigned int iphdrlen;
    195         bool match;
    196 
    197         if (!pskb_may_pull(skb, skb_network_offset(skb) + sizeof(*iphdr)) ||
    198             !pskb_may_pull(skb, skb_network_offset(skb) +
--> 199                            sizeof(ip_hdrlen(skb) - sizeof(*iphdr))))

Probably this should be: ip_hdrlen(skb) - sizeof(*iphdr)?

    200                 return false;
    201 
    202         iphdrlen = ip_hdrlen(skb);

regards,
dan carpenter
