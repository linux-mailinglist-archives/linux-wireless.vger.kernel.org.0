Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B662DFCA8
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgLUOPq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 09:15:46 -0500
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:36801
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgLUOPp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 09:15:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsar+ocIa1zZnnJPV3FluFCqCaQdxfuDmgfNwZslVdo3PIbDPl3qjucsIcb45mrIBxR40WZidttuUEVlF5ikxA0a+aOPMnonMHEl3aQlkJMlgJoulLJJvta/39zLiBWjLucH4XupB8/pqc8GSxcqNT9f/Chb726mtaQq4xBGhHZQ84Zxp4lhZc82DOBUtijNjfmVV1j9tKogpttqA6P4F5l8r7qaJm0sqQuSAPwCuyOThvprbFAR+7KzXeJXDyASO5oSGmGS3wuWGBrEwD1KsB3Boo+FkWBG/Blbf2GyXGKEAkqGHa100ejpqKv0TzN9LtMoyQZFGd/C7v0vgKCrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evkc4UJ8l6ZLa9DWyW6wyO8DnDTG6DK1Lq4ALhD8094=;
 b=kMAZpOEryAYkZSBezbfPHtfrdYrgDXp7NbNg8cF4EeHdCZbULz0zbqq95FTtyLLj7wxSF+36KeGIaXTOEG1socZUTUTylZZL7PxlzxLWDy1XS6lidRt2ObZ4NkDkuALPHgI+WrdFhj5q6eBm0v1nmt9C/HwMzIdYaZuC5/Ga6uC+x7lZ5Os/kGX0P3fCDCxsKuUGfaWnaqSGFSjjwd6JHzjLZAIVGJDK5U9Vo5ITBOP87F6cR5GzwegmRRMN45LSICAZ1ITEnKSuAFnB9oTzWbDVlDdGdwv+/5ddQRPKiOoNqwMWTNVdW/rAMHEU5vlMu4CgxatNMh7998q9GbzmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evkc4UJ8l6ZLa9DWyW6wyO8DnDTG6DK1Lq4ALhD8094=;
 b=HWqREEAjghEvz2KFTQByI2oaalPM3ImGFYUVB3WBj4LTMgOy9eICEOGg6j7KzVqR/5r6+p0pn2UCbtTfnadlzmpZkYL1Q9KjTLY3E/y8NYB9GK9qowTaz1FxSKHAdBSPegrQSpaOsYrTdCwe7+Dgt3kyt45pquxE++QBJlNB7go=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM8P192MB0963.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Mon, 21 Dec
 2020 14:14:56 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::11ec:bf60:fa41:1ff5]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::11ec:bf60:fa41:1ff5%6]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 14:14:56 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Subject: [PATCH] mac80211: 160Mhz with extended NSS BW in CSA
