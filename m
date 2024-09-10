Return-Path: <linux-wireless+bounces-12777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDF974522
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 23:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBF3283778
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 21:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3E31AB530;
	Tue, 10 Sep 2024 21:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNKcYIOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6A1F951;
	Tue, 10 Sep 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726005526; cv=none; b=jCjsTpY31iMfSwx9MI9V84LQgry1djnHw6bUpq78P2NppdXyhnxb/VTYdYy1rdeu8JwDgRRk2qnkVhnjCgaveDmyYHJBUyb5w30RX5/JJv54LwsUAuV3uGm/xq7qIPOUeajC0DwYYdwYZs7JxlSWN/+IJsh0u7rdekz1FEADfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726005526; c=relaxed/simple;
	bh=yePyIX59loL5NHGGJ//6Es5791hrIz8pgaK8x6ZDr90=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mayPJs8dWWayU58vrRIrtc3IwGNAh9s9I3PNxjBCykjvozYAXmANPrXtE1HlAzKQhD2QtYMreU+k6gYi43dI4cvYTu5Cni8Ir1NXPcR8u1hAZ6tgTccyi74VIyJbpD2qTDeYVLlGWseXeqhgksoJx0Qytzr3rXZX+2dg/2DeiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNKcYIOi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f025b94e07so50694351fa.0;
        Tue, 10 Sep 2024 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726005523; x=1726610323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cODp/cdYn+UoRP/+a8U5XTud5UdvhXKPRDpO/PLbOpI=;
        b=iNKcYIOiANyZgQaMQpLmRdN03tk7aQUu193HXbpzaWEIS623XV5DmjpkWg1g7X2KGX
         wYW4iXZp/LpGxmai5mMsiw3p2Oj0yUrvR+t2XBjWxvq/LUx0dxLn7Ns5A9fK3YnOT3iP
         JFES5LxSRInFUIS9N1lSitzbOm2RpHUHDd6hVGaehD/3BQXbqkDFrC6RSjZ+fPgg2T1t
         +GxpGQU/APDadyAGWpGCHoSo9EE1PtXT1mbkgVRsaxCzSJquZssjg/d+QL3w8kmqHqP6
         S/G2lxP7wGmUHTM0H+joNBF0wTdME/05uXJVjta7ZlJ8tb96yvir5jH/WNv8avyjCBVt
         rC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726005523; x=1726610323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cODp/cdYn+UoRP/+a8U5XTud5UdvhXKPRDpO/PLbOpI=;
        b=cCn2avzBpSkkX5gOz+LSMYDKeXoyWCWHNm42R3/Bb0uSziTSEMOqMUPmLdM+isT/8D
         XD2HNs14UPdwgP+NW9NezxIcA4SMmeSSjnvT+uy9GyW3oVmJe7TpQSWmlM39cYtgk1A4
         Q+Hlf9YZd5KFP/YD9az9Zhpn1tLJ/EZ/Zbrc3VJSDrNFhhY10YUKSiqyLEUHUy45QBpG
         uN8EbpIyMjBojzFpjRvfbeOZCPvS4TO+/Q84h56MTBm1kgdqxHdZadTFreuyI20/FN/o
         K0jrw3fV5iwHCbg+iH5g0U+JV6LigrRHMVCermW1a/6kX6tW35AU6kolPJEoDcJYse1d
         +nOw==
X-Forwarded-Encrypted: i=1; AJvYcCUDlRdjYJXZwfp4BvhNIn9fv1RrAl6f/kKxHg/nO+v6FueocureucdPuEiacu54LCRTEy467hoqKJnP5gG7aZA=@vger.kernel.org, AJvYcCVvwv7EbAwmZ5uHWtRM2g6rgTTK0vELY6s1UougtrOFzJ37UxbJt1UOSICr5WTpglmkiYOMmkCFEjpaRU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwdxnHm0pHT3KlOzVuKw2+R00nsIGo7MmLUhWeTkC2RE1BCp4
	Cax3Z4hcW4BisvcclId96z0hulAsDpWvqGKr1hTBRUWtRrRTxKaE
X-Google-Smtp-Source: AGHT+IEzf96KxSb2Nkf2s+XolsjlP30n8kQZLMRZDoTuxlRb5D00TYSZxadnElgwcvZowJSvPcdFTQ==
X-Received: by 2002:a2e:f0a:0:b0:2f3:a06a:4c5 with SMTP id 38308e7fff4ca-2f754a6b7cbmr67547291fa.29.1726005521995;
        Tue, 10 Sep 2024 14:58:41 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:5d47:19e4:3e71:414c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd5207csm4713747a12.47.2024.09.10.14.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:58:41 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 10 Sep 2024 23:58:39 +0200
To: "Khan, Sabeeh" <sabeeh-khan@ti.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>,
	arend.vanspriel@broadcom.com, kvalo@kernel.org, knaerzche@gmail.com,
	leitao@debian.org, linus.walleij@linaro.org, javierm@redhat.com,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next v2 3/3] wifi: wlcore: sdio: Use helper to
 define resources
Message-ID: <20240910215839.GB12725@vamoiridPC>
References: <20240904154919.118513-1-vassilisamir@gmail.com>
 <20240904154919.118513-4-vassilisamir@gmail.com>
 <c2886640-e342-4b2f-8c24-02c6edd901eb@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2886640-e342-4b2f-8c24-02c6edd901eb@ti.com>

On Mon, Sep 09, 2024 at 01:38:58PM +0400, Khan, Sabeeh wrote:
> Hi Vasileios,
> 
> On 9/4/2024 7:49 PM, Vasileios Amoiridis wrote:
> > Resources definition can become simpler and more organised by
> > using the dedicated helpers.
> >
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/net/wireless/ti/wlcore/sdio.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
> > index 9e1b644beba9..a73207bbe5d7 100644
> > --- a/drivers/net/wireless/ti/wlcore/sdio.c
> > +++ b/drivers/net/wireless/ti/wlcore/sdio.c
> > @@ -323,15 +323,12 @@ static int wl1271_probe(struct sdio_func *func,
> >  
> >  	memset(res, 0x00, sizeof(res));
> >  
> > -	res[0].start = irq;
> > -	res[0].flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
> > -	res[0].name = "irq";
> > -
> > +	res[0] = DEFINE_RES_IRQ_NAMED(irq, "irq");
> > +	res[0].flags |= irq_get_trigger_type(irq);
> >  
> >  	if (wakeirq > 0) {
> > -		res[1].start = wakeirq;
> > -		res[1].flags = IORESOURCE_IRQ | irq_get_trigger_type(wakeirq);
> > -		res[1].name = "wakeirq";
> > +		res[1] = DEFINE_RES_IRQ_NAMED(wakeirq, "wakeirq");
> > +		res[1].flags |= irq_get_trigger_type(wakeirq);
> >  		num_irqs = 2;
> >  	} else {
> >  		num_irqs = 1;
> 
> Tested-by: Sabeeh Khan <sabeeh-khan@ti.com>
> Reviewed-by: Sabeeh Khan <sabeeh-khan@ti.com>
> 

Hi Sabeeh,

Thank you very much!

Cheers,
Vasilis

