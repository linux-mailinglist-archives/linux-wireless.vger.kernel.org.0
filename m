Return-Path: <linux-wireless+bounces-26164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6969B1BE82
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 03:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C122C18A62B5
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 01:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F8115B135;
	Wed,  6 Aug 2025 01:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI7hivLN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF03C01;
	Wed,  6 Aug 2025 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445446; cv=none; b=B6cRdBCsPb+dbiYMD0bavBuynF9w9i04aBO8p49HN9X8A8Xxbmg3pE0ycnDP1h+cFvjby0GiVTFm2Dp1O3HEv2cn/iwhiPSJeInwx+JZLTCua4jOCFxSRsCI4hFaaI1XdcT7jHWPPVE4KH7GwfJs4J1grP+QBaENwkCbKU2q57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445446; c=relaxed/simple;
	bh=csXB9gb47w8+FD2wsMEeDNbF/7k2ffF9DLNSenl3YmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1m6a2hXrZYyvhoWGNeYnFV7d5j3t9zK3vOp0cME2sAoqQflCKZIZAtQzDn8Cz1SD+alMCEBVYvyWXW6Qw6eMPUP6AkKB2ay/Bcgbn8EVo68BtGK+3S4rN9day1a7rY3NJ8Exo9zFxL3Oz3lWjoKYFX+MZD3hf6nxGpSSXSLKt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI7hivLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D6AC4CEF0;
	Wed,  6 Aug 2025 01:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754445445;
	bh=csXB9gb47w8+FD2wsMEeDNbF/7k2ffF9DLNSenl3YmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MI7hivLNFXepCxtmZ8Il7Bc0D4Ld7flGaMzjcwL+vHwkmUH0UwN8tV3KyNMbry6ip
	 XYMNsyShxYUIDxUk5zVhiKy0BoE5pB5IwPXzyXjADisCGomwkhz5hLorn2SfTvZrSp
	 8SYaV8Pry5+A1XtmxEJZT+ldvZvSqDkXywLo2OCQO54I9tImHitGwWNgWIGf7S/VSY
	 jPrKdVZa5tuXh2ERv/jz/GkTAl9J2P5MfUb/KEkNxsjZkvjk4kKXzrm8+5t32hBQ3A
	 rtSXp6U83nJPEmsLSy1Wh/OMMvxoGSc04zGpAKjO0oo89ZgCsbatrIUboc8Gjujd6z
	 6hIjf7czaZTUQ==
Date: Tue, 5 Aug 2025 18:57:23 -0700
From: Bjorn Andersson <andersson@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Dikshita Agarwal <quic_dikshita@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] soc: qcom: mdt_loader: Remove pas id parameter
Message-ID: <di3tbtg7cxvrn5ewiiigodukek7om4uxlev5de37d7l76gyscp@mtgexdcar54v>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
 <20250804-mdtloader-changes-v1-2-5e74629a2241@oss.qualcomm.com>
 <658d7d55-fd5e-42cb-bc5d-abcc0b47a168@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658d7d55-fd5e-42cb-bc5d-abcc0b47a168@oss.qualcomm.com>

On Mon, Aug 04, 2025 at 07:17:02AM -0700, Jeff Johnson wrote:
> On 8/4/2025 5:41 AM, Mukesh Ojha wrote:
> > pas id is not used in qcom_mdt_load_no_init() and it should not
> > be used as it is non-PAS specific function and has no relation
> > to PAS specific mechanism.
> > 
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> >  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
> >  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
> >  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
> >  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
> >  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
> >  drivers/soc/qcom/mdt_loader.c                | 14 ++++++--------
> >  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
> >  7 files changed, 17 insertions(+), 21 deletions(-)
> 
> Since this patch touches files which go through different maintainers, do you
> have a plan on how this will be merged?
> 
> I can ack the drivers/net/wireless/ath change once I know how it will be handled.
> 

An ack from you and a venus maintainer would be preferable, then I can
pick the change through the qcom tree.

Regards,
Bjorn

> /jeff

