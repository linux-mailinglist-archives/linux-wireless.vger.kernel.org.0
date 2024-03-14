Return-Path: <linux-wireless+bounces-4747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5A87BD0D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 13:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443B71F229C5
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303258AB4;
	Thu, 14 Mar 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+YziKXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6F18E20
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710420744; cv=none; b=NM6F3S00XclF4bnX6riVmXR1YE1wOnxn5FeSIEiVc9Teq2+ZIuvjL27VFG4ZP0K5xPWnzNkMznw7wX5eoGNamooi0FlPpovP7I2KkzddkWDG83GD14KNhOM3RsWoH+HzSFh2+tT6Yln1oTrc182Cwqy0psJX0dx62fEm8DabgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710420744; c=relaxed/simple;
	bh=t8XPGkgCCS1SphT8rzH9OgJMH9bG+rko2YF2P6c4yxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=logvMK5j3FNS8liO2IU3EkEnpLIh7qloakQFCF7ABhYSAWhnzFSPlMaqRualhY55Ub1uPyJVmSK/JGHPvZ7SUxblthpTtLat7AH5HFkMlYaPUtr5KcrY1Zp4SXaCB6SZR3dggPoGI3maOBVvfAvcynkPgb0GNJLlbEhf9b5dsiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+YziKXH; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso798840276.0
        for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 05:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710420742; x=1711025542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OpakeXG7lnYh4AwqEGI18Zf+2/wDYzbFbSRJoPHhJPI=;
        b=Q+YziKXH603ZClsUkVpcdstTwvvRpAgQaZulkiT9arMUtbgxC7iW4y0A2GKyq0mGu1
         9TrpuIK4ZHry15eCBM7KCKKGMtGjN8nn92ImOixEspo/+jRf2rk1ZSFLUOiTCj6G1GFp
         9RIPhtBtVT+g7w+Bi3Ngu9BcrkFJRWwloO1hF6rsL2S9hRatvl4LjwhU+/2zePtd0IjV
         W8AzDLYA5S0/TPwRxXxrffq5lPP2JK9FZsmRnD1zGEhwOM21IABkuSP+duK42XjiIb0G
         P/vkx3mTQeTpTR4ZdS2bkXhJN+9IuZHKF1YXR/8YZHY3gESZCm68cNQP0QGBfhTpli4d
         TDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710420742; x=1711025542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpakeXG7lnYh4AwqEGI18Zf+2/wDYzbFbSRJoPHhJPI=;
        b=voEJF5s1lwEybGKltFSA+/dPuf/y8VcqDiez/Pj6y7cTHrsyksx09urC5o98kdxR3T
         XlxBP2ca0hRWGJdl5kMZjf+uXhpDLXlIA41NCB1m4hsddqQEhotGCr9cuSAFu+ibVWMo
         zOHTn9EtzVZ58Uq5y5Ky7HGO8aw+HLrLExReebnyBbFDjHsONh42eglfszKHtGLpWRBe
         mZuQAWpvcSHSpzWspYhw2ohKKiPtNnCqyVr271EUWh/FgXMuDhqtNWCOnGcJR4QOmk4A
         wyxjQSSCSdoErZGsrT5cO5H46x9otMFnY0m7BK69gz1YrvhRmq/5GmndZFNYjCNAS7c7
         qaAA==
X-Forwarded-Encrypted: i=1; AJvYcCXxgStJxUux/U+U48zTJGVins7V99rhBB1o0DqBDnQdHaaRd9cdxM6duTffspmxSEJ8cdQ0E8ZsBXoQqaGNTdgaptYGROOKLuo+yTyqyh8=
X-Gm-Message-State: AOJu0YyHNU6G5+FOFbNTnWsR2NDMSjR0G3K3JHGz2Tq9PMzY8T5LFssf
	4YaJ1j4noTiptQqa6lCAbqZCtHTBfAtlJ3MllHiwLgQNo7EkDR0ogvh0AIJV0AGLrOL2DveJetE
	e+NF/1yy2tcIuHR/LEfx3rp1H5eFqv5bMlpAJRA==
