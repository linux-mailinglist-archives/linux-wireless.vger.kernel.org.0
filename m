Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B587718ADA3
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2020 08:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgCSHxw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Mar 2020 03:53:52 -0400
Received: from mail-dm6nam12on2100.outbound.protection.outlook.com ([40.107.243.100]:45696
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbgCSHxw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Mar 2020 03:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHujjm72l2slQdEiMrTVM2L3FJHcz5dW5nlFhji7CE6dGgQlcq2OX//I8WJGVgtVua8AXv37VrydOHC0Vvr3SWkBTCLXI7pM1AkenQ/2ZDFymXrGI3RT040m507uSmaSQU3x72QYZ6HX0w7C7ynr+lHVLE1dPFn72z0fJX0j4AcS+zxp6Hdx2DA3zwOwMQdGBQA33AI+HvEOHrTu/beEZ0ezfDSRzac15ntJ4HPueWzNJjzeHGBfA/xDkjk6LHj+xV7MqHvnCBuh94zoQhNYR2mk7Dbrfw/HgB6rdJjPFzBj9iukHWhuJuAJXfa4qCNF0C1nncjJTZYdch+CrpzBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8TDbbYAD6gl7kgZUMz1ybJmwgXWgPQMHUtLrR1pyCg=;
 b=ZzWmulKReaU8Gm+AeUn+yqt8TpCaAu59y8QCM1gr3viuDKqHdTxLO+yZTCZaSsc8zkUsRUYKhs8acg1KlkDBSsE5Crzs2BzashY2WLQb35EHs/51EB+lpXNmEz9/KZdaNBExqJY9TIxVebOE8I0Vovj7CBV6s1d5nJRpTX+5ajmal1/7NW2lwTsEfeGNDhvrzoS7ov0rLAy3DUbuP4QQb1z1nt6AIqZfgsAr9ySCtVVrTCA1bWVyyMdRxHAlUi088GWnYc2+rOxyf463s2CWz9h29eJrVWKQaBYLgDBhBq49aMtZkdPf8QyxlYnVPxDhfq6F7E11sb0tOiCCHBZbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8TDbbYAD6gl7kgZUMz1ybJmwgXWgPQMHUtLrR1pyCg=;
 b=NsU3x5vgZoBQotEPAXf4+mVzIYG0+5f285w9FxdFMSgbahOUbtf3IqeHc2QRTGtzvaDayNB0Aq4tin4OQJIevw9VnLFwdPHsMsjG+Pb9UhYBwCs2ByIjSvOIhD+pz1Mlah6jruU6/epIEZ/126GP3tmFo1Z2bKZo5lowjp91tjw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4585.namprd06.prod.outlook.com (2603:10b6:5:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.23; Thu, 19 Mar 2020 07:53:49 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2814.018; Thu, 19 Mar 2020
 07:53:49 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     arend.vanspriel@broadcom.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@codeaurora.org,
        chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 0/3] Add AP isolate support and two modules parameters
Date:   Thu, 19 Mar 2020 02:53:23 -0500
Message-Id: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (12.110.209.245) by MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Thu, 19 Mar 2020 07:53:48 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f47316f-3acf-41e0-11cf-08d7cbdaa8b3
X-MS-TrafficTypeDiagnostic: DM6PR06MB4585:|DM6PR06MB4585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB4585BDD49EF0EE09F03EA1D6FBF40@DM6PR06MB4585.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0347410860
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(136003)(396003)(366004)(199004)(44832011)(52116002)(36756003)(8676002)(81156014)(81166006)(8936002)(6666004)(956004)(2616005)(316002)(16526019)(186003)(66476007)(478600001)(66946007)(6636002)(26005)(4744005)(6486002)(7696005)(2906002)(4326008)(66556008)(5660300002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB4585;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/7fz4D4gajt82uOhH5gU5lit5L5USlGzKrOKow6l6+GYB6uwBIeXTD6hULfnG+Vq81H6BGBZdGxyzi+DwNcO2VuOTiN67Zk4+a3pyIbeX2Vq0bJoUpOOBhGTy28GRuJGBROL7d4OOBPLGD6sRwAxL6g62aSlS/fCsml0fRWB2OWKgmYF5/4iqzlIrI5MgFNVfuVZjZ2i8hE/bj2D6kqWMVZzFaM46bSOFY+xT/T9ef6IIjl/hXZzbZy0lCc4TaIFSrZCi8kbQqVDU0aj4QiXzDCtfgd7XV6SWZkpzu70v0omvJxaaNHKAW+imjXStmD01MMFDAO5clh9vYADSkBAW/CKVCXLJABBqFEfXnobsWjP0juMsCZyuBnM7IyoVmtOCz1FJaeS4hv2L+eoBm3mCGMs2gfpG53OJgYbzcl2WOQ9oWiHuoC6mIOAyhNBj+T
X-MS-Exchange-AntiSpam-MessageData: L6BjBv2t9w2B8jgLiC+iyCPym7i1ELOplUw6Tu1X3Tlih0/nEJU5Q3qox1V7rAegIlBGsvc70NfOGCNc8z7RlGoT9a289xNMbfJ8h9mRkqaRXrqZtnhykIoNeBJE9g9JuHMrK4CVqLVkrKxKraDuUg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f47316f-3acf-41e0-11cf-08d7cbdaa8b3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 07:53:49.1600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FdjtM/LkQlbaTPa0IJCMOFn/61YFHPVP17KrfkxuYguxyO4MZYEMBQZY6wEY5RNxUcUNMuPo7rrfgGLfBUzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4585
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add AP isolate support and two module parameters("eap_restrict" and
"sdio_wq_highpri").

Wright Feng (3):
  brcmfmac: support AP isolation
  brcmfmac: make firmware eap_restrict a module parameter
  brcmfmac: make setting SDIO workqueue WQ_HIGHPRI a module parameter

 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 30 ++++++++++++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  | 10 ++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/common.h  |  4 +++
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    | 22 ++++++++++------
 4 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.1.0

