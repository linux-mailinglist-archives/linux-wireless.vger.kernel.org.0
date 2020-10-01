Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107E7280018
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Oct 2020 15:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgJAN0u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Oct 2020 09:26:50 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:10807 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbgJAN0s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Oct 2020 09:26:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601558807; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=E/GVxx0q28mPHE5Uz58HPbVOV06poC1avUaS0raLPCc=;
 b=eVHRj8+8k2i79BpQRbzqIbBEGJKjAAUtlDg5L0MDuWeXEX0Tcr5dd7cc3CgGQASAMzJWxeTA
 quSX8gLPeZHEUIXyJcu5uVpFhoAO+knI3W/L809jPC4ofcgiVcD6FAvBqvdkTlz3Rbiwb8iI
 62n/isLgyAzI3YkEHW+Kk1Nt6Go=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f75d9143aed3d14c00f546a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 01 Oct 2020 13:26:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6AF1C433FE; Thu,  1 Oct 2020 13:26:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30687C433CB;
        Thu,  1 Oct 2020 13:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30687C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] brcmfmac: Fix warning when hitting FW crash with flow
 control feature
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200928054922.44580-2-wright.feng@cypress.com>
References: <20200928054922.44580-2-wright.feng@cypress.com>
To:     Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, wright.feng@cypress.com,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201001132643.A6AF1C433FE@smtp.codeaurora.org>
Date:   Thu,  1 Oct 2020 13:26:43 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wright Feng <wright.feng@cypress.com> wrote:

> Brcmfmac got warning message when hitting FW crash in TX throughput test
> with fcmode=2. It's caused by FMAC flushed TXQ in brcmf_sdio_bus_stop
> but without doing hanger slot cleanup. Therefore, we move
> brcmf_remove_interface before brcmf_bus_stop to make sure the hanger
> slot is clean when flushing TXQ.
> 
> [ 1891.512234] WARNING: CPU: 1 PID: 2765 at drivers/net/wireless/broadcom/brcm80211/brcmutil/utils.c:49 brcmu_pkt_buf_free_skb+0x21/0x30 [brcmutil]
> [ 1891.512234] Modules linked in: brcmfmac(OE-) brcmutil(OE)
> cfg80211(OE) compat(OE) rfkill mmc_block(OE) sdhci_pci(OE) sdhci(OE)
> mmc_core(OE) ip6table_filter ip6_tables ebtable_nat ebtables
> dns_resolver fscache e1000e ppdev iTCO_wdt iTCO_vendor_support tpm_tis
> tpm_tis_core tpm mei_me mei pcspkr lpc_ich i2c_i801 mfd_core ptp
> pps_core parport_pc parport wmi tcp_bic uinput i915 iosf_mbi
> i2c_algo_bit drm_kms_helper drm i2c_core video [last unloaded: brcmfmac]
> [ 1891.512247] CPU: 1 PID: 2765 Comm: rmmod Tainted: G        W  OE
> 4.12.0 #1
> [ 1891.512247] Hardware name:                  /DH77EB, BIOS
> EBH7710H.86A.0100.2013.0312.1351 03/12/2013
> [ 1891.512248] task: ffff880118f08000 task.stack: ffffc90001180000
> [ 1891.512249] RIP: 0010:brcmu_pkt_buf_free_skb+0x21/0x30 [brcmutil]
> [ 1891.512249] RSP: 0018:ffffc90001183cc0 EFLAGS: 00010086
> [ 1891.512250] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000006
> [ 1891.512251] RDX: 0000000000000000 RSI: 0000000000000086 RDI:
> ffff880118e3ab00
> [ 1891.512251] RBP: ffffc90001183cc0 R08: 0000000000000000 R09:
> 000000000000a050
> [ 1891.512252] R10: 0000000000000001 R11: 0000000000aaaaaa R12:
> 00000000000000bc
> [ 1891.512253] R13: ffff880118b40c78 R14: 0000000000000002 R15:
> ffff880118e3ab00
> [ 1891.512253] FS:  00007f2a49760740(0000) GS:ffff88011f280000(0000)
> knlGS:0000000000000000
> [ 1891.512254] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1891.512254] CR2: 00000000012994a8 CR3: 000000011a3c4000 CR4:
> 00000000001406e0
> [ 1891.512255] Call Trace:
> [ 1891.512259]  brcmf_fws_cleanup+0x1ea/0x240 [brcmfmac]
> [ 1891.512264]  brcmf_fws_detach+0x42/0x60 [brcmfmac]
> [ 1891.512268]  brcmf_proto_bcdc_detach+0x26/0x40 [brcmfmac]
> [ 1891.512273]  brcmf_proto_detach+0x57/0x70 [brcmfmac]
> [ 1891.512277]  brcmf_detach+0x89/0x100 [brcmfmac]
> [ 1891.512282]  brcmf_sdio_remove+0x76/0x180 [brcmfmac]
> [ 1891.512286]  brcmf_sdiod_remove+0x25/0xb0 [brcmfmac]
> [ 1891.512291]  brcmf_ops_sdio_remove+0xbd/0x120 [brcmfmac]
> [ 1891.512294]  sdio_bus_remove+0x33/0x100 [mmc_core]
> [ 1891.512295]  device_release_driver_internal+0x141/0x200
> [ 1891.512297]  driver_detach+0x38/0x70
> [ 1891.512298]  bus_remove_driver+0x55/0xd0
> [ 1891.512299]  driver_unregister+0x2c/0x50
> [ 1891.512303]  sdio_unregister_driver+0x1a/0x20 [mmc_core]
> [ 1891.512307]  brcmf_sdio_exit+0x2f/0x40 [brcmfmac]
> [ 1891.512312]  brcmf_core_exit+0x15/0xd7 [brcmfmac]
> [ 1891.512316]  __exit_compat+0x9/0x2b [brcmfmac]
> [ 1891.512318]  SyS_delete_module+0x155/0x230
> [ 1891.512319]  ? exit_to_usermode_loop+0x70/0x99
> [ 1891.512321]  do_syscall_64+0x54/0xc0
> [ 1891.512322]  entry_SYSCALL64_slow_path+0x25/0x25
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>

2 patches applied to wireless-drivers-next.git, thanks.

d0151c2bad0a brcmfmac: Fix warning when hitting FW crash with flow control feature
6aa5a83a7ed8 brcmfmac: Fix warning message after dongle setup failed

-- 
https://patchwork.kernel.org/patch/11802905/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

