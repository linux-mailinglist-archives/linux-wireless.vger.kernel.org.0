Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070C3C9F81
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 15:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfJCNdx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Oct 2019 09:33:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34964 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfJCNdx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Oct 2019 09:33:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4C098611BF; Thu,  3 Oct 2019 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570109632;
        bh=BhQc6BRfl0diz4Cietg+XTpvRy6X9NSbsfG4WqMHLqc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oeiKwtmwJgVBbqXfIinIKEPwMd04AzehgvnaUHUsXtoYeqOHpYNu5qC9LjA12NW+i
         BSznTILPG5KSsjMqz4Lz29c0Fu3W8wqkcTytsnh38AzX9onEYdcoySNpwSgcWCEpiy
         KORuMyHwkFymAIurnvwXpWzjClLm8wZhtv2oelqI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B83FE60AD9;
        Thu,  3 Oct 2019 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570109631;
        bh=BhQc6BRfl0diz4Cietg+XTpvRy6X9NSbsfG4WqMHLqc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SAp0srajaYD2gp/uHRXYqBtp+aj3gRCC+Vrb4ttoxVTJu8t50GuskljRqgzLhkyxF
         o8M7cRUqQlECM+1OURB0pBWtfDUJsAtNBdiytC32oPU1cgp+kJETNsT/ZRSw6wJtaF
         /hRKRj3R7h5PLbtdO5tc2sJVTjP8Yqq0J+P0PEW0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B83FE60AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: Fix ASPM L1 state on QCA988X
References: <1553025580-6118-1-git-send-email-pozega.tomislav@gmail.com>
Date:   Thu, 03 Oct 2019 16:33:46 +0300
In-Reply-To: <1553025580-6118-1-git-send-email-pozega.tomislav@gmail.com>
        ("Tomislav \=\?utf-8\?Q\?Po\=C5\=BEega\=22's\?\= message of "Tue, 19 Mar 2019
 20:59:40 +0100")
Message-ID: <87wodmgdhh.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(please always CC ath10k list so that ath10k patches are easy to find)

Tomislav Po=C5=BEega <pozega.tomislav@gmail.com> writes:

> On some systems there are heavy crashes if the kernel config
> option CONFIG_PCIEASPM_PERFORMANCE is not set. Patch provided by
> Sujith for ath9k fixes this issue and the card operates without
> crashes with kernel default CONFIG_PCIEASPM_DEFAULT option that uses
> BIOS provided ASPM settings. Tested with QCA9862 mPCIe card.
>
> Signed-off-by: Sujith Manoharan <c_manoha@qca.qualcomm.com>
> Signed-off-by: Tomislav Po=C5=BEega <pozega.tomislav@gmail.com>

So I'll summarise the discussion from patchwork:

https://patchwork.kernel.org/patch/10860301/

Sujith wrote this workaround first for ath9k and you ported it to
ath10k:

https://lore.kernel.org/linux-wireless/1377421989-21240-1-git-send-email-su=
jith@msujith.org/

https://git.kernel.org/linus/b380a43b52be

And you have PCI problems after QCA988X firmware has crashed on HP
Compaq 6735b laptop, apparently the device just does not respond on PCI
bus at that point. And this workaround solves the issue and you don't
have any problems anymore.

Please correct if I have misunderstood.

> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -2787,14 +2787,25 @@ static int ath10k_pci_hif_power_up(struct ath10k =
*ar,
>  				   enum ath10k_firmware_mode fw_mode)
>  {
>  	struct ath10k_pci *ar_pci =3D ath10k_pci_priv(ar);
> +	struct pci_dev *pdev =3D ar_pci->pdev;
>  	int ret;
> +	u32 val;
>=20=20
>  	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot hif power up\n");
>=20=20
> -	pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> +	if (ar->dev_id =3D=3D QCA988X_2_0_DEVICE_ID) {
> +		pci_read_config_dword(pdev, 0x70c, &val);
> +		if ((val & 0xff000000) =3D=3D 0x17000000) {
> +			val &=3D 0x00ffffff;
> +			val |=3D 0x27000000;
> +			pci_write_config_dword(pdev, 0x570c, val);
> +		}
> +	} else {
> +		pcie_capability_read_word(ar_pci->pdev, PCI_EXP_LNKCTL,
>  				  &ar_pci->link_ctl);
> -	pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
> +		pcie_capability_write_word(ar_pci->pdev, PCI_EXP_LNKCTL,
>  				   ar_pci->link_ctl & ~PCI_EXP_LNKCTL_ASPMC);
> +	}

Magic values are not nice, it's better to have proper defines. Sujith
already provided meaning for 0x70c, but I don't know what 0x570c means
(or I guess 0x500 offset)?

Also please use GENMASK() and FIELD_PREP(). Otherwise looks good to me.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
