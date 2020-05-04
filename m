Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3921C326D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 08:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgEDGI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 02:08:58 -0400
Received: from mail-mw2nam12on2132.outbound.protection.outlook.com ([40.107.244.132]:50810
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbgEDGI6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 02:08:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOtZlLyIGZ6qnW6uu1eRu2ASF5fKQtFum22IaPT5zlIXE9GEX0A+qbd63WuHkNlFRITeX8LGNYTmrh5QHxZDBexRwrSJJSSotbW+JpPk6XFfVel93JxZKoVM8TsibPPwLGNyXNw5H4wq15X9Arcs5DzCVjomEHIVcJ4zVsEfx1M6TuP5juKYn7Hzn9Q8fzS56w1b07bp4VPCXQN55qY7++b4uvMXRraC7PSsNFkEUJbrhJpPaRbnXbZRa4hatg1CJcvt5ROq+VAxFThnhAh4ysX1l1tjIbygJ9U3CTBk0NnWv38fSlAvzpFYgWbyp1reeC24MvYhVkKl2iCBb/ahSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g38dBPuWEX92GT9zJ6UCo/HEPIjDmPYeLUJK82mq9+o=;
 b=jp7IHh3MDcvcW8aRlQ4xW52ns1tlWXEtFaYeM+I6EKZ/nIY+3+8lyy6DQ9rKFmm7P6zgstbi98GdNhwgu6pYSsjFel4N83RtUpX/BjfGXpMcJC/XwUvrI8hL3jGcqGg6metuDwiRlxvay+kpkjbVQF3PA5CqI0o0tO8xg28SDnDee+ZtWWdUWYZldhDlwx3FKfxVzH+7KLcd1gH7z731dhXvbjHekNHdlJrW1b0n5OJ2tYF2X48mOihMSuOQjGynai/uFbsWi/7w/9TN5TL/0x+P+r+Z5oxs0CTGNeCbJ/acFj8pRMeneNOkP/OoD91IdbD522sXhqHnQLmjYHT7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g38dBPuWEX92GT9zJ6UCo/HEPIjDmPYeLUJK82mq9+o=;
 b=JPNNAnHyf6Rpe6S36O2RBvBHHqgKkT9yJNL1YBxY7XktAs0cNmwS6yX3jCXdPx4DOH2YmGZNcAn8zPwEIbdsSU+1cv+T0VZ6kL7CHVIWPcPVBY75y+Qipwst8t+cZj/meCUd9qzFPZBR2aL3Yy3zw7oGkTc0ZHWj7sDAWfw+LvY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4283.namprd06.prod.outlook.com (2603:10b6:5:1e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Mon, 4 May 2020 06:08:55 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::ad0b:eda4:4eb8:b8d7%7]) with mapi id 15.20.2958.027; Mon, 4 May 2020
 06:08:55 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org, chi-hsien.lin@cypress.com
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 0/3] brcmfmac: p2p fixes and the second connection support
Date:   Mon,  4 May 2020 01:07:30 -0500
Message-Id: <1588572453-194663-1-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by MN2PR01CA0061.prod.exchangelabs.com (2603:10b6:208:23f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Mon, 4 May 2020 06:08:54 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bcbc4de7-23b9-4603-a070-08d7eff1a055
X-MS-TrafficTypeDiagnostic: DM6PR06MB4283:|DM6PR06MB4283:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB4283892F54B0BAAF438E65D3FBA60@DM6PR06MB4283.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+fXkHRn23FbJ5m+xftIz9HVoQgNjBB49ePtBaAyW5PHWa4Dc5bedWybzKMtm1nHjWNE57ZwtE5HgHI85x7KwGlzUlLq8/AkOQdZ92Le1M5bi8huL9FzOmI2FDaKEP9LXW8h8XBiCnfAZFI7bgrNMaw/OVSagHgwuQcnQmvhrN2cu4BuOKFlCZlb9HAmZcIW770SqXbm4l5RTkuv4LQC9OYxh+dZ68oPvpX0/R8zHVnxvXRftq9Kwd/dmvFV5yUG2nUTz++ZDGs43mFTLHKjW69FDyz6YCJI0+RjJagt3SCpxnr3DFE9aR3RRn2KvuDns8eAhGLj2Wn4gT6quRDfMgGpw6IoX9aXwbqQ++UwoC7C0FY9WHrgDOTkX74ddeDqdudXdPn1KoCYhmyEjfjeOzw4f2aNl5BeMd+O8pm1JQN0Yf2knwoDsmcIApnK/iwb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(66946007)(66556008)(16526019)(186003)(66476007)(2906002)(26005)(44832011)(7696005)(36756003)(86362001)(52116002)(2616005)(956004)(6636002)(8676002)(5660300002)(8936002)(4744005)(6486002)(316002)(4326008)(54906003)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BeD7lADcp4Xnpwgnoa0WzJDGS1+cE4C3yvvoZbTAMIU2VptFHAyf8DmpR6ojsae0ATkeDBY/At4oAnoufEzyKMArdloBk9VjSqjySpO9a+uj0K30HyPS2k7pU2LIL0NAj9CUZbh+vZ3FR/hfTbr3xx2NeZvwOijOhmzxCpOoRRqPYbu3JPCHPTtNiV16ezNce8dX1V5Lhp/JRox3hABroLwWP/MNh63Ia+MQKdv8H85gT6SLESDJoL3KOHAmE8Kd/u4XWLHggKgedducwA6yX5w1CKE+XYSFnK5zn/VgjhAportNgYEgDCoVZb4BwfMsaJPv8UA5AM9j8u2eZpkYjgpIF2+R54CG3+4anVGiQgcMVlBvdw2uHvdF5sBFDO1GXogB7idomcWLsKV3vKLhqrtWZ3DiyT0XAwdHWFpxMMk8a3Cbhs8Nejr7RVvXuuRIqlpuKLOvT6mA53FNHX+SVIy3bGy0UcNkSqwANkvXAgaUoE75mclnrp065m+BHAmZgMqHx4DaLvQPYRcS4kAtbcNLgb8s0o382V2BBTfnlT45rYObh3ZOVbCEp8ZvrpaUrR5ut0J+oJJpciqbSX+5GfH/YL2wKG4dA7OjtUyAdASc71xHIlBW2EpPJc6NTvS18eYt9jGJbRZfT5ApbF0GWvzaqZGpQOHTXKmlzDFPT/LnVdEPD7Ta9jXMJU8wuBA2dM9wBlu2+ptemcYoD6WJmFJH2r5Z22NtH3p1BptfHT7NLVjtu+4tveskMrqpLaWPuDoc/tfHSMUcFPDiDAjWj3feebWClsM2T+YzS6MdQsA=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbc4de7-23b9-4603-a070-08d7eff1a055
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 06:08:55.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rrerJidePHk6swu9j7jKVxtAvwAJCUkma/DSHhOsOsAHtuLXMDFlIu7W7a5adVPhpjCxWwRDWaQ/c6soBqcLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4283
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series addresses failures seen during p2p testing and adds the
second p2p connection support.

Joseph Chuang (1):
  brcmfmac: Fix P2P Group Formation failure via Go-neg method

Justin Li (1):
  brcmfmac: Add P2P Action Frame retry delay to fix GAS Comeback
    Response failure issue

Wright Feng (1):
  brcmfmac: support the second p2p connection

 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 88 +++++++++++++++++++---
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.h |  9 ++-
 2 files changed, 84 insertions(+), 13 deletions(-)

-- 
2.1.0

