Return-Path: <linux-wireless+bounces-4684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEE387AAC3
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 16:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C37A1C20E5C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5DC47A7C;
	Wed, 13 Mar 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgerAlKE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A847A5C
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710345220; cv=none; b=MV7+54NLfF6g6OzCQUtQM9zVop12AEml0dE69K0ilBJKnpXRWHvreBR+Agp3vgvimd51houe67mDAUYTgy4GQm+7h6uBC0tqtGFzyaWv7KZEIl0HnC/yqN5e8LWxwanijiW+VEF6gXZ2nymeXKscuquAazieB0bAhfIcBNmtZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710345220; c=relaxed/simple;
	bh=9l8ZaHlcOs0Mb7H3Uoqo+1qbmZyo/NlYfml5MB50UDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRcKJOpBR//TkvXT/8vDDoM1K1Ur/oZu4LaQnoiAaxrY22Zyor5p7sWR0YCJmc0GhzoS8IsySC90G0kad9Ev6Di1tLHUyMY4piQTTRhjFvqMgbhXLFDVhbNkc15OWXSrXSpJ3kp927SmRkUPCUHPgHV38oo7dqz7WwCK5m1KAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IgerAlKE; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dd045349d42so6361026276.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710345218; x=1710950018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6AzBQ+tLW2d59aDgYBNh01xhjYL/4GzcjrgAxlnqiSI=;
        b=IgerAlKEwLgmRqe4YY0OJ6G09/I8Yy1iNeGAS0eYkQK9aob7Gh4AB4beN7a8L9jmNF
         3grypvPXqAZQnBlyoMx5xHy8O4KI+Hyc5VlSu8xyFqsFGi7WJ6jywbylGBXwGWVCoZlr
         uorvNFQUCI4tTQYTTV5wMIoEkqXpUiEtRLiZxjoLwC2h4CCQYMvFa8Hrz+mXHrbAWurt
         4VAieWF6LISqj1HBNqJAHnhZjelJlGfRfJWm/YdHVgJioVXClUBHuXHENoyy20E/7Grc
         1/vJgwzJSb4SIxEt51jsremVyJT2QluXmeFZQXU3TL7WBsDHd5uS/ITA5P20qmSBpXfy
         5LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710345218; x=1710950018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AzBQ+tLW2d59aDgYBNh01xhjYL/4GzcjrgAxlnqiSI=;
        b=QCUW19fAb6k9eISqClMphFKmNO8VFtjFkcW7N5o4XCU9tB6U9KsQ1XT77zapULxsKc
         SngTmexI2GnHxpb+8xesKiX8lfgCh3eeX5ZOLu1sh3f2EWnk1vi7V5SrEsdtPmTKtn86
         m6//48W5USAgDjwSsk8zVjEpXUR/idrI9Dy7iDsNYC3c6uPubYaVeLZcsTZq7hkxnmqN
         YXS1nKT1K35ik8/Hkjb43XQODIvvmj30YhooeQY0+HBHkHWbQCtikvDwYx/63YD3Lxml
         f9My/jhJFqCWsYbLKKGNjweGS6Da5KmZKuDTpweAiaPGZJaht9TxJ0KRAP07jioKn4mF
         Lw4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqOkrexTvLQM2LYL7euf1T/J58k82rn/4bfoKx3MvBC3ps9W5JgqDxIiRqniCf7c11QdG6z8BJNqaUp/O7GCO+QFE6Ii1gmKW/043z5Rk=
X-Gm-Message-State: AOJu0Yy+Ee9onOR/6IeyYT2rKaaMF7ZOd+R4tNT5GyEKdXt26sUAwoN3
	uVNQGOPBGH6ZNYe06V1DIDX3sj0+RMqf+M3zxXuhGDGkzNAr2u1WaE1O78MmnP4qe1Ns14Bjuro
	XlXTX/6ygpgu8jKyzYv2bfs78CYWFFvPsd1As6g==
