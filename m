Return-Path: <linux-wireless+bounces-15141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440E9C1C03
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B191C21939
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 11:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBE1E0E0F;
	Fri,  8 Nov 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="M+Yds4Eq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68501D1E73
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064520; cv=none; b=OFfEapuHBsgme7JEA6xiTkjo9R0Doz1nfjimdOacxM1VgdIb79W0+wmSPVcu1upLSW+Ui1LXT9c2LHFOF8HZa81RDPq2EKAPUosUD0u7/ZwvQBuV0FQNCTocOc7v8yJeJRSvSefN4zwT7/1kflzLIUBZF4DYkv9Lhn+6n40H8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064520; c=relaxed/simple;
	bh=C+M036x2WrgPkRMOw7lxUtdgQyWvzUHNh3+JZe7iHnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J95Tq1t5A2lZdopo3L6W4mJZjV0j445iYl21KwozYMXzzzY1qmPU1QV/0967oOm/AHMVBD9nMXnxw+AKQGEIkoORbVIhPLHbJ5nmljhUZg14vWu/0PbnbgcDI5A+owiTS9eENgvAdZ2omnvUGYncOqoSL5mjIQyEoqPUuuZb0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=M+Yds4Eq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=toh3PYOzBRAt6yRLFWu7ghB3DlFtfqQRo4daHjqbZrk=; b=M+Yds4EqiF/+PlJHQ1pw7/qQBy
	6XTapNRT8o7L2i/jALGreihYvm6CC93RNPF8oOWj00/lYQUBYC2S6nQmaZV2TIhTfkNcz6EpZn+La
	9+y+zLJsf5lXZWTnHXQQo9snjG6MdT+D5WxROtdzwVSyvUlIWo2yipyHsKDf1dn1+ZjGOJ2cZzuwr
	eXa7feF5i/cZR4B9Pg/yjjk/gJx5loABO6aRtsJ3jZ+3ociCmlZ6JawIpjU4Ddy6Bh5ltGj5Myuz9
	81VW3rnX38LOFcWSaxzftDGFjTJF95g/g+dcIYS/aY88OdmTetilgUS4/44kkep/bQ9v4OS3btWKD
	nE5xQYjQ==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t9MxO-0040Qn-Vu; Fri, 08 Nov 2024 12:15:15 +0100
Date: Fri, 8 Nov 2024 08:15:11 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH net 5/5] wifi: rtlwifi: usb: fix workqueue leak when
 probe fails
Message-ID: <Zy3yv1TrPGXeP6x3@quatroqueijos.cascardo.eti.br>
References: <20241107133322.855112-1-cascardo@igalia.com>
 <20241107133322.855112-6-cascardo@igalia.com>
 <d66c4ae9004c43058c89fcc3d97f4b41@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d66c4ae9004c43058c89fcc3d97f4b41@realtek.com>

On Fri, Nov 08, 2024 at 02:23:48AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > rtl_init_core creates a workqueue that is then assigned to rtl_wq.
> > rtl_deinit_core does not destroy it. It is left to rtl_usb_deinit, which
> > must be called in the probe error path.
> > 
> > Fixes: 2ca20f79e0d8 ("rtlwifi: Add usb driver")
> > Fixes: 851639fdaeac ("rtlwifi: Modify some USB de-initialize code.")
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >  drivers/net/wireless/realtek/rtlwifi/usb.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > index 8ec687fab572..0368ecea2e81 100644
> > --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> > +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> > @@ -1039,6 +1039,7 @@ int rtl_usb_probe(struct usb_interface *intf,
> >         wait_for_completion(&rtlpriv->firmware_loading_complete);
> >         rtlpriv->cfg->ops->deinit_sw_vars(hw);
> >  error_out:
> > +       rtl_usb_deinit(hw);
> >         rtl_deinit_core(hw);
> >  error_out2:
> >         _rtl_usb_io_handler_release(hw);
> 
> I think deinit should be in reverse order of init step by step:

Well, I kept the order that they appear in the remove path. Also, I checked
that they are not exactly independent and rtl_usb_deinit does not need to
be called when rtl_init_core fails. I have just checked and it wouldn't
cause any harm either if rtl_usb_deinit is called in case rtl_init_core
fails. So either way should be fine.

Cascardo.

> 
> --- a/drivers/net/wireless/realtek/rtlwifi/usb.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
> @@ -1017,7 +1017,7 @@ int rtl_usb_probe(struct usb_interface *intf,
>         err = rtl_init_core(hw);
>         if (err) {
>                 pr_err("Can't allocate sw for mac80211\n");
> -               goto error_out2;
> +               goto error_out_usb_deinit;
>         }
>         if (rtlpriv->cfg->ops->init_sw_vars(hw)) {
>                 pr_err("Can't init_sw_vars\n");
> @@ -1040,6 +1040,8 @@ int rtl_usb_probe(struct usb_interface *intf,
>         rtlpriv->cfg->ops->deinit_sw_vars(hw);
>  error_out:
>         rtl_deinit_core(hw);
> +error_out_usb_deinit:
> +       rtl_usb_deinit(hw);
>  error_out2:
>         _rtl_usb_io_handler_release(hw);
>         usb_put_dev(udev);
> 
> Have you also considered PCI? It seems that rtl_pci_deinit() isn't called if
> PCI probe fails. 
> 
> 

