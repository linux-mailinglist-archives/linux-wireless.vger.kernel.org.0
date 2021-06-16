Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186D63A951A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jun 2021 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFPIdm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Jun 2021 04:33:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32955 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhFPIdk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Jun 2021 04:33:40 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15G8VQdnC028089, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15G8VQdnC028089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Jun 2021 16:31:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 16 Jun 2021 16:31:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 16 Jun 2021 16:31:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28]) by
 RTEXMBS04.realtek.com.tw ([fe80::a0a3:e64a:34ad:fe28%5]) with mapi id
 15.01.2106.013; Wed, 16 Jun 2021 16:31:25 +0800
From:   Pkshih <pkshih@realtek.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v4 09/19] rtw89: add pci files
Thread-Topic: [PATCH v4 09/19] rtw89: add pci files
Thread-Index: AQHXPM4t4237yjXWkE2au/031Uoa26sMOfeAgAJeNoA=
Date:   Wed, 16 Jun 2021 08:31:25 +0000
Message-ID: <45dd7da687a444d5acbc13eb67dcee97@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
 <20210429080149.7068-10-pkshih@realtek.com> <YMFzAZUysQ5HxZlK@google.com>
In-Reply-To: <YMFzAZUysQ5HxZlK@google.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.146]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?us-ascii?Q?Clean,_bases:_2021/6/15_=3F=3F_07:44:00?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?us-ascii?Q?Clean,_bases:_2021/6/16_=3F=3F_04:04:00?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/16/2021 08:05:55
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164376 [Jun 16 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/16/2021 08:09:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> -----Original Message-----
> From: Brian Norris [mailto:briannorris@chromium.org]
> Sent: Thursday, June 10, 2021 10:04 AM
> To: Pkshih
> Cc: kvalo@codeaurora.org; linux-wireless@vger.kernel.org
> Subject: Re: [PATCH v4 09/19] rtw89: add pci files
> 
> Hi,
> 
> I'm slowly making my way through this series. I think a lot of this
> looks a lot better than the first rtw88 submission I looked at, so
> that's nice!
> 
> Mostly small notes for this patch, but a few larger questions about IRQ
> handling and NAPI:
> 
> On Thu, Apr 29, 2021 at 04:01:39PM +0800, Ping-Ke Shih wrote:
> > --- /dev/null
> > +++ b/drivers/net/wireless/realtek/rtw89/pci.c
> 
> ...
> 
> > +static void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
> > +				      struct rtw89_pci *rtwpci)
> > +{
> > +	rtwpci->halt_c2h_isrs = rtw89_read32(rtwdev, R_AX_HISR0) & rtwpci->halt_c2h_intrs;
> > +	rtwpci->isrs[0] = rtw89_read32(rtwdev, R_AX_PCIE_HISR00) & rtwpci->intrs[0];
> > +	rtwpci->isrs[1] = rtw89_read32(rtwdev, R_AX_PCIE_HISR10) & rtwpci->intrs[1];
> > +}
> > +
> > +static void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev,
> > +				  struct rtw89_pci *rtwpci)
> > +{
> > +	rtw89_write32(rtwdev, R_AX_HIMR0, rtwpci->halt_c2h_intrs);
> > +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, rtwpci->intrs[0]);
> > +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, rtwpci->intrs[1]);
> > +}
> > +
> > +static void rtw89_pci_enable_intr_unmask0(struct rtw89_dev *rtwdev,
> > +					  struct rtw89_pci *rtwpci, u32 unmask0)
> > +{
> > +	rtwpci->intrs[0] &= ~unmask0;
> 
> I might be misreading something, but I believe "mask" (as in, "mask
> an interrupt") is usually meant as "disable" -- see, for instance, the
> conventions in 'struct irq_chip' -- and this looks like you're using the
> term "unmask" to mean disable. This confuses my reading of code that
> calls this function.
> 
> I'd suggest either swapping the names (unmask vs. mask) or else pick an
> independent name ("rx on" and "rx off"? something based on "on/off",
> "disable/enable"? "set/clear"?).
> 

Understand.
I'll refine the interrupt and NAPI flow (see below), and I suppose these functions
will be removed, so I don't change the names right away.

> > +	rtw89_pci_enable_intr(rtwdev, rtwpci);
> > +}
> > +
> > +static void rtw89_pci_enable_intr_mask0(struct rtw89_dev *rtwdev,
> > +					struct rtw89_pci *rtwpci, u32 mask0)
> > +{
> > +	rtwpci->intrs[0] |= mask0;
> > +	rtw89_pci_enable_intr(rtwdev, rtwpci);
> > +}
> > +
> > +static void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev,
> > +				   struct rtw89_pci *rtwpci)
> > +{
> > +	rtw89_write32(rtwdev, R_AX_HIMR0, 0);
> > +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, 0);
> > +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, 0);
> > +}
> > +
> > +static void rtw89_pci_try_napi_schedule(struct rtw89_dev *rtwdev, u32 *unmask0_rx)
> > +{
> > +	if (*unmask0_rx && !napi_reschedule(&rtwdev->napi)) {
> > +		/* if can't invoke napi, RX_IMR must be off already */
> > +		*unmask0_rx = 0;
> > +	}
> > +}
> > +
> > +static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
> > +{
> > +	struct rtw89_dev *rtwdev = dev;
> > +	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> > +	u32 isrs[2];
> > +	unsigned long flags;
> > +	u32 unmask0_rx = 0;
> > +
> > +	isrs[0] = rtwpci->isrs[0];
> > +	isrs[1] = rtwpci->isrs[1];
> > +
> > +	/* TX ISR */
> > +	if (isrs[0] & B_AX_TXDMA_CH12_INT)
> > +		rtw89_pci_isr_txch_dma(rtwdev, rtwpci, RTW89_TXCH_CH12);
> > +
> > +	/* RX ISR */
> > +	if (isrs[0] & (B_AX_RXDMA_INT | B_AX_RXP1DMA_INT))
> > +		unmask0_rx = B_AX_RXDMA_INTS_MASK;
> > +	if (isrs[0] & B_AX_RPQDMA_INT)
> > +		rtw89_pci_isr_rpq_dma(rtwdev, rtwpci);
> > +	if (isrs[0] & B_AX_RDU_INT) {
> > +		rtw89_pci_isr_rxd_unavail(rtwdev, rtwpci);
> > +		unmask0_rx = B_AX_RXDMA_INTS_MASK;
> > +	}
> > +
> > +	if (rtwpci->halt_c2h_isrs & B_AX_HALT_C2H_INT_EN)
> > +		rtw89_ser_notify(rtwdev, rtw89_mac_get_err_status(rtwdev));
> > +
> > +	/* invoke napi and disable rx_imr within bh_disable, because we must
> > +	 * ensure napi_poll re-enable rx_imr after this.
> > +	 */
> > +	local_bh_disable();
> 
> I'm not sure I understand this; disabling BH isn't enough to ensure NAPI
> contexts aren't running in parallel with this -- that's what a lock is
> for. And, you're already holding irq_lock.
> 
> The other part of this problem (I think) is that you have the ordering
> wrong here -- don't you want to set the interrupt state *before*
> scheduling NAPI? That way, if an RX event comes while we're doing this,
> we know that either the NAPI context is still running or scheduled (and
> will re-enable the RX interrupt when done), or else we're going to
> schedule a new poll (which will eventually re-enable the interrupt).
> 
> In other words, I think you should
> 1. drop the BH disable/enable
> 2. set the interrupt state first, followed by napi_schedule() (if there
>    was an RX IRQ pending)
> 3. stop trying to look at the napi_reschedule() return value (i.e., just
>    use napi_schedule())
> 
> Am I missing something? I'm just trying to reason through the code here;
> I haven't stress-tested my suggestsions or anything, nor experienced
> whatever problem you were trying to solve here.

By your suggestions, I trace the flow and picture them below:

int_handler             int_threadfn              napi_poll
-----------             ------------              ---------
    |
    |
    | 1) dis. intr
    | 2) read status
    o                      |
                           | 3) do TX reclaim
                           | 4) check if RX?
                           | 5) re-enable intr
                           |    (RX is optional)
                           | 6) schedule_napi
                           |    (if RX)
                           : >>>-------------------+ 7) (tasklet start immediately)
                           :                       | 
                           :                       | 8) do RX things
                           :                       | 9) re-enable intr of RX
                           :                       |
                           : <<<-------------------o
                           :
                           o

