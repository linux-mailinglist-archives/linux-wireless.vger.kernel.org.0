Return-Path: <linux-wireless+bounces-7767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 076CD8C811B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13D2282B53
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 06:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E314A8D;
	Fri, 17 May 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekm0KA1N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498214280;
	Fri, 17 May 2024 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715928908; cv=none; b=WnizOKiSpo79rIRBJevlY3TX+4hq7u28vYvWtkZn6iaKawIx8UvZRS8xOm4iurViJJxODq1zZd9yi9ey5GW4y7Gr+gmag19DgVLeVuMRHMEjsSvCb3D2I2xSUIX9KRLj1nW8TDD0xh6oHvzFZCLsisk5Q9Kf1Wn5RCAg8hF5Pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715928908; c=relaxed/simple;
	bh=SW3ZvHpjpz+gPQr9MPYdbKfCS55xJrzsHF5C2fLpP4A=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=BwA4vaRhLO5BskdpIOgvnFqrb0M9NxZgJ7h0sbtPTiVfBjvav7ri77WgJNXcTZtauk4frUkZx51kZnLnOvqWjgkGJ5vkgNBNJTmpPF/Hk7FRs5lEvUtsZyXRgynhsEw6aQRCeIrM0ZabmE9BH/MH5SwpD1M3ogm61Zd5DtF1ME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekm0KA1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7AFC2BD10;
	Fri, 17 May 2024 06:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715928907;
	bh=SW3ZvHpjpz+gPQr9MPYdbKfCS55xJrzsHF5C2fLpP4A=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ekm0KA1N3po+VN2nl8FSMBex8fDe067oxg0wA6WvdlgUU58un+aV1gF21ycHzFrse
	 eHk/2boT+e2eArMJguHCfklPoa6WgJZMabAf0T2arkdy2uwIkOX2n4cbz5stwQ8g34
	 j4g9t1HYqnhFVvov+MxuBzN6hUg2JS0LM2bp5Xukj3RwBbjvWlltFkpXIoQlGp7nMU
	 3k3RMri0gA+wPzyiPd7riO9xOkKMTD6CQMX7YrMjB9XA+iMK3lrSFrFyVXzD4mh6N8
	 a0L0WeIXt0S4znk4ICduCdvMDTSenLJRPct99xMhXuIIZr38cMNaAsJlQ13q9bjxWs
	 krm+GumiOio+w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next] ath11k: Fix error path in
 ath11k_pcic_ext_irq_config
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240508185902.70975-1-leitao@debian.org>
References: <20240508185902.70975-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: horms@kernel.org, Jeff Johnson <jjohnson@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
 ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS
 DRIVER), linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171592890381.3197586.18328283621008534575.kvalo@kernel.org>
Date: Fri, 17 May 2024 06:55:05 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> If one of the dummy allocation fails in ath11k_pcic_ext_irq_config(),
> the previous allocated devices might leak due to returning without
> deallocating the devices.
> 
> Instead of returning on the error path, deallocate all the previously
> allocated net_devices and then return.
> 
> Fixes: bca592ead825 ("wifi: ath11k: allocate dummy net_device dynamically")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-current branch of ath.git, thanks.

637c435f08ea wifi: ath11k: Fix error path in ath11k_pcic_ext_irq_config

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240508185902.70975-1-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


