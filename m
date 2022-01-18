Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B50492D13
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jan 2022 19:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347870AbiARSQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jan 2022 13:16:38 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:37244 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiARSQi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jan 2022 13:16:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 0F519B4EB5;
        Tue, 18 Jan 2022 18:16:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id URevQUGPMCfL; Tue, 18 Jan 2022 18:16:34 +0000 (UTC)
Received: from [192.168.1.126] (unknown [71.205.29.0])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 93E9CAA893;
        Tue, 18 Jan 2022 18:16:32 +0000 (UTC)
Message-ID: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
Date:   Tue, 18 Jan 2022 11:16:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] mt76: mt7921e: fix possible probe failure after reboot
Content-Language: en-US
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <70e27cbc652cbdb78277b9c691a3a5ba02653afb.1641540175.git.objelf@gmail.com>
From:   Khalid Aziz <khalid@gonehiking.org>
In-Reply-To: <70e27cbc652cbdb78277b9c691a3a5ba02653afb.1641540175.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 1/7/22 12:30 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>
> It doesn't guarantee the mt7921e gets started with ASPM L0 after each
> machine reboot on every platform.
>
> If mt7921e gets started with not ASPM L0, it would be possible that the
> driver encounters time to time failure in mt7921_pci_probe, like a
> weird chip identifier is read
>
> [  215.514503] mt7921e 0000:05:00.0: ASIC revision: feed0000
> [  216.604741] mt7921e: probe of 0000:05:00.0 failed with error -110
>
> or failing to init hardware because the driver is not allowed to access the
> register until the device is in ASPM L0 state. So, we call
> __mt7921e_mcu_drv_pmctrl in early mt7921_pci_probe to force the device
> to bring back to the L0 state for we can safely access registers in any
> case.
>
> In the patch, we move all functions from dma.c to pci.c and register mt76
> bus operation earilier, that is the __mt7921e_mcu_drv_pmctrl depends on.
>
> Fixes: bf3747ae2e25 ("mt76: mt7921: enable aspm by default")
> Reported-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
> Co-developed-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>


Tested-by: Khalid Aziz <khalid@gonehiking.org>

