Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F093028B07F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgJLIpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 04:45:14 -0400
Received: from mail-eopbgr770128.outbound.protection.outlook.com ([40.107.77.128]:32321
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgJLIpN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 04:45:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biu2Blv0BvgmWORa1my07kKfMik+tkioliYgL4jz1ixm4xh/sjKBpAgq8Vkx+KnM9aPIzygcJfATznUE09SHiO1u3JW3hPe+0TEYwQZOGho7apb7HmTgWOKFYYaO4pyswiRLr9GkodXc6xCYVITIWZS+HcppYvCNn9jGrri3RvPf9MvQTRBVd/RUOA/hd+LRr2KwWSlTmk4EKjOGpVRpwYExi0Ic5N7hMxFW0iUS0rD6U6ywah3SZJT8MLMUNGDydPETRChPdjU9e9hBqkYTtUhgGicgV5INIj1tI3VZ2JuPtP3KFhlcGeVM81b2jcYGmcwD91MRji9cShPgSOvphA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTcoU81N8bhka1yyP96GOI70yJzrabSEnbpmKnByQDw=;
 b=PRh5yXDqmw299c5FVnH+eRHa663+oDtkEdJXnam8+IgbpUFzyvazRHQeo9trs0tH01bWHWzVkzZ74UTGqrwdyjquho/5ZeT9N4jMISGmHiMmfFKbKn/Oszbbtrki1o4Q0swr8hc5vZj1YARMnwzpCF6FAVQQatERCwEdcBF1SOxh4kQPdYye4avZLwaqwFzXYB+uf+lJ3yu9fC5yBfR1iabw6BfIPOjLTsczuOCACcwHQozT97j71DTAED//d8vcf1z46yegtyuxcG7OH5vgHVTmuMbxgtdvej7HfMEbWXiNdQCU2oqCUdWbAYY1pi7zzYG168rFZwFHxUVrKkKZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTcoU81N8bhka1yyP96GOI70yJzrabSEnbpmKnByQDw=;
 b=gruFj9fypglzvJtkWTW/apRV4jXFddCOAvuUJu47XAGeyXHW24LY2CmXM8170nCwHSwgKwhFXPzRV0yfS9f+r8w7A51Zq4Be1AJe682fO28KjWb+gTKW0nA5qUNEwmZnKmveqe0qXnbM7fP4uJrPHzRk5QR/Ph7wAR/iHAyEIKM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5380.namprd06.prod.outlook.com (2603:10b6:408:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 08:45:01 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 08:45:01 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Subject: [PATCH v2 0/2] brcmfmac: add DPP feature support
Date:   Mon, 12 Oct 2020 03:43:45 -0500
Message-Id: <20201012084347.121557-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: MN2PR04CA0033.namprd04.prod.outlook.com
 (2603:10b6:208:d4::46) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by MN2PR04CA0033.namprd04.prod.outlook.com (2603:10b6:208:d4::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 08:45:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df85391d-2564-4f8a-e0ac-08d86e8b1b16
X-MS-TrafficTypeDiagnostic: BN8PR06MB5380:
X-LD-Processed: 011addfc-2c09-450d-8938-e0bbc2dd2376,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB53800A5CE1C219C1F39BAE51FB070@BN8PR06MB5380.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mB8pIf8lz5aRozytU/sYuJva7ZaRrvG4Kpy/9i6Y80UqTGx6Yj/7KL30sJ+r8t1Q4qd1YT61yrYc7TUxpcgyre1xkD5M7ptibw8V32dPEpK77HOsTSBAxF6tvL6j84IBoOd0vwcPU6qVTcsQ0wPtQymh1Oh3mDn3noOErmDSZN83hXiXW/rrWrkkd8ntrJfg0buWCFfdExdV5V2caBwKFDGD7gWZuHzWd7bfU2vwUaBpc8SE/pptNbl6D5n+jRe5OOFqmqBrnUwODOXCC54kA5LCzSUZ2UXI9F6dfS4EWyGNy4WyOrye+R9yWEZr8KcA+ErXCDA00B25YogdsXQiMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(2616005)(83380400001)(956004)(4326008)(86362001)(316002)(16526019)(52116002)(7696005)(5660300002)(4744005)(26005)(186003)(8676002)(44832011)(8936002)(6666004)(36756003)(66946007)(66556008)(66476007)(6486002)(2906002)(1076003)(478600001)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NHQA05BLedh6Yom5XY1BtxWr4v4l5Lb8tQOXa95M3n65jxQ6kzUypDfDwPQpyVhsux2UW9tw82mLBNax+wuAQm5JGtavv0gHc97cTSXhWjLM6EdgJrzNTtxXTBdKHmAX79+NMiLOw+IwVuDmiR5ebFHZAtC+9RWBRljwyzKJHXfYixzS3IATcS9ERnyAli0do82lmtYle9HsYOdhLvrG4KUJCrQGWRHrCbq+BgjZTRIfb8oda+fXt9oBk6z3DlmmL4RKAKUucr/4QFkFKl4+DvpTb4oEYPRZmQYkhwwZrpz2BiN1CmZOfqn8FKQCM2YYOXUFJ1YtPK57nnbWl6BZbJiphMqijBhrcQXYeJd5rpkLu9f1GJSvnISJy/XFIDXYcALr+fJGDEi8O+BsGMNLmaM+IVY2r/zjZurqAvjYbTureR7YTiCbmEKWECqyEIzWm1uNkcyi4lw5jj0XtdI1A9S7+T3vO4ig9+PrWa4zKl7siyeLz0r2X3fXX0Zmjvghpbu/7N5MW128mF2cHaWBA2sTPxKJEyCsPXJM7Oi1W0KJTNxs8JDs9xbWq379k1z5JfoOIEqG57jE11sJjqAfpbyBKqiiwFNKpOA0tuy8I/HviwXIa4FSF5ky77F7bxdQA3IgYABXau9GRm2ZrKIv7A==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df85391d-2564-4f8a-e0ac-08d86e8b1b16
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 08:45:01.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHHX6KLPf4FXfA687M661RK4PEx4SSkg66fiXxpXq2YApn+RPQ0QqTd7YB148p0+6pSBFkRoJQvKySJkhrc4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5380
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add DPP(Device Provisioning Protocol) feature support in this patch
series.

Kurt Lee (2):
  ieee80211: Add definition for WFA DPP
  brcmfmac: Support DPP feature

 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 150 ++++++++++--------
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  81 ++++++++--
 .../broadcom/brcm80211/brcmfmac/p2p.h         |   4 +-
 .../broadcom/brcm80211/include/brcmu_wifi.h   |   2 +
 include/linux/ieee80211.h                     |   3 +
 5 files changed, 160 insertions(+), 80 deletions(-)

-- 
2.25.0

