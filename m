Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E711359F3
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 14:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgAINTI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 08:19:08 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:42774 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730916AbgAINTH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 08:19:07 -0500
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 009DBojk030668
        for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2020 06:19:06 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by m0059812.ppops.net with ESMTP id 2xap4wwh1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2020 06:19:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOqnrIjRq29Bdl2MkCBpwiwZAg7viv/CcoMiyAUFWKn/YRdC0KvzyergUkDm/hZIW1UJ1PHaTD+dh5Np1jBfAXICDCZ+X3e1kBBUt1c/l0i1xivR7BFADfLUkRqhpR7xR/5GEgEMa2HZP/fYspcThMfIamL4kJNjwSB6VncMV2MhETps69Fl21zwVw790l6QRAbKk6LjY64p4vdbU5yvsXiCGklWBzC9bZZp1WUs6E/NyhcfYm4lOyIi/USA9YhSSoKgFaQp2okckeg+EnWZh+OJS9XBBk6m+mQ1xGGkNccfYazq9/e/jzbDQtC9+huzmpRQ9DWEA1xGRaNr4QDkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCfV2qyprWmWuSjbPDOi6dG2OWq6h7VzAj1Oq4a8NcA=;
 b=DcNuPugL/qpXcmVMUff3MekGTJyggJJUdWQRGxDJIe/nlDdNyHhDmDrW6Gj4h+V1wl4jQJqSyVv8b73aeXThhuAPE8jCVgzQswnb3amQ0Y8QCwC45RQOB3/poP+XKofV7kWjJoiJe/DA0hyiXo+Q2Sp2gIW3ESIrRyriOtktxiv21WSYAwbrQ/BFvIcBuYUG1Fp4DgJy2RzBFZA3920B3M/VFFase/4iFjbEQtknPM8+eHbDQHNFmsRN6+hUaLr2kPWOTJM8tZu33LpCBLy0rU0mn6x6cHPk9iSfg3A8i3lAs//wVGmfn/N3x/ARRf3I/ABIFPjUbN/oVX+Vnzp4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCfV2qyprWmWuSjbPDOi6dG2OWq6h7VzAj1Oq4a8NcA=;
 b=a9ew6H4SztjAikPFLtVXi/utQwN1m2lH9ZSDZvNs/Ve5vp82eBcs6vsX1pNow6I7yxyvFa/FCsGHeZD0hMSGqqmEFpuaK53ogroPpWVvMAbwURcAWtaAPowclamAp7TvbjOroRGJalVBuNETVEyaGGvdM+MrvTAd7BlS/+ln0OE=
