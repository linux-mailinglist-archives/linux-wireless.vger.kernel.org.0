Return-Path: <linux-wireless+bounces-12966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D146C97BF62
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 19:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6351C21D7E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 17:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3E13B791;
	Wed, 18 Sep 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruFVYeEI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8279443
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678882; cv=none; b=d3q+E3OVLFvZHjxW4Pv5NaS/6qwVTylyRLrVDsJLAi7hH1GMP8pLhgjsEuPx/tSvoSvgj/I4+Jk2y/lH++0o3mVE24ZPvvTADStEHOJ+SzesYAT6cCZ31QTmmv4GuMm9kdCXD/iBclCiy+J+hnGMy2XdfRsH+Gg5ySu6+1B7wEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678882; c=relaxed/simple;
	bh=t5F0wLdbX2tXwGDRdSfd1p6irhW0i7Nc5AcrWFfkXmw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Z/waX2FOoDXlqfSzO/i17sVRck6cOCPF2ZTv4eRGKCEPD76U5Ry3jtyR7LRYe+f1tq2d9341OP3UVPP3T0sO/oFQieYyzMAkmPcKaPTMlL4fvH90EvyqVitCaMEFaTOr884/9M9RfFXkHOI8Yhc4SpKWei8/VzalFKdaygSSTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruFVYeEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB57BC4CEC2;
	Wed, 18 Sep 2024 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726678882;
	bh=t5F0wLdbX2tXwGDRdSfd1p6irhW0i7Nc5AcrWFfkXmw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ruFVYeEIVDQycw1fxNHRMubk0zpE1dOoaYqUxt0TZygslLdbXv+t/YS9R5pLPwoSR
	 Qm+domV3orsJDsL7y6ECvJhIN7m0MowfzDejd0IrIs8EucufM3oe+7bbPT2JydMl+A
	 MHQiYGowN5EDf1tMWl7fRUtO9+Ye1VYTERPya3mZsfAKcs1JffqVQcWlcisl2r6PEv
	 XMdLSTa5dzQfee0Xo+uU1YTY0gTeQ/jYT5M9OEYeIZZYArHol12hkLlZJzcM9Axqyo
	 8o1HNzsz82JDcB94VEv7MrXJ+FA6wAoKajfSIQI5EbcAd8OzhiW5qL1IceH8LgqfGp
	 PT478PfqD4NgQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 1/3] wifi: ath9k: eeprom: remove platform data
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240906195359.6982-2-rosenp@gmail.com>
References: <20240906195359.6982-2-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, toke@toke.dk, nbd@nbd.name,
 yangshiji66@outlook.com, hauke@hauke-m.de
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172667887913.4089263.15911018536976803623.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 17:01:20 +0000 (UTC)

Rosen Penev <rosenp@gmail.com> wrote:

> There are no more board files defining platform data for this driver and
> eeprom support through NVMEM has already been implemented. No need to
> keep this old functionality around.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

841e1ff5369f wifi: ath9k: eeprom: remove platform data
e46333b41e43 wifi: ath9k: btcoex: remove platform_data
2b0996c76462 wifi: ath9k: remove ath9k_platform_data

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240906195359.6982-2-rosenp@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


