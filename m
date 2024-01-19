Return-Path: <linux-wireless+bounces-2277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC650833033
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 22:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C5D286472
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 21:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F858104;
	Fri, 19 Jan 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCymr1UJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5BA58103
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 21:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699445; cv=none; b=W1WUAW1q+XgBViZG870E+i5b9WMqk1KWKGm5xA8qFu/muzsfopzNfbq5fBJjy7xI3c+/Q5l13OPtupWaxe9OLnfs9vb0CNnx7kzHKxYosigR7A7jY0YpLzQt9bju6PLghbyakApBjLEU4m0GAF0HCyNAsKP5HjAmj9/4o9rHxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699445; c=relaxed/simple;
	bh=ROEW6dVOrvHPgOrUezSkIptkpBBndwGzoZZ+eXPjpbM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q/sWmXlkwACRpWwm/UdWfMMfx7GS5r/wIddZNc/a+ooVnYRIwUPBA+EU7pvRvtIqxccYNqtKbsgNJqMT1nR9MAHd+JxrK7AstT4V4Y/pD5Sa7fEXBqq192mCq9OjHvsLJLTxRRdS7DyJg6RsqUUPCsP/HSiMPyJandZL4o8S3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCymr1UJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D81C433C7;
	Fri, 19 Jan 2024 21:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699445;
	bh=ROEW6dVOrvHPgOrUezSkIptkpBBndwGzoZZ+eXPjpbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bCymr1UJIlQNPG1UngpA91cR8ga2LLbVT7fB8hgCPsWGfw1MC1+c2KaJYx4z1IixD
	 /PtNMfDjIYjF1lGj++oO1FoevJDdwufxsQotZQWKbwHe6B2tw2+QsaF5zt4qHBgbfT
	 yAk5If0fAjvh3XVWI25kSbPPYA1miVFYT1g6a6h/A38nWZXjIaM+f8YDB5pDYMg9Mr
	 HA8Od1t9O2TNGlzxiU6VCFiocDf5kMQGKWqzM7bksq88mStKtMG8+6S82AgimhxUCE
	 7qdoEVG56iGMjbOMCZ8lsneViWFiBsB0ELOae53ntLbcNfQcLGCPA9w7Agj4bdPWnk
	 essUG06sbvcNA==
Date: Fri, 19 Jan 2024 15:24:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>,
	brcm80211-dev-list.pdl@broadcom.com, linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>, lvc-project@linuxtesting.org
Subject: Re: [PATCH 2/2] [v2] wifi: brcmfmac: handle possible MSI enabling
 error
Message-ID: <20240119212402.GA186344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614075848.80536-2-dmantipov@yandex.ru>

On Wed, Jun 14, 2023 at 10:58:48AM +0300, Dmitry Antipov wrote:
> Handle possible 'pci_enable_msi()' error in
> 'brcmf_pcie_request_irq()', adjust related code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: rebase against wireless-next tree
> ---
>  .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c  | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 80220685f5e4..f7d9f2cbd60b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -965,6 +965,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void *arg)
>  
>  static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
>  {
> +	int ret;
>  	struct pci_dev *pdev = devinfo->pdev;
>  	struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
>  
> @@ -972,16 +973,19 @@ static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
>  
>  	brcmf_dbg(PCIE, "Enter\n");
>  
> -	pci_enable_msi(pdev);
> +	ret = pci_enable_msi(pdev);
> +	if (ret)
> +		return ret;

If the device supports INTx and MSI is disabled for some reason
(booted with "pci=nomsi", ACPI_FADT_NO_MSI is set, etc), this change
means the driver would no longer be able to fall back to using INTx.

If you want to go to the trouble of changing this code, you could
consider using the new APIs:

  ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
  if (ret < 0)
    return ret;

  if (request_threaded_irq(pdev->irq, ...)) {
    pci_free_irq_vectors(pdev);
    return -EIO;
  }

plus the appropriate pci_free_irq_vectors() calls in other failure and
remove paths.

See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/msi-howto.rst?v6.7#n93

>  	if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
>  				 brcmf_pcie_isr_thread, IRQF_SHARED,
>  				 "brcmf_pcie_intr", devinfo)) {
>  		pci_disable_msi(pdev);
>  		brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
> -		return -EIO;
> +		ret = -EIO;

IMHO this part ("ret = -EIO" and "return ret" below) makes the code
harder to read for no benefit.  The existing code returns -EIO
immediately here and returns 0 below.  It's easier to read that than
to follow the use of "ret".

I guess that's just repeating what Arend already said; sorry, I hadn't
read the whole thread yet.

> +	} else {
> +		devinfo->irq_allocated = true;
>  	}
> -	devinfo->irq_allocated = true;
> -	return 0;
> +	return ret;
>  }
>  
>  
> -- 
> 2.40.1
> 

