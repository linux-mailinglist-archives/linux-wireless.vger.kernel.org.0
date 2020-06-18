Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF631FF8BE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbgFRQII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 12:08:08 -0400
Received: from mail-eopbgr760112.outbound.protection.outlook.com ([40.107.76.112]:7750
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731908AbgFRQID (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 12:08:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joGDlrviDJFnofGW7DEod/QV7fJmB6ng7zv9424c90uJ1rb/o/frhiFy9mka6mzq4LzCvXycSHyqpMmULjDT9RyYOuur4z/BiR6JqcdL1emhP4Q35nUTz+H8O6gRZxPoGWWe5jWdcHCPKH83Lm8REdIyICbzFeIhraYDLydxyD/wo4cDx2VgGx7Y3p+iWKJ7LPZH299XPNlQ8nWPoChJ/P9NCC4RAlmreMA+ykzrgDnp/1brvFv37aVZK/DXJPCf5jMtQLkHh7DLZhjAJIx0A8e/0CH5VbVZF66CkghX128UVIlD1qWg/icFLFMg9tZvQUTFvRxFKCZSfWSkw+i5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+SVmunytF6+GF3Pj/HA4/SoInC8aZpfSxK/8Ql8K5A=;
 b=Tqe/IzBanziyETfogE+0Lv26KWBmAkREBk6cqAW2Sf2H6W3e93DFDI1OYao8KfdC0Cs1SC/T6Vw2V9LoX09OKw7NLgQz76DwRUv/Wqy5ga2mGSjjrAVXE9oZ4e0IqUD8ofxY6EieDOy1euqzjq38EQ8Tw1KP/2Fqzx2+L1TjWQxWf/oAa290t9GScBlVI3wDNNlzTO3HF9KGRM9XcW04ez57HGtZYO45sXp1fIsARuMHx/WAWUx/0GjXaqY0lq2bFABg5MC6SRDL9Xx9UeSl0c+IsbkccCAP7v1GLzFoCoiop+MNeLwNjaaM+IhURzw+A3SHMgNR+e/skKwdXbFymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+SVmunytF6+GF3Pj/HA4/SoInC8aZpfSxK/8Ql8K5A=;
 b=Ztnvvo1wBRg9J+5C++0RP6KBxVtXde4drMW/OuNuVLj6JddxVWyiA/7ku1UJ0rwTzm0W94i/iPz3jkkN8FlgfTUcYU4FdybyqO7s0l3lTTZaLM3R5EwCc49Yc930x1j/3wBEJRDU/pUcWTaxn7OkgubfPT8eC394vRoYVF+jH1c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB4549.namprd06.prod.outlook.com (2603:10b6:a03:4d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 16:07:57 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.029; Thu, 18 Jun 2020
 16:07:57 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Able Liao <Able.Liao@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 3/3] brcmfmac: do not disconnect for disassoc frame from unconnected AP
Date:   Thu, 18 Jun 2020 11:07:39 -0500
Message-Id: <20200618160739.21457-4-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200618160739.21457-1-chi-hsien.lin@cypress.com>
References: <20200618160739.21457-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:a03:117::28) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 16:07:55 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b0bb82a-bf46-423b-1486-08d813a1c3c2
X-MS-TrafficTypeDiagnostic: BYAPR06MB4549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB4549260FCCD8B957227B91B8BB9B0@BYAPR06MB4549.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plV7UwlsRsvpftohrOD5hdlucMO2h1AHQygEuf0ZIkbv83bUsYOtPiejb0eWLdt+k63LJoZ/Aj4xMkToSyyoVrszlEikSRXYj4SQFZ8BB/T3wkQOeSGGg7HNqVIzw7oIvPYgeyTZMGlrqCYxDnPyCdW8hz+U0U48qEM0vNWrbgOsl8EzqFjs+DBRIQ3bsfdSVFuHZ2BURnKaG03VW3daVVgswXWv0KVq12ugb3S2d0HqTtyCzjBAZa+E6yaSckYGwXQWeOEQlQ5OwMYozobZBk6h+gTkZ57161jxNmy7Pwu+UpCJaDa/XCz8NHMdLYbjm0cCabzoJkZfeo0qfM8zzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(107886003)(5660300002)(316002)(86362001)(6666004)(16526019)(186003)(4326008)(1076003)(54906003)(26005)(66946007)(2616005)(6916009)(8676002)(6486002)(7696005)(66476007)(478600001)(66556008)(36756003)(83380400001)(956004)(2906002)(8936002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: HHXVPzBYiR5eAeLBqe106C8VX/qg9XYpBEP0qijLxHvjHQAvo1sKzNIg90HqVak+wCMyoftDzEJ++3u5rw6ZxnGPHpYCZSQSf3rxQYJdsT5AIaDKzlTd4zC3qdQrrgkbh7uLzb/IXnkdIJgtHICF8heo0K8zY7exnwSbh24AcMIL3tPvQlHHK6lda2BTBvY5pGXmBeXgRxbjOkLDu03RWCRJJ914u7VdBtVK4GNVxUNGwLdm+/dnldUWjVc9SpthmWeu9p1bQdFgmWAnZ+DEx6huwAX7OWrsvaVF4hJCEXtunTRbOSE8GSnJQfOkr/mv6VicdH8MlWbjaSo3GWHMhm7Dt6vAy8rcOQQKkVtqJep1c7wq2Tx60Q6eENcJTA6RfnardO+sfKPHXM3wqRDH0aHIfegH8KHiqPsS2LbmRvvBefA98akLOdknkDouLKQ1V2XWsRjkLd9g7eGN2Vryt2xWuU3IirbP30bRaPrB7ZMqEyd91ALBZKzWOyIn+Xmm
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0bb82a-bf46-423b-1486-08d813a1c3c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 16:07:57.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axhf3Q/b8tJM5AeWq3PbabHoYt5KGRNsayl2tstbzJns8ztmLQsUawW6CS9RifA2opDaZw1NSsruXVKkX9ZQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB4549
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Able Liao <Able.Liao@cypress.com>

Ignore FW event if the event's BSSID is different form the BSSID of the
currently connected AP. Check interface state is connected or not, if
state is not connected that can ignore link down event.

Signed-off-by: Able Liao <Able.Liao@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4717867949bb..ac28fb943471 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6027,7 +6027,12 @@ brcmf_notify_connect_status(struct brcmf_if *ifp,
 		brcmf_net_setcarrier(ifp, true);
 	} else if (brcmf_is_linkdown(e)) {
 		brcmf_dbg(CONN, "Linkdown\n");
-		if (!brcmf_is_ibssmode(ifp->vif)) {
+		if (!brcmf_is_ibssmode(ifp->vif) &&
+		    test_bit(BRCMF_VIF_STATUS_CONNECTED,
+			     &ifp->vif->sme_state)) {
+			if (memcmp(profile->bssid, e->addr, ETH_ALEN))
+				return err;
+
 			brcmf_bss_connect_done(cfg, ndev, e, false);
 			brcmf_link_down(ifp->vif,
 					brcmf_map_fw_linkdown_reason(e),
-- 
2.25.0

