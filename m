Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935B91EDDE2
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgFDHSx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:18:53 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:49249
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgFDHSw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akIgUjhy1VH+vYSHIsEsyQZizUevbiJ+6J4dccYv49nM4J/cfq+kDjdmteD8cKgffWfSqq41o16mYwOM3lFOzOFzhe1nUX+of8xtFLH7xlnELkvFpEpE196iA9a5VjA9QCi5rjtoBSls1dbtUZjDjPWO/ptMJxfWuVeJQw6mdneGerhMjdsLFywysV8euVy9Y5hPMXeewSDyaWJ3gfgWGeJtcYkJYBz/Av0rEKuLHPaHmJMrOc9Ar+OqtiHGV6uFuIwdxj1HVoL8SXDWw12yzsopjG+czjFJaM0p8WyCV9Z8V38VYOhxXt3KJHsY2+Ao5zQUz5KKIkeaJ/pZspMY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSnGP7Y8jrd9BSsjmh5ESzAhzBAl9L2a+sunRjMAUm8=;
 b=WJrrI+UWdF3CLvdNZfuurOt1nqCwMpg+3RMwP0w3E7cguc8ITYSQmrDvKlmqONlKhspuEMfop0Z65IUb7nHdqXyCT8iLs4EuRz75aPdrT7/lrI54x4bFXBHQMZ26sCEKi4adAOEVFa21k4nMpbiLqlVu7YI2Gt12gPJFgdbZu/QAk2dLYM4pfBJWrz4NVV9aEHne5ANVINVac37zVQRwcDONS3Y8Ct4DipP2n4CBY5usT2fu2xGga7VHXxPQsYW7hMn2jKa5hMk9tv/L/dkXz18mtyZx8Bb8lSnhdmryNSF7u4Jh60j6oim1OMexZVCEp/QbBRX3g3JWpbiB9UbONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSnGP7Y8jrd9BSsjmh5ESzAhzBAl9L2a+sunRjMAUm8=;
 b=IdSMSVCM1ecJVJ4MtPEgbWjoCwqlhoCynzRLKr2p68WJSHttyOsfmaiH/ErcrqxncbyIQSQmJufVp0CrDtzYtJjRjxyB+1lvjkUaCm7D/CWr9MasFT1WzBM0AQapi6Fib7Z0ZTZEk5s8knrHyKEUBVv2R5bVB7I0d3uUEpa3VGk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5146.namprd06.prod.outlook.com (2603:10b6:5:112::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 07:18:50 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:18:50 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Raveendran Somu <raveendran.somu@cypress.com>
Subject: [PATCH v2 1/5] brcmfmac: To fix kernel crash on out of boundary access
Date:   Thu,  4 Jun 2020 02:18:31 -0500
Message-Id: <20200604071835.3842-2-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200604071835.3842-1-wright.feng@cypress.com>
References: <20200604071835.3842-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 07:18:49 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b578fada-3a8c-43b6-a473-08d808578742
X-MS-TrafficTypeDiagnostic: DM6PR06MB5146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB51464449897925113F599F7EFB890@DM6PR06MB5146.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqLgGVyLvH7rRpPmglaHVXg2cQnF7RmMdH7+A8TXvr8rlXguSXR6ir/FyKnwQOmGe93iBGIKqzLgl87lb+3YwHXOZ+Snsnn529EoNRtbhlFjaRsvsnMj35OZZRK8jBNubUwCYSkzdsGG7vRykORukYkjBRZe0SIASKSyPlDUX4ZOPjCdseEJqj7T6fdy3C202T9uG2km/p5w1+NkxIIveS6bpI46JfFrVvenAMRlSraU3dLfrGB3Bsc+OzFKWXSwrUyKbb/0x0NgoLsloq7VrHCHK9JXX4rRYQPG4/aIzzxwjBFcjuMZ6LGFoTeNeeDXvqxcdlpselk9guu+O801AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(316002)(54906003)(6666004)(26005)(16526019)(186003)(2616005)(52116002)(36756003)(956004)(7696005)(44832011)(1076003)(8936002)(8676002)(83380400001)(107886003)(6916009)(5660300002)(2906002)(4326008)(86362001)(6486002)(478600001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DPzvmifythxjCwVnm/4Jy4QJENyrZJ5edMiPBJnKW3yMvXo/GSl7b7tVnPxZv277EWMUArKuA2ZvgRNhl+sSInEOrmcdKeczW2CW+0uHEuTEfFBBBnc6yuf1A9feqvO1zL0gF3x81FyP0YRMUWtFwyVZyHotlh+CWK9+coBHjs626Tm5Mc2BpxPp0E1cYI4/VFkF9/npXXUeg4Esb/SgpMUequDObJQMmvpCI34ew4wbeAk4fsfmQb8KHXZp43J5283PkFNjk8SQ8YcODalMDo8wQmkuM8fdAepr7KkZDRnC7+0G3/3qTFBvapMMXTYIycLC5MJ1k2zSzEBnovmieZcMaRgFi+U8B/VtZHJFSwO+H0S7yEM7mIkc9VHNqxHqx5fEYs7G3A3nlar8OsjkVa2dsJvS2XX94B+4psLpsI0YKNj7JFNMzJqDjgoBRrHCiv3jk2w3M0DK0gTiYst6obQ6wyAbgdBmzc9ye1IjqdW+SNfil2btIvz7sb3Vuv57
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b578fada-3a8c-43b6-a473-08d808578742
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:18:50.1546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IG9UH+NtSl6LVsRQ+2j/0chh1FrLhJmEsFlhcShNdpj/oLtIE+y1nIjUkIaAHa+x+7cJ5m4LsqL7FeBl9PPuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5146
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

To truncate the additional bytes, if extra bytes have been received.
Current code only have a warning and proceed without handling it.
But in one of the crash reported by DVT, these causes the
crash intermittently. So the processing is limit to the skb->len.

Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Wright Feng <wright.feng@cypress.com>
---
v2:
 - Correct all typos in commit message

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 09701262330d..531fe9be4025 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -1843,6 +1843,9 @@ void brcmf_fws_hdrpull(struct brcmf_if *ifp, s16 siglen, struct sk_buff *skb)
 
 	WARN_ON(siglen > skb->len);
 
+	if (siglen > skb->len)
+		siglen = skb->len;
+
 	if (!siglen)
 		return;
 	/* if flow control disabled, skip to packet data and leave */
-- 
2.25.0

