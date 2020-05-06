Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC61C715B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgEFNFo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 09:05:44 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:50560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728162AbgEFNFo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 09:05:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLb57IFokViUORrudu1QaqwANltsRK9y9IoHrYMJgK4yJPZa7LDyPBW2UWJBuHq568b2WnipAUi5CyolWUuB3mc0tQXKbsGf9GQWCDTCsJGlEi9lfG64qixqcYDqrlgtrK4abCG00FvEqNbC36+9ApMf1oEY8QIo9Yt2hk3GlaRDBwB0pndU+1qXFD9Ckx6ebt6j/YF6LfuOxhtAGN50uIVKGVvLJ98UbuDrSfkIGAw3l4Jv8Uu+iK2IJKfKjSf+4XNCM+/XAbrTw53X1bONe+MBnR1i0QB3TCz2GmD2NzQFg7Hn9GqIl9fnwTrA4/6FeYVU3baUpTT0UBWCYNdogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05ADnhhSpoogBUHJkeGwTC4ivXfr5EqPdRfTIRe+avM=;
 b=m4bkM+xFYD+2wzvAf8CmSYED4LEO5VcUUTzYmAye1HNIoxKMhDwMsoO88AnfRya46oZyfYAfxar6KiKXF579aL4ygxLS5m6SCtWEdnql6p0HY2ThFtCP5zsOStR+2PK/a8V8mrGTRbkHKILNWNLf9NetQkq8VhKGa2TxHm0AR3dfpI/acaSlio0fw4VJ/2y0hXwDa3mgV0f8mBuJSe7ELt8MQoVu7qv4cjlyKpnJ3F9ErJHDWJdKKHb8jXVQstdBASl5gRTrZkWNJ59J/mCDu0NX8tfb0dZdtzc5ZF3aHvjgzGwr4Y4sPvsfIynx8xcRLsglc47fBaMho1C8WDEkog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05ADnhhSpoogBUHJkeGwTC4ivXfr5EqPdRfTIRe+avM=;
 b=S09TajCfXrLT9sst2aUjj7BZQM2K8apekzbbM0aIhRAfrGrf1vgmvS+sFWBc2MibHVpZ3JzTggS2CkbKpHKQp08vgaFaCMNnxvkrOyk2ozQ9WAdyMiSz+TE4Sy+7lrWaBeGyYke+hsm1oXgPVG1TbXIcFCvQWw5yJEj8OnmP9VY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5322.namprd06.prod.outlook.com (2603:10b6:5:106::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Wed, 6 May 2020 13:05:39 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::85fb:1c0e:ce17:e7bb%7]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 13:05:39 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Soontak Lee <soontak.lee@cypress.com>
