Return-Path: <linux-wireless+bounces-22401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A0AA865C
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 14:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F9283AF1FA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004911B0411;
	Sun,  4 May 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIA6N3ID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E791F948
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746362215; cv=none; b=rmsmoFgvj42NBxixAoPo1jz8TItwAb/rVJDQANT5IXJHXYKoOhQsNXR6L2XtC0/VBdSS7mJnNhGjh3z2Daz+fDudxtDH9f1aioDh3t9VNP3AnoVeS9PTY5DKgUh+UNXeBhEVmq8D52NE5kujBB7dK2g+b4N9lMjDCyTm9OPNbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746362215; c=relaxed/simple;
	bh=CM08xeHPPzPAtEx6J7jBMfY5mggSPnim894fiEb9CM0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TVhxVHCk/7IMeiZSwbI75kLyVQxmERZfE6L6MZw+nidx6azXLP/Lf9kLOZwQBHKZ/VHy/ausWz1fSozxZ1A5e6fBenqNZVHM/zeBi3sdf41sx7zYZwFLEuvot4AiKl7sZnYIEt2dRKJzeAgrSpyQW+9GQlRC3vT0wBt8qQishX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIA6N3ID; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso14159215e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 04 May 2025 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746362211; x=1746967011; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CM08xeHPPzPAtEx6J7jBMfY5mggSPnim894fiEb9CM0=;
        b=OIA6N3IDWQzaiE0p0v1l3CBSFTgin8lv4vs5etRVyKkE28GKfsTrSddAY8FI2GX8r3
         ElQpfFuFDsfguEHzl8kW1t67kDjfZ9S3qNUK2V8EMPCpXGX0DWNHtGatKw6G6zvy8hBX
         lqNbUu4WEtzFSZGBUFv0drn3A0xsMSRWDKPFHTLjrfCtmYCbNXSfCaENkcPaWfRVGwaB
         ea4a+PH1DEMg63Csg+fuvOlZeS7RqZABKeS5AgbR+ZqtU4C6R722lN2VeaAs7RbZfIQy
         Q3ZomwEgHXsm26h8L1sIoQ4+GS0INZRkzKXkMFY4vKiURS4WWJMQn5jeOPMilfe0Q07r
         eLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746362211; x=1746967011;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CM08xeHPPzPAtEx6J7jBMfY5mggSPnim894fiEb9CM0=;
        b=Rd0jpoDZGMJfqIrWOkilPLddCaCqhQvC+Tqf50acFL1AriFOug0y74goj5evfC+up1
         k9kMGsi2N1eJ+6a7Tec0CHs1ipxdWUwBxMakmThw+NC/8BwibRWWIJTSkim9JeZnfjeD
         2DIwZDI+FV7OCGS/7SQruWSjl0izWpHnbDn1mQVHbCtLOW6zVAyZMbHMATod3j58mu2T
         K4XqyotZASJVe28JQQfhxhZQKV5W9MYNH4eo6UZfhE7dG8X40KoLe7KGeoG/9m8LJZkw
         z03QpzpXsbGfDoe5bmtAGNkd2Sljq30z33GDYe6u8+V81CrmVn1bD8zIs9G7dF4FWu3e
         YI5Q==
X-Gm-Message-State: AOJu0YweUselSEzcDbRmQnrsK2AH2Ii4vBW5750+z22mVMYLyMisAbS7
	PvW2xyJ8EexJ3nfYnZlRVkm6UfIyM9OEtZHKAlbv/yL3UKUWZ64Q
X-Gm-Gg: ASbGncs4cnUg+Sx/UMZm4QdYfgEBtx6XHlcF/nYLdE/IVS6NvFHTfuu9BD+HMb6ztdp
	zwX6rOB4zYV2dBZW39ekeiCc32vZlkfWL7Ir/Pi5ws5HB3dEfKLPC3jkpYmObTXP9TazwM9tAgb
	4hipYY4VSDHi2shJTO0kO0apLiDq96VYGZ8jzPPh2mPG3+9VYCI3az3JTGcmXPekSDLhurbyRur
	PbTUTIVZwmrCYwvvYSpE32EE0aCJvRu2eK0yfXkyu0sHY9mXc7nNtMthX4FqR78U3V4Sn+a0x+V
	FgMCZtRGlb5MFXb/gaweySd67IbCfeP5DashnqgZJiMcq9KMcuYntwqPkOc=
X-Google-Smtp-Source: AGHT+IEApNLeMqXPTD74HBZS5fOAX/1hg+752BPbILvPZGU6lVPtLCQ59W/vyrEscsgOIHE1jBlxFw==
X-Received: by 2002:a05:600c:828c:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-441c4923807mr26739845e9.25.1746362210525;
        Sun, 04 May 2025 05:36:50 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441c0dfc537sm55192625e9.16.2025.05.04.05.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 May 2025 05:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 May 2025 14:36:48 +0200
Message-Id: <D9NDQJB4VMWA.V4IPOZOIR46W@gmail.com>
Subject: Re: [PATCH] Revert "ath11k: clear the keys properly via
 DISABLE_KEY"
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Vasanthakumar Thiagarajan" <quic_vthiagar@quicinc.com>,
 <ath11k@lists.infradead.org>, "Sven Eckelmann" <se@simonwunderlich.de>
Cc: <linux-wireless@vger.kernel.org>, "Steffen Moser"
 <lists@steffen-moser.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250117191455.3395145-1-nico.escande@gmail.com>
 <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>
In-Reply-To: <20e0a239-3d23-473b-5bc8-41bc25a64088@quicinc.com>

On Sat Jan 18, 2025 at 11:29 AM CET, Vasanthakumar Thiagarajan wrote:
> Hi Nicolas,
>
> On 1/18/2025 12:44 AM, Nicolas Escande wrote:
>> This reverts commit 436a4e88659842a7cf634d7cc088c8f2cc94ebf5.
>>=20
>> This as been reported by multiple people [0] that with this commit,
>> broadcast packets were not being delivered after GTK exchange.
>> Qualcomm seems to have a similar patch [1] confirming the issue.
>>=20
>
> This will re-open https://www.spinics.net/lists/hostap/msg08921.html
> reported by Sven. The recommended ath firmware ABI during GTK re-keying
> is SET_KEY instead of current DEL_KEY followed by SET_KEY. We are looking
> at other options like some marking by mac80211 for the driver to be able
> to identify if the received DEL_KEY is for re-keying. Also I'm curious
> if roaming between secure and non-secure mode is a critical use case.
> If not, we can probably go ahead with this revert as temporary WAR,
> @Sven?
>
> Vasanth

Hello,

Any news on this ?
I would hate for this to sink into oblivion once again given how hard this
affects end users when it does hit.

Thanks,

