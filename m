Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C134426CBD
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Oct 2021 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhJHO36 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Oct 2021 10:29:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42248 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230434AbhJHO35 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Oct 2021 10:29:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 198DsKB5025432;
        Fri, 8 Oct 2021 14:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=NBOboYsBFEkot6FilFzfDFpz4Bqd2Ie2L7AbgTKULl0=;
 b=qIis3l3DvDu2JFZNBeHlLqAKAUbdtkm3XNn3maIvWcJahQj8CFafwHPEzh5CGhEupo61
 w3ncZEgifLvT3DQkwtc/0D7kvKcSJ4yMN0jN6oEODBmociv60Bi2es8pFLegAdt3rKuA
 hbbymD4o1dTaX64zUAkqgqqohTpRS0WoRcR96BWrQo6TdJVz++0vl/8n7ZzPNB2m2zjt
 am1Yb05oDz4EeVVqzY+Cq0AbgruUZXaIBLYB3AGA5lV4OFRR86vhxeue2UcxH+fH3edh
 zSr0a3I4Kinw3ziSN391yAiF7JROuYymAEZeq4FKX1LSGdkjijM2FwZo9tH1O0XGNdl1 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhy2dgcjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 14:27:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 198EAB8j107041;
        Fri, 8 Oct 2021 14:27:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3030.oracle.com with ESMTP id 3bev7y28a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Oct 2021 14:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa7GlXUjrL/BqXfXmJCGHhn9nJChVKrjnph6O7YnTs1zyBc6oCPNBA98QxD4AXbiWVQr+Kfd0BJjH+3nQ9evYBYMxMPFgoN8Sy/KLLBObmKGTCn/mVmTMT8OFO+L+ekxsSKH0nc9HB4Jiq5z9jp8/lIwkkeMe05pGS52LevxPEeQPQ+muQutXNYxRwJ4MtzsSnITN/HBuGJgGy8+jzi9YQORdbmY/8lHIskgdYRRAI5Z2bnUOJi6GS5jbw7Q/qY+b6rhBlwz40+t+fyQsuMdQkDHP8B+luUF/fQviZXfhGVGez772ErrX21CSERBJBOeeHjBXHSFaWTChQdT2794MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Bo3Q6mZyib8e9jm1d2pVAy/pEupeev1Kk56F+gjIzM=;
 b=ArSlfUuAUYCNewTvlVv20b94NvCYFS4f1CV7kMVpNV5rMbAVm2bq0kdc2Y2u5A9ivOl0CY4paN4MVqVfjhyrYHsOCkfcmn3pQgPIEceB7FMcpknzXeesEG1BiXGx7ZxlavBhcA68/eBljHnJFB+4E9H/k3WUB5MsTNFE0O8Jl2BXxWP06MlAOyQ2MJKkgtOr121ORIHEpIVLQxZfc5tvWURRZLaIOq6DwbZSkGLRq0cw764S1DZWZQ58jyMVE1vN/TWVVz6E2l/or7+Id2Wo3Gko2Cc9N4W65o/+CO9NRmjqTlGTSoO5VwuukGT5VLrnZRek9E6bzRl7QDlXZZHGJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Bo3Q6mZyib8e9jm1d2pVAy/pEupeev1Kk56F+gjIzM=;
 b=mXW3OGUdod7ysXOTDsrz78cqXSVDojFjopN1yK1dKkX2Ye+rKDLjg/3UPPYBXiForwZKeDr3nKaJmwbkM2VdTdwJg8JgK2OpXojsbPx3+6Z8+qRWqhRyZGy7BdzhUA83xl+WuyRHZhkoc5PvLAkH1aMQaOMwoN9QB1t9W95PZqw=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Fri, 8 Oct
 2021 14:27:52 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.025; Fri, 8 Oct 2021
 14:27:51 +0000
Date:   Fri, 8 Oct 2021 17:27:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [bug report] mt76: implement functions to get the response skb
 for MCU calls
