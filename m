Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093FA401FE5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Sep 2021 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbhIFSrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Sep 2021 14:47:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56038 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237144AbhIFSrV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Sep 2021 14:47:21 -0400
X-UUID: 9fd9c6b8a7684c748f44f9bf3ef1d631-20210907
X-UUID: 9fd9c6b8a7684c748f44f9bf3ef1d631-20210907
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1967224903; Tue, 07 Sep 2021 02:46:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Sep 2021 02:46:12 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Sep 2021 02:46:12 +0800
Message-ID: <ee67c1ddf6fd87b7faac04d0ba5cad33769bf831.camel@mediatek.com>
Subject: Re: [PATCH v2 8/8] mt76: mt7915: set muru platform type
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "Evelyn Tsai ( =?ISO-8859-1?Q?=1B$Bhq;9|*=1B(B?=)" 
        <Evelyn.Tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Date:   Tue, 7 Sep 2021 02:46:12 +0800
In-Reply-To: <20210906114423.13646-8-shayne.chen@mediatek.com>
References: <20210906114423.13646-1-shayne.chen@mediatek.com>
         <20210906114423.13646-8-shayne.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-09-06 at 19:44 +0800, Shayne Chen wrote:
> Notify fw to init corresponding muru algorithm.
> 
> Suggested-by: Money Wang <money.wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  | 16
> ++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h  |  5 +++++
>  .../net/wireless/mediatek/mt76/mt7915/testmode.h |  4 ----
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index 229ba3c469d1..6242d5e11107 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2949,6 +2949,21 @@ static int mt7915_mcu_set_mwds(struct
> mt7915_dev *dev, bool enabled)
>                                  sizeof(req), false);
>  }
> 
> +static int mt7915_mcu_set_muru_ptype(struct mt7915_dev *dev)
> +{
> +       struct {
> +               __le32 cmd;
> +               u8 ptype;
> +               u8 _rsv[3];
> +       } __packed req = {
> +               .cmd = MURU_SET_PLATFORM_TYPE,

cpu_to_le32

> +               .ptype = 2,
> +       };
> +
> +       return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MURU_CTRL),
> &req,
> +                                sizeof(req), false);
> +}
> +
>  int mt7915_mcu_init(struct mt7915_dev *dev)
>  {
>         static const struct mt76_mcu_ops mt7915_mcu_ops = {
> @@ -2973,6 +2988,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
>         mt7915_mcu_fw_log_2_host(dev, 0);
>         mt7915_mcu_set_mwds(dev, 1);
>         mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(SET),
> MCU_WA_PARAM_RED, 0, 0);
> +       mt7915_mcu_set_muru_ptype(dev);
> 
>         return 0;
>  }
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> index 6344faf3f394..57be9262ec2a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
> @@ -1086,6 +1086,11 @@ enum {
>         MT_BF_MODULE_UPDATE = 25
>  };
> 
> +enum {
> +       MURU_SET_ARB_OP_MODE = 14,
> +       MURU_SET_PLATFORM_TYPE = 25,
> +};
> 

I think it's better to use mt7915_mcu_set_muru_cmd(phy, cmd, opcode) in
the long run to avoid adding duplicated muru_ctrl for future UL
support.


