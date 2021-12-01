Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFB464D7E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 13:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349176AbhLAMIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 07:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349139AbhLAMIe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 07:08:34 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51642C061574
        for <linux-wireless@vger.kernel.org>; Wed,  1 Dec 2021 04:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
        Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Fs2Dvlbnis6ALmJuF1LzDv7QQb8i2PaaMQJJ8if3268=; b=uSlOyyHtcvmeFvCgALaTWrnQB3
        2tAenKO8yujFJ4Gy/N4F3JjprwYb6Vt/+KF/CpTroOl5xk7dGZOMGeUdRT6c7r336zY7PBYlXgIaD
        YBUy5NLYKbbAT7MtdaO14RBoHjRoSK/Sy48LgWuDdsD/RCruKzLFUxG+mu5HsSGP62yo=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1msOMH-0001x8-OO; Wed, 01 Dec 2021 13:05:09 +0100
Message-ID: <c42b846e-95c3-c244-f51d-9758cbb8d6be@nbd.name>
Date:   Wed, 1 Dec 2021 13:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v3 02/11] mt76: mt7915: refine register definition
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
References: <cover.1637652742.git.Bo.Jiao@mediatek.com>
 <0850d5df6574ea3d0ef32e953e5269548a8a223a.1637652742.git.Bo.Jiao@mediatek.com>
Content-Language: en-US
In-Reply-To: <0850d5df6574ea3d0ef32e953e5269548a8a223a.1637652742.git.Bo.Jiao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thank you for the patch. Some comments and change requests below.

On 2021-11-23 08:49, Bo Jiao wrote:
> From: Bo Jiao <Bo.Jiao@mediatek.com>
> 
> Add mt7915_reg_desc to differentiate chip generations.
> This is an intermediate patch to introduce mt7916 support.
> 
> Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>   .../wireless/mediatek/mt76/mt7915/debugfs.c   |  20 +-
>   .../net/wireless/mediatek/mt76/mt7915/dma.c   |   5 +-
>   .../net/wireless/mediatek/mt76/mt7915/mac.c   |  26 +-
>   .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 507 +++++++++++++--
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |   4 +-
>   .../net/wireless/mediatek/mt76/mt7915/regs.h  | 607 ++++++++++++------
>   .../wireless/mediatek/mt76/mt7915/testmode.c  |  58 +-
>   7 files changed, 907 insertions(+), 320 deletions(-)
> 

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> index 2f8b72b..0d67321 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -10,100 +10,449 @@
>   #include "mac.h"
>   #include "../trace.h"
>   

I think the patch and the code can be much simpler if we get rid of the 
base address abstraction that you introduced. Some more comments below:

