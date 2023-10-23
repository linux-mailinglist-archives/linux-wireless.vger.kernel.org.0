Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D07D3D8F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Oct 2023 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjJWR1s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Oct 2023 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjJWR1r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Oct 2023 13:27:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668C1E6
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 10:27:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA5DC433C8;
        Mon, 23 Oct 2023 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698082065;
        bh=Tv4ouv0dyZkXdrZ2Jtv8p8V35lNdTX3igXUFKwHpCd0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hb+SH/STzoGRxC4ssiuV1nqao3LBhhXv9PRJLq0J+0k3Pomeb+cErOoVXNN8Acng2
         lFUaf96tJDw3xCBHL8+yIp2qw6jvxpukYalvie2oxF3QKPP8wtAzSjqHUNzJmQKB7S
         /S/Wc7k+HwDWs10yyw8sgj8rm0CJbgoOZmTLDycpSuFa9iqSmSs++0+HQ9vluO64sr
         H3UxU13yjvvoQHvHlgyMyKBdXgaHPKMWZgdgUb9f0nD4UfEntkedi+QwQ/zJOQjew2
         hW3ZabeWmHYkZo5aKK1ZiHxn1CFDW1tkebnjcIS53TFNV4mSwA+OsalyEYCwpuFsLO
         XVPpS8IxY2IGA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [next,v2] wifi: mt76: mt7921: fix kernel panic by accessing
 invalid 6GHz channel info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <cf77a58a60d81c77a28388bc8d312b87ffb48434.1697603002.git.deren.wu@mediatek.com>
References: <cf77a58a60d81c77a28388bc8d312b87ffb48434.1697603002.git.deren.wu@mediatek.com>
To:     Deren Wu <deren.wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808205862.695306.10760960481097586396.kvalo@kernel.org>
Date:   Mon, 23 Oct 2023 17:27:40 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Deren Wu <deren.wu@mediatek.com> wrote:

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> 
> When the chip not support 6GHz capability, the channels of 6GHz information
> should not be updated. This caused a crash:
> 
> [   19.442078] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000014
> [   19.457535] Mem abort info:
> [   19.465329]   ESR = 0x0000000096000004
> [   19.473295]   EC = 0x25: DABT (current EL), IL = 32 bits
> [   19.482354]   SET = 0, FnV = 0
> [   19.489143]   EA = 0, S1PTW = 0
> [   19.495991]   FSC = 0x04: level 0 translation fault
> [   19.504554] Data abort info:
> [   19.511111]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [   19.520269]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [   19.528988]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [   19.537960] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001027a9000
> [   19.548014] [0000000000000014] pgd=0000000000000000, p4d=000000000000
> [   19.558429] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [   19.568270] Modules linked in: mt7921e mt7921_common mt792x_lib
> mt76_connac_lib mt76 mac80211 btusb btintel cfg80211 btmtk snd_sof_ipc_msg_
> btrtl snd_sof_ipc_flood_test btbcm bluetooth snd_sof_mt8195 uvcvideo
> mtk_adsp_common snd_sof_xtensa_dsp uvc snd_sof_of snd_sof videobuf2_vmalloc
> ecdh_generic ecc snd_sof_utils cros_ec_lid_angle cros_ec_sensors crct10dif_
> cros_ec_sensors_core cros_usbpd_logger crypto_user fuse ip_tables ipv6
> [   19.614237] CPU: 1 PID: 105 Comm: kworker/1:1 Not tainted 6.6.0-rc6-next-20231017+ #324
> [   19.625957] Hardware name: Acer Tomato (rev2) board (DT)
> [   19.634970] Workqueue: events mt7921_init_work [mt7921_common]
> [   19.644522] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTY
> [   19.655182] pc : mt7921_regd_notifier+0x180/0x290 [mt7921_common]
> [   19.664983] lr : mt7921_regd_notifier+0xd4/0x290 [mt7921_common]
> [   19.674679] sp : ffff800080acba80
> [   19.681649] x29: ffff800080acba80 x28: 0000000000000000 x27: ffff4faf
> [   19.692483] x26: 0000000000000000 x25: 0000000000000000 x24: ffff4faf
> [   19.703294] x23: 00000000ffffe926 x22: ffff4faf16031fa0 x21: 00000000
> [   19.714108] x20: 000000000000001c x19: ffff4faf16ba6f40 x18: 00000000
> [   19.724928] x17: 0000000000000000 x16: ffffac6b891c2750 x15: ffff8000
> [   19.735722] x14: 0000000000000180 x13: 0000000000000000 x12: 00000000
> [   19.746478] x11: 0000000000000002 x10: ffff4faf01c21780 x9 : ffffac6b
> [   19.757214] x8 : 00000000006c0000 x7 : ffffac6b6b020cf0 x6 : ffffac6b
> [   19.767945] x5 : ffffac6b6b020d00 x4 : ffffac6b6b020cf8 x3 : ffff4faf
> [   19.778648] x2 : 0000000000000000 x1 : 000000000000001c x0 : 00000000
> [   19.789366] Call trace:
> [   19.795381]  mt7921_regd_notifier+0x180/0x290 [mt7921_common]
> [   19.804675]  wiphy_update_regulatory+0x2bc/0xa08 [cfg80211]
> [   19.813864]  wiphy_regulatory_register+0x4c/0x88 [cfg80211]
> [   19.823029]  wiphy_register+0x75c/0x8d0 [cfg80211]
> [   19.831446]  ieee80211_register_hw+0x70c/0xc10 [mac80211]
> [   19.840479]  mt76_register_device+0x168/0x2e8 [mt76]
> [   19.849008]  mt7921_init_work+0xdc/0x250 [mt7921_common]
> [   19.857817]  process_one_work+0x148/0x3c0
> [   19.865292]  worker_thread+0x32c/0x450
> [   19.872489]  kthread+0x11c/0x128
> [   19.879173]  ret_from_fork+0x10/0x20
> [   19.886153] Code: f0000041 9100a021 94000aef aa0003f9 (b9401780)
> [   19.895634] ---[ end trace 0000000000000000 ]---
> 
> Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Closes: https://lore.kernel.org/all/927e7d50-826d-4c92-9931-3c59b18c6945@collabora.com/
> Fixes: 09382d8f8641 ("wifi: mt76: mt7921: update the channel usage when the regd domain changed")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Patch applied to wireless-next.git, thanks.

169b7acb847e wifi: mt76: mt7921: fix kernel panic by accessing invalid 6GHz channel info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/cf77a58a60d81c77a28388bc8d312b87ffb48434.1697603002.git.deren.wu@mediatek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

