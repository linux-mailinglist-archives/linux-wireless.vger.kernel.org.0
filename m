Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B54262A83
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgIIIis (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 04:38:48 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:47448
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgIIIip (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 04:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599640725;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=ZJN7Gn0C64KReZ80V9CMdw/44QfuEcVHRZoW4KgBD6c=;
        b=Toyu5HT3rCMRrDTMgbwcZD6Hfn4m1vCi3vTdQLpyXaX4aLhW70XzdAldA03sORLw
        LJsDMLQsK0obDL7g2a+KfOb4ZrY3A1UL4hvwlBMUNevEZGJ6x0veFE6rJ9MrlBx/g+h
        gzPVvKPUsx4A42k+H2ZVNeGHVnKGJg04Gi8a/ucw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599640725;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=ZJN7Gn0C64KReZ80V9CMdw/44QfuEcVHRZoW4KgBD6c=;
        b=ai9w4kCRR5YoK3N69lcv4PiFLmJg+rZEUXI8CL6uVVv6EZQtE9wmPs+Ssw+RMDCn
        q16NzN2IklCxbo2CAo1PuAG8/eTRdK4ozdLKhBfqvbXWIxvfoz6BGcqXipbglndMjyA
        fkGXs0Rw1tCj0iqT6fsWdyfc847QmR2uNjSzH3bo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC835C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v5 8/8] ath11k: Add support for 6g scan hint
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
        <20200603001724.12161-9-pradeepc@codeaurora.org>
        <a9525954a6bd3055350cf4c3f29bab55@codeaurora.org>
Date:   Wed, 9 Sep 2020 08:38:44 +0000
In-Reply-To: <a9525954a6bd3055350cf4c3f29bab55@codeaurora.org> (Wen Gong's
        message of "Mon, 24 Aug 2020 11:29:42 +0800")
Message-ID: <01010174720465b2-fea2e548-95b2-488a-ae51-8f2a501f838e-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.09-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-06-03 08:17, Pradeep Kumar Chitrapu wrote:
> ...
>> @@ -2126,6 +2136,68 @@ int ath11k_wmi_send_scan_start_cmd(struct
>> ath11k *ar,
>>
>>  	ptr += extraie_len_with_pad;
>>
>> +	if (params->num_hint_s_ssid) {
>> +		len = params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
>> +		tlv = ptr;
>> +		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
>> +			      FIELD_PREP(WMI_TLV_LEN, len);
>> +		ptr += TLV_HDR_SIZE;
>> +		s_ssid = ptr;
>> +		for (i = 0; i < params->num_hint_s_ssid; ++i) {
>> +			s_ssid->freq_flags = params->hint_s_ssid[i].freq_flags;
>> +			s_ssid->short_ssid = params->hint_s_ssid[i].short_ssid;
>> +			s_ssid++;
>> +		}
>> +		ptr += len;
>> +	}
>> +
>> +	if (params->num_hint_bssid) {
>> +		len = params->num_hint_bssid * sizeof(struct hint_bssid);
>> +		tlv = ptr;
>> +		tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
>> +			      FIELD_PREP(WMI_TLV_LEN, len);
>> +		ptr += TLV_HDR_SIZE;
>> +		hint_bssid = ptr;
>> +		for (i = 0; i < params->num_hint_bssid; ++i) {
>> +			hint_bssid->freq_flags =
>> +				params->hint_bssid[i].freq_flags;
>> +			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
>> +					&hint_bssid->bssid.addr[0]);
>> +			hint_bssid++;
>> +		}
>> +	}
>> +
>> +	len = params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
>> +	tlv = ptr;
>> +	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
>> +		      FIELD_PREP(WMI_TLV_LEN, len);
>> +	ptr += TLV_HDR_SIZE;
>> +	if (params->num_hint_s_ssid) {
>> +		s_ssid = ptr;
>> +		for (i = 0; i < params->num_hint_s_ssid; ++i) {
>> +			s_ssid->freq_flags = params->hint_s_ssid[i].freq_flags;
>> +			s_ssid->short_ssid = params->hint_s_ssid[i].short_ssid;
>> +			s_ssid++;
>> +		}
>> +	}
>> +	ptr += len;
>> +
>> +	len = params->num_hint_bssid * sizeof(struct hint_bssid);
>> +	tlv = ptr;
>> +	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
>> +		      FIELD_PREP(WMI_TLV_LEN, len);
>> +	ptr += TLV_HDR_SIZE;
>> +	if (params->num_hint_bssid) {
>> +		hint_bssid = ptr;
>> +		for (i = 0; i < params->num_hint_bssid; ++i) {
>> +			hint_bssid->freq_flags =
>> +				params->hint_bssid[i].freq_flags;
>> +			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
>> +					&hint_bssid->bssid.addr[0]);
>> +			hint_bssid++;
>> +		}
>> +	}
>> +
> It handle num_hint_bssid/ num_hint_s_ssid twice, and lead skb overflow
> and lead crash
> Removed one then not crash by my test.
>
> [  333.887631] ath11k_pci 0000:05:00.0: ath11k_wmi_send_scan_start_cmd
> 2 skb null 0
> ,pK:ffff921f6fd85400,llx:ffff921f6fd85400,px:ffff921f6fd85400,p:000000008d8d8abe
> [  333.887633] ath11k_pci 0000:05:00.0: ath11k_wmi_send_scan_start_cmd
> 2 skb
> len:372,end:448,tail:448,head:ffff921f6d7a3140,data:ffff921f6d7a318c
> [  333.887635] ath11k_pci 0000:05:00.0: ath11k_wmi_send_scan_start_cmd
> 2 shinfo nr_frags 19 null 0,pk:ffff921f6d7a3300,llx:ffff921f6d7a3300
> [  333.887638] ath11k_pci 0000:05:00.0: ath11k_wmi_cmd_send_nowait 1
> skb null 0
> ,pK:ffff921f6fd85400,llx:ffff921f6fd85400,px:ffff921f6fd85400,p:000000008d8d8abe
> [  333.887640] ath11k_pci 0000:05:00.0: ath11k_wmi_cmd_send_nowait 1
> skb
> len:376,end:448,tail:448,head:ffff921f6d7a3140,data:ffff921f6d7a3188
> [  333.887642] ath11k_pci 0000:05:00.0: ath11k_wmi_cmd_send_nowait
> shinfo nr_frags 19 null 0,pk:ffff921f6d7a3300,llx:ffff921f6d7a3300
> [  333.887644] ath11k_pci 0000:05:00.0: htc ep 2 consumed 1 credits
> (total 1)
> [  333.887649] ath11k_pci 0000:05:00.0: ath11k_ce_send 1 write_index
> 6, skb null 0
> ,pK:ffff921f6fd85400,llx:ffff921f6fd85400,px:ffff921f6fd85400,p:000000008d8d8abe
> [  333.887650] ath11k_pci 0000:05:00.0: ath11k_ce_send 1 skb
> len:384,end:448,tail:448,head:ffff921f6d7a3140,data:ffff921f6d7a3180
> [  333.887652] ath11k_pci 0000:05:00.0: ath11k_ce_send shinfo nr_frags
> 19 null 0,pk:ffff921f6d7a3300,llx:ffff921f6d7a3300
> [  333.887654] ath11k_pci 0000:05:00.0: wmi cmd send 0x3001 ret 0
> [  333.887729] general protection fault, probably for non-canonical
> address 0x2e676e69746e756f: 0000 [#1] SMP PTI
> [  333.887734] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G
> W  OE     5.8.0-rc1+ #3
> [  333.887735] Hardware name: LENOVO 418065C/418065C, BIOS 83ET63WW
> (1.33 ) 07/29/2011
> [  333.887741] RIP: 0010:skb_release_data+0x66/0x170
> [  333.887744] Code: 41 0f c1 44 24 20 39 c2 0f 85 ff 00 00 00 31 db
> 41 80 7c 24 02 00 48 89 fd 74 39 48 63 c3 48 83 c0 03 48 c1 e0 04 49
> 8b 3c 04 <48> 8b 47 08 48 8d 50 ff a8 01 48 0f 45 fa 66 66 66 66 90 f0
> ff 4f
> [  333.887746] RSP: 0018:ffffb3204010ce48 EFLAGS: 00010206
> [  333.887748] RAX: 0000000000000030 RBX: 0000000000000000 RCX:
> 000000000000466e
> [  333.887749] RDX: 0000000000000011 RSI: 0000000000000001 RDI:
> 2e676e69746e756f
> [  333.887751] RBP: ffff921f6fd85400 R08: ffff921f7e5dc9b8 R09:
> ffff921f7e5cb000
> [  333.887752] R10: 000000000000000c R11: 0000000000001142 R12:
> ffff921f6d7a3300
> [  333.887754] R13: 0000000000000013 R14: ffff921f68d41658 R15:
> ffff921f68d42e68
> [  333.887756] FS:  0000000000000000(0000) GS:ffff921f7a240000(0000)
> knlGS:0000000000000000
> [  333.887757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  333.887759] CR2: 00007f73be694b58 CR3: 000000008f40a004 CR4:
> 00000000000606e0
> [  333.887760] Call Trace:
> [  333.887763]  <IRQ>
> [  333.887766]  consume_skb+0x27/0xb0
> [  333.887780]  ath11k_ce_send_done_cb+0x2a2/0x2c0 [ath11k]
> [  333.887789]  ath11k_ce_per_engine_service+0x50/0x3b0 [ath11k]
> [  333.887796]  ? ath11k_info+0x56/0x60 [ath11k]
> [  333.887799]  ? __irq_put_desc_unlock+0x18/0x50
> [  333.887802]  ath11k_pci_ce_tasklet+0x2f/0x50 [ath11k_pci]
> [  333.887806]  tasklet_action_common.isra.21+0xee/0x110
> [  333.887809]  __do_softirq+0xfd/0x2bb
> [  333.887814]  asm_call_on_stack+0x12/0x20
> [  333.887815]  </IRQ>
> [  333.887819]  do_softirq_own_stack+0x39/0x50
> [  333.887821]  irq_exit_rcu+0x9e/0xa0
> [  333.887825]  common_interrupt+0xa4/0x140
> [  333.887828]  asm_common_interrupt+0x1e/0x40
> [  333.887832] RIP: 0010:cpuidle_enter_state+0xc6/0x420

Pradeep, do you have a fix for this crash?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
