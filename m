Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5D1C5496
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEELm1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 07:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEELm1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 07:42:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66954C061A0F
        for <linux-wireless@vger.kernel.org>; Tue,  5 May 2020 04:42:27 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jVvxw-00053O-9i; Tue, 05 May 2020 13:42:24 +0200
Date:   Tue, 5 May 2020 13:42:24 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH 26/40] rtw88: 8723d: add IQ calibration
Message-ID: <20200505114224.e2jdqf5wiyu62575@linutronix.de>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-27-yhchuang@realtek.com>
 <20200430150206.3bw7lp7wslgeuaqx@linutronix.de>
 <feb792d067fc4319a2a1c294ac3bfc6f@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <feb792d067fc4319a2a1c294ac3bfc6f@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-04 09:45:48 [+0000], Tony Chuang wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> > On 2020-04-17 15:46:39 [+0800], yhchuang@realtek.com wrote:
> > > diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > > index 94784c7f0743..b66bd969e007 100644
> > > --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > > +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> > …
> > > +struct iqk_backup_regs {
> > > +	u32 adda[IQK_ADDA_REG_NUM];
> > > +	u8 mac8[IQK_MAC8_REG_NUM];
> > > +	u32 mac32[IQK_MAC32_REG_NUM];
> > > +	u32 bb[IQK_BB_REG_NUM];
> > > +
> > > +	u32 lte_path;
> > > +	u32 lte_gnt;
> > > +
> > > +	u8 btg_sel;
> > > +	u32 bb_sel_btg;
> > > +
> > > +	u8 igia;
> > > +	u8 igib;
> > 
> > The struct has 128 bytes. Putting btg_sel after bb_sel_btg will result
> > in 124 bytes. How likely is it that it will grow? I'm asking because it
> > is allocated on stack.
> 
> We need to backup a lot of the register values for doing IQK.
> I think it's inevitable, just about where should we put them.
> And as there's only 8723D is using SW IQK, this struct will only be
> used by 8723D, so add them into rtwdev is not suitable.
> 
> Another way is that we can kmalloc() and then kfree() it after
> IQK is done.

I'm not saying that it is a problem now, just pointing out that in the
end you store ~256 bytes on the stack. So if it remains in that size, it
should be okay but if it grows further then it might become problematic.
In the end you have 8KiB of stack and as I said, I have no idea how deep
you are right now.

> > > +};
> > > +
> > > +static void rtw8723d_iqk_backup_regs(struct rtw_dev *rtwdev,
> > > +				     struct iqk_backup_regs *backup)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < IQK_ADDA_REG_NUM; i++)
> > > +		backup->adda[i] = rtw_read32(rtwdev, iqk_adda_regs[i]);
> > > +
> > > +	for (i = 0; i < IQK_MAC8_REG_NUM; i++)
> > > +		backup->mac8[i] = rtw_read8(rtwdev, iqk_mac8_regs[i]);
> > > +	for (i = 0; i < IQK_MAC32_REG_NUM; i++)
> > > +		backup->mac32[i] = rtw_read32(rtwdev, iqk_mac32_regs[i]);
> > > +
> > > +	for (i = 0; i < IQK_BB_REG_NUM; i++)
> > > +		backup->bb[i] = rtw_read32(rtwdev, iqk_bb_regs[i]);
> > > +
> > > +	backup->igia = (u8)rtw_read32_mask(rtwdev, REG_OFDM0_XAAGC1,
> > MASKBYTE0);
> > > +	backup->igib = (u8)rtw_read32_mask(rtwdev, REG_OFDM0_XBAGC1,
> > MASKBYTE0);
> > 
> > igi[ab] is alreay u8, no need for cast.
> 
> It's because rtw_read32_mask() returns u32, but because we
> mask with one byte only.

Right. However I don't think that it makes any difference in this case.

> > 
> > > +
> > > +	backup->bb_sel_btg = rtw_read32(rtwdev, REG_BB_SEL_BTG);
> > > +}
> > …
> > 
> > > +static u8 rtw8723d_iqk_rx_path(struct rtw_dev *rtwdev,
> > > +			       const struct rtw_8723d_iqk_cfg *iqk_cfg,
> > > +			       const struct iqk_backup_regs *backup)
> > > +{
> > > +	u32 tx_x, tx_y;
> > > +	u8 result = 0x00;
> > 
> > You could avoid the explicit init of `result' (maybe even use `ret' for
> > less key strokes and avoiding the confusion with the `result' array used
> > by the other functions here) and then
> 
> The result should be inited to zero here, because the value
> of it is or-ed by the IQK status, such as:
> 
> 	result |= rtw8723d_iqk_check_tx_failed(rtwdev, iqk_cfg);
> 
> And yes, the name is a little confused to be the same.
> Should use different name for them.
> 
> > 
> > …
> > > +	rtw8723d_iqk_one_shot(rtwdev, false, iqk_cfg);
> > > +	result |= rtw8723d_iqk_check_tx_failed(rtwdev, iqk_cfg);
> > 
> > not or the returned value here. Since you don't collect it from multiple
> > functions I don't see the reason for it.
> 
> It actually does collect them from two functions, they are the
> same, but are done twice, hence using |= here.

Oh indeed it is. I was expecting a code flow with continue on 0 and
abort otherwise and that BIT(0) confused me.
So the first one could become a real assignment, the second has to be
ORed to keep current code flow.

Sebastian
