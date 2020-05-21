Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 779971DC5E1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 05:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEUDs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 23:48:57 -0400
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:9153
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbgEUDs5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 23:48:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgfxmJ+2EPKPDoUySNoyi4crzoDRPkxTo4x4rllkHUDWGtrU6jv55vocfitMSgsc/9MuY3Cp3YJ6SvMoGjXMmgubOOhpIKwHTr2C952henvqldN56zej9DotgiDMl297XhKzZy2lJqCanhnwibXB2rrctj1WVVIxPM19at5GrQGghlu9W3To78G99pBOM6UijJfb70y9U5xjoPp65XScvIbEv/7Ji3fSFcL8CPiEkwPLzcSec4rMJFfHZ8ug/Mu4Q1E18qBetdwWE+anCPr1v8S8NLoCYJMZ+Tfb8ii2S6kQ6LGOxTibux6hxPFEjYjRtqJLuGM1BsO6ghPvz2S6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JnRgMvUkgFHYBytlNfECs1FdgxjPyvEf5Sy4Kq0C+Y=;
 b=nYcS+SoPksDXxDdKfguqUTSFg7p9PVe+QMTNvHGmqnnsnTZiEq8lNF9LvQGzFNdLjEGWxNCuB4djHrZNv/CbyGgV3zF3N+bgwQLXJUY/LVvFQr8I8NIKJlHsizPmp36xfQ7kRkn+eTkiNUlsi82slvt7pUNDe3bVDKW9DDasivBpUqeqn14Sd/TWzn+TR5Xp7+HFK8C3124Mms5CTt1tP59z2MwVjAIwmfsYy576Xjy1f7NaTayxvgK9Z7Wplhgi88WIZv4xcdvPkxjBTXRTjHx8q2l9rDLdIw/FGLCiaeP3TIwxEyu8a3V+CGIYNT3OEVuScF/q02oC4aIQ3UFZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JnRgMvUkgFHYBytlNfECs1FdgxjPyvEf5Sy4Kq0C+Y=;
 b=bmU+bleZ4MT0d/dOx05J4iaWCaPe4YjInfHkbXmaGIKA8yRcs/UXjwfatY960N9PT2JXjcIcq65u7aTiVrA6wV794xYbMRl++mkl0LpGE9koTL+MmD9DYDrxqw8kaxdWIaJYsKKQMPlRx7U60Glk+fFxbiM3K+mslBTmzjUYYp4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4024.namprd06.prod.outlook.com (2603:10b6:a02:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 03:48:50 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:48:49 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <double.lo@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 2/5] brcmfmac: fix 4339 CRC error under SDIO 3.0 SDR104 mode
Date:   Wed, 20 May 2020 22:48:35 -0500
Message-Id: <20200521034838.57371-3-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200521034838.57371-1-chi-hsien.lin@cypress.com>
References: <20200521034838.57371-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 03:48:48 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 879229c7-a50e-4bf9-d1c9-08d7fd39df0f
X-MS-TrafficTypeDiagnostic: BYAPR06MB4024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4024566DA0961B898BC50D30BBB70@BYAPR06MB4024.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5q4vSgg+/SbuCKZ2RgxVNLqgkhC+ZAjQB6f1hbx9N3BFUiMDrN4jKtOuy2bdJ/oIPMypR02QDu+Hn0XhZQDwNb3TD6EJcynHMT7UCwaVwmhEDhSpVVW8nRJ77i+mLljcfOo+spwS5C/HQk0fHT70qlxpqK3f57/LVf18pW/LiQodYpFzmc8r7e5vjmsrXzq5Owt181AyvrYixhygTFjJzMSOgjwR8MHog+izjDjHiCwvfqMoKb306rtL4hTAXpcsPiVZV7dmd305tjFjamiYNv7l3V2HG4sk3Nr0HA3ceEeMPGF/sbm2xpySIbzCA9j/WNlmiYCWEgKY5XaZAC3Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(26005)(6666004)(107886003)(7696005)(1076003)(52116002)(86362001)(16526019)(956004)(5660300002)(66476007)(66556008)(66946007)(54906003)(2616005)(6486002)(316002)(36756003)(6916009)(8936002)(4326008)(478600001)(8676002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Sx0h9CUAJMjqd12RwZepeagIjvTjyNRfhKXnYdCppFv5BDNH+uM2hjgIbBHuFaYb3DNDMBaayZOa8Yk0x2aic0lrAXGcq9Uc80XN9j5eahprY9rZ9d9NdowFZ9AVogCf3DzsMuDnN1cCMDtXUMraYGOrgkMgsSD3+IqTT9+MRJyipoZNwqdN3ocaBxvk2C5SHNv3WHFxCW66viSFdYWYHZOyXBoynN4wTkIrFJC70aobggb+pSi8np8Y2BhnCTKy1aF5RzcjNHNb5qemVUmp77/8k4YVgwZIcQMVgjTeyqQP9yjl8WCvqkMnOYdQp2rGO+nWRnDUUVP+4BK2eP+IT6RAtTA5ONljiLeezCKifG9qEH0XUk7BIzo0GaFzye883SCdWufpAPn6uPnvvC0oYeBQH4K7Pxdegy2gBp7/vrwbgISc2KL3dwsIqHHPRoXcp9YDrlfCBRKI2cm5ZHl43DS6eBwSsda1MboGGTd4D83/3iNicpje3PsQQzLI6MQw
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879229c7-a50e-4bf9-d1c9-08d7fd39df0f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:48:49.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oeclxuq/rcF561mEvlZDzdYvcTWYHW+DzdTokYkJGOsaUFkjh0Aect+z0w1stYtUpFFG1NTyQZan80tbWOGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4024
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

This patch fixes 4339 CRC error while running Tput test with
suspend/resume test script.

The continuous failure messages before system crash:
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 25600 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 24576 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index dce22cd2279d..491b635e72b1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -43,6 +43,10 @@
 #define CY_4373_F2_WATERMARK    0x40
 #define CY_4373_F1_MESBUSYCTRL  (CY_4373_F2_WATERMARK | SBSDIO_MESBUSYCTRL=
_ENAB)
 #define CY_43012_F2_WATERMARK    0x60
+#define CY_4339_F2_WATERMARK    48
+#define CY_4339_MES_WATERMARK  80
+#define CY_4339_MESBUSYCTRL    (CY_4339_MES_WATERMARK | \
+                                SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_4359_F2_WATERMARK   0x40
 #define CY_4359_F1_MESBUSYCTRL (CY_4359_F2_WATERMARK | SBSDIO_MESBUSYCTRL_=
ENAB)

@@ -4209,6 +4213,19 @@ static void brcmf_sdio_firmware_callback(struct devi=
ce *dev, int err,
                        brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl=
,
                                           &err);
                        break;
+               case SDIO_DEVICE_ID_BROADCOM_4339:
+                       brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes f=
or 4339\n",
+                                 CY_4339_F2_WATERMARK);
+                       brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+                                          CY_4339_F2_WATERMARK, &err);
+                       devctl =3D brcmf_sdiod_readb(sdiod, SBSDIO_DEVICE_C=
TL,
+                                                  &err);
+                       devctl |=3D SBSDIO_DEVCTL_F2WM_ENAB;
+                       brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl=
,
+                                          &err);
+                       brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+                                          CY_4339_MESBUSYCTRL, &err);
+                       break;
                case SDIO_DEVICE_ID_BROADCOM_4359:
                        brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n=
",
                                  CY_4359_F2_WATERMARK);
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
