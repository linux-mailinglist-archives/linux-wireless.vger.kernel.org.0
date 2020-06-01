Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5B1E9EF8
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgFAHUw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 03:20:52 -0400
Received: from mail-bn8nam11on2127.outbound.protection.outlook.com ([40.107.236.127]:32224
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgFAHUv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 03:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmX3Kq74FOBN37r9C4P5nNHFaOIjI8QIeLo+6Zpa9bOrZuWG0XZHxwtv1vdKf6PePTeBtaODl5HD8HqYQf3XlWL9PUQzW8zb6u7Tyh3HQ3JF2ZP7hARvpyXeN1zbSUoLR9k/1cQy+c254iCjLIRxYkiREft0uphmgHZmVuYcf6PSWsRim4RpkL2Ofl1q+P09ztJ9EDCOXY0xxACXz4/NE7oXoMzfFUOZ6j+bJBsC8WNtxHVQB3Ui8Prh2NUAz83eNS5t2B89LNtrQObWujqmE6npiXIxQk9OXHSWtUIDdby37crDr4GpdVOFCu+bGzj1EI8rj65VmT1149UdHU5Vhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVgVCiwGe2QdObhm3/mt8qh8vx7zfJ83c8PjuBOSLLA=;
 b=N/TPuWAlbxc1q4EA4TA+6YAAvxQqtcy7NBP2dqGl8x/6rtOxjSl0LuSkBOrg/DHHi9w1yOFRh3l8mOTKDeHeK33uDWHmytZDnuNbvoMNmPT2KOUDDW067CY4EXXFeJl/BLn1d565YYRqNFzYU+K18nDKzzW5a3hlCrU5746hl0p8alOnyTO3xmj8RFlR0JxclTpGzTy/4E6SbkGHujucyIHy3A19QNGfx2tzKEXagm181XXdnEQu9tv7npb+//HVo9qi7q4zx4QiZCguknmf3OFkkB7DgzSLMOT/1jgvXEaFhJVQD5G09LNuPQAxjYZccQzzBwTqi2FEPf06+FShvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVgVCiwGe2QdObhm3/mt8qh8vx7zfJ83c8PjuBOSLLA=;
 b=GtaF6ZUvLI1VbJe74bRR1ye+8F5VPlbOAu3o+8XqTAuL6ZZBZZaR9XEUXLPDgdGpaVFSmM37dIENvWT9uASYhiJXnIgjjTqtuENRyCrm7wRRb1ifLPwMZaIozkUyWh60sCBwK5l9ohWaoK8C1m2OkyrwL2hsepeVe0ZycjiiwK8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6074.namprd06.prod.outlook.com (2603:10b6:5:10f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Mon, 1 Jun 2020 07:20:49 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3045.018; Mon, 1 Jun 2020
 07:20:49 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Raveendran Somu <raveendran.somu@cypress.com>
Subject: [PATCH 1/5] brcmfmac: To fix kernel crash on out of boundary access
Date:   Mon,  1 Jun 2020 02:19:49 -0500
Message-Id: <20200601071953.23252-2-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200601071953.23252-1-wright.feng@cypress.com>
References: <20200601071953.23252-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 07:20:48 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 731c1a6e-d9bb-4c9e-161d-08d805fc4f1f
X-MS-TrafficTypeDiagnostic: DM6PR06MB6074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB60742A5415F508B4937EFF70FB8A0@DM6PR06MB6074.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnsQAFySTwwi8OCKDsDzruqbFd5zrIWyQ4cOAhbiLo+aepEBj6AKWIirbsCE04Gy68JlIVTbYQewInwjMqII99PW8NMnbhwERa/B0KXcVryAa96NZAnUUnATU6i9eFn3RMQD/Cza4wwk6MU4Blq3ybY4g7kT0mgXBxYkJoy13eJyzqvs1GNyFRZ4J3zLH/pNzxQoTT/cYBlS31t327eTkLI9BfJPIVKYwoc3SBuFa3GzQ1hdnig8eDvUpzbVN/SwG3mjopnoEm+0rP4+sWG/GOM8bcqUW3rTvcTZJhgYtTxWQc4O/ixvdurVs4JdiNVHv/NPQheLBnl8qt1Axeoi2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(107886003)(6486002)(83380400001)(66476007)(66556008)(66946007)(4326008)(316002)(54906003)(8676002)(8936002)(36756003)(7696005)(52116002)(5660300002)(6916009)(44832011)(186003)(16526019)(478600001)(86362001)(2616005)(26005)(1076003)(956004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hnQxL+fQrlSoFYpCWNnnW5kps0kuPSOTYb0qlFeePP97BhBP5Yi6LxHsneze6XBIY3004HLTooqnx8jOyebnqi50XEoc5X2M4Bb8bYCNvB7luuD/wgtDQVaSTST+Ns+f59PPSlPUNDmC9vuE4MPHs1s+01/eS9fc6u2samxJm6xvWt43lmXZRs0A4cTkWpJ6z1V0Qmiw8ptZHLYYzi7A8JsckYgSmvPyve6CJoLfYU5PeZUUy6UPzrOxogt/37dF7lQlVVj3waLYoyDOV/1SOHUc57v0ag61ejpjC43pjMBJ+JqBC5JoY3iqGOfi3N4baI0Zs7galxYnVk6Y3qAonJeKv2znQF+S+Njl38n3jaqM5m2AZO+Lsy5OHHqrvRML7szdBJAjyl+2vt+mtSBOx/GqnR0nDX9rYs2ff+b0Ny3pulVcnCgbjOqgskhLBGEBQeWmBThWToCs1cHzY0cdlI4/fX5J2SBErEE91kj4zFNu1/bHgd4MogYkGjdOY/9U
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731c1a6e-d9bb-4c9e-161d-08d805fc4f1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:20:49.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zrin8LAbfMogFGJbbNc3zuvRJZFBVv6qcVGO8t065+8E60hKdfvhnowI5kf2OYzYQ0EZeeXlXMzvyvvqcz1ZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6074
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

To trunkcate the addtional bytes, if extra bytes been received.
Current code only have a warning and proceed without handling it.
But in one of the crash reported by DVT, these causes the
crash intermittently. So the processing is limit to the skb->len.

Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 09701262330d..531fe9be4025 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -1843,6 +1843,9 @@ void brcmf_fws_hdrpull(struct brcmf_if *ifp, s16 siglen, struct sk_buff *skb)
 
 	WARN_ON(siglen > skb->len);
 
+	if (siglen > skb->len)
+		siglen = skb->len;
+
 	if (!siglen)
 		return;
 	/* if flow control disabled, skip to packet data and leave */
-- 
2.25.0

