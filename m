Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290651B97E9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 09:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgD0HA2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 03:00:28 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:31151
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726543AbgD0HA1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 03:00:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWQDlsXIBGj3b/OkKlIFSh0Urg4cmaf+KW7alOZsY2OP+mO8dvBj4N6tZB3IB5cZmMxrFboRJuZ/98xYgbnf5TEdgqk9jyKEV7sAGDvryoi1O5zBRrlCK89uc+WBj4O2nDhxofmh469yIqSfCeaTeG5v1h/ZS7hX39Fr79vNPoKJYzLRG2PxZt7ZM8EO1G/0ubQnW8/FOtGTmkwbMtjYDIdIQH6NcXg7XJVeL9y4XmE9Uv5mwTxnKiLUrLElb5xR+CWEUSxwWelsiHs465KOeCF1A3c+JmKENmQH+DHeQ006vT/sH3l4riJus08JE41J/qzJYItiUUWZP0GFv0VC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONkNghBu/oCKFbhfgFAneKhCGuR7sGZ6ydFKPrDzuS8=;
 b=hqtlW3GOceRYjoS9DmSY+D+lmm8aFffNTYNYHBVPbgDieqa/p1I8fp/tjoXdk//ZnZQLsZqQT03TmUmypSxNSG+b4/gediBEunR5PMiXCoXxqf6D+2exuYcvnu54Z886RjauTtiP1WQarQ4C1Pzc+3ufCzC9tz9hrcbsx7AxnkUgoSWm36dnIMUF2VRUhbGihZSF1kOh3W2UgxfWkL3wXbiS9+A5Pr7rmAt0c02/9oB71Jm+EoaG/DfTkA1l2LPomVL1RwxpCpMXvd/5wQChNJC/6XChmcqCytNgoY/HW1kdwSxS3a0VwROQwXTINl7BJva4mwIFqI7U0Lu1KyA2AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONkNghBu/oCKFbhfgFAneKhCGuR7sGZ6ydFKPrDzuS8=;
 b=m1ip3d0LS5BDHihg9jKtFBuFbNTfs4TMbx6aiwEHmTmroudjjT6qz23V+AiN14Yf2wUa316so4e8XW/tHBAPkMxnYrB8e2NGswMVyz7z1ZIz0fYmWyhRzUgBs55CvcySxoLnWbqADUXk8h+GMbjFAxdy2VdSJUX7wAjj6iFdjwI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4551.namprd06.prod.outlook.com (2603:10b6:a03:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:00:24 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:00:24 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 3/5] brcmfmac: p2p cert 6.1.9-support GOUT handling p2p presence request
Date:   Mon, 27 Apr 2020 02:00:01 -0500
Message-Id: <1587970803-77700-4-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 07:00:22 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40e068f1-084b-46e5-f620-08d7ea78a840
X-MS-TrafficTypeDiagnostic: BYAPR06MB4551:|BYAPR06MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4551DDFB1C54811A6E7D1338BBAF0@BYAPR06MB4551.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(26005)(8936002)(81156014)(8676002)(52116002)(7696005)(86362001)(956004)(5660300002)(16526019)(6916009)(186003)(36756003)(498600001)(6666004)(2616005)(66556008)(54906003)(4326008)(6486002)(107886003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3zI767ZS16Vj/pgdRas1rXWkcAtFOWbHnoE/3761/jUPhwjPcVxhHS34gAxykKPoKKVQF+GsU3bc5esubUTMoPEF7OMNMRsWXPs1tobyEMk7JZUjFyewyw0yisWAvwy9D6iNHimG4k2pg8LLpAH4dV5/RnYl3C/Tre2yKFqI/s3dFLxRhiMB+Jf5i0mY3z+mp9h7uLB0+9HDpZG2hAEpiWGUfbYof6GkNfvJYtjL6rBDREQZhEkkQ5FiffIcBM0HScpvXBPpVQKeQvvqG43f1lCMzeAPpGmPu8TuMmxOew2plITu6DCwN+PomTNUAqENU6yVdl7qCQKtTTlzB9X/GRPGeBaCSZN2TN5ApRZP0joIapEZ6dzIF3fUlIrkRDbRn37ElinMSNTe3nokrLTMgujvyLw08Plkc+aFofjr17OTIjIeuuYzDeIpGs+Rfho
X-MS-Exchange-AntiSpam-MessageData: i6gKgXfVr9sjBGnh9GTrvj+Vg/QjUMVoGgtYCB8bLVB+h12YU6B9hTSt6ksHRkKWEmuNdvDZ0hF4Y9vTIL2BR4uCNpnz+MLpvlmuxLNWwTHhn1IaCV9zp8DCd0nKr8plfdyEOsMmDNDmAJGLsV6alpovEO0t2CvUUPXFG+kPzE0jKWOqbcX3VrcpXeMX5ad+0DUXP26kJbeU8Jy7TR2+/MFPjKBz/I8mWcWwK885Ld/mB28yWV0JAQ62wNPdXrDcS57qqZrjEvM4RcRj5QYAiPLB+cEEndMLPNsRe6pp6wO/unnhHMI1oItJeQGBrqHtRWrp8ORCt5JyafQubawMIUiYIoCtWymQGMzELReZ+HnR1jP6BpOgSBOBYBAayCWC9KmXm0S1Jy7xuM/6lHrwfX4zcqUcfqTKBWhSduJcSx5gPLk2fok8g+KZEa08DBHAe55v6/2ULvVcOfZyeE9AqPFGsaGsouDgaQ7eWfCetEn69qmPLTfRz4uzJ9O79n+5O8BkwFB3ImXAvLY7A7F1qz5eVtOu3lOAptX8HoI3uJx9f5zrm737jfpxOGNaMOu+AX4Rs17nD+e6DwF+/Wdsh/paPoHWHpAEWs/74jFK/sTpq4M8W56Sf9QCgQOnDexvV0H2hX2z+y7nHfCvLjxJFoCq6JCN9TgGzYm47ZbEgXEVPlrxtelYf07TQVMTs0a4IevjWDPBuh/6LgBZSyKiok4Rcv/EsGqVPGSoWEkMu18eEjGEFAh3mj35oY73YPrmGZ/eURaTzuEvNDzfOjpRQRWqr5UqszHh7BdCi1SOCjo=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e068f1-084b-46e5-f620-08d7ea78a840
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 07:00:23.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xc7dIV82BITdcWqy04/YQ7fVTOtyWnYrL1OFtUGyoAPjoKI4ni2kqsOOEFlBFhqw20ePydj5MdNYsqgNv1Pc/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Madhan Mohan R <MadhanMohan.R@cypress.com>

Send p2p presence response from the p2p interface address instead
of the p2p device address. This is needed for p2p cert 6.1.9 to pass.

Signed-off-by: Madhan Mohan R <MadhanMohan.R@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index 1f5deea5a288..c68edb198819 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1491,6 +1491,7 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 {
 	struct brcmf_pub *drvr = p2p->cfg->pub;
 	struct brcmf_cfg80211_vif *vif;
+	struct brcmf_p2p_action_frame *p2p_af;
 	s32 err = 0;
 	s32 timeout = 0;
 
@@ -1500,7 +1501,13 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
 	clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
 
-	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+	/* check if it is a p2p_presence response */
+	p2p_af = (struct brcmf_p2p_action_frame *)af_params->action_frame.data;
+	if (p2p_af->subtype == P2P_AF_PRESENCE_RSP)
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
+	else
+		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
+
 	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
 					sizeof(*af_params));
 	if (err) {
-- 
2.1.0

