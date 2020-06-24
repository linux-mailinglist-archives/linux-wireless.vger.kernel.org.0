Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2B206FD2
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 11:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387825AbgFXJQT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 05:16:19 -0400
Received: from mail-dm6nam10on2119.outbound.protection.outlook.com ([40.107.93.119]:24838
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728857AbgFXJQS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 05:16:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJvza3SDEgT6LPWyKiQ8KT3V9UjiMUuS9sk/dVMJlPcucLcNWzdVcsFvPGXGU1J6fD4R28C+G7NDiBfuO7MhAhMUMrH6QzjxRD57ROZ4vnvbdsQaiBrnTErxAhA5VI1BVKe5UIKcR3OOhqS305VQ/AVclSHhVXri4rWYDoGFWtEAATOfmLmAAzoxiKKy2+1pmsQnuBlE7b3PR7NlIE3tgd7NGLdMQM9vB29nGu1fuLf4jSSGRjrVhJITtWmGDDm125Q5Ro2AlgOhgnFy3ofwGPxNJuoU+msfq3hPfU+2hsezK0H0xpZKI5DersVnkFZIA4TTKSX/j2P1oHbgvEskgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F64cKXvUXSIiUaNJpHXoRnq5UL5psrjiMCMjYU411Ig=;
 b=ZJ8WYs3qkRWT9kiohOX4AtPLkiqYXf+AfcGlsCcAy16dDnmHodZWVdecJxXJ/B3860tHqmlnjAtqMYHI5I+6AbfJC8SDKFd+KS5XjLidgOfZ9zwRyOGl9vAcJbgtuggqRoay1hOjD5WS94qexC0GeZqpYB5sm24/cROzSWpZCThSRz2AD/2y56zP3DJvmN47AJkthtMrZcU0LqbNF4JefftufZs02iA3hPFu2r4QAO1/dOCY9o4gUHR4fy69pYkqEFvH9gLbjBfDijp27ZsEQZtdgrJEmtGQ7ypColQ7aVF2YmxO3Zx02ZOFYaThYQTGOYzfzmMygwCSyrGDfCqw2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F64cKXvUXSIiUaNJpHXoRnq5UL5psrjiMCMjYU411Ig=;
 b=YyjZ7vH1YWqbnJ5sIxTIvi9galtdEs1NjwYnDktF1j5cgAmTl07xe6BwmiMlJFTXq2qAvGl8dX2NGq4tT0rXfbSiY9DPXvFwY40ExZNbRAtexSz1MXT+1SLIKbAjdHMB3Pu/NRhxmiUoKAIlLu8wMCkTMWWJvO/TWMgoOMlBxS8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB3988.namprd06.prod.outlook.com (2603:10b6:406:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 09:16:16 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e%3]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 09:16:16 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 0/2] brcmfmac: Stability and throughput changes
Date:   Wed, 24 Jun 2020 04:16:06 -0500
Message-Id: <20200624091608.25154-1-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0033.namprd10.prod.outlook.com
 (2603:10b6:208:120::46) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR10CA0033.namprd10.prod.outlook.com (2603:10b6:208:120::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 09:16:15 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ebdc7062-42c2-49e1-5751-08d8181f3f6d
X-MS-TrafficTypeDiagnostic: BN7PR06MB3988:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB3988CFD9355A6BF596D890D7FB950@BN7PR06MB3988.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:305;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKoyfMSLDjW7NNZwOyXRBmOz4PgcAA78kfxkoyLQjty5SKbdmO4meLov6Mv0GTx0cIZU348s3ILTZKL+aISo2BoSZBLB+Jcq9qJfg1x4Ck9qE4xFeWOm9YkuVohMx71craRGkE0BWtnQ7U5/jyvfcq+ZkDPMV5ifu6f88N+qW+uJJga2Bi96e9Cm+udaJSztKh4Dwmho9SELo7TdbLtlTuBtghWvbjFHvWxrYYGLCvOzRYFwD97JvUOW5HzcWrDpQbdJ6Td7xwqaB6u2OfY++KZm7+5JtFyEkAoV1VzbZz2ig+5IorA1S5mP0wiRkC1/d88Ka6jzBMft9+9uf6ek+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(316002)(54906003)(2906002)(6666004)(66946007)(66556008)(66476007)(5660300002)(107886003)(6486002)(36756003)(478600001)(86362001)(1076003)(52116002)(7696005)(8936002)(26005)(4744005)(6916009)(8676002)(186003)(16526019)(83380400001)(2616005)(956004)(4326008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hGsMHK+jDsvj0lzYVNT4/1+sBZ3uWfpHrJMkU506wzUlxupdIHlXkXHxB298uph8rMzuXCHMJ4uPW9MAC2naNDvPCBCsNK9Au36ETUzIrkv5H/AR6YsdmA3rIddbIKcG966OjTzA7hYuzCYY0ggg8iBNbGiybBwSVZ92l+UdOk0O4cycdbcRLMWQvJiCkvDzG5C1BIkBFXgKuovKbSZP7atPwYtKhpNZeXK8N8OMqcNV8751g8O8lmZOhcUD99GYb+fCtwiTQ+OVC1Q/z+HrkwznwT40qPDfOsVMBwPx4KWg9+x8poe1q9sN/nniIFkqqBuExhF0/+V/v1548QCksHlgVlqWYcLAgdsy8mHDtSSZNb1V5uyJdNH6tUVjZwgIUAH/zVx1enMzFNsR2zYy+ujZUyEzCJvzRkykcclAeEkXj4BBs1w2dmFm8J6usO+WPglPOxQm3KkIPQGuBFMrpNwhy32kF0sHvaOfAFcCy8B5koNg7m7b9qRCFAXza2EK
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdc7062-42c2-49e1-5751-08d8181f3f6d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 09:16:16.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfZYM+ZmesDNk1c/cU0VCMyb9Y16P7PjfmfS/qs8Es58TT/76YqMR0dATTqn5wDCGZtl4CSmJzCblAKma7gp3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3988
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series fixes stability issue and enhances throughput.

Changes in v2:
 - Add more testing results in commit message

Wright Feng (2):
  brcmfmac: set state of hanger slot to FREE when flushing PSQ
  brcmfmac: Set pacing shift before transmitting skb to bus

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c     | 3 +++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 4 ++++
 2 files changed, 7 insertions(+)

-- 
2.25.0

