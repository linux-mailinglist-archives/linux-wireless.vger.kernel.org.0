Return-Path: <linux-wireless+bounces-30289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE5CEE402
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A8FD3001FCE
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E772DF3DA;
	Fri,  2 Jan 2026 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWZWoXSU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340D2D9481
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351755; cv=none; b=dydWmbwcC4GqL6SOzODbyOpoHoMzADWQD8LcI2NO72s0Jsp662VnUorv1do6Qoal7B2cIUNrnU16T/XhNNxgYwcs5GU0O2UhmeK/lyxiIFBCPGBGl37QO1D2WgPOTayag42RSogZKc0Qgh5NvSU4T7zcW1XQLO1KQzCW5OsOnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351755; c=relaxed/simple;
	bh=uZX+vZnqM+JTaGOZAXSO9Ba8hrCSXHZafMX0t5RiEJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGJyK1q2Qp0ExD7lUyEOP9NgAEz9ZsLuvo9JI7GXYjbX1Y8nlpH4pyWXWL8ozSZYzZRu48nNUffXAM8p9jyIzf1voJ1FfxHl23xAyxVpsGWpwX22WA3HBSJFJAmqwNJz74hmXu1p7Qb4hHmXjiGRNe3SrqdSJrxO2osVN/OgSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWZWoXSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EF4C2BCB2
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351755;
	bh=uZX+vZnqM+JTaGOZAXSO9Ba8hrCSXHZafMX0t5RiEJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nWZWoXSUg/0dcfGTBe4DdtAvoT0eNObZVq8Bm5q6nAFOAO3Jf9GLvaG3/tyvONHcV
	 UL6VKT8Mc3kq1Y3TeQ85VKVkIbthH1NipiWQqulO664DssUhRi1qMiVYOSRgIiooRM
	 A5X3t4gKL2BWBX9vRVRnXqRCiawPgrw0PkK6vWXvnA6xzxhjHF8YSZtPS2XOlZXaPp
	 bxOgwkt1BXurY6MFji4KEUvshmlbopIXqW1xZEZ+5Dxe0mcXUQkWFuFP0bMx167/ij
	 nlauE/R3FD87e2JukFXN7U14MXYTmskJuUpMXKIvJRyz9g/GSj/Z4yif2QDCkonJ9e
	 VgYTRveWRm/tg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59431f57bf6so11818281e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 03:02:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUngHSXu6pVgAHnCebLv5iv3fDpS/t7eNeslKuVWgUxKUfvCpXpM+oe9IzevHzA/FeIDq343DZ7gBoFvH4gkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yztku6U6w5n9uBbjpOxv+q533jaNkVnMkQJ+QC37uFVMb2ABd1I
	XcfRbpDKfXHYtK9WiqZdy+8lxgVmVGlJNUCFoDpgJjZHv6sTV8iVVAueaTX7/2fa4I0/ckOHstJ
	ywe52FlzTNsfeZcJWRe9IXz5fCh9gQjnh3e/T2rf1CA==
X-Google-Smtp-Source: AGHT+IER5Ned9nJ723yU7Uzu6gtn0g6aZr/0yAwum1t54+3rwVPoOpPAFG9MSH91C23iKYxPGeAWfKbWYG4EzGGJ9jk=
X-Received: by 2002:a2e:ab1b:0:b0:37b:9b28:4282 with SMTP id
 38308e7fff4ca-38121561689mr122757011fa.11.1767351753675; Fri, 02 Jan 2026
 03:02:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-5-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-5-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 12:02:21 +0100
X-Gmail-Original-Message-ID: <CAMRc=MemZbtrvFSpqvdkTq3jaF-hk999H1iK8GEpn6xfPqX-zg@mail.gmail.com>
X-Gm-Features: AQt7F2onLz_Ggs7LDoVQk2cMiOLUKiEtoEPQjMhArb-R5reMaYZSN3-gdK5tykA
Message-ID: <CAMRc=MemZbtrvFSpqvdkTq3jaF-hk999H1iK8GEpn6xfPqX-zg@mail.gmail.com>
Subject: Re: [PATCH 05/14] power: sequencing: qcom-wcn: add support for WCN39xx
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
> The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> voltages over internal rails. Implement power sequencing support for
> this generation of WCN chips. Unlike later devices, they don't have
> separate enable GPIO lines, letting the chip figure out the necessary
> parts on its own.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Looks good to me, I'll pick it up once the bindings are in next.

Bart

