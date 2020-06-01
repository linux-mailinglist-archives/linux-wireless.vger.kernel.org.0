Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C686A1E9EF9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgFAHUz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 03:20:55 -0400
Received: from mail-bn8nam11on2111.outbound.protection.outlook.com ([40.107.236.111]:48577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgFAHUz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 03:20:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6w3gmQuN5WE9d9of50gJEjkecxOQ9vIO/zAqvmFIZ5uGEA9O+kqaEsxwfJBsJQvStMWce22hnmuJ/L3Fnw3Jz1XvZaOqFTeVSnd3zx82nqOjRjOwrVY2CW00YW9PrKUzz4yhHvaIkV6M2SHKsiQ/ZwKlbnVo4X2+PYihAFGFrd/0i6biH5P7uWnrRLbzNHuVVQbs53ObAsDr4FW4YHpn9xHU4mthMA+q8r8qq+y9fhLce90W2S31DXzrLfNGMK3LPyWO4vXUctjzdf3SXs/SBbahEg0IgOPNxWi9N1VrQWePKX3g1Q9PpD7EVqiAGqu4xnDgPdJRUypM57Ayl6tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNrP6AUVLo8moojQgM0qRxJpcgEtsDhnxfjfijiqpEY=;
 b=oQBR0yeCtiYvaGsllxkJJzivq0w7qp2oKf3qT4OOlXciXMwIB2SxUqR+UnFPfMSz+ipKKTVvnSicyadJr5Me3nKxa2DCDvHPCR6h3Conbi8Q8B3CHEcAc4ETXmWK02N/c2WM4CBKDYCm9BWFcCGHRg1C4ccepcVFe7CQLSiiW5He6bugfSgtdqn0WOmNKx1n2Joq5LnPkn4Essng/6F5V0eF5e6Z+QEtUEOtuCqQZSTDQC3Xr5Wtfl0xPn0Cznr/OriFe03O/c7NdTWHL/Rtq6TWbXTT4XgwQbJ8D2wyeAITc7xG1RzKgsF+TtHU5TIxYm5uUeXNZAZcV2modsLShA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNrP6AUVLo8moojQgM0qRxJpcgEtsDhnxfjfijiqpEY=;
 b=ofztFMlQC/+SOYGbkAvjnc+oY3Ro3JAVQLR7cXstS24cfzYgOe0aIsqRGqHNEEa6YhkK+umCwC/Z/KFRF0JeGbc5gjfrt1syH4GIt5W1F4ASJLM1zHqIphbJWkEKGFIkZN/b5QEAAWbGT5cxeW/ogx6Bp5qTt/O8SfCkB1Qyy48=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6074.namprd06.prod.outlook.com (2603:10b6:5:10f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Mon, 1 Jun 2020 07:20:52 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3045.018; Mon, 1 Jun 2020
 07:20:51 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 2/5] brcmfmac: fix invliad permanent MAC address in wiphy
Date:   Mon,  1 Jun 2020 02:19:50 -0500
Message-Id: <20200601071953.23252-3-wright.feng@cypress.com>
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
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 07:20:50 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d69385c3-2d39-413e-beed-08d805fc5090
X-MS-TrafficTypeDiagnostic: DM6PR06MB6074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB6074B4B07E6FE8E1E9A459B0FB8A0@DM6PR06MB6074.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AFevSvUNC9E4CanBnByN0UQJ4nw53H3S9eh2bVSDzV97pcmTjaSuRGX0DGq0raZAnMmWl7k22dfA4L3KXecgtr219D+a5PS3vaUj36Ne7qG7IrBvo1tx6hSABbfjs354WG9EDprWFXWKWn5GAEZdUn3NcN5suEkj+ZKaNNGedioK/FYCKYuRdLFBuWdBat30tmoHnIiTJchDZutHWA6kcQp4ZebLOGmzFMc/u2jl6H6mD9NVOQQ4wvIMqSIl3RkYDa5Vo+dWQGK0CPufdTE41v6HH0CfqZsVyzvg55O81LD/uWgkpkq9maU+ciZrHYD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(107886003)(6486002)(83380400001)(66476007)(66556008)(66946007)(4326008)(316002)(54906003)(8676002)(8936002)(36756003)(7696005)(52116002)(5660300002)(6916009)(44832011)(186003)(16526019)(478600001)(86362001)(2616005)(26005)(1076003)(956004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fWr3E97gn109+zBuutU7FMWo+/GRrwcxkXO4PjIZj+gWNwMcm9Zz1EAHbvJ7j2T2ZAozfq0upFQacSAXCV0xwsj8n2qDpEkFBR+G1qp4X4fK0m5hHfOvL6pVrUBys9gZq8xMbPcjudDfJTbE4Gh/YmHD6DaiYmgc8Gm2irzC8btSAVpiYJf+lSlPbDcLht5VLNYtV/EJkkvJ6DSA9KvT+uI7qpdPwjWT9lS5J6sq2NlUt9Q6VNMvNsjrLvvojGNqbxKEAlGcWv7XPtn2NDZW/NPh8D65BOs77VmGASyt2pEX6HfEPfy4K0qjfMEIWo4OQoifDbPc4yBzbaDduZb3RtiyCcfz3QYPFgE51y6kcP3/Ne0BxOYP0CjGlc8IDuoqmgr9gbjIX8uch2YUcNXE0JHWZeuTh2jTcNB5ikLwmo5PvX0KKXFWhDQLf7BB4vMuJ2feMQN44UpiHlnYI0f+g1S3cK2/LvYOGnwfd5DoxrSDz2SavryvsH1ELB92jzS+
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69385c3-2d39-413e-beed-08d805fc5090
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:20:51.8533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QByFnSex8ypNewdnsY5aM6GbMiqBOddGc2SP/gO+tFKvv3DhEQFc4gbHgC+5ACULqGDWxkvAbTtfEqveLK2owg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6074
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When host driver retrieves mac addresses from dongle, driver copies memory
from drvr->mac to perm_addr. But at the moment, drvr->mac is all zero
array which causes permanent MAC address in wiphy is all zero as well.
To fix this, we set drvr->mac before setting perm_addr.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
index dec25e415619..e3758bd86acf 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
@@ -209,8 +209,8 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
 		bphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
 		goto done;
 	}
-	memcpy(ifp->drvr->wiphy->perm_addr, ifp->drvr->mac, ETH_ALEN);
 	memcpy(ifp->drvr->mac, ifp->mac_addr, sizeof(ifp->drvr->mac));
+	memcpy(ifp->drvr->wiphy->perm_addr, ifp->drvr->mac, ETH_ALEN);
 
 	bus = ifp->drvr->bus_if;
 	ri = &ifp->drvr->revinfo;
-- 
2.25.0

