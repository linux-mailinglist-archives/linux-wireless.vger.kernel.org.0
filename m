Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E9848FE40
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 18:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiAPRzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 12:55:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42210 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230174AbiAPRzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 12:55:41 -0500
X-UUID: f68374cc18eb4596a787a7c59d07d1cf-20220117
X-UUID: f68374cc18eb4596a787a7c59d07d1cf-20220117
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 232353742; Mon, 17 Jan 2022 01:55:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 17 Jan 2022 01:55:38 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 01:55:38 +0800
Message-ID: <5fdb8db1f02ffdacd554b7db531cf7719399cbdd.camel@mediatek.com>
Subject: Re: [PATCH 4/5] mt76: connac: move he radiotap parsing in connac
 module
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, <nbd@nbd.name>
CC:     <lorenzo.bianconi@redhat.com>, <linux-wireless@vger.kernel.org>,
        <sean.wang@mediatek.com>
Date:   Mon, 17 Jan 2022 01:55:38 +0800
In-Reply-To: <dcd7e4a9f10b1f0c94050453e4de4e1443fbc642.1642336806.git.lorenzo@kernel.org>
References: <cover.1642336806.git.lorenzo@kernel.org>
         <dcd7e4a9f10b1f0c94050453e4de4e1443fbc642.1642336806.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2022-01-16 at 13:43 +0100, Lorenzo Bianconi wrote:
> Move HE radiotap parsing code in mt76-connac module since it is
> shared
> between mt7921 and mt7915 drivers.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../net/wireless/mediatek/mt76/mt76_connac.h  |   2 +
>  .../wireless/mediatek/mt76/mt76_connac_mac.c  | 168 ++++++++++++++++
>  .../wireless/mediatek/mt76/mt76_connac_mac.h  |   4 +
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 175 +---------------
> -

[...]

> +mt76_connac_mac_decode_he_mu_radiotap(struct sk_buff *skb, __le32
> *rxv)
> +{
> +	struct mt76_rx_status *status = (struct mt76_rx_status *)skb-
> >cb;
> +	static const struct ieee80211_radiotap_he_mu mu_known = {
> +		.flags1 = HE_BITS(MU_FLAGS1_SIG_B_MCS_KNOWN) |
> +			  HE_BITS(MU_FLAGS1_SIG_B_DCM_KNOWN) |
> +			  HE_BITS(MU_FLAGS1_CH1_RU_KNOWN) |
> +			  HE_BITS(MU_FLAGS1_SIG_B_SYMS_USERS_KNOWN) |
> +			  HE_BITS(MU_FLAGS1_SIG_B_COMP_KNOWN),
> +		.flags2 = HE_BITS(MU_FLAGS2_BW_FROM_SIG_A_BW_KNOWN) |
> +			  HE_BITS(MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN),

I think hardware doesn't report MU_FLAGS2_PUNC_FROM_SIG_A_BW_KNOWN and
MU_FLAGS1_SIG_B_COMP_KNOWN. Should align mt7915 here.

Ryder

