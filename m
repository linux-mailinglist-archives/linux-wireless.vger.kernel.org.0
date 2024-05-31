Return-Path: <linux-wireless+bounces-8362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F988D6940
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5411F264A9
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927D57E78B;
	Fri, 31 May 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPU2yyuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA17E761;
	Fri, 31 May 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717181610; cv=none; b=W4jm0eq++NEXv+5UBt8brub9Lk+e/uYv7SAiq5OByUj9ODwKi0y2d4LPeOZLV+QE5kLqVpiZFYLDwYcYUo5jBChYhGS3UasZ22h/caUZvvKdFLJcLcPDQZb9jUAPKKggfbvMpsRPYnklelK70V3YWFVHB4Y18EcFvtuFPAnxdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717181610; c=relaxed/simple;
	bh=kP2teycQbL2Gc6/fKZ6aB8TWymQ7VtmJws0fyRjuoSs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QpVd5S9qxuCTuObxuiVBJLyjR8az3756BIZndaOxYPebQ6WmycfbHuLsN8XxXquVwAS6HV80cok97cD3aFOc5Ec7vcCFAFkfkQasn+4BY6DQMiKF1abldf0fMUukfWihCPt3T5krZbpkAC/03/WxoWfG6trTwEiYIidPu4tTxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPU2yyuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CCCC116B1;
	Fri, 31 May 2024 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717181610;
	bh=kP2teycQbL2Gc6/fKZ6aB8TWymQ7VtmJws0fyRjuoSs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LPU2yyuKc1kxS15QMNDL0ebEIhqNUtLH5hw1khLndbJVeXI/e4OBBbK7z3kn+9OhP
	 BT5PD/PIsBAdW4rDlLBe3gQjqFShgjLw6TvJoqd6zUH8r7IvMwaf72SCgQ9kQhsRMu
	 56XdZg8e2r2leNQZ8wfNsNpMrykucZ+gUXN91EOZNHmyaGMh/rTxR179x5AtQRwhxC
	 MoUbH1oGToEwEhUo+KbEKgPmQQ7xMUAMhjCtLYC8ngeeDd4bp3i6JbLdL+spBaWCR8
	 cN2/tDvITUgArD5GbLNmMb0pB+ZGXNc23+SutWhroGl0hggOT1SrIuPW6y1QV+W018
	 u1AUCaZI/Y/pg==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,  Konrad Dybcio
 <konrad.dybcio@linaro.org>,  Loic Poulain <loic.poulain@linaro.org>,
  Mathieu Poirier <mathieu.poirier@linaro.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-arm-msm@vger.kernel.org,  wcn36xx@lists.infradead.org,
  linux-wireless@vger.kernel.org,  linux-remoteproc@vger.kernel.org,
  devicetree@vger.kernel.org,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/12] wifi: wcn36xx: make use of QCOM_FW_HELPER
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
	<20240521-qcom-firmware-name-v1-2-99a6d32b1e5e@linaro.org>
Date: Fri, 31 May 2024 21:53:25 +0300
In-Reply-To: <20240521-qcom-firmware-name-v1-2-99a6d32b1e5e@linaro.org>
	(Dmitry Baryshkov's message of "Tue, 21 May 2024 12:45:22 +0300")
Message-ID: <87ed9hvmmy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> writes:

> Make the driver use qcom_fw_helper to autodetect the path to the
> calibration data file.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Not a fan of one sentence commit messages. It would be nice to explain a
bit more in the commit message, for instance answering to the question
'why?' and maybe provide a short example how this is supposed to work?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

