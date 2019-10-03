Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B463C9FF8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 16:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfJCOBj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Oct 2019 10:01:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45858 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfJCOBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Oct 2019 10:01:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id o205so2633796oib.12
        for <linux-wireless@vger.kernel.org>; Thu, 03 Oct 2019 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xbl2FVDV/NRDS6TRrMIuIQnHaMA9j+8M/vbEhytQez0=;
        b=uErh8nrK1Rs0KHN+obi/qdELNSpKYpzBn8koOfceCkJVWTVpbNiP46flbubxGRXUDc
         cR6hCdWYmUHMZrJDF+4Z+Iq3euNopfgyXB07pSdYUTJPR65bqetkW2L60WPHAxIfjZHk
         YCjZc1ABi5OVMy24FahqAhNFRSibUJOOk4gyz45cow1U7h250+/UiIoqCXD8WRiv0gnv
         garCRttau3lmFyRIkaGl4S/pszqE8b5VkexGS4wgTfWSPAiTHxEhow5nhtDkNZzJJiHX
         8er50thFFqK8iEKqrSQn7cMZJPtP1svTDzyY3pk4NTQre5QmRiB/4fRvskLFZqTx8XFx
         UhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xbl2FVDV/NRDS6TRrMIuIQnHaMA9j+8M/vbEhytQez0=;
        b=lhlkbNRNxwFsogNPq2rGiI/B5jVjmoJIV589Of5+4VG2kAoRxrqTHDB4m9eS58mfLT
         ny2f0JS4WKG5rt9TNPbBkSuy0jr3Rf+vvVs60IOc+5VRQN9HZlpO4WYX4VDrTvuT7b3v
         IrCxMn9BnlucOj9oWSiBw4nD09uv+zH9krasmNgQx1WfG+19dyjmwhOBhCqLTYplaqyd
         k3bPIAG6q5/qaBMH+mnelWWb1xshGNrqMc+H+o+GrZXpyLj33j0X4vhdiZJqFY74TblB
         R8LHAj4M5xdPlnFhl5ZQHSSn4C5ch/Gy3xyENbHSqZo4SDfn+LwkZMgBZK2hM8Y4Vyxh
         xjmQ==
X-Gm-Message-State: APjAAAWS40RkKUCANUpktVgXV4kJIGdMf2oes2IJzZRteDJCh7C45CjM
        fUYLECdqaZUFE2XF/ANjhd3H5wddf2WxpC6T3n0=
X-Google-Smtp-Source: APXvYqzkKQ4SM5WDnCFERLLU+BzE1d3/Gg0x7itFys0N71kFzpge/0jV++4cn4A7IWK5YPPcYqR4rsrAcaeEVr7zw0s=
X-Received: by 2002:aca:a88e:: with SMTP id r136mr3020734oie.30.1570111296850;
 Thu, 03 Oct 2019 07:01:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2286:0:0:0:0:0 with HTTP; Thu, 3 Oct 2019 07:01:35 -0700 (PDT)
In-Reply-To: <87wodmgdhh.fsf@tynnyri.adurom.net>
References: <1553025580-6118-1-git-send-email-pozega.tomislav@gmail.com> <87wodmgdhh.fsf@tynnyri.adurom.net>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 3 Oct 2019 16:01:35 +0200
Message-ID: <CAKR_QV+mJKoP1MGdw3GYA5NHG00DOj00tRC0KTCnM9txXev8Qw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Fix ASPM L1 state on QCA988X
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 03/10/2019, Kalle Valo <kvalo@codeaurora.org> wrote:
> (please always CC ath10k list so that ath10k patches are easy to find)
>
> Tomislav Po=C5=BEega <pozega.tomislav@gmail.com> writes:
>
>> On some systems there are heavy crashes if the kernel config
>> option CONFIG_PCIEASPM_PERFORMANCE is not set. Patch provided by
>> Sujith for ath9k fixes this issue and the card operates without
>> crashes with kernel default CONFIG_PCIEASPM_DEFAULT option that uses
>> BIOS provided ASPM settings. Tested with QCA9862 mPCIe card.
>>
>> Signed-off-by: Sujith Manoharan <c_manoha@qca.qualcomm.com>
>> Signed-off-by: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>
>
> So I'll summarise the discussion from patchwork:
>
> https://patchwork.kernel.org/patch/10860301/
>
> Sujith wrote this workaround first for ath9k and you ported it to
> ath10k:
>
> https://lore.kernel.org/linux-wireless/1377421989-21240-1-git-send-email-=
sujith@msujith.org/
>
> https://git.kernel.org/linus/b380a43b52be
>
> And you have PCI problems after QCA988X firmware has crashed on HP
> Compaq 6735b laptop, apparently the device just does not respond on PCI
> bus at that point. And this workaround solves the issue and you don't
> have any problems anymore.
>
> Please correct if I have misunderstood.
>
>> --- a/drivers/net/wireless/ath/ath10k/pci.c
>> +++ b/drivers/net/wireless/ath/ath10k/pci.c
>> @@ -2787,14 +2787,25 @@ static int ath10k_pci_hif_power_up(struct ath10k
>> *ar,
>>  				   enum ath10k_firmware_mode fw_mode)
>>  {
>>  	struct ath10k_pci *ar_pci =3D ath10k_pci_priv(ar);
>> +	struct pci_dev *pdev =3D ar_pci->pdev;
>>  	int ret;
>> +	u32 val;
>>
>>  	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif power up\n");
>>
>> -	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
>> +	if (ar->dev_id =3D=3D QCA988X_2_0_DEVICE_ID) {
>> +		pci_read_config_dword(pdev, 0x70c, &val);
>> +		if ((val & 0xff000000) =3D=3D 0x17000000) {
>> +			val &=3D 0x00ffffff;
>> +			val |=3D 0x27000000;
>> +			pci_write_config_dword(pdev, 0x570c, val);
>> +		}
>> +	} else {
>> +		pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
>>  				  &ar_pci->link_ctl);
>> -	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
>> +		pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
>>  				   ar_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
>> +	}
>
> Magic values are not nice, it's better to have proper defines. Sujith
> already provided meaning for 0x70c, but I don't know what 0x570c means
> (or I guess 0x500 offset)?
>
> Also please use GENMASK() and FIELD_PREP(). Otherwise looks good to me.
>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>

I don't think the old patch from ath9k is that much relevant in this
bug case at all, since by applying it the way it is the patch actually
prevented ASPM code from execution (moved after } else { ) on
QCA988X_2_0 devices. The ASPM enable code that was commited years ago
causes regression as I've already wrote, and reverting that commit is
sufficient to have card operating properly.
When that is handled properly, this patch can then be added before or
after the ASPM enable code. Also, since the read value will obviously
differ from system to system, something like this could be used:

if ((val & 0xff000000) !=3D 0x27000000)

0x570c should refer to programming address for this register, at least
according to reference driver.
