Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A201EB4FCD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 16:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfIQOC6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 10:02:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44812 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfIQOC6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 10:02:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51FCC6141D; Tue, 17 Sep 2019 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568728977;
        bh=QnXhl4cJTx647hMaJtAVeHBgkr0piUqdNzsW72RnNps=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LKPpdGroGDBb4h33xtYU+D00q8O1zo0LUPhtd8NMjhq9KpuxOXSXvfuU6EmTqutCy
         SOdcEkfqVaNiMqYLDfbwk1Le6hocwHqmR9XEkTNy8C21s8uGETuPSNSr2pAa068XAF
         uy1dMV+eiMH78XyNBDuz8I8/IzCKd81yzpGZ2r5c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 712856021C;
        Tue, 17 Sep 2019 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568728975;
        bh=QnXhl4cJTx647hMaJtAVeHBgkr0piUqdNzsW72RnNps=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=idCQlFte0Ia/nua7QqISEuiv13RoVpbdUnxCheYO/wc3EtXgwSIHlH534cNQQvEfX
         ClVN8zerx9+6vLRPUIBhZWp8QaSZC3nKUJ6mpMNqfQaQDxi/DxQW8l9W0AklOkjUX7
         6eXMbsuY2zLJioTs2hIDVneKVvyr13mUZg8fqq0s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 712856021C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: Check if station exists before forwarding tx
 airtime report
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190818190920.22813-1-hauke@hauke-m.de>
References: <20190818190920.22813-1-hauke@hauke-m.de>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     hannu.nyman@iki.fi, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, mpubbise@codeaurora.org,
        Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190917140257.51FCC6141D@smtp.codeaurora.org>
Date:   Tue, 17 Sep 2019 14:02:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hauke Mehrtens <hauke@hauke-m.de> wrote:

