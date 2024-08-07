Return-Path: <linux-wireless+bounces-11072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D07294A281
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72113B29EA5
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617A1C7B94;
	Wed,  7 Aug 2024 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7/X8GG+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E461C462C
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018490; cv=none; b=BTtRgB/xKc38dskZvzNiuka02SR5PnyZetbpS8LGbuRc/S8K9yefkgwQQiKsEqQZINSbZw0d5627ZKoSgcTQWx/2zPZ+Tw5N1PDloHw+GfKqcHe7GkCfYhabqeihjUvsQW4qzuKux8QeimHHajmDDrs7YiYyCVFHySM11CdWrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018490; c=relaxed/simple;
	bh=S6A48Lo+MHIv1exsOmOR5EUr4shcLF6VpRjYFZfgIiU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jAf7dNiBF8/Qq4t/WisEHA+SpVwNgjEoFg5fpksc+gCJCjeOZxlD8Yu/OUqxDKlBWO7L5w4CKNh3ZxvgmqR6ZuZSHBey3QdojdW75CtAwfq4Zy2BT52KXNbqfQJVYhA4vEZFOtAvxj40NrYRCgr7J1p2JE0tpTWHTpBqJyJ94/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7/X8GG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986C3C4AF10;
	Wed,  7 Aug 2024 08:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723018489;
	bh=S6A48Lo+MHIv1exsOmOR5EUr4shcLF6VpRjYFZfgIiU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=J7/X8GG+STwwU5AkaNvtfMCXT6PXw8Pr/JRx9zb0Oug8gLmSUlEp0+EKu0BMcPrIB
	 EJBAqin7zo8A88cm8036eEDFf6F1lUfnRwN/kPqUujNl/coCCCfChLQnsFKj5eTwXH
	 OKHyFd6ca9kOtOFnutl2pJPtS0MopeqY1r/SGYvUsnOXhb4QGzq0PMdIXBklcaPiJQ
	 Ac6xyd8UjSSsMTf+FgqEnLa0CJOdH9lsK9GO5uoI3SsM7GCF9xhWfs7+EFN+NJfF22
	 x/TEx2v2iJMVk2Kl2RAn+/1nWhCFccjmNxg0YL1lF6vGaksM0N9oX2gQe0YqlpMmAo
	 s5Fza+4fnjf7Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix invalid AMPDU factor calculation in
 ath12k_peer_assoc_h_he()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240710021819.87216-1-quic_bqiang@quicinc.com>
References: <20240710021819.87216-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172301848704.3886758.606294440184310150.kvalo@kernel.org>
Date: Wed,  7 Aug 2024 08:14:48 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently ampdu_factor is wrongly calculated in ath12k_peer_assoc_h_he(), fix it.
> 
> This is found during code review.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

a66de2d0f22b wifi: ath12k: fix invalid AMPDU factor calculation in ath12k_peer_assoc_h_he()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240710021819.87216-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


