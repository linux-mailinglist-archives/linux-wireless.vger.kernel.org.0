Return-Path: <linux-wireless+bounces-2333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787F836FF6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 19:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF57B2EF74
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE7F3D99D;
	Mon, 22 Jan 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fK4Hy6Cv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386553DB83
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945561; cv=none; b=gxi/4pQzciznPcpoEXlBvaXPny1WK/OgVEdXi8qCtV3BI7gTmbGTPB62v5gZKUAn/tRB1B/HGhLzdSsxpT4FwUq3scTCdj+0s/SITvXx7yW6z2yCRVynlRB0A8QZ5Zw7/V8IYvi9CR9ogo7HqPN2UawG+zGJw5jz/HDS7c4LyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945561; c=relaxed/simple;
	bh=qVDLcNstYX0XediQHmL2Dl0H92O2S6D8HwTjF00CX98=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YGu+vAM8i2zay4bAm0bLPYVHkxKcUuSx9DPWzvBHjS8uWP8BX9UEX1aNGDb0T+wF61kSmRKQEV4h5cAT1TKMbOR0Z5PpqFrNof4Lo123d7bC5g5t/Q7R37H9KN3chAaPuKNnR4cB6jMHzbeo6isRG3fNfiBkUIIj1aUoOSWnEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fK4Hy6Cv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so3466712f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 09:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705945558; x=1706550358; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lKQ/5Q7jA82cT1+M1DgIMrJhbdMuMzdcms+1XRI0Sbc=;
        b=fK4Hy6Cvu7EikgqHyx9FKU2hDSkyoM85E//Qwwl0EjiPrJbpmefljwDHGrny+0S5Tp
         TxtUb3OUJxkULbxmFNbvifiu+8D4XdPjyRPRtc6hiSZvlKAt+jlgGqxxy2Fqhowj4O7K
         kA2hSCVbIGcu2s/GJPl3V5Le8ol1Dsn21MdsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945558; x=1706550358;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKQ/5Q7jA82cT1+M1DgIMrJhbdMuMzdcms+1XRI0Sbc=;
        b=rZ1uOWLIaDBdIdMzjdt61x7bqMNKd1KwzgqCIaDELIaL0yg3naHqealKEKelyt6Syi
         yPVCsVvxUXCGOIiZQEpk3rn5JV5VS9BzSWV9EeXM5GHZpxhw/XCZKYsY6HKKH/G3fm9o
         poEE7m8QHSgTnaHYlwUJQ4wNunBsA3dTSkFvMyHT8afeZ8nNUvXSDVH+eO3wRw1jZuU6
         IiOrqJKtHZii7YcVoT5CjNpZRYsD7/FFirSniZeEYoEmsDXR1u7LN3E5dvQJm46xP6qy
         sg0sTpPT25XOzEJonqg7gdDlzWmJz7IbzPZ72A3qn0bTOt0C5KaY/DZSRN59Y6o3uVsF
         YoTA==
X-Gm-Message-State: AOJu0YxRp1BabFFS1ZNZtQ8P7/opfa8+BOcpOO52EhEDZDx6ySI6OT2M
	2PxssJ62vzyzQs/wfJPdS2oAiN2H5O5m3aeNqXWSJfAt6sctwrfJxxMrwmtvwA==
X-Google-Smtp-Source: AGHT+IHv5QmLuV8/kMrEAIQAntdljwGuYWnUmpYS0eHn10tF2Jm+uPQ9bO0Q3ji553Kbv4aPq1U1Uw==
X-Received: by 2002:a05:600c:4612:b0:40c:3d91:152 with SMTP id m18-20020a05600c461200b0040c3d910152mr2780445wmo.79.1705945558360;
        Mon, 22 Jan 2024 09:45:58 -0800 (PST)
Received: from [10.230.35.166] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040e89ff10f5sm19128259wmb.1.2024.01.22.09.45.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:45:57 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Bjorn Helgaas <helgaas@kernel.org>, Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>
Date: Mon, 22 Jan 2024 18:45:54 +0100
Message-ID: <18d32475c50.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240122115749.67682-2-dmantipov@yandex.ru>
References: <4cc44b07-13bd-49d0-b10f-b88875380f8c@broadcom.com>
 <20240122115749.67682-1-dmantipov@yandex.ru>
 <20240122115749.67682-2-dmantipov@yandex.ru>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH 2/2] [v3] wifi: brcmfmac: handle possible PCIE irq handling errors
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000083b6b060f8c67bb"

--000000000000083b6b060f8c67bb
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 22, 2024 12:59:03 PM Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Switch to newer 'pci_{alloc,feee}_irq_vectors()' API and handle
> possible errors in 'brcmf_pcie_request_irq()'. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

See comment below...

Reviewed-by: Arend van Spriel<arend.vanspriel@broadcom.com>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v3: switch to 'pci_{alloc,feee}_irq_vectors()' per Bjorn's review
> v2: rebase against wireless-next tree
> ---
> .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c 
> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> index 80220685f5e4..0f77d94f34a3 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
> @@ -965,6 +965,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void 
> *arg)
>
> static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
> {
> + int ret;
>  struct pci_dev *pdev = devinfo->pdev;
>  struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
>
> @@ -972,11 +973,14 @@ static int brcmf_pcie_request_irq(struct 
> brcmf_pciedev_info *devinfo)
>
>  brcmf_dbg(PCIE, "Enter\n");
>
> - pci_enable_msi(pdev);
> + ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> + if (ret < 0)
> + return ret;
> +
>  if (request_threaded_irq(pdev->irq,

Reading the kerneldoc for pci_alloc_irq_vectors() you should use the helper 
function pci_irq_vector() instead of pdev->irq


brcmf_pcie_quick_check_isr,
>  brcmf_pcie_isr_thread, IRQF_SHARED,
>  "brcmf_pcie_intr", devinfo)) {
> - pci_disable_msi(pdev);
> + pci_free_irq_vectors(pdev);
>  brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
>  return -EIO;
>  }
> @@ -997,7 +1001,7 @@ static void brcmf_pcie_release_irq(struct 
> brcmf_pciedev_info *devinfo)
>
>  brcmf_pcie_intr_disable(devinfo);
>  free_irq(pdev->irq, devinfo);
> - pci_disable_msi(pdev);
> + pci_free_irq_vectors(pdev);
>
>  msleep(50);
>  count = 0;
> --
> 2.43.0




--000000000000083b6b060f8c67bb
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBGNEDaeX36MdCxoMs0
UcOMECDI00P2XHG5mTG2tIFhNzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMjIxNzQ1NThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAQmC4A2LnQSyxxfv+YVK7WVEHvSGFP4n/Ntou
zLNgIip63EgNTh429IiYM9DD4k8rByNt8/FhcIIJ9pQSSVwF59RVGegpyxFbKmyVxdw/eOgpWwaQ
bMA0QhErl3/OEWVUecemJG+hEaHWiW8wX24skkSiF/Ci6VZdaYJh86RB1n/8PxrKpob4yym44XGb
i0ROdw2tnKdQLKMtEt+k5liR0tvN97n4T0nguXHkILIqv31Y3wmj4BW90SgmAQKg7W/KSV+z4r4t
gpiW+/fc6BVI6zDe8foGRU8BsKT+ZZJo8V7RIAAxWXsX59F7ocJ002G9dJhUgv/Y32f7634rLIfn
hg==
--000000000000083b6b060f8c67bb--

