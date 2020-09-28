Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4906327A712
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 07:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgI1FuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 01:50:20 -0400
Received: from mail-dm6nam10on2127.outbound.protection.outlook.com ([40.107.93.127]:22753
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgI1FuT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 01:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IazdOV8hVfc/g7g7ZNapFaCbhYD0nvcWfL3MsFQYdFJCXF0bA+xLkhlE96eL3tx1irdTjhAHJkMSmAh2vFFIIXJBjhZUCyvH/282THprlyxZ9Ztra3Y0YmZ3s8/IsZ2ktkm2h+g9/6YQL5sZdcoDBXQmzBd6w8ukc/WvbJxdqM8NAp+SW2oUVZvIoAGZCwkZkTuMzGrNET1YqW5562ASeA+8r6Dis8cq2PcnJvaIenKop67YkxURxrTBmio+f8MifIdCamC+BrT+G0tKuXw5xq9x8KnisqL0BBr41+q2jkFqrj72UsiuFicoIMt9Zp86qT0sk0dJMq7u3kJM/4DGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWhz2gFXlKViTEYtJKJs5IUc+/d97tLZiM+i6FY5KEQ=;
 b=fYZ7TvN4lIT/CiJh0UYyIyqekcRlPU15k0nc9Kuq0qhhhu5ykG3vjEPJCwepyOkVFmzzNhywGttUk6XabfkMzZOur6+tUkRt4lVz5MOd1aKeeJgxSYx1LfMEaiXxz522ew5BZVgdIshXyVwoqxkNf0SlllJOxdYSdOoQ5BYc+Yq1z7KBo7P5bM69vKnDA9Sp3bDxUFPe35muc8vIG7bGf0Bg7xJH0HxdJrwcsa16mm/JmdKn94I8/+bQWA7PUtMSDArSk3zWqz3RPFGuwl2hVSjjjmEx/hvE1+uWHB6eakMPf7hpI+t0D6LmmcoUtiMo/PQD2Ov90iSyDJfGy3BqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWhz2gFXlKViTEYtJKJs5IUc+/d97tLZiM+i6FY5KEQ=;
 b=QuOFU5RZyZYM+mzXt4wWOJdO9aLCaY3yTJ8NRXyqgwqHqWBjlPt8d80AiCl4cHcHrveFmoR05oIpBgQwBlPTOkxzColLbDGf11HMtMdGFPOP7SGeyuzMMYeuqUQTCCdT+3BgMLg54LeNYaYgJ9eEiV36/co77OD1J/knQbTmGHM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB4097.namprd06.prod.outlook.com (2603:10b6:406:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 05:50:17 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 05:50:17 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 2/2] brcmfmac: Fix warning message after dongle setup failed
Date:   Mon, 28 Sep 2020 00:49:22 -0500
Message-Id: <20200928054922.44580-3-wright.feng@cypress.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200928054922.44580-1-wright.feng@cypress.com>
References: <20200928054922.44580-1-wright.feng@cypress.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [157.95.12.33]
X-ClientProxiedBy: BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL0PR1501CA0023.namprd15.prod.outlook.com (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 05:50:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a854ea5-ff25-4084-d198-08d863726056
X-MS-TrafficTypeDiagnostic: BN7PR06MB4097:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB4097642462B624EF6778A1ACFB350@BN7PR06MB4097.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8x3E40U4pf6GejOcC3XRuh18MBKh57PEEd2fSqjzXtgfeYVFI3qJTToerBbWoZ2jNKBg6hrEtzqCeNDhYjI6mb6cNArW6mmoF3TZHyuaJ6F6+k1ceBbB8ervPB0BGVmxaoyqJMQemC1MgkKYbk/xPMAOL/wA3vapZRhMXJDOVXhnViFqEu5e84ph/1qLmDgAvED+vHVjE3Nh7KgmfCx6Pqq1qhMbN9EVtMUlInjRKJ3opRBh8Z6BawwClG/x9uWWlRO/P+OPw56Wpu8Af/a/HFdHTkShaFjRrcuDqjHUaWdlUSwL6+yGMd2TooGrhjELlcUPxyc7B8t97zIRtOODp3gaOpuDHGu6Ay3q1um4dN6cw20dD5sRpeYYJAeNJ09
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(7696005)(316002)(36756003)(4326008)(186003)(6486002)(16526019)(6916009)(44832011)(83380400001)(2616005)(956004)(66476007)(66556008)(66946007)(54906003)(5660300002)(15650500001)(8676002)(52116002)(107886003)(478600001)(86362001)(26005)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: C2+SHIa3wkCXeVAWdi2m6n7/b1KkBp3YUlAqrEUF/seGDxGbXs+XMR7xCIytJVGS5ELQgu6H/L/9W4T2EPKRvW28hC0tQaln8R72TXGGE7CCrRmGfK2kQ57RVvIOMph9EhZpmvBlp0bBDNfPxWz5iUAJKOT1dDPt6Rney/ddt+Yhff+lSHPjUIzxvI93BwpwQtCKNzXNWh3qr6W4iBd3iFPoRMnjAiq5Me1CfJohkr8206+tQjzxzkW+jNPT4yziuSQhifMnY/Y0iBf9EbJ+OewDqmXviJfQqFEOm5dpymDHL2G8gUv2Gp6DPO3woj4MTOutCcNb8luGopriUCktb+jVD4h+kwPODWY6V+aDRIQUcpMa3t0pZGAmLJhph15fq6m0Ao7TIiequFr4JaUhAqG8t7lLQ8VsWmUR9AYEM60TnZBss4XI73zK47eNw3gLOLOKKmgjVlFz5sUTI1WhVuTFgFbiI6m+6q2qZMIAKuH3zlP11+S+CZR5QbPndzwXkkMM7KqVKuUS5uCtz3FRZfhT3HFlb9Jxc0seStRXf0QsiyK0myhk+mT71ldxalcRaaeIfamZ9JlpcA816amMjlYmXSApulCgC5FTlu9D3QjaT0YAwJY9l8mFeEzZRC9NvlO9HwTxqOmWL+RY4j5Rbw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a854ea5-ff25-4084-d198-08d863726056
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 05:50:17.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtMo/kAOXme0qcPUSIQpN/MhFls+FjsjKdUSiqzoZxuw/NYlZEmtVwPS3H6CIwo8SosU4kwULqwC82oPJHf4XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB4097
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brcmfmac showed warning message in fweh.c when checking the size of event
queue which is not initialized. Therefore, we only cancel the worker and
reset event handler only when it is initialized.

[  145.505899] brcmfmac 0000:02:00.0: brcmf_pcie_setup: Dongle setup
[  145.929970] ------------[ cut here ]------------
[  145.929994] WARNING: CPU: 0 PID: 288 at drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c:312
brcmf_fweh_detach+0xbc/0xd0 [brcmfmac]
...
[  145.930029] Call Trace:
[  145.930036]  brcmf_detach+0x77/0x100 [brcmfmac]
[  145.930043]  brcmf_pcie_remove+0x79/0x130 [brcmfmac]
[  145.930046]  pci_device_remove+0x39/0xc0
[  145.930048]  device_release_driver_internal+0x141/0x200
[  145.930049]  device_release_driver+0x12/0x20
[  145.930054]  brcmf_pcie_setup+0x101/0x3c0 [brcmfmac]
[  145.930060]  brcmf_fw_request_done+0x11d/0x1f0 [brcmfmac]
[  145.930062]  ? lock_timer_base+0x7d/0xa0
[  145.930063]  ? internal_add_timer+0x1f/0xa0
[  145.930064]  ? add_timer+0x11a/0x1d0
[  145.930066]  ? __kmalloc_track_caller+0x18c/0x230
[  145.930068]  ? kstrdup_const+0x23/0x30
[  145.930069]  ? add_dr+0x46/0x80
[  145.930070]  ? devres_add+0x3f/0x50
[  145.930072]  ? usermodehelper_read_unlock+0x15/0x20
[  145.930073]  ? _request_firmware+0x288/0xa20
[  145.930075]  request_firmware_work_func+0x36/0x60
[  145.930077]  process_one_work+0x144/0x360
[  145.930078]  worker_thread+0x4d/0x3c0
[  145.930079]  kthread+0x112/0x150
[  145.930080]  ? rescuer_thread+0x340/0x340
[  145.930081]  ? kthread_park+0x60/0x60
[  145.930083]  ret_from_fork+0x25/0x30

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/fweh.c    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index a5cced2c89ac..921b94c4f5f9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -304,10 +304,12 @@ void brcmf_fweh_detach(struct brcmf_pub *drvr)
 {
 	struct brcmf_fweh_info *fweh = &drvr->fweh;
 
-	/* cancel the worker */
-	cancel_work_sync(&fweh->event_work);
-	WARN_ON(!list_empty(&fweh->event_q));
-	memset(fweh->evt_handler, 0, sizeof(fweh->evt_handler));
+	/* cancel the worker if initialized */
+	if (fweh->event_work.func) {
+		cancel_work_sync(&fweh->event_work);
+		WARN_ON(!list_empty(&fweh->event_q));
+		memset(fweh->evt_handler, 0, sizeof(fweh->evt_handler));
+	}
 }
 
 /**
-- 
2.25.0

