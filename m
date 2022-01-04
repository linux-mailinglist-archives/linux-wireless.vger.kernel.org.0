Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB66483E22
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jan 2022 09:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiADIc3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jan 2022 03:32:29 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49129 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiADIc2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jan 2022 03:32:28 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D27C06000C;
        Tue,  4 Jan 2022 08:32:23 +0000 (UTC)
Date:   Tue, 4 Jan 2022 09:32:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH 1/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O
 operations
Message-ID: <20220104093221.6414aab9@xps13>
In-Reply-To: <299bf6ed-80e6-ad15-8dc7-5ededaca15c5@gmail.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
        <20211223002225.3738385-2-f.fainelli@gmail.com>
        <20220103174953.40d7fa52@xps13>
        <299bf6ed-80e6-ad15-8dc7-5ededaca15c5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Florian,

f.fainelli@gmail.com wrote on Mon, 3 Jan 2022 09:24:26 -0800:

> On 1/3/2022 8:49 AM, Miquel Raynal wrote:
> > Hi Florian,
> > 
> > f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:17 -0800:
> >   
> >> Allow a brcmnand_soc instance to provide a custom set of I/O operations
> >> which we will require when using this driver on a BCMA bus which is not
> >> directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
> >> to use the SoC operations if provided.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++++--
> >>   drivers/mtd/nand/raw/brcmnand/brcmnand.h | 23 +++++++++++++++++++++++
> >>   2 files changed, 35 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> index f75929783b94..7a1673b1b1af 100644
> >> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> >> @@ -594,13 +594,18 @@ enum {  
> >>   >>   static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)  
> >>   {
> >> +	if (brcmnand_soc_has_ops(ctrl->soc))
> >> +		return brcmnand_soc_read(ctrl->soc, offs);
> >>   	return brcmnand_readl(ctrl->nand_base + offs);
> >>   }  
> >>   >>   static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,  
> >>   				 u32 val)
> >>   {
> >> -	brcmnand_writel(val, ctrl->nand_base + offs);
> >> +	if (brcmnand_soc_has_ops(ctrl->soc))
> >> +		brcmnand_soc_write(ctrl->soc, val, offs);
> >> +	else
> >> +		brcmnand_writel(val, ctrl->nand_base + offs);
> >>   }  
> >>   >>   static int brcmnand_revision_init(struct brcmnand_controller *ctrl)  
> >> @@ -766,13 +771,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,  
> >>   >>   static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)  
> >>   {
> >> +	if (brcmnand_soc_has_ops(ctrl->soc))
> >> +		return brcmnand_soc_read(ctrl->soc, ~0);
> >>   	return __raw_readl(ctrl->nand_fc + word * 4);
> >>   }  
> >>   >>   static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,  
> >>   				     int word, u32 val)
> >>   {
> >> -	__raw_writel(val, ctrl->nand_fc + word * 4);
> >> +	if (brcmnand_soc_has_ops(ctrl->soc))
> >> +		brcmnand_soc_write(ctrl->soc, val, ~0);
> >> +	else
> >> +		__raw_writel(val, ctrl->nand_fc + word * 4);
> >>   }  
> >>   >>   static inline void edu_writel(struct brcmnand_controller *ctrl,  
> >> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> >> index eb498fbe505e..a3f2ad5f6572 100644
> >> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> >> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
> >> @@ -11,12 +11,19 @@  
> >>   >>   struct platform_device;  
> >>   struct dev_pm_ops;
> >> +struct brcmnand_io_ops;  
> >>   >>   struct brcmnand_soc {  
> >>   	bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
> >>   	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
> >>   	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
> >>   				 bool is_param);
> >> +	const struct brcmnand_io_ops *ops;
> >> +};
> >> +
> >> +struct brcmnand_io_ops {
> >> +	u32 (*read_reg)(struct brcmnand_soc *soc, u32 offset);
> >> +	void (*write_reg)(struct brcmnand_soc *soc, u32 val, u32 offset);
> >>   };  
> >>   >>   static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,  
> >> @@ -58,6 +65,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
> >>   		writel_relaxed(val, addr);
> >>   }  
> >>   >> +static inline bool brcmnand_soc_has_ops(struct brcmnand_soc *soc)  
> >> +{
> >> +	return soc && soc->ops && soc->ops->read_reg && soc->ops->write_reg;
> >> +}
> >> +
> >> +static inline u32 brcmnand_soc_read(struct brcmnand_soc *soc, u32 offset)
> >> +{
> >> +	return soc->ops->read_reg(soc, offset);
> >> +}
> >> +
> >> +static inline void brcmnand_soc_write(struct brcmnand_soc *soc, u32 val,
> >> +				      u32 offset)
> >> +{
> >> +	soc->ops->write_reg(soc, val, offset);
> >> +}
> >> +  
> > 
> > It might be worth looking into more optimized ways to do these checks,
> > in particular the read/write_reg ones because you're checking against
> > some static data which cannot be optimized out by the compiler but
> > won't change in the lifetime of the kernel.  
> 
> I suppose I could add an addition if IS_ENABLED(CONFIG_MTD_NAND_BRCMNAND_BCMA) at the front of brcmnand_soc_has_ops(), would that address your concern or you have something else in mind?

I don't like much the #ifdef solution, instead you might think of
static keys, or even better using a regmap. Regmap implementation is
free, you can use either one way or the other and for almost no
overhead compared to the bunch of functions you have here.

Thanks,
Miquèl
