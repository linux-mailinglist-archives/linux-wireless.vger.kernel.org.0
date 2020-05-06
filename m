Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72311C7157
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgEFNFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 09:05:24 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:27010
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728286AbgEFNFY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 09:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGNTFzB/hx12Gy3iksDsEdpo+YZAuEuNBJ9y+2tG6EgeZUn8eFZvM7qfVrVoNjR5QtHZm4HGyH/X5RTpqyAa2UGbzjMjoEQYU8EIRWGmQi/WF9kFcxF6y/wwpirqZNGwjGBYtvcGlyXdb2uT9AmPUwI8nNyTm3Az+SpvP6H4M+I29AHAPMN72XPHtkcz/wGn9921DyOtbyjz8ewnqJUBcZ+dyoBkNE1Uqmz2DDGD6MsRV6pcvRHiKhWPvfj+oA4gWaNYpYia+wtgp2mFYEp9fP1gLebI1dUYejU/bYC6yd9pg/1WC6CbldCrRFShltg/dXoWM0rVWlS0lYymSuDlRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJxwtK2QjcXQv8V9rcHB7yruMz1av0xGx8jz+mq5Vls=;
 b=Pt0V5ckEXsGAejciGpmAiRyxviuB9uRMckfCEKD6dD9wL11mZMYvzzg1zx/Z1CIrB+gANAk2Nsy/KNjX8m41FlBwlCz7BD0SdvaFXiYIW8q2PDIF0Ik3YyKZQTaopi7t1kZlKgqBEhLNqp3Mpeq/6xBVlxZCELpn4j0jfHf3CXYKr1AZVaJhWBK5PHpf7GtXyUfjw+xxka5TF7FjjnitGw0F0dmqu9cr5VmeHVQ+/5S5wyxNna3DiJWKN65qtf2H1LVHBoNRvNK4iBSzHWp/mm6lFtZT6jCr/Q1nNsn4mDlkfMGZC9UBtpPR8qRXFTGwKjM8AaSogCti3Uobuh4jPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJxwtK2QjcXQv8V9rcHB7yruMz1av0xGx8jz+mq5Vls=;
 b=I/4iL0YPlpumExx2oPmaVvHXr6GFZxQX3t8Eht7357BRgleJ56+VqSiH+8qTaMKlvkM2o7/VfUm5kHgSLuCcjKucFrVvVqnNIZ0Ho/AuJAY/Tp3kV/lhxayqwfxAGL2JZwJwO8F7S5GXuHlB30phHNJHfieMNhT05H2tkMobowA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB3994.namprd06.prod.outlook.com (2603:10b6:5:87::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19; Wed, 6 May 2020 13:05:22 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb%7]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 13:05:22 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 0/3] brcmfmac: connection and action frame change series
Date:   Wed,  6 May 2020 08:03:18 -0500
Message-Id: <1588770201-54361-1-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.18 via Frontend Transport; Wed, 6 May 2020 13:05:19 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 241d236f-9a3d-46cb-3ff3-08d7f1be2220
X-MS-TrafficTypeDiagnostic: DM6PR06MB3994:|DM6PR06MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB39944620876167889E02BE89FBA40@DM6PR06MB3994.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rm5Ux72DeMSOO9Zd3rf4tUjrvVZuerVrpNoJZUOs9+TAFzp1eSY5cmn1AzU/2YfoMgBowF1buwmwLiXIi5fzWfszw1M/uVd5y4UnYDoTrNOigf3h4lhzd/j/T/Ju/D3F3qL4opUT/4p74c7iApDRX251gYJal04cQHGPSHYGqDqj16XwZ4CiXOhGjpo10OAsAYHjoyCkPqKbYE3bjjNsACntB97Uzgw++1e6ou6lRn4TrqCBb9KNpJQkRmRL7JpnQ9oZLxErJlyWWgDcDtCyYdmpgGvxWaxq7WALNOZtlXe6O0O9rtFOwCo7YIqz6pOQxIoU5GjcfJBgAK8kI2BW0Nfhwv1oEaIi7g4YRoIQtqsc8YHdTLg9MHsxxoHgiOyWaH/4hq1J9gFKnn5CmyKux2gD/u91f3Iie/dQmgY0H3xaZnyPmBOwtoJGErkUdCvw00V+mCfAy2zPYds+CFNDzBWacTxNP95RNFClP6wd6RoIozbnpof7Z8YDtZcg40xtq6rEtwCDyQkpwtfyjjy6sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(366004)(346002)(136003)(396003)(33430700001)(86362001)(107886003)(2906002)(33440700001)(52116002)(7696005)(4326008)(66476007)(5660300002)(54906003)(2616005)(66556008)(26005)(186003)(44832011)(66946007)(956004)(36756003)(6486002)(316002)(478600001)(8936002)(8676002)(16526019)(4744005)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tGXan9cHRR7vQO36qi4cleLU5U7eMkHCOoE+jKYVao3FB2pewYc5WZgcGebXc6oT/sYp/ONGGxINJAndayHJGhV9D6McDXq6Ht8SnuHfElNO2f3FKwdLRP0NEOo5i3pkzdpoB2s02YNa/c0MtIBLaUeIjos8ukxQ3snwb677GsSUjBUJmQT2aOwSMk4QH9ewcmY9q8a6zsn11BYLdlQnLmJ0Yk9r57oRkKGnF8ndP+/JjcJdEBa7jSUUIHc02rEDqhY5LrUM5KUg+vQ2ie/g4KRvMBJfrru8Ur9rwX7zESKeOqPM31aBm5RMqTy2qwC6gsdTPz0hD1PIGkIFyADj+N6z7wwVxFNjT4lzOprA4KOBoqLEI1ix/3IvY5yg0sYvm14zp7vo1MpngnwVMZ1/LBIGx09Onrvff+p5na3v+xD9ZQCAB8gaAiBjRsQinqfluuwhRKNiMOw5FTp2gKHu8n3Rf5MLsrAL+Loo0DcOvCVIvM6Gf0v9vMOtr4pU50VS+uvLF8xhP3/7YnHkFOH7D91BgbWPpWo7hj3jpyBU9MC2dT4FGZaFWvSFJgh4z5rAWGYfyqXQ63EKpeELjLJNc9xqmJtnvfYSs2V1mELqw33pn3ByASHFDcfH6JVw1g8fX/ERklw5C+jFv94PtblaoWyeS//+Z6T2J3BWfzCS3OkyTWD9ao0ik8K8JkuyEdaTrUDt5ZtMbVexbofNzZi5xlfJGYV1Lvh5JooW8104KLhf7cZDLM6dtX8GKrzBrBlOeHGG2rYDscYlVOhsA3udPn9NNG/t+AWCscwmf41+pW0=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241d236f-9a3d-46cb-3ff3-08d7f1be2220
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 13:05:21.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDDzpu2HkJEaqczZgeFyxBqr50q3OgH1qKf5HI0ZDWp/XmTba/hWaYpmxZNVQny7YpKWrDBLx5MOZQJZEUL98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3994
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series addresses encrypted connection and action frame issues

Jia-Shyr Chuang (1):
  brcmfmac: set security after reiniting interface

Ryohei Kondo (1):
  brcmfmac: use actframe_abort to cancel ongoing action frame

Soontak Lee (1):
  brcmfmac: Use seq/seq_len and set iv_initialize when plumbing of rxiv
    in (GTK) keys

 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 101 ++++++++++++++-------
 .../net/wireless/broadcom/brcm80211/brcmfmac/p2p.c |  34 ++++++-
 2 files changed, 101 insertions(+), 34 deletions(-)

-- 
2.1.0

