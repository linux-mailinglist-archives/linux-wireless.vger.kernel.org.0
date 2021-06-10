Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099583A221E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 04:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFJCG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Jun 2021 22:06:57 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:45819 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFJCG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Jun 2021 22:06:56 -0400
Received: by mail-pf1-f174.google.com with SMTP id d16so278858pfn.12
        for <linux-wireless@vger.kernel.org>; Wed, 09 Jun 2021 19:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zdw1SrBxDmJJD2ZCcEw+rVW7e/8vKW3scxCdeYBPe1Q=;
        b=bZPtD9KB1EL6ct85yjFUyBQjIpvdLYnvojQeHO4jtYN1VdQJEZVL9+cEqlsb28FdVh
         uvaMd5HotZ0s5WcIxkjsNWUDrAS3TmE5P/K7J0/0GW/w9Am0Nr2Bmd0xGxOlHY1juvA+
         oxp0YfNfBf/J2V+CBUW53E7mDyvTGvkzuOkA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zdw1SrBxDmJJD2ZCcEw+rVW7e/8vKW3scxCdeYBPe1Q=;
        b=SJb1ldvN7nSKsshaHYy782VWomoZBvX60ulNSZhB3TAl+EazmK2eIIGl7UoNIxr2Br
         CWmhV9e12B/ShtB4dGRLveRtbi1w87rtZZigbYPUsUYkFAmI3vMdHrchT+UAkkhGbIDf
         eSWizZCQceaClB6s0WShHpz/5vzjeO2Vgzmfu/gcwWEBUMaxFViIZdoe2fBHSHbRkecT
         QgCvFuI8+lOCD8E7Gj5uhlVrRB5ridHErIn3oa+aQ8BOVXtWmrjoeisr1GkikJTdRQp2
         yCjMUfP/rik9NrFkbJQnhbs1TKgkQ9caW4ezWj0iCjj7RoPx+aupaXrzVX5e3vMRfNgz
         D7bg==
X-Gm-Message-State: AOAM531Lzqhd2gEePyPYe53yhXTYAmNMILit5fhz8XiSBwBAzlqgmxoB
        fpE90baQGXzl05p1/c8pqy1GiQ==
X-Google-Smtp-Source: ABdhPJwxyp7BLXOkigLxPElzGwr/uKehR+ojOA8JhZi24GKtXrOPqIsF47Wwp3YkcaJ1TkZYzmCmPA==
X-Received: by 2002:a62:76d1:0:b029:2e9:e128:2f89 with SMTP id r200-20020a6276d10000b02902e9e1282f89mr628188pfc.59.1623290629021;
        Wed, 09 Jun 2021 19:03:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:5af8:21cc:34ee:7360])
        by smtp.gmail.com with ESMTPSA id w21sm701000pfq.143.2021.06.09.19.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 19:03:48 -0700 (PDT)
Date:   Wed, 9 Jun 2021 19:03:45 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 09/19] rtw89: add pci files
Message-ID: <YMFzAZUysQ5HxZlK@google.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
 <20210429080149.7068-10-pkshih@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429080149.7068-10-pkshih@realtek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm slowly making my way through this series. I think a lot of this
looks a lot better than the first rtw88 submission I looked at, so
that's nice!

Mostly small notes for this patch, but a few larger questions about IRQ
handling and NAPI:

On Thu, Apr 29, 2021 at 04:01:39PM +0800, Ping-Ke Shih wrote:
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw89/pci.c

...

