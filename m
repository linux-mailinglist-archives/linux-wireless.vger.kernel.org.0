Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90C01F579F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbgFJPV1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 11:21:27 -0400
Received: from mail-eopbgr750110.outbound.protection.outlook.com ([40.107.75.110]:38746
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728446AbgFJPV0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIlz5CHbGK/912+Jpk5+wWF5fHJMVmfO1zPBAY/XP1hG4mrMHiqN8CL1AnDXeuHqBxPACq44x2j0JEA7WxyEsMv/EG18G+vzcuBMIY4Z15y4GviMamgxUKZ7LM51y8q+2FQKVkxMf0ONS1gPkmzqHo9kdMgCU7PMgxUfhyAc6Xg4W1NoQQ78TfQ6Ugr0h9rT2Bc0lzz7jU82LkXA5y/Xcs/jn0pfGoekUJaxPurzScHiY4UV2R/HR1s8wESpy0WTxtH1rJXVCml+Z8IszGdKPdEc4sw9hXx9U68LstYrzV/oxwK4ogMbY8LQ5HXfXT2gMIBW3dQD/3fN1WvyueGjCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgHi90gclLmqwIbuKaHiH64HqaDm0VrmDfo80pCUMsU=;
 b=DDYy1ZT1majqALsPY+pSB5WurE+vwrO/DuZvFzpr63qs1SXFneAdTFJDuVJqutbh2/UwZdM17E0YzydutWLNC8Qr2oQoSpD5Vpb58CHbHp+WoEJFN2sPlaiKv1rPceaZTRp0rW9EaC0ssLya3fP8HC9afibQ5MQ2QKI6SFim7qYQAIF7lRJXq7RFWgfNqq6KXZxj2tRRwGbas5dXCAGDu2lYd7ehzc9lhiI/EVtGf351V4juzTPQm8k0ewLIacwAGdBco1JkBkL4UdM43iPJSQAP1MGZDNr9uEIjN97p7PRgOasJLeheKqy+lqAoQ6Tbw1spzVNfpH4+ER5hITIbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgHi90gclLmqwIbuKaHiH64HqaDm0VrmDfo80pCUMsU=;
 b=ObiPp96ImrZWGNh0cl3zaWvbjEETICGsmR/rQI8CbXhtvmko0HjD/96vfXMdhsoNNFLlwsUZWcYRNlC6ekBjZOnkCOOlT1ozTabOKMhwL3jimhF31LAFbv/nAjNWLWlfDuc88XPqzJkl4/gQOhgfNWOjCcv8AvwfDA98y4ydVXg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5621.namprd06.prod.outlook.com (2603:10b6:a03:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Wed, 10 Jun
 2020 15:21:20 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 15:21:20 +0000
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
Subject: [PATCH V2 2/6] brcmfmac: increase message buffer size for control packets
Date:   Wed, 10 Jun 2020 10:21:02 -0500
Message-Id: <20200610152106.175257-3-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
References: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 15:21:18 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c5eb0b6-1c1b-4c97-46ff-08d80d51ed2b
X-MS-TrafficTypeDiagnostic: BYAPR06MB5621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB562111A37F3155B346AD227CBB830@BYAPR06MB5621.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EF/X4/KrBsjPlInZylv9b3U6M5Uw9cHKv8KAt0WjI/XiTpM6i1VVIoTsZE5jl0u4cT9tdbzGw5RlzXCGoYNt0RYQt4QfTjOZXUBfRFfEjkckWa1fsuiznEjFc+jQh385RETFdJfUzGIUrxZ8/yPp6TxZ1nzIb4dXCkWuak9GLPDQcpNj4snF96uJchJssQW1LMC4h73fOLMMubZ54KzvEY3szS+7O4M4YadN3eFEcBSFsd4/l7QtDQW780ojMAa2vQXfNSclPVmJtVBHdmRpLFLqiGDlsy6DxL/O0CnSwSwa7mOVmwr806ynRViz7FV9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(16526019)(107886003)(2616005)(956004)(8936002)(26005)(1076003)(6916009)(316002)(6486002)(186003)(6666004)(2906002)(8676002)(7696005)(86362001)(66556008)(4326008)(36756003)(52116002)(54906003)(66476007)(15650500001)(5660300002)(478600001)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vC+NPcD8dM1qM1DwXRfI+VZh/2YEpdxyeuJEJnRFOfaHBYgvHZSAKZLtOJBb4YPO0qZjuexUPobnlUIhhTsb1Q7QOw+igrE/Oohvi7UmuXaqGccxLp/uOj+nrAkmJb1ckCzZsFqhMSboHmbZ2iWmz69xJMGuEQSty1ILmDxSZ+L9AMNkuC7ZAyFcqA1n5ip3Ogn6Gnily4q5THp8snFUm05ysrKtwkBu/TaT5rbUsNVuluuuJDx4m2WEpwh7Bg85B/Fc/VWvLp/arPYWlBIn7criaMYe1AswDF82SQ7NYRbRU2m8AM83eH2BgM7j9+8n0znqrn8/ZlHKjuuIvppvyXoXkPItswr5LSDmOqzl0urYhTAmqf/rJMoPj7xu5lqzTXi/6rARzMInFYIn3C2NviOwPmtNizhU4YGGxBy1R/M+iwG4GPkDqvKy8a2HTbE7APKUZ9EP+uBDmNL/7c0wb+4P964YpwYjZH4mon4BjCytR9jO+/+PkVt23V7BtfmK
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5eb0b6-1c1b-4c97-46ff-08d80d51ed2b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:21:20.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: USrH0mJ56hp01ppGZZyynHGT84eBdQs2b/2QKLdetZx11yexNOfm73GBxHOMvi/trvMX1wsMpZOBFzM3bHYC5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5621
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

