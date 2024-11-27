Return-Path: <linux-wireless+bounces-15751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3D9DA4B0
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D310163EB2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA9018E361;
	Wed, 27 Nov 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pIPEYSWm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A021442E8
	for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699198; cv=none; b=Evxaucd+uZ7dyG4hH2hjb2IJzV2DlI0zJm1iHOkB9l3jI3BUkp2Kq2/aRVubibPrYKMMeqtNWlxhfJttdaZm9XPeQByQcHhui0NyjFTtlhphKK0MovBRMp8g7MJCyE68Dd4BZKWpC4FTYc6iRWAUmO4MO5F+Qm0qmw3Kk9le0lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699198; c=relaxed/simple;
	bh=wHNVz9LeU11tpbWODTrW1MiSZIbMCC1eKq5T7Yx9saY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjP4+NJAi4E72KrnBrBLk9Aef7ApaWfML8CSlnMKLx2KDgQ49bafcL7b/KKCjBKF77D+8sFtg30p0rnQmV4cX9QTk07S4KJvKbrQlNWgDGTH3TOPbg9nZLWMTRv2dI9i+3aURd1mo5L//0a85aGgMUhjbUApluI9YCcP6EZgQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pIPEYSWm; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BbhBTzdxEm/IxMEgVZ3/KMRk/3xnunC7kG4foCuMnJ4=; b=pIPEYSWmrigduDRyWCZUhKXEIy
	bkexxI9UFHvpGejD/VcQspMxTH0eOYkuYjZfi2631rXzObp0prkKntSTVOYeYf6sLO4UmqLGVjwbn
	SV8m4fwlWUzudi3FaZTuFnaWLl01zNifazA8D41gn6ZKAPSn3K8iJVMfYCeWHsvzc8N9Wi5eNbKvp
	EiGO/R1C8V8PW81gXb/xVNACpPlqXJvLrU16Hngl/A+b1RU8LaIoNBpI3H0TvT5Wx6uPw/kF5fDT4
	6Vmrdf2zMSYj2iDMKYYD2cXg2/KNfwFLnQtBz3yXhCLysHAvR8AYnSIadMpbQVuiXiP5RtHi5/RcH
	FqVWirHg==;
Received: from 179-125-64-246-dinamico.pombonet.net.br ([179.125.64.246] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tGEDC-00DXal-79; Wed, 27 Nov 2024 10:19:54 +0100
Date: Wed, 27 Nov 2024 06:19:50 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH 2/4] wifi: rltwifi: destroy workqueue at rtl_deinit_core
Message-ID: <Z0bkNuVvv1eJMFyo@quatroqueijos.cascardo.eti.br>
References: <20241122172718.465539-1-cascardo@igalia.com>
 <20241122172718.465539-3-cascardo@igalia.com>
 <3b967b62f2954e799a856140aa4b0796@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b967b62f2954e799a856140aa4b0796@realtek.com>

On Wed, Nov 27, 2024 at 05:35:23AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > 
> > rtl_wq is allocated at rtl_init_core, so it makes more sense to destroy it
> > at rtl_deinit_core. In the case of USB, where _rtl_usb_init does not
> > require anything to be undone, that is fine. But for PCI, rtl_pci_init,
> > which is called after rtl_init_core, needs to deallocate data, but only if
> > it has been called.
> > 
> > That means that destroying the workqueue needs to be done whether
> > rtl_pci_init has been called or not. And since rtl_pci_deinit was doing it,
> > it has to be moved out of there.
> > 
> > It makes more sense to move it to rtl_deinit_core and have it done in both
> > cases, USB and PCI.
> > 
> > Since this is a requirement for a followup memory leak fix, mark this as
> > fixing such memory leak.
> > 
> > Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> 
> Like patch 1/3, this is a cleanup patch, so I don't think a Fixes is needed. 
> 

This is a pre-requisite for patch 3/4. Without it, the workqueue
destruction in the PCI probe error path would not happen when it should,
resulting in memory leaks and NULL pointer dereferences.

> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> "rtlwifi" is a typo in subject.
> 

Can you fix that when applying, or should I send a v2?

> > ---
> >  drivers/net/wireless/realtek/rtlwifi/base.c | 5 +++++
> >  drivers/net/wireless/realtek/rtlwifi/pci.c  | 2 --
> >  drivers/net/wireless/realtek/rtlwifi/usb.c  | 5 -----
> >  3 files changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
> > index fd28c7a722d8..062d5a0a4c11 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/base.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/base.c
> > @@ -575,9 +575,14 @@ static void rtl_free_entries_from_ack_queue(struct ieee80211_hw *hw,
> > 
> >  void rtl_deinit_core(struct ieee80211_hw *hw)
> >  {
> > +       struct rtl_priv *rtlpriv = rtl_priv(hw);
> 
> A blank line between declarations and statements. 
> 

Same here.

> >         rtl_c2hcmd_launcher(hw, 0);
> >         rtl_free_entries_from_scan_list(hw);
> >         rtl_free_entries_from_ack_queue(hw, false);
> > +       if (rtlpriv->works.rtl_wq) {
> > +               destroy_workqueue(rtlpriv->works.rtl_wq);
> > +               rtlpriv->works.rtl_wq = NULL;
> > +       }
> >  }
> >  EXPORT_SYMBOL_GPL(rtl_deinit_core);
> > 
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
> > index 4388066eb9e2..e60ac910e750 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/pci.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
> > @@ -1656,8 +1656,6 @@ static void rtl_pci_deinit(struct ieee80211_hw *hw)
> >         synchronize_irq(rtlpci->pdev->irq);
> >         tasklet_kill(&rtlpriv->works.irq_tasklet);
> >         cancel_work_sync(&rtlpriv->works.lps_change_work);
> > -
> > -       destroy_workqueue(rtlpriv->works.rtl_wq);
> >  }
> > 
> >  static int rtl_pci_init(struct ieee80211_hw *hw, struct pci_dev *pdev)
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > index 0368ecea2e81..f5718e570011 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > @@ -629,11 +629,6 @@ static void _rtl_usb_cleanup_rx(struct ieee80211_hw *hw)
> >         tasklet_kill(&rtlusb->rx_work_tasklet);
> >         cancel_work_sync(&rtlpriv->works.lps_change_work);
> > 
> > -       if (rtlpriv->works.rtl_wq) {
> > -               destroy_workqueue(rtlpriv->works.rtl_wq);
> > -               rtlpriv->works.rtl_wq = NULL;
> > -       }
> > -
> >         skb_queue_purge(&rtlusb->rx_queue);
> > 
> >         while ((urb = usb_get_from_anchor(&rtlusb->rx_cleanup_urbs))) {
> > --
> > 2.34.1
> 