Message-ID: <20211008142734.GI2083@kadam>
References: <20211008130007.GA23161@kili>
 <9298fd82e4b49b965e9f26957510b9e968e8b691.camel@sipsolutions.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9298fd82e4b49b965e9f26957510b9e968e8b691.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Fri, 8 Oct 2021 14:27:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b756cfe-dd65-43a5-3605-08d98a67cf18
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4691AB1BC1ED8F2D1671A8898EB29@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzI1dIb4btBr3SJ9J2WTYHrNAYiJ7WyLC1ckFTSrB1emMc9Fa1S8jJDTJWf009b5sLAjXIU6kb3fmH4UzAZbxODh8/rSqZiTOJ0nf5LlQtky1v6HnBPdrWwj5Pi3FkoD/uWuZM3VzAvnUGZbXHBBboA8f44haoI3Hc8RcEQo1EYPkVGiewoh8cBzeUcR5wDZvVE/LXzXa6MU/qyX28JQFZwzeP4DVwC0bPq/krgikjkwm5m2efZtVMULPTwMY7e/RMOX2tGgHTgU2P8NlzyGPqqfjfG2Yq27CWb5NfuTLNtJPKb/d21CwAFHCvPg/pCb0ZH0xhDn2FgSBul0uEfEXU6GYU+KSmr4U+mHqg9KI9Nks7qTy8JrIdVckhr4BWe1ivoiJeBWKSqi45Fetfmd1Yc6M1OFDepp54RpJyJOpEFxh7EaLR2fWFHXFhh6C4CNlE9heZiol+mqayZAxUEqFFH16qYL7FhnHcusEje5nVoa5AztqsuLViznGMAlZfjHCbZnwfdMnadXJhbFN4TrC6Ic9gnd6hkYXDzUZHMh9Mzu3E+AC8k3LBdX49modYAtnqU0Sbp5SgWF8qXT8Y8Oc/xO7bjnPpG+BnNYlcNxokQ1K5sRTVAc0x8ICetanv3w6w/jDgoLMcAK1/RR4lMwSbqyWUucXFcT4GrNBqZdE5bHpLYfS5QcTPdf86lPzXsQRbz8tfYeSEVJSuDybfDMpsXk1q8fZviIcngLbIiRcvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(66946007)(66556008)(4326008)(66476007)(6666004)(6916009)(9576002)(26005)(9686003)(6496006)(44832011)(956004)(52116002)(2906002)(8676002)(38100700002)(55016002)(33656002)(38350700002)(5660300002)(86362001)(8936002)(186003)(316002)(508600001)(83380400001)(1076003)(15583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XIKPtbVfRTcwwzisM/e3R8jsJRnMlPU9h27yV+gqTPFnQQRo68cNCK8vOV?=
 =?iso-8859-1?Q?2L81lz0NvwzzKHypFV9TBNdKM2WEs0LYFknmgfN2l9KoMKUUPnX5nx3na8?=
 =?iso-8859-1?Q?mae5X5tMphrG20q5RUFUc55CggFrkWFvDwy4mhzGaKdAVKww0w3F336QTZ?=
 =?iso-8859-1?Q?DFIB/7YOYA92GMZSB2fQ4aFrOb2jsZ/84WhZ/L3DM5fDrs9AWl3lEl4EZm?=
 =?iso-8859-1?Q?DfHpOMjTUTPI1sA1SZPnjTN7FtMn/IqF7cWDsRx9l+xha6RhHQdUPFVtwj?=
 =?iso-8859-1?Q?wS8uTFe0fIKFT/Lm2Rbx3myhcCFYV3i9FIIqQ2Bomp0Wx0+oiH5+7+/nG2?=
 =?iso-8859-1?Q?U8bEhcePXG+Lt5tf9TA4IofaVSRxPrxwxpiCUdTrum5pwWyc3h2NuUZcPo?=
 =?iso-8859-1?Q?CCrviUuDRWpEkaO7LWz/UNfbd1Yre/zc43iY4Dq1QWIZSv0ZBK18BdNgR4?=
 =?iso-8859-1?Q?EZChYsHK2JQ6FyuyqH5nQ713lrVR0I3K7rfRDZNnebwk50yq8Nz4NBNH6Y?=
 =?iso-8859-1?Q?l5dvMyIasJcO1e56mXTU7bf7CD5PEj6HojKGgqZfjjo2Q2UI4ODqbCDEZE?=
 =?iso-8859-1?Q?oFu786sSkqJ04J+ROAupuR+DpWdEpSRnoXWdCm3V0ebp4F1Nx2K7wgPjcH?=
 =?iso-8859-1?Q?h8ohz4apGsmxgvtm5H+aSiehfXCxcvLNm74rSnjnGa8GTbid0ImVC2imsk?=
 =?iso-8859-1?Q?tgPCb2qemk9KjIZMyDXQobmg0/ECZE+SdACevo7Ic3mXl8rTUurevCPjYi?=
 =?iso-8859-1?Q?zzRfFMXzDyu69d7xK9uEqbAGnIDVqdD1DPzF+xLVuroNbJSB2wVkGNedv+?=
 =?iso-8859-1?Q?eFTEV5+Ge6hD09MSdiPH6DWX7zq8GoBf4F7t+lQtN2Bp60ty6+PrxQa++T?=
 =?iso-8859-1?Q?NgBiTaoLfm5Wta1lt92QZPpV5uwJloyolcMHx5+cv7gqXHWLR+l4ED9+mV?=
 =?iso-8859-1?Q?B2r8DaDTc/lSWTjfHhjGi3RDXlBtCrkg4xNJ8HbMnxpsoV9uAODY3QzM/5?=
 =?iso-8859-1?Q?j+OrvXLS80Ofa409+FZk6MdGPAuL2B2qnOjBuFv6iBPWVc9A/df/AQJRdB?=
 =?iso-8859-1?Q?tX2xENbzTwuOQ0u0uI/yg5H34LWGJyCoo+ZxmC4vQkO4oI2pOUJQ1yWj6Z?=
 =?iso-8859-1?Q?HjlVoTqvZAaaP0o1qMQGKXXtNLHSuZD/6SPDzaqFFjrWdHixtWkXPboaKl?=
 =?iso-8859-1?Q?Uk6G/BwQWbTd9vJH2IkTvfLWEwT2pQePYIf2WsnWdl8E7hcXimago98bQV?=
 =?iso-8859-1?Q?kbdHdJljqATdoM9zOrZCyTEy5hV0dNFEl+ZQOAogvbM2+T2+Mh7OwQm3Su?=
 =?iso-8859-1?Q?lYzlXa2YY5Km65P7yZ9D6M0aUXMtcNEkjxq9z75GOK55C8BTtrMOOvkXKr?=
 =?iso-8859-1?Q?iWz8v7ItLz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b756cfe-dd65-43a5-3605-08d98a67cf18
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 14:27:51.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXDaoA8OOtZwPlxWKmXjpIHospm6CkDpOI+u1yfVtP21DwytJfY6ZeN1U4KiPPd2mVM0Ajqk00BT8/s9wMi6cnW1bUMeBnXCdR72cNGTxXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110080086
X-Proofpoint-ORIG-GUID: eW9hLx205KYvMuwRDaLstjzlpvGLmc6j
X-Proofpoint-GUID: eW9hLx205KYvMuwRDaLstjzlpvGLmc6j
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Oct 08, 2021 at 04:03:10PM +0200, Johannes Berg wrote:
> On Fri, 2021-10-08 at 16:00 +0300, Dan Carpenter wrote:
> > 
> >     1146         ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
> >     1147                                         sizeof(req), true, &skb);
> > 
> > If mt76_mcu_send_and_get_msg() calls the dev->mcu_ops->mcu_send_msg()
> > then "skb" is not initialized.
> > 
> >     1148         if (ret)
> >     1149                 return ret;
> >     1150 
> > --> 1151         res = (struct mt7921_mcu_eeprom_info *)skb->data;
> 
> Looks like possibly 'skb' is always initialized if
> mt76_mcu_send_and_get_msg() returns 0 (success)?
> 

This build is with cross function analysis enabled so Smatch looks for
that.

The problem is that the caller has to know if dev->mcu_ops->mcu_send_msg
is NULL or not because if it's non-NULL "skb" is not set.  Perhaps that
means it should be separated into two functions and we pick which one
to call depending on whether the pointer is set.

drivers/net/wireless/mediatek/mt76/mcu.c
    54  int mt76_mcu_send_and_get_msg(struct mt76_dev *dev, int cmd, const void *data,
    55                                int len, bool wait_resp, struct sk_buff **ret_skb)
                                                                                ^^^^^^^
This is the parameter.

    56  {
    57          struct sk_buff *skb;
    58  
    59          if (dev->mcu_ops->mcu_send_msg)
    60                  return dev->mcu_ops->mcu_send_msg(dev, cmd, data, len, wait_resp);

The function pointer doesn't set *ret_skb at all.

    61  
    62          skb = mt76_mcu_msg_alloc(dev, data, len);
    63          if (!skb)
    64                  return -ENOMEM;
    65  
    66          return mt76_mcu_skb_send_and_get_msg(dev, skb, cmd, wait_resp, ret_skb);

But this does.

    67  }

regards,
dan carpenter