--
Khalid
> ---
>   .../net/wireless/mediatek/mt76/mt7921/dma.c   | 119 -----------------
>   .../wireless/mediatek/mt76/mt7921/mt7921.h    |   1 +
>   .../net/wireless/mediatek/mt76/mt7921/pci.c   | 124 ++++++++++++++++++
>   .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |  18 ++-
>   4 files changed, 139 insertions(+), 123 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> index cdff1fd52d93..39d6ce4ecddd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
> @@ -78,110 +78,6 @@ static void mt7921_dma_prefetch(struct mt7921_dev *dev)
>   	mt76_wr(dev, MT_WFDMA0_TX_RING17_EXT_CTRL, PREFETCH(0x380, 0x4));
>   }
>   
> -static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
> -{
> -	static const struct {
> -		u32 phys;
> -		u32 mapped;
> -		u32 size;
> -	} fixed_map[] = {
> -		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
> -		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
> -		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> -		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
> -		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
> -		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> -		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> -		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
> -		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
> -		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure register) */
> -		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
> -		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
> -		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
> -		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
> -		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
> -		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
> -		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
> -		{ 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_host_csr_top */
> -		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
> -		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
> -		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> -		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> -		{ 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
> -		{ 0x820cd000, 0x0f000, 0x1000 }, /* WF_MDP_TOP */
> -		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
> -		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
> -		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
> -		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
> -		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
> -		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
> -		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
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
> -	int i;
> -
> -	if (addr < 0x100000)
> -		return addr;
> -
> -	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
> -		u32 ofs;
> -
> -		if (addr < fixed_map[i].phys)
> -			continue;
> -
> -		ofs = addr - fixed_map[i].phys;
> -		if (ofs > fixed_map[i].size)
> -			continue;
> -
> -		return fixed_map[i].mapped + ofs;
> -	}
> -
> -	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
> -	    (addr >= 0x70000000 && addr < 0x78000000) ||
> -	    (addr >= 0x7c000000 && addr < 0x7c400000))
> -		return mt7921_reg_map_l1(dev, addr);
> -
> -	dev_err(dev->mt76.dev, "Access currently unsupported address %08x\n",
> -		addr);
> -
> -	return 0;
> -}
> -
> -static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
> -{
> -	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
> -	u32 addr = __mt7921_reg_addr(dev, offset);
> -
> -	return dev->bus_ops->rr(mdev, addr);
> -}
> -
> -static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
> -{
> -	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
> -	u32 addr = __mt7921_reg_addr(dev, offset);
> -
> -	dev->bus_ops->wr(mdev, addr, val);
> -}
> -
> -static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
> -{
> -	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
> -	u32 addr = __mt7921_reg_addr(dev, offset);
> -
> -	return dev->bus_ops->rmw(mdev, addr, mask, val);
> -}
> -
>   static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
>   {
>   	if (force) {
> @@ -341,23 +237,8 @@ int mt7921_wpdma_reinit_cond(struct mt7921_dev *dev)
>   
>   int mt7921_dma_init(struct mt7921_dev *dev)
>   {
> -	struct mt76_bus_ops *bus_ops;
>   	int ret;
>   
> -	dev->phy.dev = dev;
> -	dev->phy.mt76 = &dev->mt76.phy;
> -	dev->mt76.phy.priv = &dev->phy;
> -	dev->bus_ops = dev->mt76.bus;
> -	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
> -			       GFP_KERNEL);
> -	if (!bus_ops)
> -		return -ENOMEM;
> -
> -	bus_ops->rr = mt7921_rr;
> -	bus_ops->wr = mt7921_wr;
> -	bus_ops->rmw = mt7921_rmw;
> -	dev->mt76.bus = bus_ops;
> -
>   	mt76_dma_attach(&dev->mt76);
>   
>   	ret = mt7921_dma_disable(dev, true);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> index 8b674e042568..63e3c7ef5e89 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
> @@ -443,6 +443,7 @@ int mt7921e_mcu_init(struct mt7921_dev *dev);
>   int mt7921s_wfsys_reset(struct mt7921_dev *dev);
>   int mt7921s_mac_reset(struct mt7921_dev *dev);
>   int mt7921s_init_reset(struct mt7921_dev *dev);
> +int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
>   int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
>   int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
>   
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> index 1ae0d5826ca7..a0c82d19c4d9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -121,6 +121,110 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
>   	mt76_free_device(&dev->mt76);
>   }
>   
> +static u32 __mt7921_reg_addr(struct mt7921_dev *dev, u32 addr)
> +{
> +	static const struct {
> +		u32 phys;
> +		u32 mapped;
> +		u32 size;
> +	} fixed_map[] = {
> +		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
> +		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
> +		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
> +		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
> +		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
> +		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
> +		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
> +		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
> +		{ 0x00400000, 0x80000, 0x10000 }, /* WF_MCU_SYSRAM */
> +		{ 0x00410000, 0x90000, 0x10000 }, /* WF_MCU_SYSRAM (configure register) */
> +		{ 0x40000000, 0x70000, 0x10000 }, /* WF_UMAC_SYSRAM */
> +		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
> +		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
> +		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
> +		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
> +		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
> +		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
> +		{ 0x7c060000, 0xe0000, 0x10000 }, /* CONN_INFRA, conn_host_csr_top */
> +		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
> +		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
> +		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
> +		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
> +		{ 0x820cc000, 0x0e000, 0x1000 }, /* WF_UMAC_TOP (PP) */
> +		{ 0x820cd000, 0x0f000, 0x1000 }, /* WF_MDP_TOP */
> +		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
> +		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
> +		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
> +		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
> +		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
> +		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
> +		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
> +		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
> +		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
> +		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
> +		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
> +		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
> +		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
> +		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
> +		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
> +		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
> +		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
> +		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
> +		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
> +	};
> +	int i;
> +
> +	if (addr < 0x100000)
> +		return addr;
> +
> +	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
> +		u32 ofs;
> +
> +		if (addr < fixed_map[i].phys)
> +			continue;
> +
> +		ofs = addr - fixed_map[i].phys;
> +		if (ofs > fixed_map[i].size)
> +			continue;
> +
> +		return fixed_map[i].mapped + ofs;
> +	}
> +
> +	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
> +	    (addr >= 0x70000000 && addr < 0x78000000) ||
> +	    (addr >= 0x7c000000 && addr < 0x7c400000))
> +		return mt7921_reg_map_l1(dev, addr);
> +
> +	dev_err(dev->mt76.dev, "Access currently unsupported address %08x\n",
> +		addr);
> +
> +	return 0;
> +}
> +
> +static u32 mt7921_rr(struct mt76_dev *mdev, u32 offset)
> +{
> +	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
> +	u32 addr = __mt7921_reg_addr(dev, offset);
> +
> +	return dev->bus_ops->rr(mdev, addr);
> +}
> +
> +static void mt7921_wr(struct mt76_dev *mdev, u32 offset, u32 val)
> +{
> +	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
> +	u32 addr = __mt7921_reg_addr(dev, offset);
> +
> +	dev->bus_ops->wr(mdev, addr, val);
> +}
> +
> +static u32 mt7921_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
> +{
> +	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
> +	u32 addr = __mt7921_reg_addr(dev, offset);
> +
> +	return dev->bus_ops->rmw(mdev, addr, mask, val);
> +}
> +
>   static int mt7921_pci_probe(struct pci_dev *pdev,
>   			    const struct pci_device_id *id)
>   {
> @@ -152,6 +256,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>   		.fw_own = mt7921e_mcu_fw_pmctrl,
>   	};
>   
> +	struct mt76_bus_ops *bus_ops;
>   	struct mt7921_dev *dev;
>   	struct mt76_dev *mdev;
>   	int ret;
> @@ -189,6 +294,25 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>   
>   	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
>   	tasklet_init(&dev->irq_tasklet, mt7921_irq_tasklet, (unsigned long)dev);
> +
> +	dev->phy.dev = dev;
> +	dev->phy.mt76 = &dev->mt76.phy;
> +	dev->mt76.phy.priv = &dev->phy;
> +	dev->bus_ops = dev->mt76.bus;
> +	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
> +			       GFP_KERNEL);
> +	if (!bus_ops)
> +		return -ENOMEM;
> +
> +	bus_ops->rr = mt7921_rr;
> +	bus_ops->wr = mt7921_wr;
> +	bus_ops->rmw = mt7921_rmw;
> +	dev->mt76.bus = bus_ops;
> +
> +	ret = __mt7921e_mcu_drv_pmctrl(dev);
> +	if (ret)
> +		return ret;
> +
>   	mdev->rev = (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
>   		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
>   	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> index f9e350b67fdc..36669e5aeef3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> @@ -59,10 +59,8 @@ int mt7921e_mcu_init(struct mt7921_dev *dev)
>   	return err;
>   }
>   
> -int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> +int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
>   {
> -	struct mt76_phy *mphy = &dev->mt76.phy;
> -	struct mt76_connac_pm *pm = &dev->pm;
>   	int i, err = 0;
>   
>   	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
> @@ -75,9 +73,21 @@ int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
>   	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
>   		dev_err(dev->mt76.dev, "driver own failed\n");
>   		err = -EIO;
> -		goto out;
>   	}
>   
> +	return err;
> +}
> +
> +int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
> +{
> +	struct mt76_phy *mphy = &dev->mt76.phy;
> +	struct mt76_connac_pm *pm = &dev->pm;
> +	int err;
> +
> +	err = __mt7921e_mcu_drv_pmctrl(dev);
> +	if (err < 0)
> +		goto out;
> +
>   	mt7921_wpdma_reinit_cond(dev);
>   	clear_bit(MT76_STATE_PM, &mphy->state);
>   