> It looks like the FW on QCA9984 already reports the tx airtimes before
> the station is added to the peer entry. The peer entry is created in
> ath10k_peer_map_event() just with the vdev_id and the ethaddr, but
> not with a station entry, this is added later in ath10k_peer_create() in
> callbacks from mac80211.
> 
> When there is no sta added to the peer entry, this function fails
> because it calls ieee80211_sta_register_airtime() with NULL.
> 
> This was reported in OpenWrt some time ago:
> https://bugs.openwrt.org/index.php?do=details&task_id=2414
> 
> This commit should fix this crash:
> [   75.991714] Unable to handle kernel paging request at virtual address fffff9e8
> [   75.991756] pgd = c0204000
> [   75.997955] [fffff9e8] *pgd=5fdfd861, *pte=00000000, *ppte=00000000
> [   76.000537] Internal error: Oops: 37 [#1] SMP ARM
> [   76.006686] Modules linked in: pppoe ppp_async ath10k_pci ath10k_core ath pptp pppox ppp_mppe ppp_generic mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_helper xt_esp xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY usbserial slhc nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_log_ipv4 nf_flow_table_hw nf_flow_table nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack_netlink iptable_raw iptable_mangle iptable_filter ipt_ah ipt_ECN ip_tables crc_ccitt compat chaoskey fuse sch_cake sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32
> [   76.059974]  cls_tcindex cls_route cls_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred ledtrig_usbport xt_set ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set nfnetlink ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6t_NPT ip6t_MASQUERADE nf_nat_masquerade_ipv6 nf_nat nf_conntrack nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 msdos ip_gre gre ifb sit tunnel4 ip_tunnel tun vfat fat hfsplus cifs nls_utf8 nls_iso8859_15 nls_iso8859_1 nls_cp850 nls_cp437 nls_cp1250 sha1_generic md5 md4
> [   76.130634]  usb_storage leds_gpio xhci_plat_hcd xhci_pci xhci_hcd dwc3 dwc3_of_simple ohci_platform ohci_hcd phy_qcom_dwc3 ahci ehci_platform sd_mod ahci_platform libahci_platform libahci libata scsi_mod ehci_hcd gpio_button_hotplug ext4 mbcache jbd2 exfat crc32c_generic
> [   76.154772] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.132 #0
> [   76.177001] Hardware name: Generic DT based system
> [   76.182990] task: c0b06d80 task.stack: c0b00000
> [   76.187832] PC is at ieee80211_sta_register_airtime+0x24/0x148 [mac80211]
> [   76.192211] LR is at ath10k_htt_t2h_msg_handler+0x678/0x10f4 [ath10k_core]
> [   76.199052] pc : [<bf75bfac>]    lr : [<bf83e8b0>]    psr: a0000113
> [   76.205820] sp : c0b01d54  ip : 00000002  fp : bf869c0c
> [   76.211981] r10: 0000003c  r9 : dbdca138  r8 : 00060002
> [   76.217192] r7 : 00000000  r6 : dabe1150  r5 : 00000000  r4 : dbdc95c0
> [   76.222401] r3 : 00000000  r2 : 00060002  r1 : 00000000  r0 : 00000000
> [   76.229003] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   76.235509] Control: 10c5787d  Table: 5c94006a  DAC: 00000051
> [   76.242716] Process swapper/0 (pid: 0, stack limit = 0xc0b00210)
> [   76.248446] Stack: (0xc0b01d54 to 0xc0b02000)
> [   76.254532] 1d40:                                              dbdc95c0 00000000 dabe1150
> [   76.258808] 1d60: 00000001 dabe1150 dbdca138 0000003c bf869c0c bf83e8b0 00000002 c0314b10
> [   76.266969] 1d80: dbdc9c70 00000001 00000001 dabe114c 00010000 00000000 dbdcd724 bf88f3d8
> [   76.275126] 1da0: c0310d28 db393c00 dbdc95c0 00000000 c0b01dd0 c07fb4c4 dbdcd724 00000001
> [   76.283286] 1dc0: 00000022 bf88b09c db393c00 00000022 c0b01dd0 c0b01dd0 00000000 dbdcc5c0
> [   76.291445] 1de0: bf88f04c dbdcd654 dbdcd71c dbdc95c0 00000014 dbdcd724 dbdcc5c0 00000005
> [   76.299605] 1e00: 0004b400 bf85c360 00000000 bf87101c c0b01e24 00000006 00000000 dbdc95c0
> [   76.307764] 1e20: 00000001 00000040 0000012c c0b01e80 1cf51000 bf85c448 dbdcd440 dbdc95c0
> [   76.315925] 1e40: dbdca440 ffffa880 00000040 bf88cb68 dbdcd440 00000001 00000040 ffffa880
> [   76.324084] 1e60: c0b02d00 c06d72e0 dd990080 c0a3f080 c0b255dc c0b047e4 c090afac c090e80c
> [   76.332244] 1e80: c0b01e80 c0b01e80 c0b01e88 c0b01e88 dd4cc200 00000000 00000003 c0b0208c
> [   76.340405] 1ea0: c0b02080 40000003 ffffe000 00000100 c0b02080 c03015c8 00000000 00000001
> [   76.348564] 1ec0: dd408000 c0a38210 c0b2c7c0 0000000a ffffa880 c0b02d00 c07fb764 00200102
> [   76.356723] 1ee0: dd4cc268 c0a3e414 00000000 00000000 00000001 dd408000 de803000 00000000
> [   76.364883] 1f00: 00000000 c03247cc c0a3e414 c0368f1c c0b03f60 c0b153cc de80200c de802000
> [   76.373042] 1f20: c0b01f48 c0301488 c0308630 60000013 ffffffff c0b01f7c 00000000 c0b00000
> [   76.381204] 1f40: 00000000 c030c08c 00000001 00000000 00000000 c0315180 ffffe000 c0b03cc0
> [   76.389363] 1f60: c0b03c70 00000000 00000000 c0a2da28 00000000 00000000 c0b01f90 c0b01f98
> [   76.397522] 1f80: c030862c c0308630 60000013 ffffffff 00000051 00000000 ffffe000 c035dd18
> [   76.405681] 1fa0: 000000bf c0b03c40 00000000 c0b2c000 dddfce80 c035e060 c0b2c040 c0a00cf4
> [   76.413842] 1fc0: ffffffff ffffffff 00000000 c0a0067c c0a2da28 00000000 00000000 c0b2c1d4
> [   76.422001] 1fe0: c0b03c5c c0a2da24 c0b07ee0 4220406a 512f04d0 4220807c 00000000 00000000
> [   76.430335] [<bf75bfac>] (ieee80211_sta_register_airtime [mac80211]) from [<00000002>] (0x2)
> [   76.438314] Code: e1cd81f0 e1a08002 e1cda1f8 e58de020 (e5102618)
> [   76.446965] ---[ end trace 227a38ade964d642 ]---
> 
> Fixes: bb31b7cb106c ("ath10k: report tx airtime provided by fw")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b10f32672946 ath10k: Check if station exists before forwarding tx airtime report

-- 
https://patchwork.kernel.org/patch/11099861/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

