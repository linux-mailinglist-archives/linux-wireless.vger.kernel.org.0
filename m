Return-Path: <linux-wireless+bounces-1558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD71826376
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jan 2024 09:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD2AB21D54
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jan 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D763D533;
	Sun,  7 Jan 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1XBPWFx4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E912B87;
	Sun,  7 Jan 2024 08:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491FBC433CB;
	Sun,  7 Jan 2024 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704617552;
	bh=15zndfpHg+9DAspQBb3USYLMs06e6OiG3wQTC2Oy2z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1XBPWFx4dmYgfd9wiY9F7A8iVjM0fqpewletEfcCKWcswzcqZpxlwOpEd0FRTmtP/
	 +DunnpDPivUtxA8bk0pYnisl4ghw35aFM2UiFSGpGroQbBSL5NEdX7g/89bdvVUXWE
	 6pGS32hYVp5E3Bnctqzdma+wMtVBrrEjYwQPGej8=
Date: Sun, 7 Jan 2024 09:52:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	Hector Martin <marcan@marcan.st>, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/3] wifi: brcmfmac: Demote vendor-specific
 attach/detach messages to info
Message-ID: <2024010717-riverbed-cycle-d43e@gregkh>
References: <20240106103835.269149-1-arend.vanspriel@broadcom.com>
 <20240106103835.269149-2-arend.vanspriel@broadcom.com>
 <2024010757-bootie-librarian-51f7@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024010757-bootie-librarian-51f7@gregkh>

