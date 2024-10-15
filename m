Return-Path: <linux-wireless+bounces-13956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6399E2B9
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A8D9B259F2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A901DAC97;
	Tue, 15 Oct 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVQw9ysP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D51D9A76
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984203; cv=none; b=UNpsE7rjcvpDpBqCQve4T2z9PLnDZ9gnrHIbBF4+RnWzh+v52Bm9gj6SQ87l4I8LjNbsyjVbJCyQE8IV+K1QJoD/aQZ8VIIws6400s2Nd4LBUYz8oh1zYfHh23xYV+E3Wc3peRHeQWo09yYr+XBz1B3/Yclb1/lZfRWxm+FESHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984203; c=relaxed/simple;
	bh=aVx2P8n8ZyXSb5r6npYv24xMThDVa5tb3VuhMO2aR1M=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=AOa76lTn2DGWdC3LLD+aG/qVKdi/CX1JNU2xKqbAuwA/oOZp9O1M4Sm77291uylNN+VgmZ5dNe6OiAVBXW69Sdd97xzmmzAC7PLjepwcecW5SmMSh2saFH6sQs0xIVeP1jZ79y8lUMunNeFFunYW+q+2tN00/MyatS4aP6IRykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVQw9ysP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53AAC4CEC6;
	Tue, 15 Oct 2024 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728984202;
	bh=aVx2P8n8ZyXSb5r6npYv24xMThDVa5tb3VuhMO2aR1M=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HVQw9ysP13ogq2FAiqIPmQMEnAJMYdT7U45/TBFFZlX4JCjNcCd/YvZFISPbApd+a
	 iXTQ4eeSJklF1syCUYEGbw+lDDrLJWbGCELzfRU1ordYDnaJfhyMLkxH2B/1yv1gxn
	 PIOXvJF4gkbfM9Tcbi8vfgd32Epu0Uo2llmRpHZ6e7OXvi2FwhQfMQTjRbR8G7mCj3
	 gFeR1R+cPltJWKs9EpRllJ7e2XO7l8P5mu9tu/Ipl/tsWr/J28FqX5CmDJVlMgrmqZ
	 qvtFU8YV5Gp8WiVOACSo8lM8SZq0QMa6UABCDidx7ojWNZ+iik3fOJvOJ3wZHRS0zj
	 4I12orLJo2IFQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
References: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172898420024.235905.11004494352014224008.kvalo@kernel.org>
Date: Tue, 15 Oct 2024 09:23:21 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This ID appears to be RTL8188SU, not RTL8192DU. This is the wrong driver
> for RTL8188SU. The r8712u driver from staging handles this ID.
> 
> I think this ID comes from the original rtl8192du driver from Realtek.
> I don't know if they added it by mistake, or it was actually used for
> two different chips.
> 
> RTL8188SU with this ID exists in the wild. RTL8192DU with this ID
> probably doesn't.
> 
> Cc: stable@vger.kernel.org # v6.11
> Link: https://github.com/lwfinger/rtl8192du/issues/105
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

I assigned this to me on patchwork, I'll take this to wireless tree and add:

Fixes: b5dc8873b6ff ("wifi: rtlwifi: Add rtl8192du/sw.c")

Ok?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/40245564-41fe-4a5e-881f-cd517255b20a@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


