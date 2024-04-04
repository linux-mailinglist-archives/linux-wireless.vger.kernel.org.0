Return-Path: <linux-wireless+bounces-5871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A841898697
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 13:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5601C23209
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Apr 2024 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862168627B;
	Thu,  4 Apr 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tinh7T1d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42084FDB;
	Thu,  4 Apr 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712231871; cv=none; b=NjoQNAnp4BJEd/JMWijGm5QCPn485n6eKQ+Ja11PPltoiwIzkAWclVYCGZ89EmPi90dDuJdibmObk6MQwakklp9gOQ4Bwe0ird6iRvBDbiuIB7jl0zvODvWarWcgmF6rTNJJ5/BObxCGkB2Ne9SElQkdpkKmf0TrbreECIDdwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712231871; c=relaxed/simple;
	bh=oyPatv7PBt0holfVUYukJP8QPI1R/fKA+cCRZYJIaig=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=q/kI0lYFHM2rEg+IlcnCUpQSvTMU8mekHhUkSiFPYDn04jZ9w5rUaY/5rP/2OTUUb8Xj9g7N+7loXYTUxDH3witr30XJkTOK56sD7jjh4feqrQz5vF1hVd6OnzJZ3A+017dL/ietnzgQ+EIEO8oAkgPA71QhSQVDS141etgQseo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tinh7T1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77253C43394;
	Thu,  4 Apr 2024 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712231871;
	bh=oyPatv7PBt0holfVUYukJP8QPI1R/fKA+cCRZYJIaig=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Tinh7T1dpbBAZFIvgHQsGQjt/0I1nrX4iqfeXu6jrWUyo0+9kaF8XGmmZlRy6aOC5
	 Zmwd/1oVr0T/Kg9Nn2oSMiHafCk4mhUXyd+luoCFjq467AEyDpYcK7iDtXUsPiNuNL
	 8Xw+aNrCE0jUfDUCFdk9Khq/JW4SGqYWP57ZJNTi9Qr4RCiTJ+CzRlcDK20UGnTwSS
	 ob3QmPFqAUTKh2ettqurQvj4LdISg/4YfTfbTQ5wR0iOc4KfVCYkZ4gU1yVcKBDI9G
	 XXN/KsC5vZ7EEiMcW5YxK64qwoTJsXGt87SloFje7xCrntHwidNNeOyVbXW1njOb1D
	 yMiaOE4OIyNbQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>,  Konrad Dybcio
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
Date: Thu, 04 Apr 2024 14:57:45 +0300
In-Reply-To: <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
	(Dmitry Baryshkov's message of "Tue, 2 Apr 2024 18:55:56 +0300")
Message-ID: <87ttkh49xi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

>> 3) ADD that compatible to the wifi node in msm8998.dtsi
>>    compatible = "qcom,wcn3990-wifi", "qcom,msm8998-wifi";
>> 4) In the driver, set qmi->fake_msa_ready_indicator to true if we
>> detect "qcom,msm8998-wifi"
>>
>> And this approach would be acceptable to both ath10k & DT maintainers?
>
> I'd say, we should take a step back and actually verify how this was
> handled in the vendor kernel.

One comment related to this: usually vendor driver and firmware branches
go "hand in hand", meaning that a version of driver supports only one
specific firmware branch. And there can be a lot of branches. So even if
one branch might have a check for something specific, there are no
guarantees what the other N+1 branches do :/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

