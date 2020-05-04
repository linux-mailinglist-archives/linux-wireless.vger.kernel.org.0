Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23801C3271
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 08:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEDGJH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 02:09:07 -0400
Received: from mail-bn8nam12on2092.outbound.protection.outlook.com ([40.107.237.92]:14944
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726410AbgEDGJG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 02:09:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiuoXUjAYgC/ASVm58Skk0ID4M0lEv8Rur+n8xbdWOq2qH45YNebAjd2qF7sA+jhe4AnEJNAkYG/M9cHvHpV6/XVtAYJyG9s+uUjJ+InWsB1W6zNH/VygPn8xEBtXNB3T/WD2k/gNPgQ+FeAJvizyOq96zKA1WX0W/a/UnhLF+aTfVa7l3y3hfDHLcVRiMECNRgFKvyyH7mO4pDSCTrjVGgsRpA3og5SLrdxFqlKLclN6B4gl9ErcjE30znpGkzLInWf3tCXAlMpeYhPQiaYQl/oQp2TXz4SXcWC08bL6nGMCVLtGkmaqHTJazJ27RpgIBWoUCv7eDVo4JwdCnzWHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhr+tcgIeol6CoKuWP0Igk2XuSvWYppqWZpc4IKdWlI=;
 b=AE0We/G0bbeuHFCuPuA+L2/712tB4NgfxmpT6ZxG4hEE6Imy2br/AG1rOGElhynmmSdN1POuUn2Ne+E9rZk9Qcx5hROxAtNDr0fs9z+T1N4sHb/tBVckL6EUsmHeAhE3lzIB2UhBMhACPDfgLZH+dMyUCk76z8tQ+hAlk9Fy8CKJBFbeqtbZ8cu9hXIY55nZDBHjq3gRozhxbt+mCqSIZt8F3OnuTSNED8Cv64cjq0NJo1l4RU8VOJ9jgKned1/VMu+rqdlbkaE/MAGICUJ6MVYnRvFbW4z9s2pi07IcImK5hESYt00Svjp5oaUTJzZHICsDIUhiD5dBoPckAe9Jnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uhr+tcgIeol6CoKuWP0Igk2XuSvWYppqWZpc4IKdWlI=;
 b=pf16vaz/RlZuuPuKtCuBtE+6V83yUs7d5/lYoaFZ9n1CoWTzH+ynGNYZmZpYSWlIgC+uUKm7JzEzFfoLMkcpMHyrOxd22zX3Yi9hCyV4YNduOm6Ly4c8Mxr43i2KsqfEWbqISJrF7Lb+ZTZKYO35HPCdNxq+uPMa7fbnC+eeBvo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4283.namprd06.prod.outlook.com (2603:10b6:5:1e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Mon, 4 May 2020 06:09:04 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7%7]) with mapi id 15.20.2958.027; Mon, 4 May 2020
 06:09:04 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Justin Li <Justin.Li@cypress.com>
