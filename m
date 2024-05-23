Return-Path: <linux-wireless+bounces-8009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94A8CD2DD
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6907E1F2061D
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2417A13BAC7;
	Thu, 23 May 2024 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn9j6Nu5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B18174C
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468928; cv=none; b=j3WY+j/Svgyg+07d1r/ZjvndOSB/sBnUMDpDPb1Psy/jr5lZlT2wTfVaSRALDiFBAEpA5h5fq4ycftivHxsR8TUW76wdmKTbxu7sIvBVzldkMnqVq7YKrhAOZkstRPdG+AbgznjL3qkbUwCzUjiIc7DwDVA0Fud9c3lnWctOx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468928; c=relaxed/simple;
	bh=H7x7rZBnnIHpTamBE2p08RqJBe/ZOmnl1rL5sp92f+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lwF4OUIVJufsroxzK1N5i66trOcfp6H3A7Ui5t/tHn1BK6I2IA312IvDOdWPlDi6Q1C6TaOQv5x042jtfYZRMoYI/JTsjdiOz/M26YU4kDgYFyMQ15hLCHYKft189Lgq5hUfz+ep67SjJJyWR8hYhw+mQtw9uvXMZTwJBUFx+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn9j6Nu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A00C2BD10;
	Thu, 23 May 2024 12:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716468927;
	bh=H7x7rZBnnIHpTamBE2p08RqJBe/ZOmnl1rL5sp92f+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Tn9j6Nu5RWnGvfsSGyOmDKzefvjhvyHI4uqR8rZPPlogww0Ou3J9BoJqwCkAubZtW
	 qoeummKv2LkMNhUby0fAhy9O9qziJtmB6TLxoyb6EZlgifTJI8b4XsJZ9KGVLAfHnb
	 AoqeQmqlhs4Z2kzSa7ZsX+fdqKSeRsVw2393jszKf4GYikJYYcKB9ihK1xEtpVav6C
	 ITEmvJF253nv5613BVt4db7s1wwYFJtjijODLZl+0ZlzM2dzlqkCsMvDckF7MchgSJ
	 lRkAyDrcuQOVKv87fVYrNuqlgDjksNNh792c3GTt0GNVuv+bK0q5N11Zed3zs98oe7
	 Ofi0UsDiwZDbw==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] wifi: ath12k: Fix Pdev id in HTT stats request
 for WCN7850
References: <20240510050806.514126-1-quic_rgnanase@quicinc.com>
	<20240510050806.514126-4-quic_rgnanase@quicinc.com>
	<87pltfd2bt.fsf@kernel.org>
	<667cea80-9b62-4ca4-9d28-c5940582832a@quicinc.com>
Date: Thu, 23 May 2024 15:55:24 +0300
In-Reply-To: <667cea80-9b62-4ca4-9d28-c5940582832a@quicinc.com> (Lingbo Kong's
	message of "Thu, 23 May 2024 20:34:51 +0800")
Message-ID: <87ed9sbscj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

>>> +struct ath12k_vif *ath12k_mac_get_vif_up(struct ath12k_base *ab)
>>> +{
>>> +	struct ath12k *ar;
>>> +	struct ath12k_pdev *pdev;
>>> +	struct ath12k_vif *arvif;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < ab->num_radios; i++) {
>>> +		pdev = &ab->pdevs[i];
>>> +		ar = pdev->ar;
>>> +		list_for_each_entry(arvif, &ar->arvifs, list) {
>>> +			if (arvif->is_up)
>>> +				return arvif;
>>> +		}
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>> I'm not seeing any protection here, is that on purpose?
>
> you means there need to add lockdep_assert_held(&ar->conf_mutex)?

I mean what's the locking design here? Is it safe to concurrectly access
ab->pdevs and arvif->is_up?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

