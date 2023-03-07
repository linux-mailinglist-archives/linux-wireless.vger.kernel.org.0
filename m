Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B686AFA08
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 00:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCGXDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Mar 2023 18:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCGXD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Mar 2023 18:03:28 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876364C35
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 15:02:54 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BA42318002C;
        Tue,  7 Mar 2023 23:02:52 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 02E2413C2B0;
        Tue,  7 Mar 2023 15:02:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 02E2413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1678230172;
        bh=/co1+Bp9c/8uHncz+p4IRmSJoueJmHf+eaaL3Z9kkQ0=;
        h=Date:To:From:Subject:From;
        b=B4cq3lV1/pBQkuNhb8s4dZ8bvwma/5jkaGLF/lzoPrb2kVtURKZh+5dTX3ILZDeil
         kz3ZzOVJNSEbzV8i5QoS9imjSb/47ctVYUGq7BX0lGW85LoPGV/01vRrvq6GEmkH4L
         CuJAd6rV4QtW20ysFj31jxEUsDFZKaLgCz5cTKNY=
Message-ID: <6da06ec1-193a-ff3b-16c3-fa5fa2e6569a@candelatech.com>
Date:   Tue, 7 Mar 2023 15:02:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org, sean.wang@mediatek.com
From:   Ben Greear <greearb@candelatech.com>
Subject: mt7922 crash in mt7921_check_offload_capability in 6.2.2+ kernel.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1678230173-WFyGA9YG_lCQ
X-MDID-O: us5;at1;1678230173;WFyGA9YG_lCQ;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I am trying to use a bunch of the 7922 radios in one of my systems.  I am seeing
the kernel crash about half of the time when booting, in the location below.

Maybe release_firmware invalidates the 'features' memory?

Firmware info:

[   17.800452] mt7921e 0000:06:00.0: ASIC revision: 79220010
[   17.800886] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build Time: 20221227123154a
[   17.816567] mt7921e 0000:05:00.0: WM Firmware Version: ____000000, Build Time: 20221227123243
[   17.905902] mt7921e 0000:06:00.0: HW/SW Version: 0x8a108a10, Build Time: 20221227123154a


Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
1;39mMonitoring RIP: 0010:mt7921_check_offload_capability+0x17d/0x1d0 [mt7921_common]
of LVM2�… dmevemt7921e 0000:06:00.0: WM Firmware Version: ____000000, Build Time: 20221227123243
ntd or progress Code: 5f 48 8d 7b 03 48 8d 6b 04 e8 6f 80 2a e0 80 7b 03 04 75 c1 4c 89 f7 e8 81 6f a6 e0 48 85 ed 74 47 48 8d 7b 05 e8 50
polling. Mounting FUSE Control File System...
RSP: 0018:ffff88812a5c7630 EFLAGS: 00010246s in /dev...
RAX: 0000000000000000 RBX: ffffc90001cb0a64 RCX: ffffffffa1283cfd
RDX: 1ffff9200039614d RSI: ffff88810fa80200 RDI: ffffc90001cb0a69
RBP: ffffc90001cb0a68 R08: 0000000000000016 R09: ffffffff84053363
R10: ffff88841c460158 R11: 0000000053ee80c4 R12: ffffc90001cb0a78
R13: 1ffff110254b8ec6 R14: ffff88810fa80200 R15: 000000000000005b
FS:  00007f78120ed940(0000) GS:ffff88841e080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001cb0a69 CR3: 000000013d21d004 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:arting udev Kernel Device Manager...
  <TASK>] Started udev Kernel Device Manager.
  ? mt7921_set_tx_sar_pwr+0x80/0x80 [mt7921_common]ge.
  ? pci_address_to_pio+0x20/0x20all Devices.
  ? pcim_iomap_regions+0xcb/0x1a0Complete Device Initialization...
  mt7921_pci_probe+0xca/0x4b0 [mt7921e]tch Status /dev/rfkill Watch.
  ? mt7921_l1_rr+0x90/0x90 [mt7921e]x2dpvscan.slice.
  local_pci_probe+0x6f/0xb0scan on device 8:19...
  pci_device_probe+0x166/0x3a0n on device 8:3...
  ? kernfs_add_one+0x19a/0x1f0r event daemon.
  ? pci_device_remove+0xf0/0xf0lt for address: ffffc90001cb0a69
  ? kernfs_create_link+0xb2/0x100ernel mode
  ? kernfs_put+0x13/0x30 - not-present page
  ? sysfs_do_create_link_sd+0x73/0xd025067 PMD 14fb85067 PTE 0
  really_probe+0x130/0x510MP KASAN
  __driver_probe_device+0xc5/0x210emd-udevd Not tainted 6.2.2+ #28
  driver_probe_device+0x45/0xe0
  __driver_attach+0x11e/0x270
  ? __device_attach_driver+0x140/0x140
  bus_for_each_dev+0xdf/0x130
  ? subsys_dev_iter_exit+0x10/0x10
  bus_add_driver+0x290/0x2e0
  driver_register+0x108/0x190
  ? 0xffffffffa1018000
  do_one_initcall+0x82/0x2a0
  ? trace_event_raw_event_initcall_level+0x150/0x150
  ? kasan_unpoison+0x23/0x50
  ? __kasan_slab_alloc+0x2f/0x70
  ? __kmem_cache_alloc_node+0xe6/0x1e0
  ? do_init_module+0x33/0x2d0
  ? kasan_unpoison+0x23/0x50
  do_init_module+0xda/0x2d0
  load_module+0x31fb/0x3390
  ? module_frob_arch_sections+0x20/0x20
  ? __fget_light+0x1a7/0x1f0
  ? __do_sys_finit_module+0x10d/0x1a0
  __do_sys_finit_module+0x10d/0x1a0
  ? __ia32_sys_init_module+0x40/0x40
  ? fget+0xfb/0x120
  ? fput+0x13/0xb0
  ? ksys_mmap_pgoff+0xef/0x280
  do_syscall_64+0x34/0xb0
  entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f7812954ddd
Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 8
RSP: 002b:00007ffd66d60b48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055beff992a90 RCX: 00007f7812954ddd
RDX: 0000000000000000 RSI: 00007f781285784d RDI: 0000000000000014
RBP: 0000000000020000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000014 R11: 0000000000000246 R12: 00007f781285784d
R13: 0000000000000000 R14: 000055beff98a770 R15: 000055beff992a90
  </TASK>
