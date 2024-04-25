Return-Path: <linux-wireless+bounces-6854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC76A8B26B3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1549BB24AAC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 16:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6179014D2B4;
	Thu, 25 Apr 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpCGPsNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457614C5BD;
	Thu, 25 Apr 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063204; cv=none; b=e4Wnc9E3m4Al/9Mdx3Qdd8JnBEihjkwbsPDPX9PGAphjgHZrn438Y9zlykmaL5kOw5ljErLBBH6gy66uilH5ez5Do5zjS87t0V2TM0jT9D7Yy6aoZnrZBrSgld7M0E7IkFe7jOLpnUeRrLpP27oYrPo4Hf48yQZTmQN5pN0NauM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063204; c=relaxed/simple;
	bh=LbSqadMzoFjsuXSnWvEu/tPbSTkv0wSi5qeCjW/x/YA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VeeOicCbLAAJnbbNXKmZRI5riOdl2+y904docYXmg2XLA6KR+IbMsGmZtNCtMkeyIPrxvslHOZfnZ3iM/J3uhcHsuDhTKQi3VB+b7YO8Hr7XqmKmaugYqaDEzGGgfo1q5PiZAn3xHWbEUvylstOe0imVKEIShr32zSV35qT7vAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpCGPsNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFEEC113CE;
	Thu, 25 Apr 2024 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714063204;
	bh=LbSqadMzoFjsuXSnWvEu/tPbSTkv0wSi5qeCjW/x/YA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kpCGPsNPtizwkRXzbbBOisqIxYXAYDvBURByNuPNU7j+hAZaM3rY4zD9QvWJosW68
	 iC0L8DM0TP4KnXEx4C3MICMMVEH9a6cqbEgZ7ANWMYOYB6nyRMCg2jexrQAtQQNaO4
	 sS+tAVTrBYCPA95XjLgyBzehFuUM7HqoFrvJ4I1FAjXyN03+BjI2hp4QK/8bHTh7sz
	 CA0JgVVrA7XGz3fZ5GjYINhkpDAI3n3XxKqZtHGVMLXXrpq0YuSbeaa7K2SaZn/zPI
	 ed2bP4EbknrklmiDXJLJCsNer2VxtXL2JV3xQkOXT7D3dMuzr4kwowbBdy2W06/FNN
	 Re8OsFDjeHi7w==
From: Kalle Valo <kvalo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>,  Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>,  Konrad Dybcio <konrad.dybcio@linaro.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,  Jeff Johnson
 <quic_jjohnson@quicinc.com>,  ath10k <ath10k@lists.infradead.org>,
  wireless <linux-wireless@vger.kernel.org>,  DT
 <devicetree@vger.kernel.org>,  MSM <linux-arm-msm@vger.kernel.org>,  Rob
 Herring <robh+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  Pierre-Hugues Husson <phhusson@freebox.fr>,  Arnaud Vrac
 <avrac@freebox.fr>,  Bjorn Andersson <andersson@kernel.org>,  Jami
 Kettunen <jamipkettunen@gmail.com>,  Marijn Suijten
 <marijn.suijten@somainline.org>,  Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
References: <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
	<0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
	<CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
	<87ttkh49xi.fsf@kernel.org>
	<e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
	<87h6gh406w.fsf@kernel.org>
	<ad5e178b-cd64-4a87-8994-f917993f3bbb@freebox.fr>
	<871q6tu6bn.fsf@kernel.org>
	<de65290c-0f67-4499-ba28-a460e6d6e419@freebox.fr>
	<87msphsb3b.fsf@kernel.org> <20240425-monopoly-barn-45608dae0996@spud>
Date: Thu, 25 Apr 2024 19:39:34 +0300
In-Reply-To: <20240425-monopoly-barn-45608dae0996@spud> (Conor Dooley's
	message of "Thu, 25 Apr 2024 17:02:56 +0100")
Message-ID: <87il05s8ft.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Conor Dooley <conor@kernel.org> writes:

> On Thu, Apr 25, 2024 at 06:42:16PM +0300, Kalle Valo wrote:
>
>> Marc Gonzalez <mgonzalez@freebox.fr> writes:
>> 
>> > On 25/04/2024 11:42, Kalle Valo wrote:
>> >
>> >> Marc Gonzalez wrote:
>> >> 
>> >>> Do you prefer:
>> >>>
>> >>> Option A = never waiting for the MSA_READY indicator for ANYONE
>> >>> Option B = not waiting for the MSA_READY indicator when
>> >>> qcom,no-msa-ready-indicator is defined
>> >>> Option C = not waiting for the MSA_READY indicator for certain
>> >>> platforms (based on root compatible)
>> >>> Option D = some other solution not yet discussed
>> >> 
>> >> After firmware-N.bin solution didn't work (sorry about that!) my
>> >> preference is option B.
>> >
>> > Actually, Option B is this patch series.
>> > Could you formally review it?
>> 
>> I'm happy with this series and would take it to ath.git, just need an
>> ack from DT maintainers:
>
> As far as I can tell, Krzysztof wanted a commit message update for
> 1/3.

That's my understanding as well, I assume Marc will submit v3. I marked
this patchset as 'Changes Requested' in patchwork.

> Usually this dts patch would go via the qcom dts tree, so presumably
> there's a need for an Ack from Bjorn or Konrad?

Thanks pointing this out. What I meant to say earlier that I'm happy to
take patches 1-2 to ath.git but I prefer that patch 3 goes via qcom dts
tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

