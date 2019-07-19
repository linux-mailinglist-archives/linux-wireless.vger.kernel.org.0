Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0203A6E1AA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 09:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfGSH1X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 03:27:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4147 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbfGSH1X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 03:27:23 -0400
X-UUID: a69de542ced147f3a1a4b1ceb27efe2f-20190719
X-UUID: a69de542ced147f3a1a4b1ceb27efe2f-20190719
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 160776184; Fri, 19 Jul 2019 15:27:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 19 Jul 2019 15:27:14 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Jul 2019 15:27:14 +0800
Message-ID: <1563521234.8090.4.camel@mtkswgap22>
Subject: Re: [PATCH 2/3] mt76: mt7615: add 4 WMM sets support
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Roy Luo <royluo@google.com>
CC:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 19 Jul 2019 15:27:14 +0800
In-Reply-To: <CA+zupgwyz2hdVRmnGr+4vzeEfvTfxYkLmu6jD_jFNjrPAdbvCQ@mail.gmail.com>
References: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
         <1dc3cbc32729be40d0e1f2ef831377f2cddf3df3.1563518381.git.ryder.lee@mediatek.com>
         <CA+zupgwyz2hdVRmnGr+4vzeEfvTfxYkLmu6jD_jFNjrPAdbvCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: D61FDE6DCE5E490ED94D7E171FF4DB4510347F1D7F8F881410629479B1536F882000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-19 at 15:05 +0800, Roy Luo wrote:
> 
> 
> 
> On Fri, Jul 19, 2019 at 2:55 PM Ryder Lee <ryder.lee@mediatek.com>
> wrote:
> 
>         MT7615 hardware supoorts 4 WMM sets, so this patch adds them
>         accordingly.
>         Also remove incorrect queue mapping in .conf_tx
>         
>         Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
>         ---
>          drivers/net/wireless/mediatek/mt76/mt7615/mac.c  |  5 +++--
>          drivers/net/wireless/mediatek/mt76/mt7615/main.c | 16
>         ++++++----------
>          .../net/wireless/mediatek/mt76/mt7615/mt7615.h   |  1 +
>          3 files changed, 10 insertions(+), 12 deletions(-)
>         
>         diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
>         b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
>         index 8f9a2bb68ded..d85b3904f33a 100644
>         --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
>         +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
>         @@ -314,7 +314,7 @@ int mt7615_mac_write_txwi(struct
>         mt7615_dev *dev, __le32 *txwi,
>                 struct ieee80211_hdr *hdr = (struct ieee80211_hdr
>         *)skb->data;
>                 struct ieee80211_vif *vif = info->control.vif;
>                 int tx_count = 8;
>         -       u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0;
>         +       u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0,
>         wmm_idx = 0;
>                 __le16 fc = hdr->frame_control;
>                 u16 seqno = 0;
>                 u32 val;
>         @@ -323,6 +323,7 @@ int mt7615_mac_write_txwi(struct
>         mt7615_dev *dev, __le32 *txwi,
>                         struct mt7615_vif *mvif = (struct mt7615_vif
>         *)vif->drv_priv;
>         
>                         omac_idx = mvif->omac_idx;
>         +               wmm_idx = mvif->wmm_idx;
>                 }
>         
>                 if (sta) {
>         @@ -335,7 +336,7 @@ int mt7615_mac_write_txwi(struct
>         mt7615_dev *dev, __le32 *txwi,
>                 fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >>
>         4;
>         
>                 if (ieee80211_is_data(fc) ||
>         ieee80211_is_bufferable_mmpdu(fc)) {
>         -               q_idx = skb_get_queue_mapping(skb);
>         +               q_idx = skb_get_queue_mapping(skb) + wmm_idx *
>         MT7615_MAX_WMM_SETS;
>                         p_fmt = MT_TX_TYPE_CT;
>                 } else if (ieee80211_is_beacon(fc)) {
>                         q_idx = MT_LMAC_BCN0;
>         diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
>         b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
>         index 2c702b31d55f..ea48dcdb65c0 100644
>         --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
>         +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
>         @@ -85,9 +85,9 @@ static int mt7615_add_interface(struct
>         ieee80211_hw *hw,
>                 }
>                 mvif->omac_idx = idx;
>         
>         -       /* TODO: DBDC support. Use band 0 and wmm 0 for now */
>         +       /* TODO: DBDC support. Use band 0 for now */
>                 mvif->band_idx = 0;
>         -       mvif->wmm_idx = 0;
>         +       mvif->wmm_idx = mvif->idx % MT7615_MAX_WMM_SETS;
>         
> 
> 
> IIUC, vifs with the same wmm_idx will share the same WMM HW, thus the
> same WMM parameter.
> Shouldn't we assign wmm_idx based on that?

I think that's what I did here. vif0 <-> wmm0, vif1 <->wmm1 ...

> 
> 

