Return-Path: <linux-wireless+bounces-26175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB19B1C758
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90133A8F5F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 14:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1DE28C867;
	Wed,  6 Aug 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVCz1cPx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866D23F295;
	Wed,  6 Aug 2025 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754489297; cv=none; b=OQ+zjh/mlVIntSW7OxSq/9/sm+/in7O8lKlwO8kp0W/95QlWSYK60W7qicMwr4gh9M/SwvwWjekzgMPlfawXtItisrEuvdzdJTejNtxob7GN8oKavIod5NVobgpmHK9KPR8KAPgN8I5EY3KGSQrSZaZIoh5LiNJrajilaEAoZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754489297; c=relaxed/simple;
	bh=gFK8OTJEyw46i3VVqV/FUE5R71FnlRtaDMqr/AA+WRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRYWDIcWF8UvnRJYLx/AQiSn0S5Hcy/MYVN2JjNWrBmlFG+BFGqUPGcXBX654Y/YjNScX3+2LYOswD8hZVYtKXe+P+MjAmMs2tm1bwbOaOGpHh8orroir+9or1+WyScAI5r1oWO5GpuDuD/HXfkxid8u14vqQjM7SrshgqlDpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVCz1cPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1F4C4CEE7;
	Wed,  6 Aug 2025 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754489297;
	bh=gFK8OTJEyw46i3VVqV/FUE5R71FnlRtaDMqr/AA+WRk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tVCz1cPx3xfRSiEV+xPPufAJlChb2haUwVPpseZ89ETmuc4dbD+YrtcQ8iz5CvWeM
	 7Rp0A/Ps/YDEkwQL44PUSvOCYyHO7FgLRMu9ikP1Tm0oAKr00q9GWIi46aTQOLBktu
	 83odU3wC1kL/CDqXSftPoucl88vHCiNu4zFm0TdzTgxqaZQSXnTeZHgNbgsbB9PXo6
	 +xfy6okJAzoqGlBKYNV+xWZBuJ7dMmlpBVzu+BJOwt28/bVBUzcDZ4+azDYVHdVJ8O
	 YyNtp1HDPD2vVSzcKfIbR7dbnp09An1BViy1QPw6IkdnA3Sx6ttTeQeIsIbvgPgRdr
	 M3B9gYrWxEhqA==
Message-ID: <87566200-1d0f-4360-bafb-f7a7fab67f3e@kernel.org>
Date: Wed, 6 Aug 2025 07:08:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
From: Jeff Johnson <jjohnson@kernel.org>
Content-Language: en-US
In-Reply-To: <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/2025 5:41 AM, Mukesh Ojha wrote:
> pas id is not used in qcom_mdt_load_no_init() and it should not
> be used as it is non-PAS specific function and has no relation
> to PAS specific mechanism.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
>  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
>  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
>  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
>  drivers/soc/qcom/mdt_loader.c                | 14 ++++++--------
>  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
>  7 files changed, 17 insertions(+), 21 deletions(-)

Acked-by: Jeff Johnson <jjohnson@kernel.org> # drivers/net/wireless/ath/ath12k/ahb.c

