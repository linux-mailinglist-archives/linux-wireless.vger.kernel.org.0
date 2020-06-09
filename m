Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCA1F38DB
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 12:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgFIK7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 06:59:35 -0400
Received: from mail-dm6nam10on2129.outbound.protection.outlook.com ([40.107.93.129]:26720
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgFIK7e (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 06:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DywDNjU67naqKAnlLQvDFFzphm8pG1dtMVobvT4Wzc45HFN6n8GanJhMPaOCvVwQjavvkdbGlLBY7M+lWWmcffW1sz4tnfyRW2qBc9jXaSWsRixvCMuGBu3u+1wPZJbtLcmV2Z+DBS6BhmvxzfMctL0V3gGouA99t1qPf3AtM6cTQvOXaA7bk5uLmb12o2yJ507BCx++C39SM3RWWwK3wYuhVYGWiMY+98O08R6O2VMZyzOE4Xz7wG79L9Lc3G/pTfTvO5L6axgD+GwoZcHxasw4mT+j0NcYUiPOfrBLCjY+f6z4eHW46y2E+TeUuApGaqJjL9Eilm5heM+V6rMPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgHi90gclLmqwIbuKaHiH64HqaDm0VrmDfo80pCUMsU=;
 b=M502k5uFDQ3fRYrjLRKpCj9X4+FIL98VBYaAm9Rr4vy91sFIOXXCyqjbXididq6V1eAp/dbXBi4UtlHL4+KXaDU+KZHs6yVYam+ZSBb3U99dRvS/YSoeSX9M5WHFLnL/ozBtD1f7afb/zs6rW8qmBTisI2zEm3Ilae/ZBmTtd4QVVN90SXpKUis0OcdfQgVMAaUiOz/7UsNGMAPTSJQtwGl3T7oeXPU5Y3HANsf0PJPbnU3nNI4WRvuSEJSZICtDD94ETuHO349t5pcT28yZststB7E7fGL7hoeG/xXLodyxnAaO9cRvsJtsQx5bxZKgS8yzVLo87CPFpSJZkLO+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgHi90gclLmqwIbuKaHiH64HqaDm0VrmDfo80pCUMsU=;
 b=LYKGmHm7+kvnXfLOjJ0ViyVwbL9wX71j4AaAoEetlJTh6xUN4D9HQUYVdt5sis1VXsb3O5ju5xeandskCbBqFUUjbxv7dvw5Es91XtE1U6xkQI6/lz3u0SorR89H69dtZgv6e+x9mpcVqvixLgkvAlSeBb1hESJPoJ8FQsD4nP0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5064.namprd06.prod.outlook.com (2603:10b6:a03:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:59:27 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Tue, 9 Jun 2020
 10:59:27 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jia-Shyr Chuang <joseph.chuang@cypress.com>,
        Soontak Lee <soontak.lee@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 2/6] brcmfmac: increase message buffer size for control packets
Date:   Tue,  9 Jun 2020 05:59:09 -0500
Message-Id: <20200609105913.163239-3-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
References: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0068.namprd19.prod.outlook.com
 (2603:10b6:208:19b::45) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR19CA0068.namprd19.prod.outlook.com (2603:10b6:208:19b::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 10:59:25 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0afcf06-8575-41e6-df69-08d80c642d77
X-MS-TrafficTypeDiagnostic: BYAPR06MB5064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5064B56A71AFF3E810DA05C3BB820@BYAPR06MB5064.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndH/7FDrgHn+bPGHh9KMte66qmeS4sIglvLhRN+h20pEdJ7HYpFJW08/nEjCFENoxP9P2Si3eV8bN9Q0Ng8j4TbR3g3KoMZ7CxoyQFlztRCgQBIM3xSkpSSuUY7858E4L9Y6HloBNctMMwsLdIGEoq1kl5ddek0kU5azXBgP3M8F+pPrsffodLYm33K2jElu4KqCdQVh9iktkWk6leUaEwxKH7gBEAPneOUExcixFjk4C7GIKBjqJih/JKl8EgHfuiongAZ3O9rt2fNZRvdz4J41jLP5Ghqsz3lm2kjNgyg23BiOqbBIupS4WKn2BR/9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(36756003)(316002)(2616005)(52116002)(66946007)(8936002)(956004)(83380400001)(16526019)(4326008)(2906002)(186003)(5660300002)(6916009)(7696005)(8676002)(66556008)(107886003)(15650500001)(478600001)(1076003)(26005)(86362001)(6486002)(54906003)(6666004)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TAtBAwCxryo8SQnwUIdriIhCNMgsjxKWdjj3cATxaa+Z82fXJMC3P3LtQPA/i6YGMY36z22ODP/HN7RpOO17RRYdskv//rjxzjNTPrMNQLwlMn33sbzetdci9gZGYHMDb+qsbtEnXguFtGQmAlDMeyEsU85tCWwsIw6G2DB7gXdq6UnWpEiE/5IzPqrrsX8ttqksiPFmswdzprmDN2oF/QpPWCwGUGQhULuxQgQTyvOOmTFF2FM9OLjzCSg9VKzXiRo9Tg32vEnX9o04jxCAeItZ4UK1zgMi/vnUvinFlZ+jElUZdZxGYNbf+cCOVE8gdQsezPB3tRWEG1Zo+5PSkWB6Sxfgrtnx3jH0FoVW45SuF2ljECCa9Jw4NbFwD4NObiDMYShRg8hAmCDff60cnKsNLkISx3QEdSOIlTUT9HiMl86R64guOEjh7r05SyaJgkzws0oLCZ9DngOim/C8UbozqpajdWa/n2pi2QHpZ/8WYyTXq1rfhKlsLX1tmGDi
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0afcf06-8575-41e6-df69-08d80c642d77
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:59:27.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XI7/0S2HRAt7yUpH+oM2ljK+to1JvrL0Q1fkUA+Lt9GKMg5UZSlrFYJ6C1ejJKt6mIG5ssaWeLWHUBaTV+6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5064
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jia-Shyr Chuang <joseph.chuang@cypress.com>

In wifi firmware, max length of IOCTL/IOVAR buffer size is 8192.
Increase the message buffer max size same as wifi firmware for control
packets so return buffers can come back.

Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
Signed-off-by: Jia-Shyr Chuang <joseph.chuang@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index 8bb4f1fa790e..f1a20db8daab 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -54,6 +54,7 @@
 #define BRCMF_IOCTL_REQ_PKTID			0xFFFE
 
 #define BRCMF_MSGBUF_MAX_PKT_SIZE		2048
+#define BRCMF_MSGBUF_MAX_CTL_PKT_SIZE           8192
 #define BRCMF_MSGBUF_RXBUFPOST_THRESHOLD	32
 #define BRCMF_MSGBUF_MAX_IOCTLRESPBUF_POST	8
 #define BRCMF_MSGBUF_MAX_EVENTBUF_POST		8
@@ -1028,7 +1029,7 @@ brcmf_msgbuf_rxbuf_ctrl_post(struct brcmf_msgbuf *msgbuf, bool event_buf,
 		rx_bufpost = (struct msgbuf_rx_ioctl_resp_or_event *)ret_ptr;
 		memset(rx_bufpost, 0, sizeof(*rx_bufpost));
 
-		skb = brcmu_pkt_buf_get_skb(BRCMF_MSGBUF_MAX_PKT_SIZE);
+		skb = brcmu_pkt_buf_get_skb(BRCMF_MSGBUF_MAX_CTL_PKT_SIZE);
 
 		if (skb == NULL) {
 			bphy_err(drvr, "Failed to alloc SKB\n");
-- 
2.25.0

