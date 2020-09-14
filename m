Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2626830B
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Sep 2020 05:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgINDQ4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Sep 2020 23:16:56 -0400
Received: from mail-co1nam11on2096.outbound.protection.outlook.com ([40.107.220.96]:49120
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgINDQz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Sep 2020 23:16:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaCDH15zw9AI2Drv5r3iJIGVwfAMb2UfgH8W+lIebD3RVHG5zfxnPUwV/bAsYuYkw/l5S2Gau6eunLSsosxsMxeDIZhXtaY+q5hPZF1rAr64e+knKcOhilY+sq4IQ+hy6YTN71i7BVUAU/AcwTIMlPPJ5bEgU6lrHbttql3KE3GKN4mIH1m44iy6KPMOf531PRaVbLwbulOuxsuocSEaIX/25xvdpGU1onWjZpqNBdn+NlDZxx46mLvmEHkrFpWLHlp53+pTAVqvyxE5gLWGaM6CRi8CpWm1s4hx6/UUroNczSWdCETmyY/WrejyBg48fLylAYwoqKKFZd9kZcwMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyV0tIkFg92r0eszQO7pADzNpNv8qFi1MikJNOKfTfk=;
 b=KhDRFvs2L5qAzacT2iSspbZqRKFr+wOkFZSMZEgqnV+A73/vuaLJaVf0o7cu97qd/Snk7QIt69iJ8r76clLX4A3NH5XnBZoHQl7vA7wJaWuJLUD+ST220DKx6qt+bPW5OCtcqrvC084tuiqq2hXVmYjiKEr3pSdkJlxkX7BZo3ZGL9XBJsmUIKZnF+q6djRoAmOD12wgWVEpS/vycymmNoifjmZtGZPbPI/OeEIAJV9feNSUkspCp0NiNO/L744qv4dPvyHU/mbPo41h+MSI7VE/GRPFXDF6TEdp1fRAtYJJA052ecRaO2uFBCnfIyneylx93G9jv48opxnt+S0qRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyV0tIkFg92r0eszQO7pADzNpNv8qFi1MikJNOKfTfk=;
 b=nuYpPtAQfDaO765xqyYyYX8YJcSvvAHoHPsqnuWjfqeTMJOd4uj73bt8JbASVuOTloh//TOl5OjJBh+PN4LjabJ7gM7RtTJbgBFzP9rlOqr1XzMNcFmVQMkDOckMLqJlANokksnfmGHY3SPnOFWiIO0k/Bn7eoJGPn564Bb89gk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN8PR06MB5377.namprd06.prod.outlook.com (2603:10b6:408:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 03:16:53 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::d82b:5f42:b7a8:d819%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 03:16:53 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        "Double Lo" <double.lo@cypress.com>
Subject: [PATCH v2 3/3] brcmfmac: increase dcmd max control buffer size
Date:   Sun, 13 Sep 2020 22:16:34 -0500
Message-Id: <20200914031634.190721-4-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200914031634.190721-1-wright.feng@cypress.com>
References: <20200914031634.190721-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Mon, 14 Sep 2020 03:16:52 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [157.95.12.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b9567ab-c11e-40b4-e620-08d8585ca0c8
X-MS-TrafficTypeDiagnostic: BN8PR06MB5377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR06MB537701EAED65B72831A387BCFB230@BN8PR06MB5377.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcwL2RYRWLRgWcJAXv3RSKpuYl5JzvH0Jk7z35q65C82j6iiQ+THNpb5LTBDudgX4FbJXyX96Y5OTC57HrWWojZbmoXyM2nVkgoVmDE0QmTwGAl5waMRpvEr07ykgFjO79vR8uv3qnsCaiIwMkq65NRtEoe7xAKx5XFZBkWHFT1E1zn/ePMBe+AbheS+yYQhuIn4KLQO+WWv5vLKp2QeUaCc5mQ4TIY7WoU0Wy2zMU2lIAxKv/DJGT6+Z6dX4/lMxy0coSFT67cRK9/MqQ+jw0EtMGzmc0gQ/Zl4pMpx8u+Qba1llS/sn95KPf0l6Oy65DVGJ6PIXv7QhyL3D7edlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(36756003)(26005)(7696005)(52116002)(6916009)(6486002)(66556008)(66476007)(1076003)(83380400001)(86362001)(16526019)(66946007)(186003)(4326008)(8936002)(8676002)(44832011)(2906002)(478600001)(316002)(54906003)(2616005)(956004)(5660300002)(6666004)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Iohbnh8kV47r3K1zPLQzGstoZeznEOsAFqNFa4BaTc1jMyqYCtBnPNI82Fvx+XEK+jX9e57C9Lnrj3yEzA6RLNAzAuWq6MlQPpoYyx1va6Dl3QCZAiA6pTKrBEOMJ9b8oQFv5BQq1Hac7sNLnjuvDSyeE5icXm0fhsZ1EGzgIbkMncO1/Nxu2dUH4yMYSeS743UwNSTgFjwhHfMWRoIZCHAoWEFt2XwkIiKja98yBd4CI1EtAgnVdFTCz9EZYVLYWLz+179xADGIwIHxfYmVOdeewBe54eFBoWn5Y7ejFTRjvXMRwGXdo7z0Uzk28f86jnC56Pva1p3TeaLa0cEeSdxQNjjeqd1SLijKjgDn/NhuJJYwlxGmePgmNnbjtrGBdutiTwC/xjK1GrdXMH+oRPClPjh4TcsF9X4W4FOacfS3lBoJr1kS7WRz9LlZX9RsdfuyJ3WmLuPIHWmGbiEZ+uz4LXkkdl2SYtndrdejyX2BQzykPFljgDw6ds1hcUV314KWfl6VI38ZbyJPX1tfVbujFwIXFRZIcbpZq6e5a2O0DffI1lRAwY93VMbQOmSYaRCFVcEGxufYL8KdxFIt1ANPvMAtL+hYr4V4BP1IIJet6X4X0tWkqchymszdqxhq3DtsGD/b7NgjW5Dqv59xXQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9567ab-c11e-40b4-e620-08d8585ca0c8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 03:16:53.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9M93x2q7Gm1f4fhOaIWOMsB+5g/eF1gyQO90i5fqfwidMTrHAf4M6p+V1CaXCGR6xkwMX9GZoOW0NUKmxABdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5377
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Double Lo" <double.lo@cypress.com>

Add the padding round up value in the max control buffer
size to match firmware configuration for new chips.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
index 2c95a08a5871..705130cf27d5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
@@ -87,6 +87,8 @@ struct brcmf_proto_bcdc_header {
 					 * plus any space that might be needed
 					 * for bus alignment padding.
 					 */
+#define ROUND_UP_MARGIN 2048
+
 struct brcmf_bcdc {
 	u16 reqid;
 	u8 bus_header[BUS_HEADER_LEN];
@@ -471,7 +473,7 @@ int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr)
 
 	drvr->hdrlen += BCDC_HEADER_LEN + BRCMF_PROT_FW_SIGNAL_MAX_TXBYTES;
 	drvr->bus_if->maxctl = BRCMF_DCMD_MAXLEN +
-			sizeof(struct brcmf_proto_bcdc_dcmd);
+			sizeof(struct brcmf_proto_bcdc_dcmd) + ROUND_UP_MARGIN;
 	return 0;
 
 fail:
-- 
2.25.0

