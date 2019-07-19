Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA09C6E410
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2019 12:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfGSKSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jul 2019 06:18:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53594 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725794AbfGSKSC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jul 2019 06:18:02 -0400
X-UUID: 263050394edc4ec59f48a13859d9414e-20190719
X-UUID: 263050394edc4ec59f48a13859d9414e-20190719
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2101253499; Fri, 19 Jul 2019 18:17:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 19 Jul 2019 18:17:56 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 19 Jul 2019 18:17:56 +0800
Message-ID: <1563531476.17970.2.camel@mtkswgap22>
Subject: Re: [PATCH 3/3] mt76: mt7615: add cwmin/cwmax initial values
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 19 Jul 2019 18:17:56 +0800
In-Reply-To: <c83e14787bc86f8f8062e0aa44e03ef80c3fd38a.1563518381.git.ryder.lee@mediatek.com>
References: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
         <c83e14787bc86f8f8062e0aa44e03ef80c3fd38a.1563518381.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-19 at 14:55 +0800, Ryder Lee wrote:
> Add initial values in mt7615_mcu_set_wmm() to cleanup setup flow.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> index 5fd162be3654..154c09428b69 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -622,10 +622,7 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val)
>  int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
>  		       const struct ieee80211_tx_queue_params *params)
>  {
> -#define WMM_AIFS_SET	BIT(0)
> -#define WMM_CW_MIN_SET	BIT(1)
> -#define WMM_CW_MAX_SET	BIT(2)
> -#define WMM_TXOP_SET	BIT(3)
> +#define WMM_PARAM_SET	GENMASK(3, 0)
>  	struct req_data {
>  		u8 number;
>  		u8 rsv[3];
> @@ -638,19 +635,17 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
>  	} __packed req = {
>  		.number = 1,
>  		.queue = queue,
> -		.valid = WMM_AIFS_SET | WMM_TXOP_SET,
> +		.valid = WMM_PARAM_SET,
>  		.aifs = params->aifs,
> +		.cw_min = BIT(5) - 1,
> +		.cw_max = cpu_to_le16(BIT(10) - 1),
>  		.txop = cpu_to_le16(params->txop),
>  	};
>  
> -	if (params->cw_min) {
> -		req.valid |= WMM_CW_MIN_SET;
> +	if (params->cw_min)
>  		req.cw_min = params->cw_min;
> -	}
> -	if (params->cw_max) {
> -		req.valid |= WMM_CW_MAX_SET;
> +	if (params->cw_max)
>  		req.cw_max = cpu_to_le16(params->cw_max);
> -	}

I should use fls() here and will send a v2

>  	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
>  				   &req, sizeof(req), true);


