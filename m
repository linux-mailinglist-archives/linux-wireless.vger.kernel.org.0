Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99B4243454
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgHMHCP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 03:02:15 -0400
Received: from mail-bn7nam10on2121.outbound.protection.outlook.com ([40.107.92.121]:54113
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgHMHCO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 03:02:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE8ozt4cVCVThuQhIBGQwKlcwY4gdKCTHNsTab/Xhn/zvXRsmWOvPfak1eLT/f0Zjf+hUPU2V4st8uM1cqP8R2f8sSVLYNlzjdboaVbCuA0ApOMzSKgHZE6CHmvKuV8n4z+9B8Iducw45F5dIX0sBLatjOV+hCP1d3PG9SWCGZjfS61DA1E6JTLesAKHg4/i1di6hyjxD9AZ9FFq3/xln4mwjoz612Uccwh9nWwYwBa1bOcO6bedNzczhC2lWbNnjnSgtyHGdk8vsTas0pvi+oQq3Ajr9CrZDnsgSlJ4R7MlnBGv2OIDKLlvNqN6wFA5JSrNubplwqc/WRIaNLxkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HGiF3wXi9wB1DoAGlLOgFsdWoPkIoghho/RdbZbCkI=;
 b=B4zVQvXssNkA1uyKHYtgLxHl4j9r5z1fvLDF0pwrTzlj3bA4e0Dxc9TzZfsKjuKSqxX84Ya0NEshb0MdkGVIEkNl6kh6VcNieZpiuNwm7rcycxDDaqxcJBw1FjVwp/m3g3kP9Ds5b6fBhSh3SR24qYPveyQJti6y3Ghzbh7D+Xy0GVmb5eoePIbtIovck5lJ4XEqdrNhpXVY630xRcP2eWWNdOKAuAfrPtfhgFCWS09iNiqLiqlfKq/F5F7sQGZd9FQIDi/9x8qGq+Y0Q1BU9Eb68FDXREAlOXcDAWTYoptCiludIccVr+JILlE00W3TLCV6xq0EqaTh8+rJt5ryTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HGiF3wXi9wB1DoAGlLOgFsdWoPkIoghho/RdbZbCkI=;
 b=G49YdF5pVAlTsG0cE5bkrGOWR2l/klD5In1fwPZm9QB9c7bocRd6+ctBINJyIa2kopTAmGJtmKbLjcDBitFXW2ahEaDgQ5GPsqMuVUZyq/lFjdJ1PJHqF6TbwkxvGGHFvKJIAi5C2sjRqbXs8lbuxf80vQ1mOuIXWeqYdz1M1kg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB3506.namprd06.prod.outlook.com (2603:10b6:404:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 07:02:11 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 07:02:11 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] brcmfmac: reserve tx credit only when txctl is ready to send
Date:   Thu, 13 Aug 2020 02:00:16 -0500
Message-Id: <20200813070017.89023-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0037.namprd20.prod.outlook.com
 (2603:10b6:208:235::6) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR20CA0037.namprd20.prod.outlook.com (2603:10b6:208:235::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 07:02:10 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e290180-f095-47cb-6e41-08d83f56cce1
X-MS-TrafficTypeDiagnostic: BN6PR06MB3506:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB35060F1FF9E387E2277F2ABEFB430@BN6PR06MB3506.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RRKe2SwPlOcnRfSLYZpXqTKr2UcTiKuYG/m/uy3S1unt8S3hABLr0hsxHciCVvSh3MwBNcoy7Z0cNKe1OdnFt7/qsrBGeneSX/gNJCQkVECsCtpWqqVqVsOVgjTbm5HTjh/W2v/yTnLCLoMvJk/jynVhl1cpyDnt0FHSLeKX6Q9hRKfJuoET/FeIAB5uh0Xr5CryghPbaLwy1ARWFttIBiIlX0GUwjtO0/7T9mTgpwPOKcWbUGKfz3Hk8qaZyrkm+fdYhGWSL1BCYwRsPl8GjnbtqOgTUCTrjo7rKYnbcRQ/7GnPabcEkk7QnwQxqPL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(186003)(7696005)(66476007)(66946007)(66556008)(52116002)(16526019)(26005)(478600001)(83380400001)(5660300002)(44832011)(1076003)(36756003)(54906003)(86362001)(8936002)(6486002)(2906002)(6916009)(2616005)(956004)(8676002)(4326008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zSwsTKaaoAgViPpVV9iCZ31ZUleDI7otoCGxx6aMSLYKgErOyBCVhLhBYkg31p5szHMwWyy3Jq3PDqcPS6a51h+S+sQvFxa+g58v+98gKbpwGl1MD9cqXzfHNqFgm1Ey1+cr9wg702PScRzow65zUMmNvDuOG6ypemuBgvOHZI5RU16MAWXpbIDNSuH0cQ4CI0zszkBfq8R9s7R/bbjoUPNfF2cHCKyeYsPIV4K6PwRj2F3ul3ivma5xF9GUV5qQHXoDSfUF2y9CSA1KMbhrc0TwIutDPVfRYrCYpiX6qZmlwHPQ0X13+Z6N3mMlf6u9JT1ND+7CszHBrRzxhxUPjM5Mxz50J6xMIW30FrDup4xpVskN71VEIXlAprxFpg3R+C7qyz9p1Fs9aAZmuKuaEEPJM7cNBKVQol+tnSnKaS0743T2FGgwJAvGi/CyevuZrNyViI7+3Ee+8iHUXgPf1EGCgbz5pWtA2mxrLLcoTcWzWn93HYa6NdXAE+3/6fEtJSUK0xyFEYqaMJCHeIG5pRAoWegujm/fBc2kedMkqAYfXuMh6GCbwVuUwLjF9uepI3o+6zhhCOxRH7p3Yie855zy51C4IRt0ZkV2W5f97noKkuxGuU29Rh6yYi53q++FLIpPxFBfMW1AGRB43RFXRA==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e290180-f095-47cb-6e41-08d83f56cce1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 07:02:11.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0vCs2LyOs1Mz6mankKxfdcP49CjuMv9jmkE8Ql65WKkDdkmVw7XHpjS34oN4X9DXaTRX/wp+Mg11Q6Uojk0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3506
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The 4329 throughput drops from 40.2 Mbits/sec to 190 Kbits/sec in 2G
11n mode because the commit b41c232d33666 ("brcmfmac: reserve 2 credits
for host tx control path"). To fix the issue, host driver only reserves
tx control credit when there is a txctl frame is pending to send. And
we also check available credit by using "not equal to 0" instead of
"greater than 0" because tx_max and tx_seq are circled positive numbers.

Reported-by: Dmitry Osipenko <digetx@gmail.com>
Fixes: b41c232d33666 ("brcmfmac: reserve 2 credits for host tx control
path")
Signed-off-by: Wright Feng <wright.feng@cypress.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/sdio.c  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index e8712ad3ac45..3c07d1bbe1c6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -664,9 +664,15 @@ static void pkt_align(struct sk_buff *p, int len, int align)
 /* To check if there's window offered */
 static bool data_ok(struct brcmf_sdio *bus)
 {
-	/* Reserve TXCTL_CREDITS credits for txctl */
-	return (bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
-	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
+	u8 tx_rsv = 0;
+
+	/* Reserve TXCTL_CREDITS credits for txctl when it is ready to send */
+	if (bus->ctrl_frame_stat)
+		tx_rsv = TXCTL_CREDITS;
+
+	return (bus->tx_max - bus->tx_seq - tx_rsv) != 0 &&
+	       ((bus->tx_max - bus->tx_seq - tx_rsv) & 0x80) == 0;
+
 }
 
 /* To check if there's window offered */
-- 
2.25.0

