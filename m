Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6721E73E1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 05:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbgE2DuE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 23:50:04 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:15968
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388127AbgE2DuA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 23:50:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf4LHcAgn94VzfzLPx3H8rZzipG3FAY7oXOQr7c7TlAyYafcjpRHL9YCVqZ5ejSG+0aPMZXTOWLK6fPU+VD/lOP0qEWnBGO5d+SiI8gZp4mYZFkiG5uqioKw8PK1kEmk8fHPWACxFsqM0AnIRroix0KbogvpQo821L/8Y4BJVOWPP8al7HwE6WSTHfBS1HTIREMA/+DO88t8T0a7E7N2fSwoWQT53dv0D2RwkXghW97mW/ihOtLZpOyixCXVvXcZwG4XtQUCMmNKETJQ/GTShC+1nVgjsJtmBkucaOXOV12x2sZEwGkf3MlFJT80sAYmt24f5YlhswWfRxIDxLcJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHOIx0TG6hJ1+4q9r+fXISUcVyO1lvCMzO2bdSqqzqU=;
 b=eVpdf04FyqwjRfIXbaiz77jOQl4EgRZN5xTBZagKbK4C/0HQZSkLZpoj9bYK/XxZ0Y8ImQ8L7DVcLEW8Lnx/DuTEk3ti3BjRdtXG865qJjFw8ErGrNSLXGtY9mcbpB8UwQesQa800LZZQMunz07sg49r4coMssOr+2ylIU1ifNL3/GcKne1LUbErY9EzQ/ceMNvIUqzUoYLcZ2vdKShcULLYrTk4dj4OIU5lMgvdzBJSKqUZLxGiSOWx6cm3+pA5XC5pYVfRBih28LeOCe+g/0hHP23JQ0GewuDVa0fjeWF9YhYwH4njtJctuElS2MTZpR7wEuk8B0iLTSRjF8GZ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHOIx0TG6hJ1+4q9r+fXISUcVyO1lvCMzO2bdSqqzqU=;
 b=DUY7PgWWQBjSrjGtGQC8zJn/yTUMXX6K2QDlLzWg/CnzW9swHXNwp0uWtd9h0u0QJSGa0nUigIHRKAnIdwZnj4zvzanhZXfG7HCp9kLYNCaUGfPvHcCrLXqubn7J1LT9BswV4s4Zl9luU7feOsSFXjkgzDns/Bce7u0KvJJiPzI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4839.namprd06.prod.outlook.com (2603:10b6:a03:77::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.25; Fri, 29 May
 2020 03:49:51 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 03:49:51 +0000
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
Subject: [PATCH V2 5/5] brcmfmac: 43012 Update MES Watermark
Date:   Thu, 28 May 2020 22:49:38 -0500
Message-Id: <20200529034938.124533-6-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200529034938.124533-1-chi-hsien.lin@cypress.com>
References: <20200529034938.124533-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::49) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0072.namprd06.prod.outlook.com (2603:10b6:a03:14b::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 03:49:50 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 031ee933-bbff-4402-a130-08d80383574a
X-MS-TrafficTypeDiagnostic: BYAPR06MB4839:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4839DEE1093AACB6A4B53C14BB8F0@BYAPR06MB4839.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3oudXht3XK4j3MUbzbI2PpO8RlP7i3QucyWtCgwdQbzE7iXlMk5xEpn6w8xPTwEuW1fRmPrxaPrNjvhgigRNjon3n9KtzwFERJtG/fKJ6od7XFaRK+wLgwc52YlxPnAez9pYqnnMy+vBq08Pbpa7f9TVgZDhbMJVa+CK02SF8WH70uRjCY9u6NIIZ9SiFNkcxDFQyg30CCMZpNnNHbJHKF/N8v51FjPAgmupujtzXSP6QoIxdVaW72wIW+UcvV7/Lk04OLTDJEDPHJ2S/X8HN3v5z7envwGV4hzzJWXUhkc8cmoAlf9Up/MFuFFvjgR9JYBhSwfBuvnrwx7m5EEIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(376002)(396003)(39860400002)(66476007)(2906002)(66946007)(52116002)(16526019)(7696005)(26005)(186003)(36756003)(5660300002)(478600001)(6916009)(2616005)(956004)(66556008)(8676002)(6486002)(4326008)(107886003)(86362001)(54906003)(316002)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: GAvtu0hxsAntyOJCQ42oJolBcJ4FY94ALarhMlgLvlL93ub2EgJ5lFvLRd2KkUrLc6b72YA0h1nJwDGPDXMs1u+a3yjrHKU1o24AH1KcspvQyEuumbJc+s1DDs3HYeaYnAPNf0aRTLU2yectGrhGXADU+rmF4k5io6ka7syj9M8VfZRiy7DT7IVak9T+lmJLvkEKv0PyceFB7UpRl3wFsrumCpOcqvnWSAz/s/RK5c4oNIjyTAXy9jLKccwY7ekOuIZ+VXEUFBRBJdwKQtZ2lsZhznCPL9lhiUmONiHF4xC0AYX5Ydj23Ptrs/gQyP1o8w9kTfFUoeFsUtfyMXtfBFL7FiZ4ggkUCRe4wcTyKHZreFSp6cPaoeEvxl5NUysgZRv7C1Wbz+m0lylX1SV8reoAJWjXwluk/cGoswZCniy9xDByeG0/OEuzuvJR3izrjFQfM7wDiG2yP23CGQmkVUZu1l4gBANcHGNK7a60uIMtG/PV0Cb3UEvV4iCWBXuS
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031ee933-bbff-4402-a130-08d80383574a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 03:49:51.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TjjBO5vYpqa5uJ/EbGtdAOwcTGkm9mi1BQWnE/FIXi71Hx74wozS6+kamA1H+jer3mnvtpx/qD4u7JenY+3VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4839
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

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 58d9f0b90ad3..760b7737e745 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -43,6 +43,9 @@
 #define CY_4373_F2_WATERMARK    0x40
 #define CY_4373_F1_MESBUSYCTRL  (CY_4373_F2_WATERMARK | SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_43012_F2_WATERMARK    0x60
+#define CY_43012_MES_WATERMARK  0x50
+#define CY_43012_MESBUSYCTRL    (CY_43012_MES_WATERMARK | \
+				 SBSDIO_MESBUSYCTRL_ENAB)
 #define CY_4339_F2_WATERMARK    48
 #define CY_4339_MES_WATERMARK	80
 #define CY_4339_MESBUSYCTRL	(CY_4339_MES_WATERMARK | \
@@ -4217,6 +4220,8 @@ static void brcmf_sdio_firmware_callback(struct device *dev, int err,
 			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
 			brcmf_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
 					   &err);
+			brcmf_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+					   CY_43012_MESBUSYCTRL, &err);
 			break;
 		case SDIO_DEVICE_ID_BROADCOM_4339:
 			brcmf_dbg(INFO, "set F2 watermark to 0x%x*4 bytes for 4339\n",
-- 
2.25.0

