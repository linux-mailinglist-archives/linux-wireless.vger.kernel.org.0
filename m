Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA821CF217
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgELKDW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:03:22 -0400
Received: from mail-eopbgr690104.outbound.protection.outlook.com ([40.107.69.104]:50401
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbgELKDW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egAski9Tq+EPDrzWzmsQZb/ir+AqxducnpTcvQpEkIrn1fFnKasfv8gpgzGQr3X2X57vpKS1EWlW+6e0IFyAmqpDqD+pCFRo3YVgONsDNuckrOBxMG6BdtmJeSj4D/XuidhEaKb08GzAL046r+JyDprugRWZCFMgXJsL8A6b1HJ4jq0RUml08GB0lDmmCzuZ8ePp/igTWr5ezRTi9U/TXQShSvR/Z0cKdWS6eKaFB8xUNEPHR25QTq7bTa4J3oglOb4Jl/VPQuZ69lZU9+jmuaEMlATGcH1kvcbwFhDbOjwAxW15NFtClH5YOWIcuQayG1Ve1Phw8uUp/yPl1zngag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYdoAGHIrSuJUVFmiVGwdFl0Xzb5FZ77xn6AHAf4u0g=;
 b=CO86817Kfpo+1UeWUZXJr/GYxkwG9mE7K8xxEQGnl4wWi6ovBnKX99G+WWHYYQ2+vINl2woWf0+voVuovpL85DHkDEjaaFn1KkewQ9lF9bTeq438oQKWJrfgAgskAgjRZVmUwIuCOtAX+n2AdgkSvhbgz3t3w9EoMQQ2yRs6ort1XzRkkFkckTXD/vJXY9nymGGY+hbUiKMPxEbLu6RHy3/QOJcniKAB+bqlDp4hJ0CNG537HiUpcjNkjsybejr4Oc1IvSoN5qnwLtLjgH90c5e05qGIx0FbZ6l0ELhtDFjll0HDxgtn3fzZqzqeJMHLbabQ/HUMWIzQF5i50xGWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYdoAGHIrSuJUVFmiVGwdFl0Xzb5FZ77xn6AHAf4u0g=;
 b=WQTjrdvzfvW9RIGQOBr8P3NDkFzD1gDwkJ+nfby0Lb3ekE55a6BcKXY6b1WJnc6mIVbFXDQe97Cv6/hWc7JQiskV0PVg6MBNe0g4hdWieiOyFhnpd25KvPMXom+cNZ9ryHgcOBMBxL5YfycGsI5RkmJ69IMc3JeMkx5H9K9iB2s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5559.namprd06.prod.outlook.com (2603:10b6:a03:dd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Tue, 12 May
 2020 10:03:20 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.3000.016; Tue, 12 May 2020
 10:03:20 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH] brcmfmac: fix WPA/WPA2-PSK 4-way handshake offload and SAE offload failures
Date:   Tue, 12 May 2020 05:03:08 -0500
Message-Id: <1589277788-119966-1-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0023.prod.exchangelabs.com
 (2603:10b6:207:18::36) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR0102CA0023.prod.exchangelabs.com (2603:10b6:207:18::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 10:03:18 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29e727f9-f395-48ea-1438-08d7f65bb296
X-MS-TrafficTypeDiagnostic: BYAPR06MB5559:|BYAPR06MB5559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB55594362CCB4AA3DAF23D824BBBE0@BYAPR06MB5559.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZZVCNjylADvir0qYKSu3+FDe4rVe7SNZsVgbeqX6LxONKl3rZ6Zhu09sKjaJSTRc2a5G3EDZeoxvBV/gXEHtrsU/fC7ssJjhIgMp2kPSTTa/38HiQYVIZBgt0q84qNDSWxLWelp81Z7rZmD6+q40oB5IjY0zZxh/GtgZCByS4soPGD6EfN8U0LCHMT+9rfh6lGT1hh+We3L+7IFhZV8HPfPtKAagjuPM7vVihgWLe9K/+8d2iF6jHLrUYKUrQgpgav7oV1fw9T93COBnw2F4C8khXJhlUINXtcPkljwfqifIo9JiKOrmbpBnaw02nf6WrKivMN+Ah/+3uThiCQ2d0nsYC99ydr3eT6LpaHBKhVsifm9NtucOXCCnRPn7cHOF1sUr8Pu16obFTQ17k6VEiY/YhdNUGOpYSBQ+87R4HvDxDVUcQszGVHc6XazvEwjdH6Bm/1joKNlw28IoQBgE1NGhVLdDEDBg/yP63hIZZppuAGjb9dSrZmcDPi5EY1cpg5zJrTgEaG0hxB8jcb/xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(33430700001)(26005)(316002)(6486002)(956004)(2906002)(5660300002)(186003)(6666004)(16526019)(2616005)(4326008)(52116002)(6916009)(66476007)(107886003)(8936002)(54906003)(7696005)(8676002)(36756003)(66946007)(66556008)(86362001)(33440700001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /Y9UTkiy5JP4PiaYAWKVASN6B9n//IOuKXLVJV7JELwPBaG4j1pdVkxgLfYgqGUgImZfFhcm+AgYcDWJRFzHhMW1FU50vCiyfTxu/qn5bXPT8sGLmljtqeKtUsaJ02BYjd8mgx6QKD4GO/a3eJu+Hj2KTxgh2ucJxaxJZdtZlm01dOBd1h9BdVWd56adcMbbJTQhEOGzCAlm36Pe//14HN0zoZnvmlllRRzAAg1BRJkKu1Rlyqs9XvDiezJ+ft0JBJjzQl1SFDAEc/m28QzLBstqcb8Ocj9/FMj0Ipl7AVMjqkyvnsPjkfbljmxHVQbQrYSqDAw2XUBKSS0QZ65w0odCzr5GGuk3uz4z/L5+wRq+P466FthPDjFblLu1V4UqCcP4Ry39S4IqDsYKhZ6ufaVzyEuraXXQYPc3ucnJvLSGIKOk00L1jP0OONhX8tuL6i/jKdv6Q39ouV9z6/dvoA+0s9AYiOjl3tC1yW6lxbdrK/nnIjE346dKPUSbh4ez
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e727f9-f395-48ea-1438-08d7f65bb296
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 10:03:19.8889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67EUE3r8slGaIj0dQlz0xqa87eOHDR9uH3nMCcY4+RbbT5kiHUbL9ZZDcRL4qDGUUs/VmP8Mashu7LSS4XU7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5559
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chung-Hsien Hsu <stanley.hsu@cypress.com>

An incorrect value of use_fwsup is set for 4-way handshake offload for
WPA//WPA2-PSK, caused by commit 3b1e0a7bdfee ("brcmfmac: add support for
SAE authentication offload"). It results in missing bit
BRCMF_VIF_STATUS_EAP_SUCCESS set in brcmf_is_linkup() and causes the
failure. This patch correct the value for the case.

Also setting bit BRCMF_VIF_STATUS_EAP_SUCCESS for SAE offload case in
brcmf_is_linkup() to fix SAE offload failure.

Fixes: 3b1e0a7bdfee ("brcmfmac: add support for SAE authentication
offload")
Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4bd69d85fab9..bc6a1c48affa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -1819,6 +1819,10 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
 		switch (sme->crypto.akm_suites[0]) {
 		case WLAN_AKM_SUITE_SAE:
 			val = WPA3_AUTH_SAE_PSK;
+			if (sme->crypto.sae_pwd) {
+				brcmf_dbg(INFO, "using SAE offload\n");
+				profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
+			}
 			break;
 		default:
 			bphy_err(drvr, "invalid cipher group (%d)\n",
@@ -2104,11 +2108,6 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
 		goto done;
 	}
 
-	if (sme->crypto.sae_pwd) {
-		brcmf_dbg(INFO, "using SAE offload\n");
-		profile->use_fwsup = BRCMF_PROFILE_FWSUP_SAE;
-	}
-
 	if (sme->crypto.psk &&
 	    profile->use_fwsup != BRCMF_PROFILE_FWSUP_SAE) {
 		if (WARN_ON(profile->use_fwsup != BRCMF_PROFILE_FWSUP_NONE)) {
@@ -5505,7 +5504,8 @@ static bool brcmf_is_linkup(struct brcmf_cfg80211_vif *vif,
 	u32 event = e->event_code;
 	u32 status = e->status;
 
-	if (vif->profile.use_fwsup == BRCMF_PROFILE_FWSUP_PSK &&
+	if ((vif->profile.use_fwsup == BRCMF_PROFILE_FWSUP_PSK ||
+	     vif->profile.use_fwsup == BRCMF_PROFILE_FWSUP_SAE) &&
 	    event == BRCMF_E_PSK_SUP &&
 	    status == BRCMF_E_STATUS_FWSUP_COMPLETED)
 		set_bit(BRCMF_VIF_STATUS_EAP_SUCCESS, &vif->sme_state);
-- 
2.1.0

