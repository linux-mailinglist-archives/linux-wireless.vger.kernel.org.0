Return-Path: <linux-wireless+bounces-2502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C87183CA24
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 18:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419611C21C4B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8FC1EB5A;
	Thu, 25 Jan 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dv5EcCT3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1601E861
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204228; cv=none; b=CnwHHYBsXpMSNChZGEj6uqyoWNR6ZGXaHM849ffqOl9UaWsnSgzgtEYbFy4r3hxAQPcXKrMdEcRWPJBNzG8CE2j0qNfjFpyhwY7n7VlPU+tKigXqVAPCX+aYktlV+CP2P14mLEILZEfRFg+z5HBRZfNgqrl7FFeAtaXaJJtvork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204228; c=relaxed/simple;
	bh=eW9nvqK3rdk1a/EloiiXVCZQoDThGGVr8zFNhZreNU0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NVK5SKECAFs1Cix/mHLNJrR2wjHP9n3/FDtl1SHBmtY52YCegqWqelj9wXsmDDy9r1jIpGTBCH4obgzsRPSGsgYsx4h/KR6SU5hIZrb4wL22B2EfTlre3xjDimGO/+ayvQKxYIFQmsCkOxwV6CdVOjN8wxg4kYN0rNn/kdG+uro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dv5EcCT3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33922d2cb92so5925897f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706204225; x=1706809025; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlOQcRkjxTPyALgsj45FV6zvkOFIst8EqWJb/0cG21Y=;
        b=dv5EcCT3ejXhmFZ8nL9FZsov1HuGpdhpsnZcj0+r9Rged08xpyVQMI35RNhco6tRxU
         XvKsoaG0svTLWaLGKBp9owuNjKahyHNK4DKWE+cB+4mkqlTPpk/K74htBG7x/mMPjCfY
         qebFtJu8M5VGEg6t4BEi3ENCTLO2+2Rb2AeTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706204225; x=1706809025;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlOQcRkjxTPyALgsj45FV6zvkOFIst8EqWJb/0cG21Y=;
        b=qdtw7MUUyOq0o7on5RARZRtSt9eUPbd5jK3Poc5TzhKD0L5z6qsK0tTXCKqCJX2oRA
         Clv2S4SUWP7aCbCznnzTCMIh4fK/Yy+wXxIlNKoxAgOIuujY5DclzRloHxrk7HmR3UAC
         0tkcS7+YnW27IsAYucuNRstGaQiFEODxWdBTrXNbn5cZrctj8DRRc55p3oP+oo1Gqyh/
         V9rHF4weDjGopznU60wQSPfk2PtBVI8NNFDgoNZJJbGNaM1goaZ0amsFgpsVJY4O5ypq
         JoTDN9jO0e1bVcIuaZgAQrSlw8+ibpZY143WMJriTMocVstQ3O4zaSfBIe+1BpYfAfg/
         nvug==
X-Gm-Message-State: AOJu0Yx05GWpHpfgXrFtSSWQILiNpNgF2HiyKg1SQx/dnXSBwjbtZJGg
	gme9Fy2v/e5Ze3i/5czHefgGJf5EvGYpvg8heOjovtXYWQf+DqghxxeD59S9ow==
X-Google-Smtp-Source: AGHT+IEYRARgjCuNkH+BRxmIdhGSL0EBp5zdyYGgm+YDFIM9Vh2T0RYEGIR/auUV6TE33pltp4Va7A==
X-Received: by 2002:adf:a44e:0:b0:337:9a67:821d with SMTP id e14-20020adfa44e000000b003379a67821dmr51569wra.56.1706204224998;
        Thu, 25 Jan 2024 09:37:04 -0800 (PST)
Received: from [10.230.35.166] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003394495566dsm6472401wrm.22.2024.01.25.09.37.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 09:37:04 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Bjorn Helgaas <helgaas@kernel.org>, Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
Date: Thu, 25 Jan 2024 18:37:02 +0100
Message-ID: <18d41b25230.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240125120740.111330-3-dmantipov@yandex.ru>
References: <20240124133331.GA351271@bhelgaas>
 <20240125120740.111330-1-dmantipov@yandex.ru>
 <20240125120740.111330-3-dmantipov@yandex.ru>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH 2/2] [v4] wifi: brcmfmac: handle possible PCI irq handling errors
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c4648f060fc8a028"

--000000000000c4648f060fc8a028
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 25, 2024 1:08:26 PM Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Switch to newer 'pci_{alloc,free}_irq_vectors()' API and handle
> possible errors in 'brcmf_pcie_request_irq()'. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Crap. Did notice something else...

> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v4: prefer devm_{devm_request_threaded_irq,free_irq}()', use
> 'pci_irq_vector()' and fix title (Arend, Bjorn)
> v3: switch to 'pci_{alloc,free}_irq_vectors()' per Bjorn's review
> v2: rebase against wireless-next tree
> ---
> .../broadcom/brcm80211/brcmfmac/pcie.c        | 20 ++++++++++++-------
> 1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 80220685f5e4..17b855164025 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c

[...]

> @@ -972,11 +973,16 @@ static int brcmf_pcie_request_irq(struct 
> brcmf_pciedev_info *devinfo)
>
>  brcmf_dbg(PCIE, "Enter\n");
>
> - pci_enable_msi(pdev);
> - if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
> - brcmf_pcie_isr_thread, IRQF_SHARED,
> - "brcmf_pcie_intr", devinfo)) {
> - pci_disable_msi(pdev);
> + ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> + if (ret < 0)
> + return ret;
> +
> + if (devm_request_threaded_irq(&pdev->dev,
> +      pci_irq_vector(pdev, 0),
> +      brcmf_pcie_quick_check_isr,
> +      brcmf_pcie_isr_thread, IRQF_SHARED,
> +      "brcmf_pcie_intr", devinfo)) {
> + pci_free_irq_vectors(pdev);
>  brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);

Maybe better to use pci_irq_vector() here as well.

>  return -EIO;
>  }




--000000000000c4648f060fc8a028
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAuXJ3zFfEeg5TDPEmY
rOLTOWSFiekUv1Dx24SK0rCOmzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMjUxNzM3MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAMNCrwvLk+kNcmxFMRmujFWqkKF1kSO9dDZkg
npsNP0i7+UDYxlWSwZnJ7bnCch4pbXRZEWQixQNNSQWLh6Pzx6AnvlFpkYvWWYSHAzHbzi3kVbhb
qcorIPv3hfIHFYolsn0522Kl91Q7ocTZzsdIY1jgyK/b45WRxjIPWYs/dVlqO/5EfdSRuZsuciJr
T3WEUW0Aip6WwNO8/xNlrnqhT4dc7PE4lRTOJjVKBW3ZhrzVbCL/JLoLX5l4JY2kyHzc6lBRzsvM
AiRraYrTYysjkMOAmN9H/tQCJrStGuohPWcvo/h39ftT531L3DdtoEtYI+yvSSsR3iGEiu9+iNIS
3w==
--000000000000c4648f060fc8a028--