On Sun, Jan 07, 2024 at 09:52:01AM +0100, Greg KH wrote:
> On Sat, Jan 06, 2024 at 11:38:33AM +0100, Arend van Spriel wrote:
> > From: Hector Martin <marcan@marcan.st>
> > 
> > People are getting spooked by brcmfmac errors on their boot console.
> > There's no reason for these messages to be errors.
> > 
> > Cc: stable@vger.kernel.org # 6.2.x
> > Fixes: d6a5c562214f ("wifi: brcmfmac: add support for vendor-specific firmware api")
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > [arend.vanspriel@broadcom.com: remove attach/detach vendor callbacks]
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > ---
> >  .../broadcom/brcm80211/brcmfmac/bca/core.c    | 13 ----------
> >  .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 13 ----------
> >  .../broadcom/brcm80211/brcmfmac/fwvid.c       |  7 +++--
> >  .../broadcom/brcm80211/brcmfmac/fwvid.h       | 26 ++-----------------
> >  .../broadcom/brcm80211/brcmfmac/wcc/core.c    | 15 +----------
> >  5 files changed, 6 insertions(+), 68 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
> > index a5d9ac5e6763..a963c242975a 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/core.c
> > @@ -11,17 +11,6 @@
> >  
> >  #include "vops.h"
> >  
> > -static int brcmf_bca_attach(struct brcmf_pub *drvr)
> > -{
> > -	pr_err("%s: executing\n", __func__);
> > -	return 0;
> > -}
> > -
> > -static void brcmf_bca_detach(struct brcmf_pub *drvr)
> > -{
> > -	pr_err("%s: executing\n", __func__);
> > -}
> > -
> >  static void brcmf_bca_feat_attach(struct brcmf_if *ifp)
> >  {
> >  	/* SAE support not confirmed so disabling for now */
> > @@ -29,7 +18,5 @@ static void brcmf_bca_feat_attach(struct brcmf_if *ifp)
> >  }
> >  
> >  const struct brcmf_fwvid_ops brcmf_bca_ops = {
> > -	.attach = brcmf_bca_attach,
> > -	.detach = brcmf_bca_detach,
> >  	.feat_attach = brcmf_bca_feat_attach,
> >  };
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > index 24670497f1a4..bec5748310b9 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> > @@ -11,17 +11,6 @@
> >  
> >  #include "vops.h"
> >  
> > -static int brcmf_cyw_attach(struct brcmf_pub *drvr)
> > -{
> > -	pr_err("%s: executing\n", __func__);
> > -	return 0;
> > -}
> > -
> > -static void brcmf_cyw_detach(struct brcmf_pub *drvr)
> > -{
> > -	pr_err("%s: executing\n", __func__);
> > -}
> > -
> >  static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
> >  				 struct cfg80211_crypto_settings *crypto)
> >  {
> > @@ -49,7 +38,5 @@ static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
> >  }
> >  
> >  const struct brcmf_fwvid_ops brcmf_cyw_ops = {
> > -	.attach = brcmf_cyw_attach,
> > -	.detach = brcmf_cyw_detach,
> >  	.set_sae_password = brcmf_cyw_set_sae_pwd,
> >  };
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
> > index 86eafdb40541..f633e2bbd891 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
> > @@ -89,8 +89,7 @@ int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *vmod,
> >  	if (fwvid >= BRCMF_FWVENDOR_NUM)
> >  		return -ERANGE;
> >  
> > -	if (WARN_ON(!vmod) || WARN_ON(!vops) ||
> > -	    WARN_ON(!vops->attach) || WARN_ON(!vops->detach))
> > +	if (WARN_ON(!vmod) || WARN_ON(!vops))
> >  		return -EINVAL;
> >  
> >  	if (WARN_ON(fwvid_list[fwvid].vmod))
> > @@ -150,7 +149,7 @@ static inline int brcmf_fwvid_request_module(enum brcmf_fwvendor fwvid)
> >  }
> >  #endif
> >  
> > -int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr)
> > +int brcmf_fwvid_attach(struct brcmf_pub *drvr)
> >  {
> >  	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
> >  	int ret;
> > @@ -175,7 +174,7 @@ int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr)
> >  	return ret;
> >  }
> >  
> > -void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr)
> > +void brcmf_fwvid_detach(struct brcmf_pub *drvr)
> >  {
> >  	enum brcmf_fwvendor fwvid = drvr->bus_if->fwvid;
> >  
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> > index d9fc76b46db9..dac22534d033 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> > @@ -12,8 +12,6 @@ struct brcmf_pub;
> >  struct brcmf_if;
> >  
> >  struct brcmf_fwvid_ops {
> > -	int (*attach)(struct brcmf_pub *drvr);
> > -	void (*detach)(struct brcmf_pub *drvr);
> >  	void (*feat_attach)(struct brcmf_if *ifp);
> >  	int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_crypto_settings *crypto);
> >  };
> > @@ -24,30 +22,10 @@ int brcmf_fwvid_register_vendor(enum brcmf_fwvendor fwvid, struct module *mod,
> >  int brcmf_fwvid_unregister_vendor(enum brcmf_fwvendor fwvid, struct module *mod);
> >  
> >  /* core driver functions */
> > -int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr);
> > -void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr);
> > +int brcmf_fwvid_attach(struct brcmf_pub *drvr);
> > +void brcmf_fwvid_detach(struct brcmf_pub *drvr);
> >  const char *brcmf_fwvid_vendor_name(struct brcmf_pub *drvr);
> >  
> > -static inline int brcmf_fwvid_attach(struct brcmf_pub *drvr)
> > -{
> > -	int ret;
> > -
> > -	ret = brcmf_fwvid_attach_ops(drvr);
> > -	if (ret)
> > -		return ret;
> > -
> > -	return drvr->vops->attach(drvr);
> > -}
> > -
> > -static inline void brcmf_fwvid_detach(struct brcmf_pub *drvr)
> > -{
> > -	if (!drvr->vops)
> > -		return;
> > -
> > -	drvr->vops->detach(drvr);
> > -	brcmf_fwvid_detach_ops(drvr);
> > -}
> > -
> >  static inline void brcmf_fwvid_feat_attach(struct brcmf_if *ifp)
> >  {
> >  	const struct brcmf_fwvid_ops *vops = ifp->drvr->vops;
> > diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
> > index 2d8f80bd7382..fd593b93ad40 100644
> > --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
> > +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
> > @@ -7,21 +7,10 @@
> >  #include <core.h>
> >  #include <bus.h>
> >  #include <fwvid.h>
> > -#include <fwil.h>
> > +#include <cfg80211.h>
> >  
> >  #include "vops.h"
> >  
> > -static int brcmf_wcc_attach(struct brcmf_pub *drvr)
> > -{
> > -	pr_debug("%s: executing\n", __func__);
> > -	return 0;
> > -}
> > -
> > -static void brcmf_wcc_detach(struct brcmf_pub *drvr)
> > -{
> > -	pr_debug("%s: executing\n", __func__);
> > -}
> > -
> >  static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
> >  				 struct cfg80211_crypto_settings *crypto)
> >  {
> > @@ -30,7 +19,5 @@ static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
> >  }
> >  
> >  const struct brcmf_fwvid_ops brcmf_wcc_ops = {
> > -	.attach = brcmf_wcc_attach,
> > -	.detach = brcmf_wcc_detach,
> >  	.set_sae_password = brcmf_wcc_set_sae_pwd,
> >  };
> > -- 
> > 2.32.0
> > 
> 
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Sorry, bot is wrong here, this is fine.

