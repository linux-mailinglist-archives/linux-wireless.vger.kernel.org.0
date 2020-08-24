Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DBD24F18A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 05:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgHXD3w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Aug 2020 23:29:52 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:30514 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgHXD3v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Aug 2020 23:29:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598239790; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RlEqKZrNc5bchYDvuyDavUGCUK4wOrs0tOHldktmziU=;
 b=jRpRu3gJChFXdEj1qL8IwEH6+0qroDeKoBOMndsT2FliG3YL0Zp8FAWZqLVUkZJp7ZDZvGhy
 gAWK1W0nV7HGkOonnD5Bx5axX3tX7BildmJLQOgBsSLNm9Qq/1bCn5JjX93mcPTntpjpkKym
 /kjfGBJ27jClwn1yt4mRrYxv8JE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f433427cdcfa9e21aef4b21 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 03:29:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4E2F7C433C6; Mon, 24 Aug 2020 03:29:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 438EDC433CA;
        Mon, 24 Aug 2020 03:29:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Aug 2020 11:29:42 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v5 8/8] ath11k: Add support for 6g scan hint
In-Reply-To: <20200603001724.12161-9-pradeepc@codeaurora.org>
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
 <20200603001724.12161-9-pradeepc@codeaurora.org>
Message-ID: <a9525954a6bd3055350cf4c3f29bab55@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-03 08:17, Pradeep Kumar Chitrapu wrote:
...
> @@ -2126,6 +2136,68 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k 
> *ar,
> 
>  	ptr += extraie_len_with_pad;
> 
> +	if (params->num_hint_s_ssid) {
> +		len = params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
> +		tlv = ptr;
> +		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
> +			      FIELD_PREP(WMI_TLV_LEN, len);
> +		ptr += TLV_HDR_SIZE;
> +		s_ssid = ptr;
> +		for (i = 0; i < params->num_hint_s_ssid; ++i) {
> +			s_ssid->freq_flags = params->hint_s_ssid[i].freq_flags;
> +			s_ssid->short_ssid = params->hint_s_ssid[i].short_ssid;
> +			s_ssid++;
> +		}
> +		ptr += len;
> +	}
> +
> +	if (params->num_hint_bssid) {
> +		len = params->num_hint_bssid * sizeof(struct hint_bssid);
> +		tlv = ptr;
> +		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
> +			      FIELD_PREP(WMI_TLV_LEN, len);
> +		ptr += TLV_HDR_SIZE;
> +		hint_bssid = ptr;
> +		for (i = 0; i < params->num_hint_bssid; ++i) {
> +			hint_bssid->freq_flags =
> +				params->hint_bssid[i].freq_flags;
> +			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
> +					&hint_bssid->bssid.addr[0]);
> +			hint_bssid++;
> +		}
> +	}
> +
> +	len = params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
> +	tlv = ptr;
> +	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
> +		      FIELD_PREP(WMI_TLV_LEN, len);
> +	ptr += TLV_HDR_SIZE;
> +	if (params->num_hint_s_ssid) {
> +		s_ssid = ptr;
> +		for (i = 0; i < params->num_hint_s_ssid; ++i) {
> +			s_ssid->freq_flags = params->hint_s_ssid[i].freq_flags;
> +			s_ssid->short_ssid = params->hint_s_ssid[i].short_ssid;
> +			s_ssid++;
> +		}
> +	}
> +	ptr += len;
> +
> +	len = params->num_hint_bssid * sizeof(struct hint_bssid);
> +	tlv = ptr;
> +	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
> +		      FIELD_PREP(WMI_TLV_LEN, len);
> +	ptr += TLV_HDR_SIZE;
> +	if (params->num_hint_bssid) {
> +		hint_bssid = ptr;
> +		for (i = 0; i < params->num_hint_bssid; ++i) {
> +			hint_bssid->freq_flags =
> +				params->hint_bssid[i].freq_flags;
> +			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
> +					&hint_bssid->bssid.addr[0]);
> +			hint_bssid++;
> +		}
> +	}
> +
It handle num_hint_bssid/ num_hint_s_ssid twice, and lead skb overflow 
and lead crash
Removed one then not crash by my test.

