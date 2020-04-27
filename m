Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1032C1B97EA
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 09:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgD0HAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 03:00:30 -0400
Received: from mail-dm6nam11on2125.outbound.protection.outlook.com ([40.107.223.125]:31151
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbgD0HAa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 03:00:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCTlrD7mSS6jtiZWvCDqCPR+qQtxK3zKg9vv/G1M5uMwkvAy4u7yuB9PeG/7vosgZXAVf1WTMBiTRE302WY+WKmGFKMwlCCVheU+H2vgE90iZmWYN+qt2GTr/pBLdKG5ubRmn8MKrcn/inIxzzjhsxAkLmIe7QnQ2wS182gLEqJ/LWxuDZvBz3T9BS6K+g4MbPuU7sSZRPtm2SqDRFM1R7NIaeb9nqMmkyh6Fyv7dzvUJkSNdJVwAe/tsIiscjplvKWJUvB4oKJ7dsUdbzPIX+nBAm5Z1+Y0olTjtE76nAz09CW0UqJfJoxhzRbO/olpkR5N1DH50LnBOv2VUJPkFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBP0T2ttXzcFKwRJXpvhQN85vFBEaVOg1/Odoqx9UqU=;
 b=Dep/TrxAhFPWCKyV0AKfIxRrMiiZzXvKcfKzHKuuZXDZU5ozMeEmfr5HjWFdNf7YC6Eg/Y5QynNpkB2562QgriNxGG3y7xDGTMcPBlvJRfmzRbIfiD7spdGAQWZPQGXVWdaRyt8SkQItC8FlAk8i/ha95+W5krmtzds+SX7eVcNYNWd2b6jeIfX2gvHfp9f8OXT9goVfhZr1yP9k52p9JlSSrZ57n6xQjkNndLfLFD+jD5KabdNscb7D0nrT1QeDCAj4mNKsg/hXRkixwlS/NztMemMCfaYLi3ocNfMCkyYVncaiQb8rGp7wkR+Gcx56Mru/6vxbevS+Xam7lJpJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBP0T2ttXzcFKwRJXpvhQN85vFBEaVOg1/Odoqx9UqU=;
 b=Zau4vaxOX+71ipQmisSYSamsdGZwD5qxVBxoPVEl2U/+DrXK3lPsFS8QZg7Ejgq4i8BuJPgt3D4h52DBIumqHyqmHkvZfORcHP+kVw/TUdp+p2basNlW3EfvfWw4Y43SUx0/2HtfjYBsIjYqiAGMP2uZq39Q1IH4YOld3mj1k0o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4551.namprd06.prod.outlook.com (2603:10b6:a03:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:00:26 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:00:26 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 4/5] brcmfmac: only generate random p2p address when needed
Date:   Mon, 27 Apr 2020 02:00:02 -0500
Message-Id: <1587970803-77700-5-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 07:00:24 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6fa6214-6c80-44b0-4fa9-08d7ea78a94a
X-MS-TrafficTypeDiagnostic: BYAPR06MB4551:|BYAPR06MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4551D2A56B6C06AD1D67BA33BBAF0@BYAPR06MB4551.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(26005)(8936002)(81156014)(8676002)(52116002)(7696005)(86362001)(956004)(5660300002)(16526019)(6916009)(186003)(36756003)(478600001)(6666004)(2616005)(66556008)(54906003)(316002)(4326008)(6486002)(107886003)(2906002)(66946007)(66476007);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haJrRQdarIVIFjkI1tdcbHjhSCYYOZAUJfIXYw6v5slpvDHh0QB++y6ESi+JU5mHp7b2z09GJTYXVN4DPaeQsarJxk7UDn84sMyZWaqajya91c3tmYFSx1swTbKIgCeO+Pun/e4tJZyeqSVop5oki/q++wcqchXU8jWTqO3Qiwgh0XkDAdYfUchrq5Wdj4YChpKuApxNbfu4YVav8kRdT8Hv39qPkf+S9dmRNKjOYv3tkY2ck6cmRRqepk0Sjk0L2x/52EmS4YRcKkqP7nKALCNdlGk0or6vTQM/256AarcKoeyYsSXpys1CjizjcpHDjC7GdDkXaJWvnKeY5duUkNgoEoRMifCNiHNdSW46vCSyXhfA/ujHmrpText8fsTzJlQXS2yzw2g3eY8EHE3wMR54Q1y02uBgfJhN9UPXdfj3R4XC1NQEShuNAHo/zTLg
X-MS-Exchange-AntiSpam-MessageData: t0agizTjwTzGeCJSea7jzlil5ummVKNx9pGrC+fOYQcrFutpwxJdaevjM0j1JPdEncKbtxyOS68m880ay7K3B9Zy2D3v1Y1n2MKhGsZJL3zJyHsWl2ZwEHlfE/u/6evNdgWafDE4wY2foekQ9SpsAaDkZe7HXrFo8v+UY4Jqr1dETssn3ERgR87ZdSnmEd4kyO/ac6ELff0iJKVVhIzyQqjCG030e+5n/n7xNPUa1sCWgoqNr1WN0jZgQ+ZTF7Qe9NizlfO5asVsNRD3MPbqEpVwGVqfm2+f1VwVeNRHxqg1d1Dtol0DpOHGNHGU/qNEWa9kNjDqIY0LeVtu919v9sHu2dw8qcmSrLm/4yWNtwF3xSiCNgzCjSry5HKo7deghvWDwSCsGkS/8bIMbxC1zn5sWDBp7WoajipQgkttV/o7Np9H2b2UmXyBBqcnihjGLt8vM1qdmBbvLN0L05AcE8MdcTxIuOfMESSBvwL6U3GNonjI3uR7YlHwCAHsfVr3Yb9SpyfxqL5l26rGQaVDTfQuZ/iPyPxFXqlZOfd6f+Hd8mZt9fOH7nx3Ur0B4OFWQ4NLhBCCYK0x9HgX9hZsenKXx+6uIq9dJgnTkUEeJmqCvm5JRBrEVx21oxRHkAUTtGFtKjkLWGB0iCece8ZhwreAjbRVUhxYnXQMc5vvdx9hbVIhHdznTOIui3Hb5BmiS8eI0CfPpMY/kBoy7dQZttahyDtCKeGH3ywYffGPEMsuS2Kk+smwiWOTLpe4Ui5Zq6Z3ma2WG3HdD8J9BvQyETMqRbH3U/SpJvP8amEjr0Q=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fa6214-6c80-44b0-4fa9-08d7ea78a94a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 07:00:25.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzQDVgKAoAOUTbBjjS+Sla6qWLb2ReIA6dO943i3EApojlEzpMrmad88jaAZWsVzA3I7ohN8sdRaBGRjCwAvRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

P2p spec mentioned that the p2p device address should be the globally
administered address with locally administered bit set. Therefore,
follow this guideline by default.

When the primary interface is set to a locally administered address, the
locally administered bit cannot be set again. Generate a random locally
administered address for this case.

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index c68edb198819..f8ece9f381a5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -457,10 +457,21 @@ static int brcmf_p2p_set_firmware(struct brcmf_if *ifp, u8 *p2p_mac)
  */
 static void brcmf_p2p_generate_bss_mac(struct brcmf_p2p_info *p2p, u8 *dev_addr)
 {
+	struct brcmf_if *pri_ifp = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif->ifp;
 	bool random_addr = false;
+	bool local_admin = false;
 
-	if (!dev_addr || is_zero_ether_addr(dev_addr))
-		random_addr = true;
+	if (!dev_addr || is_zero_ether_addr(dev_addr)) {
+		/* If the primary interface address is already locally
+		 * administered, create a new random address.
+		 */
+		if (pri_ifp->mac_addr[0] & 0x02) {
+			random_addr = true;
+		} else {
+			dev_addr = pri_ifp->mac_addr;
+			local_admin = true;
+		}
+	}
 
 	/* Generate the P2P Device Address obtaining a random ethernet
 	 * address with the locally administered bit set.
@@ -470,6 +481,9 @@ static void brcmf_p2p_generate_bss_mac(struct brcmf_p2p_info *p2p, u8 *dev_addr)
 	else
 		memcpy(p2p->dev_addr, dev_addr, ETH_ALEN);
 
+	if (local_admin)
+		p2p->dev_addr[0] |= 0x02;
+
 	/* Generate the P2P Interface Address.  If the discovery and connection
 	 * BSSCFGs need to simultaneously co-exist, then this address must be
 	 * different from the P2P Device Address, but also locally administered.
-- 
2.1.0

