Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA7253158
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 16:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHZOcr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 10:32:47 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:17203
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727061AbgHZOcD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 10:32:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqkwE/5fVs1gDJiRJ/iAKNOLlrEIABzcvUAXieDdzcVw+RAdAUA9CbxXHm3faBt4LHM8n4LePHtnL8FwTPVhhCnHtVdw0x9gdeopwpFyrJ/vaoibhpCUvOAeBsEOkMKSm+dlKqaCcnWhU1QWQTuvNylHJe1v2KVuKBNUidKjw2OZFf7d8tBnChLOxfhYsDgN9FM+tcD7AacOPL9c8c+en6CDkFXy4QDPLoYkBh9oh2vBY8Ktn/3aLxKeTjxj0lSEWQze57p1B98TiER1mmf3BZ/nbS190fgZy29XVpM0s4wkZsBpU2oLPJt++W6MxqWILouC3881U1hRhGFTYIZIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYk1KRFxrBKAmkCY3ju3RocvsEHsX369343xIoiuxLg=;
 b=ACA6y+c5ziildKwEj8n/Na3bOpIyeqrYHh+j7+y6wlI5gAqnEfaHXTjmqDP0DsYRIjTaqkGAhRiGEkovT1MhCFkTgFWVhKXiaOgX8ErM5eLJCkuDK8EcFgF9AMmxry6U+5Y2rbgZYgiNL+q89h49fE0RUC1iqBW0redjzL+Vv5+VPIo7v/EQxc+Bn2uL+6mMsnELRASFQF77mpip5oHJMr/nepsU/fhHP+fevkkbq8xaHTwLG1NRaT/ivnGUlfc9g1ISsu8Bl+rXmd0vJ0216QjHXUtrJl8SnZHCyxLDTYj7YuTsgAYnJhqldzdrF2cKs0LSLm/mYW6NM7mj4118/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYk1KRFxrBKAmkCY3ju3RocvsEHsX369343xIoiuxLg=;
 b=uKzXmFHwd1IoUdVdWW2UQqmZLoT0OFT/094JOY01Rg0+VLqs1i6pjeLKDMcxHxHkQR1RvooDN9BvFpYpLKK8iTK0nYgnyMhQ55zMQmi9oVEFHminNJ9cW6CBvnG74XsPO3h/bz8dvR02heQjkkPDO3ttmT3NCtPNSl4k5eilmgI=
Authentication-Results: sipsolutions.net; dkim=none (message not signed)
 header.d=none;sipsolutions.net; dmarc=none action=none
 header.from=celeno.com;
Received: from VI1P192MB0479.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:38::31)
 by VE1P192MB0733.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:160::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 26 Aug
 2020 14:31:58 +0000
