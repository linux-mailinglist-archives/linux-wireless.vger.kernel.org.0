Return-Path: <linux-wireless+bounces-7145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34378BAD43
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E9281B63
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 13:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4925153575;
	Fri,  3 May 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBqI4fqa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C391514E4
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741952; cv=none; b=dym2DZYU0Hd5Jf/dsj0t525umLtMShJgrp0Nb9yyey8hoXQyItKOd0v2RoDLZlY1CquRfmOXVAbegCw/B1gzYIguF/T4DZ5BCKBbjibouEa7ZV6u24NrcOVo0hrXk9muZxHBM/hRj4t2UNqtl/Yx6f7dEDGS8pVxPnFl8zyQNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741952; c=relaxed/simple;
	bh=jBar2W6RBh1+V35XaFhWDL8yZRs0q9RXTXHdlT0dLZc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cDYzevMvIqkqwqbtSW8i7MA4p0mk9wYIKyZViiGrewTxMp80Q0R3JfZ8NqB1VdvaMv9T9EzGrBRGRMC1N1otPCdLVQf0q+/qAH52dNGbD0vDwWNi5KTE4EWsYQ1z2Mj2EDhZqFwOyWWvD24qEKwisQZmg5Beg2c0FAhHJp+Kvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBqI4fqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787ECC116B1;
	Fri,  3 May 2024 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714741952;
	bh=jBar2W6RBh1+V35XaFhWDL8yZRs0q9RXTXHdlT0dLZc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=DBqI4fqa7jYGNW0KwMMfbO9a7KR1ELmYvkUEtzfj67AAbFcuY1DKWS10tNz2vCi0/
	 pdkEqlAFhsz8FyYkR3FCWctALv2f09Ofw6Cwy+PAzQ+EvF9YDvg8PS+DS9Y0Ou/DfO
	 zb8aD/eitwXiGljtvCDisMfrQtJV7Jsm9kxj2j/h86eQzstK43I+hwQE0aK8KDuk6h
	 PDBtBiYs/zC75N2HMC1IgMN6ofEjAPGWg/J2zk7s6RAT6GB8ZkIWsw2CbzHin/z49w
	 UhWx5g7F9HM6hyT74alA7T8Fi4XFwkLp0TkhxVFdjNZCLcuzhwmKg+5RlP/6EFW3Xw
	 ImggDibAOGCJQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] wifi: ath12k: Refactor the hardware recovery
 procedure
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240425090307.3233434-2-quic_periyasa@quicinc.com>
References: <20240425090307.3233434-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171474194939.1512332.8024949318765059348.kvalo@kernel.org>
Date: Fri,  3 May 2024 13:12:31 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, in multi-wiphy models, the recovery handler access mac80211
> HW from the radio/link structure. This will be incorrect for single wiphy
> model, as they will hold multiple link/radio structures. To fix this,
> access mac80211 HW based on the number of hardware in the SoC/chip. This
> approach makes the recovery handler compatible with both multi wiphy and
> single wiphy models.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

ecd509b6f263 wifi: ath12k: Refactor the hardware recovery procedure
9b4e5caaf590 wifi: ath12k: Refactor the hardware state
acaa84009fad wifi: ath12k: Add lock to protect the hardware state

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240425090307.3233434-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