> +static const u32 mt7915_base[] = {
> +	[MT_REMAP_L1_CFG_BASE]	= 0xf1000,
> +	[MT_REMAP_L1_BASE]	= 0xe0000,
> +	[MT_REMAP_L2_CFG_BASE]	= 0xf1000,
> +	[MT_REMAP_L2_BASE]	= 0x00000,

The use of these is limited to the mt7915_reg_map_l* functions. You can 
simply add separate #defines and separate register map functions for 
7915 and 7916.


> +	[MT_INFRA_MCU_END_BASE]	= 0x7c3fffff,

This one is unused if you also get rid of MT_CONN_INFRA_MCU_START and 
MT_CONN_INFRA_MCU_END.

> +	[MT_PCIE_MAC_BASE]	= 0x74030000,

Same as 7916

> +	[MT_PCIE1_MAC_BASE]	= 0x74020000,

This is used in one place only. Separate register definitions would make 
this easier to follow.

> +	[MT_WFDMA0_BASE]	= 0xd4000,
> +	[MT_WFDMA1_BASE]	= 0xd5000,
> +	[MT_WFDMA0_PCIE1_BASE]	= 0xd8000,
> +	[MT_WFDMA1_PCIE1_BASE]	= 0xd9000,
> +	[MT_WFDMA_EXT_CSR_BASE]	= 0xd7000,

Same as 7916

> +	[MT_SWDEF_BASE]		= 0x41f200,

Again used in one place only, so separate definitions makes sense here 
as well.

> +	[MT_MCU_WFDMA0_BASE]	= 0x2000,
> +	[MT_MCU_WFDMA1_BASE]	= 0x3000,

Same as 7916.

> [...]
> +static const struct __reg mt7915_reg[] = {
> +	[L1_REMAP_CFG_OFFSET]	= { MT_REMAP_L1_CFG_BASE, 0x1ac },
> +	[L2_REMAP_CFG_OFFSET]	= { MT_REMAP_L2_CFG_BASE, 0x1b0 },

Same as for MT_REMAP_L1_CFG_BASE, ...


> +	[INT_SOURCE_CSR]	= { MT_WFDMA_EXT_CSR_BASE, 0x10 },
> +	[INT_MASK_CSR]		= { MT_WFDMA_EXT_CSR_BASE, 0x14 },
> +	[INT1_SOURCE_CSR]	= { MT_WFDMA_EXT_CSR_BASE, 0x88 },
> +	[INT1_MASK_CSR]		= { MT_WFDMA_EXT_CSR_BASE, 0x8c },
> +	[INT_MCU_CMD_SOURCE]	= { MT_WFDMA1_BASE, 0x1f0 },
> +	[INT_MCU_CMD_EVENT]	= { MT_MCU_WFDMA1_BASE, 0x108 },
> +	[TX_RING_BASE]		= { MT_WFDMA1_BASE, 0x400 },
> +	[RX_EVENT_RING_BASE]	= { MT_WFDMA1_BASE, 0x500 },
> +	[RX_DATA_RING_BASE]	= { MT_WFDMA0_BASE, 0x500 },
> +	[TMAC_CDTR]		= { INVALID_BASE, 0x090 },
> +	[TMAC_ODTR]		= { INVALID_BASE, 0x094 },
> +	[TMAC_ATCR]		= { INVALID_BASE, 0x098 },
> +	[TMAC_TRCR0]		= { INVALID_BASE, 0x09c },
> +	[TMAC_ICR0]		= { INVALID_BASE, 0x0a4 },
> +	[TMAC_ICR1]		= { INVALID_BASE, 0x0b4 },
> +	[TMAC_CTCR0]		= { INVALID_BASE, 0x0f4 },
> +	[TMAC_TFCR0]		= { INVALID_BASE, 0x1e0 },
> +	[MDP_BNRCFR0]		= { INVALID_BASE, 0x070 },
> +	[MDP_BNRCFR1]		= { INVALID_BASE, 0x074 },
> +	[ARB_DRNGR0]		= { INVALID_BASE, 0x194 },
> +	[ARB_SCR]		= { INVALID_BASE, 0x080 },
> +	[RMAC_MIB_AIRTIME14]	= { INVALID_BASE, 0x3b8 },
> +	[AGG_AWSCR0]		= { INVALID_BASE, 0x05c },
> +	[AGG_PCR0]		= { INVALID_BASE, 0x06c },
> +	[AGG_ACR0]		= { INVALID_BASE, 0x084 },
> +	[AGG_MRCR]		= { INVALID_BASE, 0x098 },
> +	[AGG_ATCR1]		= { INVALID_BASE, 0x0f0 },
> +	[AGG_ATCR3]		= { INVALID_BASE, 0x0f4 },
> +	[LPON_UTTR0]		= { INVALID_BASE, 0x080 },
> +	[LPON_UTTR1]		= { INVALID_BASE, 0x084 },
> +	[MIB_SDR3]		= { INVALID_BASE, 0x014 },
> +	[MIB_SDR4]		= { INVALID_BASE, 0x018 },
> +	[MIB_SDR5]		= { INVALID_BASE, 0x01c },
> +	[MIB_SDR7]		= { INVALID_BASE, 0x024 },
> +	[MIB_SDR8]		= { INVALID_BASE, 0x028 },
> +	[MIB_SDR9]		= { INVALID_BASE, 0x02c },
> +	[MIB_SDR10]		= { INVALID_BASE, 0x030 },
> +	[MIB_SDR11]		= { INVALID_BASE, 0x034 },
> +	[MIB_SDR12]		= { INVALID_BASE, 0x038 },
> +	[MIB_SDR13]		= { INVALID_BASE, 0x03c },
> +	[MIB_SDR14]		= { INVALID_BASE, 0x040 },
> +	[MIB_SDR15]		= { INVALID_BASE, 0x044 },
> +	[MIB_SDR16]		= { INVALID_BASE, 0x048 },
> +	[MIB_SDR17]		= { INVALID_BASE, 0x04c },
> +	[MIB_SDR18]		= { INVALID_BASE, 0x050 },
> +	[MIB_SDR19]		= { INVALID_BASE, 0x054 },
> +	[MIB_SDR20]		= { INVALID_BASE, 0x058 },
> +	[MIB_SDR21]		= { INVALID_BASE, 0x05c },
> +	[MIB_SDR22]		= { INVALID_BASE, 0x060 },
> +	[MIB_SDR23]		= { INVALID_BASE, 0x064 },
> +	[MIB_SDR24]		= { INVALID_BASE, 0x068 },
> +	[MIB_SDR25]		= { INVALID_BASE, 0x06c },
> +	[MIB_SDR27]		= { INVALID_BASE, 0x074 },
> +	[MIB_SDR28]		= { INVALID_BASE, 0x078 },
> +	[MIB_SDR29]		= { INVALID_BASE, 0x07c },
> +	[MIB_SDRVEC]		= { INVALID_BASE, 0x080 },
> +	[MIB_SDR31]		= { INVALID_BASE, 0x084 },
> +	[MIB_SDR32]		= { INVALID_BASE, 0x088 },
> +	[MIB_SDRMUBF]		= { INVALID_BASE, 0x090 },
> +	[MIB_DR8]		= { INVALID_BASE, 0x0c0 },
> +	[MIB_DR9]		= { INVALID_BASE, 0x0c4 },
> +	[MIB_DR11]		= { INVALID_BASE, 0x0cc },
> +	[MIB_MB_SDR0]		= { INVALID_BASE, 0x100 },
> +	[MIB_MB_SDR1]		= { INVALID_BASE, 0x104 },
> +	[TX_AGG_CNT]		= { INVALID_BASE, 0x0a8 },
> +	[TX_AGG_CNT2]		= { INVALID_BASE, 0x164 },
> +	[MIB_ARNG]		= { INVALID_BASE, 0x4b8 },
> +	[WTBLON_TOP_WDUCR]	= { INVALID_BASE, 0x0},
> +	[WTBL_UPDATE]		= { INVALID_BASE, 0x030},
> +	[PLE_FL_Q_EMPTY]	= { INVALID_BASE, 0x0b0},
> +	[PLE_FL_Q_CTRL]		= { INVALID_BASE, 0x1b0},
> +	[PLE_AC_QEMPTY]		= { INVALID_BASE, 0x500},
> +	[PLE_FREEPG_CNT]	= { INVALID_BASE, 0x100},
> +	[PLE_FREEPG_HEAD_TAIL]	= { INVALID_BASE, 0x104},
> +	[PLE_PG_HIF_GROUP]	= { INVALID_BASE, 0x110},
> +	[PLE_HIF_PG_INFO]	= { INVALID_BASE, 0x114},
> +	[AC_OFFSET]		= { INVALID_BASE, 0x040},
> +};

I think you can replace the { base, reg } tuple with just a register 
address (or offset). For the PLE register definitions, it probably also 
makes sense to get rid of the array indirection and just add separate 
definitions and functions.

> [...]

> +
> +static const struct __mask mt7915_mask[] = {
> +	[L2_REMAP_MASK]		= {19, 0},
> +	[L2_REMAP_OFFSET]	= {11, 0},
> +	[L2_REMAP_BASE]		= {31, 12},
> +	[MIB_SDR3_FCS_ERR]	= {15, 0},
> +	[MIB_MRDY_CNT]		= {25, 0},
> +	[MIB_MPDU_ATTEMPTS_CNT]	= {23, 0},
> +	[MIB_MPDU_SUCCESS_CNT]	= {23, 0},
> +	[MIB_AMPDU_SF_CNT]	= {23, 0},
> +	[MIB_PF_DROP_CNT]	= {7, 0},
> +	[MIB_VEC_DROP_CNT]	= {15, 0},
> +	[MIB_BF_TX_CNT]		= {15, 0},
> +};
> +
> +static const struct __mask mt7916_mask[] = {
> +	[L2_REMAP_MASK]		= {31, 16},
> +	[L2_REMAP_OFFSET]	= {15, 0},
> +	[L2_REMAP_BASE]		= {31, 16},
> +	[MIB_SDR3_FCS_ERR]	= {31, 16},
> +	[MIB_MRDY_CNT]		= {31, 0},
> +	[MIB_MPDU_ATTEMPTS_CNT]	= {31, 0},
> +	[MIB_MPDU_SUCCESS_CNT]	= {31, 0},
> +	[MIB_AMPDU_SF_CNT]	= {31, 0},
> +	[MIB_PF_DROP_CNT]	= {15, 0},
> +	[MIB_VEC_DROP_CNT]	= {31, 16},
> +	[MIB_BF_TX_CNT]		= {31, 16},
> +};

I think this array should also be removed and the mask differences 
open-coded in the relevant functions.

> +
> +static const u32 mt7915_bit[] = {
> +	[RX_DONE_DAND0]		= 16,
> +	[RX_DONE_DAND1]		= 17,
> +	[RX_DONE_MCU_WM]	= 0,
> +	[RX_DONE_MCU_WA]	= 1,
> +	[RX_DONE_WA_BAND0]	= 1,
> +	[RX_DONE_WA_BAND1]	= 2,
> +	[TX_DONE_FWDL]		= 26,
> +	[TX_DONE_MCU_WM]	= 27,
> +	[TX_DONE_MCU_WA]	= 15,
> +	[TX_DONE_BAND0]		= 30,
> +	[TX_DONE_BAND1]		= 31,
> +	[RX_MCU_TO_HOST]	= 29,
> +	[MIB_MB_SDR]		= 2,
> +	[LPON_TCR]		= 0,
> +};
> +
> +static const u32 mt7916_bit[] = {
> +	[RX_DONE_DAND0]		= 22,
> +	[RX_DONE_DAND1]		= 23,
> +	[RX_DONE_MCU_WM]	= 0,
> +	[RX_DONE_MCU_WA]	= 1,
> +	[RX_DONE_WA_BAND0]	= 2,
> +	[RX_DONE_WA_BAND1]	= 3,
> +	[TX_DONE_FWDL]		= 26,
> +	[TX_DONE_MCU_WM]	= 27,
> +	[TX_DONE_MCU_WA]	= 25,
> +	[TX_DONE_BAND0]		= 30,
> +	[TX_DONE_BAND1]		= 31,
> +	[RX_MCU_TO_HOST]	= 29,
> +	[MIB_MB_SDR]		= 1,
> +	[LPON_TCR]		= 2,
> +};

I think for the interrupt masks we should have a separate mask 
definitions for 7915 vs 7916 and check for the chip type in 
mt7915_irq_tasklet.
The other two bits also don't seem worth keeping a separate array for, 
so better just open-code the differences.

> +
> +static const struct __map mt7915_reg_map[] = {
> +	{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
> +	{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
> +	{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
> +	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
> +	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
> +	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
> +	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
> +	{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
> +	{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
> +	{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
> +	{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
> +	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> +	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> +	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
> +	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
> +	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
> +	{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
> +	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
> +	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
> +	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> +	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> +	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> +	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
> +	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
> +	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
> +	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
> +	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
> +	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
> +	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
> +	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
> +	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
> +	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
> +	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
> +	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
> +	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
> +	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
> +	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
> +	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
> +	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
> +	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
> +	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
> +	{ 0x0, 0x0, 0x0 }, /* imply end of search */
> +};
> +
> +static const struct __map mt7916_reg_map[] = {
> +	{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA_0 (PCIE0 MCU DMA0) */
> +	{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA_1 (PCIE0 MCU DMA1) */
> +	{ 0x56000000, 0x04000, 0x1000 }, /* WFDMA_2 (Reserved) */
> +	{ 0x57000000, 0x05000, 0x1000 }, /* WFDMA_3 (MCU wrap CR) */
> +	{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA_4 (PCIE1 MCU DMA0) */
> +	{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA_5 (PCIE1 MCU DMA1) */
> +	{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> +	{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> +	{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
> +	{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
> +	{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
> +	{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> +	{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> +	{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> +	{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
> +	{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
> +	{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
> +	{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
> +	{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
> +	{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
> +	{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
> +	{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
> +	{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
> +	{ 0x820ca000, 0x26000, 0x2000 }, /* WF_LMAC_TOP BN0 (WF_MUCOP) */
> +	{ 0x820d0000, 0x30000, 0x10000}, /* WF_LMAC_TOP (WF_WTBLON) */
> +	{ 0x00400000, 0x80000, 0x10000}, /* WF_MCU_SYSRAM */
> +	{ 0x00410000, 0x90000, 0x10000}, /* WF_MCU_SYSRAM (configure cr) */
> +	{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
> +	{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
> +	{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
> +	{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
> +	{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
> +	{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
> +	{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
> +	{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
> +	{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
> +	{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
> +	{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
> +	{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
> +	{ 0x820c4000, 0xa8000, 0x1000 }, /* WF_LMAC_TOP (WF_UWTBL ) */
> +	{ 0x820b0000, 0xae000, 0x1000 }, /* [APB2] WFSYS_ON */
> +	{ 0x80020000, 0xb0000, 0x10000}, /* WF_TOP_MISC_OFF */
> +	{ 0x81020000, 0xc0000, 0x10000}, /* WF_TOP_MISC_ON */
> +	{ 0x0, 0x0, 0x100000 }, /* fixed remap range */

This "fixed remap range" entry isn't needed, this is already handled in 
__mt7915_reg_addr.

> +	{ 0x0, 0x0, 0x0 }, /* imply end of search */
> +};
> + [...]

>   
>   static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
>   {
> -	static const struct {
> -		u32 phys;
> -		u32 mapped;
> -		u32 size;
> -	} fixed_map[] = {
> -		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
> -		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure regs) */
> -		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
> -		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
> -		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
> -		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
> -		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
> -		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
> -		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
> -		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
> -		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
> -		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> -		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> -		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
> -		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
> -		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
> -		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
> -		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
> -		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
> -		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> -		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> -		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> -		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
> -		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
> -		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
> -		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
> -		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
> -		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
> -		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
> -		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
> -		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
> -		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
> -		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
> -		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
> -		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
> -		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
> -		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
> -		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
> -		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
> -		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
> -		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
> -	};
>   	int i;
>   
>   	if (addr < 0x100000)
>   		return addr;
>   
> -	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
> +	if (!dev->reg->map) {
> +		dev_err(dev->mt76.dev, "err: reg_map is null\n");
> +		return addr;
> +	}
> +
> +	for (i = 0; i < dev->reg->map_size; i++) {
>   		u32 ofs;
>   
> -		if (addr < fixed_map[i].phys)
> +		if (addr < dev->reg->map[i].phys)
>   			continue;
>   
> -		ofs = addr - fixed_map[i].phys;
> -		if (ofs > fixed_map[i].size)
> +		ofs = addr - dev->reg->map[i].phys;
> +		if (ofs > dev->reg->map[i].size)
>   			continue;
>   
> -		return fixed_map[i].mapped + ofs;
> +		return dev->reg->map[i].maps + ofs;
>   	}
>   
> -	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
> -	    (addr >= 0x70000000 && addr < 0x78000000))
> +	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
> +	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
> +	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
> +		return mt7915_reg_map_l1(dev, addr);
> +
> +	if (dev_is_pci(dev->mt76.dev) &&
> +	    ((addr >= MT_CBTOP1_PHY_START && addr <= MT_CBTOP1_PHY_END) ||
> +	     (addr >= MT_CBTOP2_PHY_START && addr <= MT_CBTOP2_PHY_END))) {
> +		/* CONN_INFRA: covert to phyiscal addr and use layer 1 remap */
> +		if (addr >= MT_CONN_INFRA_MCU_START &&
> +		    addr <= MT_CONN_INFRA_MCU_END)
> +			addr = addr - MT_CONN_INFRA_MCU_START + MT_INFRA_BASE;

As far as I can tell, the MT_CONN_INFRA_MCU_START remapping is useless 
and unused.

> +
>   		return mt7915_reg_map_l1(dev, addr);
> +	}
>   
>   	return mt7915_reg_map_l2(dev, addr);
>   }
> @@ -138,10 +487,18 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
>   {
>   	struct mt76_bus_ops *bus_ops;
>   	struct mt7915_dev *dev;
> +	int i;
>   
>   	dev = container_of(mdev, struct mt7915_dev, mt76);
>   	mt76_mmio_init(&dev->mt76, mem_base);
>   
> +	for (i = 0; i < ARRAY_SIZE(reg_desc); i++) {
> +		if (device_id == reg_desc[i].id) {
> +			dev->reg = &reg_desc[i];
> +			break;
> +		}
> +	}

I'd prefer removing the reg_desc array and just checking the chip types 
here directly.

> +
>   	dev->bus_ops = dev->mt76.bus;
>   	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
>   			       GFP_KERNEL);
> @@ -184,15 +541,29 @@ static void mt7915_rx_poll_complete(struct mt76_dev *mdev,
>   				    enum mt76_rxq_id q)
>   {
>   	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
> -	static const u32 rx_irq_mask[] = {
> -		[MT_RXQ_MAIN] = MT_INT_RX_DONE_DATA0,
> -		[MT_RXQ_EXT] = MT_INT_RX_DONE_DATA1,
> -		[MT_RXQ_MCU] = MT_INT_RX_DONE_WM,
> -		[MT_RXQ_MCU_WA] = MT_INT_RX_DONE_WA,
> -		[MT_RXQ_EXT_WA] = MT_INT_RX_DONE_WA_EXT,
> -	};
> +	u32 rx_irq_mask = 0;
> +
> +	switch (q) {
> +	case MT_RXQ_MAIN:
> +		rx_irq_mask = MT_INT_RX_DONE_DATA0;
> +		break;
> +	case MT_RXQ_EXT:
> +		rx_irq_mask = MT_INT_RX_DONE_DATA1;
> +		break;
> +	case MT_RXQ_MCU:
> +		rx_irq_mask = MT_INT_RX_DONE_WM;
> +		break;
> +	case MT_RXQ_MCU_WA:
> +		rx_irq_mask = MT_INT_RX_DONE_WA;
> +		break;
> +	case MT_RXQ_EXT_WA:
> +		rx_irq_mask = MT_INT_RX_DONE_WA_EXT;
> +		break;
> +	default:
> +		break;
> +	}

If we have separate mask definitions, we could simply have two arrays 
here, one for 7915 and one for 7916.

- Felix


