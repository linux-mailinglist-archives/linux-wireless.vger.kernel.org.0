Return-Path: <linux-wireless+bounces-13021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4597CC75
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DEDDB2318C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 16:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1701A2C14;
	Thu, 19 Sep 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlJ5eFln"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE031A08B6;
	Thu, 19 Sep 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726762638; cv=none; b=HORS4z6lIfHWEVp94aGZFz/io3WIrZbZxuG9DPOBC/skCHFSMewdPRO2C8DtyAJ/zB1qOzPu/j+I/RBPsgrsTG478G4jfiHL+MthE4a5Grfj0DSkqS5wwQROdnzA2CNycdA6WdAFVoQqbCUFxR6lsmXxd2DiHn+NdZhAEq5gWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726762638; c=relaxed/simple;
	bh=sjj4xoGZyqBiJoPJLOdx5QdG3kIiMdBBPYT8rVH+FNU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=UWsMkn+ajnE5uOgbLiKNEdaIiBVCb2RX64tM1ZFiwCvnX0Tllj/Fqf50OJ77SPQV9uF5/2H3NhW7NH0YfubgUvbFalAPwqQCpGkdIsmk03nU6S+oBdCox7L/v16yS3RV+QMKZfdXGvcGG4dQ1NIfgAhGyLcOXxfWCAhaWgoUbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlJ5eFln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1157C4CEC4;
	Thu, 19 Sep 2024 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726762638;
	bh=sjj4xoGZyqBiJoPJLOdx5QdG3kIiMdBBPYT8rVH+FNU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WlJ5eFln1Ei+yDSLAvwG5p1jF8wz+GnlJS3mfddEyWXqJwBQXKPMdpSE8zB4ZCiws
	 MbsO+o1pskEjg1J1F/2NqrTvrNu+g/W7uJ1xkyoLA05bJuJUncKPPlLX50KkSiew8A
	 B+tZQDCChDF4NrMSY37IFBKg9FcMd+mHg1aReOGuQ9ep3mwSXLPBs7IquMVlcbwU08
	 UxWrebmN1/U4RvSyTdFJy6E0iXib7kg/hGgyXDkzpHLAWg2ix9PrBmvGn8L01aXmAA
	 OBU4U14L6EeWodnfz7DPrlvecK78wxko4HaB1HC+XJvMqwRMKnSM/8QRbIb59db+Ep
	 RN0gCKIzG50ag==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] wifi: mac80211: make read-only array svc_id static
 const
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240912144456.591494-1-colin.i.king@gmail.com>
References: <20240912144456.591494-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172676263461.263986.17402367834704723969.kvalo@kernel.org>
Date: Thu, 19 Sep 2024 16:17:16 +0000 (UTC)

Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only array svc_id on the stack at run time,
> instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f8acfee2f8e0 wifi: ath12k: make read-only array svc_id static const

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240912144456.591494-1-colin.i.king@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