Date:   Mon, 21 Dec 2020 16:14:41 +0200
Message-Id: <20201221141441.17613-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019132616.32286-1-shay.bar@celeno.com>
References: <20201019132616.32286-1-shay.bar@celeno.com>
Content-Type: text/plain
X-Originating-IP: [87.70.6.186]
X-ClientProxiedBy: LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::23) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (87.70.6.186) by LO2P265CA0516.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.28 via Frontend Transport; Mon, 21 Dec 2020 14:14:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7238a0ef-5fac-400e-22a4-08d8a5bacb34
X-MS-TrafficTypeDiagnostic: AM8P192MB0963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB096301BAC36F82EEB817A7ADE7C00@AM8P192MB0963.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsK98cOMXc/68yYkJoGg8VN4hnTbAInMa2MFsyYkYjkBWMF+p01gU5b4Ilw/uOGHhzE/mA4ig4dURU89DryT6jKRlVocNTAM8W+EkiHLmR9OQs4tmRETm2DizzdEPx6pj8AxfmXW/Qc4JelmQObNfZYH59lvMCUmGqLeub7Ukd7k8bdkMJlF2b7ngtKOBnJ8mrf/ZSZnlKbPRKKDmZ4vabCLjpLKXXK/0CxGkxoGUn86RybGxEqXE3X/fkZjG8N3mw9Vya0VrdB6mKSLW63KLEHbbxN2gLO6uByCZCK+DHOgQYmvZsCCMzsAipUd80CtBIuUF5VTiJq0qQLdA7n4Ojb1+VmtrzwDF71fR0ik9ac4zGOR1k0ajbCekvgO7+6H5iOypRVGsI3mf4NQtJRurrA/PM5qlvWQLinQQoEMcyH8uqUBp4WDqQMs0AMhFlGcWi/8oYvasifmKnpXu1du7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39840400004)(1076003)(69590400008)(2616005)(26005)(6506007)(6916009)(66476007)(5660300002)(4326008)(66556008)(86362001)(16526019)(186003)(478600001)(36756003)(83380400001)(8936002)(6666004)(107886003)(44832011)(52116002)(316002)(8676002)(6512007)(956004)(6486002)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KbKVKVIDD4QJMnDFkA0waGRU8f1LX+dv2SJxiK3kLKKpM9R1o1nXHJhZSHHD?=
 =?us-ascii?Q?a700ZGQ0jBXcnTC8kZALBWprH1/pfRFehFmPyVQ7wveidkTX/alvixAQSHfr?=
 =?us-ascii?Q?0y0I6UfS2ZSL1FGUYyMN2p8iN/8nTP+xriK4Q2crUl4vT0xqVLG5JImNvvMx?=
 =?us-ascii?Q?dPFzlxbJ/O5cewlomX/eVKNiji3PPEnkgFdmdnVcc1mp7Z/ue9GM2qbvJBNT?=
 =?us-ascii?Q?itN5kDIFFWHCGigT6QWUvcnM9pFPh0sh2hjHGjSEDdBuEh98RGhaLIsP/3WK?=
 =?us-ascii?Q?uSfHelEgUfiRaZCxdxCYhRMr3EDNolJtjJRLFzenVuNRzadWMqtb95fZXBuD?=
 =?us-ascii?Q?ib8RTSGHpevL7QWERnPehFBjkr/eaX4WG+B0y4GAd7KFOzmDRN/JYBr7SeQ2?=
 =?us-ascii?Q?tpeZoq72tYRZbkLxsdd5jf7Y0rF+O8MTsUW5yt+muYeWcLvX/+kO4hCMY1zH?=
 =?us-ascii?Q?xcPOXSMMR9a96G/EPcOJUXJbdEp1D5AeL3rqJRxaiUtn/XpOZhe726dRG8+K?=
 =?us-ascii?Q?70MP3AkRw8FNt4PsJp9CFf2ZSipjlOxKuvk1bfiJ0GSOE1zLQdHO7A8+GINP?=
 =?us-ascii?Q?vl+2eMoEPaPozq1S24gLajzvAFLvhYRNKlzQ789o0qUFtFNWZ/xpCUiuaFEj?=
 =?us-ascii?Q?GkFWehLabHIBfmsmE7DB2aOwvBAfPEjgZ5if9Ax82ES05hZwWU5J7fPD6ekM?=
 =?us-ascii?Q?MlkYgzRX+E4MdyjOU9wilX505YookqnEcpHgOKbViCSavsAVKxlndyFlmWL+?=
 =?us-ascii?Q?o2H9jbZGxNrNKfQjLwHDmy9GfNC1mAwj/w2iMTdWjaGn9B4Tqw51FvOomycR?=
 =?us-ascii?Q?gYsA+fkxafpSthgEy0Rnox78Jfaf8YIKcm7zZnTstXgcw/XUq4OkjxZjtV1l?=
 =?us-ascii?Q?Dz99ZKrgLwm67kWWRo72cfMOyvyiFb7uqtHQSJFKKzGKfkgXS6VRgQxKOzLd?=
 =?us-ascii?Q?t83DYsBPQA+BwavxqPvfwvMCOB0CzGmkzA8A6kcPVIoGiHC1irUJsOsWvj61?=
 =?us-ascii?Q?3oTP?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 14:14:56.2827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-Network-Message-Id: 7238a0ef-5fac-400e-22a4-08d8a5bacb34
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDqZarIhPTyChdjFR8DeQ8rEvrxmrQCx177SmuwM5b/65BN3ljB9dpjQGyJcNU2Kq0JgsOaP86tEzOHi3U9KQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0963
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upon receiving CSA with 160Mhz extended NSS BW from associated AP,
STA should set the HT operation_mode based on new_center_freq_seg1
because it is later used as ccfs2 in ieee80211_chandef_vht_oper().

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 net/mac80211/spectmgmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index ae1cb2c68722..c235ddceb835 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -133,16 +133,19 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (wide_bw_chansw_ie) {
+		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
 		struct ieee80211_vht_operation vht_oper = {
 			.chan_width =
 				wide_bw_chansw_ie->new_channel_width,
 			.center_freq_seg0_idx =
 				wide_bw_chansw_ie->new_center_freq_seg0,
-			.center_freq_seg1_idx =
-				wide_bw_chansw_ie->new_center_freq_seg1,
+			.center_freq_seg1_idx = new_seg1,
 			/* .basic_mcs_set doesn't matter */
 		};
-		struct ieee80211_ht_operation ht_oper = {};
+		struct ieee80211_ht_operation ht_oper = {
+			.operation_mode = (le16_to_cpu(new_seg1) <<
+					   IEEE80211_HT_OP_MODE_CCFS2_SHIFT),
+		};
 
 		/* default, for the case of IEEE80211_VHT_CHANWIDTH_USE_HT,
 		 * to the previously parsed chandef
-- 
2.17.1