> +static void rtw89_pci_recognize_intrs(struct rtw89_dev *rtwdev,
> +				      struct rtw89_pci *rtwpci)
> +{
> +	rtwpci->halt_c2h_isrs = rtw89_read32(rtwdev, R_AX_HISR0) & rtwpci->halt_c2h_intrs;
> +	rtwpci->isrs[0] = rtw89_read32(rtwdev, R_AX_PCIE_HISR00) & rtwpci->intrs[0];
> +	rtwpci->isrs[1] = rtw89_read32(rtwdev, R_AX_PCIE_HISR10) & rtwpci->intrs[1];
> +}
> +
> +static void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev,
> +				  struct rtw89_pci *rtwpci)
> +{
> +	rtw89_write32(rtwdev, R_AX_HIMR0, rtwpci->halt_c2h_intrs);
> +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, rtwpci->intrs[0]);
> +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, rtwpci->intrs[1]);
> +}
> +
> +static void rtw89_pci_enable_intr_unmask0(struct rtw89_dev *rtwdev,
> +					  struct rtw89_pci *rtwpci, u32 unmask0)
> +{
> +	rtwpci->intrs[0] &= ~unmask0;

I might be misreading something, but I believe "mask" (as in, "mask
an interrupt") is usually meant as "disable" -- see, for instance, the
conventions in 'struct irq_chip' -- and this looks like you're using the
term "unmask" to mean disable. This confuses my reading of code that
calls this function.

I'd suggest either swapping the names (unmask vs. mask) or else pick an
independent name ("rx on" and "rx off"? something based on "on/off",
"disable/enable"? "set/clear"?).

> +	rtw89_pci_enable_intr(rtwdev, rtwpci);
> +}
> +
> +static void rtw89_pci_enable_intr_mask0(struct rtw89_dev *rtwdev,
> +					struct rtw89_pci *rtwpci, u32 mask0)
> +{
> +	rtwpci->intrs[0] |= mask0;
> +	rtw89_pci_enable_intr(rtwdev, rtwpci);
> +}
> +
> +static void rtw89_pci_disable_intr(struct rtw89_dev *rtwdev,
> +				   struct rtw89_pci *rtwpci)
> +{
> +	rtw89_write32(rtwdev, R_AX_HIMR0, 0);
> +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR00, 0);
> +	rtw89_write32(rtwdev, R_AX_PCIE_HIMR10, 0);
> +}
> +
> +static void rtw89_pci_try_napi_schedule(struct rtw89_dev *rtwdev, u32 *unmask0_rx)
> +{
> +	if (*unmask0_rx && !napi_reschedule(&rtwdev->napi)) {
> +		/* if can't invoke napi, RX_IMR must be off already */
> +		*unmask0_rx = 0;
> +	}
> +}
> +
> +static irqreturn_t rtw89_pci_interrupt_threadfn(int irq, void *dev)
> +{
> +	struct rtw89_dev *rtwdev = dev;
> +	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> +	u32 isrs[2];
> +	unsigned long flags;
> +	u32 unmask0_rx = 0;
> +
> +	isrs[0] = rtwpci->isrs[0];
> +	isrs[1] = rtwpci->isrs[1];
> +
> +	/* TX ISR */
> +	if (isrs[0] & B_AX_TXDMA_CH12_INT)
> +		rtw89_pci_isr_txch_dma(rtwdev, rtwpci, RTW89_TXCH_CH12);
> +
> +	/* RX ISR */
> +	if (isrs[0] & (B_AX_RXDMA_INT | B_AX_RXP1DMA_INT))
> +		unmask0_rx = B_AX_RXDMA_INTS_MASK;
> +	if (isrs[0] & B_AX_RPQDMA_INT)
> +		rtw89_pci_isr_rpq_dma(rtwdev, rtwpci);
> +	if (isrs[0] & B_AX_RDU_INT) {
> +		rtw89_pci_isr_rxd_unavail(rtwdev, rtwpci);
> +		unmask0_rx = B_AX_RXDMA_INTS_MASK;
> +	}
> +
> +	if (rtwpci->halt_c2h_isrs & B_AX_HALT_C2H_INT_EN)
> +		rtw89_ser_notify(rtwdev, rtw89_mac_get_err_status(rtwdev));
> +
> +	/* invoke napi and disable rx_imr within bh_disable, because we must
> +	 * ensure napi_poll re-enable rx_imr after this.
> +	 */
> +	local_bh_disable();

I'm not sure I understand this; disabling BH isn't enough to ensure NAPI
contexts aren't running in parallel with this -- that's what a lock is
for. And, you're already holding irq_lock.

The other part of this problem (I think) is that you have the ordering
wrong here -- don't you want to set the interrupt state *before*
scheduling NAPI? That way, if an RX event comes while we're doing this,
we know that either the NAPI context is still running or scheduled (and
will re-enable the RX interrupt when done), or else we're going to
schedule a new poll (which will eventually re-enable the interrupt).

In other words, I think you should
1. drop the BH disable/enable
2. set the interrupt state first, followed by napi_schedule() (if there
   was an RX IRQ pending)
3. stop trying to look at the napi_reschedule() return value (i.e., just
   use napi_schedule())

Am I missing something? I'm just trying to reason through the code here;
I haven't stress-tested my suggestsions or anything, nor experienced
whatever problem you were trying to solve here.

> +	spin_lock_irqsave(&rtwpci->irq_lock, flags);
> +	rtw89_pci_try_napi_schedule(rtwdev, &unmask0_rx);
> +	if (rtwpci->running) {
> +		rtw89_pci_clear_intrs(rtwdev, rtwpci);
> +		rtw89_pci_enable_intr_unmask0(rtwdev, rtwpci, unmask0_rx);
> +	}
> +	spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
> +	local_bh_enable();
> +
> +	return IRQ_HANDLED;
> +}