Subject: [PATCH 3/3] brcmfmac: Add P2P Action Frame retry delay to fix GAS Comeback Response failure issue
Date:   Mon,  4 May 2020 01:07:33 -0500
Message-Id: <1588572453-194663-4-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588572453-194663-1-git-send-email-wright.feng@cypress.com>
References: <1588572453-194663-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 06:09:03 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 57d846e8-bd1a-48c8-a122-08d7eff1a58a
X-MS-TrafficTypeDiagnostic: DM6PR06MB4283:|DM6PR06MB4283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB42833F469379A2A642B0597DFBA60@DM6PR06MB4283.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGfO+e2gYM7Mjf5qJxTzsKsexuyw3ez63AxAlQ+SgUY5LZxuCmKjDkdIG6SWrwS7nwL3EIJpVwla/KRpVe76XHWJ60Uun2HTJU6otjKGI4re3wTyxtTcEOcJP2UqjLdn8zxZ5useOPdliFtGJH+J/cGMF7LDwVgDdnvHZeo9YG10zxMxbk1PKLSa7pwu3YYTY902sw9dcIYhzIjn5SiUU6XTPdL4VA50c6FwGLzYNPJcbPXq+KEBPtqM2MkbckqQdhdrCVSXy+7SXPBJJklv9ykfJZkkvetxJJlPwUnpQuQUfffsrbHUsDzwJLw4WuuH7v7rVqM9o/eUm4jgFoWE4Dmd/BAHSuTjjfCn+urN30kVG9vQ4ljXjvGanmXSDqeD+aM0/qs9QNgfu0NgtoOKzJIbRYdDGbQ4gBt1uqwU3B0N01NnFew/SXE3BSJpV0cJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(66946007)(66556008)(16526019)(186003)(66476007)(2906002)(26005)(44832011)(7696005)(36756003)(86362001)(52116002)(2616005)(107886003)(956004)(6636002)(8676002)(5660300002)(8936002)(6486002)(316002)(4326008)(54906003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Z+aTHMGBFWB6NjX8krmHT4QUipkLiFtdPFsfreNoh6TDemEBvxz50o7+uk2rOp57hw2e0nSiDcDJRPMLXgdAJy2dXxvDcKMeSwCbDj4wtLJ16lieC4eJI6YV8ur9Kw2h9ojV3Fu1n0mQp+kIfbVV8IJxBx4U7BkxsHwdt+NC+75oZ+atP27OnOQ2qFetKsrvQY3sTwddsShH87T2OicqH7Cu1qOCHEEPMZevboUWJbYmjIfXGSPd/T+b41XZopVoh7+JYm6ljRQ/coK5RFlUncs0oDlUhrG5K1njOaTjBcgPq+1niyhnyyiuMolXxK+H0UjPPPVDb0LNvfQaSh/Aulw5Yxey3WGLH0iGRZiizWtn1jv6A8EKRVKIRy8CTzaukHs+kMAY8TF5K8v8wDzXQV5OTwxnJl+Za/A1iqP0boCYQkS6VE6wRnFzO+hu8VsjTaWgY8WF1mjuetu8SgBIbpc03o14M6/A7c6ToG0+EftnED1bFk4uuCHBe1gBlmad+/qFEz5O85505sJk+wp0YgFGuFAzoqr3ywDvSEcUmauFHPa5k1fAijy2203xXIX1IpEUpTJbktZJLbCHrmjzHfba3Dn2xLmI3WWNxTPXQ66lNQ6/Mbnb+z4pT735qG7hR88j1K5ivs2sUTExaRiBEkl/mt+XgXVtXxZIXPwZTUsupzLnu+zqZvvYav+osCagJsGvZbUMLy4IMIZ8Elaoejb67pQjFR5HbminC9RzpRNvL+SxdCDy8yB0AB4r26Yilr3ULCarRRfZfpmqcSqxYsoSc2J8lqs+efb5qZo9Hxw=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d846e8-bd1a-48c8-a122-08d7eff1a58a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 06:09:04.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1P3RSbCon86BgEYTSFY6rG96lqbj4dJejajqeiDiZANr+6tExilEhxOQQf2SI4EcumD7zcgr+UPu10ww85K5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4283
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Justin Li <Justin.Li@cypress.com>

It was observed that P2P Cert. 5.1.19: DEVUT responds to Service
Discovery request failed due to DUT did not send GAS Comeback Response
after receiving request from test bed P2P peer. To fix this issue,
we need to add P2P Action Frame retry delay to enhance P2P connection
under VSDB and noisy environment, since the peer can be in other
channels under VSDB.

Signed-off-by: Justin Li <Justin.Li@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index cb8e229..780fe21 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -66,6 +66,7 @@
 #define P2P_CHANNEL_SYNC_RETRY		5
 #define P2P_AF_FRM_SCAN_MAX_WAIT	msecs_to_jiffies(450)
 #define P2P_DEFAULT_SLEEP_TIME_VSDB	200
+#define P2P_AF_RETRY_DELAY_TIME		40
 
 /* WiFi P2P Public Action Frame OUI Subtypes */
 #define P2P_PAF_GON_REQ		0	/* Group Owner Negotiation Req */
@@ -1806,6 +1807,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
 	while (!p2p->block_gon_req_tx &&
 	       (!ack) && (tx_retry < P2P_AF_TX_MAX_RETRY) &&
 		!dwell_overflow) {
+		if (af_params->channel)
+			msleep(P2P_AF_RETRY_DELAY_TIME);
+
 		ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
 		tx_retry++;
 		dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
-- 
2.1.0

