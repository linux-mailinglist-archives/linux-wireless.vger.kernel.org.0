Return-Path: <linux-wireless+bounces-30284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A452CEE348
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D10CB300DCBF
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC12DEA77;
	Fri,  2 Jan 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMcF12wg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5312DC35C
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351125; cv=none; b=GDk6RUaHNIPkTJkMp3R48cwgHMAyjrKFH8N8Tu2qnbEsJizn5OylK1DSntN2/K6XfYE6q2o5sD/tQ4QNpva+VG6UOnqpEB56lrLnoyMY+b5O7S+5Od7X5aW+zIV2NPok2s4wLlshEcgSQmPy4t+zIp/8btEEbcr/NPtC5QcQcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351125; c=relaxed/simple;
	bh=xXAn347RsD6hgQZouoWZ55FlGcQUQLUmECm4fuYlljE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fvGbxMAT7hOWIkzHT6/8fKVY7p/DS6Y6J2IJT0FWn9Vh3pBZ6MY/HZM9boguXUVJufQhy0plcXFFW72H6NudV+QT2Xu/utRjXPQnLG///rKUnAsfAw7qGQ6f587+zaqKW8lIgJO5vjc090pOEMYo2krK1r6vzMhTUW+9Sz+wIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMcF12wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C51C2BC86
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351124;
	bh=xXAn347RsD6hgQZouoWZ55FlGcQUQLUmECm4fuYlljE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cMcF12wgtYhlzl3OOC513tR9kI9YefWSLw6YLI3AnXUMeelHrOOT4o+H0j0sNKARv
	 Zs1/81nmx3Wl6bc+FmsVPDXOLJSNr6OfB8t2kkxf5FkgzepQ2iBV1MizSmnuaO7ePC
	 RQthPeORjpyl49BIEsKNXPi+P7NAqjbOgQz5ugkqFLk/6l4wyphx1FmGJmTQRYH5Lk
	 +Fk973WN8BwfCra57/+VnE5j+0UHmcYO7HWfIy2hOUjaLtMxQTOOQE+ETLo7ZT7ICW
	 yxvxwhGJknjpsm3uNDgUAnOP7ywqgZOI+5/ZZhHP4E/Z/2iiSd+nWp/jBNm2pUE79S
	 SIZRiw6uk26ww==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a33b06028so100967091fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 02:52:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLsvvQXeaxRVcXYEzAHMvAGRlZVTiolojB9m7EIReztmnBhKCY9z2dG1Gs958qiOBu8oVNLuDla8/5xFOOeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzezUzWQsOYGpmgAWxBfJ4SX68dqNrUyQr/HMVyb6SKa6HL8+xS
	81EFjuBU+YDDg4M4LGRgUlpbLe7O/QLM35hIYh1ipiX7AkvOdsINQNpNCzKioItdTaAGqAcLw+C
	S3ZaJJSBPFbi2XoPba0GR6S5sVHUoE/RvvYS8FDmdLQ==
X-Google-Smtp-Source: AGHT+IGEB230wg4WPQ884wIw4d+xKW3xm3mX9tpow6yKELEID6v10VfXcSi9Pm/TOi4IGufi44ofR27WYzi/tTVG1Cg=
X-Received: by 2002:a05:651c:3244:b0:37f:cc5b:de41 with SMTP id
 38308e7fff4ca-3812158ffddmr117742161fa.9.1767351123504; Fri, 02 Jan 2026
 02:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-14-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 11:51:51 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeT8PH+TXX9pYgqb3eo61zt0JqorRDSJV-LPNDmuwyYFQ@mail.gmail.com>
X-Gm-Features: AQt7F2pouAlQJ-sMEsiHWRttM9wH4yG7LpdTIHvF2QWzScSglHBPWDDULB8nrvY
Message-ID: <CAMRc=MeT8PH+TXX9pYgqb3eo61zt0JqorRDSJV-LPNDmuwyYFQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] arm64: dts: qcom: sm8150-hdk: describe WiFi/BT properly
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

On Wed, Dec 31, 2025 at 12:36=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> Properly describe the PMU present as a part of the onboard WCN3998
> WiFi/BT chip. Enable Bluetooth part of the chip too.
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
> [   81.510709] ath10k_snoc 18800000.wifi: qmi chip_id 0x30224 chip_family=
 0x4001 board_id 0x55 soc_id 0x40060000
> [   81.521713] ath10k_snoc 18800000.wifi: qmi fw_version 0x32040163 fw_bu=
ild_timestamp 2019-10-08 05:42 fw_build_id QC_IMAGE_VERSION_STRING=3DWLAN.H=
L.3.2.0-00355-QCAHLSWMTPLZ-1
> [   81.554143] ath10k_snoc 18800000.wifi: failed to fetch board data for =
bus=3Dsnoc,qmi-board-id=3D55,qmi-chip-id=3D30224,variant=3DQualcomm_sm8150h=
dk from ath10k/WCN3990/hw1.0/board-2.bin
> [   85.467464] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target 0x00000008=
 chip_id 0x00000000 sub 0000:0000
> [   85.478132] ath10k_snoc 18800000.wifi: kconfig debug 0 debugfs 0 traci=
ng 0 dfs 0 testmode 0
> [   85.487223] ath10k_snoc 18800000.wifi: firmware ver  api 5 features wo=
wlan,mgmt-tx-by-reference,non-bmi crc32 b3d4b790
> [   85.758168] ath10k_snoc 18800000.wifi: htt-ver 3.73 wmi-op 4 htt-op 3 =
cal file max-sta 32 raw 0 hwcrypto 1
> [   85.901630] ath10k_snoc 18800000.wifi: invalid MAC address; choosing r=
andom
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

