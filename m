Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD983AB935
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhFQQNc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:32 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:36933
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233892AbhFQQMO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkErqSF8Aw2m8+v0a3qCwq/wZZov8U+JNVYmUFi1q+EfiCP6ZXYjZ2aGOQFPjw7p/5VnkdRVx2lyuw2JkgpqNl0ytAO/ZNOqR4iKEE+LCAZQ76ChRcM5RUXYQofCcMJZ8NaSjtFwcaiKUAQTavl/nf7MHdCSILhZE+uard+mA4hFEghaED7hkJMUXraMcD9v8vLprG5NBVfr/ESsUhZYVOfFPC5Ax8ubGo9DWmpgg0bcdD6hqNhTfuAJyaMSRDFX4wpwsg7nWzkBPMISodhmC72BKNfwRi2akoVToY8iFTUukPap3RL771g/UKjVlEQecEX3siZ309Hn6aHBfl2SdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1C0PNNs5F/g4Zka63Ki+DKHk/mN6+BzslnKXLFuvY0=;
 b=CpgB7e4RQ15kiZ/3wvKxBg4VMLI5aPlRTxzKinA6bwxCH0HYSQpXe8w05wt2jD6c7bFJu6zacyYTsaUv8w976jTxEwaYb5qQMcHE77SmJiT35nDO0E6oSb2VmoEosXIkTGTEkbeTbLdMk5SxYPDp2pUyR7+NCCjs+XVTjnCz1EgOVoD3Zs9G7CqwV+iy/QHUTGHNOzIWS/FxZpId1Xrg3pgKklLqHo2V+t6TX4OMo+S3TAN+LFnqrrGT3ch+qCs41WRT6yImuxRD64EZIUTK9RvAHiHCRA+DQuPdOR3/lvXMIYbazVsm+Dtl+knVrpJnxrtj7xiwuDMuX/4seLvZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1C0PNNs5F/g4Zka63Ki+DKHk/mN6+BzslnKXLFuvY0=;
 b=QU8HdfsssxLX1GtNXIBI8TFwQVJs6782nKzWIk7ls8fQZIRxsuRw2IDa83WydRBenp1UK5EBmwr7qbG1DgdpEGBOfz7YwXRmicQlTwnQqvOcyfEA17bnUINb5tnojZjGlyVQIn1/W7LGYTwndNgKDcefaxJ7pRzrpT1b2elf6MQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1014.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:08:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:37 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 256/256] wireless: add Celeno vendor
