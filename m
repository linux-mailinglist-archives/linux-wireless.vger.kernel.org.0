Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9895E1D94F2
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgESLKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 07:10:30 -0400
Received: from mail-bn8nam12on2096.outbound.protection.outlook.com ([40.107.237.96]:16865
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728625AbgESLK3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 07:10:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQTA+nORvbu6yH8IO3KwgTB5Xh0cSylbomNJDTYxfZeRSP+O5Is90M80NgwtLrVA5fujvAXYadj5cONgVUmJPAGKu4J+hQd7pE20zhcxnU0nPTZeiuz57nvVZSd5O6DTCBzLSwLfeyf/6tF800wV2KMiaZBT1HQjKgG8kgY503TOnidK+rSek+lx1eA3/vQGmEyW4nvNEptH9lqLvQ2ydBMpis4gMKeE2e5G1pNeS5RP8gvedP+iFVOxiuIKDWX8vIU1OS3RAJHVtP6bDtRnmNpJ06UvhgP3dmHsSFcZEfAXWl82is36lSFKO57AQTOe1sXqsypnL/izwAurOvtQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20D4lPd8XG8+TFxRLQPWnsT1/jy9mV551VGUjg2RvMw=;
 b=oKNJItBWLXhvte5jfWC38sKRlHPjpFCbrCLlWkvjN4cmCwrGwlOe8SiGCON8vpYISIPrhU3Lk364t8ZkxjDVACBgDeKWinSqDRhkXuxQJZUZ7VBwadW3yyDMS1AgHA12LF1CXHv74q4ewnFT12coFAYW3w/0sQ17O0y8eVeehad5lof7A5lehn1SgjRl7VQqINLDNPlSDjxwdic8+I4H516V0tgFI1m8g+92t/E1yKgHt4nSQWBdtsap6bKrdMvoMH+2E0Jcy8qheUkySZU5+Y5bgBDL7UOPw78iWVsBChwZ2DcOcHtrX8M0ro+G7uSQK7Om16I5M6XoZImiqttrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20D4lPd8XG8+TFxRLQPWnsT1/jy9mV551VGUjg2RvMw=;
 b=Ddiu6Uac4BL5Le+syD2KGbfbuV5jYlYNCzPzttw5Q3jfD56svOYCt2GoI8SNRjuYAwSfxT8j7qr+iX9+wBjZaEGWVw9E2C+CIHW8rHCQDf4LMt7WGElCneXP5YG76qYM+BEdD5Ti/wTThSy/aEkyNCGW1Bog6E5oVQm6UHbYHEY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4906.namprd06.prod.outlook.com (2603:10b6:5:56::11) by
 DM6PR06MB6043.namprd06.prod.outlook.com (2603:10b6:5:10b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Tue, 19 May 2020 11:10:21 +0000
Received: from DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f]) by DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:10:21 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Kurt Lee <kurt.lee@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 3/4] brcmfmac: set net carrier on via test tool for AP mode
Date:   Tue, 19 May 2020 06:09:50 -0500
Message-Id: <20200519110951.88998-4-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To DM6PR06MB4906.namprd06.prod.outlook.com
 (2603:10b6:5:56::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 11:10:04 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d99a9e13-0ba9-4c51-6ba3-08d7fbe52f20
X-MS-TrafficTypeDiagnostic: DM6PR06MB6043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB60434564C11F3EF705D9C496BBB90@DM6PR06MB6043.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGpyZRhzOGnoCmx5Ih9LAcDYqtyFroJTePr8D3uVsUUAvv3w+NGEl6TIqV257XQWyIhNlvUb4Rwc7Mt01CIX9wFmXA03cTGrTpSN5VSQRILXsRPIdKSaCOuLorsM3WLjXFdNBgnUDWUXlZWk7jepvrdTEbu1t1jzRp7+3M+nBOnroLZSch6cedt2RwD0x6P6YkHj7ANZw+fNoo5Hxv9H+Z+H185xUogTJLVpFOXiWiVBuO3dcwS9fNtQUOuIN3eSDhz6F6sDyCvVQrfZRMJJqJI1jAIaWy9hM2hBnZbH9jRRG3jScf7k6XtAGPEnjlxEyYj4nja09FnPTct48FU+g5tkwnw7TgFBpys0jiz2KzL0EpA+8xzJnf8+IBzI829TtxUUab0ac7tTMZMCO+4UIObyh6ef1hOotUzvO+hQuv4w+NpclZYZifbI+v2UFCZz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4906.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(52116002)(66946007)(66556008)(86362001)(36756003)(7696005)(54906003)(66476007)(8936002)(8676002)(6916009)(478600001)(956004)(316002)(2616005)(6486002)(1076003)(5660300002)(6666004)(2906002)(4326008)(186003)(16526019)(107886003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BhkXbMDDnrLAUE+GSCMkrrHGe2NGdRsYppIKK/s7rOkfHQr2ZnIxL4azfGbUajzpkpy5KZ3OsiynkSF8Ek7ltnhweNH3h/3z5b4v8Zgx33iNp8UZnUX5c8h32735v/S8k5EdnW00mF4XHEf2VBKn5Sep93+NygG7MpM0wcHpGZb/vrhTnOL4Y5MWtXRYhPKANnwma6B42YUpvOSIR1QL9eSdN5/6WPqgzleY8w9cj/789Lnn5CYAEPrwv8FYBfM6O/rWH9wrsW/nIHknSwsB0Ci92gKthjjrUxUrpdPTh/wMp/8p79FOAN7AVz2Wbhckd8Hs87fzwyx7oP6tDA4Z1QaUMG2QbVhsbUUYQfHmW/rhbiTqiauTiiRjfSMZAFP9KUzfmxRAlELfNa98C8+I0tzU6ils/S12wqSevGjjbFbzNRzCyCZUNBobcHl0muF9NCTm6F4Nixt8MpxbVJ9LRun0AQNpFc4QHYLY2gbR9Slq1v3Fj6ZfOERI7McAEHTu
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99a9e13-0ba9-4c51-6ba3-08d7fbe52f20
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:10:05.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gbSJWlZjWCv+blqweknUP52RA/KU0KLad1rMxcs2NjH9l+1AxYQLQf16wFu4Ip6gQbory5tLYwaxWG6x2kw5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6043
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kurt Lee <kurt.lee@cypress.com>

In manufacturing line, test tool may be used to enable SoftAP. Such
SoftAP can't pass traffic because netif carrier is off by default. To
allow such use case, let brcmfmac parse ioctl cmd, and then set iftype
to ap mode and report netif_carrier_on to upper layer.

Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/vendor.c    | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
index d07e7c7355d9..5edf5ac1167a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c
@@ -64,6 +64,15 @@ static int brcmf_cfg80211_vndr_cmds_dcmd_handler(struct =
wiphy *wiphy,
                *(char *)(dcmd_buf + len)  =3D '\0';
        }

+       if (cmdhdr->cmd =3D=3D BRCMF_C_SET_AP) {
+               if (*(int *)(dcmd_buf) =3D=3D 1) {
+                       ifp->vif->wdev.iftype =3D NL80211_IFTYPE_AP;
+                       brcmf_net_setcarrier(ifp, true);
+               } else {
+                       ifp->vif->wdev.iftype =3D NL80211_IFTYPE_STATION;
+               }
+       }
+
        if (cmdhdr->set)
                ret =3D brcmf_fil_cmd_data_set(ifp, cmdhdr->cmd, dcmd_buf,
                                             ret_len);
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
