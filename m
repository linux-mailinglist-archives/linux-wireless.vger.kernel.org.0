Return-Path: <linux-wireless+bounces-6849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B178B2571
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D56F1F2122C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890214B08A;
	Thu, 25 Apr 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeQ9XnqB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0121494BF;
	Thu, 25 Apr 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059786; cv=none; b=PDINsYWVYjI0pxVpVdpRPTZ2DASHLDy81KoAWiL1bpGedFmGH5sZ2c6jgx842vv1QfXSPTTIp4Itix9VVqQrWUv1BdweAMGOZmqn+tWTMrjAfmVMlwcFymCZCAqXguyVLbVipA5v263tEoKEXXGCA6ilBvb9J/gGWOQJbQPzSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059786; c=relaxed/simple;
	bh=We7CJBcpFiTtuiJw0bxly1Y/yD2hktd8wy5CjSTeJeU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HcyDwmIZDvLLrNZc0O99ULeybayLJABAYvX8d6hYxTmqMHmS+Feqd6ptAfIclMzZvzZaSHlo4ihxXjWIL0En65AkH5oFjwcBhFvoZmy0CXvethA0oJQZRHuUYRWl3PdLwl9MJ1MLWdjbHEB9pq4gKkz1LcxQ/JmFhffkniy3qPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeQ9XnqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D18C113CC;
	Thu, 25 Apr 2024 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059786;
	bh=We7CJBcpFiTtuiJw0bxly1Y/yD2hktd8wy5CjSTeJeU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=UeQ9XnqBfcEo2PV4stOWd1PCCqh5xB4NHBt3bBNcHrIBiaG8peGRoBKHDpPaZ5xLG
	 NI7BEOx1O/wrU9eUXBEGrvT1XJbP5FUsfd74cNbqEJ3sSwC09/OHxJMvx0QU3u83tt
	 NsxCbA3FhIq7gI/MOXnZ7M3MB+ny7HXB+OI7r9qHNpJd+cPl/k9QsOpSN0OzjnQXve
	 Yss8pXytw1pkIIDvisiQmOR1ykgmeX0nD9mRfN24NjAJ28AQDwXpzjTlSsllLJSnYw
	 t1/6J8VUrHyfEcTzpwzTTa4uB0+H+FGlwpwRAJvONsx997XLo4so9htaP7J88B+MPP
	 ZQkwHvkzZFSqA==
From: Kalle Valo <kvalo@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Jeff Johnson
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
References: <fd26ce4a-a9f3-4ada-8d46-ed36fb2456ca@freebox.fr>
	<5cdad89c-282a-4df5-a286-b8404bc4dd81@freebox.fr>
	<252618e8-9e80-4774-a96c-caa7f838ef01@linaro.org>
	<502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
	<0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
	<CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
	<87ttkh49xi.fsf@kernel.org>
	<e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
	<87h6gh406w.fsf@kernel.org>
	<ad5e178b-cd64-4a87-8994-f917993f3bbb@freebox.fr>
	<871q6tu6bn.fsf@kernel.org>
	<de65290c-0f67-4499-ba28-a460e6d6e419@freebox.fr>
Date: Thu, 25 Apr 2024 18:42:16 +0300
In-Reply-To: <de65290c-0f67-4499-ba28-a460e6d6e419@freebox.fr> (Marc
	Gonzalez's message of "Thu, 25 Apr 2024 13:48:50 +0200")
Message-ID: <87msphsb3b.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marc Gonzalez <mgonzalez@freebox.fr> writes:

> On 25/04/2024 11:42, Kalle Valo wrote:
>
>> Marc Gonzalez wrote:
>> 
>>> Do you prefer:
>>>
>>> Option A = never waiting for the MSA_READY indicator for ANYONE
>>> Option B = not waiting for the MSA_READY indicator when
>>> qcom,no-msa-ready-indicator is defined
>>> Option C = not waiting for the MSA_READY indicator for certain
>>> platforms (based on root compatible)
>>> Option D = some other solution not yet discussed
>> 
>> After firmware-N.bin solution didn't work (sorry about that!) my
>> preference is option B.
>
> Actually, Option B is this patch series.
> Could you formally review it?

I'm happy with this series and would take it to ath.git, just need an
ack from DT maintainers:

https://patchwork.kernel.org/project/linux-wireless/patch/84f20fb5-5d48-419c-8eff-d7044afb81c0@freebox.fr/

> Perhaps one thing I could do slightly differently is to NOT call
> ath10k_qmi_event_msa_ready() a second time if we DO receive the
> indicator later.

Good point. And maybe add an ath10k_warn() message so that we notice if
there's a mismatch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