X-Google-Smtp-Source: AGHT+IFEXBYea2H7akvOYLZnU0E8yFk/kdMNNhRxZzxlLPLFxZd9tmb0mKfs/cS05ZdYc2wWKixhp6fXP1k2h0BiDjw=
X-Received: by 2002:a25:db85:0:b0:dd0:129f:16 with SMTP id g127-20020a25db85000000b00dd0129f0016mr3097478ybf.11.1710345217678;
 Wed, 13 Mar 2024 08:53:37 -0700 (PDT)
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
 <0816f7bb-3c97-4b90-8e19-191552ea6e26@freebox.fr> <87h6hk7aee.fsf@kernel.org> <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
In-Reply-To: <fb0ffdd9-923a-4191-8304-583243ad528b@freebox.fr>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 13 Mar 2024 17:53:26 +0200
Message-ID: <CAA8EJppHa=qEkKbSVs9hMCBXfhiC9MyAQO+v+6TCWhg==4CpOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k <ath10k@lists.infradead.org>, 
	wireless <linux-wireless@vger.kernel.org>, DT <devicetree@vger.kernel.org>, 
	Pierre-Hugues Husson <phhusson@freebox.fr>, Jami Kettunen <jamipkettunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 17:09, Marc Gonzalez <mgonzalez@freebox.fr> wrote:
>
> [ Dropping the DT fellows ]
>
> On 05/03/2024 20:20, Kalle Valo wrote:
>
> > Marc Gonzalez wrote:
> >
> >> I need to build a kernel + rootfs + FW to test the proposed solution,
> >> then I can spin a formal submission.
> >
> > Yeah, please do test this to make sure we are not missing anything :)
>
> I used buildroot ( https://buildroot.org ) to generate a kernel + rootfs
> for my board (a variation of qcom/msm8998-mtp.dts)
>
> Not sure if I must use the vendor FW blobs? Or if I can use the blobs
> from linux-firmware-20240115.tar.xz (as supported by BR2).
>
>
> All I see from the ath10k driver (with debugging cranked to the max) is:
>
> [    0.539801] ath10k_snoc 18800000.wifi: Adding to iommu group 0
> [    0.541941] ath10k_snoc 18800000.wifi: snoc xo-cal-data return -22
> [    0.543633] ath10k_snoc 18800000.wifi: supply vdd-3.3-ch1 not found, using dummy regulator
> [    0.544002] ath10k_snoc 18800000.wifi: qmi msa.paddr: 0x0000000094400000 , msa.vaddr: 0x(____ptrval____)
> [    0.544271] ath10k_snoc 18800000.wifi: snoc probe
>
>
> # ip link
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000
>     link/ether 34:27:92:82:48:ec brd ff:ff:ff:ff:ff:ff
>
> No wlan device at this point.

Do you have pd-mapper, rmtfs and tqftpserv running? You also need to
have wlanmdsp.mbn in the same directory as modem.mbn for your platform
(see how this is handled for sdm845).
If these points are implemented and you still don't have the wlan,
please check for tqftpserv messages in syslog.

>
> I got shell-shock from reading these setup steps:
>
> https://wiki.postmarketos.org/wiki/Qualcomm_Snapdragon_835_(MSM8998)#WLAN
> https://github.com/jhugo/linux/blob/5.5rc2_wifi/README

These readmes are mostly correct. You don't need qrtr now, it is
provided by the kernel.  pd-mapper (protection-domain-mapper),
tqftpserv and rmtfs usually can be installed from your distro.

You can mostly ignore the part for board.bin / board-2.bin for now.
You'll get to that point later, when the driver complains about
missing board data.

Also, if you pick up series at [1], you can put your bdwlan.XXX file
as ath10k/WCN3990/hw1.0/board.bin and skip all the json and stuff.
This will work for the bringup, then you can follow the process at [2]
and submit your file for inclusion into board-2.bin.

[1] https://lore.kernel.org/ath10k/20240130-wcn3990-board-fw-v1-0-738f7c19a8c8@linaro.org/
[2] https://wireless.wiki.kernel.org/en/users/drivers/ath10k/boardfiles

>
>
> Jeffrey, Bjorn, Konrad,
> Has someone written idiot-proof (such as myself) steps to enable
> the ath10k core on a msm8998 board?
>
> I'm still not quite sure where linux-firmware.git fits into all this.
>
> Regards
>


-- 
With best wishes
Dmitry

