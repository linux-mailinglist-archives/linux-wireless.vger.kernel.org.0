Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91C5493CA8
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 16:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355517AbiASPIt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 10:08:49 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37974 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355520AbiASPI2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 10:08:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JE438o010655;
        Wed, 19 Jan 2022 15:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4PH7ktht7rbthijTsnRKnWod26/IC4pPzmK4ic9+O6s=;
 b=Z4PfOvk3Y7jb+uVE5r+YXLcK1tNuk9VTUIC9HWA+7XRcNCleFIn5qVnr3dfoSGRTZSOU
 hWP35T21NFLRRLsZ7JtJ24dLPFEbnLekIglmwis52xg1LfGyOFuhNGTv4bzTKW7lFjLk
 RTGU2bteA6JiE1GBKvENHnBlBa1T26tdOcoMc5mBwBhhgf/G5f6RNQq+Ke5fj7XlFmEq
 s7/pz03r1sYPUpB0+oCwaOVL3T8iAHMakUbX6Ayv/GM8CXc8cGjbuxQo5o53Ad/f5OBO
 n/td44hxnvN8Y7RmjwQ2q1GSFHSnejIFlM3H/zcbv/I5kshxqrqGJfoq1hLD0t2kJIav sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52wbrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 15:08:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JF4tcD173609;
        Wed, 19 Jan 2022 15:07:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 3dkmads5d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 15:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtGakbL+nNt8+r61NWlNBQ/Rb9otOXg0nS2Q+fUeXTomxBGO75D1sQCca06xjIt4JejzhgHwZutR0ozMvN8PgAzECv6bJalckBclx+XW9aPItkjKQYIUB69ZApHcclRRzzBylLm024Q7f6TYwL6c5RthVRsgLkJypatxzEhAP1jYpaLbtW3ndkbTzGbHIaoXe8kUwMdIx5aKK0Ppe8XFycN5A+hR6EDD8qpGw1J1trL/+92bq56HIhxRou6+Mup8FDJvUtu6oyFNRTk8+scfFLIefkjKXAz9DUqsQbyZ75JyYjkDKuIWK8SP1ACPnnTQ394MbLCumI9GJMXWbR+hLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PH7ktht7rbthijTsnRKnWod26/IC4pPzmK4ic9+O6s=;
 b=ZsS2Xa4FZqKbo95349Hoz8IelKvaedISDZWX/5+HQciuLUpC7LpEDww419Mkb/TvrGYzIMjc+wUesqg0ZKdz8iZe8cl5y/WwkYHx7Gy2rThcz9hVBbdak5XowWPYgeaypRHG5sJaHZy3hDjDTGMv4KLZHBXZcQJLAKw8XfwhC2iBazWpUfVx5caFdjLzoFlmU7L/v/xZXS8d/+OKoExZbZSb89oEUs0nUdMToMmXEn735vnkJxUTImsNHMnwu03/dct+sKwJgT/qKsBeNTNACRnzkTU24M1bWBC6dul+zbZN9nuBm6S1tBjmnWmd+qZmXb8MJSv02VOk2RXkIUgPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PH7ktht7rbthijTsnRKnWod26/IC4pPzmK4ic9+O6s=;
 b=cc92Qu6e9jNgdsx8iD7xRf2WVvufdsXJa1RGVvjRweXxI8a9i0tuRVPLqwr8hQ0172cKZxrNBbhBjs7SWmhN0ENLfm79ZeMwjn09My/IxdnY3Ck3ylVcPwOwEIRAYpaAq0a5jvzMi3oVemAKwPkq7FL1uco/7HBhsTC7ubfk5j0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4706.namprd10.prod.outlook.com
 (2603:10b6:303:9d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 19 Jan
 2022 15:07:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 15:07:58 +0000
Date:   Wed, 19 Jan 2022 18:07:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mac80211: prevent out of bounds access in
 ieee80211_rx_h_action()
Message-ID: <20220119150733.GB1978@kadam>
References: <20220119125923.GB9509@kili>
 <ea8638fcd820e5b777bc6d5befc5eab9369edbbf.camel@sipsolutions.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea8638fcd820e5b777bc6d5befc5eab9369edbbf.camel@sipsolutions.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f67788e-8317-436e-3de6-08d9db5d79e0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4706:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4706579ED0E7EAD8E3C1A9F18E599@CO1PR10MB4706.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e51cgvy1oOLXCBOCM5DIgrwZPIbXuAx2o09QhCWa0pdGcc2Chh2ycBKFNTdqawhXILY5Qux87q/BqOXUh9pIfFCvU9Yg54hTs45WOUTqvxf0X6WJvyfBWPaoTalCN17GDQU3SML9u+i/qcZWNgy3i59er5EI4qDLbJbdGDZaLiqHYag8juyoYnBPZU3REwFGRWeI+907EAAhte9cnH2cn1FW/OSyTD1y9zuy8d/kjfygOItv6x9haQ6iwoqFkiVGPod/xe7qUsP6lXkduBJW8+M3F3MJVKfI7p3cw8i1ebKLYzCDiJ5RadLFs8/4JH5WZqzbw6wEV2yCoikCHZBpYNRxvOXCM72KITnYDbLM12tYofE/fkUC3RRlQI2In2RgraOLSA+gSmFCd4m8awAaKxqyKbWiC1omvD2T/Y0doCxy6QJp+Bg18wiUl07U3XoZn3fJBs7cE4xrr6zzHIUqhaY6N/HvLFldfv3bIWb+vCREJGb7Q25ML2wgRUg+LKQFwzvy/J7LwhHw8HMLMbJ+8xgwyTKa/hThaojoB2htf6bDLUi2SOIslpzaBbmg8+gST40vdEU9QbkmbH9E3DuKdlJrpCIzdWkK81a4TNc26rhnaJ5eYZmBGa7lp3umimlzDY7Zsqyml2Si520VLiIGawPIMFET22R0W6eV9UTPio2dpJj5D78H43vZh6APqN6x+61BGOWCHsuc/4LqdqGOZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(6512007)(6666004)(6506007)(9686003)(44832011)(186003)(508600001)(6486002)(86362001)(33716001)(4744005)(8936002)(26005)(2906002)(1076003)(66946007)(6916009)(52116002)(8676002)(4326008)(38350700002)(38100700002)(33656002)(316002)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sca9hVvIUjI+cir7btvMS0az1HcUqvNBTxS85olxYDGUF7zeZy/r1MQ4j+tb?=
 =?us-ascii?Q?TFjkQUYihp+hANJ+62tbOyIAXod2yHpY5qG8pv3BVpgsT+o0Bqhadp1zwiNM?=
 =?us-ascii?Q?RUBFeOdVdDPkw5KpnFHiG17HodiLDbOcUN8/5Uxl0pORfuSK56opF5i/EPjf?=
 =?us-ascii?Q?XKH6aonTTVsPER1ZDpcQ5vs11Gmw2B9BcjfcbsKOTc/nR7aNCz0k/a/Gc3px?=
 =?us-ascii?Q?Tcq36GVEPZ+IqYjr+E1j/vM/NVasHStgG1z0pvQhn15l0fQa5JwdXU5nSKOe?=
 =?us-ascii?Q?WALD3ETuG1NMrn93OH/wShq88ATW5fVdhgeC7B6PoAc+R20P3Qt4CQOk7mn9?=
 =?us-ascii?Q?HQv9vgkV0t+QgtmIfhbKemOcUrFhQ0a+Pbwazpb/ac8uoeJxMlo8FfzYwz2P?=
 =?us-ascii?Q?NCv0aaY3WRkk2ZLMxpSwO6IdGawI1l9/0trkG49/spSu2zM/LtKtg2k7PVMk?=
 =?us-ascii?Q?V4+9cgP7VcWOZ+6T33Hk3bmqpMqYq6E7pQrHgMg1j6PRoGBsHRLVECBhGFud?=
 =?us-ascii?Q?DN13QfydP3hp1zgIU/sN6JFupnUfmKgug7VhZF7ajeaZ1p9nEq55f7soIopA?=
 =?us-ascii?Q?kL580Pg3K36ax488Ja6KXAs546aM2r8i66EQHoKhFPCjltZPVRyZAb7AwXvc?=
 =?us-ascii?Q?U9j5dcPN9yzmn324nNhzN9ahyJJWbgZLSC3Rba88+AbltDuMLvBW1SAEVF+V?=
 =?us-ascii?Q?TTL2/RdZMHPLCjEOCPsPhwl4cgLGYVpRhvgP3EBw+6UTvaqf/7PrafnsQkMu?=
 =?us-ascii?Q?D3as32senbcdeje51E76fA7jnFNZQu/tgZVt1YO2pDmLRjQgu/AZMMGfA70s?=
 =?us-ascii?Q?JnTqqAUuT1REv5BBZ8bEYuhcMZvBfm/H+ocRH4AMsXmrZmuwWm6L7IFVWEPq?=
 =?us-ascii?Q?qKe6/jpJjMhO2vng5T05PNFEVGAciQ8bxSYjQNRbtz/8rliajqi2UGLOgSBG?=
 =?us-ascii?Q?ylbSC0cHoiFERFsgFQ493cq7i5RVIRm79kaudQ1E95tRKXrWWLgpyjl4A5l3?=
 =?us-ascii?Q?h7keZdX6jm6e/imH/pH3++S08eAy2aYrsqj9os1FukSoY39H1/GNkgeH1QRw?=
 =?us-ascii?Q?QC1Go/Flb9r7wIpubxy5thj26QtuIRhdDmV6d6ILCPDjgxcZZqcTmwRiVPUi?=
 =?us-ascii?Q?DuripQw/xRnRS4Rg0mM+P5F+K5YoWIn33KSpLx0oJO1dswftY7mhF9wbuXj/?=
 =?us-ascii?Q?J3AD4YQpDsBK3en8eCjP9dxPk92xwbihn43yRzYr87hCR6hXhqmP939ZIjon?=
 =?us-ascii?Q?pvRdsASIQYXGcwsqs/hf0VoJLQ7hgvZzPUz4enF0DA3qFehiy4CxrPlDeA0V?=
 =?us-ascii?Q?9V69PWhro7uF6EiaBEUfQcZVC8P2Gzprjv3/pcqYkl/GOSCe0o8LB+JVBBIc?=
 =?us-ascii?Q?GmOsRpjnZMdlNvW/ITqSTBl3FarbDcu1M5bvKqMzCV+Z3fGTaIndPKxowouz?=
 =?us-ascii?Q?6XmJZuM0AMlUemq0eMrs1DShi3pDRarQeHIYflmw9IjGcJzPhzp03Gagb8y0?=
 =?us-ascii?Q?JdtBetclZ+4x6hdmqr3mIQQgvZS0+UbWGrOE/FFoZPrirVRdw8S5TpmwLLdj?=
 =?us-ascii?Q?tQgnPzYJ1kAJ5If/4C8q5anLvkCnt00vk2feWkym/QlEaoT6WhSVjyxAkB6/?=
 =?us-ascii?Q?tFbi8fQ0+G4rIaiqhFvh6+IjLWJwfCK6bD0BSMqtoyMnuHX15/zO4fuf5Omi?=
 =?us-ascii?Q?GTaEZkaOZgmH0Nfo66R+uhqAa0I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67788e-8317-436e-3de6-08d9db5d79e0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 15:07:58.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy/SoGv3a92X8rSy8aI4bsyKCehQG9lmKzITugUgH8lwbbYGd9V3CBrUFwxeifhhfEngJyERkHmWm5oLESgH4gBb8exhuoNIoMtd0V8I+WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=892 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190087
X-Proofpoint-GUID: j3L6Cqb3wr9Zz33Oj-4FkKnLcAqbW4CI
X-Proofpoint-ORIG-GUID: j3L6Cqb3wr9Zz33Oj-4FkKnLcAqbW4CI
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jan 19, 2022 at 02:56:52PM +0100, Johannes Berg wrote:
> On Wed, 2022-01-19 at 15:59 +0300, Dan Carpenter wrote:
> > Smatch complains that status->band comes from the skb->data
> > 
> 
> Hmm. How does it come to that conclusion? It's not really true? It comes
> from skb->cb, and the driver should fill it.

Ugh...  Sorry.  I misread the code.  I spent some time trying to figure
this out as well, but I still didn't figure it out.

So, yeah.  It's skb->cb and Smatch for some reason thinks skb->cb holds
user data...  I will look into this.

> Also, we have:
> 
> void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
>                        struct sk_buff *skb, struct list_head *list)
> {
> ...
>         if (WARN_ON(status->band >= NUM_NL80211_BANDS))
>                 goto drop;
> 
> 
> so I really don't think this patch is needed?

The problem with that is that ->cb is an array of char so Smatch doesn't
track status->band across function boundaries.

regards,
dan carpenter