Received: from DM5PR0501MB3718.namprd05.prod.outlook.com (10.167.107.143) by
 DM5PR0501MB3735.namprd05.prod.outlook.com (10.167.107.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.5; Thu, 9 Jan 2020 13:19:05 +0000
Received: from DM5PR0501MB3718.namprd05.prod.outlook.com
 ([fe80::c0dc:d81b:b815:afc9]) by DM5PR0501MB3718.namprd05.prod.outlook.com
 ([fe80::c0dc:d81b:b815:afc9%6]) with mapi id 15.20.2623.008; Thu, 9 Jan 2020
 13:19:02 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4637.namprd05.prod.outlook.com (52.135.114.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Thu, 9 Jan 2020 13:18:12 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 13:18:12 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 4/5] qtnfmac: add support for STA HE rates
Date:   Thu,  9 Jan 2020 16:17:54 +0300
Message-ID: <20200109131755.7729-5-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
References: <20200109131755.7729-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0901CA0053.eurprd09.prod.outlook.com
 (2603:10a6:3:45::21) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars.quantenna.com (195.182.157.78) by HE1PR0901CA0053.eurprd09.prod.outlook.com (2603:10a6:3:45::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Thu, 9 Jan 2020 13:18:10 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 706dc147-f2d7-47cb-3f44-08d79506609a
X-MS-TrafficTypeDiagnostic: SN6PR05MB4637:|DM5PR0501MB3735:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR05MB4637172A791A9009CC517E31A3390@SN6PR05MB4637.namprd05.prod.outlook.com>
X-Moderation-Data: 1/9/2020 1:18:59 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:106;
X-Forefront-PRVS: 02778BF158
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39850400004)(346002)(366004)(396003)(376002)(199004)(189003)(16526019)(107886003)(26005)(956004)(103116003)(8676002)(186003)(66476007)(5660300002)(2616005)(4326008)(66556008)(6486002)(6666004)(66946007)(478600001)(6916009)(2906002)(1076003)(86362001)(81166006)(36756003)(81156014)(316002)(8936002)(52116002)(7696005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0501MB3735;H:DM5PR0501MB3718.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzenDb3NcuB3hRSIikw6RrwcuGh0tj3BQBsB9Ejpv2DccKED+krnzSFDhLcGt5f0GsJkHDjSJQ+JAvs+HIGABWinxDDdVRhRO15fE8nGgoJ9yTmuso9dFpM5pqaHQWCUiQmVXTRxq852fzBPLB8xQIqo9RiK4d3ez4UTVAS/OQv3JxNCqrVOnWINpY3UAsvkwRHc+l6Vmqlm7+M43Ej7YyIrwVhjJpOfkQz91bcepcCuSRsqV1bitT70XCUp8lzjSRC+DQLZNW8wE+HzDYeDpokz7//B1dbVKFGom7oPAX7tBoTAzlHotDm/3GdeXEzQGVaouWZevQ0xBBNO35cpf0kSNQtP1t/QqVRfCDKG8bwspW+BSaUiYpRwS5FthFtlMgLw1nvvSgapdMMm5VkOCm0xCgO8+ORuK663qnynC7Wm3LmtMHSqcZBaOgoGMI5E
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706dc147-f2d7-47cb-3f44-08d79506609a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yP8qjct8STJCNY4k+nb71sv4re0jfbwm8blK2quBYJTAMfxgtiGYZWma0vWZfN15jSrxq1fDt2e48Y2drbzt2TtUlv1AShPftsdKybpvNT7N9CHzyju1CPvvfRWfVV4fv09e+rNZjHDgNAR9W4J0Mgd/662XXyA89d0+7kJGr+pEWZIDxNHxhUmpAsTaVD5mwXA4akyr2Vd78FFh7nRZU3RRGoGijdMpO7pydYP2Bc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2020 13:19:02.7786
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3735
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=1 clxscore=1015
 mlxlogscore=690 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090117
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add HE rates into STA info. Report HE Rx/Tx MCS if STA supports them.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 2 ++
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index fbeff01f902a..fa932f771856 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -510,6 +510,8 @@ qtnf_sta_info_parse_rate(struct rate_info *rate_dst,
 		rate_dst->flags |= RATE_INFO_FLAGS_MCS;
 	else if (rate_src->flags & QLINK_STA_INFO_RATE_FLAG_VHT_MCS)
 		rate_dst->flags |= RATE_INFO_FLAGS_VHT_MCS;
+	else if (rate_src->flags & QLINK_STA_INFO_RATE_FLAG_HE_MCS)
+		rate_dst->flags |= RATE_INFO_FLAGS_HE_MCS;
 
 	if (rate_src->flags & QLINK_STA_INFO_RATE_FLAG_SHORT_GI)
 		rate_dst->flags |= RATE_INFO_FLAGS_SHORT_GI;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
index 799c622a160d..19e432b28de5 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -949,6 +949,7 @@ enum qlink_sta_info_rate_flags {
 	QLINK_STA_INFO_RATE_FLAG_VHT_MCS	= BIT(1),
 	QLINK_STA_INFO_RATE_FLAG_SHORT_GI	= BIT(2),
 	QLINK_STA_INFO_RATE_FLAG_60G		= BIT(3),
+	QLINK_STA_INFO_RATE_FLAG_HE_MCS		= BIT(4),
 };
 
 /**
-- 
2.11.0

