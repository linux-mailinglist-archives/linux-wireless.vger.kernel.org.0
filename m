Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CD21B97E6
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 09:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgD0HAX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 03:00:23 -0400
Received: from mail-bn8nam11on2111.outbound.protection.outlook.com ([40.107.236.111]:12961
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgD0HAW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 03:00:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1bdPhg3MptVkr3wc7oCEuca9c1GukIXhTWjpx1Jy9Z/zL1lvKFwWRDM45eDFetYuaN1C1u6ixkBM+chDHd0ehXOBWNlSg+56qVddNeXo8Ubnh8L0/FbSA9OhB1HQPcxlbViDYm8+K9BICvegpAUJfRItM8fJhujSacIjwa7UpBt9O+sBuMj1D4nlNRsRJgbeqAueHTqU2xZR0eVMZ5vqBbqGNKhaB5QdbR3PnuANIkSkdKP14kUgfzPD3bIGWsRYFpHbU1lranP2UR58fZ/ieuB2BK38ZwOwpGwiBfRu/88HhFluA2z73GkgG5RHG11Ku0X7XmvMWwyRs4GfkWPxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd3J4eBxfPYGEMpVHwKdHrkhxaqZTNxJG6wYJF7QpMM=;
 b=e2NCwA04bYHdczy+raZ1TDF7Oxa4gPofz+AtSvl5CHufU8a9Zem/rR7VRZk8YQrJ/fMXlGT77zsKZlslZAADYDzvM/cxxfRJBemF1PybGVABGHh5NMWOaQDXDo543zx1xRu3l8e1OpuNSUE/7m4GXsNQ34pgRGylFIalEEFBVR6fEHXO2NRFhbOhEl0+HXx9o5H5vSnF8kLZCBv5nh9amZmNKQeDdT/9L/Comqrs4ChcTjmQSVMUgB+YUPB8CkXmG34iDOMTybgf/Epjjn4WcZuADqmGztj2zs6vppIEUAMjcu46iJ1a5yYcmGYwVIa7D4kkYFW4eNmf+z7VUQxyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gd3J4eBxfPYGEMpVHwKdHrkhxaqZTNxJG6wYJF7QpMM=;
 b=K3o1zBwZ3lumBbE5jLlz/0Zck7GpdAdHytJ+5GrF3UIUPKMDTn2XF0tsGDHh41R2EuytXLGqVJx2goUmdB6X9Th3uR90MsXOlbTnvSW7MPTKtUtECRbJCK9cokwe+yXIOqEFFDhLU3IGyYl5fbl2kw8Eaarl/JSCYsCZxzweytA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB3973.namprd06.prod.outlook.com (2603:10b6:a02:85::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:00:18 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:00:18 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH V2 0/5] brcmfmac: p2p/miracast/apsta fixes
Date:   Mon, 27 Apr 2020 01:59:58 -0500
Message-Id: <1587970803-77700-1-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 07:00:16 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9268ba20-0d40-42ec-bce6-08d7ea78a4be
X-MS-TrafficTypeDiagnostic: BYAPR06MB3973:|BYAPR06MB3973:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB3973FB6989B9794B1C82671EBBAF0@BYAPR06MB3973.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(6916009)(2906002)(107886003)(498600001)(26005)(36756003)(186003)(6486002)(16526019)(966005)(2616005)(956004)(4326008)(6666004)(66476007)(54906003)(8936002)(4744005)(8676002)(52116002)(86362001)(66946007)(81156014)(66556008)(7696005)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5cj4VB3LCYAzco4Nq1vbpcguAx97jBjoHqoRv5zn9UiUL99tfHl/RyLRbblELndLZWbweKcg74LpZ17uZnDwMpROrNmt20REmlPMDHXYixhnCsW5xVMQtra1CI2PtYTLFIjxnA8O6fpREFsd4/o9SpSy6aFaCWAc/Na10chOUiGMCSN6/OEusqDW0HHItPHW06qzzInb+wuR6op76HeSmPB0Eb+5jzf7HoVrhu4XDIt4iEGhNQIsqwvkM3FpbR0V1dLOIxJtdih83yj5PzgPHRivEv1I9MPiaiajOyXd/LwSo9vjrEHc45DRuoVsCngcMiTmSULCNEPBPMlxHnhPXjbrLj3x1eiz2ynJn86nlDwR1CvDQDcmc/r7/l7Ju0W3NZQ0FOyoHI+dXqey+JnmbPVckbjKTCMBAPMLO0IO3LkxMXEwpCtCrpLqnv0aLw6MFM26OT6GY4+4yYnR4Or6I1P/J6g3UsYFLpZqIy5vkp/Hj+C78yFbNxJjIeLAWdG60BoQ4uxqOTJbW2EEUtKkw==
X-MS-Exchange-AntiSpam-MessageData: 4F+eq7Beo29HRNQfBAN3mC4ACbzwY7fjAKjZ3YzrydQc2krGF9hDKc1OM1pVL7xy7jx9PirvbevsuNG17cGn09xmxDzptDbkbhDh5v0zURGYF94cD0gjEer1+I4aW2pqyGQ/7Aq4Lx73F8dkGtE2uQGeovqNyuoSWT51I3KKQrN99J9OPiEw6iH5XgkeCYas/dATcZw4M7n0BMAfzdni1WklMRY11s3aDhJ2TEH4xhlQKu0QbvwJOv0t5ulme2N8Jg9Azdb7FuUd6809mo+ZYVZ0LknWFBW0oUlhKl490GoETgHphqx5Z7x9FM/t9B/fI0BYucABLPzHiL73UfOz3FTSBAvO32XD25KTaeFcafiQT50JVmioHB++fc/A37gw3yJsQPjbtnJY3Ld2l93/ArfiWwXw/sFQeVsaGN8siHhzKqDrpP9LPMjmWRpjnc8up8w2tqTZr23k2+5kyiceyyQ0t7UoVMSiSSPKFrfEvvoPInrrd5eZ+HzVGWiIJJ2WLh6jw865b7Lg4ufGvu6/IGcCUHWQV044lzD4rfi4+0qwsXgEsb9iZccsLFjVgxR+A8oFKyRiIjsyD418wzgx7xqTMaengZwOc3GWZmx3KASkS2EpzCf9yjXKdLodsdqHEIS3D1EvRJKSYrf1/nIn8fb26ySMsyo4G7mHfT7vKrwpmXvTcbcU3tESsnwj2zDpKi1Yxo+ZfEuzY3Z2JOgloAEmsXb575JOIwiEKVYdc6rVABvdIc85rA1qZvPHmiPfgA2FiOFWVBljLj9b19zoCvhtts8WD7KAEJsl8lJZ7Y0=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9268ba20-0d40-42ec-bce6-08d7ea78a4be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 07:00:18.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GUE8u6iG46NE4roTAhyzNO/JI3gDMTAymspKGejPtlcV91Mnl+uq1FjIrWtK4rsyFACyHTxmgBkLcQavfiUiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB3973
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series addresses failures seen during p2p/miracast/apsta testing.

This is V2 for an old series https://patchwork.kernel.org/cover/10673417/

Change since V1:
 - Rebase to wt-2020-04-25
 - Add two checks (!MCHAN and !RSDB) for 01/05. Update commit message.


Chi-Hsien Lin (1):
  brcmfmac: only generate random p2p address when needed

Madhan Mohan R (1):
  brcmfmac: p2p cert 6.1.9-support GOUT handling p2p presence request

Ryohei Kondo (1):
  brcmfmac: add vendor ie for association responses

Wright Feng (2):
  brcmfmac: keep apsta enabled when AP starts with MCHAN feature
  brcmfmac: remove arp_hostip_clear from brcmf_netdev_stop

 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 17 +++++++++++++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |  4 ++++
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  3 ---
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 27 +++++++++++++++++++---
 4 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.1.0

