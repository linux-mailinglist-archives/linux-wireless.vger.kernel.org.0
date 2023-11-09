Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85757E713B
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 19:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbjKISJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 13:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKISJp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 13:09:45 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69F258A
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 10:09:43 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 95AEFC00070
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 18:09:41 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 2A07A13C2B0
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 10:09:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2A07A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699553380;
        bh=XTOYK+RCarPLHsmlVTf6o7bKLjzVKBzgkxfJMVrspCY=;
        h=Date:To:From:Subject:From;
        b=cxoADCMUANPB8e27qvG35G96rlyeTqX8qrZjgZU0rVUOAykSVVMDDjSIKXh9R2fo3
         pLjp6UnapDsVlcawKW8BgRmpnQkRT2aPkV3ro/LZBI5AGNLOUmP33W403G1kkwRlUi
         0mXZILi1rDLFTFjLcRSY0uraO8PBM2W4gmd9t/V0=
Message-ID: <a7771a34-fc79-c8be-5fc6-006183687998@candelatech.com>
Date:   Thu, 9 Nov 2023 10:09:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Why ieee80211_mgd_probe_ap ignores MLD vifs?
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1699553382-rYT9NZQ8-9Iz
X-MDID-O: us5;at1;1699553382;rYT9NZQ8-9Iz;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

In 6.7.0-rc1-ish, I see a splat from the WARN_ON_ONCE below.  I enabled MLO on some
be200 radios against a TPLINK AP, attempting to connect to the MLO ssid.

I traced git back to where code was originally added (in slightly different form),
but that was a big patch and it is not clear to me why we should not probe here.

So, can anyone share the reason?

