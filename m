Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B749715BAFD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 09:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgBMIpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 03:45:24 -0500
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:59328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMIpY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zswzb+0izLQE6uKVsaamOqHJlTf6jaffjliFfUer5ttIpB3R9+nu+2A69C3aWeV19mtkiyf4gGK5qxz6hUGdIL695SLAFKZMeBKMDljsQzeeNjlAhIeEPJoz/0ZArXFNJI3LTAlXxbItu2xrpbsQ8WlkUH7C17BCL+q4QW71TMhGuAb50iAjrX0eg8mqADIzSV95y/2S3GZ/szMrU7WdJvryTJgj2pEhVRXhiSrBwQ8w3dsFTXLgFyfq9LOkWh2XOECT1ozeJmKH5Gh8gab5f1whBIVs/97GumGA9cwv+lkHRHd1rd2wYMhsLpRM0m+iwO7bOee0NN4EuyT13nx7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVwKgTRJ+ZGENUgkjH6k1eLuK8rNyFEdHOaSWhrh/ZY=;
 b=I4qgJcGLXI+XsLVyYZAUmWar7WyiaClAi9QwpblnUmwsdEcr3NXzakByokeuxedtHjJdzMwatWL25bUlUX5FUtylcDs4e25VikzhDI+QYWaSXYGAf3jxdjTgtkeLgPgMGtSpvdX30XsBFu6BjrX9egG7KVF2tmXFvAzJMdMI+0gfW1cV1vwyfiWGVW4cAQZcHY4OLBMf7/LeI0CKYKdFrmrmIqiVQ2/NE5a9ZfiRPmCUxiAh3l+Q84tza4A0Pdb1tlsKcA0TLXbk6Nw6doRa2HG8XPG9z3dgRB8zI1BBzP38bqGdrlvWd1VU4SPVrDOFhUQjdIiowojdOwDH0YGXbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVwKgTRJ+ZGENUgkjH6k1eLuK8rNyFEdHOaSWhrh/ZY=;
 b=Qoo08IP9zdraGYZQiLlRZzaUTyCIuZkvzognX99vYx5OmJA451X3N2iH0+XUBFP7ylIFyWDdzWJgRDBQxU8W+8ayK3HHAGkatFYGCX5UEmSj+riNVr5PgfeX+zLEQp5Vkdwe15k+7lWLykPwj5xmj8oZKNkp2HfdiGuagRL9hgc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5623.namprd06.prod.outlook.com (20.178.196.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Thu, 13 Feb 2020 08:45:20 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 08:45:20 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 4/6] brcmfmac: increase max hanger slots from 1K to 3K in fws layer
Date:   Thu, 13 Feb 2020 02:44:34 -0600
Message-Id: <1581583476-60155-5-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 08:45:18 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1108d2f8-2bbc-48a4-02d8-08d7b0610e4f
X-MS-TrafficTypeDiagnostic: BYAPR06MB5623:|BYAPR06MB5623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5623179DBEA390C64255313FBB1A0@BYAPR06MB5623.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(16526019)(478600001)(2906002)(186003)(4326008)(2616005)(316002)(26005)(5660300002)(36756003)(956004)(86362001)(6666004)(8676002)(54906003)(8936002)(66556008)(52116002)(107886003)(66476007)(81166006)(81156014)(6486002)(6916009)(7696005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5623;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqbrNYGNBYgaw97a485o5h3kk/nwRJA1iL+UA8xUJe45+p2TJkJmguiKrptD7Tixn7bGiG2e4L++sFhIR1YuXnct+52SZg2P5pMttMwiGSI8q7eKNnsDaWnW6eoZcJbd1fYSLdWSOXt9eRQ8SF93sD6G/cr9o0dwDEdIDGTOiRFQrkSdaaZNiLqXqEINLOChZaOURggVFo5NjwJwAVr2EX76Uf0n3og6GjTyVGUyoUCNeGW6XQm2+MEZCm7mjzGYcqOUV0lOl3CxDlDk2MmbBtyQj/9UCTg+vRpSN0MZNbl0rWpWN9RBy57vUprdzq6oQGTF2rQERzS8joIbsCOhTgSBujp/oFoMMNKcBuHE11FxSVzUBpukx+upBDDMn/VmlgpA37yBInuZmH+EJuNZaoqPBrgISke+wUrsWe+mc2i9E/R0H6M14/NkhxipWa4L
X-MS-Exchange-AntiSpam-MessageData: 1g4QiISez/9SjMU1WILU5pRKWYYCepbo0zr45JVpSjZlAuTGFx/ClmdfzRpW2E4dPOQXxozdDtb/tAcMbtuE7Y9j8JbDOjvxxU3Ucz0Iif9SE9xAzH2lukC8GNqIoMtLfgvJ2+giLu7542fMlJc6Zw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1108d2f8-2bbc-48a4-02d8-08d7b0610e4f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:45:19.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yetMLStXuGV9H+GuGqdliQjBLY4YWPC6pPUw+nS9iLgPQCY5E84im9NzlKqYle08/yTroyLsFD0xIRY0S7JwgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5623
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Madhan Mohan R <MadhanMohan.R@cypress.com>

Will enable FMAC to push more packets to bus tx queue and help
improve throughput when fws queuing is enabled. This change is
required to tune the throughput for passing WMM CERT tests.

Signed-off-by: Madhan Mohan R <madhanmohan.r@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 10022c765354..8cc52935fd41 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -404,7 +404,7 @@ struct brcmf_fws_mac_descriptor {
 	u8 traffic_lastreported_bmp;
 };
 
-#define BRCMF_FWS_HANGER_MAXITEMS	1024
+#define BRCMF_FWS_HANGER_MAXITEMS	3072
 
 /**
  * enum brcmf_fws_hanger_item_state - state of hanger item.
-- 
2.1.0