Received: from VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 ([fe80::d9f3:c73:3d30:1467]) by VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 ([fe80::d9f3:c73:3d30:1467%6]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 14:31:58 +0000
From:   Shay Bar <shay.bar@celeno.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
Subject: [PATCH] wireless: fix wrong 160/80+80 MHz setting
Date:   Wed, 26 Aug 2020 17:31:39 +0300
Message-Id: <20200826143139.25976-1-shay.bar@celeno.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:803:38::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (77.126.12.128) by AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:31:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.126.12.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fff7408-0c43-4dd2-1a32-08d849ccc981
X-MS-TrafficTypeDiagnostic: VE1P192MB0733:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1P192MB07336AF49E7642FD04F161EDE7540@VE1P192MB0733.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lisMMXmk9VrdZeBUn3iQSw+AzDhxWkLyNopmQmUpeosTBK1dNnLrv3wxb3RgAM+ncaELlpkm5KdhsqZC5w+kFTmVO1y9hCIGi4tp6kKfv/c8E6r6ODz4scq/bsM+KAxXnGy52tNkxX79L8wCA+xaEhJ7c1W3Csia2ibzGwu2sVXdlw/yGlilu8e67YNsOrLUTb6lEMiqgWJi9RAxDVGmdVKvMSXjqTQwYWVdQTMUjLTvZH6Fcg32NqTuZf0ZEyFunDKonM3nLvt/H3+bFd6kCvB1CihvjARwXlunsU5kTdjZgERR9HHOJlrs5kkbygko5c8tkT1gIiC2Fp9Twb8xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P192MB0479.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(366004)(346002)(376002)(478600001)(6512007)(6506007)(2616005)(66946007)(107886003)(956004)(26005)(6486002)(66556008)(316002)(6666004)(4326008)(66476007)(36756003)(6916009)(83380400001)(86362001)(16526019)(8676002)(52116002)(44832011)(186003)(1076003)(8936002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jEanEI3ZKUjJlckcT7YlY4AiLld2VWQs2/cgXJe/iC45Tx1yaZsN9ffc2qlDKH4/bUuv0guoLKjByYKGkYeN72FcHl7spCGjCHvqiiuQQYvaY4pFqBJBY5iGWBgKtR74Mur31BuSa6J+Ohxg4DWszUjgvbrosaIMdOpZ6sohhw+u7nfsC7ws7XXYgjEbEEt9BTLU+yX1Io0/Ku6adgaz3s9H1RiUMvWzWT1vk3sKDOjkNiUhsdBER7tGpmelxGp2JmrOP3F8b8jmZI6QSqA0Sb7X6qTyx9zc3DQWkYCfoKcqotxKa34X4B207mGucG+MAzPEJVnWZ/+iXXeSzfWiX0WUGgzYMxNzmWAoD1HoJkkYQ3yxxi9GS7AOn7wiqf4Lchvws4r01VPy6bZincV9DygwFUFi63y1EUfbwjKwulqXOmj3Erc7aB+E3Mo/PXnoSts2bgapGICIouZlaSFEYl/MV7vGFyDoPtb/FqYbXg8VZdJMCQrqBYFHlAxzuPbdXpbz8vUaARquovpABp7UUKq4V4XrJpVJMWFW/tADlV1SrLQuRuRRTVBw9NW1j22WSE7dEN7nXkBy7D9yD6pIMglpisDYuBkuzZQIK8/oTU91k36e00rsVBzCUyYngDRsyI4d/w6i5u7S4cW1BlImFA==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fff7408-0c43-4dd2-1a32-08d849ccc981
X-MS-Exchange-CrossTenant-AuthSource: VI1P192MB0479.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:31:58.2368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: derCDZmazIWBMNnH1H/fov9sw60OEEIvGsEV3XR2NeUBhvHb6MNAnrqX1KZDi6IPBvOJqz0TU2bq5PhK0jVtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0733
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix cfg80211_chandef_usable():
consider IEEE80211_VHT_CAP_EXT_NSS_BW when verifying 160/80+80 MHz.

Based on:
"Table 9-272 =E2=80=94 Setting of the Supported Channel Width Set subfield =
and Extended NSS BW
Support subfield at a STA transmitting the VHT Capabilities Information fie=
ld"
From "Draft P802.11REVmd_D3.0.pdf"

Signed-off-by: Aviad Brikman <aviad.brikman@celeno.com>
Signed-off-by: Shay Bar <shay.bar@celeno.com>
---
 net/wireless/chan.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 90f0f82cd9ca..a51d11d3be33 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -912,6 +912,7 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
        struct ieee80211_sta_vht_cap *vht_cap;
        struct ieee80211_edmg *edmg_cap;
        u32 width, control_freq, cap;
+       bool support_80_80 =3D false;

        if (WARN_ON(!cfg80211_chandef_valid(chandef)))
                return false;
@@ -979,9 +980,16 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
                        return false;
                break;
        case NL80211_CHAN_WIDTH_80P80:
-               cap =3D vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MA=
SK;
+               cap =3D vht_cap->cap;
+               support_80_80 =3D
+                       ((cap &
+                         IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ=
) ||
+                       (cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
+                        cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) ||
+                       ((cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK) >>
+                                   IEEE80211_VHT_CAP_EXT_NSS_BW_SHIFT > 1)=
);
                if (chandef->chan->band !=3D NL80211_BAND_6GHZ &&
-                   cap !=3D IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80=
MHZ)
+                   !support_80_80)
                        return false;
                /* fall through */
        case NL80211_CHAN_WIDTH_80:
@@ -1001,7 +1009,8 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
                        return false;
                cap =3D vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MA=
SK;
                if (cap !=3D IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ &&
-                   cap !=3D IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80=
MHZ)
+                   cap !=3D IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80=
MHZ &&
+                   !(vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
                        return false;
                break;
        default:
--
2.17.1

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

