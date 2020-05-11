Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B61CE244
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 20:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgEKSIo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 14:08:44 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57366 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729564AbgEKSIo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 14:08:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589220524; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=waBghC/CDXh2/ZO+eWu/vgzCF6wGxBCdYtnPFKHehFs=; b=xdXLCHVxy+AcdqWN8THwPJtTDLxEwY1N2qwF3A8aXKm0GFYw3et/0q3TN8H09/3LaxGAQsYx
 FxSBfwnAgGh6Qcb1q/LWzSJbCaqRrlC1Rxh3SVDT7XusLIvc6WSo7leddHSqxnMc8XEb1C+8
 vTnktZfIRpIHbWzRkMMEI35dV7o=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb9949e.7f47cf2cdf10-smtp-out-n01;
 Mon, 11 May 2020 18:08:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F3B91C433BA; Mon, 11 May 2020 18:08:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0458BC433CB;
        Mon, 11 May 2020 18:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0458BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] ath11k: Register mhi controller device for qca6390
References: <20200508085850.23363-1-govinds@codeaurora.org>
        <20200508085850.23363-5-govinds@codeaurora.org>
Date:   Mon, 11 May 2020 21:08:24 +0300
In-Reply-To: <20200508085850.23363-5-govinds@codeaurora.org> (Govind Singh's
        message of "Fri, 8 May 2020 14:28:50 +0530")
Message-ID: <878shy4a5j.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Govind Singh <govinds@codeaurora.org> writes:

> MHI is a communication protocol to communicate with external
> Qualcomm modems and Wi-Fi chipsets over high speed peripheral buses. Even
> though MHI doesn=E2=80=99t dictate underlying physical layer, protocol an=
d mhi stack
> is structured for PCIe based devices.
>
> Register directly with mhi core layer as a mhi device driver for
> firmware download.
>
> Tested QCA6390 on X86 platform.
> Tested firmware WLAN.HST.1.0.1.c1-00440-QCAHSTSWPLZ_V2_TO_X86-1.
>
> Signed-off-by: Govind Singh <govinds@codeaurora.org>

[...]

> +int ath11k_pci_start_mhi(struct ath11k_pci *ar_pci);
> +void ath11k_pci_stop_mhi(struct ath11k_pci *ar_pci);
> +int ath11k_pci_register_mhi(struct ath11k_pci *ar_pci);
> +void ath11k_pci_unregister_mhi(struct ath11k_pci *ar_pci);

The schema for filenames is this:

ath11k_<filename>_<functionname>

So I changed all functions in mhi.c to follow that.

> +static int ath11k_pci_qca6x90_powerup(struct ath11k_pci *ab_pci)
> +{
> +	return ath11k_pci_start_mhi(ab_pci);
> +}
> +
> +static void ath11k_pci_qca6x90_powerdown(struct ath11k_pci *ab_pci)
> +{
> +	ath11k_pci_stop_mhi(ab_pci);
> +}

These looked like useless functions so I removed them.

> +static const struct ath11k_hif_ops ath11k_pci_hif_ops =3D {
> +	.power_down =3D ath11k_pci_power_down,
> +	.power_up =3D ath11k_pci_power_up,
> +};

I added __always_unused as a temporary solution to avoid a compiler
warning, but we should remove that once we really use this.

> @@ -229,14 +313,26 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>  		goto err_free_core;
>  	}
>=20=20
> +	ab->mem =3D ab_pci->mem;
> +	ab->mem_len =3D ab_pci->mem_len;
> +
>  	ret =3D ath11k_pci_enable_msi(ab_pci);
>  	if (ret) {
>  		ath11k_err(ab, "failed to enable  msi: %d\n", ret);
>  		goto err_pci_free_region;
>  	}
>=20=20
> +	ret =3D ath11k_pci_register_mhi(ab_pci);
> +	if (ret) {
> +		ath11k_err(ab, "failed to register  mhi: %d\n", ret);
> +		goto err_pci_disable_msi;
> +	}
> +
>  	return 0;

I added a warning here that PCI is work-in-progress. Oh, I need to add
that also to Kconfig.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
