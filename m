Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748921D94EF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgESLKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 07:10:23 -0400
Received: from mail-bn8nam12on2129.outbound.protection.outlook.com ([40.107.237.129]:61536
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbgESLKX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 07:10:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeqbmDeo8YpBtlDIrQg97P5/pSns8v4RyujlL03oBWv7Enq0QKX3J3obOBoKPA9qRyLV9oofVPZHU+Qd9i4VqhpGH0w48lADygEEChVlnk4ysSgSrvLEvrmqOnaDJ3frbsz4T3IMI24jWsO0/6ycj2+6KCivtGnsuduD5pC/aRxAcAblHqUC/rSCuiDEuXLrqmR7bWLCF8JOLraY6QZvzC+OWpRyjJdW3cowgbU//wprHW53a5T9JOcm0LeC7CF0c8WvFv/wut7ufwJgK7Q1NUdLV+zp4vlHOek1KdbNQXD8XGQ7mAjZpdlb7U1j4V1rcMLrTBXgiE6eVjMFH0jF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbGO6BtiGo8RXeJy0V305oVt2OBv9ZSO5GQ2MnIfEeo=;
 b=C5BjITN+B6L+zneRTfRdyvCQcLO33kZMM+I38oAs/QwDVmqTdrmcOrUy/W0G20BxBTDB++b4nuJ+RY8qOIBKzpvgbEDKCM+ZPQLbGHb3B6Xe50tBhkSium5AI482seEL1M9gd2dXqOeVOmA9NN/RNSpTerxGK7hBVsPHeWRHxzo9oDW+Ri25s+MuXpZZe3t1XNiJViP49Pct12HQ7OuXCkaDjWEyIQ7bA9J1vifMvkWEgr0dl7CJ1bKs0NPxqptxOLstj+jgjcEX/bygVNsjO59iXcwXjxko30YRXYLc7qVQHIGycspDg5KF8J0XJzvYjtVQ4+YApWN/AWJqdFUrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbGO6BtiGo8RXeJy0V305oVt2OBv9ZSO5GQ2MnIfEeo=;
 b=NRk4S7/R8Dx5E4wHiWhQhzUb/gLftsN+ZYHOdI/PvJkZ8SxzyAfqX26nohpmbfhclCAYMTvlSGOO8/hYux+HL0MfMJ7hs2BObP+bkUavJYLbQCw38YAiUk0dEWFem7vBABHwGttHJezxx2CVle11LaB2p6179JfCPbrwNkDbjOc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4906.namprd06.prod.outlook.com (2603:10b6:5:56::11) by
 DM6PR06MB6043.namprd06.prod.outlook.com (2603:10b6:5:10b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Tue, 19 May 2020 11:10:02 +0000
Received: from DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f]) by DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:10:02 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 1/4] brcmfmac: fix a sparse incorrect type error in p2p.c
Date:   Tue, 19 May 2020 06:09:48 -0500
Message-Id: <20200519110951.88998-2-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
References: <20200519110951.88998-1-chi-hsien.lin@cypress.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::42) To DM6PR06MB4906.namprd06.prod.outlook.com
 (2603:10b6:5:56::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 11:10:01 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41ea11f3-6a1a-4b82-9d52-08d7fbe52d3d
X-MS-TrafficTypeDiagnostic: DM6PR06MB6043:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB6043F22F8E2B5B5AA6F6F05FBBB90@DM6PR06MB6043.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:106;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VP2r4o3lj3ugK3Z8OTgid3N3vuliwcGPs+aOhdafRi/uaMKk1+Iav4LYNEvBpshFsKcD+xlXSl0kBlWrD8ffSzRfpoaCMRWAKTF8/8Pw1vBjbvCCVnNgUa3IbZ3+wAOlEPoQSkBZKUq4fmLQdXWxfp5CotKalmSzhRY9l/oAd3m5InmF8DL3l6J+ivpZ4L2UDmxtUMOvpTR7guZYe6YiWzo9YjHlnAsYaULKySSp969Wi+ol0+y5LWjvQOgv7an/sxWYHDaTU2ZVQmRrsOZ9cQD+HvJ18N7NpSm+cYhdqWGi0wBFF98eG40uVlOWeoO8BfEAyUCuAwXtDhgcW9sNdzKb/Ks3Kvj5DbxHlYQVbu0kaW6vzwCUmwvfjcRQiQ7O6fjEYZgBydRSD4FSe5GWYGupiNsDQYlAaI2kxwG4kIoZJoJ5EvG9sw8NMJInmD2G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4906.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(52116002)(66946007)(66556008)(86362001)(36756003)(7696005)(54906003)(66476007)(8936002)(8676002)(6916009)(478600001)(956004)(316002)(2616005)(6486002)(1076003)(5660300002)(6666004)(2906002)(4326008)(186003)(16526019)(107886003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: RXUnTtIDSZXXEub1NvyBxzK8Ag2X9T/xJ+wQkiWSZk8ZCHLl73oXQTgSjx21b3aOqlM/ceXV5J4UcpcP4Zi5zzqUg/AagZPUZrZmF9sUQLwauEfXuc/rO+AOo1FQOidwNEP/MxF4H3T5wkzTuKZL0XyHL91abZRrOoQlYIwCHNzOGcbr13JbkQu8YBbc0lUOE18bHPcro2f3DLWW2fodCO2WdkR4oop51/vngJD/AZtEpU2AMdwyByvDxo3dSU/EjR40jLPuiWWCKbEOvC7pb8qoO+8LOTwiF8bJHjImZAUNIXXa+69BwDoNu6NWFyE1U1s2swD53h7StcUWe3aqerK/HT2MNHDfKit2v4dwPp96qK8y465eymUjmvRNtrmnudV0ysGn6OX09UyvIbSoaKeNuaRQTpdp4RogvjT4GwOk+MXktzkbvvHt092lJyn3LKgcy13c3R4D7dY2MBSrWSFO3adhqhrn+bpZoBt33WpaHzWcdxjf5hMIsigj0zc/
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ea11f3-6a1a-4b82-9d52-08d7fbe52d3d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:10:02.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wR010v45d6M/pWeIT2EBcSU2nA9n/nTwZd64Vhww/eP6MLvM8760lEzSr9AmdnYqlm+xrBMjXEFPfrkF/Zk5rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6043
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the below sparse error introduced by commit 9c29da3f4e7e
("brcmfmac: Fix P2P Group Formation failure via Go-neg method").

drivers/net/wireless/broadcom/brcm80211//brcmfmac/p2p.c:1741:40: error:
incorrect type in initializer (different base types)
drivers/net/wireless/broadcom/brcm80211//brcmfmac/p2p.c:1741:40:
expected signed int [usertype] requested_dwell
drivers/net/wireless/broadcom/brcm80211//brcmfmac/p2p.c:1741:40:    got
restricted __le32 [usertype] dwell_time
make[3]: *** [drivers/net/wireless/broadcom/brcm80211//brcmfmac/p2p.o]
Error 1

Fixes: 9c29da3f4e7ef ("brcmfmac: Fix P2P Group Formation failure via Go-neg=
 method")
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drive=
rs/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index d2795dc17c46..194c1ac19402 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -1737,8 +1737,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg8021=
1_info *cfg,
        uint delta_ms;
        unsigned long dwell_jiffies =3D 0;
        bool dwell_overflow =3D false;
-
-       s32 requested_dwell =3D af_params->dwell_time;
+       s32 requested_dwell =3D le32_to_cpu(af_params->dwell_time);

        action_frame =3D &af_params->action_frame;
        action_frame_len =3D le16_to_cpu(action_frame->len);
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
