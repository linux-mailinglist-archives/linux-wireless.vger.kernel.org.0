Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9D9532925
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiEXLhh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiEXLhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E0440A01
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoYbKNLBsdQlJI5g6YAquuqvgFn0UMQuD3wcosRhYVj4+SEbkThB8OmavuEcccb0ZiecRbLmbXUpv3Ai9aWvv0s/Rv5T5bwkI7NAXAZbGmoqNUC5V5Nmi8ArUFL1IPdXRDnpCP48MQBVEpCe9iTB43349rLc8EFrL4CcXw3TPkAC9ra1dw3BmjgBG/6G5oz3Qo8U9xaa7CskOBAu7sosQTHpHGGQr/WBPcMwL2jKxBx+UiuutvieP5foKq+m5m8GUBnvRLSm/D9K7NK/+a2qIv27sBayHq2G8IcMEZO4lZPm27b8g3qTDecpHxnfnBRyf0i07cWv42EnPutVtLJPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHZWAy9rAH81C43m9OTTcovuMhYZKMnPxf7s3MIWjGY=;
 b=V3xUyLyDNGM3nyu7z8Ws9P030GHUvNlZa41DviHxlRfe24rb4Sj/aVKJ6zlGCFXs87YyhJiWcqTJTqCfMSJ/Aa0WLop8GYN2aKJOc0nB4bfghqTtZOx+/Zp/ZuZeUjaQQ/NiDGDaKmisYmxu1G8GkDWb3NSVeYI2idymnQ+ucgQZ4DhnY7TemkGHvpHeNXJa4mBzV7VrngN90srP6aT11hTRIAJFuV8zGBbZXsAds84gmd8AN8hR8gKCs+fN3pdD+zdYErlkAn7F2lxx0vXF36FZKFkrb4/zoKc9SyOqSjYQ21SdOomlJcNnSGN5Jjf7mwARVs6XRTN0yISOfPMm+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHZWAy9rAH81C43m9OTTcovuMhYZKMnPxf7s3MIWjGY=;
 b=H0fN1wSTc0LR3I6YBWsobsqp49qqZxOAWdHzhWHowkFdkX7o10+qYcbjG8WRGmm79kQBONzo1K25WycbfWrtkvXTDFZ7qOnsmW1vwIORn0qdmELh/GfQibPmhBqpummjZYT3WXTUU1WMVzo688Tlcq/u2WN3StWmMZe/58ylxkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:37:29 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:28 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 01/96] celeno: add Kconfig
