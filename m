Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5301D462F41
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 10:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbhK3JLR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 04:11:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36916 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239942AbhK3JLR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 04:11:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU7c3to028128;
        Tue, 30 Nov 2021 09:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=jSdXWsaZrvVTj760LK6ZbKiY7RNvg7jGVKNwdW5uWd0=;
 b=tgjtG5CZFou3XOI4tmjpbZq5Ix5h0Qw1HMm6PtgLwBf7yXwIgG/2xppvNba45EDd/a8A
 +ccImj9Z2/6ifPHH4s6dGCOtXW60DSDsUulIL9GSyZ5MefiqUzjB/zQpHl99L1vnW4wu
 gdjNMYlTaQ8DMZjfrYBbyoiOdYoeC2dS/F6EGSiEQV/jLPjZBRF9KE9321BHPlHnb8x/
 /IpbgVM4Zh//mIRC3EWqUMXxhOPC2FYcbOyjIZEYJgfIM97XUdC9dTbbcI5CjhwcFyGA
 vwy9pIO57yt6CmNZGp9G/IEnlGG6dWys+KKQ8695bEkEhTEB6XihEivq0OqNE0L8EpyP bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wfb56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 09:07:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU95bVW096069;
        Tue, 30 Nov 2021 09:07:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by aserp3030.oracle.com with ESMTP id 3ckaqeaujt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 09:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Am9Qo2n9nUYdmprqPXSfHSWh3JGIJfjci7mJUHCoQhFfXshh3TtB3KSL2eZiznnwL5VVzgEJAiCzcU0s19aE4T67oKIyoMWry9Lfj+PmIZ4aKiCsxMfg6igtDfhlswUXaWHmBBhb5MesB6BRGdZKbDEPyUs+FDjhHoy/Wl/eVlqAVHAptE5OUYH+fz1cKKfaKejoI7AXHpe4oeQR1/df0FjN3uZq29D0EjYoijNBNhWYDK41y303JzZQYcwl1jH7g8+BhgJQX1xXAm5RKVfObjH4tCRJnwMYhDewISBi+tgTWVHpDdCjxNQVCLV6Us+O5oyv6vKwr6VdQnBahoJ+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSdXWsaZrvVTj760LK6ZbKiY7RNvg7jGVKNwdW5uWd0=;
 b=OinzCZ42/REdu29Nq4YDJgKqIJ6icByq3DyXbz7WImMlP1EnolV2xgV0HCrmRX8N0UV+LgNGKZNc6CL7D2QzKQA+rkTLVZrdBktvqFNONEM7KiNzSdPGytnhUwwWHjO7vkuOgXOwAfIIyA1ECDsvhJAXsOlPR3XrrmqSoTzz+zqBRiq8X5RtsaZz/j5AVqhwJjJX1YXKTAEsBn4NA+PFeP3Jy/QcXpV3axxSZJYSo02+MXeS36cj2du2aQ51DaWBUsyV9qy0KzJG0bJWpLKsty462kClHtx3tKDcBo4gITN12XGmw45sQvLJYQYZ3evysfm5X9K7UW/HgWhhDfYjPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSdXWsaZrvVTj760LK6ZbKiY7RNvg7jGVKNwdW5uWd0=;
 b=COfvqVoKev4xBzNWTz7wCBs070D+MpPjeJasEkQKH6mGb3EV8Z9kFy/jV96KI0Izzs9o+nBvEghhlp3KNDhrblfE716Bi3NNY5SKpc9YlmF1BRozkBhpEkJqCeB2d6vqFlTmr3ss27LdK5KnZvZ2XWEp/uSbSpeFb4XRbRVYRAA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2400.namprd10.prod.outlook.com
 (2603:10b6:301:33::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:07:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:07:52 +0000
Date:   Tue, 30 Nov 2021 12:07:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [bug report] iwlwifi: integrate with iwlmei
Message-ID: <20211130090734.GV18178@kadam>
References: <20211130062017.GA20271@kili>
 <SA1PR11MB58251D5736428C2C0FE235E4F2679@SA1PR11MB5825.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR11MB58251D5736428C2C0FE235E4F2679@SA1PR11MB5825.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0039.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 09:07:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b2327b7-39d4-47ed-dfbc-08d9b3e0e3d2
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2400:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2400015228334AEC840EAFCA8E679@MWHPR1001MB2400.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5334K/U+BjrSSlKBpKBjaVX30XP3JNbPLKM7QMJ6HyGXhAar7/v2JDq8lZvBfUlnlF5gHNlJOl6E1dHV8qCiosXYGguVFa44p/uCLST/3ol6/ZVw09PG0g9NzoCmknB9XG5052AaX9px18jQmRjzlPyK/dc/hFiVQpOk/uTNQfshA+fMOs7BaEgysa9L6GmcsIJXhRqypY6hQ4TwE4djRiLkr72tx1H6M/e8vPO85yEhwape7mXTFXUDr5bPh1egiHNQMOhv30KLFhtbCh/xZhZcPWd6UuqJWKQMoaWr1mZ/g2ntvxpq0BvfqJhODXAQcSfkRUbXVOO18rGSlzf5FY5xy2zKbVe9FcYgUwKvVS6y0VTsoff7FTytHtN6n5rYNYDwsYoYavK92Yn6NUvIRiH+Cls9kEjxqIhY5IYZaa0ZnymZL5es2r1U+8EJE4gIRAXUk3J4rpy9tkXgmP02Kvdz0yN6Cbxu0aH2hb31xM740XRvrCkagcgQz6uVLH0lnQywnvC1cb/OJfOSUK+ybeYXWYKVsp1MRIh2QJ5ayQbWj6qGwFxfHh80cL2IzGsCrlG8i0cCg//iw/XrVdKXZL4JoU+V4k90knF8mGrpri0oah0QvnfAHLqlqK83VCe8L4O/yJCVC61/O+9CBzcVeqyhFZ3tkVf4z3ep/neLQH5GEMWYGfqpSWK5s11ulxvlc2Ma+ZLCI1uygtO8Z/BXcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(4326008)(44832011)(66476007)(508600001)(26005)(66946007)(38350700002)(52116002)(1076003)(6666004)(55016003)(86362001)(9576002)(186003)(6916009)(66556008)(8676002)(33716001)(8936002)(2906002)(5660300002)(316002)(33656002)(6496006)(9686003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uAVOhnwyfIYpmE8JAa+GJLxfqzZixbDpo6nFnyejHexFDVqqVUPOIvhSl8hT?=
 =?us-ascii?Q?S54iu3cKwPSiCwrmBrvMW6MKECZjRadIO/N2J8qE9ONPVPDLXTQ4hggywMFL?=
 =?us-ascii?Q?MNgeZ0AKQ+VTQL3FLhm+uYU4+ETLRRxS8DpHahhZZRTANPddD6ujnCMxNwE4?=
 =?us-ascii?Q?C+Bogh9eQ5j85gp00f5ubepiVfJEdW+WyVAgZNtw5KgEMV8ZrHglr0LwoPRU?=
 =?us-ascii?Q?W9n16XSliZ9oOTZ5HsuGFr6qQvXmqLMof+mQxQVQhaxQaz2/7bmJbN8z+zrZ?=
 =?us-ascii?Q?jXq1VGFDKyqpemB8DwAhlM/wNMXA044/jNX+BLgT/ZXqJv689Q3RSITmq88p?=
 =?us-ascii?Q?86e5rLLlBBawwz1G1P9oSIEKZFeInPwtW6Uhi4wwweJzX86Lc5N6S79iwgYb?=
 =?us-ascii?Q?jEixgGohrPxQl/ydl5CtmwZNUh+Id96RXYpmydGhKJmKzVEhq9Iox+VNNDID?=
 =?us-ascii?Q?G3bZvh2rXgOUklnc4rcU9XCh0ig2ZYKIypWCVvq+94RW3Azpxq3NjReDGJX5?=
 =?us-ascii?Q?yjnIvYCd6WCjVuYYAczHpUNEHFDsCe6aFhYh4f7SE29RtHPK+q4neWSQvO4u?=
 =?us-ascii?Q?pDx26w6vSO9kXiDCZmexu8cZOaDtw0Lo3bgYQOlPNJyzVT/Ig4aKRamejPhk?=
 =?us-ascii?Q?FNVPFGAzBp1sMHAF+OM7zSE3OXGmtAy9owGCoN98N9jbd+lhzK90k/ZEEMuq?=
 =?us-ascii?Q?+Hrn4n3TJefp+F0xnUAWeLwP97DM8/TqWN42Z+h2RM3lalqdnWlGAM0SxRmg?=
 =?us-ascii?Q?Q31MZllsuqCt3YKE3Jhud+hKJMKomKykvD4aVL34o43y6HxpeBXXvDfra1Oi?=
 =?us-ascii?Q?hggZUHZS/wkffNXRKs4ct8Ac3EKTKEDozNw3y5pJvU73rleS93C/1tGuEaQg?=
 =?us-ascii?Q?uJskXEF17+qm4gERmH7SNQRwavqn9U0LQnMAQ/cwtVm2IXMufWROjnOQQgvo?=
 =?us-ascii?Q?F0D6oE4eWlAxQRDgTBFggl9eTKxWkjAp1jF57Fv3ApWgXTGxxGC1m+yJh6j5?=
 =?us-ascii?Q?r88DKnF7yfEQHOFQfUbRrA6cAIBtDia8mbnPec116w9OibqZ6De0J9S3w1Se?=
 =?us-ascii?Q?NoXpMBGLRQZvOnTM/HiwJysJrvS7l+bFJ4qWZuSYYmydWwb1ujiOmqGbjXl0?=
 =?us-ascii?Q?41xBYCAv5JVA+en30qwhV36OBjeYPvCTLZXtlJ+EqWdcOO/ty+bu13oLM6s0?=
 =?us-ascii?Q?MgC3wyX0RP2pg481J6mcRJzSd169s18AfsvYKVoX5i3GxRhgT7bt1KmRZ4Cn?=
 =?us-ascii?Q?x99pvMkrAIywSKYASvFr+Elo8fa6Ct7sfzCV+wIsB/hLc+M0dMUVZcZ8oEgG?=
 =?us-ascii?Q?zq05dcgIRogOC+wjcx2AslSLKolASXz5MucXNcnWD6bMoY2ORmbTl6wlnFNk?=
 =?us-ascii?Q?vmHmkgIDF++ntYF0qffnlQxa8e0TZMu/RY6Bf/cxsjYnbWPHjmDIOWVaygwH?=
 =?us-ascii?Q?6r3YHjEILZfn+2olTpHnljTISh6UDMwsW+GYTfpjSvLLMuS8f+9eTsuulTgr?=
 =?us-ascii?Q?ZP7BoZOtD23aWgJHcqfKKFIrUbW/XRnMJd3r0BvvrFxIp79GzJYK4w+fnTto?=
 =?us-ascii?Q?Q9iaDHuoxN9Pg2Cq+0oFIqSJT+v+/SFQxiywPwcaCTK8B5Z2E68keB2Abszb?=
 =?us-ascii?Q?cCBaotSnhoNNuqdl/ReTG8Qa1z2E6f+0wiv0fYMmHEeG1Wfu9zcGYXZ3aMtL?=
 =?us-ascii?Q?xQ4echZpmuJtcvm8pbzGCs2o94k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2327b7-39d4-47ed-dfbc-08d9b3e0e3d2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:07:52.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0DE+z0hqVVQoERHrnj01TjG4cSX1HiGxFxWICDfz5JVCUxcVC0ZuhkK9zds0ZWuZbohzmo7v/Ed/AOS+tXvzKjSzrofYqURTR/pi2RzniE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2400
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300052
X-Proofpoint-GUID: 7nvO4yheaWCD60kAF72Zn-GWaPxn-_mF
X-Proofpoint-ORIG-GUID: 7nvO4yheaWCD60kAF72Zn-GWaPxn-_mF
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 30, 2021 at 08:09:48AM +0000, Grumbach, Emmanuel wrote:
> Hi Dan,
> 
> > Hello Emmanuel Grumbach,
> > 
> > The patch 6d19a5eba5cd: "iwlwifi: integrate with iwlmei" from Nov 12, 2021,
> > leads to the following Smatch static checker warning:
> > 
> > 	drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:2640
> > iwl_mvm_start_ap_ibss()
> > 	error: NULL dereference inside function
> > '__iwl_mvm_mac_set_key()'
> 
> Where in __iwl_mvm_mac_set_key() ?
> This function should be able to cope with with a NULL sta I think.
> I don't really see how this could be related to my patch since iwlmei is not related to AP mode at all.
> 
> I also moved to that commit, but the line numbers don't match, so I am a bit confused.
> 

I'm on yesterday's linux-next.  The patch moves the mvmsta assignment to
the start of the function.

	mvmsta = iwl_mvm_sta_from_mac80211(sta);
                                           ^^^^

It introduces a couple other Smatch warnings as well.

drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:3643 __iwl_mvm_mac_set_key() warn: variable dereferenced before check 'sta' (see line 3594)
drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:3773 __iwl_mvm_mac_set_key() warn: variable dereferenced before check 'sta' (see line 3594)

regards,
dan carpenter