[  333.887631] ath11k_pci 0000:05:00.0: ath11k_wmi_send_scan_start_cmd 2 
skb null 0 
,pK:ffff921f6fd85400,llx:ffff921f6fd85400,px:ffff921f6fd85400,p:000000008d8d8abe
[  333.887633] ath11k_pci 0000:05:00.0: ath11k_wmi_send_scan_start_cmd 2 
skb len:372,end:448,tail:448,head:ffff921f6d7a3140,data:ffff921f6d7a318c
[  333.887635] ath11k_pci 0000:05:00.0: ath11k_wmi_send_scan_start_cmd 2 
shinfo nr_frags 19 null 0,pk:ffff921f6d7a3300,llx:ffff921f6d7a3300
[  333.887638] ath11k_pci 0000:05:00.0: ath11k_wmi_cmd_send_nowait 1 skb 
null 0 
,pK:ffff921f6fd85400,llx:ffff921f6fd85400,px:ffff921f6fd85400,p:000000008d8d8abe
[  333.887640] ath11k_pci 0000:05:00.0: ath11k_wmi_cmd_send_nowait 1 skb 
len:376,end:448,tail:448,head:ffff921f6d7a3140,data:ffff921f6d7a3188
[  333.887642] ath11k_pci 0000:05:00.0: ath11k_wmi_cmd_send_nowait 
shinfo nr_frags 19 null 0,pk:ffff921f6d7a3300,llx:ffff921f6d7a3300
[  333.887644] ath11k_pci 0000:05:00.0: htc ep 2 consumed 1 credits 
(total 1)
[  333.887649] ath11k_pci 0000:05:00.0: ath11k_ce_send 1 write_index 6, 
skb null 0 
,pK:ffff921f6fd85400,llx:ffff921f6fd85400,px:ffff921f6fd85400,p:000000008d8d8abe
[  333.887650] ath11k_pci 0000:05:00.0: ath11k_ce_send 1 skb 
len:384,end:448,tail:448,head:ffff921f6d7a3140,data:ffff921f6d7a3180
[  333.887652] ath11k_pci 0000:05:00.0: ath11k_ce_send shinfo nr_frags 
19 null 0,pk:ffff921f6d7a3300,llx:ffff921f6d7a3300
[  333.887654] ath11k_pci 0000:05:00.0: wmi cmd send 0x3001 ret 0
[  333.887729] general protection fault, probably for non-canonical 
address 0x2e676e69746e756f: 0000 [#1] SMP PTI
[  333.887734] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G    
     W  OE     5.8.0-rc1+ #3
[  333.887735] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW 
(1.33 ) 07/29/2011
[  333.887741] RIP: 0010:skb_release_data+0x66/0x170
[  333.887744] Code: 41 0f c1 44 24 20 39 c2 0f 85 ff 00 00 00 31 db 41 
80 7c 24 02 00 48 89 fd 74 39 48 63 c3 48 83 c0 03 48 c1 e0 04 49 8b 3c 
04 <48> 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa 66 66 66 66 90 f0 ff 4f
[  333.887746] RSP: 0018:ffffb3204010ce48 EFLAGS: 00010206
[  333.887748] RAX: 0000000000000030 RBX: 0000000000000000 RCX: 
000000000000466e
[  333.887749] RDX: 0000000000000011 RSI: 0000000000000001 RDI: 
2e676e69746e756f
[  333.887751] RBP: ffff921f6fd85400 R08: ffff921f7e5dc9b8 R09: 
ffff921f7e5cb000
[  333.887752] R10: 000000000000000c R11: 0000000000001142 R12: 
ffff921f6d7a3300
[  333.887754] R13: 0000000000000013 R14: ffff921f68d41658 R15: 
ffff921f68d42e68
[  333.887756] FS:  0000000000000000(0000) GS:ffff921f7a240000(0000) 
knlGS:0000000000000000
[  333.887757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  333.887759] CR2: 00007f73be694b58 CR3: 000000008f40a004 CR4: 
00000000000606e0
[  333.887760] Call Trace:
[  333.887763]  <IRQ>
[  333.887766]  consume_skb+0x27/0xb0
[  333.887780]  ath11k_ce_send_done_cb+0x2a2/0x2c0 [ath11k]
[  333.887789]  ath11k_ce_per_engine_service+0x50/0x3b0 [ath11k]
[  333.887796]  ? ath11k_info+0x56/0x60 [ath11k]
[  333.887799]  ? __irq_put_desc_unlock+0x18/0x50
[  333.887802]  ath11k_pci_ce_tasklet+0x2f/0x50 [ath11k_pci]
[  333.887806]  tasklet_action_common.isra.21+0xee/0x110
[  333.887809]  __do_softirq+0xfd/0x2bb
[  333.887814]  asm_call_on_stack+0x12/0x20
[  333.887815]  </IRQ>
[  333.887819]  do_softirq_own_stack+0x39/0x50
[  333.887821]  irq_exit_rcu+0x9e/0xa0
[  333.887825]  common_interrupt+0xa4/0x140
[  333.887828]  asm_common_interrupt+0x1e/0x40
[  333.887832] RIP: 0010:cpuidle_enter_state+0xc6/0x420
[  333.887834] Code: 90 31 ff e8 0c 6a 8c ff 80 7c 24 0f 00 74 17 9c 58 
66 66 90 66 90 f6 c4 02 0f 85 24 03 00 00 31 ff e8 5e 87 92 ff fb 66 66 
90 <66> 66 90 45 85 e4 0f 88 c3 02 00 00 49 63 d4 4c 2b 7c 24 10 48 8d
[  333.887836] RSP: 0018:ffffb320400a7e78 EFLAGS: 00000246
[  333.887838] RAX: ffff921f7a26bfc0 RBX: ffff921f7a275900 RCX: 
000000000000001f
[  333.887840] RDX: 0000000000000000 RSI: 00000000316404ec RDI: 
0000000000000000
[  333.887842] RBP: ffffffff9a4e9c60 R08: fffffff8ac800705 R09: 
0000000000000433
[  333.887843] R10: ffff921f7a26af04 R11: 0000000000000018 R12: 
0000000000000005
[  333.887844] R13: 0000000000000005 R14: ffffffff9a4e9c60 R15: 
0000004dbd4170fb
[  333.887848]  ? cpuidle_enter_state+0xa4/0x420
[  333.887850]  cpuidle_enter+0x29/0x40
[  333.887852]  do_idle+0x1d8/0x260
[  333.887854]  cpu_startup_entry+0x19/0x20
[  333.887857]  start_secondary+0x141/0x170
[  333.887860]  secondary_startup_64+0xb6/0xc0
[  333.887862] Modules linked in: ath11k_pci(OE) ath11k(OE) qmi_helpers 
qrtr_mhi mhi qrtr ns rfcomm ccm bnep nouveau intel_rapl_msr 
intel_rapl_common snd_hda_codec_conexant snd_hda_codec_generic 
x86_pkg_temp_thermal intel_powerclamp i915 coretemp kvm_intel kvm iwldvm 
uvcvideo wmi_bmof irqbypass snd_hda_codec_hdmi mac80211 mxm_wmi 
videobuf2_vmalloc ttm videobuf2_memops videobuf2_v4l2 input_leds joydev 
drm_kms_helper videobuf2_common videodev snd_hda_intel crct10dif_pclmul 
serio_raw snd_intel_dspcfg crc32_pclmul mc thinkpad_acpi 
ghash_clmulni_intel snd_hda_codec aesni_intel snd_hda_core snd_hwdep 
crypto_simd snd_pcm snd_seq_midi snd_seq_midi_event snd_rawmidi cryptd 
snd_seq libarc4 snd_seq_device glue_helper nvram snd_timer drm 
ledtrig_audio btusb iwlwifi lpc_ich btrtl btbcm btintel snd bluetooth 
i2c_algo_bit fb_sys_fops syscopyarea sysfillrect cfg80211 sysimgblt 
ecdh_generic ecc mei_me mei soundcore wmi video mac_hid parport_pc ppdev 
lp parport autofs4 ahci sdhci_pci firewire_ohci e1000e cqhci
[  333.887898]  psmouse ptp firewire_core libahci sdhci crc_itu_t 
pps_core

...