X-Google-Smtp-Source: AGHT+IH+AbXJKIsJ0K+qf80CaawJtfQeiqz1IfY0TFyU81iVTRDOnCMRBXQi+u9EeWwxdv5UGjnYpNKHt4w0xxHRDWA=
X-Received: by 2002:a05:6902:e13:b0:dcc:9e88:b15 with SMTP id
 df19-20020a0569020e1300b00dcc9e880b15mr1697730ybb.41.1710420742226; Thu, 14
 Mar 2024 05:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr> <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr> <87wmqoilzf.fsf@kernel.org>
 <c58e67e6-6a7f-4963-86b9-580165bf05ba@freebox.fr> <87cyse8j9m.fsf@kernel.org>
 <6d4b1381-c121-4cda-a8c9-9ccac56bd447@freebox.fr> <87plw87nsc.fsf@kernel.org>
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org>
 <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr> <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
 <d23b5fc5-9fc2-4841-8eb9-b22a28f05f69@freebox.fr>
In-Reply-To: <d23b5fc5-9fc2-4841-8eb9-b22a28f05f69@freebox.fr>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 14 Mar 2024 14:52:10 +0200
Message-ID: <CAA8EJprgZkZcesT7WNwpYx_Lg3w9xkTxQmq5-bPyhbvECLkQCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k <ath10k@lists.infradead.org>, 
	wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>, 
	Pierre-Hugues Husson <phhusson@freebox.fr>, Jami Kettunen <jamipkettunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 14:31, Marc Gonzalez <mgonzalez@freebox.fr> wrote:
>
> On 13/03/2024 16:53, Dmitry Baryshkov wrote:
>
> > On Wed, 13 Mar 2024 at 17:09, Marc Gonzalez wrote:
> >
> >> On 05/03/2024 20:20, Kalle Valo wrote:
> >>
> >>> Marc Gonzalez wrote:
> >>>
> >>>> I need to build a kernel + rootfs + FW to test the proposed solution,
> >>>> then I can spin a formal submission.
> >>>
> >>> Yeah, please do test this to make sure we are not missing anything :)
> >>
> >> I used buildroot ( https://buildroot.org ) to generate a kernel + rootfs
> >> for my board (a variation of qcom/msm8998-mtp.dts)
> >>
> >> Not sure if I must use the vendor FW blobs? Or if I can use the blobs
> >> from linux-firmware-20240115.tar.xz (as supported by BR2).
> >>
> >>
> >> All I see from the ath10k driver (with debugging cranked to the max) is:
> >>
> >> [    0.539801] ath10k_snoc 18800000.wifi: Adding to iommu group 0
> >> [    0.541941] ath10k_snoc 18800000.wifi: snoc xo-cal-data return -22
> >> [    0.543633] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not found, using dummy regulator
> >> [    0.544002] ath10k_snoc 18800000.wifi: qmi msa.paddr: 0x0000000094400000 , msa.vaddr: 0x(____ptrval____)
> >> [    0.544271] ath10k_snoc 18800000.wifi: snoc probe
> >>
> >>
> >> # ip link
> >> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
> >>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> >> 2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
> >>     link/ether 34:27:92:82:48:ec brd ff:ff:ff:ff:ff:ff
> >>
> >> No wlan device at this point.
> >
> > Do you have pd-mapper, rmtfs and tqftpserv running? You also need to
> > have wlanmdsp.mbn in the same directory as modem.mbn for your platform
> > (see how this is handled for sdm845).
> > If these points are implemented and you still don't have the wlan,
> > please check for tqftpserv messages in syslog.
>
> I first tried using buildroot, which doesn't package these tools AFAICT.
> I have now generated a debian rootfs, which does package them.
>
>
> >> I got shell-shock from reading these setup steps:
> >>
> >> https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_835_(MSM8998)#WLAN
> >> https://github.com/jhugo/linux/blob/5.5rc2_wifi/README
> >
> > These readmes are mostly correct. You don't need qrtr now, it is
> > provided by the kernel.  pd-mapper (protection-domain-mapper),
> > tqftpserv and rmtfs usually can be installed from your distro.
>
> Can you explain a little bit why all the steps are required
> just to be able to talk to the ath10k IP block?
>
> It's just an MMIO device, right?
>
>                 wifi: wifi@18800000 {
>                         compatible = "qcom,wcn3990-wifi";
>                         reg = <0x18800000 0x800000>;
>                         reg-names = "membase";
>
> Is the IP block behind some kind of switch that must be programmed
> by a remote processor on the SoC?

It has a separate core, with the firmware to load, etc. For some
reason the firmware is loaded in a complex way, via the modem
remoteproc.


-- 
With best wishes
Dmitry

