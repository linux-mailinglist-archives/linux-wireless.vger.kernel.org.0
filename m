Return-Path: <linux-wireless+bounces-239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED97FF7AC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EBA0B21070
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02C855C16;
	Thu, 30 Nov 2023 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsKOulHi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0A3C694
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 17:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93413C433C7;
	Thu, 30 Nov 2023 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701363761;
	bh=kO+tnUITBtUkmCBdvTfQ2GZDs3tBiJ+5QDKUMcdiWiQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HsKOulHiEFMsie379PAyzTppAf+fKQ5a7JnlnEyQRPoYOR1P8kumyu09/gj56nDPh
	 gAIs7ZXgxCNAkStlAxaa9F0ZSwrGktOEZJcb5TUmUsUohCwMcQPk0mlhTZkl74fX4E
	 zzNfHcioHZbu+mo28SbXBZK8i8pdMKoH8HXkswu1sc8eG2YlDoHBWCQ2CA6QpJfjXV
	 NB7CJK023lMTfw2idbwJ0yDa8YX+qJFLAjBpdEfD0op4CsYn7yVps/2ufWBTqj7JjW
	 IdI4OEEnEExiV1Ma4P7BIEJHRrglU0W8ltn3mKw6TzGktIsKSvuj9RPENFvCt3u3Dl
	 m8A+YYeDNl9yQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: ath10k: remove ath10k_htc_record::pauload[]
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231127-flexarray-htc_record-v1-1-6be1f36126fd@quicinc.com>
References: <20231127-flexarray-htc_record-v1-1-6be1f36126fd@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook
	<keescook@chromium.org>, <ath10k@lists.infradead.org>,
 <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170136375770.1435047.461679171270420722.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 17:02:39 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> The misspelled pauload member of struct ath10k_htc_record is unused,
> so remove it.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

c7876faa91ab wifi: ath10k: remove ath10k_htc_record::pauload[]
7b4df59fced0 wifi: ath10k: Use DECLARE_FLEX_ARRAY() for ath10k_htc_record
f20eb4cb9324 wifi: ath11k: remove ath11k_htc_record::pauload[]

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231127-flexarray-htc_record-v1-1-6be1f36126fd@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


