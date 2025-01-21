Return-Path: <linux-wireless+bounces-17784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1069FA17A7E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4227B161FC9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA7166307;
	Tue, 21 Jan 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmDW4sjo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A961B3927
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737452934; cv=none; b=ReNiMexBbl3PHHELNny1hl7zC4YA9Y+l2YwHea0JWhSGOua4Kc7gXV2oNqct72MPPGpUC0jvb6RN/mhtCSBRBglzmI6ij/ORLQLSRav8FqiWrnxm9jSnpAIuK5IH+x5FdOEPcYwh8tel13BfMHcHgsq4atzCHANcxAe9GnfxNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737452934; c=relaxed/simple;
	bh=t9xOXzZTKO+ZBse5+nuPInJomAHN3dC99HiCBavXd1o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=KfYFRciyZd+snbLNvvvx13FtbzRBDWiJnUpKG67vN7MiPd/6vlb8kWkoZEVYrfaS+h6qlQGVhFMcL6/OjWsoAfHluzWkuJXnGAfZPbVO3Ll58W/Tyahn+qblUSPavM+Ig+bDCqxbumTW23Z7+XS4epHTA5F40fzjFdeJz9thIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmDW4sjo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso34199715e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737452931; x=1738057731; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mElhxqDWL3nmKtABnnj5PpFNGRnfcx1UhS+XeGlosA=;
        b=lmDW4sjo/x2zdqOi48qCVyKrnLConySrc/gLOtw2tonD4e9XmfG5dJBv2JP+S5Pwp2
         SEUdKC/UmQN18aQiq20Dk8AXJLc/iSZsc3d4KvWt2K0JRZPsoToeLjSnca3mYBaZHpWv
         Dyf+qbDRv5bnPvlvRIn+Dviee9TXu4274aZhc56Elr4z/FhNRExkWuJSU85/TpuOUANl
         QLKDZE6dbcnJ81cfGOm6MOX4MF85irdZ+tf/akXi9YnCPOj5asjlstMdOIAD/IF/T7Wd
         qE5oYRXgFY9MY/XWiWVh/QdSAgHRJeubugCbi0bRAoQxO5tL3dSRDfxIOo2muCNwj39d
         pw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737452931; x=1738057731;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4mElhxqDWL3nmKtABnnj5PpFNGRnfcx1UhS+XeGlosA=;
        b=bkC1a7Qq0PM/Q1s2m39W7T3GcqyMw5rk862BT49XrdnGC/iN1ukd5ZgB7TGrfRZF6p
         E7VJYb9VanxIiB0XDqujFOGSkOK19tDP4IGeKHFYU3OwoKgouoAf+vAVNUeCe6UEoRAz
         B8TqT1wPd+/ppVWLQvgwdNBjpE3QqWtynaI0cBeSmbP1tHgaMjodNjNosNv8ZfYEGKI7
         KegRWF32S88LIRFP/RVO91YjjMoLbqAnrGAygY49IhYlZK+MXUA+95+1R43byTKp1y73
         9PGudmj+fqmzkx8R3s+WhCvWbwQh98wz57MJyRyt1Iq03r6kOc+FnCEqPKWNdmj4i/io
         Eptw==
X-Gm-Message-State: AOJu0YwQZe41L9FKOo5HUymmCrUkAw36GI+D7R8lgupjXft9ZCt5G2M7
	emXF+1r0SeFqJPZqz2YTcWavBgrCzQkacyVirowWjHH3SIhP6no6
X-Gm-Gg: ASbGncvX3nAQV7whmqajA/gEBgg5F74LOM7FIJ4lknGkEb5CeIOXGwJ0/8toveObiAc
	3eYbnHer5Et97SEBASl68TM9HQZNOcigiLklzS68Hvslxe50N4lMtr/4GSqcK1I0JkV2w+iwOud
	RonZ6N/eUnzOaHhYquk2Hl1PV8vdYp9ZRD9oPcZPsDg5c/FQtYVNUlV6NSujQxiPtvQBF/Z08OJ
	XohGc+EA9s74vA7QB9IozkqefnA7koUEmDAeutbdoJma9EauqQbfFWaP9o9IoNpLdIMzHnPWvP7
	c2ZhvZ3Ggv/d
X-Google-Smtp-Source: AGHT+IGP65D0Pe5aHLN0us1kvEpjhb2rySYwVy/45FGTEUFh1I2k1u1NHeivMhZzMxrgoZ5ckjOfpg==
X-Received: by 2002:a05:600c:218e:b0:434:e65e:457b with SMTP id 5b1f17b1804b1-437c6ae9bdcmr220684815e9.3.1737452930664;
        Tue, 21 Jan 2025 01:48:50 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74c4e38sm231134495e9.21.2025.01.21.01.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 01:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jan 2025 10:48:49 +0100
Message-Id: <D77NNT0XWFMM.3F8D0CVJ8C7SI@gmail.com>
To: "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] wifi: ath12k: Add monitor interface support on
 QCN9274
