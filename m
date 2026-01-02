Return-Path: <linux-wireless+bounces-30283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D807CCEE332
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5702F3019191
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A72DEA9B;
	Fri,  2 Jan 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERchD51M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58E2DEA77
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351079; cv=none; b=lt3Beu4aAJnzXukuOv902QfApf+QdWiRqAOQq5+JpAesTSjb3n0smx5hXFD+povo4Wx5NgEfT/d4XgDUTaOoKHGSXfBJmki4tN9U14uHf3unbPqlaDseRuybjDU43VVnFSTUOVsN4ld1Wq6EWJwjsNPJWCC6iBj5uIbc55JFGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351079; c=relaxed/simple;
	bh=xCx5AAentnk4QBvWh8rauxDanszvphvmntZcvGZ11JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1GyKxj4tCT9/SbiGpC2mpTf2vgNU7ImLwPiM30nOHcgpNHDUA52Jo+I+oP0slVOmdNSgym8GAWHKDh0EE2vJfV2C+XCMvaKHV54HZX1rYefzbyYiK0YahSnZtC79D1U45+y5US9bdoXmlzfV8OIPI9J2/LzeRGWrTtdw/FrId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERchD51M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126D9C4AF09
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351079;
	bh=xCx5AAentnk4QBvWh8rauxDanszvphvmntZcvGZ11JI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ERchD51MB1D4chMBJnCAi3SlK+C9HNN5rmPtujFRTW8r6NnDnucrebDxccoXl7/0R
	 ZWpl22I5yZrov0ltt9Vf6sk551xg3AUMgpU62J/vZ87U8HYO5t2rNHQCwETVRkjftK
	 uFAzt+sBNagP3oIFuSvi95VYnrb5M6UBeDktEPv6wsNl9uMQyZWPO6ycuqga7/Iyls
	 w274UfqoFddWQibz4WQ2psUy9IoxMI8JtTU9lxvT7a6eRqMPRciuyVCHhXMDxpiG+j
	 tejjZaDRbGs4l6+5x34zDXLaAm3w1fz5g9lybkAar8YP00xCmvjHaDA4DSUERoBg1L
	 4kP1R9X0ZHpZA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37bbb36c990so110769991fa.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 02:51:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg41G2wz3HvKz6f2o4mgLxY5F9LJ7CxHVm6mVngEP43iCdp5D1OieWS8b2SjoC57i+GmoumPROGFcs2c/S4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTKhBVcEUMj8M0fBUvJDAKJEI3NJs0DXVosKVH9EaqJ14UxoB
	rWDKMPHCRSkCnVuilMvK5wx31fqEtLzPU6WeCMFE+J+cOJ6CS4nQwC1EdLTFs1Bgu4w+RSqE7Ph
	fmSD2TqdgvYPYTzjYr8szj/9ruCZwPG+J/IRol+MwDQ==
X-Google-Smtp-Source: AGHT+IHsTD9adaJDmyGmY1It23ntuHwPKruzTO4CUZ5lqrhgY5dCs2ctjbHSYlm1/KVO3NQ94ib9c9b+lWmDxYLnems=
X-Received: by 2002:a05:651c:50f:b0:37e:6884:6756 with SMTP id
 38308e7fff4ca-3812081e6dbmr136602621fa.14.1767351077385; Fri, 02 Jan 2026
 02:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-10-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 11:51:03 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf+FFEQPb1vvaY09_P=jCuzzFw_ZyaV7xB3BEdbWveU1w@mail.gmail.com>
X-Gm-Features: AQt7F2pqkjKwFIx8hZpIu-TfXbr4Nzd5pfqyrhbXe7nGgy4iKw45mcVh-sFbf3Y
Message-ID: <CAMRc=Mf+FFEQPb1vvaY09_P=jCuzzFw_ZyaV7xB3BEdbWveU1w@mail.gmail.com>
Subject: Re: [PATCH 10/14] arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT properly
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
> The onboard WiFi / BT device, WCN3950, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

