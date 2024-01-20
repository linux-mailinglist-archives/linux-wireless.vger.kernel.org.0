Return-Path: <linux-wireless+bounces-2288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F5E8333FD
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 13:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B674A2833FC
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED8DDC7;
	Sat, 20 Jan 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VUcZX6Z+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB68D2FE
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705752496; cv=none; b=e4sqvBaSUjuYwH7+L/Rc+OUs9YBNBciSUYrPHvB3KpB2O75KXZhEbAOkIzB1phGqqxYKo4ct/fFEPrxaOHoJMdsMCeo0f22zzmQz46lJJOFlW4T+bA9hj8zLeZj5y6dGGD3X3AuZJV3J+t4o55MIaQ6kBCx8Q6jBwA+JOgkdMLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705752496; c=relaxed/simple;
	bh=nq5h9zD4BCtiz1w5ZnC9ZNIGGSeSXEB3GpsFWHT9PuU=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Hc17+/0hfeLxFG0l1opJk0e9imLhg575dnN114JMpWBupmhJGPCJoTDu5xjGtAbTGVFkL4ZKipCUZgOMZKHtag4G2cabYesQwaA3vL9P02n4KqIjmAxXDEvDbbqgKbSUb/MLW9wFxgSyFO+2dPlnIhN8R9rLfZSkOUg3k3YjVCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VUcZX6Z+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so171430166b.0
        for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 04:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705752492; x=1706357292; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EuiMMWK0jjWFYebIOPwfyMMZKJTEhtsqFSbOhn6EobM=;
        b=VUcZX6Z+QxqXK/eV61NXUiRYD3+a4QY9+AW+ebeA8b0lQlAHrcgnlC9Dzhkoy4UxQh
         cgBmA7wx20jE3ELCYoBZBFyVHe304OaNnRT8NPc6vHIRTzVi52DHuD2cJk066KClOSYm
         +wxC1avkNfnuisa/4uaAbezgSfPa16D4ezS/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705752492; x=1706357292;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuiMMWK0jjWFYebIOPwfyMMZKJTEhtsqFSbOhn6EobM=;
        b=nBvP7EO6s8TUMRmAJJCAnSWpVqU4KjoYy7ir6BnKQRqyZPJM+8u34YlJ9yecg1LrAm
         5SCJmaKkkqSAtk8YisJzqUSadtK8Pg2qDkPDJpOrfn5HBQLsrUUkFM390SQbD19+nGFS
         22yVzN0G6IbQ4FBN+IkSj+5oqrtqDcqMSdCH+Z71xVlK8XaoJ4UuiD4m4d9ZOT8Dmfzn
         zefZr18m7/rcvXnWgcMlDV4efx+aGmj5EDztEpDfMvXGkgDuXxznwX8ipz5RV0Aib4Il
         WudsbmXPAp7G2K8Lc3OIiDqHumF0CxrvyzArXUJ8bb0g8ZV7rS+oneTbee25tkFJTJc5
         u9lw==
X-Gm-Message-State: AOJu0Yz5YDK2vl+3YI6rTUIk8KPXsRJnwr/vAjk19mLmwPRSwtciZpVR
	vclOQHTGJii1JzJ4vxVfbs2pHOmLKpygTcLgjarzwcmB2LPOlqnyfU6wo5OOWg==
X-Google-Smtp-Source: AGHT+IGxkH7BMXP2RrT1H8cAkQH6ZQ1iWD95Db3kd5/biSTqfe3n0+4B4qfsEED1JcLljpFQF4X6EQ==
X-Received: by 2002:a17:906:e0d0:b0:a2f:7808:8269 with SMTP id gl16-20020a170906e0d000b00a2f78088269mr737150ejb.42.1705752492511;
        Sat, 20 Jan 2024 04:08:12 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id vk6-20020a170907cbc600b00a2ea02e4162sm4988697ejc.214.2024.01.20.04.08.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jan 2024 04:08:10 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>
CC: Hante Meuleman <hante.meuleman@broadcom.com>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>, <lvc-project@linuxtesting.org>
Date: Sat, 20 Jan 2024 13:08:07 +0100
Message-ID: <18d26c56458.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240119212402.GA186344@bhelgaas>
References: <20240119212402.GA186344@bhelgaas>
User-Agent: AquaMail/1.49.1 (build: 104901407)
Subject: Re: [PATCH 2/2] [v2] wifi: brcmfmac: handle possible MSI enabling error
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006afb93060f5f7363"

