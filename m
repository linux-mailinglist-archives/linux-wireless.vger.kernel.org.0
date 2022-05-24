Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B226D53297C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiEXLl2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiEXLlM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:12 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00080.outbound.protection.outlook.com [40.107.0.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95879548B
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKUbRMWddtiCtijym/SD800e3K+6JfKZOWBvrLoC3hre2eF4NULDZitEAwQ9+7FEoQnvuYZkoxy4pcc8jVvO5odBKt7e184GbCp78/9sVhXGC6ucDZDKHf5qCQBZjEuTXlonMqOkXI3IvO3FKdhI1vdQTdC79B5stk1JGYE3Wwc+3Wg+ytJ4hydAOrnXMLmeeSXR03mr/rx3EFtz1B8OmQZuyQ0Qg+aSw7j5Kak85DNKsB3YROx8qS+Ne0G6u+0piB+yQ5uc2WmcvazqnXkeDKatUJTNBhhI3W9EkPMQCMqmbE//whgWm9Pz1QXXK0dSEdrgD3f+jutMG8uVmjkBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjM1EzjCY3utdspDCfRR4v0P+u37DxPkAT/q/cJvYtA=;
 b=XJWxIU+VKq11BViszlLqmbjVKJe6Oxb4YV+nBzkwnieSXnoDIXauIXwEwxztSO1qJZmhWa42cf0yH5J+gPFluk3vacVj04fXdpwonm2DkBDmAbvWaxU9ETxaOQSzc/jowHQM+j107cD38A/W2If2yyPDYqq13D60EfxlBRPL0/8RGUq1ju928twAXtIeUzkg3alMj9e5Qcw3/SkDvDEpUORGkb6H1nr7tPTCqHSuMG+Anxequar0um0x/Srlvwe90yP8EgqA61Zp+oA2Z4qI3V2q7KtkCi7DrrcpZszGbOqO+deHSAXYdnlEjNvwFlT10Cgvxi5y+r6KAKwDFmWb8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjM1EzjCY3utdspDCfRR4v0P+u37DxPkAT/q/cJvYtA=;
 b=xsAL0uMB3+TLcud+XjKjmxdGjWBuBvoSbJWwqgiDsrCp561pBDhg1S/E2X7kDH+8nyjmUgV7JjhhI0bEvqLsUE98ddf3FaMjl4ZG3sMJ/Xh/0K/EsHAAVlzY08rg1J1fMVCxjS0C6lmm9hFPkm3Y9K6g6wPowQjej/Gr2GZA5y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DBAP192MB1033.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:40:07 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:40:07 +0000
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
Subject: [RFC v2 96/96] wireless: add Celeno vendor
Date:   Tue, 24 May 2022 14:35:02 +0300
Message-Id: <20220524113502.1094459-97-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: fecaddf6-17e7-458d-2bce-08da3d7a027d
X-MS-TrafficTypeDiagnostic: DBAP192MB1033:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAP192MB1033F72DD762488685DE0AAFF6D79@DBAP192MB1033.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gxnpxvrqdipqEZi7+TcBIaWMOQprFhv7/6lconKRD/CnuEt6vBg6mxCfjijm27JUsckwZgtOXF+5eix838wGAF5+bwS26NTM5RCy8xhKszL+gkgZvHQPYAJXWu2Kwcv9GsOnLjRM0IL1tF7rcPr3hI4n8TURXiL+f6ysCDP7hvdjQQHhTmMWRDhb3DA5fEvxQbBrV1wawKmrTkMeGoWzDnD96uMc47oXZGWYaARHyZSrygB5aMQWx6BNfxNMomjb6LbjWaIHkns6hFPDtoxoaRba9xEbNPSurq6Kg/6tRqvff8jJLgg+8ieiql4lwVafj2z3IJ/jzAlDiXBWf77nFawAn4hKXzPiQ3pQq0modFaTe4ZU0jfDG3je1ENWGCYwgkOwkwLUChiJSlOak2yUcZksBJ5uPQFRLJj230lwLl11RcGPixG9ggVY3C5wdm1Aebgj8rEE14CjGsW/Bt7IyBJfK46UMxpOCziNhjnCzx25Djk4FpzA1NjRmgTXJWzeWTa/2Fxxer5xX0yoNQghYPaO/o5R5vDsMSgZ/AYQayMZdWm6e7FQEsV8jqgEV/WW71Me7QXdAs6bkrPkkAJJ/36ahiabxyuMLldQn7OwQ00YXjItAA60426Ml9Ry4pjQ0cpi+qsZjgkQR3e/jx+iJP6ylvgZbYcdZSlmc0EKIQid3W1iL4iWXAexd/W8U7lomgmJTsR1Kxy/QH8BC+cMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(366004)(136003)(396003)(39850400004)(2906002)(4326008)(6916009)(38350700002)(8676002)(86362001)(316002)(54906003)(38100700002)(66476007)(66556008)(26005)(2616005)(52116002)(9686003)(36756003)(6486002)(66946007)(6512007)(6506007)(107886003)(5660300002)(508600001)(8936002)(186003)(1076003)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V2YhkOIfMetucgA3iNVz8yYiFooehRU5BpXxk8YwAHysDYQS4YxT8i3FmAlb?=
 =?us-ascii?Q?/+FCRcTZcXeHeZTyimw4drPNHEgGkA/iJrJiBXVX3ye/51OrUcMgBGBEooe1?=
 =?us-ascii?Q?42eoQpCUnMhv02WsvEpWHdcb64gJYSZXXtcE0b46GroptCUy3F8Y2pCMQAbb?=
 =?us-ascii?Q?so/hCOCq4yT84w4ACWn8Ok1dPy0dueInesecpE2MD1zLARcw+AaIqE/7mBGu?=
 =?us-ascii?Q?/jSVT/mteykOg+NvYQTEfwaYCtuwfGsxrFd0r9FDqquUWDcGx47t09ipTwy4?=
 =?us-ascii?Q?HL5Id8ddZk8G98Djy89bqCZKzRweq5uaBpaOgqs9KpbRoepTJK0Umwl0qLXL?=
 =?us-ascii?Q?NzCcnCxnhRdv6BVAZI2F6AvVhCYXaZ6JIUIbju+YemyonCtnTe6w3TQFa/mb?=
 =?us-ascii?Q?XyooU8lP3XHJeZ0SJr8LmMo6cFkbqUHYmCfu5WhVPgDgoRVDip5Z8ieCQraq?=
 =?us-ascii?Q?54gNgMgwHi5T8gFoKBt51iCt6ZL04h/ieJ7A3wde3DfF2oC7N0+Yd7lDmh/5?=
 =?us-ascii?Q?FZWN34FMgj1zkEeYzcTqwF6e8J+FXvIE5KYrOEsQKdgLIPgb/8Bh8vXatBYo?=
 =?us-ascii?Q?ydURSLmAhF2lGa+sl0ah/zLK0PkZCjo8s6I8lRUesJOHOhoK4CAdNu7fpcad?=
 =?us-ascii?Q?SWV+bOnSBnqYOI8e45Ca0tP6/D4CKm2bBz9MHA+gk9r3+mEMHdM6J0BO6viB?=
 =?us-ascii?Q?t+aCfr7B0CymD0AGojQ0MMwrMUakW9lT5HqESCAhOw+e6nXd9coZwWeHRYef?=
 =?us-ascii?Q?S5uSU5B1SbIiWqMbQxpqRxfJbLAe8Vwu7e/P9mBjj0tRQmFFKVgYL5dZpAQF?=
 =?us-ascii?Q?WlGcTlK0GoRI+8oXKIKtk+7n2brIjWns6equGQwRpd71YXzIbnyWFk0z19s4?=
 =?us-ascii?Q?wYNQc03INY3exgJZPpUGGw20hRB0CLYbVfl8e/W7fV5WfeVP+bZQBgfD4y+G?=
 =?us-ascii?Q?iD3o8TfZFF97eMOudJAWnvPzStg66PCMp29l0HYa6YMPpbMA0sCBK6SiATSS?=
 =?us-ascii?Q?zWt2rnCZj4Rp8x96ZBIgWiv8AE1m5/bwRxmnrhCOBS2DsjMu/DPgInSpxm0L?=
 =?us-ascii?Q?hY6OKcO7AOhLi9NbzQyttm+uB1pI8FpQvNYS3qDWiAmQ4p/2TMXfAqPaC2PW?=
 =?us-ascii?Q?pHi8D367MxjEXBAO6jjWP0ff+1sVH4sGwVpP7FsFRukcKMoy7AtdHdJQLDKQ?=
 =?us-ascii?Q?9M4k7enNH6UOZ2JgGxDV/j8soHA1egutXdMSwM6Y3H+8MzOQ5JaL3EMikPiF?=
 =?us-ascii?Q?dbX1FB9lLrwGZekBMz8nlr8mLV7fZImOTOVTTk3+9yXLlq/Gv6UDzPdY21Cb?=
 =?us-ascii?Q?wMwF7JgMAFWHTDOIrD3W0mdMOWL4I3dOL2W/v8Pdw38xYVUfIfZUEouaMLQy?=
 =?us-ascii?Q?Q01ZPWjPx+oFtUBaHupXcPi8plWoM9E4btqIHuMAqEAOC70Gogic85zByJVU?=
 =?us-ascii?Q?5dCw06+1gam7ovSEXbplUlcnBgEpqKqarnoFVZFXad/Rl9djLRSN1Mqq9kTY?=
 =?us-ascii?Q?LfaMesLd3gqAXtsz4kqbztfjZ6ZdUgPuAHt1uguF60nbMxQTNXKubxF2nXGw?=
 =?us-ascii?Q?qn2c55gbrgiDYlsUtFHDUeuoJbF+xUCXx5DBDuEak0ws/Kw7Gp0lPR9oLJ0N?=
 =?us-ascii?Q?mmpLZPvlfkCrC1BEu5TP5hDQtHb4eCS4wugdtPC5EfCFOEUxbMWiNTyIFogE?=
 =?us-ascii?Q?U1NZZlGEfidFX5jFby20bHcOxpYTNvwsYz+QHqXBwKEhyCqpr1UgNZTGb8pY?=
 =?us-ascii?Q?BIAvvrS5qZrGYC7FwkacY7ULkWH+2CY=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecaddf6-17e7-458d-2bce-08da3d7a027d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:06.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ov8kJ3WUDgZBwONkW6HnWv1C1mBQnU5/KJ4LW4x/zFO45SegayKrMCbZJomnsy7JvVOhGAa5VY7Q/JXGlDXGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB1033
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
 drivers/net/wireless/Kconfig  | 1 +
 drivers/net/wireless/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 7add2002ff4c..444c81e3da06 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -35,6 +35,7 @@ source "drivers/net/wireless/st/Kconfig"
 source "drivers/net/wireless/ti/Kconfig"
 source "drivers/net/wireless/zydas/Kconfig"
 source "drivers/net/wireless/quantenna/Kconfig"
+source "drivers/net/wireless/celeno/Kconfig"
 
 config PCMCIA_RAYCS
 	tristate "Aviator/Raytheon 2.4GHz wireless support"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index 80b324499786..3eb57351d0e5 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_WLAN_VENDOR_ST) += st/
 obj-$(CONFIG_WLAN_VENDOR_TI) += ti/
 obj-$(CONFIG_WLAN_VENDOR_ZYDAS) += zydas/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) += quantenna/
+obj-$(CONFIG_WLAN_VENDOR_CELENO) += celeno/
 
 # 16-bit wireless PCMCIA client drivers
 obj-$(CONFIG_PCMCIA_RAYCS)	+= ray_cs.o
-- 
2.36.1

