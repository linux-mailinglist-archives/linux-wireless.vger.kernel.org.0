Return-Path: <linux-wireless+bounces-30286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C79CEE36E
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66D9930054BF
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7672DEA89;
	Fri,  2 Jan 2026 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0zs/yNT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F362D879F
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351252; cv=none; b=sIqpdy8eU9bhjkm+d/a5A6Aq7OToyPGgsfZkJTPOh1JPXk2+09K/dh3a74rIi3JRLTNLd2Q2VJlkob9154tVkjvQVPfKQKAx1QO3qPiZOzoYajGX9sUbbGbkixYoPpoK0UVixR/hekOu4mqPrihdzKY4LzMWltl5ASUO0IW/QLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351252; c=relaxed/simple;
	bh=mhZD+26yEtIqCTAfVl9iT6ZYu15zs4sSgg8F7ighC/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmauAdlgj/sZVcKkZDZm+c1ESKa0ks2E7uheUzvFKRFTMV7a+4FAnX/nmGCc4xakccRp5vnnaUanTGjKd61F5NmMh13WYqlPhYM/lb5O442z/QipKGVFuRAz7Ovn4dZtGayJ79kRdD0yrxE11GCQkr/4ZVtvtuEwHA9G0WZgWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0zs/yNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A410C4AF0E
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351252;
	bh=mhZD+26yEtIqCTAfVl9iT6ZYu15zs4sSgg8F7ighC/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0zs/yNTkJOTHppfnCWmNvC+9oYLEz1NkUoEzyweEETzScTG+qABaLmAGD3LujFRI
	 FbrNgAMngh0lQAHpVA7/advd4197jrvMhfmu2mtYfOC/+D7rYHNdo4d4lpm5LFEFFF
	 BRK0ao0800BY41AIpfUE29vPVW/ZWeJy1zh3KklfGOXfCuwPsNEtGODcLsh07EIezo
	 P6D19sO6dTTKLdXL6LcxwjUVVTlm1W7f7mqNtAvigC5/yEhvprMlQUx3E8jRdZllF5
	 MiSkRWQl0PU5Nc8U5dXd+SWPbDP64Fgddl6X/YN3VwMbIVhOIFTcVN4CRHdyinzjsz
	 59al3gVGGPU0w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so11955042e87.1
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 02:54:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlyOCgNnmi7oTjANuzasIFfQ2WfR6JlbgBgzl1peTgzshI4WpUrt7c3GjApubuFgIsSaBipFqNRqHo8BsCYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBzLAKRlawIxwyly+Zq9b/gUzJden0ZhzuqZDg7SHKshxMJZD
	aTspCdB/8lnA3bSMonDspOfpojKbWK93C2aHPVepM+pyAbndD0JENqVnGSe5wBuJAJZopWCnLaO
	PIZsVvP/gz+XpSGfWqlR2NKAWlGlay+gIThq3pYmvCA==
X-Google-Smtp-Source: AGHT+IExnKYlDStG06tTP1RibOKTGQuC8yDyUL3e1vDeFIS1fn58mDudw2E+LdXxU8NjOyVmgo6RUbBW+jM7qYg69kE=
X-Received: by 2002:a05:6512:1581:b0:598:e9f9:c03 with SMTP id
 2adb3069b0e04-59a124dcd09mr14271730e87.3.1767351250861; Fri, 02 Jan 2026
 02:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com> <20251231-wcn3990-pwrctl-v1-13-1ff4d6028ad5@oss.qualcomm.com>
In-Reply-To: <20251231-wcn3990-pwrctl-v1-13-1ff4d6028ad5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 11:53:58 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mf5fC===xFnO6P_Nuf1YnbgHK2DXvDLDand1StyUTKcYQ@mail.gmail.com>
X-Gm-Features: AQt7F2rX1OA_FQ6BWF4RsUO2xhslUW0cJ4Gi7nKzsu0XwbfiBxB-ZebBY9NVVE8
Message-ID: <CAMRc=Mf5fC===xFnO6P_Nuf1YnbgHK2DXvDLDand1StyUTKcYQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
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
> The onboard WiFi / BT device, WCN3990, has a simple on-chip PMU, which
> further spreads generated voltage. Describe the PMU in the device tree.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

