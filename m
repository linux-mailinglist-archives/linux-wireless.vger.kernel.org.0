Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2638C1D94F1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgESLKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 07:10:30 -0400
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com ([40.107.92.100]:56385
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726157AbgESLK3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 07:10:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwuZEMzxa9u36yGhv/C42h0sB4HrQvXQjHu+1QbM5w1nYktfCe0wJmYhgOdhiT7NyWPCMDzuSkPAwL8eGkdJVrfBMsTtPGAxY+t2bKjQf5e+hMC2lBidcwGqddrehubi0iQrSVh1+ayqPnW0455QTPvNhxQh7iFAs0VJh95Z8k7jQ2pWEpW0L343rdmSGBA4zq+kX/MjL0kHyfhR3mdG8fvlslOf3pnbIlMXJ5J19jM+Y5bZSgs9Nc3z5bUpw5PceNhLWtanaCA+KE4/dFDzZDGwIDmUH5XXDmAhv8EmTy30zfOk6Djcw3ATdBBUyC0KG9HhrOghb5RpK4JccUC2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VICEm403AhP5Knd7Lytlui+ps2b/Q+mICDGcXfHd65s=;
 b=ihWRVM7aQu8PxkH7Ak4phT99w9Fi4xKsNU33c5KS7DuSq9LCO20/KycBxLN1alawBKq7X86Z7RC9cp0aGR/3//na2mjOeFQ/9iYU8wCY7HKHAp2rjegPgwgbovXZFyYsyFj0FMj59Dw2N34/HVfi0cRgkeBU6y7F/ECG9rOA9ewuhekQ1hDOXwbNubRDf9uXqWSGlOt/D47+Bl3f7BIH/J73j3linYTanqoWMESO0taGERGCkKgJ/JMj+jMzW1Khdh4K6RVaA68OqI0PgYP1h3WTydWWaO8LC6SU73wieB/203OEjrnC/YuT+TVX0m7C4liiBiojdoGt/SZMyakFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VICEm403AhP5Knd7Lytlui+ps2b/Q+mICDGcXfHd65s=;
 b=OvF6n9BzcGgoWtWQ5Ia9QBqny799nBQGtUuNKAP96QaOmAxg2+4ieBL2qO+1V+HOS1UpciA8C+REKp45WfIAGi88UQ4jH6pas1uMWHwjeMT8DIE93y0uZOWtBVozE7f2NAbqHpEHWO9M19mkyaqPhRUY3IJTudHuc78eX1XG0Fs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4906.namprd06.prod.outlook.com (2603:10b6:5:56::11) by
 DM6PR06MB3964.namprd06.prod.outlook.com (2603:10b6:5:86::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Tue, 19 May 2020 11:10:26 +0000
Received: from DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f]) by DM6PR06MB4906.namprd06.prod.outlook.com
 ([fe80::c0ed:fb1f:a976:5c3f%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 11:10:26 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <double.lo@cypress.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 4/4] brcmfmac: increase dcmd maximum buffer size
Date:   Tue, 19 May 2020 06:09:51 -0500
Message-Id: <20200519110951.88998-5-chi-hsien.lin@cypress.com>
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
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 11:10:05 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 437d01be-e2cd-49fc-e892-08d7fbe53010
X-MS-TrafficTypeDiagnostic: DM6PR06MB3964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB396476DC6D8440D8FCDAB59FBBB90@DM6PR06MB3964.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: neMMvItcLTXCzjDMitD8Hpr+hCVNiTiYtbjrzxtLCwrWZ1X11VLsSJtK5R32ORdTuHpuQoL7TSDBEUXmBmWQQ5GaIeOCduKl98GdbCtZqPK72gdblDorSGEXrvHJCMZC8gWz9TkQu7hw0smdspbB+c0lCpBZXOTh3zQxF1kdiePhEEJSId1ewPsF274OWVAsfdZUHbAVVxBcLTqz48y9DZIwcJro+VmFzVK/8CztFwWv/lriGKz11cy/ZVfCI9oulOKats0koMkCL2WPK0kjsrWh97VnknMseJYM9LTZ5q0otZRgn6rcF13+mU+RlbS+4hOtUOi4p4sts8J9Y1BMxsfp+MkrTQF7kuGhy7AgoUi08cpL1RBTHj8y2JBGApjMYodo6p4+0nGZaJtoDt7KzjFK3+UAHx3bcpvJXtD+fvmS+vSIIk9L2EcP0CNfOpZh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4906.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(39860400002)(396003)(346002)(2616005)(316002)(26005)(54906003)(107886003)(86362001)(2906002)(956004)(4326008)(1076003)(6666004)(6486002)(6916009)(16526019)(186003)(5660300002)(8936002)(7696005)(36756003)(52116002)(478600001)(66946007)(8676002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vF1iGIYtGl4vVcTJgiqZQWiQrAwkVTd/eGhRxNidKwBlQ6r0Y7tZqQAV30cNfJrcll16S5i5mN9jwc33diiOIl4hd0uU2ld2m0vuK9TKWkdtQLydnHSn4JZMjNO1U8lFU4E/0BNEQk2fAc/ACE0t1LacwBa9hrgifsTj0ynXx/jXzIdd2bYi7IW24TcIRDnj+p167XLbAwkh+HPPuR3c7KMJnDrqzgv6tyQBznDO1ACEzxj8y0XWXe9LSe/LDViqswP/woJUtgCaKyU8C0pJJj0AWdNaSERyIFU4UL84V5XmIIrXL8OSwPdgi/wcrAgCFHGO7883Q3e23/c9dZFT1DEGCzDuWj6UlQq5jfzBB8Y+VgqNa4Ff6Lfh87mBgUSB8RhTMK5LYCTy9YtB0W9iqhdvJi0SEn5wtcJDAhSS9YDQTU9AOCBwRP6X9URCAosSbIxhAMs9LIfeWoKbsYdgIa21Y7dpjJo6kaZ+AO4FtL0PUtBamHTWIkEUrm3qxNHF
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437d01be-e2cd-49fc-e892-08d7fbe53010
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 11:10:07.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: US5JsQjS+JJyldEY0ILWOtJCQS9wezsrw1OPY15FqxtW98AWjy//WsHuySRaqxP9IjaF7pEdaMosPQBVQrmNpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3964
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Double Lo <double.lo@cypress.com>

Increase dcmd maximum buffer size to match firmware configuration for
new chips.

Signed-off-by: Double Lo <double.lo@cypress.com>
Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c b/driv=
ers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
index 2c95a08a5871..705130cf27d5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c
@@ -87,6 +87,8 @@ struct brcmf_proto_bcdc_header {
                                         * plus any space that might be nee=
ded
                                         * for bus alignment padding.
                                         */
+#define ROUND_UP_MARGIN 2048
+
 struct brcmf_bcdc {
        u16 reqid;
        u8 bus_header[BUS_HEADER_LEN];
@@ -471,7 +473,7 @@ int brcmf_proto_bcdc_attach(struct brcmf_pub *drvr)

        drvr->hdrlen +=3D BCDC_HEADER_LEN + BRCMF_PROT_FW_SIGNAL_MAX_TXBYTE=
S;
        drvr->bus_if->maxctl =3D BRCMF_DCMD_MAXLEN +
-                       sizeof(struct brcmf_proto_bcdc_dcmd);
+                       sizeof(struct brcmf_proto_bcdc_dcmd) + ROUND_UP_MAR=
GIN;
        return 0;

 fail:
--
2.25.0


This message and any attachments may contain confidential information from =
Cypress or its subsidiaries. If it has been received in error, please advis=
e the sender and immediately delete this message.
