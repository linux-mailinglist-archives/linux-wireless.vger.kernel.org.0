Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982BB7CD2DF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 06:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjJREb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 00:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJREbZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 00:31:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6FAC6
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 21:31:17 -0700 (PDT)
X-UUID: 2b974abc6d6f11eea33bb35ae8d461a2-20231018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=W2kp2L5BmgGub7RbK4HdPPv4NX9pWAiu2RlvDuuJmb8=;
        b=Q7t41EoJxcjFdtpkdkC0oprfNQG9FPLu8SOmfdikPC9fgac2rom3Qu4MKvuQXPprmz2PWlqquxB+6hJZfhlNCkUSOkvoHd0ROFtnoqBoDYvOTr7kPlT6p/2Qxi/P5QAOJoDJq88OigtZm806GAG0GbjxJklTHLKPgW+3SK4EJEY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:318b2ef3-eca9-4e3c-be42-c6f5a8816b1a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:a71741c4-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2b974abc6d6f11eea33bb35ae8d461a2-20231018
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 752127188; Wed, 18 Oct 2023 12:31:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 18 Oct 2023 12:31:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 18 Oct 2023 12:31:11 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Kalle Valo" <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
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
Subject: [next v2] wifi: mt76: mt7921: fix kernel panic by accessing invalid 6GHz channel info
Date:   Wed, 18 Oct 2023 12:29:35 +0800
Message-ID: <cf77a58a60d81c77a28388bc8d312b87ffb48434.1697603002.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.638600-8.000000
X-TMASE-MatchedRID: vYlX7A2PbnGE9zgVMk3pXvhavVZP5tTaim7lNffkTa5h2fnHe1cil34U
        OBQdfZJqEBxQ8/uHHs+lwJcQd6igKe3b8gC3neG3o65WJt1k1O/8d3gJRYhL8RrUQ7A9MrmGZaC
        d5Q2wOp/zSALlc2lmhdFgPsIL1VdsCWTkrZJeyWxbuDP8ZuCmXn607foZgOWyxSZxKZrfThMGxP
        EJpxlnFXcgv1FNmNxlsyNwawB6LJRidZi4l9eUhkD6z8N1m1AL+KgiyLtJrSA4YKAM3oRt9riNd
        7CXjOin07DRGjpSlleN6fDbnTu0nx8TzIzimOwPbdTuPa9VRGvEQdG7H66TyB5vYIBVaAnA/Yep
        h2Q+Pj6VnDmfyY21YjpP4WK3uV4Z/jPxLsL7yo9YIwW19+v4wH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.638600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: ECA448016E618E463B98F9D931EF7CBE63EF33B328E938D7CF6E466F426EB6072000:8
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

When the chip not support 6GHz capability, the channels of 6GHz information
should not be updated.