Modules linked in: snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio snd_hda_intel snd_intel_dspcfg snd_hda_coe
CR2: ffffc90001cb0a69
---[ end trace 0000000000000000 ]---
RIP: 0010:mt7921_check_offload_capability+0x17d/0x1d0 [mt7921_common]
Code: 5f 48 8d 7b 03 48 8d 6b 04 e8 6f 80 2a e0 80 7b 03 04 75 c1 4c 89 f7 e8 81 6f a6 e0 48 85 ed 74 47 48 8d 7b 05 e8 53 80 2a e0 <0f> 0
RSP: 0018:ffff88812a5c7630 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc90001cb0a64 RCX: ffffffffa1283cfd
RDX: 1ffff9200039614d RSI: ffff88810fa80200 RDI: ffffc90001cb0a69
RBP: ffffc90001cb0a68 R08: 0000000000000016 R09: ffffffff84053363
R10: ffff88841c460158 R11: 0000000053ee80c4 R12: ffffc90001cb0a78
R13: 1ffff110254b8ec6 R14: ffff88810fa80200 R15: 000000000000005b
FS:  00007f78120ed940(0000) GS:ffff88841e080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc90001cb0a69 CR3: 000000013d21d004 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400



u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
{
	struct mt7921_fw_features *features = NULL;
	const struct mt76_connac2_fw_trailer *hdr;
	struct mt7921_realease_info *rel_info;
	const struct firmware *fw;
	int ret, i, offset = 0;
	const u8 *data, *end;

	ret = request_firmware(&fw, fw_wm, dev);
	if (ret)
		return ret;

	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
		dev_err(dev, "Invalid firmware\n");
		return -EINVAL;
	}

	data = fw->data;
	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));

	for (i = 0; i < hdr->n_region; i++) {
		const struct mt76_connac2_fw_region *region;

		region = (const void *)((const u8 *)hdr -
					(hdr->n_region - i) * sizeof(*region));
		offset += le32_to_cpu(region->len);
	}

	data += offset + 16;
	rel_info = (struct mt7921_realease_info *)data;
	data += sizeof(*rel_info);
	end = data + le16_to_cpu(rel_info->len);

	while (data < end) {
		rel_info = (struct mt7921_realease_info *)data;
		data += sizeof(*rel_info);

		if (rel_info->tag == MT7921_FW_TAG_FEATURE) {
			features = (struct mt7921_fw_features *)data;
			break;
		}

		data += le16_to_cpu(rel_info->len) + rel_info->pad_len;
	}

	release_firmware(fw);

	return features ? features->data : 0;

#### Crashing on line above, evidently. --Ben

}
EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