From: "Nicolas Escande" <nico.escande@gmail.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250119152917.2316514-1-quic_periyasa@quicinc.com>
In-Reply-To: <20250119152917.2316514-1-quic_periyasa@quicinc.com>

On Sun Jan 19, 2025 at 4:29 PM CET, Karthikeyan Periyasamy wrote:
> Currently, monitor interface not supported. Therefore, add the missed TLV
> tags parsing in the monitor parser, configure the monitor vdev state
> identifier with HTT filter setup.
>
> Depends-On:
> 	[PATCH v2 00/14] wifi: ath12k: Enable monitor ring for updating station =
dump in QCN9274
> 	https://lore.kernel.org/all/20241223060132.3506372-1-quic_ppranees@quici=
nc.com/
>
> 	[PATCH v3 00/10] wifi: ath12k: Add peer extended Rx statistics debugfs s=
upport
> 	https://lore.kernel.org/all/20250119135751.2221902-1-quic_periyasa@quici=
nc.com/
>
> v2:
>  wifi: ath12k: add monitor interface support on QCN9274
>   - remove redundant filter setting in ath12k_mac_monitor_start()
>   - set the default filter when the htt monitor configuration get disable
>
> Hari Chandrakanthan (1):
>   wifi: ath12k: fix link valid field initialization in the monitor Rx
>
> Karthikeyan Periyasamy (1):
>   wifi: ath12k: Replace band define G with GHZ where appropriate
>
> P Praneesh (5):
>   wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
>   wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
>   wifi: ath12k: change the status update in the monitor Rx
>   wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
>   wifi: ath12k: add monitor interface support on QCN9274
>
>  drivers/net/wireless/ath/ath12k/core.c   |   5 +
>  drivers/net/wireless/ath/ath12k/core.h   |  18 +-
>  drivers/net/wireless/ath/ath12k/dp.h     |   4 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 362 +++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/dp_mon.h |   5 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c  |   7 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.c  |   8 +-
>  drivers/net/wireless/ath/ath12k/hal_rx.h |  17 +-
>  drivers/net/wireless/ath/ath12k/hw.c     |   4 +-
>  drivers/net/wireless/ath/ath12k/mac.c    |  74 +++--
>  drivers/net/wireless/ath/ath12k/wmi.c    |  38 +--
>  drivers/net/wireless/ath/ath12k/wmi.h    |  20 +-
>  12 files changed, 438 insertions(+), 124 deletions(-)
>
>
> base-commit: e7ef944b3e2c31b608800925e784f67596375770
> prerequisite-patch-id: afb04ab90da26435239077de723d1276946a194a
> prerequisite-patch-id: 1b12bea72973c14f461b8202eed9432f27932876
> prerequisite-patch-id: a6719494f46b8568504be8c64255676e67b4deda
> prerequisite-patch-id: 054756eb1705babff324a743e62685bb78035198
> prerequisite-patch-id: 889c4a0174fac23261705a42b46e923d7e7a0a18
> prerequisite-patch-id: ea0321fbd8a59c09191873f59b6aea8225f4b8e5
> prerequisite-patch-id: 3c8ccb635d319f8755649e445b68feb615fd82c4
> prerequisite-patch-id: d516b2a3196218f42fdf4567516a1fd2c8b4c40f
> prerequisite-patch-id: a2c59b4e468384e27d934a986e5fe9a951685fd9
> prerequisite-patch-id: 359fecf93ef53f39243cc1b3466ab06fbd33cc71
> prerequisite-patch-id: bf0b6542c65299c0bfa7fef2da6f09dd8453c39f
> prerequisite-patch-id: 1dc79cafb399be590d1e418afcc5a719ae35834f
> prerequisite-patch-id: fb1e39f2dce024ff692b0e6b112dc90c6a43ad00
> prerequisite-patch-id: 9ea3943ae0b6e6a5a09cb648eaa35f8087967ac3
> prerequisite-patch-id: 35da9ccb2466675b50e819029c13cbda70702fc2
> prerequisite-patch-id: 282cdacca7b9bbef5a94b1a78457304d38362af2
> prerequisite-patch-id: 5bdb2bd29cd4c92d23708432f451e92951c23f0e
> prerequisite-patch-id: 4b6f75cfa4d25f974f8fa61adbc85fff35a187fa
> prerequisite-patch-id: 6a015b7d89f3d61adb5d60eff2d63fea10d9c3b0
> prerequisite-patch-id: afba80a88de0869ade8954c32ebbec407608a1c0
> prerequisite-patch-id: 12367e8ecdccf254c41bd0518cea6877e4673bb3
> prerequisite-patch-id: d94f4a9c9b0b3bdc9e709efcae0cba4983bf440f
> prerequisite-patch-id: 8c9df1e16a25c3b9a3fb709ba9bc8d37e6f14a5e
> prerequisite-patch-id: 8db0be3595dc82725d9a195f3239402b9062d9f3

I've been running this updated series since yesterday and no problem so far
when running concurrent monitor & ap

Tested-by: Nicolas Escande <nico.escande@gmail.com>
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

