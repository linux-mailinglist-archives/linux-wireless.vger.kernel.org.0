Return-Path: <linux-wireless+bounces-30397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2ACF860B
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C160301D0F7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 12:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DB93254BD;
	Tue,  6 Jan 2026 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBijw961"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13380256D
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703119; cv=none; b=j7GnYReGA7zS3yTtKFrWs1UKsw5KiQAqx5mIJ+eaQ2+2kqAh0aIptkOBl5BrwlFw+zoSQXBw6616+HTEgYATHJ6693vrmdemJa3q0rxImDTQVyv72tcWyrTPRzauHf3eJflIJp7GKgetP9MgJxn2sr+BIqK+Ftw3BIqUFEsBSSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703119; c=relaxed/simple;
	bh=/WJ3FXylxb75JjfkAYrSDskdl0Pr5JcXSOfrWa9vX2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=spvmHpEGqtjUTvf3jB0YLURKw3qQopJRNqODVDYhFySfjnCW8ZBU1ddihuF7cuk9lSYguqrYZbye0Ow9zIbyiahFTCBp2/ZYW4gP0qA65SRMZpb7WoUJIK/31GkEoTs1WJqYgzmggBlNbGk1Cpojw7eGkIc4IgJo3JFa1PPkdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBijw961; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB0C4AF0B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767703118;
	bh=/WJ3FXylxb75JjfkAYrSDskdl0Pr5JcXSOfrWa9vX2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eBijw961FdVqdQ5lzqU/ESM00AOiadOqx+ua0ZRGi8NdxZOi0LmsS4uMs8po6Cb0O
	 5TMhTC1pqRmu5yMhNHRR+d9WYEpa5PYeh2yArJhCA70XzCJpBcWfx41mNkMu0g87H7
	 xo89EoRPkf34wKF1WWhYht/GJw/1OcOhYW0wZp+ouQonriPSRbIJVqOczclQENQpIe
	 N8Gjs/7c0iTXE66WYqZPBMwfi2/XNAtnLCMO3RPd6DP97ZzSdEoYSqQ4ZTSfsUnQ12
	 xGnHMMTQLsb/EQJU/s/eAr+K2BKAJOufY6CAyLHUMxqYPkOXol0F+D/fjg/dimDcik
	 qXCIufIZGv6/A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5945510fd7aso739304e87.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 04:38:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWroxqiJba1sw1VlL5hB8zYQH+nKw1/TE8D3iim4TwCEAEWPg6yzaRMpg6uYVmg95eWAK9bryMayDRhhaJ70g==@vger.kernel.org
X-Gm-Message-State: AOJu0YynDyUzbnEkVvD+H3GCECVoFHUq/Zp2aep5WZqsNg9W+q0rSlYg
	vSqP7ev6lH0lUrWrWnHpZmwy09KZaa3wDWhtrVsVr3jX5wFDpK6OjC/VXB6llUTRhDGcomoC62c
	ncLUp0pXR2lKU4i8vr0d/GNXkhhp4o48Fm3d+3xVXBQ==
X-Google-Smtp-Source: AGHT+IH/5oi/Mm4ylt/aH4A15j/ljVlSgxeG2MAOav7Sf6QITgCC+i0rM7ktFn11IEgwttpux/NAggqCjE5gcEsv344=
X-Received: by 2002:a05:6512:4010:b0:598:f2e1:f616 with SMTP id
 2adb3069b0e04-59b652b8202mr751335e87.29.1767703117392; Tue, 06 Jan 2026
 04:38:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com> <20260106-wcn3990-pwrctl-v2-3-0386204328be@oss.qualcomm.com>
In-Reply-To: <20260106-wcn3990-pwrctl-v2-3-0386204328be@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 6 Jan 2026 13:38:25 +0100
X-Gmail-Original-Message-ID: <CAMRc=McxGOejmegC9KaNLpCbxSL_CWmPC2PwfQGxQ+vaHg+rOw@mail.gmail.com>
X-Gm-Features: AQt7F2rrsJVu7GLT96AFg8gb0rDx8lEL223Ap08R9PVwfe0DiaVCdXK84QTL9yQ
Message-ID: <CAMRc=McxGOejmegC9KaNLpCbxSL_CWmPC2PwfQGxQ+vaHg+rOw@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] Bluetooth: qca: fix ROM version reading on
 WCN3998 chips
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:01=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> WCN3998 uses a bit different format for rom version:
>
> [    5.479978] Bluetooth: hci0: setting up wcn399x
> [    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
> [    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
> [    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
> [    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
> [    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
> [    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> [    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
> [    6.842948] Bluetooth: hci0: QCA setup on UART is completed
>
> Fixes: 523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 7c958d6065be..86a48d009d1b 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -804,6 +804,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baud=
rate,
>          */
>         if (soc_type =3D=3D QCA_WCN3988)
>                 rom_ver =3D ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver &=
 0x0000000f);
> +       else if (soc_type =3D=3D QCA_WCN3998)
> +               rom_ver =3D ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver &=
 0x0000000f);
>         else
>                 rom_ver =3D ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver &=
 0x0000000f);
>
>
> --
> 2.47.3
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

