Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7BF1DC5E5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 05:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgEUDtb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 23:49:31 -0400
Received: from mail-dm6nam10on2131.outbound.protection.outlook.com ([40.107.93.131]:18624
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbgEUDtb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 23:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0POGjbPGZVbB/cx0pXnE4t8XbKRWrHCpHdZ6422fwecE6SDRCmSt6IHj4QfASsFwfxXsxA2PUIoLdar/eFYibxU0a/MGcSKOWjpQSiZom6lTDhMEf/qD3CdWUPuN+s5ER5Ked08sDcJswUOPoCD5KeRZMPL1woyzqceQCScFIzOJ1gbUF091mUzkP8qyRatnyhK0hprK6AkhVuCypX3vyM60oj0QZF+YD3w1QQTpPfT3CoRLMD0kF0XG6kjFmhBr4CE3HTyFUcCUXmJg26Vw7IEhNhR7Kvn/QmEHKfth+Qy5/4VRv2GwyCiibtt1mGMcVoXGcrNkK8ZhF4XRL1ljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH1LUDKud288xOqxaG2LiseQ5gYcP18B17tmc+duFg8=;
 b=mFa1lqfa/nM9PfzKwJnZHFEDsP0npRQxK1u9ZdZXyMn9uTjvK40pKtplTz5WpkryUir2EMzSVLWOrXoCaIP5xxp3KOY/FQXgKhQDahT3Qj60+TU4abAOvkp/Dqih1Y3ye0XXJgVa7Zq1EazH8af5de+8NktwxquJ8MKQPAvZ4/VflgexKyUCzwZ67ZSdh9+rkFat5ecdEvDKwmJZxkgBSDPksjEGEsidBUeW4vMZ7O7MTXveUrwgGaGbI8FIlUK9SwriKs3A1gc5ql/jJr2+c4yKCK+C1c+Y9mPdp42+zVjaXkMkK461Vastv0jCtO0wIfUvby0PyBQf7MQFQEZQ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH1LUDKud288xOqxaG2LiseQ5gYcP18B17tmc+duFg8=;
 b=l5cj9vE3AZ2r75KCIfs+zXvPyn2vuTaL7ZUftae/AABRE6C46RCs45SYr8dIhYzybeuKJuBmy4Ksvpcn+pCCn+T0kLTrEfMlfFwbAIaOzBNh8nGsItXibIJYFUAjx8v7gPQ+69KvIpC5ZW89vNHzpj2JxISmBxJll88p3lGk8KU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4024.namprd06.prod.outlook.com (2603:10b6:a02:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 03:48:52 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:48:51 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 4/5] brcmfmac: fix 43455 CRC error under SDIO 3.0 SDR104 mode
Date:   Wed, 20 May 2020 22:48:37 -0500
Message-Id: <20200521034838.57371-5-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 03:48:50 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1c54c56e-08a2-4c5f-691f-08d7fd39e043
X-MS-TrafficTypeDiagnostic: BYAPR06MB4024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4024381DA84547AC4909C81CBBB70@BYAPR06MB4024.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qN6ErZGrFuQbXJHr9cR3hD4KEnAhKrEya1ufQpOfFXZEPnQdBN2grTeh0PDOVHBpJo6J3uFNFgR65IF9IWuN/qVbkKWH4/XTphkpnDGR26c7XhyzsQ/2YZpXboeItmmf4/Me5jWAPlQzb2OToNL6MCadIjLqwv3dtBeZie/0gp3F4cFMYRkdpOyVwTh29nkMXmdq34cNym2VKKrNHYjwOVqv8IPI6wtPoy6dhufS7Qeaepe+Bh34hUDZy3IOr+SPxhLMF9eRciicII6+qn4Q3lJXngWDoRVQYgDzA5Z4dy+pmhVpVzvOmZu0CJRsuH201b716erMu8sUbyOlOeRQlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(26005)(6666004)(107886003)(7696005)(1076003)(52116002)(86362001)(16526019)(956004)(5660300002)(66476007)(66556008)(66946007)(54906003)(2616005)(6486002)(316002)(36756003)(6916009)(8936002)(4326008)(478600001)(8676002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: y9slphLvlzzLdd4KbT5LkCBPyPxinVLc33Co8rz4JhF5mhR7/hh6XOmoUKBtclRvskGLHOyOn+j6vrENfo5leTsaQZHwstEeTN2htwWCfXrVcQLCxs1cESzzVYeufywOMY1VjEjnGocbUIrIPT4qyXbwXuGIUzUvkPwCUgMAy0BmxM/c50+F+oHm9qg/mAozU7T0ZzG+dAwo/4/9/8kkG0mESGN7ZucPhHzfMtFftLfczjLABiduKkqedHhATJZGU3sdDzgLqKaI1gX9lhWrvf54d3W4JmmvADhemwrl6Di0YdhgAXzNB/MsdIf8FjnqNvqFWk+vAQFP0RjujNw4HNrT/B2ritZoLGKQjLlKs5CgJ+F7r2Jknfj2LdWQF9cVm0k0IOySHFgS46R/5cZF2OmwU8D0KbBvdm/SgN9hT4A09k+D9NxZYAF7rDsbZAIP21zazvOrUYsPrkMOXgJOdCXSVZpbQNORR1G77XHxABtunos2E4Ct/qOuiR53+q8F
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c54c56e-08a2-4c5f-691f-08d7fd39e043
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:48:51.8029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma4BRFfF6PR8mAkxnlAXLqwHjyHhgZJp5lo6YpKDjxlIvsz5o2dk7p5X3LK1reqzcff54ez7hrqq20/CSxFqkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4024
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

This patch fixes 43455 CRC error while running throughput test with
suspend/resume stress test.

The continuous failure messages before system crash:
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 25600 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame
brcmfmac: brcmf_sdiod_sglist_rw: CMD53 sg block read failed -84
brcmfmac: brcmf_sdio_rxglom: glom read of 24576 bytes failed: -5
brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../broadcom/brcm80211/brcmfmac/sdio.c         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 037a4efef924..58d9f0b90ad3 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -47,9 +47,14 @@
 #define CY_4339_MES_WATERMARK  80
 #define CY_4339_MESBUSYCTRL    (CY_4339_MES_WATERMARK | \
                                 SBSDIO_MESBUSYCTRL_ENAB)
+#define CY_43455_F2_WATERMARK  0x60
+#define CY_43455_MES_WATERMARK 0x50
+#define CY_43455_MESBUSYCTRL   (CY_43455_MES_WATERMARK | \
+                                SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_435X_F2_WATERMARK   0x40
 #define CY_435X_F1_MESBUSYCTRL (CY_435X_F2_WATERMARK | \
                                 SBSDIO_MESBUSYCTRL_ENAB)
+
 #ifdef DEBUG

 #define BRCMF_TRAP_INFO_SIZE   80
@@ -4226,6 +4231,19 @@ static void brcmf_sdio_firmware_callback(struct devi=
ce *dev, int err,
                        brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
                                           CY_4339_MESBUSYCTRL, &err);
                        break;
+               case SDIO_DEVICE_ID_BROADCOM_43455:
+                       brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes f=
or 43455\n",
+                                 CY_43455_F2_WATERMARK);
+                       brcmf_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+                                          CY_43455_F2_WATERMARK, &err);
+                       devctl =3D brcmf_sdiod_readb(sdiod, SBSDIO_DEVICE_C=
TL,
+                                                  &err);
+                       devctl |=3D SBSDIO_DEVCTL_F2WM_ENAB;
+                       brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl=
,
+                                          &err);
+                       brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+                                          CY_43455_MESBUSYCTRL, &err);
+                       break;
                case SDIO_DEVICE_ID_BROADCOM_4359:
                        /* fallthrough */
                case SDIO_DEVICE_ID_BROADCOM_4354:
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