static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
				   bool beacon)
{
	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
	bool already = false;

	lockdep_assert_wiphy(sdata->local->hw.wiphy);

	if (WARN_ON_ONCE(ieee80211_vif_is_mld(&sdata->vif)))
		return;

4442 Nov 09 09:58:05 ct523c-2103 kernel: ------------[ cut here ]------------
4443 Nov 09 09:58:05 ct523c-2103 kernel: WARNING: CPU: 0 PID: 961 at net/mac80211/mlme.c:3382 ieee80211_mgd_probe_ap+0x81/0xc0 [mac80211]
4444 Nov 09 09:58:05 ct523c-2103 kernel: Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q 
garp mrp stp llc macvlan pktgen rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt ee1004 intel_pmc_bxt iTCO_vendor_support        iwlmvm 
coretemp intel_rapl_common intel_tcc_cooling mac80211 x86_pkg_temp_thermal snd_hda_codec_hdmi intel_powerclamp kvm_intel 
snd_hda_codec_realtek iwlwifi snd_hda_codec_generic kvm ledtrig_audio irqbypass cfg80211 snd_hda_intel snd_intel_dspcfg intel_wmi_thunderbolt pcspkr 
snd_hda_codec snd_hda_core snd_hwdep snd_seq tpm_crb bfq snd_seq_device mei_hdcp mei_pxp snd_pcm snd_timer i2c_i801 snd tpm_tis intel_pch_thermal 
soundcore i2c_smbus tpm_tis_core tpm acpi_pad nfsd auth_rpcgss nfs_acl lockd grace sch_fq_codel sunrpc fuse zram raid1 dm_raid raid456 libcrc32c 
async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq igb i915 i2c_algo_bit drm_buddy intel_gtt drm_display_helper drm_kms_helper       cec 
rc_core ttm drm ixgbe agpgart mdio dca
4445 Nov 09 09:58:05 ct523c-2103 kernel:  xhci_pci mei_wdt xhci_pci_renesas hwmon i2c_core video wmi [last unloaded: nfnetlink]
4446 Nov 09 09:58:05 ct523c-2103 kernel: CPU: 0 PID: 961 Comm: kworker/u16:13 Tainted: G        W          6.7.0-rc1+ #6
4447 Nov 09 09:58:05 ct523c-2103 kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
4448 Nov 09 09:58:05 ct523c-2103 kernel: Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
4449 Nov 09 09:58:05 ct523c-2103 kernel: RIP: 0010:ieee80211_mgd_probe_ap+0x81/0xc0 [mac80211]
4450 Nov 09 09:58:05 ct523c-2103 kernel: Code: 02 89 93 3c 14 00 00 a8 02 75 d1 48 8b bb 60 0f 00 00 e8 a2 fd ff ff 48 89 df c7 83 20 14 00 00 00 00 00 
00 5b e9 2f fb ff ff <0f> 0b c3 8b 0d ca d7 03 00 48 8d 97 78 0f 00 00 31 ff 48 c7 c6 30
4451 Nov 09 09:58:05 ct523c-2103 kernel: RSP: 0018:ffffc900035f3e40 EFLAGS: 00010202
4452 Nov 09 09:58:05 ct523c-2103 kernel: RAX: 0000000000000008 RBX: ffff888135a70378 RCX: ffff888135a70398
4453 Nov 09 09:58:05 ct523c-2103 kernel: RDX: ffff888135a70398 RSI: 0000000000000001 RDI: ffff888138e68a00
4454 Nov 09 09:58:05 ct523c-2103 kernel: RBP: ffff888138e69de0 R08: 745e72736d647564 R09: ffff88813870b200
4455 Nov 09 09:58:05 ct523c-2103 kernel: R10: 000000000000000f R11: fefefefefefefeff R12: ffff888135a703c0
4456 Nov 09 09:58:05 ct523c-2103 kernel: R13: ffff888135a703a8 R14: ffff888120073c05 R15: ffff888120058cb0
4457 Nov 09 09:58:05 ct523c-2103 kernel: FS:  0000000000000000(0000) GS:ffff88845dc00000(0000) knlGS:0000000000000000
4458 Nov 09 09:58:05 ct523c-2103 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
4459 Nov 09 09:58:05 ct523c-2103 kernel: CR2: 00007fa4a864ccc8 CR3: 0000000002634005 CR4: 00000000003706f0
4460 Nov 09 09:58:05 ct523c-2103 kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
4461 Nov 09 09:58:05 ct523c-2103 kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
4462 Nov 09 09:58:05 ct523c-2103 kernel: Call Trace:
4463 Nov 09 09:58:05 ct523c-2103 kernel:  <TASK>
4464 Nov 09 09:58:05 ct523c-2103 kernel:  ? ieee80211_mgd_probe_ap+0x81/0xc0 [mac80211]
4465 Nov 09 09:58:05 ct523c-2103 kernel:  ? __warn+0x78/0x130
4466 Nov 09 09:58:05 ct523c-2103 kernel:  ? ieee80211_mgd_probe_ap+0x81/0xc0 [mac80211]
4467 Nov 09 09:58:05 ct523c-2103 kernel:  ? report_bug+0x169/0x1a0
4468 Nov 09 09:58:05 ct523c-2103 kernel:  ? handle_bug+0x41/0x70
4469 Nov 09 09:58:05 ct523c-2103 kernel:  ? exc_invalid_op+0x13/0x60
4470 Nov 09 09:58:05 ct523c-2103 kernel:  ? asm_exc_invalid_op+0x16/0x20
4471 Nov 09 09:58:05 ct523c-2103 kernel:  ? ieee80211_mgd_probe_ap+0x81/0xc0 [mac80211]
4472 Nov 09 09:58:05 ct523c-2103 kernel:  cfg80211_wiphy_work+0x8c/0xb0 [cfg80211]
4473 Nov 09 09:58:05 ct523c-2103 kernel:  process_one_work+0x15d/0x330
4474 Nov 09 09:58:05 ct523c-2103 kernel:  worker_thread+0x2e8/0x400
4475 Nov 09 09:58:05 ct523c-2103 kernel:  ? rescuer_thread+0x400/0x400
4476 Nov 09 09:58:05 ct523c-2103 kernel:  kthread+0xdc/0x110
4477 Nov 09 09:58:05 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
4478 Nov 09 09:58:05 ct523c-2103 kernel:  ret_from_fork+0x28/0x40
4479 Nov 09 09:58:05 ct523c-2103 kernel:  ? kthread_complete_and_exit+0x20/0x20
4480 Nov 09 09:58:05 ct523c-2103 kernel:  ret_from_fork_asm+0x11/0x20
4481 Nov 09 09:58:05 ct523c-2103 kernel:  </TASK>
4482 Nov 09 09:58:05 ct523c-2103 kernel: ---[ end trace 0000000000000000 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