...

> +static u32 rtw89_pci_ops_read32_cmac(struct rtw89_dev *rtwdev, u32 addr)
> +{
> +	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> +	u32 val = readl(rtwpci->mmap + addr);
> +	int count;
> +
> +	for (count = 0; ; count++) {
> +		if (val != RTW89_R32_DEAD)
> +			return val;
> +		if (count >= MAC_REG_POOL_COUNT) {
> +			rtw89_warn(rtwdev, "addr 0x%x = 0xdeadbeef\n", addr);

I understand this is a constant, but it might be better to either
stringify the macro:

			rtw89_warn(rtwdev, "addr %#x = " #RTW89_R32_DEAD "\n", addr);

or just use val:

			rtw89_warn(rtwdev, "addr %#x = %#x\n", addr, val);

> +			return RTW89_R32_DEAD;
> +		}
> +		rtw89_pci_ops_write32(rtwdev, R_AX_CK_EN, B_AX_CMAC_ALLCKEN);
> +		val = readl(rtwpci->mmap + addr);
> +	}
> +
> +	return val;
> +}

...

> +static int
> +rtw89_read16_mdio(struct rtw89_dev *rtwdev, u8 addr, u8 speed, u16 *val)
> +{
> +	int ret;
> +
> +	ret = rtw89_pci_check_mdio(rtwdev, addr, speed, B_AX_MDIO_RFLAG);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]MDIO R16 0x%X fail!\n", addr);

Dump |ret|?

> +		return ret;
> +	}
> +	*val = rtw89_read16(rtwdev, R_AX_MDIO_RDATA);
> +
> +	return 0;
> +}

...