Date:   Tue, 24 May 2022 14:33:27 +0300
Message-Id: <20220524113502.1094459-2-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f106e8e-0809-44a9-e4be-08da3d79c842
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384E80DDDD52D0F7338B4D2F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x5SdiXP5VOtVpZpyYpzS5k2zqCr/xWzf1DzQ1/JGzsmHyXVJgb5thwZYgKzQyFXWEeGN3rzhR6B6sZEkXOnXDg5jeu+gICLiAJ8QAVsU159liglepvXhk8pqxmcf95ANNuQtMHejPzSFqvcz2dZO/IB5/f7cUFNzab4MgDL02liFHxQ3jEIYkrNeOY+Dv/jIeiuDSeyT3QpVLneBtcxvx1ZCGMdt5hWVcxIDMgSO+hSwhl/0u8OIkpf9Ec4BwJPxlftzakOHYtwZ2RvBzepMPpPZOOBpXIENsLjOHsfR+bERWWBvndb+p48hAqU8mKFK1dsJYXyTGVwD7IJBIeKf2JhPfcv8SZzIuvDJLVFClQQSdfbVHMw0sJNuzVSSvbzTyQ9l8hUhRoEb5JZnlihJaUUxq7RNmaA+LJN09L++F+ycj2ZCS1GFvDhtRHQINwOcme6CstDDnsWdFMmKSsS3jisGbWK5Od+m0Aq1D44njyA3E9Fsoi7zm40qYaTWrYEjaTU0vGydk1OhLv646DGMZQNzHEmoKl0IyOecQG8HTXDp+QfWcNDkQlVKUkA5UHEGk1b+t/X/V35Frf4DIcGtp/qNPfZteCME2AXukW1xzaiJdGQWBAijw0NADvVGrIh+8c9cctCZAuNBQQKWzHno7FRz83ixW3Ib0Fdz5usMd8OZrFsc5X9MG70PHixu6xbwWkfolaACguQosNVpL3OUIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PosR73sa+Qbw73I226nz0MfhfYNcuKqduqgq04U65pv82eu+tVjIyOPzm4g8?=
 =?us-ascii?Q?xuJ5PLUCL5TTodW7RHtAgQC8H31WJBc2bNmAxtFvvVE8Cx8N6q2o2sSSh7ML?=
 =?us-ascii?Q?gNPjKqfvnwMC74vAeEPGvPSvtaG0ddp0XJ0JDMxFyLitYjpwGH8lOUuqCVfp?=
 =?us-ascii?Q?oaJAPJy7Ev/bX5/NhfvCjoy9TfuaHhu9rorZq/x6RfA0XfIhOhBTU1d25G09?=
 =?us-ascii?Q?+kf+fEF56sT3sP1o22Vr1S8HXddqEwcvtdQJXdYFn0j4pl+A2UZixyVEIRjz?=
 =?us-ascii?Q?jqWqMJ8dRskd+Equ63GM6gKVXfUGeIIvNgyi2V4tt0LBux6O6GKOIkdS/X83?=
 =?us-ascii?Q?a/TMk8KZegKDGYeULbyawY6wIEzKO4lumqjNoJyDrbQNFXt1+8EKZmgJ8pK6?=
 =?us-ascii?Q?pAZ+FvVbZn+Yuhxnw4K7ot3gWyZFlOjwuHIqPRolCqzkJ96Qdu8uz/9S7guv?=
 =?us-ascii?Q?Wr4FozkE/JD2l3kjqoZ5ecjqZgNQOPPTgtlsvZEvfa/JY93XsihjHLhcBY2t?=
 =?us-ascii?Q?7HKYcoPw2WJ8GNVhKNCDCSjBDalAQRCEXpgMoGqUzJf4yUMBrBnHqtZDm89a?=
 =?us-ascii?Q?W8fZdutEwP7TkPP0yQQdTxawQ/1XySw+cUM8YGdlfFnuFRNo7XbW6oaa2Ldx?=
 =?us-ascii?Q?aBhAiF1XdzQrJi7T/ThPuq4ovkdO9jsNkLyrX7phrmFkTnyaG2SuH9vafBwv?=
 =?us-ascii?Q?Ka4UIGi5HQdKeqJHaPdQhvKZ0LAUsuTgJA8zDSOpgfXR6pgaTqdf3vQat4TN?=
 =?us-ascii?Q?hDBvxAzPw2oaTXpE/BrOuaWFdKjjtiAbWcr/HZxF7fsmjqzOt3wu5Tdw/k5K?=
 =?us-ascii?Q?E9R5rHFsIB1AFZ3s/McF/kbAm4f/oPQrd8b3T15DCYdNmKyvgY4uWvmdItQ/?=
 =?us-ascii?Q?aF6CEI+tyoofGOlVd0/3QLOH1Tcq/n8TPw7OecWmhxbLMPJiW3UganbglF7v?=
 =?us-ascii?Q?aF5wlxz8L9gOTP9TEEeymcMRSrIUNaudhU5qtLqNQzOv3qFT+A/2Cy/ya428?=
 =?us-ascii?Q?Xs91zUbmgPdD8nUlYtzsOm719QsmKbcwygPjsZgANS8eqaxjrkSTl4txabMH?=
 =?us-ascii?Q?VqP1VOMdDpOVXle+Bp6XsiKnuinfxi4NLe/Rk/0rI/BqluibRtQQXkmNtM30?=
 =?us-ascii?Q?7emhVS8G+suh4MUZeIk8woRNbg0H0IF44iAss6um1sT9R4orbvRMQhYUawrl?=
 =?us-ascii?Q?DsXxlzzFGkLBhQqnHFqbNJU2GRZdKtJ9K4DcMHoxhr1nRhclrElBr5X1p8Vq?=
 =?us-ascii?Q?6RJQcXF0uLOrMjHcmZepWzWiZnLCADnBNcl/BYGRHBtfBP3jiOn9u4e++HAg?=
 =?us-ascii?Q?GeJMOaM8wWS9XiS68j5dJE6lxNxTkqzDK4o3539Im8bm4E0K6Q/5oOzdNbd3?=
 =?us-ascii?Q?BEzjdahzkMookE7ZY/bF8A97CmQdehHcPo7yRjkFiJ64j39hawYO3tK+C1ZD?=
 =?us-ascii?Q?Y1NVQHf28jBxpaaYLDF6gkdsq2rov2UPRE0ZsXzHP22Us/G7PUaHYrfFDs/F?=
 =?us-ascii?Q?g7tajYpibA6nQIFtHj8OVh+2TAeGI0YJSNMyZafq6VEmCEgc1Hat0zjsRIEW?=
 =?us-ascii?Q?YqLZ9RLHZRsxWSrj2+Dt5R3z75VMK24TNLtEY0pLC5lzaXOgmU+RLGqcBQWo?=
 =?us-ascii?Q?Nbq1gMqaEu879PsTOTae+VNAKTDS8tcgBUHUnor7jUujt9F/AvhsP8l4EbsR?=
 =?us-ascii?Q?B67RplR50S7rlZhQwVUgFHOPZwBwWfx+iNWJQKNbAoFWw70AECwIQk9ipSly?=
 =?us-ascii?Q?HePCSqzOJUBQoPS/9C5AZ/Jb4PmN8Ak=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f106e8e-0809-44a9-e4be-08da3d79c842
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:28.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5z09+1j7780kNnKJHr7ffmlXjtmIIRAthUY5za3F5jTnyalwnlxZwNrpfGcA4IGs22qq73AeRwTmct+CT68dQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100755 drivers/net/wireless/celeno/Kconfig

diff --git a/drivers/net/wireless/celeno/Kconfig b/drivers/net/wireless/celeno/Kconfig
new file mode 100755
index 000000000000..a5e8a9af1ee1
--- /dev/null
+++ b/drivers/net/wireless/celeno/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+config WLAN_VENDOR_CELENO
+	bool "Celeno devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all the
+	  questions about these cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if WLAN_VENDOR_CELENO
+
+source "drivers/net/wireless/celeno/cl8k/Kconfig"
+
+endif # WLAN_VENDOR_CELENO
-- 
2.36.1

