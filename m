Return-Path: <linux-wireless+bounces-34326-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJGxEr3Cz2lH0QYAu9opvQ
	(envelope-from <linux-wireless+bounces-34326-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:38:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAB394949
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DBD33014105
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D210B40DFBE;
	Fri,  3 Apr 2026 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/HesPv3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05113A9DAF
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223309; cv=none; b=ha/befU13igdVGBpuAjJFNTeo+GuBkqWf0WTCI/XHwRSRl0ZwcU92ADrEzJ1lrwQGlrdB+ksM3RwYL1RVYtLEJ7ksxjst9KZuA1XFWRQPBmNB6rCywN7yYF+TrGZw2sR3dizpN0QJOgWS0sEdLxnQ2QZO9tJQCTmLLcUg1fCJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223309; c=relaxed/simple;
	bh=V/h0f9d78XX6YPK62s4wDgSH/I/6asklxfUo1DFcVrg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=J9k5HNVT7b8JUjF1G+IkDRzaSYrC4/DCpRochDPGKIj5W2d3hNfWF3urvawmG5u/UT3/n+sePX7w+OW/9XVs6J1/6sKjA7kjJRUO938xLwvOvUEjb8npbl2ePKZJGeKsRfbGW72XXBqm46HCI56uTkcK9Q31+wM4fruEoXSUNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/HesPv3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48704db565eso20244145e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775223305; x=1775828105; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sdn1t+20ZcBDYTL0P+DZi/HsAzqkOYhV5LIu4Iw10U=;
        b=X/HesPv33NOK2GgNsBQoAodl3xlEIt0tC4PVE9tZ817DXQc6K6ZBW5kSou4+PUZV7l
         m/zD1sQSxbDF3xQTwtsyU+ZjE3BRCBHn501cOz6DQCwpq1PrYP+WTDZ0d6tq/Wz6Sjfn
         YCL4RH4HE7DCvrnGvdjqbD/DPz8DctszlNCCD6cNsutp4cl+x2RhYp4LH1+s6mM4TX3L
         ICU2JEDFgWY0XdUEtynnhkUttvNfeYVwUgtXYqD0JdAAHB8gUMaRkfswlu5ITauoO/J+
         l7EX8RRkoDw9ZINMkVJJU6/OlJXT0vL5L3PZS5WGTfO0ca8AazqWydFO8kN6t5y6CZjZ
         7Nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775223305; x=1775828105;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Sdn1t+20ZcBDYTL0P+DZi/HsAzqkOYhV5LIu4Iw10U=;
        b=j/BtCJ0UI3YoKpt5Zs2bNAGaK5DmicQTaJAil+reAOvGaAw9sIDPPk1Grb/bJOXECs
         yVqSxi52GNhJl5wbfcMluACKIBeH+HGP2JI/UQL7nGDZQbsL0DnLNBQqWsh1ElspwgfJ
         p/sSpJCLwgQlunOZm0d4hxYtt7PQpTDh5j9kAnSgcpaELxEmg1bpJpq4ATumRn72k+I7
         /ajx5xcZK8vclUuR76x4QST0M9VOX14n6atBao4Wsng0zf1TFeU6oblJB652srupFk5c
         rP/mcl9uNMeN0jqHjS6UeuhcItLvLNsYBevzRStpZ0aclB/NbfgbvTuuXMyfm9eFOc15
         E4QQ==
X-Gm-Message-State: AOJu0YzNfIJkMkhjFJwGgpJFDrC9do4akmJSj52YLQX6bFFsOwdkQQZG
	p10j8VgQ1K2QJVWAkgj5XiXb+Z8lM78YAHVs5epm3rAECkMAF4yLWFBHQXVPzg==
X-Gm-Gg: ATEYQzz8K+VBn19gKQ3LIhl7mt577CBW4TLL0F8aH/EDGVrAHDksVBhrhV/M/QV8SJb
	I2EkrU2gRZi65vRqksBEjU71hfsBsSpUy4NZktYv1Mlw8c+dtyBDCUa1hofY6kcEb5gjhgvLdxw
	gy1bue8IbrDFDFl28xxDgA5xjQByZaEz1x4kSWVqiWkFWG7XsvhtVSFPTbucH9rgnAt1O6tdsVY
	Pgmqyv7wLkaETBxxq9E5p+k9RgUdBVpYmU2AaKw3FJ9OQh2IEhOdf1WuEMD5U2X+d4/nqbzwFbK
	gLEun7zsslfnsY9EVCcJDi51u7f4FBt8uBovao4eJA1iS1HOAyF04V/LlXiZUWErWRGqT+wAxQi
	UuRnKcdh6LUKA7k+I3CgQBHj7f2K1c0fD8EVE9V3GcNg2o+MSDooqjb8Y1R60jvXSA52fWMOdv6
	muetSX11INiqX+dCmglyqTeC1EO1srLsGpUu4IwtRIK0+iOJtrzvj7xyT+YDevfUWXEawE0PShA
	V/hKolB+w==
X-Received: by 2002:a05:600c:c8f:b0:485:3cf3:1010 with SMTP id 5b1f17b1804b1-488996d23femr44916705e9.2.1775223305341;
        Fri, 03 Apr 2026 06:35:05 -0700 (PDT)
Received: from [192.168.85.4] (net-5-94-253-173.cust.vodafonedsl.it. [5.94.253.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f52easm17505801f8f.36.2026.04.03.06.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 06:35:04 -0700 (PDT)
Message-ID: <afefde93-1f6a-4b3b-976b-87105615f931@gmail.com>
Date: Fri, 3 Apr 2026 15:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
From: Matteo Croce <technoboy85@gmail.com>
Subject: mt7996e kernel panic
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34326-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BCEAB394949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I'm experiencing a crash with the mt7996e driver.

The system is OpenWrt running on a Banana Pi R4, so kernel is 6.12.74 + 
mt76 backport

This is the crash:


[518291.616307] mt7996e 0000:01:00.0: Message 001a0003 (seq 1) timeout
[518291.622615] ap-mld0: HW problem - can not stop rx aggregation for 
4a:11:96:52:7e:6d tid 0
[518291.686603] pcieport 0000:00:00.0: AER: Multiple Uncorrectable 
(Non-Fatal) error message received from 0000:00:00.0
[518291.686603] pcieport 0001:00:00.0: AER: Multiple Uncorrectable 
(Non-Fatal) error message received from 0001:00:00.0
[518291.686628] pcieport 0000:00:00.0: PCIe Bus Error: 
severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
[518291.697137] pcieport 0001:00:00.0: PCIe Bus Error: 
severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Requester ID)
[518291.707639] pcieport 0000:00:00.0:   device [14c3:7988] error 
status/mask=00004000/00400000
[518291.707645] pcieport 0000:00:00.0:    [14] CmpltTO                
(First)
[518291.719022] pcieport 0001:00:00.0:   device [14c3:7988] error 
status/mask=00004000/00400000
[518291.730390] pcieport 0000:00:00.0: AER: broadcast error_detected message
[518291.730395] mt7996e 0000:01:00.0: AER: can't recover (no 
error_detected callback)
[518291.738822] pcieport 0001:00:00.0:    [14] CmpltTO                
(First)
[518291.745754] pcieport 0000:00:00.0: AER: device recovery failed
[518291.754122] pcieport 0001:00:00.0: AER: broadcast error_detected message
[518291.786622] Unable to handle kernel paging request at virtual 
address 7ae91c2bcb8708b6
[518291.788007] mt7996e_hif 0001:01:00.0: AER: can't recover (no 
error_detected callback)
[518291.795992] Mem abort info:
[518291.803956] pcieport 0001:00:00.0: AER: device recovery failed
[518291.806766]   ESR = 0x0000000096000004
[518291.806769]   EC = 0x25: DABT (current EL), IL = 32 bits
[518291.821919]   SET = 0, FnV = 0
[518291.825052]   EA = 0, S1PTW = 0
[518291.828278]   FSC = 0x04: level 0 translation fault
[518291.833233] Data abort info:
[518291.836189]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[518291.841761]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[518291.846895]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[518291.852282] [7ae91c2bcb8708b6] address between user and kernel 
address ranges
[518291.859500] Internal error: Oops: 0000000096000004 [#1] SMP
[518291.865152] Modules linked in: pppoe ppp_async nft_fib_inet 
nf_flow_table_inet pppox ppp_generic nft_reject_ipv6 nft_reject_ipv4 
nft_reject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat 
nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6 
nft_fib_ipv4 nft_fib nft_ct nft_chain_nat nf_tables nf_nat nf_flow_table 
nf_conntrack mt7996e(O) mt76_connac_lib(O) mt76(O) mac80211(O) 
cfg80211(O) slhc sfp rtc_pcf8563 nfnetlink nf_reject_ipv6 nf_reject_ipv4 
nf_log_syslog nf_defrag_ipv6 nf_defrag_ipv4 mdio_i2c macvlan libcrc32c 
compat(O) at24 crypto_safexcel pwm_fan i2c_mux_pca954x i2c_mux 
sha512_arm64 sha1_ce sha1_generic seqiv md5 geniv des_generic libdes 
authencesn authenc leds_gpio xhci_plat_hcd xhci_pci xhci_mtk_hcd 
xhci_hcd gpio_button_hotplug(O) usbcore usb_common aquantia crc_itu_t
[518291.935834] CPU: 3 UID: 0 PID: 22229 Comm: kworker/u16:0 Tainted: 
G        W  O       6.12.74 #0
[518291.944702] Tainted: [W]=WARN, [O]=OOT_MODULE
[518291.949135] Hardware name: Banana Pi BPI-R4 (2x SFP+) (DT)
[518291.954696] Workqueue: mt76 mt7996_mac_reset_work [mt7996e]
[518291.960367] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[518291.967406] pc : __free_pages+0x14/0x88
[518291.971326] lr : mtk_wed_hwrro_free_buffer+0x5c/0xc0
[518291.976371] sp : ffffffc08cf83b80
[518291.979761] x29: ffffffc08cf83b80 x28: ffffff80c5ce4c30 x27: 
ffffff80c5ce4c18
[518291.986976] x26: 0000000000000001 x25: ffffff80c4e1c080 x24: 
ffffffc081d03000
[518291.994188] x23: ffffff80c266f000 x22: ffffff80c2670000 x21: 
0000000000000001
[518292.001401] x20: 7ae91c2bcb8708b6 x19: ffffff80c266f810 x18: 
ffffff80ff7ae100
[518292.008613] x17: ffffffc07eb8b000 x16: ffffffc080e00000 x15: 
0000000000000001
[518292.015825] x14: 0000000000000000 x13: ffffff80c0129cc0 x12: 
0000000000000006
[518292.023037] x11: 0000000000000000 x10: ffffff80c0129cc0 x9 : 
ffffff80ff7ae180
[518292.030249] x8 : 0000000000000000 x7 : ffffffc080d76400 x6 : 
7ae91c2bcb8708ea
[518292.037461] x5 : ffffffc080dafce8 x4 : 0000000000000020 x3 : 
000000000000003f
[518292.044673] x2 : 0000000000000040 x1 : 0000000000000000 x0 : 
7ae91c2bcb8708b6
[518292.051885] Call trace:
[518292.054408]  __free_pages+0x14/0x88
[518292.057974]  mtk_wed_hwrro_free_buffer+0x5c/0xc0
[518292.062668]  mtk_wed_reset_dma+0x78c/0xafc
[518292.066842]  mt7996_dma_reset+0x1b0/0x444 [mt7996e]
[518292.071807]  mt7996_mac_reset_work+0x324/0x1250 [mt7996e]
[518292.077287]  process_one_work+0x174/0x300
[518292.081376]  worker_thread+0x278/0x430
[518292.085202]  kthread+0xd8/0xdc
[518292.088335]  ret_from_fork+0x10/0x20
[518292.091992] Code: 9100d006 910003fd f90013f5 52800035 (f9400004)
[518292.098160] ---[ end trace 0000000000000000 ]---
[518292.110206] pstore: backend (ramoops) writing error (-28)
[518292.115685] Kernel panic - not syncing: Oops: Fatal exception
[518292.121506] SMP: stopping secondary CPUs
[518292.125508] Kernel Offset: disabled
[518292.129073] CPU features: 0x00,00000002,00000000,4200400b
[518292.134548] Memory Limit: none
[518292.144967] Rebooting in 3 seconds..


I resolved the line numbers and I've got:

    __free_pages (include/asm-generic/bitops/generic-non-atomic.h:128)
    mtk_wed_hwrro_free_buffer (drivers/net/ethernet/mediatek/mtk_wed.c:870)
    mtk_wed_reset_dma (drivers/net/ethernet/mediatek/mtk_wed.c:1887)
    mt7996_dma_reset (mt7996/dma.c:1009) [mt7996e]
    mt7996_mac_restart (mt7996/mac.c:2273) [mt7996e]
    process_one_work (kernel/workqueue.c:3235)
    process_scheduled_works (kernel/workqueue.c:3304)
    kthread (kernel/kthread.c:389)
    ret_from_fork (arch/arm64/kernel/entry.S:863)


It happens randomly between a few hours and a few days. I don't know the 
code so I let an AI analyze the crash, for what it's worth, this is its 
analysis:


The crash is a use-after-free / corrupted pointer during a MAC reset 
work handler. The sequence:

1. mt7996 MCU timeout (Message 001a0003 timeout) triggers a MAC reset 
via mt7996_mac_reset_work
2. The reset path calls mt7996_dma_reset(dev, true) → 
mtk_wed_device_dma_reset() → mtk_wed_reset_dma() → mtk_wed_rx_reset() → 
mtk_wed_hwrro_free_buffer()
3. At mtk_wed.c:870-879, the loop iterates over page_list[] entries and 
calls __free_page(page) on each
4. The page pointer is 0x7ae91c2bcb8708b6 (visible in x20/x0 registers) 
— this is a garbage/poisoned value, not a valid kernel pointer
5. __free_page() → __free_pages() tries to test page flags via 
generic_test_bit() and faults on the bad pointer

The root cause is that dev->hw_rro.pages[] contains corrupted entries. 
This is likely because the PCIe Completion Timeout (CmpltTO) errors on 
both PCIe ports
(0000:00:00.0 and 0001:00:00.0) corrupted DMA memory or the device state 
before the reset handler could clean up properly. The 0x7ae91c2bcb87... 
pattern in x20 and x6
(with 0x...08ea vs 0x...08b6 — differing by 0x34 = a struct offset) 
suggests the page_list memory itself was corrupted by stale DMA writes 
after the PCIe link went
down.


Regards,

-- 

Matteo Croce

per aspera ad upstream


