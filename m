Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D0B10906B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 15:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfKYOv0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 09:51:26 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:38481 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOvZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 09:51:25 -0500
Received: from [192.168.2.97] (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 82EE2580068;
        Mon, 25 Nov 2019 15:51:21 +0100 (CET)
Subject: Re: [PATCH v8 6/6] mt76: mt76x02: add channel switch support for usb
 interfaces
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
References: <20191121180001.22451-1-markus.theil@tu-ilmenau.de>
 <20191121180001.22451-7-markus.theil@tu-ilmenau.de>
 <20191125130449.GC28102@redhat.com>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 sGZPq8zmOtvOyZtafA==
Message-ID: <76778e31-5757-6e8b-eecb-b1b3a23acc6d@tu-ilmenau.de>
Date:   Mon, 25 Nov 2019 15:51:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125130449.GC28102@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/25/19 2:04 PM, Stanislaw Gruszka wrote:
> On Thu, Nov 21, 2019 at 07:00:01PM +0100, Markus Theil wrote:
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
>> index 90c024f12302..b9bd6bfb2a9d 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
>> @@ -210,6 +210,12 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
>>  
>>  	mt76x02_mac_set_beacon_prepare(dev);
>>  
>> +	mt76_csa_check(&dev->mt76);
>> +	if (dev->mt76.csa_complete) {
>> +		mt76_csa_finish(&dev->mt76);
>> +		goto out;
>> +	}
> mmio counterpart setup beacons on CSA, but do not sent buffered
> PS frames. Perhaps here we should do the same. However not sending
> beacons on one TBTT looks ok to me as well.
>
> Stanislaw
>
If I change the order of beacon iteration and csa check, the following warning in mac80211 gets triggered:

	/* the counter should never reach 0 */
	WARN_ON_ONCE(!beacon->csa_current_counter);

Dmesg output looks like this:

[  153.829617] ------------[ cut here ]------------
[  153.829752] WARNING: CPU: 0 PID: 224 at net/mac80211/tx.c:4318 __ieee80211_csa_update_counter.isra.0.part.0+0x5/0x10 [mac80211]
[  153.829756] Modules linked in: ccm bridge stp llc nft_masq nft_chain_nat nf_nat nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c nf_tables_set nf_tables nfnetlink ath10k_pci amd64_edac_mod mt76x2u edac_mce_amd mt76x2_common ath10k_core mt76x02_usb kvm_amd mt76_usb mt76x02_lib mt76 kvm ath mac80211 irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel cfg80211 pcengines_apuv2 gpio_keys_polled aesni_intel input_polldev crypto_simd gpio_amd_fch cryptd glue_helper igb pcspkr k10temp fam15h_power rfkill sp5100_tco i2c_piix4 libarc4 ccp i2c_algo_bit dca rng_core uio_pdrv_genirq uio leds_gpio evdev mac_hid pinctrl_amd coreboot_table acpi_cpufreq ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 sd_mod ahci sdhci_pci libahci cqhci libata sdhci crc32c_intel xhci_pci ehci_pci mmc_core xhci_hcd scsi_mod ehci_hcd gpio_keys
[  153.829948] CPU: 0 PID: 224 Comm: kworker/0:1H Not tainted 5.4.0-rc7-1-01110-g19b7e21c55c8 #32
[  153.829952] Hardware name: PC Engines apu2/apu2, BIOS v4.10.0.3 11/07/2019
[  153.829966] Workqueue: events_highpri mt76x02u_pre_tbtt_work [mt76x02_usb]
[  153.830067] RIP: 0010:__ieee80211_csa_update_counter.isra.0.part.0+0x5/0x10 [mac80211]
[  153.830077] Code: 4c 89 4a 18 c3 48 8b 47 10 4c 89 4f 10 48 89 4e 18 48 89 46 20 4c 89 08 eb a1 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 <0f> 0b c3 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 54 53 48 89 fb
[  153.830082] RSP: 0018:ffffbde8803d7c80 EFLAGS: 00010246
[  153.830089] RAX: 0000000000000003 RBX: ffffbde8803d7d20 RCX: ffffa3b01df8f658
[  153.830093] RDX: ffffbde8803d7d20 RSI: ffffa3b02901d450 RDI: ffffbde8803d7ce0
[  153.830097] RBP: ffffa3b0267007a0 R08: ffffffff8d011040 R09: 0000000000000000
[  153.830101] R10: ffffa3b029908098 R11: ffffa3b02ab2ab38 R12: 0000000000000000
[  153.830105] R13: ffffa3b02901d450 R14: 0000000000000000 R15: ffffa3b0284eae00
[  153.830111] FS:  0000000000000000(0000) GS:ffffa3b02aa00000(0000) knlGS:0000000000000000
[  153.830115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  153.830119] CR2: 00007fbb6b5c9f30 CR3: 0000000126ee2000 CR4: 00000000000406f0
[  153.830124] Call Trace:
[  153.830203]  __ieee80211_beacon_get+0x4c2/0x4d0 [mac80211]
[  153.830312]  ieee80211_beacon_get_tim+0x41/0x150 [mac80211]
[  153.830336]  mt76x02_update_beacon_iter+0x2d/0x40 [mt76x02_lib]
[  153.830352]  ? mt76x02_add_buffered_bc+0x80/0x80 [mt76x02_lib]
[  153.830420]  __iterate_interfaces+0x74/0x110 [mac80211]
[  153.830469]  ? mt76x02_add_buffered_bc+0x80/0x80 [mt76x02_lib]
[  153.830566]  ieee80211_iterate_interfaces+0x3a/0x50 [mac80211]
[  153.830580]  mt76x02u_pre_tbtt_work+0x96/0x220 [mt76x02_usb]
[  153.830600]  process_one_work+0x1e2/0x3b0
[  153.830610]  worker_thread+0x4a/0x3d0
[  153.830623]  kthread+0xfb/0x130
[  153.830631]  ? process_one_work+0x3b0/0x3b0
[  153.830639]  ? kthread_park+0x90/0x90
[  153.830650]  ret_from_fork+0x22/0x40
[  153.830665] ---[ end trace 7a658e5cbfd0f9d1 ]---

Markus

