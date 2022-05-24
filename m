Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7559A53295C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiEXLkC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbiEXLj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E692D0C
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td2vUgGpUfgSykCi3d4XL/e1CWc2IaIYbaXPiWZa6X+OIpY6YJACG6bFk1JSQIGvBfNCYhuPOfTXXQEZWk6GdtvykMXDEv8suby2sXhkDor1uvmQYEJ0daRJ5ibPtXB2uiSHxONdS1IGIxM6yrwutdGOTX5ozmacy6Tb0mvdTt309hdgClQC/7Q3bz3HMOk3zrm/eo5fKjMlrh8UMZZdM/i3259eI+AwBjT8Hun0vyMH+OD4LmiZpN8WiyHR9wCHF5eBV8oZzMfqE0tVaFnDQA1Y4gJYcs/2Bn5ifcPg3c/63Cav+bRg2T/sRfD+o9z18NxqEm0DJvx3QgbgoUfTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuEiQ2he2/khl9KjB3d8Z7ABA1d6Vd6a9zGKnnkZSxs=;
 b=Ib3dgMM9gxfJp2xS5rUR6VWsYtdbBEeRoDMBVRDU6VC9LNXjb3HlwWUTg7zBCdVJeQhW5XWCIkHT6+C8X2FCc/1Yv5JCQF4j2W1G8/4+sJKo0c6uHdRnjQKQEEz12EAf4OnE/YREf0z39+IxG8brHvR3HS18+1BYNsrrLUNdxDvBydiycMKTQusz1ucE0xwWK2gSnuv98ee0GAPmZO9n7GHsM38bUo0yugI1aTydDSnMiE1BATYlFQ6UShC4I8Vwr/14cCH+6W5jaqrH5h+N6VwkAT8o3iuCcy1XlJ1ulQV3jmxuUMCq5csApJwwjSn3l/oYQ5FdJIx+EAS+55tJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuEiQ2he2/khl9KjB3d8Z7ABA1d6Vd6a9zGKnnkZSxs=;
 b=fX2FtrGdRTsvWmkj/lY+0g76fbouPtRiZHDB2DrjTPlj3pz3HVQC4OuDBNoor8rWxXX8II50zeqGoaNUL3izAkX8j+hNcbnPBBT06YpriOITGlYxncrQUhCxHYBeCn9zxgq+3hZujSjs6sY8GvZjZWhBy2ctjaj0w7NXO94g/PM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:44 +0000
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
Subject: [RFC v2 43/96] cl8k: add main.h
Date:   Tue, 24 May 2022 14:34:09 +0300
Message-Id: <20220524113502.1094459-44-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b38815b4-1411-47af-ba79-08da3d79e789
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB03842806C636B132ABD7BBB9F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icbzC1DDtLNYv1NJW0bgiscXtwOOUE/VPesUwPO5kvImA6pJ7F8e9S04yedlgOM7TopN958Uv4Dc8WML/h4pudnSsda87n+KYsgs0uO7OuCdhq5SFORz0KIISHN+VLFWFQKVvs43T0Jxq6DU0hjBbDC3RAfsvaW+lcE8xHkdrZZqqe62Jt3v2kTmN4qv/AzBkSKTeVYwalHIioMJSKD3quFMzXKUUhnRq7lY6cv4gNq57TqgarFqvwDflCMVK9CxhepRt4I8wyc/AecChd4SC4DCYuwAWIVHbSdMaiMVZWV7tix/zP2skbDmZCYSF2xG8CRQ4ej5kZaQm+sjowyMG1U2H48/LlOoHDfLRL1Z9paJAl1M6BkArL45FaXv4+7S+1VcLmcvLLdINbtMc+veCQG1xAyYDnnT9aIL5Ua9qjgHBfgyvzm7ZFsWjXX2qymQAKTEIjrkv596/7vTq68QtPKEGX5/fLwnslfYmzaIvdRCj5IzvxoCPCrPMgsRk8vALHH8GX56YjCzP8vXXVuqoDJu+nELiVRogY5pw0YSFIfMhDifvPOJZLqdO1Jmm1WhR/jdqBUj+X8NGGgG9Hxto0KJHh5Yo2JnMP/xELZDZmZNakqrjdk2KJuwacFy+CuELKJNTL6EdzfnhrUc+6IwoFXXFDUZbiN3NtNrRxPSehv25b8z5pvEUMsSAF4l+1BlMTbcflX29jWAQ0rMhjMTsDJ57rbyuReJ8ZpX7xxqajs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psmvP3r4FfDKHiXNYwHo++r8H9ho4TltJ13yaH2pqgJ8NhqeN3ZkJP2Uv0Ko?=
 =?us-ascii?Q?WroONogHN6u+NPj+f1cQFsCSm0pE0uUqvEJa596+J3QGLJFXrcK6bLZOwRvQ?=
 =?us-ascii?Q?yLL/Vd2KuSRzKbfmwZ/WKeQnrzwyrO1n2uoZCs2lAvlo408+lA02qGyLK2gL?=
 =?us-ascii?Q?XvuJawl4A3oyLEugjthJENM78ejX0+9odMgi0a19h0Vlq6uzOSVJjHki5qMU?=
 =?us-ascii?Q?cAUwfoi8/VOagKE8OIyqcpFP7U65OK9wztG6n1NXPxMUZKyYcV7to0aB3DGc?=
 =?us-ascii?Q?n0C3Mt6A7NbHLgUKDLNpn444K9hddhB9KBdw5ZDnM8aYeYYJ9r5g0U5sn2U1?=
 =?us-ascii?Q?9Kca3MlStE3C2IOm9LrOJEn6LrAEcMkSadU70pKv9Vm5m3PiVV8l/acSRosd?=
 =?us-ascii?Q?kPpRPQsn5m2QcsQE5Pksgc9a47BY37h7f4kGRkOC8vACPHdUgfJ41kw7y37m?=
 =?us-ascii?Q?IwqysKOp7yggkY0oz5QV9PqR+yyPch66cIsKc8OZXtTbGCaE0EyqcJwjraFP?=
 =?us-ascii?Q?0GrJedjVccBV5U0RNh8TL8BZLbcg5stMb/zvhzuu14j5DOcKSsjXi0r1BJ44?=
 =?us-ascii?Q?PUwjM6Mw7ziP2SlEz7m/6V6TIaAjL1t7HmWKEisF4GFXAEaE/9SzqwmcwCFh?=
 =?us-ascii?Q?qoEGbZgymIVH2lcUWkEn+CFPFKHTKxOoMVdQR75+tC6ziP5frkZ6YnezxX2x?=
 =?us-ascii?Q?d4ZeBx4d/E09c4RO3D+rZwjt/IVKlpJ9kcO1RWbFpBPXVlRoZuDCcGebUDK/?=
 =?us-ascii?Q?lcUXjrgFg5RzDCd5q6boOJDikhsnBjto/kiG16oe9vTTLND6iSydu2YfhBAm?=
 =?us-ascii?Q?yDBLngpWspVfK0YJSmYdEMfM8x/ohN85Zrsln/4FsxDIqPkOiS8mo9D3CvzH?=
 =?us-ascii?Q?qT1pvjOtGUOkZRUZ0lF6fJ9zlQ5/DwUGhAoLCoynBj5npL4Abr9rtKtP0YaL?=
 =?us-ascii?Q?jQxQbGMpM0QpLtvUHIsESolabZ38BO1xci1mHG3di0m12SOcSAKsg0eOilBA?=
 =?us-ascii?Q?ne1tH5dN0vj3UAA7eLmzBY/VKB7U4w1IVkH6NnxoW4TvAaqEozI6H9AUJ2bM?=
 =?us-ascii?Q?S/ecRgkLgAbbkY9BBPMkv8e2vWo1HAHlcgRqsBs8ASdniqiFAU7venvS/KgM?=
 =?us-ascii?Q?Gl5hyWhLKzTRU7s3t0ELDoATe4UbxRplICjup3powLDVjx1BKVaxnMZ2TC2C?=
 =?us-ascii?Q?n8w2Ye/c21SiR/6Suyj2HU6vMvbXuUSCxEvG/Js0Oye2htRD4MD9PnPhRezK?=
 =?us-ascii?Q?KBT51kdp9GVxzJhup0B+o9IgytHz7nK3J2gtWC4XvnTJOV7nM88h/CFgGLhs?=
 =?us-ascii?Q?ZxsAdcZeIvya9Ge8I/uksjEkQ1nm8jYrHkDwej97PlmjcdlIhrVcRl5/NS1T?=
 =?us-ascii?Q?Nz3M9FWspZBIccbctesR2ohukP0DHJdqoc3QSCvwT+el6+i0txfvseA17mf/?=
 =?us-ascii?Q?fY+VActpz6s2Iz9zhrmDez15zQ+Q8BCnV0TnbG38A2IhVOcT5cg/POWdamiH?=
 =?us-ascii?Q?tvC4Vp8sMX+acKuUmluRxT3fm1Xc0sUSziRFG+RWfSnUDO2IE02cdWBkTqAw?=
 =?us-ascii?Q?HIUlpkWHiemPxllNWgAjX9V53zm+E4LMrjm4hHI1wDIXtzqPQzZvyM/kb2A2?=
 =?us-ascii?Q?J99Ggdbi3264okQFnY6/J+NEm5ukdMIEfmLEpbdT4ZrWobRZuew246mrp2sC?=
 =?us-ascii?Q?85gBl3Yqzol2Vlu9s/GG7YIw9S4Eqt/FfnlI41mnKm5eUeqfJkw7gFwbrbyl?=
 =?us-ascii?Q?d/QdC+YtA70RrIjOn8+ZOMx1rVE6ybs=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38815b4-1411-47af-ba79-08da3d79e789
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:21.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSrHzDeRc1Gz4AJDdU3dPkC22QzsUY4NzWuCaB4qodxsmrxVfQsS9CyOgjZDvj0alhk0YroFw4NQxldFQ0KQWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/main.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/main.h

diff --git a/drivers/net/wireless/celeno/cl8k/main.h b/drivers/net/wireless/celeno/cl8k/main.h
new file mode 100644
index 000000000000..69f4ae599902
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/main.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_MAIN_H
+#define CL_MAIN_H
+
+#include "chip.h"
+#include "hw.h"
+
+int cl_main_init(struct cl_chip *chip, const struct cl_driver_ops *drv_ops);
+void cl_main_deinit(struct cl_chip *chip);
+void cl_main_reset(struct cl_chip *chip, struct cl_controller_reg *controller_reg);
+int cl_main_on(struct cl_hw *cl_hw);
+void cl_main_off(struct cl_hw *cl_hw);
+
+#endif /* CL_MAIN_H */
-- 
2.36.1

