Return-Path: <linux-wireless+bounces-5876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918E3898B1B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 17:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4C428332A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE11C68D;
	Thu,  4 Apr 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4ZyxnWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776C12B95;
	Thu,  4 Apr 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244492; cv=none; b=kFImk/KnSbtckkcPwL3wtAs5rRBSIJxil7Ds9Ef13+Fy6AFiPm25ra135Cl0kwRJLMDDZJ7P8FWkBGd97apWAoKZFSmK3GK5Z6CC2PKiQk2CDq4VyvadWfSiE4FZsGZUXsXI7rUnA1N5Z7O8phlJI8BPW5nqwaMvnnEhQWlWD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244492; c=relaxed/simple;
	bh=kFnpx5tB/cOSNRhheZ9+fj6gL/PgrOpF3Q++o3JjWqk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JRsKPwfLyRStnmdRznIicfX0P8zIeWtoVnmVHZ3XYro6PcyQkLeSBOqMqNCRb6wfUra8sJPJPeQihb6D2fTTdvznvOp8mK5zM0bhvVP0ARHlonkIxGTO3YN6A6u3O0BJvPdnkkyix/Q2xOaWiviPLtcPoTkp2X7kbpKj1ZJy9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4ZyxnWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143BAC433C7;
	Thu,  4 Apr 2024 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712244492;
	bh=kFnpx5tB/cOSNRhheZ9+fj6gL/PgrOpF3Q++o3JjWqk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=B4ZyxnWRY6QDwGCgzRK4sS9Yr2ohJAEihjYC01BJTA4XOv0BmXoLAISwpDGrqqnTv
	 4rsINRdWvn358oQM52XmkKPAG4zc6Z6p+UlPKTvWKQtYj/r4MPYi5N3rcNnywlovgx
	 SJrZCysgn21LtHWb07jv2DT0xovACa/ctMomGNZO82crfF1SZgMiv5qax8V7A85vZS
	 vyOF1P2Fm2/Ez+cz9cYKGXKFOLH0/9tYkxDwEEcjBgASsHcAUIhom7iGM8gXdT+j4Q
	 5ufnKF2//xDq5kDV0176Xn0N827UWHzbpg/Vp/waZ6sXnXO4UFCgoFdA1tARewulLw
	 aqe68yIK0sG2Q==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  MSM <linux-arm-msm@vger.kernel.org>,  Rob
 Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Pierre-Hugues Husson <phhusson@freebox.fr>,  Arnaud Vrac
 <avrac@freebox.fr>,  Bjorn Andersson <andersson@kernel.org>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Jeffrey Hugo
 <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
	<5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
	<252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
	<502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
	<0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
	<CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
	<87ttkh49xi.fsf@kernel.org>
	<e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
Date: Thu, 04 Apr 2024 18:28:07 +0300
In-Reply-To: <e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr> (Marc
	Gonzalez's message of "Thu, 4 Apr 2024 14:30:40 +0200")
Message-ID: <87h6gh406w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 04/04/2024 13:57, Kalle Valo wrote:
>
>> Dmitry Baryshkov wrote:
>> 
>>> I'd say, we should take a step back and actually verify how this was
>>> handled in the vendor kernel.
>> 
>> One comment related to this: usually vendor driver and firmware branches
>> go "hand in hand", meaning that a version of driver supports only one
>> specific firmware branch. And there can be a lot of branches. So even if
>> one branch might have a check for something specific, there are no
>> guarantees what the other N+1 branches do :/
>
> The consequences and ramifications of the above comment are not clear to me.
>
> Does this mean:
> "It is pointless to analyze a given version (or even several versions)
> of the vendor driver downstream, because there are exist a large number
> of variations of the code." ?

I was trying to say that because the design philosophy between vendor
drivers and upstream drivers is very different, we can't 100% trust
vendor drivers. It's a very good idea to check what vendor drivers do
but we just need to be careful before making any conclusions. Testing
real hardware (and corresponding firmware) is the most reliable way to
know how different products/firmware work, unfortunately.

> And thus, "it is nonsensical to try to "align" the mainline driver to
> "the" vendor driver, as there is no single "vendor driver"" ?

No no, I'm not saying that. I have suffered this "N+1 different firmware
branches behaving slighly differently" problem since ath6kl days so for
me this is business as usual, sadly. I'm sure we can find a solution for
ath10k.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

