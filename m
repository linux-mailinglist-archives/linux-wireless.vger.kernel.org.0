Return-Path: <linux-wireless+bounces-11941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4795E9CF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BDC1F21497
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0536AF2;
	Mon, 26 Aug 2024 07:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7Ec7lIq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB984FA0
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 07:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655711; cv=none; b=q6ifdaAPefDPX6g8R+thlI4/I1muVVsw4dbaoc14hVgKKCHtmrBUxUjanRGDLoadtK32H1COl5oLv2RbhTa+LgfVw02aUMPEPxdkkBEl6ZX1UXcI6zw89HZvSl5xisMx7qIf0YCpgkP0Ha84B+ZMCkQjhlJz0qefnhbqMFjDPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655711; c=relaxed/simple;
	bh=soBUuYI6ZLm71P7WLh4LC31KMgg0Qjo9i4sEGfUmChc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVgvX+q+17a7GdS0dRUlNPkhipgl1BxbmZNB0kO3tlkAzoDMzoPuIFTHwwmhQwKSO4Th4N6QHIesD3wmPdqHv7o0Cxatl/vE2ivYfQshA0twiMVBeh/U/niQKiCdnjc7rmHdY0MxqpRpTr88hoKSpSQbdsUsGRx0QiRrpLXlDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7Ec7lIq; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so3261425b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 00:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724655709; x=1725260509; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VG/saQQ5iHGoFIIQv7ApO+CzdPsxdfU6dBnZhjjs/f4=;
        b=o7Ec7lIquOEvqPIzZ95AyG5/7QiGC25CZ7qBrMStxrSHPgon69j3GJCZUkKM/RH2lz
         H/vMUq3jKW4b3s9azQBPVGQ8j6jOw20V5JR+bEmmlALtCifk9pHZlfqNa/MVHXeQv6FW
         b3iCfRQgjUTKA0g5ncUk3ThRsPw8dYqysJhif6Fl2UGg/yYgG38zFn8nsc0v9KhVKwHG
         z31Lpd1QZnIrxphL5BJ2cxu5tbWVNkRCvc0S7PXP+8hGEja+VTA+X8iGb8pHTUHOKII3
         ESJ2MV7TNCEBjzeXjle1AhkZ0blbXj4XIVeEmPv60YdNNOdKv/b05Kc2cYPwuj+S7yMs
         r6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724655709; x=1725260509;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG/saQQ5iHGoFIIQv7ApO+CzdPsxdfU6dBnZhjjs/f4=;
        b=bf1cY7cj/5iYeZy2+j5rr+4Y84Wok5wnLTX+gklIwM2dxcmQ37GxsqsKH2R17rtlWf
         +l8FbAYKi/pGKvFg7G9uAhgySYb1LJ2DBEZ+dAHIzD0N1xEVjqGiQyVLJigtLIQoFyYD
         Rs8TbwJI6ETJR6xZHUywRfqFrq1n2Rm/Gpfrqcnt0kCfLyKSbab3XCKSNfyswPO9dey7
         PjiVZauGnJ99NzwWSFol4xkhqPOG/sSLZNMR9k5/gVLSA9NxvxdBD1ghwxu5WM5JqF7T
         eDRhA8IYAKykKmaY3XTh2z9mpCdsaHixngqd7fZQdxg4H++boms62pE8EnNIvlzdyliS
         0sEA==
X-Forwarded-Encrypted: i=1; AJvYcCVkQbApeLoI2rwRxZ0ya/EchXR4wxUkfUdIIPq9S6PXUB1SdNQHQ0VY3jRBtl8vIKa/Hr+H42oD8RLugZF9+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXjM3ywKvvA4nscXV3/m/vnf1VO9MgbcexKixXX9KBM8x6ITM
	775BD8XKUuEcuL5MDcEjc+xBwlGyvhId/dlGI0ZBIRVIudrGtKLM8a1h6RNwOA==
X-Google-Smtp-Source: AGHT+IFGIR6y4xQ2gR1n7QV7ZGej510G4EA/KhOh+F8qAhhrMZfBhUIO3179V98yc6fCEadsR5WUKg==
X-Received: by 2002:a05:6a00:918b:b0:70d:2b95:d9cd with SMTP id d2e1a72fcca58-714457d35c7mr9989372b3a.16.1724655707102;
        Mon, 26 Aug 2024 00:01:47 -0700 (PDT)
