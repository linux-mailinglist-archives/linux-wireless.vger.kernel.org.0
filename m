Return-Path: <linux-wireless+bounces-37295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGdkCQGQHmodlAkAu9opvQ
	(envelope-from <linux-wireless+bounces-37295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 10:10:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B262A3BD
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 10:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C06A5302BE8D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4463BBA0B;
	Tue,  2 Jun 2026 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzNDbDXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B943BB108
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387220; cv=none; b=AkKhLcqdrIgBjlZ9NDoNNhNikbo4e3/WJTQpraH+d8jbjJsOHgYaBU2meaEvK4Tsrk8VBom6yIQR/vNICzhRYAj2FHIwW50825HpvdEMH82P+0bTxp/vVDD4kG78Jjb1Pary6+KKY9eOGY1Fi3aUSBDRtXDQTK7Ezzn/0L82j0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387220; c=relaxed/simple;
	bh=37KTjZRL4G5Ngm5H44pJADKwMDqne/yoFzMJDKE33lg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OP7bX2kP9uLphp/QynRddTkLVcJ59fLzGyeDJA4Dm5b3doMaYIPozCJnckMWQiT0e3sp91bk+mQbv0x+lYwl2+Lr75HEB1bm9kh8yWX3SvZBbio+7nYI6d44mHF21bTYWlO26GEqw5LnRQYwrT3WQb8p1mH3U8LdfcpZ4NYhTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzNDbDXU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD041F0089B
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 08:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780387218;
	bh=YcHbUW0/z6MxMlX2QsScaV0gwWaW5ODpoWMz4NoUgZw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=KzNDbDXUP0/GMeHK0OA58vp1P+iuRNQD3rXvWS3Jv2YLR3nFB6b/Fsx3qmeJ9uDtY
	 ST49GW2bUSnc6WwFndPZPApLCXbsnR06mrP4zB8k9T249WuHHDIXZRQiHvHqBOkV2c
	 5jaQVnUAyYkqjMmE2dY9YINfcGHjlYu8PtkJHoYBAaSvW+1FTUn0ScSt2Ato0gHTc6
	 rm7b5UIX8yQAUqd24jQ8X7TVgQKKjYa1zo+yjfKih3vuOduO5hmqKKLibfOyOFsTX2
	 hQOWS5oS67SUnmx0GLc6u8uoqOBQ4p2/bY9LxIpEsAvtSXRpyUcjmKkNX1FGrOd1CQ
	 qceuqgMB41GDA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3966c0d5ac9so27889131fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 01:00:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ktsgWka3OsmKS4L1QKuRI9iPYVnCN9NCB0QchAC46QulbT9zaq0aHMVoxua4+Ed2rEkA7lKTvRTXmlgqiKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvUHBkBKIph/0MoC23cZ/kHjHN8JTfuJSqzuesvheAtWqlQC5
	a85hiU+ObrF/bFF1GM5JoZt0P5qun54czg61IKxZtG0wLFQCiQCExh2xiVJJVOjzbBPs+3MnUIM
	ctappSg1ZAb2Zi5Ympa9nJRH+IcUMe6nfEnLpyfCQhg==
X-Received: by 2002:a2e:8614:0:b0:396:9630:5ed with SMTP id
 38308e7fff4ca-3969a81a943mr7988131fa.15.1780387217586; Tue, 02 Jun 2026
 01:00:17 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 03:00:15 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 03:00:15 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com> <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 03:00:15 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfmosOiaYONd1Cs_G8M4bgL6k844gmANUD-tg_H+VcEqA@mail.gmail.com>
X-Gm-Features: AVHnY4LpWcxff9jncmRnjmUuLE6aaoj7VaQIrr97syxQJ21dl10x_BOM0i6sA48
Message-ID: <CAMRc=MfmosOiaYONd1Cs_G8M4bgL6k844gmANUD-tg_H+VcEqA@mail.gmail.com>
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, devicetree@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37295-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bgdev.pl,kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E5B262A3BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 11:46:55 +0200, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> said:
> The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
> version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
> parts of the device.
>
> The firmware isn't (yet) available as a part of linux-firmware, so it
> was verified with the firmware files from the vendor-supplied package
> (wcn prefix was applied to Bluetooth firmware files to make them follow
> upstream driver changes, vendor provided hpbtfw10.tlv and hpnv10.b06).
>
> Bluetooth: hci0: QCA Product ID   :0x00000013
> Bluetooth: hci0: QCA SOC Version  :0x400c0110
> Bluetooth: hci0: QCA ROM Version  :0x00000100
> Bluetooth: hci0: QCA Patch Version:0x00001017
> Bluetooth: hci0: QCA controller version 0x01100100
> Bluetooth: hci0: QCA Downloading qca/wcnhpbtfw10.tlv
> Bluetooth: hci0: QCA Downloading qca/wcnhpnv10.b06
> Bluetooth: hci0: QCA setup on UART is completed
> Bluetooth: hci0: HFP non-HCI data transport is supported
>
> ath11k_pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x605fffff 64bit]: assigned
> ath11k_pci 0000:01:00.0: MSI vectors: 32
> ath11k_pci 0000:01:00.0: wcn6855 hw1.1
> mhi mhi0: Requested to power ON
> mhi mhi0: Power on setup success
> mhi mhi0: Wait for device to enter SBL or Mission mode
> ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x6 soc_id 0x400c0110
> ath11k_pci 0000:01:00.0: fw_version 0x110c80c8 fw_build_timestamp 2021-05-25 21:43 fw_build_id WLAN.HSP.1.1.c3-00200-QCAHSPSWPL_V1_V2_SILICONZ-1
> ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
>
> For the reference, the driver looks for the board data for
> bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=0,qmi-board-id=6,variant=QC_8350_HDK
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

