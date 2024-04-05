Return-Path: <linux-wireless+bounces-5910-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92119899E47
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262E628857E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F916D4CB;
	Fri,  5 Apr 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lttrIDkP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D116C877;
	Fri,  5 Apr 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323660; cv=none; b=tZSI/4CPIjyKWhYfJcGFXdGrbYF6acM07JtMYc6ZEhH3nDLIrlSH6HFJATi40CiMklKj5BfpYV9Ce0vcT9kAx6fuUDa9N3bcDHr649NHmQGKVlvMhXx3tmYuXg343EQjzYpupuPB4PzrgTNyg9NJpJMVxdaY2oMUyhrSI7R2vf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323660; c=relaxed/simple;
	bh=iitSfI2Y8LrBa++ncwel3h3WEbl4CDisdRxqGPA4c5k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BNFdwAH1jhN8JGivG3ltKJ8qdfaREFosQH237bJhm0Yprpaw7klsj5GWMVW0bjCI5ugR2BnYUdbxkIJkPsHjy7iRBZE+0JMIuA4PUWzlOB/Ba/hPAvZY5DHHO6VgaJGBpCJhG6Afc6gMV6P1PMp91Yx6BlIzZyOWtgTHAlsil6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lttrIDkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B728C433C7;
	Fri,  5 Apr 2024 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712323660;
	bh=iitSfI2Y8LrBa++ncwel3h3WEbl4CDisdRxqGPA4c5k=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lttrIDkP/Dhv4IN6Lxk++khK7XWYBENBQs6ggUCGtf4DyBhxkdh6xc5im0USff+Gm
	 CGtvdPhqBQXrMkVdiAK9fOCDiwUt4DBYoGSQMrfBcLx0RZuJBS61BL6I5sC+vn4znX
	 YIcIUcw19KqTIYxqWzBstbqn046g4X7EHfEJZpXflYZLLGDYFsnJWu4jewvExLRNCJ
	 ONIAaJAuozMJ0yVdPHQIKJmPUQHyHzlkuSggeVvYchurL5QnIVKtJn0ZNCpp/Fr0C5
	 CAWNm+FbmdZoeV9fPnY1PH5ZjXyWz/tmhUfd/lezExNCXmYevrmZebYkyySrghUINF
	 08r5k2y+i6y3w==
From: Kalle Valo <kvalo@kernel.org>
To: <davem@davemloft.net>,  <edumazet@google.com>,  <kuba@kernel.org>,
  <pabeni@redhat.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>,
  <manivannan.sadhasivam@linaro.org>,  <linux-wireless@vger.kernel.org>,
  <linux-arm-msm@vger.kernel.org>,  <mhi@lists.linux.dev>,
  <netdev@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] net: qrtr: support suspend/hibernation
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
	<20240305021320.3367-3-quic_bqiang@quicinc.com>
Date: Fri, 05 Apr 2024 16:27:35 +0300
In-Reply-To: <20240305021320.3367-3-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Tue, 5 Mar 2024 10:13:19 +0800")
Message-ID: <8734s02b3s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi netdev maintainers,

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> MHI devices may not be destroyed during suspend/hibernation, so need
> to unprepare/prepare MHI channels throughout the transition, this is
> done by adding suspend/resume callbacks.
>
> The suspend callback is called in the late suspend stage, this means
> MHI channels are still alive at suspend stage, and that makes it
> possible for an MHI controller driver to communicate with others over
> those channels at suspend stage. While the resume callback is called
> in the early resume stage, for a similar reason.
>
> Also note that we won't do unprepare/prepare when MHI device is in
> suspend state because it's pointless if MHI is only meant to go through
> a suspend/resume transition, instead of a complete power cycle.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Could I take this patch via ath.git tree? Full patch here (same patch
but links to both patchwork projects):

https://patchwork.kernel.org/project/linux-wireless/patch/20240305021320.3367-3-quic_bqiang@quicinc.com/

https://patchwork.kernel.org/project/netdevbpf/patch/20240305021320.3367-3-quic_bqiang@quicinc.com/

I ask because we need it to get hibernation working on ath11k (and ath12k):

https://patchwork.kernel.org/project/linux-wireless/patch/20240305021320.3367-4-quic_bqiang@quicinc.com/

Kalle

