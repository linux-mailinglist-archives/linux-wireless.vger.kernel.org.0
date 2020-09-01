Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2A258841
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Sep 2020 08:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgIAGcu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Sep 2020 02:32:50 -0400
Received: from mail-bn8nam11on2090.outbound.protection.outlook.com ([40.107.236.90]:25312
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgIAGct (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Sep 2020 02:32:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8a7MamICYzcnqzfAQiu2CFrLGw55XBwDYiyLXr8HAsjk1ylTHbDRaLPgsOql39WJPkjRncgvBA8VN7w3y/X5HTkaGSoeDIeiJ8t6DgBbKdZfjv8nKjc1ftfLTxdrmQdAUqXbF0JkCh6AK47JnhfhvHonfIIcfPrD5xf8vfhEG2I35lrIEelWiO67Glxri/O8tpFrHOPTXe43jMrAGVBV4JH6GfSP/RIXCXcMQvABIAF05WkI5v8iLubu8HmBbAMVvizuA91VXQ9UXwx8EKHXLtQTbF29zgidjZ86RtWuw5OgwfoK4BpAWpWZgeEjw0wAZshSGCLaT4lvnCTtnIY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC156aEGiJK/JUgUAcSV/Rsv+VBjmfiE8df+q9tsdeA=;
 b=F4qW5Cicn+crNvFl+r49KojW3wxGRG8kZia4mVsJxSKU68BpqCF6gO80+sNtq3iVKqxX4jzsayOdQ/bEX09JumNvo6H2KZFgqLYEiO81WoH/WeH1fvb8A+A8KmVkwUHpih7f2JzNpfsmmG/6hrK6Dm0BidspqfYCG2bxGeOcCmWLWAI3o3Ve/QyJ/uPpTnFbRW6udtH6dqAyJKiw93de6mIDj0JxrdT9OdSFy7BRwmXYIe4gPgWlIpmUc0UciwGFj23vcm7jbd4PUf5AsX8fSXuwMm5vYr/cokdUveRC9SVpJoghC5hbnMo3CWw2DP0jEQ+QeirNlknOHGE+oyNb0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC156aEGiJK/JUgUAcSV/Rsv+VBjmfiE8df+q9tsdeA=;
 b=FSRazTdo/V8jFqjIgGMrPbwRwR6DMPaQu+Ox7/CXOXj+nLdtxvbjLa8VRF7BFLzjWxmE9G52KlIL8MLoFXa4LS7nwrhWA+KyqmzgXzLZIxs+rCmZRw6J8KCXNuHtP1pKNsKP+BkfKGmt38JYd/cvmERmU4MN8FhtcOtChmA6Ok0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN6PR06MB2867.namprd06.prod.outlook.com (2603:10b6:404:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Tue, 1 Sep
 2020 06:32:47 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 06:32:47 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 0/4] brcmfmac: Add few features in AP mode
Date:   Tue,  1 Sep 2020 01:32:33 -0500
Message-Id: <20200901063237.15549-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 06:32:46 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 809e92ce-d83e-43ad-fb72-08d84e40d74b
X-MS-TrafficTypeDiagnostic: BN6PR06MB2867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR06MB28674040E226A508FB3EA51FFB2E0@BN6PR06MB2867.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3RJ1n6qwlNx0eA44Y5iOCo6hdW+VjiYkm+IznwcaPYJV9p3Ib+n4k16IYbcgJIeKuo+Xz1pdeaUThsYyzeRHtmEO6820WQrkPwwG3UbjUOlAh56sdZeFkKMMcXovSK6vMuzzgx2SNPU0s7WeekrioISHlZ13FIun5hlWHPxQFjFkL6zR69kc5xn0vkghTSP+0g/0GdF6W6hQtp+aogTEbKgOg7Pvwn3BSEvJ8ncFO7EPBrBQM/tqqN7zmJ2h3jz3wT+q/aynSavNPSA1RDTBpbZgzIoMYr4TB0E4FmB/hPmFIEhlt29zrfFHEXXIatDmKPdG1trnNybuJNuNO+7VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(54906003)(478600001)(5660300002)(66476007)(66946007)(52116002)(26005)(66556008)(107886003)(4744005)(4326008)(6486002)(16576012)(316002)(186003)(36756003)(86362001)(1076003)(44832011)(6916009)(2906002)(6666004)(8676002)(8936002)(956004)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2lueH37QDGwVvHosc7VSdCJDTgF8mnFuxrgluJRiAi/dgPjFiPAOLN9x+uuoZfvB9y9NmwTCtU/ipBLSIG36Jis8aACACbdSgT3R5WbxFg5FdFgQ0l4OdDYVIuq066OLBar6W96NQ0Dgqd5hgUIW11K3U6r3dOoEko9fpm4ZiOGqmwOYBD4Clu3uCB4KovS9iIieL3+CdrGyKIUtyYrQPjDJcShki3hfZsQZ/yGTE8AkUREZ1mfZTmXTtuffIhqRN5E8jHrrJS1KyH6TXcAUG29VdohxamhuNVDyw4M+eGw8SXHjKiMpGDIxQjja68HJ/3azMoYTqMMzt/GH3WOsu9yE0JvEIP0qXr/aoJ01EEAcshlX9Ujz7qarfTXEqm0pDs/px2bTXHv9OgRY9to8y7TUoUw2G0Og5kdL4cAsEQwKKBcOy66ssskzmm9iTo83efb5yHC82f0ryc4t2i2EQOK78kPgU7fc6c45QVPlAHeIKEKe+qmKd2Vf1QJzwQ9IFWPLLvSJGBV+A6N4fMRbv2zx8J0NEBitUw5+EAVzgZ2vjlnpBGlBbQcWAhmxEJ3JLhENy+Xy8nQ8JYsiM9Scpk7LEval05mIOF3mj4NBcFIWa/vU8vzPxcIfxSbsPBCOv9fing+TfTPRPinyh62VUQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809e92ce-d83e-43ad-fb72-08d84e40d74b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 06:32:47.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYZGm3eU634KIP4dbxvTvtQ6Rz9RBYoaei+uAX5o/gtumVroeeqq4J1odj3sto2TaL8GdyVtuSSXW2VcGWmLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB2867
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series add support for AP isolation and forwarding mechanism
in AP mode.

Jia-Shyr Chuang (1):
  brcmfmac: support the forwarding packet

Ting-Ying Li (2):
  brcmfmac: don't allow arp/nd offload to be enabled if ap mode exists
  brcmfmac: add a variable for packet forwarding condition

Wright Feng (1):
  brcmfmac: add change_bss to support AP isolation

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  64 ++++++++++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.h    |   1 +
 .../broadcom/brcm80211/brcmfmac/core.c        | 105 +++++++++++++++++-
 .../broadcom/brcm80211/brcmfmac/core.h        |  19 +++-
 .../broadcom/brcm80211/brcmfmac/feature.c     |   1 +
 .../broadcom/brcm80211/brcmfmac/feature.h     |   3 +-
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  31 +++++-
 7 files changed, 217 insertions(+), 7 deletions(-)

-- 
2.25.0

