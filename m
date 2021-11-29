Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E9D460F3F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 08:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhK2HWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 02:22:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28184 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229899AbhK2HUG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 02:20:06 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT5WHlD007901;
        Mon, 29 Nov 2021 07:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=etbIXkngajiTiYrxou881bF0Q8iEtr7+RnlABfOYCQg=;
 b=y3PZSS2fLBsJKvpPsqVA7sycWHbTborYO33tN3Cwdi9hBaNKtqohd1K16HuckFORvfiO
 o/JLFVYziMNtlKaa00XUEhfYlNV1VUoT5R49y3J3GT/r9kBdy8tTVnc7bEAllRffYXrt
 jEoEQX53bu+oPWxTkI2imkHokQV2TgepnNjUPp5Ie+ttjEdJoZixKa8e+HCgxJ4uOr6s
 PVmYDgY+sk8c1GUwrJCLBgWiArVju3pUnh9FLpAAvVa6emjGHHJiGuh8AWYZkSpC8jw9
 RRKcN9E/fSR/dXiKr9Vp/nBeoLpUUNViq/1iqplB8eARazvobezm3El5kJ19MVdMMhnF 1w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmrt7rc9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 07:16:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AT7Bm62104826;
        Mon, 29 Nov 2021 07:16:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 3ck9svrak7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 07:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBPPhQotc2mGusAHNKe+61wYCYQhQgTN+Wnqiul3NuSsAhCCdLsdoggglg9R2Sq+dJnbcT5O4aVkoXMrkGL1DSm2pFLtYLtDxyBJgExqw6gVGWHeI8/hTuq2snedVSRfCnGMEGgZpGxiOlNdVGlSrhf0rGa25RkQoslwY1iv3rz22TnvtACeIxSb31AlfkyWi1WVSo/mS9ZFy9xEmOp3UacWqAqrsCIZIByVQh0CioYNe7Ja+Y+ScnoJJ8Db7gLHc1kewsX6tT0/al7sTA/LCADRLsJpyWVzoXvy45MFzhfC+aBeSRTUy4pgFzNSGh8h7CPNzemtc2oeFUyMsdqZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etbIXkngajiTiYrxou881bF0Q8iEtr7+RnlABfOYCQg=;
 b=ciCBHG3XWoavi+P/D+5/EJHdr6oQGECGffab42dmrRRDckJGrLou44zvK7L9laUp2Vz0oYqlX1BcmVXvsPXqf5j7mkDcbpO0ChJSw/YFlqBW+NAKxLhlrxJx8AA2CD3CH14k1CWvc7pOxvcI9Js7q2OfNJinMH1PuIFFR+dCgX9zSjlIBJTw7d4wzUzYLkVjZwyznecYJK26cOe8yuzgWiVlmLhNLftZx19676t+KjV/IxyUaLOmcys2WZ4zsxrjMYiOmP0ZrMbFA+uzhLyK4ri3gA02HDvyYY6YkKkFREX7xsdfhRUrSpZVJcSk+AxvbhSVNB9PFsigVM+L9ipolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etbIXkngajiTiYrxou881bF0Q8iEtr7+RnlABfOYCQg=;
 b=kH2Sqdyvg59VHZkwFgdaw/hbm4Qk+91IFyG8n741nwm+O3luaSEwthtMWO82IRO70++uF6BHILdEWIaeEruec3313TevgcO/MDKNgNccsBFlbrTooiwKvLoyREyq+XMkLeF0eByVwb7kAS7jEqKlD82RK6XMVmo4X8cCGBzv3fs=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4724.namprd10.prod.outlook.com
 (2603:10b6:303:96::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 07:16:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 07:16:21 +0000
Date:   Mon, 29 Nov 2021 10:16:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     max chee <maxchee@outlook.com>
Cc:     "security@kernel.org" <security@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: Heap based overflow in Marvell Wifi mwifiex_cfg80211_start_ap
 function
Message-ID: <20211129071602.GO18178@kadam>
References: <SI2PR06MB40600A3DBE2D37C6C484D4A5A3659@SI2PR06MB4060.apcprd06.prod.outlook.com>
 <SI2PR06MB406009BA8EA40388A439FA3DA3659@SI2PR06MB4060.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR06MB406009BA8EA40388A439FA3DA3659@SI2PR06MB4060.apcprd06.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0038.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19 via Frontend Transport; Mon, 29 Nov 2021 07:16:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709fd3c3-ef35-44c2-c00b-08d9b30824e5
X-MS-TrafficTypeDiagnostic: CO1PR10MB4724:
X-Microsoft-Antispam-PRVS: <CO1PR10MB472434E0A3015282B8EBB9478E669@CO1PR10MB4724.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DW9C4DZZ2O/F3VnCHVZpiGSsPbv2Tva9SJ+Cyj8Rv66+Y6wNRCiE3azd6osQjbW3Oo3g4iEdEt4NanLbS3AoDgKX+piLvvbo0aHi1osdb+ee7hfRCUhOQytLXpdbuZloaV5qzLsvPWlaDNXA40qrkLF5IwhoK7otojmQnC6u+kkkfxfOQ0AZB+j7BBNF6eJmHCUnmFM+R18XYSys0WRnh68Ej3NUyMN6XERl8+qKjACTq6HiF33XTNjbYr3PhRTbo8m6O3kh58S/pbS5ESR2DX9Hii5p/3Xsbvb9l2KJwJJx5iB2UFDwdFZNFSoDO9dawFW+DZshLOBOnDwpP8Bfwomm/iHl0BMX+AZTvdEzaUV588LtO9jZ7jB2KkMVBAEAllgZxreV59GM+pZxpwJvlkiBVICWccTOMTzKfebia/GFSg+rTLgHUym5sanq5w3qJCs14Q89OKiyM5A97oJdQRKLil0LB3TF2UmRYat3SPEukT2S4PLXbjYIJ8bvmQP895bYI3UOXQpk5ovhnBmA9gn+BjwF9tv+nQOtG5qZCIyvT51zYL/gVNoj1H4i+HsJ847Wf3Fj7NQkMzKs7vGpGakud9+Wo9H8Cjdq7gOWIGnQ+MNgz9AJiNFO/mWUa9Jq9DuzwhrhrjiuzDKiyqo4Me8ZiXxIY0vPktU8a3sSHzfTXPp5GjYVU38HrKtWfqhlJSOOD4FLFetG634vtO/s4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(956004)(38100700002)(66556008)(55016003)(66946007)(508600001)(8676002)(38350700002)(33716001)(66476007)(52116002)(6496006)(44832011)(1076003)(33656002)(6916009)(5660300002)(4744005)(2906002)(9686003)(26005)(316002)(86362001)(9576002)(54906003)(186003)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hL7QFc5iUf/OK6N/M+Wbsnlne2Bs22JtKbuOyKdJc/MPOEaG1qdVlz2/fDFp?=
 =?us-ascii?Q?/VZ0KyQlFjBK4sc4Rns2syJo4pG+j4IUqlnNYCPkIq44qwBmJJX1reZ+L81p?=
 =?us-ascii?Q?KqkAhY49EoX/VtlFLE0CgZUuYRunRJNmeLpsQfVMrCsj7tybmJnJZ9YOEg9E?=
 =?us-ascii?Q?iJSRRIoHe6ckUBRfXll7jF0tgzdK1Xq8AEVITSwYuAhcW2OEZwZKaCH9cS+m?=
 =?us-ascii?Q?YiidiOzibQRrs+LSOKcbWJEOIk+PreMYLN8ThpgUUdgx6zD5rwgfAPrwtXJp?=
 =?us-ascii?Q?ar3Goo6/mGVV81tBAp1nLcobmZbLMJrdTedV12BleW3NpvBTAJhKMDvgeWnp?=
 =?us-ascii?Q?P3zalsCwDuQ/JODI4PWbSTfrBXb1PEgyWyFdrDL0K6P4MnAcE9xgJqkXBnSo?=
 =?us-ascii?Q?tX4SIhPXsMojfvPNwoKkBVWpBcH+PlajlXagMVZSNnaq0vhpTBHg3aa/qjk4?=
 =?us-ascii?Q?OnXc+RNMhuYJYpexatsBsK3scDW70lciXgKoi2fD595/+668vYXMAppc4Mjt?=
 =?us-ascii?Q?XzCiJZupYeyhjSAmbyIc+zAjrKugaro6mPHebJl5beQlbIUo9A7DxQV7A3jX?=
 =?us-ascii?Q?SwbwzC8NWg0Fy2MK6jPfD/int1uWkSzNeu2uIKiGAFHqe1P/LbKzkGFDfgKq?=
 =?us-ascii?Q?7kY9wkUNNEcRgspeWQ3ziyhooVq/juTMKQgLuMOzDRUBaG/Vp4O68hUEH7w2?=
 =?us-ascii?Q?eBEQ1nWFL17CdHERh1JAxrwe2LSRINzdoMgXy3nfDRYHqm08qQjpcRdlGFzd?=
 =?us-ascii?Q?qtyjDjVtwv0od1d9OpGclUWB1XnExeQ6FZL4dzWGODbscetMBJ7bUgt5L1Qy?=
 =?us-ascii?Q?O4VScSRwv7lhK/YbvmxMw7Tw06/4WogORiEq78aj9Hvm24w1IUzdyv3J5upF?=
 =?us-ascii?Q?LcReVTU7809MtINzmbPWrajBtzXgmrxN84cCkEocqx1KhWRPCoGjCTkEW6nh?=
 =?us-ascii?Q?8a9VxqIBsA0l/qxFq2tocnB56jYsED0pL4JbuUW0TaKan6YIEJdXWZPjDc+K?=
 =?us-ascii?Q?eBtln4XerTnudxT8RGgCEgK2LfdoYcC3RiREk8bhamDWbiUN+fyNiU4fBe+n?=
 =?us-ascii?Q?sEwj1qSomN5r+bnzZ4NzERr34H64vD/BLy3yo+p7HvC+vqlNWL2qRSKMZUg+?=
 =?us-ascii?Q?Wj+WbquA8eVdNTkBMx9EJ9UhT5guHruSBrLEpwvfoCzCEZupBhwIOOT/BUUM?=
 =?us-ascii?Q?F1uN7ZB5MJE0Ddr9hZadHLJ6JTfvrugepHiNfxew39WRFzJpYELvoQvFFm17?=
 =?us-ascii?Q?bi5xUm2eOd6M10EgJ+UbfWc8SHYUWX4JHIwhttqP5KX1GBlVyPcAv8Lf1Ejl?=
 =?us-ascii?Q?12scvVi2HVlJxapi9iUggpQib9vK+WPaQw1O7e6k0/JJxE+Bh2769/KFMRWh?=
 =?us-ascii?Q?RP1F8HnkwisfNZx9jlvmOBZtl9dbQ66e8WgQnpolHbW9T9svr9gJJgNYCBKz?=
 =?us-ascii?Q?Nqkt7Yq/P9zmpGALqovupiN3utKpEFEh2IhlnE1bCRsRV93ayzEHM49Wux+L?=
 =?us-ascii?Q?7f8pEWVh1OkyaF0jFp4cd13Ln/N7yIpG7xhH5a6s9DDRFLewj69pRq9ibaG7?=
 =?us-ascii?Q?TI7fCJHh633z20dEY2rAFN8jCmFcxktM/g1AlRHtqEI6nZXEl5FBPxGj6Nli?=
 =?us-ascii?Q?cAqa9EkiA99s8NbGP7YafFL5eDUVLr6/iz5BFma3FdOLrrJBEI9RjBijoyau?=
 =?us-ascii?Q?zzwGsA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709fd3c3-ef35-44c2-c00b-08d9b30824e5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 07:16:21.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv4vdI/Po/I9JkyUTZG2BuGyi1bn8E987XuZyY8udXEDj/3gZKARkRDMxrV/W7H2dLHs8LR1uWqUmTvvYP8kBxQVJulQU0MtXz4IjCf2Reo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=781 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290034
X-Proofpoint-ORIG-GUID: opkneeaW5xnm1hD2yTuFDV_PUIiLI6mj
X-Proofpoint-GUID: opkneeaW5xnm1hD2yTuFDV_PUIiLI6mj
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a false positive.  The nla stuff has checking which is pretty
tricky for static analysis to handle.  Here is how that attribute is
defined.

net/wireless/nl80211.c
   544          [NL80211_ATTR_SSID] = { .type = NLA_BINARY,
   545                                  .len = IEEE80211_MAX_SSID_LEN },

When the NL80211_ATTR_SSID attr is parsed it's capped at
0-IEEE80211_MAX_SSID_LEN because of this.

regards,
dan carpenter
