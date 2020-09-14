Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E3268308
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 05:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgINDQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Sep 2020 23:16:47 -0400
Received: from mail-bn7nam10on2114.outbound.protection.outlook.com ([40.107.92.114]:28119
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbgINDQo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Sep 2020 23:16:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQy9J7QzCdyz7h7XXrFMSvhPBNYNwd1JUAeXYjpzxbygrLp2JsfYR2CE/qGnCNuIH+2cASpp4xkW35VV3fXKExzb499otp1IeN6cXQcvioNn4qmDEEntPgVp3EYnLNHfx3jYYG4sMR/N3it0TDDwJTlT3bihYCEVgymCGIfOcwNIIspt0ZHjuWGmDqqnmOvrETojWfAed2m2C/dds2qX1e9G/ceOTJNJ27DRNcZKQXXhHSXY8ipBfDAJIUJo4eHlBeh1JffVjjPhudYPuh8KeYGZpoRyJQVHdmt8mSmZmoMte6nmCSTPD8CnKaReyt+CrEsFST2h04tCTwptShPCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O84zLW/ZI819xftYtxqbkElVnZfnimW7WM19SBMFhGM=;
 b=Epm4fs/6dfIJ/fov5ssqOOlUSYh0sC3YhHbijIdLV7dRjDNoEEL0ZQ/SV9vgQpuNXmpLaDB1ETcrhOrEzGsmeRYLvydqQW+S0CkrCE7kyJfbf4d9BKxvaawzRdKkC84AUqad2d4Fou33QSlROz+1OCi9W6usEikvNsq94dHupTlnelWiUwpuMF9dd8h/CJKqFVLTIdR6MDEtm62tB07vsKs3TzCHHfqJLx751n6L6u2GuO0bCtO+DDuoddODg6cv568US5FRzptuuXCvbj6FwNvoZNJljBsbrNXA5RC3fYN03dKA/WpUM5vCeZ2p7n0AnqKlCKvinOqUA5+wLSOmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O84zLW/ZI819xftYtxqbkElVnZfnimW7WM19SBMFhGM=;
 b=DAx74kpjHypFouEli3nbcgqTRSwHaY+eAYvavwiZZ6BQ+2dJarBGDAgnO510TtvS9ByRVHGjSSXoV2uYN9hK+6rqLPsm0OvUfsY4Yrg8oc/CSSBuEQSqvRzz8c8iRNC10Fm+BoX9EXS15tDOEzvvGE67Y44K40xVh96corCbc+I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5377.namprd06.prod.outlook.com (2603:10b6:408:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 03:16:40 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 03:16:40 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 0/3] brcmfmac: SoftAP creation and dcmd buffer size changes
Date:   Sun, 13 Sep 2020 22:16:31 -0500
Message-Id: <20200914031634.190721-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Mon, 14 Sep 2020 03:16:39 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32e0b931-2387-4f37-5126-08d8585c9920
X-MS-TrafficTypeDiagnostic: BN8PR06MB5377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB5377151FA7047AE7ECE81B65FB230@BN8PR06MB5377.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ELanNUjtdc/1T57GxatNUlUHwX36HIoQ8lXelS4YuaWfnguj7z3qqlxfi3gjLyVdkE/dblVZh/lWPKUZjL826gTe8dsxzL/+bRuWMvZ2txCEUYLp9rfCHptDQz3F9QOf80sdulrjnvH6vtgRvYmY4wN398Eybbdw4jJok7XqqUl3yOKpA88qSxQR/M1K9K0TKcdW1iOdkfs/N8MyMjag7c5wnEctOhNpL3kuQs66TtuRzJZf3rR7z2f6tl2XXcCj63PUJ+7ylU/2F1ZwnwteURP4zQG/BuP2pW7liPygWnXgcKjDdZPKdhokVDLvmJUad/o5HloXqcRthEZz3eTcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(36756003)(26005)(7696005)(52116002)(6916009)(6486002)(66556008)(66476007)(4744005)(1076003)(83380400001)(86362001)(16526019)(66946007)(186003)(4326008)(8936002)(8676002)(44832011)(2906002)(478600001)(316002)(54906003)(2616005)(956004)(5660300002)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IztIU4JDjrey+MT/etTh7wl+LLtW+eyYGceWPuNH1qdUkQUL0rrKvCulA3Aa+0metiQdgy1jWudYJdvOXfPf4bu2N13AEj1bMyjMKEgJZrzLOfou+EHuBMBHIOAoX/ZQPcM1FAz6P+SPZUOGTfU7zAF5CBbVT37LDFf7pv4T7HgwJuVz6gc9Ik3T0lwi+uXtYF1Bp4VNPFtgSi3N+1pTx/NDz2FNFeXHYUEKNL0iv37Pguru2jygRs+QBUy6LtJ394vtNO/PZWb9ACzw+ZkTPHRW9GvwzJYvmxiPtSh1Z7HeMokT6D2s8efKgOOWwZBA8LSKBKmx2bO+fOx2TWPYXMtc0sUQBQDBStfHY3KMqy9FA/MOXFIexGI5XqmtLRV4vSJkWlk+IxKH7oyQ3emw80w5GPfW47o2HLz69dWOZXfBHIYxDpEfofDcuh6avqMTRZ6NJLBlYojYmjDdo8bpODxQJBlals5iq+LpkZb0VXq2+dxXNXEWqSEsDM9+jYi6owVoA8nmE88NtUm4aGwG7zJmkSaAdOT9Wwm1U+rVvyOdMxtcNLAWaOAlmCWnMhb34/PJagfmGeh49/kjwBMe4D/4gi+ms56ouQ8aDthNDmavzreFULyE8VycOtzSmLDYLug5DcOwhQe/xkkNa3hC8g==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e0b931-2387-4f37-5126-08d8585c9920
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 03:16:40.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJv2xcJTZRLRjx5QAmnrugpM8CO48sPyRyHMIsU2OmccoOt7d9qwxa7k1U4T2AqFd8RN04VoxS+mQVWyjHzKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5377
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow SoftAP creation via vendor command from test tool; also update
dcmd buffer size settings for new firmware.

Changes in v2:
 - Fix sparse check error in v1
 - Remove one patch due to duplicate
 - Add more comment in "brcmfmac: increase dcmd max control buffer
   size" patch

Kurt Lee (1):
  brcmfmac: set net carrier on via test tool for AP mode

Double Lo (2):
  brcmfmac: support virtual interface creation from firmware
  brcmfmac: increase dcmd max control buffer size

 .../broadcom/brcm80211/brcmfmac/bcdc.c        |  4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 50 +++++++++++++++++--
 .../broadcom/brcm80211/brcmfmac/vendor.c      |  9 ++++
 3 files changed, 58 insertions(+), 5 deletions(-)

-- 
2.25.0