> +static int rtw89_dbi_read8(struct rtw89_dev *rtwdev, u16 addr, u8 *value)
> +{
> +	u16 read_addr = addr & B_AX_DBI_ADDR_MSK;
> +	u8 flag;
> +	int ret;
> +
> +	rtw89_write16(rtwdev, R_AX_DBI_FLAG, read_addr);
> +	rtw89_write8(rtwdev, R_AX_DBI_FLAG + 2, B_AX_DBI_RFLAG >> 16);
> +
> +	ret = read_poll_timeout_atomic(rtw89_read8, flag, !flag, 10,
> +				       10 * RTW89_PCI_WR_RETRY_CNT, false,
> +				       rtwdev, R_AX_DBI_FLAG + 2);
> +
> +	if (!ret) {
> +		read_addr = R_AX_DBI_RDATA + (addr & 3);
> +		*value = rtw89_read8(rtwdev, read_addr);
> +	} else {
> +		WARN(1, "failed to read DBI register, addr=0x%04x\n", addr);
> +		ret =  -EIO;

You've got some weird whitespace here and a few other places. Search for
the string "=  " (2 spaces) -- there should only be 1.

> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +__get_target(struct rtw89_dev *rtwdev, u16 *target, enum rtw89_pcie_phy phy_rate)
> +{
> +	u16 val, tar;
> +	int ret;
> +
> +	/* Enable counter */
> +	ret = rtw89_read16_mdio(rtwdev, RAC_CTRL_PPR_V1, phy_rate, &val);
> +	if (ret)
> +		return ret;
> +	ret = rtw89_write16_mdio(rtwdev, RAC_CTRL_PPR_V1, val & ~BIT(12),

You mostly do a good job on using macros with meaningful names instead
of magic numbers, but you've still got quite a few uses of BIT() that
probably should be macros. I'd suggest taking another pass through this
driver for usages of raw BIT() and GENMASK(), and see where it's
reasonable to add macro names (either in the .c file if it's a very
local usage, or just add to the .h next to the register definitions).

> +				 phy_rate);
...
> +}
> +
> +static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
> +{
> +	enum rtw89_pcie_phy phy_rate;
> +	u16 val16, mgn_set, div_set, tar;
> +	u8 val8, bdr_ori;
> +	bool l1_flag = false;
> +	int ret = 0;
> +
> +	ret = rtw89_dbi_read8(rtwdev, RTW89_PCIE_PHY_RATE, &val8);
> +	if (ret) {
> +		rtw89_err(rtwdev, "[ERR]dbi_r8_pcie %X\n", RTW89_PCIE_PHY_RATE);
> +		return ret;
> +	}
> +
> +	if (FIELD_GET(GENMASK(1, 0), val8) == 0x1) {
> +		phy_rate = PCIE_PHY_GEN1;
> +	} else if (FIELD_GET(GENMASK(1, 0), val8) == 0x2) {
> +		phy_rate = PCIE_PHY_GEN2;
> +	} else {
> +		rtw89_err(rtwdev, "[ERR]PCIe PHY rate not support\n");

Dump the value of |val8| in this error message? Also, this probably
makes more sense as "not supported".

> +		return -EOPNOTSUPP;
> +	}
...
> +	/*  Obtain div and margin */

Extra space.

...

> +static int rtw89_pci_napi_poll(struct napi_struct *napi, int budget)
> +{
> +	struct rtw89_dev *rtwdev = container_of(napi, struct rtw89_dev, napi);
> +	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
> +	unsigned long flags;
> +	u32 cnt;
> +	int ret;
> +
> +	ret = rtw89_pci_poll_rxq_dma(rtwdev, rtwpci, budget);
> +	if (ret < budget) {
> +		napi_complete_done(napi, ret);
> +
> +		cnt = rtw89_pci_rxbd_recalc(rtwdev, &rtwpci->rx_rings[RTW89_RXCH_RXQ]);
> +		if (cnt && napi_reschedule(napi))
> +			return ret;
> +
> +		spin_lock_irqsave(&rtwpci->irq_lock, flags);
> +		if (rtwpci->running) {
> +			rtw89_pci_clear_intrs(rtwdev, rtwpci);

Do you really want to clear interrupts here? I'm not that familiar with
the hardware here or anything, but that seems like a job for your ISR,
not the NAPI poll. It also seems like you might double-clear interrupts
without properly handling them, because you only called
rtw89_pci_recognize_intrs() in the ISR, not here.

> +			rtw89_pci_enable_intr_mask0(rtwdev, rtwpci, B_AX_RXDMA_INTS_MASK);
> +		}
> +		spin_unlock_irqrestore(&rtwpci->irq_lock, flags);
> +	}
> +
> +	return ret;
> +}

...

> +static void rtw89_pci_remove(struct pci_dev *pdev)
> +{
> +	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
> +	struct rtw89_dev *rtwdev;
> +
> +	if (!hw)
> +		return;

Is this even possible (hw==NULL)? You always "set" this when probe() is
successful, so remove() should only be called with a non-NULL drvdata.

> +
> +	rtwdev = hw->priv;
> +
> +	rtw89_pci_free_irq(rtwdev, pdev);
> +	rtw89_core_napi_deinit(rtwdev);
> +	rtw89_core_unregister(rtwdev);
> +	rtw89_pci_clear_resource(rtwdev, pdev);
> +	rtw89_pci_declaim_device(rtwdev, pdev);
> +	rtw89_core_deinit(rtwdev);
> +	ieee80211_free_hw(hw);
> +}

Brian
