Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885295F927E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 00:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiJIWtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 18:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiJIWs4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 18:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1E63DC;
        Sun,  9 Oct 2022 15:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1117060C19;
        Sun,  9 Oct 2022 22:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25E7C433D6;
        Sun,  9 Oct 2022 22:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665354280;
        bh=UXuYkRg57IpIdhL+0EpbJonj4qIC8kvPF/3E5EhuwQc=;
        h=From:To:Cc:Subject:Date:From;
        b=EecdMCajY1Uvmh2twPF0DppSRNI0xtkpggbp1Som+GqJV/nBM/BACj0lWnsdP06UM
         ia3DDJAv/bQqiYH6QwcVeAwYl7CpoFR3KqzBwfKtg7hWKDmq8SpryArL9muix9D98g
         LzmykBPSOPXSW3U2fI+OU3ojl3FsYkVOXjlpcIGE8KhYvr0fFA0G0YdPQYXe4bHBRJ
         S5uWeHP5UHACiQbEPVqIZO9s6vtaZzWL4eXHuMnNLTmCEpk1tTJxgYkS/8SGdcyKnn
         q0l/rPvtt4TfX55EG6x/or9cb+VxXZUJNO7y8sVL4BjJ6mo8EhgR+BxQhkx2GQm2N2
         Bn4gDUqI+QjgQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wright Feng <wright.feng@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/25] wifi: brcmfmac: fix invalid address access when enabling SCAN log level
Date:   Sun,  9 Oct 2022 18:24:06 -0400
Message-Id: <20221009222436.1219411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Wright Feng <wright.feng@cypress.com>

[ Upstream commit aa666b68e73fc06d83c070d96180b9010cf5a960 ]

The variable i is changed when setting random MAC address and causes
invalid address access when printing the value of pi->reqs[i]->reqid.

We replace reqs index with ri to fix the issue.

[  136.726473] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
[  136.737365] Mem abort info:
[  136.740172]   ESR = 0x96000004
[  136.743359]   Exception class = DABT (current EL), IL = 32 bits
[  136.749294]   SET = 0, FnV = 0
[  136.752481]   EA = 0, S1PTW = 0
[  136.755635] Data abort info:
[  136.758514]   ISV = 0, ISS = 0x00000004
[  136.762487]   CM = 0, WnR = 0
[  136.765522] user pgtable: 4k pages, 48-bit VAs, pgdp = 000000005c4e2577
[  136.772265] [0000000000000000] pgd=0000000000000000
[  136.777160] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  136.782732] Modules linked in: brcmfmac(O) brcmutil(O) cfg80211(O) compat(O)
[  136.789788] Process wificond (pid: 3175, stack limit = 0x00000000053048fb)
[  136.796664] CPU: 3 PID: 3175 Comm: wificond Tainted: G           O      4.19.42-00001-g531a5f5 #1
[  136.805532] Hardware name: Freescale i.MX8MQ EVK (DT)
[  136.810584] pstate: 60400005 (nZCv daif +PAN -UAO)
[  136.815429] pc : brcmf_pno_config_sched_scans+0x6cc/0xa80 [brcmfmac]
[  136.821811] lr : brcmf_pno_config_sched_scans+0x67c/0xa80 [brcmfmac]
[  136.828162] sp : ffff00000e9a3880
[  136.831475] x29: ffff00000e9a3890 x28: ffff800020543400
[  136.836786] x27: ffff8000b1008880 x26: ffff0000012bf6a0
[  136.842098] x25: ffff80002054345c x24: ffff800088d22400
[  136.847409] x23: ffff0000012bf638 x22: ffff0000012bf6d8
[  136.852721] x21: ffff8000aced8fc0 x20: ffff8000ac164400
[  136.858032] x19: ffff00000e9a3946 x18: 0000000000000000
[  136.863343] x17: 0000000000000000 x16: 0000000000000000
[  136.868655] x15: ffff0000093f3b37 x14: 0000000000000050
[  136.873966] x13: 0000000000003135 x12: 0000000000000000
[  136.879277] x11: 0000000000000000 x10: ffff000009a61888
[  136.884589] x9 : 000000000000000f x8 : 0000000000000008
[  136.889900] x7 : 303a32303d726464 x6 : ffff00000a1f957d
[  136.895211] x5 : 0000000000000000 x4 : ffff00000e9a3942
[  136.900523] x3 : 0000000000000000 x2 : ffff0000012cead8
[  136.905834] x1 : ffff0000012bf6d8 x0 : 0000000000000000
[  136.911146] Call trace:
[  136.913623]  brcmf_pno_config_sched_scans+0x6cc/0xa80 [brcmfmac]
[  136.919658]  brcmf_pno_start_sched_scan+0xa4/0x118 [brcmfmac]
[  136.925430]  brcmf_cfg80211_sched_scan_start+0x80/0xe0 [brcmfmac]
[  136.931636]  nl80211_start_sched_scan+0x140/0x308 [cfg80211]
[  136.937298]  genl_rcv_msg+0x358/0x3f4
[  136.940960]  netlink_rcv_skb+0xb4/0x118
[  136.944795]  genl_rcv+0x34/0x48
[  136.947935]  netlink_unicast+0x264/0x300
[  136.951856]  netlink_sendmsg+0x2e4/0x33c
[  136.955781]  __sys_sendto+0x120/0x19c

Signed-off-by: Wright Feng <wright.feng@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220722115632.620681-4-alvin@pqrs.dk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/pno.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pno.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pno.c
index ffa243e2e2d0..581a23549ee5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pno.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pno.c
@@ -163,12 +163,12 @@ static int brcmf_pno_set_random(struct brcmf_if *ifp, struct brcmf_pno_info *pi)
 	struct brcmf_pno_macaddr_le pfn_mac;
 	u8 *mac_addr = NULL;
 	u8 *mac_mask = NULL;
-	int err, i;
+	int err, i, ri;
 
-	for (i = 0; i < pi->n_reqs; i++)
-		if (pi->reqs[i]->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-			mac_addr = pi->reqs[i]->mac_addr;
-			mac_mask = pi->reqs[i]->mac_addr_mask;
+	for (ri = 0; ri < pi->n_reqs; ri++)
+		if (pi->reqs[ri]->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
+			mac_addr = pi->reqs[ri]->mac_addr;
+			mac_mask = pi->reqs[ri]->mac_addr_mask;
 			break;
 		}
 
@@ -190,7 +190,7 @@ static int brcmf_pno_set_random(struct brcmf_if *ifp, struct brcmf_pno_info *pi)
 	pfn_mac.mac[0] |= 0x02;
 
 	brcmf_dbg(SCAN, "enabling random mac: reqid=%llu mac=%pM\n",
-		  pi->reqs[i]->reqid, pfn_mac.mac);
+		  pi->reqs[ri]->reqid, pfn_mac.mac);
 	err = brcmf_fil_iovar_data_set(ifp, "pfn_macaddr", &pfn_mac,
 				       sizeof(pfn_mac));
 	if (err)
-- 
2.35.1