May get the stacktrace without this patch.
<1>[   19.442078] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000014
<1>[   19.457535] Mem abort info:
<1>[   19.465329]   ESR = 0x0000000096000004
<1>[   19.473295]   EC = 0x25: DABT (current EL), IL = 32 bits
<1>[   19.482354]   SET = 0, FnV = 0
<1>[   19.489143]   EA = 0, S1PTW = 0
<1>[   19.495991]   FSC = 0x04: level 0 translation fault
<1>[   19.504554] Data abort info:
<1>[   19.511111]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
<1>[   19.520269]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
<1>[   19.528988]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
<1>[   19.537960] user pgtable: 4k pages, 48-bit VAs, pgdp=00000001027a9000
<1>[   19.548014] [0000000000000014] pgd=0000000000000000, p4d=000000000000
<0>[   19.558429] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
<4>[   19.568270] Modules linked in: mt7921e mt7921_common mt792x_lib
mt76_connac_lib mt76 mac80211 btusb btintel cfg80211 btmtk snd_sof_ipc_msg_
btrtl snd_sof_ipc_flood_test btbcm bluetooth snd_sof_mt8195 uvcvideo
mtk_adsp_common snd_sof_xtensa_dsp uvc snd_sof_of snd_sof videobuf2_vmalloc
ecdh_generic ecc snd_sof_utils cros_ec_lid_angle cros_ec_sensors crct10dif_
cros_ec_sensors_core cros_usbpd_logger crypto_user fuse ip_tables ipv6
<4>[   19.614237] CPU: 1 PID: 105 Comm: kworker/1:1 Not tainted
6.6.0-rc6-next-20231017+ #324
<4>[   19.625957] Hardware name: Acer Tomato (rev2) board (DT)
<4>[   19.634970] Workqueue: events mt7921_init_work [mt7921_common]
<4>[   19.644522] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTY
<4>[   19.655182] pc : mt7921_regd_notifier+0x180/0x290 [mt7921_common]
<4>[   19.664983] lr : mt7921_regd_notifier+0xd4/0x290 [mt7921_common]
<4>[   19.674679] sp : ffff800080acba80
<4>[   19.681649] x29: ffff800080acba80 x28: 0000000000000000 x27: ffff4faf
<4>[   19.692483] x26: 0000000000000000 x25: 0000000000000000 x24: ffff4faf
<4>[   19.703294] x23: 00000000ffffe926 x22: ffff4faf16031fa0 x21: 00000000
<4>[   19.714108] x20: 000000000000001c x19: ffff4faf16ba6f40 x18: 00000000
<4>[   19.724928] x17: 0000000000000000 x16: ffffac6b891c2750 x15: ffff8000
<4>[   19.735722] x14: 0000000000000180 x13: 0000000000000000 x12: 00000000
<4>[   19.746478] x11: 0000000000000002 x10: ffff4faf01c21780 x9 : ffffac6b
<4>[   19.757214] x8 : 00000000006c0000 x7 : ffffac6b6b020cf0 x6 : ffffac6b
<4>[   19.767945] x5 : ffffac6b6b020d00 x4 : ffffac6b6b020cf8 x3 : ffff4faf
<4>[   19.778648] x2 : 0000000000000000 x1 : 000000000000001c x0 : 00000000
<4>[   19.789366] Call trace:
<4>[   19.795381]  mt7921_regd_notifier+0x180/0x290 [mt7921_common]
<4>[   19.804675]  wiphy_update_regulatory+0x2bc/0xa08 [cfg80211]
<4>[   19.813864]  wiphy_regulatory_register+0x4c/0x88 [cfg80211]
<4>[   19.823029]  wiphy_register+0x75c/0x8d0 [cfg80211]
<4>[   19.831446]  ieee80211_register_hw+0x70c/0xc10 [mac80211]
<4>[   19.840479]  mt76_register_device+0x168/0x2e8 [mt76]
<4>[   19.849008]  mt7921_init_work+0xdc/0x250 [mt7921_common]
<4>[   19.857817]  process_one_work+0x148/0x3c0
<4>[   19.865292]  worker_thread+0x32c/0x450
<4>[   19.872489]  kthread+0x11c/0x128
<4>[   19.879173]  ret_from_fork+0x10/0x20
<0>[   19.886153] Code: f0000041 9100a021 94000aef aa0003f9 (b9401780)
<4>[   19.895634] ---[ end trace 0000000000000000 ]---

Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Closes: https://lore.kernel.org/all/927e7d50-826d-4c92-9931-3c59b18c6945@collabora.com/
Fixes: 09382d8f8641 ("mt7921: update the channel usage when the regd domain changed")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---
v2: add [next] in title to apply this regression fix
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 55baac70860b..7d6a9d746011 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -88,6 +88,9 @@ mt7921_regd_channel_update(struct wiphy *wiphy, struct mt792x_dev *dev)
 	}
 
 	sband = wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband)
+		return;
+
 	band_np = np ? of_get_child_by_name(np, "txpower-6g") : NULL;
 	for (i = 0; i < sband->n_channels; i++) {
 		ch = &sband->channels[i];
-- 
2.18.0