Received: from thinkpad ([220.158.156.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434230696sm6740544b3a.10.2024.08.26.00.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 00:01:46 -0700 (PDT)
Date: Mon, 26 Aug 2024 12:31:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: kvalo@kernel.org, jjohnson@kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: Set IRQ affinity hint after requesting
 all shared IRQs
Message-ID: <20240826070143.ejd6vuorseogmdfe@thinkpad>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
 <20240823155502.57333-2-manivannan.sadhasivam@linaro.org>
 <d3ceaead-5619-4413-acce-64567c08fb27@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3ceaead-5619-4413-acce-64567c08fb27@quicinc.com>

On Mon, Aug 26, 2024 at 11:04:41AM +0800, Baochen Qiang wrote:
> 
> 
> On 8/23/2024 11:55 PM, Manivannan Sadhasivam wrote:

[...]

> > The warning is due to not clearing the affinity hint before freeing the
> > IRQ.
> > 
> > So to fix this, let's set the IRQ affinity hint after requesting all the
> > shared IRQ. This will make sure that the affinity hint gets cleared in the
> > error path before freeing the IRQ.
> if you check 39564b475ac5 ("wifi: ath11k: fix boot failure with one MSI vector") you would see that the hint is set before requesting any IRQ for a purpose.
> 

Ok, thanks for sharing the history. However, commit 39564b475ac5 looks confusing
to me. It asserts that changing the IRQ affinity changes the MSI vector
programmed to the device, but I've never heard of that behavior. IRQ affinity
change is supposed to only change the CPU mask for the IRQ.

For confirming my suspicion, I added the debug print in pci_write_msg_msi() and
I can see that it is only getting called once during pci_alloc_irq_vectors().

Moreover with my series, WLAN is working fine on QCA6390 with a shared vector:

213:       6766          0          0          0          0          0          0          0   PCI-MSI 524288 Edge      bhi, mhi, mhi, ce0, ce1, ce2, ce3, ce5, ce7, ce8, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EX
T_IRQ, DP_EXT_IRQ, DP_EXT_IRQ, DP_EXT_IRQ

So I think the issue fixed by 39564b475ac5 should be reinvestigated.

- Mani

> > 
> > Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
> > 
> > Cc: Baochen Qiang <quic_bqiang@quicinc.com>
> > Fixes: e94b07493da3 ("ath11k: Set IRQ affinity to CPU0 in case of one MSI vector")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> > index 8d63b84d1261..0c22e18e65c7 100644
> > --- a/drivers/net/wireless/ath/ath11k/pci.c
> > +++ b/drivers/net/wireless/ath/ath11k/pci.c
> > @@ -886,16 +886,10 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
> >  	if (ret)
> >  		goto err_pci_disable_msi;
> >  
> > -	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
> > -	if (ret) {
> > -		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
> > -		goto err_pci_disable_msi;
> > -	}
> > -
> >  	ret = ath11k_mhi_register(ab_pci);
> >  	if (ret) {
> >  		ath11k_err(ab, "failed to register mhi: %d\n", ret);
> > -		goto err_irq_affinity_cleanup;
> > +		goto err_pci_disable_msi;
> >  	}
> >  
> >  	ret = ath11k_hal_srng_init(ab);
> > @@ -916,6 +910,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
> >  		goto err_ce_free;
> >  	}
> >  
> > +	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
> > +	if (ret) {
> > +		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
> > +		goto err_free_irq;
> > +	}
> > +
> >  	/* kernel may allocate a dummy vector before request_irq and
> >  	 * then allocate a real vector when request_irq is called.
> >  	 * So get msi_data here again to avoid spurious interrupt
> > @@ -924,17 +924,20 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
> >  	ret = ath11k_pci_config_msi_data(ab_pci);
> >  	if (ret) {
> >  		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
> > -		goto err_free_irq;
> > +		goto err_irq_affinity_cleanup;
> >  	}
> >  
> >  	ret = ath11k_core_init(ab);
> >  	if (ret) {
> >  		ath11k_err(ab, "failed to init core: %d\n", ret);
> > -		goto err_free_irq;
> > +		goto err_irq_affinity_cleanup;
> >  	}
> >  	ath11k_qmi_fwreset_from_cold_boot(ab);
> >  	return 0;
> >  
> > +err_irq_affinity_cleanup:
> > +	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
> > +
> >  err_free_irq:
> >  	ath11k_pcic_free_irq(ab);
> >  
> > @@ -947,9 +950,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
> >  err_mhi_unregister:
> >  	ath11k_mhi_unregister(ab_pci);
> >  
> > -err_irq_affinity_cleanup:
> > -	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
> > -
> >  err_pci_disable_msi:
> >  	ath11k_pci_free_msi(ab_pci);
> >  

-- 
மணிவண்ணன் சதாசிவம்

