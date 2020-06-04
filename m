Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291EC1EDDE5
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgFDHS6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:18:58 -0400
Received: from mail-bn7nam10on2105.outbound.protection.outlook.com ([40.107.92.105]:24672
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726411AbgFDHS5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLgOyvLuioGCqdVvGk82wuGzrVMY0nwiUteekpjCMq235LpdY5mc8y1NYTNGNNuZqcYChs5Ej37Nb1y9ddd6G+dvgP7TWUO0EzfaE+ZtPXKrNdLQRJ3yyFRXLTHHZjpPHcFkmqOsj2muq2eEgN7lnDLykpkVnI2zTN4qEQj4+D3Mh4i0qBNA6ROc7vlYH4EwTnVGZWeR+DoTf+BksIymsf9l98/CV2Xlj7VhwPUKQLJUYTFPDd5DHUfcW/QMgOtr9ZfICNCyqbuCS/aZjcl7ckM4g9nbhDSKpR7C0G3JVmycfq5M2SH9FJ4cnaAuaQW4lSOGqEPe/C1Nl36dtXXZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibNoBsucNltPwbEOckqM4A27xcl752GRwIYqZ7p9IFU=;
 b=cfX+XnIIloW1WrwK3Jiu3krzcuVRp5u82n+GH+uu+BvCIRgP00xx2hlF2UMd72iIQ2I/XSLw3P6SeyGBhU+dgYaGF3In9bf/gN5XyPivkXK0UgShEtLl7REWlSdqKCllJXt2QrxJ40bek+Jzqh5Wsi3rB4IyI1YRgTZd2yZlrBzdhxa6QdOd1u9UQbMQz+1fQB+1C0Er31TLLqy4WbMWcdWNv4nKrifDQyumGhcM+l1bP714GGSa9by4TjcdoDutZgyvySGlvS1jDEtHfqxCp2oOLMIeLFkGlALS8HHdOctBpjJ2v3SZPj/jci38LwMohyGbhwG2iiHQKNU+GjTpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibNoBsucNltPwbEOckqM4A27xcl752GRwIYqZ7p9IFU=;
 b=WGQKsSqsWb173EyhkdSa+mfufuWXRVUvI8FbuSUmKLUcL+EELaKqroSZrS/OwgxvRsFYaMN6YPs4StCpHrbqyzxo1oziB7+p5oIzxeL7D5bUltc4Z3GVjwZibi+0JFLWxPii3Tzp2wJ3G0ARBlyd06rDdS0HwEf3EkUzrDc6Xb4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5146.namprd06.prod.outlook.com (2603:10b6:5:112::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Thu, 4 Jun 2020 07:18:54 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:18:54 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH v2 3/5] brcmfmac: keep SDIO watchdog running when console_interval is non-zero
Date:   Thu,  4 Jun 2020 02:18:33 -0500
Message-Id: <20200604071835.3842-4-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200604071835.3842-1-wright.feng@cypress.com>
References: <20200604071835.3842-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18)
 To DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from iot-wlan-dev-u02.aus.cypress.com (12.110.209.245) by MN2PR01CA0049.prod.exchangelabs.com (2603:10b6:208:23f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 07:18:53 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 352be13f-3534-4bf2-3782-08d8085789e3
X-MS-TrafficTypeDiagnostic: DM6PR06MB5146:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB5146ADA18D23F21A22D4B08EFB890@DM6PR06MB5146.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDut9LO4wHEQyo8OjGMk2a2bfaYbp735SncgcJr4uIbMdPu0v69uFrK9T0GKeCv0wqTDnDWK9CPqg8Ht2KJVDbyLdXf8EfpcRtW+8pOdCujfWDZFshtm8ytZqMt/wRPBEHqO3VGT0/WexswmEK/aNDUyOck4p1WOYuOl1ntp1NOmg1UyDmQ87h3q1t6aRoAc+tVI8n1CgJ0x6cMuTfdBcc8JtCPuYLykJ5YJf8w561R48hJnwu2BwasTQz0hvTqRdFmDQnp/Y3PB7WEZwB68dBjjC9XqXayhsqqpuXSs55xozZpQttLFhdkVUR+SXCEFc2U5PRyz2pG6qy7cw7+EZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(366004)(136003)(316002)(54906003)(6666004)(26005)(16526019)(186003)(2616005)(52116002)(36756003)(956004)(7696005)(44832011)(1076003)(8936002)(8676002)(83380400001)(107886003)(6916009)(5660300002)(2906002)(4326008)(86362001)(6486002)(478600001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: pPUf9Xy85O1SO81KjHzHLwzHeuUVVSyLzRgthDYiP5KUzey0nxt9zncoDB2+hGzLGVJtX3/SrNAeZ6dBKqkqFAmbLfoTDuI0EzJa/q14DDv2eaka/hGhrLm4JUnRBqeJ3bSOwIQeD5jZJvcQtmcdofWMZKC4XZIHBdRFHkZG64GVQZkDTwN81XdVzTDfhiwjhB2KoIRHsWdS3D9pp0Qf9EE4Z8J9Td0z3Um4n7634C9KA9DSZnYiohvMWDyZltDJxHP+JMmVkSVfhqolZGuqut4uRr27qgRI9NVgIEaZOtPbtNR4d22g+2REX+BgrkTriR1Y4RoGZGTmAbw1atNe/fLZmWeuJCEEcpFbH3Uoegp1/+L7wMycOOJL755MmjxMT9flRDjEBDron7aQUwXeMimCOdAGlS2cK9cJyqpHNL+gaFCG8MZoyXSHaZM6g9n9oghZUJI8WzEM8JmW8jr7xmXkUzgs93MPXtHtUT8wy5KY12X6bwu0b9LIEXMbv1w9
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352be13f-3534-4bf2-3782-08d8085789e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:18:54.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/tS+O2p1tvnhNRAWcJ980XKMmVBdXPa8roHpZbBynFsRFbtY7IsGMZrimyne+P7zzfkL46SUcCzVuE/AxykCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5146
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