--0000000000006afb93060f5f7363
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 19, 2024 10:24:07 PM Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Jun 14, 2023 at 10:58:48AM +0300, Dmitry Antipov wrote:
>> Handle possible 'pci_enable_msi()' error in
>> 'brcmf_pcie_request_irq()', adjust related code.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
>> ---
>> v2: rebase against wireless-next tree
>> ---
>> .../net/wireless/broadcom/brcm80211/brcmfmac/pcie.c  | 12 ++++++++----
>> 1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> index 80220685f5e4..f7d9f2cbd60b 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
>> @@ -965,6 +965,7 @@ static irqreturn_t brcmf_pcie_isr_thread(int irq, void 
>> *arg)
>>
>> static int brcmf_pcie_request_irq(struct brcmf_pciedev_info *devinfo)
>> {
>> + int ret;
>> struct pci_dev *pdev = devinfo->pdev;
>> struct brcmf_bus *bus = dev_get_drvdata(&pdev->dev);
>>
>> @@ -972,16 +973,19 @@ static int brcmf_pcie_request_irq(struct 
>> brcmf_pciedev_info *devinfo)
>>
>> brcmf_dbg(PCIE, "Enter\n");
>>
>> - pci_enable_msi(pdev);
>> + ret = pci_enable_msi(pdev);
>> + if (ret)
>> + return ret;
>
> If the device supports INTx and MSI is disabled for some reason
> (booted with "pci=nomsi", ACPI_FADT_NO_MSI is set, etc), this change
> means the driver would no longer be able to fall back to using INTx.

Thanks, Bjorn

This was indeed my concern.

> If you want to go to the trouble of changing this code, you could
> consider using the new APIs:

I saw this mentioned in pci_enable_msi() kerneldoc, but didn't bring it up yet.

>
>  ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>  if (ret < 0)
>    return ret;
>
>  if (request_threaded_irq(pdev->irq, ...)) {
>    pci_free_irq_vectors(pdev);
>    return -EIO;
>  }
>
> plus the appropriate pci_free_irq_vectors() calls in other failure and
> remove paths.
>
> See 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/msi-howto.rst?v6.7#n93
>
>> if (request_threaded_irq(pdev->irq, brcmf_pcie_quick_check_isr,
>> brcmf_pcie_isr_thread, IRQF_SHARED,
>> "brcmf_pcie_intr", devinfo)) {
>> pci_disable_msi(pdev);
>> brcmf_err(bus, "Failed to request IRQ %d\n", pdev->irq);
>> - return -EIO;
>> + ret = -EIO;
>
> IMHO this part ("ret = -EIO" and "return ret" below) makes the code
> harder to read for no benefit.  The existing code returns -EIO
> immediately here and returns 0 below.  It's easier to read that than
> to follow the use of "ret".
>
> I guess that's just repeating what Arend already said; sorry, I hadn't
> read the whole thread yet.

No need to be sorry. Thanks for taking time to look at it and give your 
feedback.

Regards,
Arend

>
>
>> + } else {
>> + devinfo->irq_allocated = true;
>> }
>> - devinfo->irq_allocated = true;
>> - return 0;
>> + return ret;
>> }
>>
>>
>> --
>> 2.40.1




--0000000000006afb93060f5f7363
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCzMEzQrl8pszMMT0VF
mpiAscpeOvhCHbBHX8wvqMy/UTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMjAxMjA4MTJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAt8kakC5pAVzJrAL4oaaUEKiRP4hbF+qrJYFU
Y7X48x91Dz/M3bIsvtIA6ooN/kb0P5Rqeiw8nuLYMUodlcIIBPygCeiuSFmFauYKyglxbQ4Xl64P
FPIfA4BEdT1ayyOLydhppwnWJZxKwpOTi2yLz9zXhlyrrQFNh+IQP9r8leDKWsPL0qUCThAVol4Z
p4p/DVAe9e88fxfPu/bzIGO0Fw5uxxMVZmAuwMWD/EXO00E39IfqW765ACoIiAMGvtUKQy2x/26B
lchQAJoDdjkssrzzmoAgchSv4PPA7xJ6YFSMRIOI6lTRE3/Z+ri+0dEpziKLcxGFdf8mLY6bYkgS
jg==
--0000000000006afb93060f5f7363--