Date:   Thu, 17 Jun 2021 16:02:23 +0000
Message-Id: <20210617160223.160998-257-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 359411c2-f2ae-4bf4-60d5-08d931a9fcd5
X-MS-TrafficTypeDiagnostic: AM9P192MB1014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB10140EA593A1647DC27E00CFF60E9@AM9P192MB1014.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xw9UInACHGxvUOZz6jlx00eK9GjQYw1lnaHH/dK8CSdSLe7G2G5Tcz57Xwia2bKQWEJsBWkjFB+1a6eGB0J57Gbs7eB3fEC2ASKfyx5DYcgwzHSku/+KUvoBvGGs0EqTo8YYqjnlLSexuThlRdEVeBph4E0tgYYN8Rd3/g3W8s+Hl9PLLA1UY48gzyL4H7GQ11NNVkyUUpDH4KTz0r8psHZ+CJfQpLARE0etSoq2CcyijvxA8UtoN+eSDtN+vKfQAeXBce0opZx+fL8MIUjpJQCM5+UY1TDSyFP0foUaqwQNmeDhpyOyZmuh90utZ7c0Sis0iUBa1EKqG/e140U4IFrfBYLexdAyD/4PKNRKcDMAxh82Do7Q/uLKLYIDijufSD2pWTSE8emvozHA+b4PmszhSYdkoXvK1LpzSvb3upcpuOMZ2lU2kW1eCmn4MSXnaJYaGSiulOCRH2WjfLWL4bi6Km98ENvaM3Jg++w/DAi90DnDs5ZTDzESAkQXAQUfU8SmTy58e3k4whBEPRomZywH95d+TG+B5OZhfB3C/nsapvixTYvVFfxBox2vG1/PTlNLO9D15nZifVN0m7WOMLy29YWylQvGzH7Dna+qKNwiZRbPepfmN+GJfA+ot99zEt3RpcEyJAZsuU3cMYEg2X7+NnoJ4xRfOc1+Gnm5ioB5YLj2svmbX5eAXroK8VTE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(346002)(376002)(396003)(136003)(316002)(86362001)(66946007)(54906003)(4326008)(956004)(55236004)(66556008)(66476007)(508600001)(36756003)(8676002)(26005)(2616005)(5660300002)(6506007)(107886003)(6916009)(83380400001)(2906002)(52116002)(1076003)(16526019)(38350700002)(38100700002)(6486002)(8936002)(186003)(9686003)(6512007)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WbAAUbPguhGVLw0lJrAvhZVcohI1FMJbikK3QRb5JWgc5zzfbXu9drdGtsQg?=
 =?us-ascii?Q?m+clXcI0R2xlnMNSxWtDFNxPAp4ZqUtC2wG/Xx3L9AHoHQrLd8/U+Br/eT0+?=
 =?us-ascii?Q?/AxE8MA04xONwFT7VygMDgQLsjBIkTRvQTA9aWHITkQUl7oR8chDVk3pB/Nx?=
 =?us-ascii?Q?/h3YYgK9sKLUxI9n9E3xIQaLV4kwjonhYtvOhhTov0ed/h5OjGVJZCv/ns4g?=
 =?us-ascii?Q?CeJ2s446AqY93tLv0NqMTbPIY7gCUciP3EtbbniGT35E+IVr9PReNlvoXtYk?=
 =?us-ascii?Q?U53HUrORCVmMwqNZrX8jV29OlaI8GVOydQvqFLJ1QzUgVv8boJmxEVJfPznw?=
 =?us-ascii?Q?EhiY8wKtbLQy9wcHRWyeOxupRibOS8CzF9ahhKbsRo/qGh5LXPpiXWCKPR8E?=
 =?us-ascii?Q?nQifD3hgMsSeNBmpLugel3D9r+5LEfG9IxHx8Oiu97vuPESpHpfu1W/Vpswl?=
 =?us-ascii?Q?gVA2MFI4Og8cLbWxpo43U4QmMSGa7McLyTE4tQ34vImgim0nLtO48l95W9ga?=
 =?us-ascii?Q?+HXUETk1f+IcvLVHAT+kEStVyzGwyeh3ZsZ9YjB+ONKEEA4oL1Wuq5QeeBEp?=
 =?us-ascii?Q?q8xm+4lA+KHJ6cHHKF+jmbNuEIwBgQvxPolhZ4hxKjJHkLyKK1tFlVwaQwz+?=
 =?us-ascii?Q?2IOmIB0DpT9k4DAQxDuKkvkQRw/yAhcOQpuq5HWJZxFar7v47zMS3X3OCDLc?=
 =?us-ascii?Q?8ksrMFxPpufWCNMJg4mEEGAiAtik241YG0J3uGoTO6Uc279FUtXipW1TDel1?=
 =?us-ascii?Q?ep1qDr9GnuLDZi/ccNugYlMA3FHTVKMcb2sKM6Su62Uq57QTwg2YSMUByG53?=
 =?us-ascii?Q?vy5z7ubwNoaH+3DkCBOTLMS4KOXxEupB9SmncUWOphr7sLjvDQSb/xs/Z/F1?=
 =?us-ascii?Q?e8njz59V6hg/NPaU1f8A6d6Y2rLF6bGatGNAf9/Pw7EPp6c8VQ8TSU/Pq4k+?=
 =?us-ascii?Q?XCs/L9jItFsD67XtOTmHj5TznFZm2HNnqGcBmiWDulgMNx7jRZ6Gq8SppKLa?=
 =?us-ascii?Q?YdSK6G3yjadGewhK0JwPeujzOaDbB0uPgfVm3LuGCD8kO7x3vYS+3wVGoM6t?=
 =?us-ascii?Q?qNAaOU5x4WuTmnqEpPhwc3ert8LtRfg0fNQ1FuIB4wAlJiBh+gz8aKGYnjYz?=
 =?us-ascii?Q?UZ66FXcb2X/KG+3ys5cO/NL8vPLP8qPib2NBKT52e9jPRHpYAu5ErNGP95Ws?=
 =?us-ascii?Q?dgK1fBtd503P11/FfThsWppiqJWojZxqRjPYpdx6DY93YKlKXUCIZsYficqT?=
 =?us-ascii?Q?xwVRktvx8UVWM1ckMvclibeL0GmpLw3erX7q0NWCOKL0aMLu7RdfH8Bh6hV6?=
 =?us-ascii?Q?tYsFlfHQeL9pLx3wQ86TcNwl?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359411c2-f2ae-4bf4-60d5-08d931a9fcd5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:21.2195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HM57R6EZt8uMehErTUqJLZCFQau8eNLl1zv2YIVwsVYvTUXUo9DCItD3TO7X1TCkuNdDBm26PGutVMYpq0CHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1014
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
@@ -20,6 +20,7 @@ obj-$(CONFIG_WLAN_VENDOR_ST) +=3D st/
 obj-$(CONFIG_WLAN_VENDOR_TI) +=3D ti/
 obj-$(CONFIG_WLAN_VENDOR_ZYDAS) +=3D zydas/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) +=3D quantenna/
+obj-$(CONFIG_WLAN_VENDOR_CELENO) +=3D celeno/

 # 16-bit wireless PCMCIA client drivers
 obj-$(CONFIG_PCMCIA_RAYCS)     +=3D ray_cs.o
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

