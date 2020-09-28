Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC6627A711
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 07:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1FuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 01:50:17 -0400
Received: from mail-dm6nam10on2139.outbound.protection.outlook.com ([40.107.93.139]:31776
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgI1FuR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 01:50:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Og6OvUjiKAur4TPQmBHGiSWr8bSI5oTridiJM60W2tNM94KedYwq/kVjpTDwyVPVzbGZJQQMGAAWvSVF34+LINgDyY96ERvh4v2HHdCLPmqomGMePrSRqFZNUoKjLac/mChuIEbjCBBUL4d4mWxl8y/V4JSljAvrYUBEDbbOkNfzZNNcGVo6fCXHtL769wHUmNMyyxAAUD4jCLc0VgWiTCHMdG0EvB+rvVwdvaZ2r2oVkycZTwnni4EuAH1d5NwR5Tn0pIv4Oc1WG5izTge2RSK76N9KpqGG34B/t/uqg/wLDc/uTtqkxHreJuoWkF83woC8hO536yO2IqoWwj/uqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piqebC5GAUlnj1pdlO6BKNYU+TYMvPuIQItzhBesA+A=;
 b=X9mEbXOvCjA0ORuLDCw+fr7jMzi9uSqW8RZQvQ26WdBB7AMzxHUghJnTn1grimihD7uvNu4avIFn00Jf4BmjwHyGgMuRIqACUGweldlojN0Iz+to/oX4ZskXaf/0KzDByh8O5sWcO9hYhsALLuVe5RWiXkM5ecsI0CokbCdjMDi0bHDXeXWteOLjZczXfJUNJLZRwMR1Y8Dfsr2JyYEGtmATHnGgkD/sPDZSA0+evGAVaBkh8B+In+SWjqGfhHssAGRkMXeEz0qW2K4Fs3bkBybPvCTfD3OQzX8CTFY2bMnCeFvmDX4oI7tEjVXqbpOi3sFi5r1MieI2x86rQ+z9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piqebC5GAUlnj1pdlO6BKNYU+TYMvPuIQItzhBesA+A=;
 b=EGLskNKXMLNW1yanRxpRBPgRRPc9ZFOrQPX7nr/30dGgiZJMvAKBFl8MsCl6Yj9a7Rs9l+zGQtE4TeDaAjb8iscWbUaUVvYUu20VRYLxY+B8DyyKJ/mtkk7myF/E0udUhmUtkaaoPUDYpMKgPum0BxffFujAvUUAwxeDMwG56mA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB4097.namprd06.prod.outlook.com (2603:10b6:406:89::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 05:50:14 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::14ee:f61:60a2:1e48%5]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 05:50:14 +0000
From:   Wright Feng <wright.feng@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     wright.feng@cypress.com, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
Subject: [PATCH 1/2] brcmfmac: Fix warning when hitting FW crash with flow control feature
Date:   Mon, 28 Sep 2020 00:49:21 -0500
Message-Id: <20200928054922.44580-2-wright.feng@cypress.com>
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
Received: from aremote06.aus.cypress.com (157.95.12.33) by BL0PR1501CA0023.namprd15.prod.outlook.com (2603:10b6:207:17::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 05:50:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7807946a-5401-47b7-f89c-08d863725ed6
X-MS-TrafficTypeDiagnostic: BN7PR06MB4097:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB4097B938130EC9D998DBB267FB350@BN7PR06MB4097.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbzFk7buKnIT5BT89sTXkjUpplEVcGAgabeEUvpCSFUCPfEBQxYCouUxOXcDOKwsgg1uAssFO4x/R7ip/RIir2hXL5P1URfdT8RL2Rm9iylmucR7ywG0tELbb39kI7sJBQyju3T6ns7OkKuKYb4xMZQu6e9rZGnRlkaT2BTxRspvnT17gnfeUz/UXJRW9/kSFW7RqbTyVGwLfN3QIncwZRI8n12PZk7NjYVkO6foNZGIejYK/HAcyaiTZ8BOEs50UB9O8jh++ZqUCSDALmiIJYNjbn5BWnIjwEHgCKeIsvccMkZ5O3kzrKGx3TNN003zNaLaSbBKOFX0LSIsfGBpq3DX6YoYo1YxQmwvpCnhT2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(7696005)(316002)(36756003)(4326008)(186003)(6486002)(16526019)(6916009)(44832011)(83380400001)(2616005)(956004)(66476007)(66556008)(66946007)(54906003)(5660300002)(8676002)(52116002)(107886003)(478600001)(45080400002)(86362001)(26005)(1076003)(8936002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rsdP9jjVPBPWDAKxMbwmNTPlHdQQxFAgwyoqeWiDvNUODvThzB54qwSO7CuhOpSdG5UZjEKubTdSbObin1DMiRKlACm2ZvZRlWC+e+05TIvBzSry7suN1RGFVY5EeupUCwnHvUGIKyFv1HfY8uVPey7hk4sThgGmO6fXira/eNGhf8TBLzIiavhhARvzKu4Z1KdEgBvR1MUzleRAcL/jVcwoKzwxDJX2+90dheG+Q3jndqGPq6zwIKJm+LtXbZz6c5WSZRejYUBVl0Qs/xjFqWWIyDQ930iv78OnQtp/kU1hI3d3PPWC3JlQBwGHHu+oJTGq1mwpJl2zSacQlRRPpQATqRXQmMBdgJ2q6K3XQqPJqhC/VYlbb2BDATBZRIQdBoxHedKuwUgTWAZtMkMy8qp0fIiJ6SJjORFV2Ris1mtcHtWr4YlKYVmi99YCUzkI0d7ha5/VCGVSMZUZ4uaBJ2SHeK33Pn5ncf2FsQORZ1sLHx0WNdmvOJzysIURm4aD9m8dIYHueVx9QxM3IpRh490bhS9Oy6a1rpwAEM1/LquI+RtYS4TSHNQc+LdJsnlC+zyG9daRUcSqyd9B25Z/U6z1BTl/NvIICLOU+oh5Qw91TLgM07JJ3HMXE2LT8gTgd8jmB0eAvNPG54M/nICZuQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7807946a-5401-47b7-f89c-08d863725ed6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5889.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 05:50:14.5061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpxLc+CadT4jd5Qg4/oe5dGIeW0PooWlNQv931NPwAxdXE+VUDaiUi9rucWEaawJ7gO0Na534Pk1+ALDYl/+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB4097
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brcmfmac got warning message when hitting FW crash in TX throughput test
with fcmode=2. It's caused by FMAC flushed TXQ in brcmf_sdio_bus_stop
but without doing hanger slot cleanup. Therefore, we move
brcmf_remove_interface before brcmf_bus_stop to make sure the hanger
slot is clean when flushing TXQ.

[ 1891.512234] WARNING: CPU: 1 PID: 2765 at drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c:49 brcmu_pkt_buf_free_skb+0x21/0x30 [brcmutil]
[ 1891.512234] Modules linked in: brcmfmac(OE-) brcmutil(OE)
cfg80211(OE) compat(OE) rfkill mmc_block(OE) sdhci_pci(OE) sdhci(OE)
mmc_core(OE) ip6table_filter ip6_tables ebtable_nat ebtables
dns_resolver fscache e1000e ppdev iTCO_wdt iTCO_vendor_support tpm_tis
tpm_tis_core tpm mei_me mei pcspkr lpc_ich i2c_i801 mfd_core ptp
pps_core parport_pc parport wmi tcp_bic uinput i915 iosf_mbi
i2c_algo_bit drm_kms_helper drm i2c_core video [last unloaded: brcmfmac]
[ 1891.512247] CPU: 1 PID: 2765 Comm: rmmod Tainted: G        W  OE
4.12.0 #1
[ 1891.512247] Hardware name:                  /DH77EB, BIOS
EBH7710H.86A.0100.2013.0312.1351 03/12/2013
[ 1891.512248] task: ffff880118f08000 task.stack: ffffc90001180000
[ 1891.512249] RIP: 0010:brcmu_pkt_buf_free_skb+0x21/0x30 [brcmutil]
[ 1891.512249] RSP: 0018:ffffc90001183cc0 EFLAGS: 00010086
[ 1891.512250] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000006
[ 1891.512251] RDX: 0000000000000000 RSI: 0000000000000086 RDI:
ffff880118e3ab00
[ 1891.512251] RBP: ffffc90001183cc0 R08: 0000000000000000 R09:
000000000000a050
[ 1891.512252] R10: 0000000000000001 R11: 0000000000aaaaaa R12:
00000000000000bc
[ 1891.512253] R13: ffff880118b40c78 R14: 0000000000000002 R15:
ffff880118e3ab00
[ 1891.512253] FS:  00007f2a49760740(0000) GS:ffff88011f280000(0000)
knlGS:0000000000000000
[ 1891.512254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1891.512254] CR2: 00000000012994a8 CR3: 000000011a3c4000 CR4:
00000000001406e0
[ 1891.512255] Call Trace:
[ 1891.512259]  brcmf_fws_cleanup+0x1ea/0x240 [brcmfmac]
[ 1891.512264]  brcmf_fws_detach+0x42/0x60 [brcmfmac]
[ 1891.512268]  brcmf_proto_bcdc_detach+0x26/0x40 [brcmfmac]
[ 1891.512273]  brcmf_proto_detach+0x57/0x70 [brcmfmac]
[ 1891.512277]  brcmf_detach+0x89/0x100 [brcmfmac]
[ 1891.512282]  brcmf_sdio_remove+0x76/0x180 [brcmfmac]
[ 1891.512286]  brcmf_sdiod_remove+0x25/0xb0 [brcmfmac]
[ 1891.512291]  brcmf_ops_sdio_remove+0xbd/0x120 [brcmfmac]
[ 1891.512294]  sdio_bus_remove+0x33/0x100 [mmc_core]
[ 1891.512295]  device_release_driver_internal+0x141/0x200
[ 1891.512297]  driver_detach+0x38/0x70
[ 1891.512298]  bus_remove_driver+0x55/0xd0
[ 1891.512299]  driver_unregister+0x2c/0x50
[ 1891.512303]  sdio_unregister_driver+0x1a/0x20 [mmc_core]
[ 1891.512307]  brcmf_sdio_exit+0x2f/0x40 [brcmfmac]
[ 1891.512312]  brcmf_core_exit+0x15/0xd7 [brcmfmac]
[ 1891.512316]  __exit_compat+0x9/0x2b [brcmfmac]
[ 1891.512318]  SyS_delete_module+0x155/0x230
[ 1891.512319]  ? exit_to_usermode_loop+0x70/0x99
[ 1891.512321]  do_syscall_64+0x54/0xc0
[ 1891.512322]  entry_SYSCALL64_slow_path+0x25/0x25

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/core.c   | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index f89010a81ffb..83f812eb81d9 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1422,6 +1422,11 @@ void brcmf_detach(struct device *dev)
 #endif
 
 	brcmf_bus_change_state(bus_if, BRCMF_BUS_DOWN);
+	/* make sure primary interface removed last */
+	for (i = BRCMF_MAX_IFS - 1; i > -1; i--) {
+		if (drvr->iflist[i])
+			brcmf_remove_interface(drvr->iflist[i], false);
+	}
 	brcmf_bus_stop(drvr->bus_if);
 
 	brcmf_fweh_detach(drvr);
@@ -1432,12 +1437,6 @@ void brcmf_detach(struct device *dev)
 		drvr->mon_if = NULL;
 	}
 
-	/* make sure primary interface removed last */
-	for (i = BRCMF_MAX_IFS - 1; i > -1; i--) {
-		if (drvr->iflist[i])
-			brcmf_del_if(drvr, drvr->iflist[i]->bsscfgidx, false);
-	}
-
 	if (drvr->config) {
 		brcmf_p2p_detach(&drvr->config->p2p);
 		brcmf_cfg80211_detach(drvr->config);
-- 
2.25.0

