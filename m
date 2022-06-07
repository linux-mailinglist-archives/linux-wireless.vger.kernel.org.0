Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF71F541B1C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 23:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351430AbiFGVmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 17:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380981AbiFGViy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 17:38:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0076389F
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 12:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78DA6B82182
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 19:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E598AC34115;
        Tue,  7 Jun 2022 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654628736;
        bh=7akDYZYViwC+x2RZETc4ewLC4IDnj735CZZxBHiA8KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thyZsBlwqtmWuwRmn+Fg8tNxbN5MU+vLlUWD/7rIF18wscxYZcgFdyX+9KBDblCCO
         F4Vsk5Sfc39zycGgrGLXBkRtVj8quGqWikTWTuYOfKxOOVTAQwOhecfjYYtkyk/csd
         sAJ1oE2iVZQ/ErOwFliD68mNsp7n6S6Ikm7YDu/5FhiDK1pPsHvHTguu9WLey5nFYb
         CTkB82mYjNccAzvgXc0VxbWWfPserfoiTB7H0rH1GhG4+5M50OE1QHl8cAd9kCiAuf
         gMsAnCFrgL1xxAX9X1ggA9yNydscAglAF0MSUnQ2qxcwLGz237hspPsK5654TYaCxJ
         FN1Si0KRepEng==
Date:   Tue, 7 Jun 2022 12:05:34 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH v3 4/4] rtw88: Fix Sparse warning for rtw8821c_hw_spec
Message-ID: <Yp+hfo5Uual8ZUkR@dev-arch.thelio-3990X>
References: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524153716.20450-1-Larry.Finger@lwfinger.net>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

On Tue, May 24, 2022 at 10:37:16AM -0500, Larry Finger wrote:
> Sparse lists the following:
> 
>   CHECK   drivers/net/wireless/realtek/rtw88/rtw8821c.c
> drivers/net/wireless/realtek/rtw88/rtw8821c.c:1880:22: warning: symbol 'rtw8821c_hw_spec' was not declared. Should it be static?
> 
> The warning arises because the external declaration for rtw8821c_hw_spec
> occurs in rtw8821ce.h, which is not included in rtw8821c.h. That line is
> moved, and the now empty file rtw8821ce.h is deleted.
> 
> Symbol 'rtw8821c_hw_spec' can be made constant.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

