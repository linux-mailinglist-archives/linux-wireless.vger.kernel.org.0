Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAAF1E9EFA
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2020 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFAHU5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jun 2020 03:20:57 -0400
Received: from mail-bn8nam11on2111.outbound.protection.outlook.com ([40.107.236.111]:48577
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgFAHU5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jun 2020 03:20:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp1n6k//K1O8e3uTFfG5IKzwkPdzaoTpAehE5TQwLg2Kaa69aym+4+8W6PnumSes+c+yM4ufvZGaYAMoRbCIz/qF3pfzFC1cUnecz1IuhWme0gbS5BBEx9MFV1jTDbmwboK1O+G3XkZ/h5FT+LdQu5CsEAPTXV0z+uIt7WooXhgbkHXT/8+yarqw7a3yySnAS4UXizU/OQ2PKFWw3DrI9CBf21ZQKtXjRLy45vvSIAOD/PRn5TKshCpB3rrFXjjBqjdJqs9ouvPRlDbuzZEitOdpOfuFjOAclxZdX08JShbeg2nF6u75w+YfnANpD02+m+R03o7d6Lv4PIp0zeG+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibNoBsucNltPwbEOckqM4A27xcl752GRwIYqZ7p9IFU=;
 b=IFBSixPBVZPNNARnhRB6Y/GJXhz8jYvX9ZJoGFwXRKBZfRg0zWB9DHwcJ2PKPUkrbkv3KhoDRl1POKVebWQF3A8A1nAycNuBNCudUwOcAJmuN27iCWOheRmYKnwwgOoTlNO39TnxQbqDtYaknLGzk6nk4ObwoHnJu89RQFV3Uwlbgds8ICOKp76cLtpP8vGIUvQK4DCmhLoSKG67+TtQ74rb/POaFTNW1N3tC/GIXOvGJctjoA0zgMJtjZwx6I1572JBnsxLZQ8UfPNE//tqq9fZ5ygmFtY74xsP2cFoCjq1TDaBrpYrBIoQwvTiBhM4PQHJO7jD/TPfNXafS3Cdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibNoBsucNltPwbEOckqM4A27xcl752GRwIYqZ7p9IFU=;
 b=OUE17tgkEXIt33FAQaZBfKikLbZJ1hxa2EqIhAgP3FKXYVybr5yRnON4Z6Ct2T//yVu7YhjXlYShaDNDEy8gVGfMNXQwJAAkY4xLvvsLQmaecz/gRAIhTvFw2wLIjrzRS2a9x25UxJjTZ7tDsnTdsHWPEXoQJorH2VZfriZKKVs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB6074.namprd06.prod.outlook.com (2603:10b6:5:10f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17; Mon, 1 Jun 2020 07:20:54 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3045.018; Mon, 1 Jun 2020
 07:20:54 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 3/5] brcmfmac: keep SDIO watchdog running when console_interval is non-zero
Date:   Mon,  1 Jun 2020 02:19:51 -0500
Message-Id: <20200601071953.23252-4-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200601071953.23252-1-wright.feng@cypress.com>
References: <20200601071953.23252-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3045.21 via Frontend Transport; Mon, 1 Jun 2020 07:20:52 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4f48885-721b-42a4-e7be-08d805fc51e3
X-MS-TrafficTypeDiagnostic: DM6PR06MB6074:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB607417BBEF00EEF0CB5EA648FB8A0@DM6PR06MB6074.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWNLaySN85fTP2gmzvuVG41XFw/0xnxFU+ht/q07uYFauZWFys+0hGfp5LxSZSVf9Jl0yBbjfWj8teG4SMBYHjLIfO7q/NRqeHeK+12e5IBVZXwVbp7WE8Zp1G8KBHQaD8BNB++3QEox62qZg/gNtUCvEShmr6Z2BezdyYMLXstedr1qlHV8RkS/Vr/REYxizLtmwKlH52gFfc8ZIfhoRTF86Cj7xy4YU1exlEQ/7gq+sJxZ3UFS+YkaiJX/3ZTMUi+mhiMC/zGSYDxcwFK7LQ7FdIwD0Cpp44rcT346JEkU3t9E/nhqp/FIMfMXyRMeuEN2Ye3YevqF1T/FKciIKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(39860400002)(376002)(107886003)(6486002)(83380400001)(66476007)(66556008)(66946007)(4326008)(316002)(54906003)(8676002)(8936002)(36756003)(7696005)(52116002)(5660300002)(6916009)(44832011)(186003)(16526019)(478600001)(86362001)(2616005)(26005)(1076003)(956004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hy2+2A+wgWedaSBsFfL1Fwi6JBVCgYwqqXdEvmHBCtp+/HF8ya5VOqtdY6kP1lrNZOYN9Q+oCUXW6iOSEE5Es+bnnBAtCut69rpoCKr+0fi3s7Z+aG66bBUVbOCbCn9U2wOqsygJKetzJfrRXASkrCMEx+HvpDvyqaOVhDD68VBsYGtRjXxjpAR6k9kBzxXlAqQF2JlmhiIpOhArm0VOukPoAdvSaWWNlPPoHh/Lr6BMxt3ZrsHXIkNTT37BIl7+CR1cDLP07nawack5oShZtnvG6x6E0B1XIJyiy5NMiRztntJYKNxJH/XeR6emKMoS7hVrnoGaUdfRcvFpk0XzzqUc9EnW2Szm1TrvcjADKIMHJaXyZhg6qZtw51yArnbQVVXQhtlmJEfJg9riosMVH2W2k4zs40G2Rr7LIrJaJNbT19NI6zkZ2jXbrYrjhVQsIwtKf6x+UuO63atTsFezTgrvocRu02i+CJvE0LijcKlhT+o3WpDnjTQt0NBevpw8
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f48885-721b-42a4-e7be-08d805fc51e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 07:20:54.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1br+Ae3UhZvFjkxBdkKernengCTtgAutzTw4ftt5JagC5zF4dbakr+UxAn3tvPAsjhqUFGR9nAHSbfTlMs/dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6074
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

brcmfmac host driver makes SDIO bus sleep and stops SDIO watchdog if no
pending event or data. As a result, host driver does not poll firmware
console buffer before buffer overflow, which leads to missing firmware
logs. We should not stop SDIO watchdog if console_interval is non-zero
in debug build.

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index ce6f15284277..50444989ae09 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -3686,7 +3686,11 @@ static void brcmf_sdio_bus_watchdog(struct brcmf_sdio *bus)
 			if (bus->idlecount > bus->idletime) {
 				brcmf_dbg(SDIO, "idle\n");
 				sdio_claim_host(bus->sdiodev->func1);
-				brcmf_sdio_wd_timer(bus, false);
+#ifdef DEBUG
+				if (!BRCMF_FWCON_ON() ||
+				    bus->console_interval == 0)
+#endif
+					brcmf_sdio_wd_timer(bus, false);
 				bus->idlecount = 0;
 				brcmf_sdio_bus_sleep(bus, true, false);
 				sdio_release_host(bus->sdiodev->func1);
-- 
2.25.0

