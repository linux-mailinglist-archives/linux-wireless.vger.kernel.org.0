Return-Path: <linux-wireless+bounces-17187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D355A05658
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 10:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DFD164568
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36E51F2C51;
	Wed,  8 Jan 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGk3ZOrA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B31F2369;
	Wed,  8 Jan 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327147; cv=none; b=KjCSrGeGqqqoRAMoLyBy1WIFURrSukG3zxQ7vkFwGeV04qsf40XjCMs4ZyKmoilwttfP3aD/vwhavrXHcqQf3sJOjHSWknRoYdGkWw+DJuw4VsNBQuLa6b+YznveP9fr+YquQCO/q46/3w+O0dZ4N+JaNRtn0MgkgcMld7VIqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327147; c=relaxed/simple;
	bh=B89NSua0s2NL9yMjR0i7yePdrfAUdgeidNmKjSs+5Ak=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CiEDk63e5r5wDp01zhBGrj3Jrw9FG8WTcJZ9qx7Qoi3TO6lB8sAFVa68gK08m4rFVx613A/+GqDS6Lj8MSczd5CfcTK8FYRTNGpYtg8qWom0tVpmN8okynGr2/in/5XJl/94lbVtagnjqrElB74AAtf5BD2r9wXupqPBxVDz9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGk3ZOrA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385dece873cso6205330f8f.0;
        Wed, 08 Jan 2025 01:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736327144; x=1736931944; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B89NSua0s2NL9yMjR0i7yePdrfAUdgeidNmKjSs+5Ak=;
        b=bGk3ZOrAI3stkye6PNluYmOGXQR6q3RqLgtj0r1N2qElmjTcfK/gRmYeKgafbWZBj6
         DShNyMAp6NfVlRX7/ZUsmuoIwxQFWFWQKPlZt+8morqRyzwPyhp2tuj9RdUPvKAVg+5f
         DlgbAxP/hANx0iveZveIWMnjyMZ+p179V6DmIGhFqFRjum9QtH4OgOV5mtxAtka7p6jH
         yXnOzEGWVPl/3VjExZ3FPUf3x7uZpDdTEE+YaPxct2gcYJprnL3SkpHF3Xhrnc9NaInn
         DaRnajH+x8Kl4OBrOUQHA0UY6J5UJrWg7hoHn3kxoJKxSueZVOPSWoH/VRTih0cIjzZN
         hqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736327144; x=1736931944;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B89NSua0s2NL9yMjR0i7yePdrfAUdgeidNmKjSs+5Ak=;
        b=XLjLYmOnu8mbKnAg17v10oKLkzKTvcnx2tjj6kIx2tJt5Y2EOeKRmaWytR+L34zasa
         FEg5E5v/v+ZEs8ZAqz8nVUYAtCDk5bxv6Y/5zgnB9oehwqM7KQpsASe/dPjBnzLd07vQ
         nsVr5Huzqx5Fbt8Suqrh2DzWfM1GEiUN45euH3/EZckzx+L+TeSEaOb3rm+P5O+GT8Q8
         eKxvVFBsOfS5saK8ik3ul2Iyem7Pa9sE7S5AwgTl1wl7QLGw46jspu/ivuaCyJNb3BRg
         nkwrX42XuYrmBkgCRESu8iDjLdpLo/fA9zUsYlqcbr5Q6ib00XkAQLVhrEJFZK+YDn2O
         5gLw==
X-Forwarded-Encrypted: i=1; AJvYcCUdbXM1R5acYhlWXJM1qrpQlc6CO9RewSb5+73GR4jfen6EzJudcZ8QXdMof+J2/iz0rpC7hpECY8RIkgyHWb8=@vger.kernel.org, AJvYcCW418WehItRZibHTRsB4APca5LV5D/4FIxfkR0Ob7p/EEq1ibpcNVnYDnHB8F1whAnw5avpQQ43l/DSupo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywV1eP4M8McKlD1CKi0lzvy4VZQq1qB0LmsFs5VksOcxVy+zEA
	996bIOH535a0R5CZW51pTXzBRgt2NpQx6moAK1ziW3AIxinuGXjD
X-Gm-Gg: ASbGnctXhxv2u0seco+0flzMnh0YB+GaTrDR7xaxH5NsbCK/UqRhK80Zk+FsaC8/v4b
	Zsllv2P9NX0Hg1c0epdf9JgknB5kIhqYwAc1f/Lq3WG1a/jXe3fj37vKkwATnIG4cFXOdj7rVGY
	MR6ypwjs8JLbU7d3Ly4OZcYeIfF+RgS/1qvzz0zgmCM2BYqB9WJaGPxR8aczvVY/Xbe1kRtn4ys
	PhPgi/IF5wAEYXf+KEBcTatEtwR8QX3XLY4zT71OCwFmSG8/+L4saDvedpBzj3ndq7IIekapb0=
X-Google-Smtp-Source: AGHT+IFd7isXdiuuZAhkyVSn84acInMhw1zHLKjbGGjVuf5RC652pAj9eDj91mCMpRDLX6U/2h6MwQ==
X-Received: by 2002:adf:a41e:0:b0:385:ec9b:e442 with SMTP id ffacd0b85a97d-38a8733a391mr1242495f8f.40.1736327144140;
        Wed, 08 Jan 2025 01:05:44 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828d39sm54052634f8f.9.2025.01.08.01.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 01:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jan 2025 10:05:43 +0100
Message-Id: <D6WKLPTWY5GP.1KTCXNQWACLBH@gmail.com>
Cc: "Kalle Valo" <quic_kvalo@quicinc.com>, "Balamurugan Selvarajan"
 <quic_bselvara@quicinc.com>, "Carl Huang" <quic_cjhuang@quicinc.com>, "Wen
 Gong" <quic_wgong@quicinc.com>, <linux-wireless@vger.kernel.org>,
 <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Sathishkumar
 Muruganandam" <quic_murugana@quicinc.com>
Subject: Re: [PATCH] wifi: ath12k: encode max Tx power in scan channel list
 command
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Aditya Kumar Singh" <quic_adisi@quicinc.com>, "Kalle Valo"
 <kvalo@kernel.org>, "Jeff Johnson" <jjohnson@kernel.org>, "Vasanthakumar
 Thiagarajan" <quic_vthiagar@quicinc.com>, "Bhagavathi Perumal S"
 <quic_bperumal@quicinc.com>, "P Praneesh" <quic_ppranees@quicinc.com>,
 "Karthikeyan Periyasamy" <quic_periyasa@quicinc.com>, "Pradeep Kumar
 Chitrapu" <quic_pradeepc@quicinc.com>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250107-add_max_reg_pwr_in_scan_ch_list_cmd-v1-1-70d9963a21e4@quicinc.com>
In-Reply-To: <20250107-add_max_reg_pwr_in_scan_ch_list_cmd-v1-1-70d9963a21e4@quicinc.com>

On Tue Jan 7, 2025 at 5:01 AM CET, Aditya Kumar Singh wrote:
> From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
>
> Currently, when sending the scan channel list command to the firmware, th=
e
> maximum Tx power is not encoded in the reg2 member. This omission causes
> the firmware to be unaware of the host's maximum Tx power, leading to
> incorrect Tx power derivation at firmware level.
>
> To resolve this issue, encode the maximum Tx power in the scan channel li=
st
> command before sending it to firmware.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_S=
ILICONZ-3
>
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
Not sure if those are in the righ tag format but
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3-03253.1-QCAHKSWPL_SILICONZ-27

