Return-Path: <linux-wireless+bounces-707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 392C280F425
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 18:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85941F212A9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393057B3C7;
	Tue, 12 Dec 2023 17:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUaoRgfn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6137A221
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 17:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF99DC433C7;
	Tue, 12 Dec 2023 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401163;
	bh=11KCF6eSfX3xll38pRiWQMZTkETjMhw6UMQe+oezm78=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=JUaoRgfnbG3rvgefKvEPEIVdTLPOtFJN5zQ42Fh1q7LwJIk11bBtG/fSym3OaFS4X
	 8qyGvBj+NLb+mcwzSbuOghxn6a9l/E5Hjv4Mi0G/p4rhyO6uD/9tkPVNH+d3dmsr0k
	 PTbIPFnx9NrjdRdWQdSQARv5GU1EGVDRIYd3Cj80kKij6aOSPrV8btNNt1aD/Lnodx
	 crc1c/nXU+NB4z8CNtz4cw5j0dDOXZDbnj3z1DAZjjidn5czF/Quhz6VtG2ZGtzGyo
	 NxBn+VjFRyk7xqKDamf6cq0qZDZhVUVbCawrLU39Qba21U14d+rpiEjYwuYV+Pd1AJ
	 oQz4W6NGLcBmQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: Fix ath11k_htc_record flexible record
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
References: <20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook
	<keescook@chromium.org>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170240115970.422537.17165398794556525510.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 17:12:41 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Transform the zero-length ath11k_htc_record::credit_report array into
> a proper flexible array. Since this is the only array in
> ath11k_htc_record, remove the unnecessary union.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

add731385eed wifi: ath11k: Fix ath11k_htc_record flexible record

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231205-flexarray-htc_record-v2-1-fbb56d436951@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


