Return-Path: <linux-wireless+bounces-7278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE48BDF89
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 12:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AF21F23426
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A53514E2F0;
	Tue,  7 May 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIyH0Lfs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5639114E2DA
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077122; cv=none; b=ELIGyKUko3xEt33xPfp/Hlq6Fn/EEIp5Df0d+bTPvNY9nvg16QOx+pzd9Pi1HJPVFvkFGl12BKAS92SAvrEqYvpc5+mZS8HRdyZv68zwCa2UsBe+Ofr0saYTcpQwrsF75wugwLQNT9o6AfC0rtaTe4E5TrKc+IsKD+sIVdlflvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077122; c=relaxed/simple;
	bh=H9Ov+02Db9ZsbaLN5N5fV/vO7IHWQQc9uE2lzc5cVUo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=kDix1k/JcYNSgqBAcIpdZBvxXZ670/4gVQlNbb70qtRtboX1i64os+W5k8vEPAwM7qW9Cdznv1lA9luFdYehJJ7qVMrFF31GRub4bSL9LZ+iLb8xTqSCdJEvE7Bfz8x76HVmGAFSmj33tMNTsIcxrDRmVSRqdOlQGClDoucnbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIyH0Lfs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69ECC2BBFC;
	Tue,  7 May 2024 10:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715077121;
	bh=H9Ov+02Db9ZsbaLN5N5fV/vO7IHWQQc9uE2lzc5cVUo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=rIyH0Lfs/fwGgwZSDIeeBhAR8TdqwGoj5t3vHJPTzx9PxSUn+HSjkSsGQwZAkaEP3
	 5kimOsi0l0MnEdtFfpIx7swqYTYRTMOF7g+OFjJbKmIaBfQBb+vR4xpmzBCYDdWn82
	 OA9gSWDnROo9kf1VtKDBrqFUvICfjCcdxFkcV16MTBjldauuJDTT6ZKmDVhUIlI/uj
	 xvqmm3NzMN3GJcNEMAZAbdxggJuCAKSEJDo7RK1JXd09FTk3uDNvmwfb7RtEWE1duc
	 FpM7JzVhW3SZ7vYxJhnUkFUsIohVjTDrViTVGBauyJ8+EbmBSTIkAphejooUpSwtej
	 M7MdDQlpoBULw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: ath12k: remove unused variable monitor_flags
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240429081525.983-2-quic_kangyang@quicinc.com>
References: <20240429081525.983-2-quic_kangyang@quicinc.com>
To: kangyang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_kangyang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171507711881.3827098.17675343914805366101.kvalo@kernel.org>
Date: Tue,  7 May 2024 10:18:40 +0000 (UTC)

kangyang <quic_kangyang@quicinc.com> wrote:

> monitor_flags is defined in struct ath12k. Although it is changed in
> some places, but it is not actually used.
> 
> So remove related code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

782615f280ce wifi: ath12k: remove unused variable monitor_flags
3b0989e925f3 wifi: ath12k: avoid duplicated vdev stop
f40aaca07bf7 wifi: ath12k: avoid duplicated vdev down
efd920f48d1f wifi: ath12k: remove invalid peer create logic

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240429081525.983-2-quic_kangyang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