Subject: [PATCH 3/3] brcmfmac: Use seq/seq_len and set iv_initialize when plumbing of rxiv in (GTK) keys
Date:   Wed,  6 May 2020 08:03:21 -0500
Message-Id: <1588770201-54361-4-git-send-email-wright.feng@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1588770201-54361-1-git-send-email-wright.feng@cypress.com>
References: <1588770201-54361-1-git-send-email-wright.feng@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:254::27) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.18 via Frontend Transport; Wed, 6 May 2020 13:05:37 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19bf5c35-27ae-49be-0ccd-08d7f1be2c7c
X-MS-TrafficTypeDiagnostic: DM6PR06MB5322:|DM6PR06MB5322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB5322FCEEA1CFD7DBA25A32BAFBA40@DM6PR06MB5322.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bxsbp76/fLtRVxWQsieF/wFSFdlnCA/15JiZXj+7Z/m5UQ511/Av3XALcWBVvz6kShYFuLYCwATt8tjQmQO91PdlV/oLYzHWIqJEm8TVTN/OtoG8hI8uMhedkCfocHqX4loD/OlqWUyfidRxdo+ru8eJ7Tyl93BFKmoWhokYReu8oWuhhP1sQMADOSzJh6H8tdIG6Xt5BEODhWisifvZ/dwzN+SrkuAm6u1MaxG7VqAEdX+chX5JMUVyGN5onZhfx8IDIH8fnkslwdEiABqNr2OnhfFV7lR6BGe56En1f7GnHU6hOegUbZftLQ+yeUJ5InNvNW2e1eKYdByjnstR6ambLI8q2Dy6JkFMhyLVY0ODkyxng88NqoQsuImybm+VckMyfdYJV+3yD161YeoZnOXWkZ7zV6l6NirC4G8UUxOSsrdEWbb4L+R+2g/eFkoqSMbkwXnFvfiwMzuPfjE9mPd/A5/LxlsUaQlSrHvGI8HBJopQnqT95US0Sw9WXT0uq46FdZmp0vteYvpQXzJ6qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(396003)(136003)(346002)(39860400002)(33430700001)(316002)(2906002)(8676002)(8936002)(36756003)(6916009)(4326008)(86362001)(33440700001)(6486002)(107886003)(66946007)(6666004)(26005)(66476007)(66556008)(5660300002)(186003)(44832011)(956004)(2616005)(54906003)(52116002)(478600001)(7696005)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: h4dtYT4s75Y8O+U5F3EK1A5gr0+/r+cFD4E+iTl52HDIu/F7ddqGqvX2w1VgmOulcH0yVha7FRz8/WIlAyrcV7yCYD50pMZU6miGP9AnB8c8i2TWkZ1L60tqZimzZibykgM/pXN5QE9K2hz7HNEy/xW91VCuDF0+Ge5RFrgjZSWoW7v1Nh7cAEDxrXq9hpuA+PSN9V0mVCD+gd43hPUih4mIymNYDaD8JKHA3BfXyYUaXSmYkuyef6F5huWPGZJUK6PWYx1qKOprJ1seRhjCFEI3QqehqonWUGQ6v4ZmsgrRVpcIRxfd0z7Rbe9tPr2xSdPG15QuVT1TrYt+FwzYFxMqesfGlbpcZPxyL7xxZTqvgMLVAP4hVNKkRBlZnrYvRuLVPZVfDnZzmfYGDR9jmr7+TpPq1cSac7Yt1SifasZIptXMV2rsHDZEGh+Duddt/R2hfPulS+HvP8jM7+Nz6tMkeKXbnduDgVAaMjSyhaIME+wDpUhxsxNt7fbOKqWUGA3Q2hzS/j2qazbQbYJxQYfT2TJD0FSJObyBEuVMN96/HUUq9yTdcIskp/+cKB58gpYGfZ4jeY4A/cq21f0q59PK+VXmFmy7S+Cs5hD1U3Kb0uUaToGYhs/c2YfIIZiBG6XkjVqS+WHeU8BJhzP3hCbcw3sElZkEC7L4tog2zADehV2V98yduUfpAX12ktjbNRz3EKFdvd3DgJUUDPtgeMRaRi+EqCSp602oO4dc8f1DaOAWsPJUen716/ULsy8/fPLOlzTwLV9dBuubw74uDXezmVVog55FGUIJYHfIAEE=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bf5c35-27ae-49be-0ccd-08d7f1be2c7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 13:05:39.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMPtQLIiTMh+WKmO6PX4LsNrxuC3eTlbWTixApX/ccNr30dwQmq+JcM55CoonK6s005B76xJOmQvXz9o44g+Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5322
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Soontak Lee <soontak.lee@cypress.com>

When plumbing rxiv for (GTK) keys, current code does not use seq/seq_len
when present nor set iv_initialized for iovar wsec_key. This could
result in missing broadcast traffic after GTK rekey. The fix is setting
iv_initialized and using seq/seq_len for iovar wsec_key.

Signed-off-by: Soontak Lee <soontak.lee@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 4c86ed2..b20ccfd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2468,6 +2468,17 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	if (!ext_key)
 		key->flags = BRCMF_PRIMARY_KEY;
 
+	if (params->seq && params->seq_len == 6) {
+		/* rx iv */
+		u8 *ivptr;
+
+		ivptr = (u8 *)params->seq;
+		key->rxiv.hi = (ivptr[5] << 24) | (ivptr[4] << 16) |
+			(ivptr[3] << 8) | ivptr[2];
+		key->rxiv.lo = (ivptr[1] << 8) | ivptr[0];
+		key->iv_initialized = true;
+	}
+
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 		key->algo = CRYPTO_ALGO_WEP1;
-- 
2.1.0

