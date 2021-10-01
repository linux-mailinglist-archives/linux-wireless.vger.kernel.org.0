Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D341EDFA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353644AbhJAM7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 08:59:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28454 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353690AbhJAM6P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 08:58:15 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191BZAPo019566;
        Fri, 1 Oct 2021 12:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4BJ7frgcYRZfG03Rs157rG3U8/WsXpwt53CXeXVttCQ=;
 b=wzlPuF1U/LydRZUZ9DBko8LuWGtByGQGJA8lluXGzj5BGPCNJKosvKbBsZp4N59zhZK5
 aPt2xCcbmBALBSBm4cMK/E05w1/QIO86i3oMCrko7lbedBbeicuXl4HcETFKbFjA96Uc
 26pkaAuqfrTRJ2MAauAdtfgfZ7HBlSNTcNKITflgj87mxpYJjHOZhxhxSQXVT1Jj+9JP
 Qbk55boWk8FtcyeXB3d+GIAocyS/SKSANT0JD9BKwXV/t2UMQ+v1BbhadsudmmCtyCK6
 tRe7o4dHIIYYy40idS3h93ORkLu/+HeYfNfthUJGcOumy1BfHDhh2TXqrRj+n04kBjRs hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bde3cffwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:56:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191CtH4Q000758;
        Fri, 1 Oct 2021 12:56:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3030.oracle.com with ESMTP id 3bd5wcmpru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXhWP3zJwh+Htty+/4rbYOqSMx7i7ris2qxjTNc36NfRZ9tSo6XctGwt0lukLOW5hGjswpzriSPq5dXWpLI2XAx8VsLbSehNNaGhLP8B3vDpXHK2T0p8+S/RILzI2ISeDZzttecvkshE4PARJmCYjNcHjVCx8FCest8WXlRndQRR5sP1E4Jyj4B+swBIe+J3lht1+5FidhZwlSBD4SfNcp/qY2lSM2BzMnBCcjE8/NH8S+6GsC07frm+YEyz/FtT0CGf1IqJY9BkoG50FxEFbw3E0mZ7AQ/1gz4iurBT/jDNU/ssIUUhdwC8zlg9k5tdoVK0gkizYty47JS0k2FEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BJ7frgcYRZfG03Rs157rG3U8/WsXpwt53CXeXVttCQ=;
 b=ASVYp1SacLZ7lK4H/ouDLRXt2RWg1MdLA0IDkhVjZ9nD+uogOu/WwTcc7YSeQGupAcYYr2MDPMdcgWaDOpiudGfvzTDJ/JCOxLGe6w5O6VRnRLmFwxGzYD9Mtf2N01ev+59V9ULnRaEnQfnKDGPAW4iQuWI6A1CFIK3lBHBlw2VdHt0kWS9qH6I5FArmWLlpywoMIW5I8CRp3vTlLkIQ1/EShEma9tpb21Nmrz3J03M7j61nMijSZrvN+hrw83tfRGydqpxRvgFoPqXf6V7prX+xpcOq5O5Zv/h4RpWHKMVpfWGv1RRwvDbblzF3tyhuG+6M8cIuaayZbw6sapHA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BJ7frgcYRZfG03Rs157rG3U8/WsXpwt53CXeXVttCQ=;
 b=MVHi00/ud4BUrvyIWjH59MSWZrFXfk8aK03AESHAjD0+gyvkpwqYYnxyMY6iiTBsGUWSocRPAmuHuophKcOSr8pM6WaIZq6gTjwTDOTpQQbzTmdHho4d2t9hJXDafqAOG1VGpkFCiGVZo81CzZToeC2c0UZzGq069RQ+QIX/Uio=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4433.namprd10.prod.outlook.com
 (2603:10b6:303:6e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Fri, 1 Oct
 2021 12:56:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 12:56:26 +0000
Date:   Fri, 1 Oct 2021 15:56:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nl80211: fix error pointer dereference in error handling
Message-ID: <20211001125616.GI2283@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM6P193CA0097.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::38) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by AM6P193CA0097.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 12:56:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6db0fc8b-a9a2-4a78-5957-08d984dae0da
X-MS-TrafficTypeDiagnostic: CO1PR10MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44331AEE7E34FF6612E272B78EAB9@CO1PR10MB4433.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QoxvUX8GGDFE/mV2nHOUQQ6n5sp4+dB64JXFosIzfTqsaU7ebMBNN67T0YYi/iI4qPR7JofuRo4SqpZsJcV0vYbwMXjghq8xb9cHcd7dDnMe/gEPCMk3LMPF2XBwjf48WVJgP8vWc1H4HwxT/UZvaqqfLPec/UJLHkED9tg1FV3tikg7lucgFlX5DM9cS8q4XLfZZDeBive980txllEZfAJv6wElL+HzHk9FlUbSn2CJj97bdbAomro7Z2hdb3xiydRbRDnJVWg5LRJXy5ubYAfIT6j0DmyTbD718UaUeRURM3DjyYu7JENAgdd6NUrzNXBQyxFt9HUfkemgPh9tyBNFmza0j+fun1dHThhcxThgBm69/AuHi856gS8B63SO+Q0ri9UZdu50upeylTJ/nqJjJY07IF7QJgjv2bNVxRNym1PyYV4nroayJq7xZSKErhHQGUr9KCtRVWkFrxh4pwsIopSiYZMaNw04xFEQ02mD1I5mrgxdmON5cxtQEXKN58YkSTk+Y/ICEXapYPoQ1G4ZZNcetVX/wBApbq0QL5ul9Be8eBX1c/5RAJC2yqWO3j4L6aVxEcTaR62gzL9Xnw14pb5MEJ0uXb9S6I1h7TmxM+JZGdr4nbJToldFJmnLgturuw/dXTz1ZgQmKGIHI7mZ4xjZxBGHSh0aurKmWTvhXsVGO/PIkPFyuwcwLD5QpAgfmNJHnRJ19moKG6+eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9576002)(55016002)(8676002)(9686003)(6666004)(956004)(1076003)(2906002)(26005)(38100700002)(66556008)(66476007)(8936002)(4744005)(66946007)(4326008)(508600001)(33656002)(38350700002)(5660300002)(6916009)(52116002)(6496006)(186003)(33716001)(316002)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rm4u6p1w/KMBLn34UU6AoqAAMEXGCVQwUZ5VPY2IYazz5yUH/3xQ/uPm1VZ+?=
 =?us-ascii?Q?qYYDG4Yahwy5D9uPMVtksEZmyoaD15XLMN2JAjID9FXVc3JiWafeXUZxM8bs?=
 =?us-ascii?Q?eBAHVW8nZv5GVutejqpxm1QoWrJK6mHNjdmuINuQ7AsdrxOs6oHfxnil5PNw?=
 =?us-ascii?Q?L6vpJSGGg0JgnqGmPIeRUsEFCF30EpKT0NrNoE3n2HCMasOJrxmY+H7oiRlD?=
 =?us-ascii?Q?amC0eT84ybULIR1Bg4p1lU7Srp1ENpsBIMSS4BZM46B6zBqQmYJpGUftoI52?=
 =?us-ascii?Q?qsamcAuvtSzm03BGlgt9VNVcUXmtj9+mNK7aiLZMXY3hbhxvj4Uu47lqxGU9?=
 =?us-ascii?Q?HGeSfJtVFS68871Ai8+cOggwHD7EOQzkWpCz2R8KcHHid48gfrSCFNACKghj?=
 =?us-ascii?Q?wZNtNRpJU0klkNCw1uiC14S5zibLl2l4fqseKI++eTl6WOqgeY6d0fuon6Le?=
 =?us-ascii?Q?UClAScLgE+EBXklKzSGnyccqV0ZUHs1pgU8q7QVVDSMnDNCWUcQ+TpnGkZ1N?=
 =?us-ascii?Q?wmK/m9GxCMnMlGILpqGnizlZFYI2A8+Pf2PvJD45Q6VVgITw1CjCOxxjQN7Q?=
 =?us-ascii?Q?kM96Iyvd+Aof0izzlpz6NkRai2+URWgbfWG/eeccSFHZ8DuUp+ogpUerTVnA?=
 =?us-ascii?Q?+ozG013aX+9JLWOcs1MROuPYecEpJ+y4oGl6cF5uinPsCigKS049qJIFMRks?=
 =?us-ascii?Q?T4C8qXZ0N7fo3uCj+9pKtURBY/tStykjeCnjZq+2OyzkG9VwR4sz4LGrTeqj?=
 =?us-ascii?Q?Oev7PKPH/n8pNf/eq2+ZQJik+iomzcngRxEDbqtaPi76uLnbLBULOvz27Mu/?=
 =?us-ascii?Q?cIu2MQ8weB19xu98uu8qeFnx9SHuO+CFhb5/jZuC3BM33WMZPrWRRCgabUD5?=
 =?us-ascii?Q?p6ACFPY1Pisj0dEA2N8QN+K34xdwJtly0JFRbaH5oDD2Nxo8+eCuRv0EFhBU?=
 =?us-ascii?Q?7UJLciPjwTsuRXKzQUApiVEDB1li9uO2eOw7pHRuUoZJQFTLALb9+vs7rEKQ?=
 =?us-ascii?Q?3g770/2sdKOHkMIQ/CjClqrNoOYVNlAo/bwKxYwgAsyJljQ8SHMDDr6N4n5K?=
 =?us-ascii?Q?TKJ8fOa6UR6wtt04ArjcBQu+M5ejtIOHoc9jgT7cEwSsYOd/GRi05oh6rJGH?=
 =?us-ascii?Q?3n52knTiCIZyv8ZWqjZSQzge94ZLvETF6axlzJzYhjsK8yZV+QWjFpMi5ywq?=
 =?us-ascii?Q?52qMiIIbGgYHcAvffD7xgWOit+j0KSpWe08MsX7vLjMiKEcU3ld34FQqXhfR?=
 =?us-ascii?Q?KjB7WIeE/PUZu2ZquoEUkLwpsEH8ksMkRY91CqxN8zQcooGvxjnF97SRyZdQ?=
 =?us-ascii?Q?giI4bk/APbzo8WmDzi2NUHug?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db0fc8b-a9a2-4a78-5957-08d984dae0da
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 12:56:26.1258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36RGSYheO0oL8YxFv+MczcQtECnbUzU5VAr8Dp6F03JlLor4eSfzk7Xg6vpzXs4BngaVyOSvZzcopiW/h6bSaV0FcKOoSHe7q7ZUVQWdBHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010086
X-Proofpoint-GUID: vcxOuQWzC5tVnSOt39tAP1Q9aExWZIwZ
X-Proofpoint-ORIG-GUID: vcxOuQWzC5tVnSOt39tAP1Q9aExWZIwZ
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The error handling calls kfree(params->acl) so if "params->acl" is an
error pointer that will lead to an Oops.

Fixes: 9e263e193af7 ("nl80211: don't put struct cfg80211_ap_settings on stack")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0b4f29d689d2..962fb169a5fb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5507,6 +5507,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params->acl = parse_acl_data(&rdev->wiphy, info);
 		if (IS_ERR(params->acl)) {
 			err = PTR_ERR(params->acl);
+			params->acl = NULL;
 			goto out;
 		}
 	}
-- 
2.20.1

