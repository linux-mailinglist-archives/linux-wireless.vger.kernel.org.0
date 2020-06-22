Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE3202E3A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgFVCHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jun 2020 22:07:35 -0400
Received: from mail-dm6nam12on2137.outbound.protection.outlook.com ([40.107.243.137]:42336
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbgFVCHe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jun 2020 22:07:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8vT2oyetGoRw1vh7ZKhFSq8Z78jUGNuv6QAI/sg0n1636ztYNQ481WvVX2yqfsqLqGMgMAL/YGIFdq0m3LkRQ/BC0u1ejs23C4aa68vx1p7DV1lh/5zK5DdEcR1hzjV5emnHtL3Vkzpvavn+cKwlqywEDQzfKjzztrWkrfgknNigtrF6r70BEJal7Kb2nzcvbYpsh+2ronUmy1p7EjkWTIsGfVmGdUxZdA+q1a6cQccpW4r8pi20nzue01q6ZHstvcvE0fYMqekR+ve0bjNE3Kb1WtO8gTfMNcQ0yHhqKhGmkI6zheYQ4HU3V72Brajg8LgDfCIE3p1G1FEIxhQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKG6LQy7JTp3YNXCecydB8qO4UuHlzEXvyVLaWQLk4Y=;
 b=FmdC6amdNSE1zIqd6npDf+K9mR4R5WTu33rGe/tn/wVRg1GGQtAzIKWqf3/UfgsPLZE1xeul0e25BXJL5T1nii7G6Q32dcfTqW3tdx3NrbfWRI06HmRWoKHsj7gcivYyS2HiW6chSJ+AYTJDhcH32/7I9IUJ0JtX1VRo9MtV3sGRB4TlPlwOfnkMMVpLnwxIwtsZn40s3IyTUPosTX++UGEKRFgRdqJq0UWRLdekrxjdlTltCDdCwHmchkeJrxNkOXDcfDrIiAQEORKXxXLmSZTpf3wGQnSptGItsz73kKMkfzdUfP4NvbYTpAm2TyNbpfdin/hCMPFeIDX8RGXwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKG6LQy7JTp3YNXCecydB8qO4UuHlzEXvyVLaWQLk4Y=;
 b=VS8RKu/54TAwQ4ZyqaoJ9KTIPZ/JsDqJjJNMleOVU1YAfZ4p25s6Wjf7X1nFbcL4o9uMDQE9GtYd6a9LWWT+X7waR3fvcurDlZGt+8KiRl+nmnmwEqnuKgENYencH87wUjYhyU0TCn8OKqk6nGtgzZkAWGPeyNakonVJv4RKerU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2370.namprd06.prod.outlook.com (2603:10b6:404:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 02:07:32 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e%3]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 02:07:32 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 0/2] brcmfmac: Stability and throughput changes
Date:   Sun, 21 Jun 2020 21:07:19 -0500
Message-Id: <20200622020721.498-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 02:07:30 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9be188cb-3114-44ea-766f-08d816510593
X-MS-TrafficTypeDiagnostic: BN6PR06MB2370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB23706FF86AA0BBAA771A3D56FB970@BN6PR06MB2370.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mD0KrTliiI1lZSNqPu1BiK2zabYhllxYjXofD5IDA8ygUaSaGE1ZF7wWDX77XJqYc97yNa0MWCsqg/LztppyrD0CDmEjHz8ClukQCvCh3PEtSGXczOuwuEYQhpt5PCjIBAvnWqlOZS8uoE5Nh2vVpj671FRebcdALFpbLLSskdM+aRHiKk0lRalNAj77937ZqxTw5Ftpq//Bc0dHckV0SffQACxujtA071g1UQWO4OXxw87MKl6kr3qR9ed4E00ewDL9GOfsyfek9sNTKpc+KJg4dznLnsZCE9ruW2TpRx3SHXp6IAk1ZHOMRiFChHdMk8KobzLpBUjUgXhxQCP1gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(186003)(107886003)(36756003)(44832011)(2616005)(956004)(16526019)(6666004)(6486002)(8936002)(6916009)(478600001)(26005)(66946007)(2906002)(66556008)(54906003)(8676002)(4744005)(1076003)(66476007)(5660300002)(316002)(86362001)(4326008)(7696005)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: iqNFITQaRRFwb7N3dJgd3x91gJHUK0hnRoJ7TFpJcf8GPhlwvEDbISdnA7hkj1EHhZi1egnJR2gj3bXryOQJGGyMFcSHxRF1WxdrAyRfy5Zm+RsVE8PCLJYUZRrQbf3WXXyeKMvHxh02hyhCLl2jFQsN3KK83EkElszSm+So6/yivtfxlcnlCwPQKflxnxUOLMjt5dF2/rdDNbQ/cT6FVFq6pFofEz0fi2PvuHfr8PJp9JHtLzYzD52EylYX9lHsLavgbBIeg3HmCbdT7AEITmW/RQUAzadpLLC4JU1FwSbAd8zCLxmogC/RQFwOPO/kMLVASjPW/6LAmzChT3AqBM5njSVcBgZBj5FGizgdfeWpfTtXr7u5WfA01gSckTIf0iqdkfs+iPh0NVfUF17yxZ6+iEi7zAeY7mXTv7YSWDLJoNkCEL2XTjwDZG3zF+DRfhzWEQgXho8AYqW6CGIzT18Pd3wmAKIALFOOMpIv01gY1n9+GP3D0QRdKrDxVQB2
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be188cb-3114-44ea-766f-08d816510593
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 02:07:31.9514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fmw/bLaVkYquMXuR7G9qc3ZjzVRH67y1ORbxN+e9PQYEdYnQaKeu1xUpL+mZWuECNZj4mNUUnw7goCotAXcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2370
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fixes stability issue and enhances throughput.

Wright Feng (2):
  brcmfmac: set state of hanger slot to FREE when flushing PSQ
  brcmfmac: Set pacing shift before transmitting skb to bus

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     | 3 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.25.0

