Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEA1202E3C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 04:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgFVCHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 22:07:40 -0400
Received: from mail-dm6nam12on2138.outbound.protection.outlook.com ([40.107.243.138]:35924
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbgFVCHk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 22:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYtSvTwLYQUhvzWlergV9EoHAya/b+zAOf+pBJNsIxjqfwAasLJSQBz2ltMDPF0lRYGOg+edYFWjsAnC807zpVHWib1m17FLa+Us5Omouu5ST5QbAIkArPi7T+oEzEUOu0RTaCs+WlQYKRGCnwKhUb8xmUKb9ckaTuaChyde36+aU6X3m4h9vM/sC4MYx/wjtKp0p070/LNOphZeesZkppfaasrdoVC4j6F5FQTvSZCNoOMgogO2H4jRCpAz0n5sAKlPZWXyPbhVe5UoxWFAKFjtc5WtZalA1T2IDmsgAkwqp2mFYXYlrMEHw2gTXybx3dDFvFbTKWHX7NfWQLOLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeDGGejs/HacM++Y1MzG6xV9uZYP38PXI4xz+rIOk6U=;
 b=BkXJmi2eMWFGDrb2ZbAlYpnuahaKDtMjLGAsoO5X8LJibZDJLTDIohC64HADoV7RIfyftcTs0rHuPWYnEN8wOk4tdpa90wNuoqfRBcdsie50EopQO4vG9VrNWTDbaf7UhTg0NRixBYVnQBIsH3OqKwS6y9eUca8Of68rzU5LGz7bZjj6IO1eJrGuO3pwJPaXfxGZtJoFSv1a9kFzBfgdbesDiyGY9t2hDJHWUvd9Q5rFdQs+VRercCkBjrbV+cDPERiw8c09LQJ/NAObDUA+sFr5H5P0Lw+LLfxRtTRAV816o1Lo3bJ/5V5GtusDSTca2QFzt07bxNUA3Aa64g/4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeDGGejs/HacM++Y1MzG6xV9uZYP38PXI4xz+rIOk6U=;
 b=HsLCLjVT0Jgh5aNFxer11MpVwgy+MgP0aRbXh7bFK8DoEGqjPYVjZ01AaybydrtyLoTfAvsIwaNG8r700ZX5DcvBL1I8nhT8iTicCaBh3C7iA+EUwaGK5+3xvNnE4viNpR3huwVBKFhGaZhR/31ecKNTntfDQjFPHFJkz0+Veko=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2370.namprd06.prod.outlook.com (2603:10b6:404:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 02:07:38 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e%3]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 02:07:38 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 2/2] brcmfmac: Set pacing shift before transmitting skb to bus
Date:   Sun, 21 Jun 2020 21:07:21 -0500
Message-Id: <20200622020721.498-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200622020721.498-1-wright.feng@cypress.com>
References: <20200622020721.498-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 02:07:37 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fa40934-9f05-46ba-dc08-08d81651095b
X-MS-TrafficTypeDiagnostic: BN6PR06MB2370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB237085D14441844CA0CF7177FB970@BN6PR06MB2370.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2nBEkGiBe3r20UGjsNonbdDngv2iOyVbOtIU1MdXSZR0+M79lziqc45MAzn8RILVCh4qavlixtjGwmnLNCZABfkoVoqE/OZBy/g15ObWK+IINoGltIl6q2ubHZvu+rgNJr3Im+TKx+vErYCrjb+1GYzv0qQ/j+N1P2yCyVBGoWBp3yBVTIwTSAsTlRgmZw4/bbkERTG2e+8JpVszg7nh4WGd9BorKJnh7YXIW4w+JLCa5h0Yg7vISgACCl+mmyaEVFfrkBdKg63N3RGAtkwy9iAfNKLHZ9cp5wCNmYMiOYzVSpspnzhGlx3cnEkD46a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(186003)(107886003)(36756003)(44832011)(2616005)(956004)(16526019)(6666004)(6486002)(8936002)(6916009)(478600001)(26005)(66946007)(2906002)(66556008)(54906003)(8676002)(1076003)(66476007)(5660300002)(83380400001)(316002)(86362001)(4326008)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7t+3UcnJpQZXVWNqjY13unjZsQEnMq8NqsdPkKVzs0vDhrCZZNw2VGfaI9pYMhUpjDwtP65CaXUnKrymcAfoPNgC1sVw7BhhE3r6hGRCesk19YkcUW2ToUtkkGZUjSrzr3+E2NiIrpuZdIvOX2WqInsfkxcFHvi86aYJDZDVNRVRwtSeO4yqcWi5kojPx+5aUURGLf8nuxgyIzfYKY4l+9PYxWGbfgy03vxEJKC7zd0hHYbQUW0M3uZPV7SngS2stAyrvZafGjrAxqtaQphkCZm70wi0gjERLJ9Iz57O7DywIMon8Z1CHVj45CCQEH0qiqyzuSIH0oJlUvnneh67q9wrcko21NsHXZVEl2nGkvLV2TTY4xyiVpoojmEGe4xcpuCaVMdGmgpsuIeSu58OJKW7OFhNOYqA0K1+OJUxNuXjoV9emFsh0ldqRhv/9gG8yXZNZhobHP46FWUH66JikwtAtOx9pyAJaNMG0uJ9hEimZnW+ttiI8GLBGB1F3r3z
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa40934-9f05-46ba-dc08-08d81651095b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 02:07:38.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uT2zc9Wj13IHIcqFT808rRi/DiDDHYoILvCaphjofBleCFc6jCyHf/j5lFTufTAcqIu62ZynSnEBbeJzO4Sagg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2370
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Linux 3.6 introduces TSQ which has a per socket threshold for TCP Tx
packet to reduce latency. In flow control mode, host driver enqueues skb
in hanger and TCP doesn't push new skb frees until host frees the skb when
receiving fwstatus event. So set pacing shift 8 to send them as a single
large aggregate frame to the bus layer.

43455 TX TCP throughput in FC mode 2 on Linux 5.4.18
sk_pacing_shift : Throughput
10: 190 Mbps
 9: 216 Mbps
 8: 233 Mbps (Max throughput)
 7: 233 Mpbs

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index c88655acc78c..f89010a81ffb 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -352,6 +352,9 @@ static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
 	if ((skb->priority == 0) || (skb->priority > 7))
 		skb->priority = cfg80211_classify8021d(skb, NULL);
 
+	/* set pacing shift for packet aggregation */
+	sk_pacing_shift_update(skb->sk, 8);
+
 	ret = brcmf_proto_tx_queue_data(drvr, ifp->ifidx, skb);
 	if (ret < 0)
 		brcmf_txfinalize(ifp, skb, false);
-- 
2.25.0