In my preliminary test, it works as above flow normally.
But, three exceptions
1. interrupt is still triggered, even we disable interrupt by step 1).
   That means int_handler is executed again, but threadfn doesn't enable
   interrupt yet.
   This is because interrupt event is on the way to host (I think the path is
   long -- from WiFi MAC to PCI MAC to PCI bus to host).
   There's race condition between disable interrupt and interrupt event.

   I don't plan to fix the race condition, but make the driver handle it properly.

2. napi_poll doesn't start immediately at the step 7).
   I don't trace the reason yet, but I think it's reasonable that
   int_threadfn and napi_poll can be ansynchronous.
   Because napi_poll can run in threaded mode as well.

3. Since int_threadfn and napi_poll are ansynchronous (similar to exception 2),
   it looks like napi_poll is done before int_threadfn in some situations.

I'll make the driver handle these cases in next submission (v6).

Another thing is I need to do local_bh_disable() before calling napi_schedule(),
or kernel warns " NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!"
I think this is because __napi_schedule() does local_irq_save(), not very sure.

I investigate other drivers that use napi_schedule() also do local_bh_disable()
before calling napi_schedule(), or do spin_lock_bh(), or in bh context. I think
these are equivalent. 

> 
> > +	spin_lock_irqsave(&rtwpci->irq_lock, flags);
> > +	rtw89_pci_try_napi_schedule(rtwdev, &unmask0_rx);
> > +	if (rtwpci->running) {
> > +		rtw89_pci_clear_intrs(rtwdev, rtwpci);
> > +		rtw89_pci_enable_intr_unmask0(rtwdev, rtwpci, unmask0_rx);
> > +	}
> > +	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
> > +	local_bh_enable();
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> ...
> 
> > +static u32 rtw89_pci_ops_read32_cmac(struct rtw89_dev *rtwdev, u32 addr)
> > +{
> > +	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> > +	u32 val = readl(rtwpci->mmap + addr);
> > +	int count;
> > +
> > +	for (count = 0; ; count++) {
> > +		if (val != RTW89_R32_DEAD)
> > +			return val;
> > +		if (count >= MAC_REG_POOL_COUNT) {
> > +			rtw89_warn(rtwdev, "addr 0x%x = 0xdeadbeef\n", addr);
> 
> I understand this is a constant, but it might be better to either
> stringify the macro:
> 
> 			rtw89_warn(rtwdev, "addr %#x = " #RTW89_R32_DEAD "\n", addr);
> 
> or just use val:
> 
> 			rtw89_warn(rtwdev, "addr %#x = %#x\n", addr, val);
> 

Will do it.

> > +			return RTW89_R32_DEAD;
> > +		}
> > +		rtw89_pci_ops_write32(rtwdev, R_AX_CK_EN, B_AX_CMAC_ALLCKEN);
> > +		val = readl(rtwpci->mmap + addr);
> > +	}
> > +
> > +	return val;
> > +}
> 
> ...
> 
> > +static int
> > +rtw89_read16_mdio(struct rtw89_dev *rtwdev, u8 addr, u8 speed, u16 *val)
> > +{
> > +	int ret;
> > +
> > +	ret = rtw89_pci_check_mdio(rtwdev, addr, speed, B_AX_MDIO_RFLAG);
> > +	if (ret) {
> > +		rtw89_err(rtwdev, "[ERR]MDIO R16 0x%X fail!\n", addr);
> 
> Dump |ret|?

Okay

> 
> > +		return ret;
> > +	}
> > +	*val = rtw89_read16(rtwdev, R_AX_MDIO_RDATA);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int rtw89_dbi_read8(struct rtw89_dev *rtwdev, u16 addr, u8 *value)
> > +{
> > +	u16 read_addr = addr & B_AX_DBI_ADDR_MSK;
> > +	u8 flag;
> > +	int ret;
> > +
> > +	rtw89_write16(rtwdev, R_AX_DBI_FLAG, read_addr);
> > +	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_RFLAG >> 16);
> > +
> > +	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
> > +				       10 * RTW89_PCI_WR_RETRY_CNT, false,
> > +				       rtwdev, R_AX_DBI_FLAG + 2);
> > +
> > +	if (!ret) {
> > +		read_addr = R_AX_DBI_RDATA + (addr & 3);
> > +		*value = rtw89_read8(rtwdev, read_addr);
> > +	} else {
> > +		WARN(1, "failed to read DBI register, addr=0x%04x\n", addr);
> > +		ret =  -EIO;
> 
> You've got some weird whitespace here and a few other places. Search for
> the string "=  " (2 spaces) -- there should only be 1.

Fixed

> 
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +__get_target(struct rtw89_dev *rtwdev, u16 *target, enum rtw89_pcie_phy phy_rate)
> > +{
> > +	u16 val, tar;
> > +	int ret;
> > +
> > +	/* Enable counter */
> > +	ret = rtw89_read16_mdio(rtwdev, RAC_CTRL_PPR_V1, phy_rate, &val);
> > +	if (ret)
> > +		return ret;
> > +	ret = rtw89_write16_mdio(rtwdev, RAC_CTRL_PPR_V1, val & ~BIT(12),
> 
> You mostly do a good job on using macros with meaningful names instead
> of magic numbers, but you've still got quite a few uses of BIT() that
> probably should be macros. I'd suggest taking another pass through this
> driver for usages of raw BIT() and GENMASK(), and see where it's
> reasonable to add macro names (either in the .c file if it's a very
> local usage, or just add to the .h next to the register definitions).

I fix pci.c first, and I will pass through whole driver in next submission.

> 
> > +				 phy_rate);
> ...
> > +}
> > +
> > +static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
> > +{
> > +	enum rtw89_pcie_phy phy_rate;
> > +	u16 val16, mgn_set, div_set, tar;
> > +	u8 val8, bdr_ori;
> > +	bool l1_flag = false;
> > +	int ret = 0;
> > +
> > +	ret = rtw89_dbi_read8(rtwdev, RTW89_PCIE_PHY_RATE, &val8);
> > +	if (ret) {
> > +		rtw89_err(rtwdev, "[ERR]dbi_r8_pcie %X\n", RTW89_PCIE_PHY_RATE);
> > +		return ret;
> > +	}
> > +
> > +	if (FIELD_GET(GENMASK(1, 0), val8) == 0x1) {
> > +		phy_rate = PCIE_PHY_GEN1;
> > +	} else if (FIELD_GET(GENMASK(1, 0), val8) == 0x2) {
> > +		phy_rate = PCIE_PHY_GEN2;
> > +	} else {
> > +		rtw89_err(rtwdev, "[ERR]PCIe PHY rate not support\n");
> 
> Dump the value of |val8| in this error message? Also, this probably
> makes more sense as "not supported".

Added.

> 
> > +		return -EOPNOTSUPP;
> > +	}
> ...
> > +	/*  Obtain div and margin */
> 
> Extra space.

Fixed

> 
> ...
> 
> > +static int rtw89_pci_napi_poll(struct napi_struct *napi, int budget)
> > +{
> > +	struct rtw89_dev *rtwdev = container_of(napi, struct rtw89_dev, napi);
> > +	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> > +	unsigned long flags;
> > +	u32 cnt;
> > +	int ret;
> > +
> > +	ret = rtw89_pci_poll_rxq_dma(rtwdev, rtwpci, budget);
> > +	if (ret < budget) {
> > +		napi_complete_done(napi, ret);
> > +
> > +		cnt = rtw89_pci_rxbd_recalc(rtwdev, &rtwpci->rx_rings[RTW89_RXCH_RXQ]);
> > +		if (cnt && napi_reschedule(napi))
> > +			return ret;
> > +
> > +		spin_lock_irqsave(&rtwpci->irq_lock, flags);
> > +		if (rtwpci->running) {
> > +			rtw89_pci_clear_intrs(rtwdev, rtwpci);
> 
> Do you really want to clear interrupts here? I'm not that familiar with
> the hardware here or anything, but that seems like a job for your ISR,
> not the NAPI poll. It also seems like you might double-clear interrupts
> without properly handling them, because you only called
> rtw89_pci_recognize_intrs() in the ISR, not here.

This chip is an edge-trigger interrupt, so originally I'd like to make "(IMR & ISR)"
become 0, and then next RX packet can trigger the interrupt.
But, it seems that enable RX interrupt (step 9 of above picture) can already 
raise interrupt.

> 
> > +			rtw89_pci_enable_intr_mask0(rtwdev, rtwpci, B_AX_RXDMA_INTS_MASK);
> > +		}
> > +		spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
> > +	}
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > +static void rtw89_pci_remove(struct pci_dev *pdev)
> > +{
> > +	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
> > +	struct rtw89_dev *rtwdev;
> > +
> > +	if (!hw)
> > +		return;
> 
> Is this even possible (hw==NULL)? You always "set" this when probe() is
> successful, so remove() should only be called with a non-NULL drvdata.

Removed.
I have confirmed if probe() is unsuccessful, kernel won't call remove().

> 
> > +
> > +	rtwdev = hw->priv;
> > +
> > +	rtw89_pci_free_irq(rtwdev, pdev);
> > +	rtw89_core_napi_deinit(rtwdev);
> > +	rtw89_core_unregister(rtwdev);
> > +	rtw89_pci_clear_resource(rtwdev, pdev);
> > +	rtw89_pci_declaim_device(rtwdev, pdev);
> > +	rtw89_core_deinit(rtwdev);
> > +	ieee80211_free_hw(hw);
> > +}
> 
> Brian
> ------Please consider the environment before printing this e-mail.
