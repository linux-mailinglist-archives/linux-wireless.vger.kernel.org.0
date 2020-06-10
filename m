Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F621F579C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 17:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgFJPVS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 11:21:18 -0400
Received: from mail-dm6nam10on2096.outbound.protection.outlook.com ([40.107.93.96]:58272
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbgFJPVS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 11:21:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImSEO79UG/LeQBrtKNjOg2UDUdORUOi5xGHciAD0ha3jsL37yl+V4Dg6uEKNTOXadFO1qprKi7Y8I9UzdHcmRabEby2Hgv9P4o3jYQnc5fiSsWZAd8uqDhw3R323NUxRk/+l7o7Cpuf2FLdcY2lkIS4lUgZtkpj7hnG0Z1WZnoj9UVh4YdXrGm/ajQGhDRngmcSDKtI5KSVPCnR6/qlZ19fQbtg7Y3ECzwH3e2TGSZOvPWwjneCbV8iv/s85/gGo/DO/k+6C/n4BejDRyb6tPzS0xDJRkk3N2KNQBKVCmq9rTP04sXnUnZNqqX9HClhjVTl/EeVrahciHGW5vOlR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij20CdO25IvjT3l5fuWEegzjXHmQg5dDoam5ZW7n+94=;
 b=gmTAg22m1DnSxEIKytQspYrrpQ+VHm8NMBKsmggDJoBGhO6jG3eW4+YB/jUOcjW3+sZU1Y2CpwAXFjPomcE3m0O01j/1WX/OfDZx9/e6zEsbrliGnbhcAy+pQ7j8zWwj004scR409ErQdT/YIoc4YkiUlXSshYvjrPjbRTRqV/v969R93AmJe2oxxtDm57TXLz6+PzI+uU/rTBhP3blgb60QkeO5SzRtTbDHxZ5xP0cMP3QJr4k6uEzFPneUq92ZHHCaQ+eQC/4vl8FMeCZY9Nck4tFOo6YmOVlM3FoudFpKkmCxXqSa6m+2Yhk236EFZ6xjhI3X9haheEzkAyJ/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ij20CdO25IvjT3l5fuWEegzjXHmQg5dDoam5ZW7n+94=;
 b=Sh2e+fbZZyhsJsEOrHG/Yo8ABQyMjlj2iaZ1mTGVmv5SNwZAw/zYdY3QoOTC2NDXZqx1kwDCtQFLhKWNNyWDIoTRM7nCuGtbZE/FH6AjTtTR1T6LxRG6agtGHE8WoJU37K2/BENS07xVYYnFNVI9T7jVebllisN9X/IYdbTh+Us=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5621.namprd06.prod.outlook.com (2603:10b6:a03:ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Wed, 10 Jun
 2020 15:21:15 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 15:21:15 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 0/6] brcmfmac: flow control and p2p fix series
Date:   Wed, 10 Jun 2020 10:21:00 -0500
Message-Id: <20200610152106.175257-1-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 15:21:13 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 963b1c89-fd6d-4594-0b64-08d80d51ea35
X-MS-TrafficTypeDiagnostic: BYAPR06MB5621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5621FC91C9BDBD8B73D4EBA9BB830@BYAPR06MB5621.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvzaPrdJdkj6tF4DZcOz6fWMKUwixNlOdVwqWFenXDaPhkZ4ZTWpm8kmoDQ1ASbe4LlZPcF6Z1xnDW/NB6iQG8B2Kp4m+gqhXkLZo++y7ztty7Y4EurYl3dxYdayv6T4cA0MC5QUdvEXmOxcM2cuB72LS+i9QVqeA54hK+tKZ+5ehFK1EElbk44Vr97X/2M+YfDx2gRnWLniu7t8c9kQ5iLk3wkH27Wk8aya16YLZ9hFaJ3/plWyMWvuJXuJOnmSOnBIUTwkVg2qaFzsKdBUDYnHV5RuFwlhzxHl0t7hLcbRZgv66jaohBKITAasc8Cv7zpoAwJtRmvTWaeyH8tPUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(16526019)(107886003)(2616005)(956004)(8936002)(26005)(1076003)(6916009)(316002)(6486002)(186003)(6666004)(2906002)(8676002)(7696005)(86362001)(66556008)(4326008)(36756003)(52116002)(54906003)(66476007)(5660300002)(478600001)(83380400001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6VlS7x4s5lEyDRvf4BblrLURniEYn32FKASe3EpGvnOA3x+Z2g+2Ng9AWeNNw3O7YsxpcFFD6eIzdvidU9EX6Ct2Vcv7DsBf7z74+sDZHbjTjumOHJyg0mDqZv/IjISms4fc/ai5TPhujJJP4u+mT6zGYLyNU4pcDYYeqioSr4+yEtporzaku5t3nhQwXgehmPAghRUIxFQHIMlo6uGCLG1XEkW0HyakT8pE25E+ueVZ7dMKab2kYSZ3ySO94FzP3z1eJ5S/NCmd53AcsoTirciPPEQqfCUxyd0keNTbR8o5r6q9xO2LFtbY0E9QzFabWadpTAsKJuGu2i3+W7GRLTu66gCv4hvnj9LO3u1f2hL5A+r93HaaeIZWKloluAQ609mAuCwYs9VpzQgCLs6hUoG92VsktFfHgWAdOMrA7IG14c9z9f0aBBa+k12GVJAR6+pXC8G7iCdWu/MTZMo8/eiUL8fscf5H0NqF6UrG1jEBQHFdtHMCp08u3xK3aSwW
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963b1c89-fd6d-4594-0b64-08d80d51ea35
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 15:21:15.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoDM3t48iAss7Cr35lUSbrg6Ls4qGyRYZhc/Y26GgNa6jZHUPAq15g9qDndSevaY4ny77URHrPQW6yL0/qmMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5621
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix WFA certification failures due to flow control credit issues.
Also fix an issue with a varialbe (dwell time) that is not properly 
initialized.

Chnages since V1:
 - Remove unnecessary casting from patch 03/06
 - Correct a s-o-b email error in patch 03/06 commit message

Amar Shankar (1):
  brcmfmac: reserve 2 credits for host tx control path

Chung-Hsien Hsu (1):
  brcmfmac: update tx status flags to sync with firmware

Double Lo (1):
  brcmfmac: fix throughput zero stalls on PM 1 mode due to credit map

Jia-Shyr Chuang (1):
  brcmfmac: increase message buffer size for control packets

Joseph Chuang (1):
  brcmfmac: initialize the requested dwell time

Raveendran Somu (1):
  brcmfmac: allow credit borrowing for all access categories

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  2 +-
 .../broadcom/brcm80211/brcmfmac/fwsignal.c    | 68 +++++++++++++------
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  5 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 19 +++++-
 5 files changed, 67 insertions(+), 30 deletions(-)

-- 
2.25.0