I bisected this change as commit 89d8f53ff6e7 ("wifi: rtw88: Fix Sparse
warning for rtw8821c_hw_spec") in linux-next as the cause of one of my
test machines failing to boot with the following stacktrace:

BUG: unable to handle page fault for address: ffffffffc09f52f4
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 5b5215067 P4D 5b5215067 PUD 5b5217067 PMD 111f61067 PTE 8000000111e07161
Oops: 0003 [#1] PREEMPT SMP NOPTI
CPU: 6 PID: 436 Comm: NetworkManager Not tainted 5.18.0-rc7-debug-01822-g89d8f53ff6e7 #1 5cac31ca93432e53341863abfb3332fd98b144da
Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
RIP: 0010:rtw8821c_phy_set_param+0x262/0x380 [rtw88_8821c]
Code: e8 53 f3 c0 d6 48 8b 43 10 4c 8b 63 38 be 24 0a 00 00 48 89 df 48 8b 40 68 e8 3a f3 c0 d6 89 e9 be 28 0a 00 00 48 89 df d3 e8 <41> 89 84 24 54 01 00 00 48 8b 43 10 4c 8b 63 38 48 8b 40 68 e8 15
RSP: 0018:ffffb08c417cb6f0 EFLAGS: 00010286
RAX: 0000000064b80c1c RBX: ffff93d15a0120e0 RCX: 0000000000000000
RDX: 0000000034028211 RSI: 0000000000000a28 RDI: ffff93d15a0120e0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000006 R12: ffffffffc09f51a0
R13: ffff93d15a0156d0 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f4e9b73d1c0(0000) GS:ffff93d83ab80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffc09f52f4 CR3: 0000000103b9e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 rtw_core_start+0xbd/0x190 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
 rtw_ops_start+0x26/0x40 [rtw88_core de79d6bdfd083d102030858972032e5706726279]
 drv_start+0x42/0x100 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
 ieee80211_do_open+0x2fb/0x900 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
 ieee80211_open+0x67/0x80 [mac80211 21e803d0ad10691f64c6c81ecc24c0c6c36e5d58]
 __dev_open+0xdd/0x180
 __dev_change_flags+0x1d7/0x250
 dev_change_flags+0x26/0x60
 do_setlink+0x357/0x12a0
 ? __nla_validate_parse+0x5f/0xbc0
 __rtnl_newlink+0x61a/0x9b0
 ? proto_unregister+0xa1/0xf0
 ? __netlink_sendskb+0x68/0x90
 rtnl_newlink+0x47/0x70
 rtnetlink_rcv_msg+0x152/0x3b0
 ? __mark_inode_dirty+0x28a/0x380
 ? __inode_attach_wb+0x25/0x1c0
 ? rtnl_calcit.isra.0+0x140/0x140
 netlink_rcv_skb+0x55/0x100
 netlink_unicast+0x243/0x390
 netlink_sendmsg+0x254/0x4b0
 sock_sendmsg+0x60/0x70
 ____sys_sendmsg+0x264/0x2a0
 ? import_iovec+0x1b/0x20
 ___sys_sendmsg+0x96/0xd0
 __sys_sendmsg+0x7a/0xd0
 do_syscall_64+0x5f/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4e9c31374d
Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 8a 52 f7 ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 de 52 f7 ff 48
RSP: 002b:00007ffc0645e060 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000010 RCX: 00007f4e9c31374d
RDX: 0000000000000000 RSI: 00007ffc0645e0a0 RDI: 000000000000000c
RBP: 000055d9ec3aa040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffc0645e200 R14: 00007ffc0645e1fc R15: 0000000000000000
 </TASK>
Modules linked in: mousedev joydev vfat fat hp_wmi intel_rapl_msr intel_rapl_common sparse_keymap hid_razer platform_profile wmi_bmof kvm_amd rtw88_8821ce amdgpu(+) kvm snd_hda_codec_hdmi rtw88_8821c rtw88_pci snd_hda_codec_realtek snd_hda_codec_generic irqbypass ledt>
 ext4 crc32c_generic crc16 mbcache jbd2 nvme crc32c_intel nvme_core xhci_pci xhci_pci_renesas
CR2: ffffffffc09f52f4
---[ end trace 0000000000000000 ]---

The 'const' part of the change appears to be the problem, as the
'->ch_param' member in rtw8821c_hw_spec is modified in
rtw8821c_phy_set_param(), as rtw8821c_hw_spec is assigned to the
'->chip' member of rtw_pci_probe() via the '->driver_data' member. If I
back out of the 'const' change, everything works but I am not sure if
that is a proper solution or not, hence just the report. That diff and
the bisect log are below.

Cheers,
Nathan



diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 42841f5d502c..ffee39ea5df6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1877,7 +1877,7 @@ static const struct rtw_reg_domain coex_info_hw_regs_8821c[] = {
 	{0x60A, MASKBYTE0, RTW_REG_DOMAIN_MAC8},
 };
 
-const struct rtw_chip_info rtw8821c_hw_spec = {
+struct rtw_chip_info rtw8821c_hw_spec = {
 	.ops = &rtw8821c_ops,
 	.id = RTW_CHIP_TYPE_8821C,
 	.fw_name = "rtw88/rtw8821c_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 2698801fc35d..4f76937da4ef 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -84,7 +84,7 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 	rtw_write32_mask(rtwdev, addr + 0x200, mask, data);
 }
 
-extern const struct rtw_chip_info rtw8821c_hw_spec;
+extern struct rtw_chip_info rtw8821c_hw_spec;
 
 #define rtw_write32s_mask(rtwdev, addr, mask, data)			       \
 	do {								       \



# bad: [73d0e32571a0786151eb72634f1a4c5891166176] Add linux-next specific files for 20220607
# good: [f2906aa863381afb0015a9eb7fefad885d4e5a56] Linux 5.19-rc1
git bisect start '73d0e32571a0786151eb72634f1a4c5891166176' 'f2906aa863381afb0015a9eb7fefad885d4e5a56'
# bad: [7cf73307e0374ea2e2d67afd2efb07f25cad2071] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect bad 7cf73307e0374ea2e2d67afd2efb07f25cad2071
# good: [265f79500ad68324566c2b67e4ff861236a83c69] Merge branch 'fscache-next' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
git bisect good 265f79500ad68324566c2b67e4ff861236a83c69
# good: [770bbdd44528c06362b2b55535a36a0aa7833805] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect good 770bbdd44528c06362b2b55535a36a0aa7833805
# good: [947321a7f4c06411a92a33d14acbcab06b5cabf3] Merge branch 'hwmon-next' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
git bisect good 947321a7f4c06411a92a33d14acbcab06b5cabf3
# good: [2a5666e1827ad3ba8443acf36df7283f1beabd21] Merge branch 'thermal/linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
git bisect good 2a5666e1827ad3ba8443acf36df7283f1beabd21
# bad: [3c76ec880588c5291506e58239f1efaa860969f1] wifi: wilc1000: remove WEP security support
git bisect bad 3c76ec880588c5291506e58239f1efaa860969f1
# good: [32621eb61bfd003ffb586028d84bb6a2e84e3dac] rtw88: fix null vif pointer when hw_scan fails
git bisect good 32621eb61bfd003ffb586028d84bb6a2e84e3dac
# good: [e36db29cfdffde868a52f8e7607dd0935d69f352] wifi: rtw88: Fix Sparse warning for rtw8723d_hw_spec
git bisect good e36db29cfdffde868a52f8e7607dd0935d69f352
# bad: [b88d28146c30a8e14f0f012d56ebf19b68a348f4] wifi: rtlwifi: fix error codes in rtl_debugfs_set_write_h2c()
git bisect bad b88d28146c30a8e14f0f012d56ebf19b68a348f4
# bad: [89d8f53ff6e729907af77f09f48eca9854295c91] wifi: rtw88: Fix Sparse warning for rtw8821c_hw_spec
git bisect bad 89d8f53ff6e729907af77f09f48eca9854295c91
# first bad commit: [89d8f53ff6e729907af77f09f48eca9854295c91] wifi: rtw88: Fix Sparse warning for rtw8821c_hw_spec
