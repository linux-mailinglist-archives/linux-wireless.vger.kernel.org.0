Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 935B9192280
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCYIVG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:21:06 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgCYIVF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+t82hd20CsQBvEFjMKutsTlCe38gf4sAtmu4COcTeh0Dv56G1vWAK4G4y+mMVJi8adkvqAronhd5IsdmjWrRnys0MXArQiboE5yAlPCfx65y5/7H3O/5zS3DS77oj2KJJBv+tlIjXTlU8CmgHGqbNoq55onqUzzW+u+StS94mLsI5LVZSTzckw/Yx6N0uGN8c5PMH+66W0UxONiSBqmbX3QHMbYeWPUTUljq09iIHQ4rG54vkYQfBI23m/ECDIoHiy7Ks1/Rs+84yqhmL43vUFq7gXMh8WrAcCpdGpVGioAxjw1sCEt/O0t8ZYQWQEhqfxKxUfp3rzhurCNY7dMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVwKgTRJ+ZGENUgkjH6k1eLuK8rNyFEdHOaSWhrh/ZY=;
 b=WXq9FD9lvi7QSE0nk5gEfrCzyfnA1ptxbBWk63wzOXvC553o/ZHPq26ZrGKw45kbWD4d2XBrhgwrdAhQdHQSfFES60jekBHtfc28Keo3xXOTjLCW6qG9EE4iZuEjTicptubeGuA+b7BsXiiNKcQZUyvL401ZsgCjNnH4GwE2BObcOp16qcy/ttGLSzHzVTujRFv3ODZLRmtHravTVULqbL3rRZLsTLL+DvZ9PEJLRdOn6j6U8pFzWZEXyrEWlc4jXvTBAYJWPa4jJQuObzyM5TC2WoAub7fL7ye3RmMZ/hRLpmS7zWtq6Y+FX0rGZcFYLqHMk5Jt2o7NTSHlGzI6Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVwKgTRJ+ZGENUgkjH6k1eLuK8rNyFEdHOaSWhrh/ZY=;
 b=HDeUcEIYHYL9nihX3HrIiLpsJcet0d0lnSsfvjVfsFcW7+s5XaT0ovoUYXP8aMx+0g9Tx7Rq+na/MZjsrUIa5QamGn019BZdNoFvoc5ekdGrzJifgu/9HEKidbQ1yP3VnjHYqUY2/OAG+Fc9KEBnfLMwrFENMILb5jzG/rMuEhg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5189.namprd06.prod.outlook.com (2603:10b6:a03:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 08:20:56 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:20:56 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Madhan Mohan R <MadhanMohan.R@cypress.com>,
        Madhan Mohan R <madhanmohan.r@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V3 4/6] brcmfmac: increase max hanger slots from 1K to 3K in fws layer
Date:   Wed, 25 Mar 2020 03:20:27 -0500
Message-Id: <1585124429-97371-5-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:20:55 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 537b9879-a7af-4130-aafb-08d7d09570d3
X-MS-TrafficTypeDiagnostic: BYAPR06MB5189:|BYAPR06MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5189FBA50C684119ECC89EDBBBCE0@BYAPR06MB5189.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(66556008)(8676002)(81156014)(2906002)(66476007)(66946007)(81166006)(6486002)(8936002)(6916009)(16526019)(26005)(956004)(2616005)(498600001)(6666004)(54906003)(86362001)(52116002)(7696005)(186003)(36756003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5189;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBT6cIIWMcgegIMCJ9Tej2rtByzHPUv3gBZramKQcMAXxspj8bHwAeDlVaI28r8EUlbdJArhF7sDAEN1DpgyzWQSgJuIT9DuRlSplLPAcBALQT2cFmuO8D+vHBrgx/VZaklH4rD1W4yxLQjLCEAN/eq+2Hp3CoodF2H5gJpT/LQZHaVNMUMmEFBsiMMSlgWw4Mfj80FBWGYA67P4Ykl+VrUx1WC5G5ng2aWB//95drr0WptzdsLyK15dOmjrmeIznXnrsDwGtb6XL2uRW8MwyUCV3Cx8bt4MJiKaGVw/XZQrOzvM3zTr5NnkYk6mPoiQc1M3Hb3cJOVhZoKj8PSmZbOm1rSC5Jy4l5YStEqNKVFnvr1dFz0ATalezn0Q8xZt8O+A8ueNN+S6nhYmzeYEs2XLM2Ahlil3i9nuHEj1gNi1ugeIVwUJjI/ijH7ISqdP
X-MS-Exchange-AntiSpam-MessageData: mPlSbElvCi9Aile8ySJbXBSIyuaz/cWc1FbICeU/Cid2o4QemnzjB79lRIe5WlsQPjT6KNUDNWLSdX104jAN/4mE2mVFrUtXMTCj8Sm/y3yKBIsCJglO1hxqbB//d5Wf302EI0TZIAam6RKemsrLgQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537b9879-a7af-4130-aafb-08d7d09570d3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:20:56.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hOJFknIx48dV12tdj6rWPZEEqSQ/Y2RwpdxpqpHYCMLuK+EceEIWFWiobXMgISvUWu0kskFC/SgxMNWH8z0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5189
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Madhan Mohan R <MadhanMohan.R@cypress.com>

Will enable FMAC to push more packets to bus tx queue and help
improve throughput when fws queuing is enabled. This change is
required to tune the throughput for passing WMM CERT tests.

Signed-off-by: Madhan Mohan R <madhanmohan.r@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 10022c765354..8cc52935fd41 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -404,7 +404,7 @@ struct brcmf_fws_mac_descriptor {
 	u8 traffic_lastreported_bmp;
 };
 
-#define BRCMF_FWS_HANGER_MAXITEMS	1024
+#define BRCMF_FWS_HANGER_MAXITEMS	3072
 
 /**
  * enum brcmf_fws_hanger_item_state - state of hanger item.
-- 
2.1.0

