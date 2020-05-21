Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AA91DC5E6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 05:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEUDtd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 23:49:33 -0400
Received: from mail-dm6nam10on2131.outbound.protection.outlook.com ([40.107.93.131]:18624
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbgEUDtd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 23:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lqi+kSM3yS9iyxQrb26LScDt7uupDTdF47bd7WbgV9hMnnOWuJEXTKu4nFAuEx8XQUDfjT9AYII4PEZrQKB6jEIlbZ+ADvK3BVeHKGm6NWmXCOfKF8sEeC1LLHA5Getm81fE8DMca93l2WRtQ8AVy5IU7Pra+9dEoI1D+0IqxoKwrw6U4Q+32wvK7u8pOuH+yj7JA4kcv0zISygZT/wMlBBQooap6ZyRlD7szN586peDGBOQXiCIciznMt0Q79ZCuJ7MdgNmIYVCyXfPmBo5CYxksHIfhADxCMnpmmppQYsQGYz/8TUU5FFEpfixTmirQigt2QidkAmX0q70sK/BbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX3iQ2DfxMZY3mCYYTVfnfDeIozy68gBAp+aVCUXzOU=;
 b=PYaxpHRPH1+bkEl0c+CTkG05huwY9b4Aj2U0Gd8T277drXJ1E4qnDA84kvbVVLdzNxchKgIuBpbYwbo/g8YzuS2melAKvCsAMrWSFYHdrtKNAj0FGCmbkjqcwrLQZoWlfiiFULxYYlfxYsj0uHdrUPb4QSg2uU4QXQKL3P4OrK/Eyis3tFyjISMBwGEeepRxvjUbyjAne9gaWuky9TXwMnZdumXbcZxrZc0fzhDqMHIUY5ChCQVWdIBm5TdiWw4/zvUWAriQa0ppwN04T40W5+wUyC7npvEf8lB0SwCsOj9rcZDxxbEciBbmecLfVC6evEYzWOqzKg1Gk3Xkc9g0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX3iQ2DfxMZY3mCYYTVfnfDeIozy68gBAp+aVCUXzOU=;
 b=mBFXcMgy1wb+78sZy2XofdqFsbDjqOTvjW7nQuNRv5+WS8TgeQrSmpxn5xuYSSLFX9oqFe0VtE63eHrLwupyjHt1yw9Lvsomnk/ysSdHHge6lizOyha9pn0KeoqRZay0KGoqq+qdATeLUwzG6/cafUBK2InHFQHbKzPgMS5WgoE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4024.namprd06.prod.outlook.com (2603:10b6:a02:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 21 May
 2020 03:48:53 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 03:48:53 +0000
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
Subject: [PATCH 5/5] brcmfmac: 43012 Update MES Watermark
Date:   Wed, 20 May 2020 22:48:38 -0500
Message-Id: <20200521034838.57371-6-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Thu, 21 May 2020 03:48:52 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 348d704d-59d6-43d8-35c4-08d7fd39e0ee
X-MS-TrafficTypeDiagnostic: BYAPR06MB4024:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB40247B2296F68EE1BA1F5BECBBB70@BYAPR06MB4024.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNYSy1/4FbY9leSWHfSVKerlHrGv075AzK+3QgtvutleAb9jQRt8MOe+HNYfCLfWXZBMfmVc4uEEjSHvtmuchIt+hZIiKFWWMR9Su7FJP/kO4UQh15YnmAHuoPfa885j2Ri3sILoG7sDLSvcg94B97NCCam2hCrE6fqF3/E1jV7c/qp2EmvgjqhoXSm4/AEApvg2zkoZpEIl3Oy0iZjBeVL+dtyYmtqi7UDc31jWPmUdlzVitwvwoB2DTOq1Uu6nrezeQGK50M2EX807ICSZrJQHFhRttV9NETmLWdGKNPXJTtAzITI0FUUa+0Wy5Sz/+hgGZQy9hCbqJ1I8qZrDfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(26005)(6666004)(107886003)(7696005)(1076003)(52116002)(86362001)(16526019)(956004)(5660300002)(66476007)(66556008)(66946007)(54906003)(2616005)(15650500001)(6486002)(316002)(36756003)(6916009)(8936002)(4326008)(478600001)(8676002)(186003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3HOO/ixBxgV6wSSrkyyLBesfUwXcxgXAWLN+84RI22A/DI6EmynPX+IWb6wmpToFpvoMcn/Zvn488fI8c46QU/s7x4KvSwUJQujQalVI8utvitpPJGBmcGq33PzlnWCqWQ5AVzrbKBGesZmsoABbmoAJ8Cx+vHl0V45FDTSsv/p2QaspTjRaqmX89JfP6G62Wgk2tiTe/CAJIox/hQqwFxniiylL5o2fJgncpaSjOvU1LyDDNQ2YeoEILsc2DVd9ps07FDYMyN8cVMp73rZ4egQj/96voyEbXTVsgRLlvWb00GWX2jNFNzcqb14hoHCH35oZ5PwPkjAhm6C0AitrR0hHZgBH+IY5vqvEP3IjuWUH2Mw0JEwP/uEEW686gSBZ6kQYp/deZkIzvfI1VuS+SfFYy0YWqfpqRk0blQEe5kZs8fahJkZ867vOjuBxKvIy6wT1mutK8oP//0mHOZXcJqwtEEAF1L3FuiVWYMmk0/5jLuIqZ/gcjZkXoscqpmY6
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348d704d-59d6-43d8-35c4-08d7fd39e0ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 03:48:52.9402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 218rxy+oWkXPtDCHy62H25c1r2YmxxcysU8cFFxr4q35SHzEbcgIxBtALHhaHciLFHx24XuQtExQEDdEiCrlyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4024
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

Set MES watermark size to 0x50 for 43012. It fixes SDIO bus hang issue
when running at high throughput.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 58d9f0b90ad3..760b7737e745 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -43,6 +43,9 @@
 #define CY_4373_F2_WATERMARK    0x40
 #define CY_4373_F1_MESBUSYCTRL  (CY_4373_F2_WATERMARK | SBSDIO_MESBUSYCTRL=
_ENAB)
 #define CY_43012_F2_WATERMARK    0x60
+#define CY_43012_MES_WATERMARK  0x50
+#define CY_43012_MESBUSYCTRL    (CY_43012_MES_WATERMARK | \
+                                SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_4339_F2_WATERMARK    48
 #define CY_4339_MES_WATERMARK  80
 #define CY_4339_MESBUSYCTRL    (CY_4339_MES_WATERMARK | \
@@ -4217,6 +4220,8 @@ static void brcmf_sdio_firmware_callback(struct devic=
e *dev, int err,
                        devctl |=3D SBSDIO_DEVCTL_F2WM_ENAB;
                        brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl=
,
                                           &err);
+                       brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+                                          CY_43012_MESBUSYCTRL, &err);
                        break;
                case SDIO_DEVICE_ID_BROADCOM_4339:
                        brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes f=
or 4339\n",
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
