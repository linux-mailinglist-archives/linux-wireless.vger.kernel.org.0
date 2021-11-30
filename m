Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F10F463155
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 11:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhK3KqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 05:46:08 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11724 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235366AbhK3KqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 05:46:07 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAVsUN021038;
        Tue, 30 Nov 2021 10:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=mYKFxtRbIdxf8JJMeFt6beVacHFg9Qip3zZRB1us9lU=;
 b=T6IO0sNc5F1wxAkBhnVIuuL8ZAk0wzak9c/zuDgwbBQ7USbDGT+W4xPutDRcXq39NY6T
 Na/TfkMcS1zzvHjd07YMVtodr0k+IThmfm3FcG+e3jfimQ3tiJBYnUTNqZlJ8/tJUPxi
 ZNmQXBe/GsjPbatYHqpgSmIXso4y9XsREeLHdOF8ofYJUmGKfiILbIg9mFGi/f0o2lKb
 2HrhETMItoVAFrXYo2IAud5pzCqduDKwekGnWlqOxfQpPO5th7VkWXcQOqrBdmudvkrH
 rPGmdnlVyFse9H3mcQLErKPjka52oUpt+Omd7UAzno5XVaABcOmxODSvPKUNjXyvmOFn Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwra24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:42:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAVdq6094492;
        Tue, 30 Nov 2021 10:42:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by aserp3030.oracle.com with ESMTP id 3ckaqeep3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpQJc9p+avVrJQO184Z+rWr7ZMTIwviAo+ikso3d3WzirUMibkPVaEa3lT3CEvqK25kSX00HPiOrSS1XBgn6zHGlEuJ6IsbpQNuyl5BCzyZHeoie1DpN+aVf3EUqN9yuPwm4wYYADEo7YU6Oo/5q95+DhNKdjH9lX8d4nLgNAf1c3OZ1JynDM5w9P31nuCjOC8dxekddn/AMo9z//UPmOYbgPW6FgEObXUumiUrDtcsh0N3hdl2EaxO7GrKg4c3mDXSMjNfBabnFyJTPfh4Mx4nvveXcAk8EGdoUre4k4liODhpdFNHrtb/ollVLW1upDfg9XqUqQ5iERuS1Aaol/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYKFxtRbIdxf8JJMeFt6beVacHFg9Qip3zZRB1us9lU=;
 b=HV9KZvLAeYtg42NaWLJFmD3uq0Wy7uT0D9AVwXJbVuDt8dR2Wzx+P7wJ3Sdy4NwjWgAiOM1vClityCI2CHQd09fwbFZkK05/qTqoUrDs/TyZkqn0UbOqziFDLLA41HXti6aWeSnjPCwmYNFjZ9qJGpssxozkPGkeKIRsUuVZMFQnGR5AvSrF4DSHu34H1FbghtJhwYtVgzVLgCIwAQJBa938ykldk8d42yQ/6vs25roVk/nzXFN+tn/hY9T9iNYX1Ta8TCYrS2PP6HDtSrMxZ1x9uZEf7fw4ARZDdsFgkmSuS5JFsLk1pTEalCG8vL0BAmZfofte3zS7ph+vv43NRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYKFxtRbIdxf8JJMeFt6beVacHFg9Qip3zZRB1us9lU=;
 b=KkFJ2cJvNfqAQ+JOtFFDvZLtB2cUmTWv+scIfwLW/Y5OW1w6vyX52xb0UCQ/3pZnD5j0AZe6Xoq3eJV9gfnvH/+yePaX5dTADk9AkU2P/pp2GSAjz7ei9cYyb0j9zwzXcOWh8Y52NlOQGNoZoBHp3slZcaTPLcEIZkl49mrGSGQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1357.namprd10.prod.outlook.com
 (2603:10b6:300:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:42:41 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:42:41 +0000
Date:   Tue, 30 Nov 2021 13:42:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw89: add Realtek 802.11ax driver
Message-ID: <20211130104230.GE5827@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 10:42:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f90e53e3-0d38-45de-3ae2-08d9b3ee223c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:
X-Microsoft-Antispam-PRVS: <MWHPR10MB135748BF2B00C67A546BE9038E679@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IjzntLZxDFVaxIvDruiEUJhvJ4qnnsYtL7K7NEAYbx9zbUNn9NETp4Eb0Orce/XY3BxxUbGQxQEM/e1yKIpTAM5oycqzJDrNfz3cCmabjGrbMFKVPCCpPudoqSA5TRrzEFGeDlcQ/BjwS8kKCAX8PL/T7imc8QyKDlrktu5sxMc/Zg2pAvjz/0apoY4lmESa3Su5KsiU9bAmZBXDhI+9wLcwFii3hKHa+W/cebYKGoUf2nQreCekx7VC/KnBDtv+XX3QbXQGq1Rsy1uNNGY4mbIhJ9IAR2y7DFCRcO2XyoYPuom5s2yNTuI30PJl9jEyNK5BAV5xNpGtDKSxqc7Iu0khy6nsZ4o2xZruUx4RGe8ujbPWdxyKhwfr0zVgEpPBsSQs/gVDUVNXjL1DbVKQOYlpYIWKvEMix6l8ct7gS9op2ddPi11cGytaTEkaC/yiWcQPz6M/9528hzJJ6Snv93PeTz3v4szOeBldoz9IHN9w1s+JkE74s8cjMGBN7vVsyxMW5rGR6dFp0mjQKhFYDg//rwzASdBN17GbdQBz5iqm/3KtLamZmDv8XsjN/PYaYDj6JX8hKZBRujuczZEu7O5iRI6aifUIM2jQgV6lqb2etT+NwQxo2YDmb0sXuYLGj66Js0sQoPqoCdKfIkmZjODzdHFEbHMVvjmQf/ebhLXGnyDXHDHHjtiPni97TQAHOKKBz+/WUC8b2OR47+71iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33716001)(9576002)(316002)(66476007)(8936002)(66946007)(44832011)(38100700002)(6666004)(83380400001)(38350700002)(956004)(9686003)(26005)(6496006)(186003)(5660300002)(86362001)(33656002)(508600001)(1076003)(8676002)(52116002)(6916009)(4326008)(66556008)(4744005)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQamFDRbYHSqG7tnQTz7WRBDUcYEI/aL7H1U7/3lZ7/082/lITYZaHT2Oqg2?=
 =?us-ascii?Q?y+C/rWb1tKmQ+X2/nrEEmQiL20Snx3xkozWKts7qBSzR2uCicYjUORcN+5E7?=
 =?us-ascii?Q?4LDnnzWGYzI2jmGNX8eXPM4bPgf9vYU4vukwMffKc4LPv1SzdGS9QUbv1xfQ?=
 =?us-ascii?Q?/s39aPVXkmMr2L9BX718FLu0VNmDW7EzgfIcFhFsqlKFoI6Al7dLDru0ajqt?=
 =?us-ascii?Q?ijJ7WRgTaC0+EzjYoBJYxYcnH2rJ+890+KUVTDPCCSeW7ErR+6/c5VCHVCDz?=
 =?us-ascii?Q?yrfOgBC+ub+J9Z1FPYvga4L8Tun+7H/sLkUNzZszOHsGvk2Fu8ZAGRT/aplb?=
 =?us-ascii?Q?bJPzMNKxksUk8kkrqEt00Pr6mGxMtpnoTSv00k+f7gblLBzccu8mdRz8IlO0?=
 =?us-ascii?Q?AtJ0eAR0fnm0UzyhZAxgOuuyl9svyncZM4Cz/xO/FAFn5RMyyfWesX63P0PL?=
 =?us-ascii?Q?CKUW+XL8dp7SAeZ34Z6ah5d17Rx1AvqVzzX4ZNSokUHNhhO4yzEGypHXQM85?=
 =?us-ascii?Q?Q8LOV2kMvDMol0ty3wiRdPyC2juObzHGSMJolOkiPHlZigRMcq2Oa4kdmrfd?=
 =?us-ascii?Q?WN2H8V/dwBwrnx3ajudDr1kG4Aw1m1BEjmj8+HWPBv/NjT+WTD3p8H87p0QU?=
 =?us-ascii?Q?mjVXqa7yAeQyw+OHp7/IM6l8Bb1Kde120t4r/qQgaF5V1k2pUfJrsHbdOPng?=
 =?us-ascii?Q?JGgWh50tgDH4041AshtA1tfrarFMMeXTYZanAZ6RVQtC9weJmIjH6Oc+l0vM?=
 =?us-ascii?Q?wWliPaq5XEv8sal34p+/MbCpwZeNIGK/fUT/e34KzYejLvmnjhhlshr/3iRR?=
 =?us-ascii?Q?0EyCMtYylKWFt5Gj4Y7rzA3D5N/p5CRXzHghjzXK8AlF0Sibm9z8+2jZg6bT?=
 =?us-ascii?Q?gXgIOs6Yv4cedeO7FT0QLAU3J38ex84a/qGO74qqZNOZSef8Ibwp+IWm0o2q?=
 =?us-ascii?Q?wZ9x4MpxEee1l8+3aDjCc96j2ImM854Rhplb9D3V/p8mpD0CJQwdJENZJuad?=
 =?us-ascii?Q?kbR8L/HnGNMR1uiLBushdkbUNu53TrlN2BtDYt2Ui6hAZQP4YutkHhmzk3s9?=
 =?us-ascii?Q?lpwQTIcZmxFmvIXuSsgzq+Cn1Qk7WvCEVivV6kNEWRTj82cV22OP66um3vWc?=
 =?us-ascii?Q?YISzbigznY5S+86gR6g6Ld9eiIRW0MXVihegnvojWyqA09y9mfqrI0RCVEIE?=
 =?us-ascii?Q?Xu6kYeiAWrr8aCHv02Jl1Q3qbgN/6VktuQd9JiodsTvGVspr7XznLxR2eELZ?=
 =?us-ascii?Q?8qG5OFVU7GLceibYsxxi9h4kHIrEAicVOKjoJW1sh5z7d6PMLQ3hcbFnntIB?=
 =?us-ascii?Q?1XgGBAuJCqrTKh3StNFjckJ1b8a3oj4xGOKxSsgofWL2g94mlOBxf57eAXxY?=
 =?us-ascii?Q?lZldqOh75IpyI4CFcwbrdyksswVcCnDJGukaN50kgDJ79Wn5tqyE3gqn0xOl?=
 =?us-ascii?Q?H3nttl3PErbaAlwtrjmTpf09HAucKVeJlXAw/el1c+IOn86wHBAU6mKiHE24?=
 =?us-ascii?Q?MygY0WyX/Pg2vsfhyW0c+cb/xjGxkQMJ766TcNB9e1+CaJ/waOk7yz8K7gBI?=
 =?us-ascii?Q?EKVjlXhu8JjvsWTM9rJUCigs7o3Byi57Obmrcwv6X4omSmW55T9KzNCzO3iD?=
 =?us-ascii?Q?nNMcQU7N8xZergljiMV/OgqSNxXfex5PEekmyC5RgcoMf2wwe8l4u+GkOxw8?=
 =?us-ascii?Q?jeRtcDOjoFM9DrgetOeLrnSBGkU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90e53e3-0d38-45de-3ae2-08d9b3ee223c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:42:41.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvGa0xni/8rzjbF72Gh0CVJUtu8hDwQ3hqT+7TO2516fP7UcKTLYVK3LmaPOXQvXbaoRsP2+cf6w7I+fc4bxcgESB1Drqv0m7FI7VOUndMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=704 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300060
X-Proofpoint-ORIG-GUID: _r0HesGLu9AHSEMfwCd3R0wMSgwTqM64
X-Proofpoint-GUID: _r0HesGLu9AHSEMfwCd3R0wMSgwTqM64
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ping-Ke Shih,

The patch e3ec7017f6a2: "rtw89: add Realtek 802.11ax driver" from Oct
11, 2021, leads to the following Smatch static checker warning:

	drivers/net/wireless/realtek/rtw89/mac80211.c:31 rtw89_ops_tx()
	error: uninitialized symbol 'qsel'.

drivers/net/wireless/realtek/rtw89/mac80211.c
    16 static void rtw89_ops_tx(struct ieee80211_hw *hw,
    17                          struct ieee80211_tx_control *control,
    18                          struct sk_buff *skb)
    19 {
    20         struct rtw89_dev *rtwdev = hw->priv;
    21         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
    22         struct ieee80211_vif *vif = info->control.vif;
    23         struct ieee80211_sta *sta = control->sta;
    24         int ret, qsel;
    25 
    26         ret = rtw89_core_tx_write(rtwdev, vif, sta, skb, &qsel);
    27         if (ret) {
    28                 rtw89_err(rtwdev, "failed to transmit skb: %d\n", ret);
    29                 ieee80211_free_txskb(hw, skb);

Missing return; here?

    30         }
--> 31         rtw89_core_tx_kick_off(rtwdev, qsel);
    32 }

regards,
dan carpenter
