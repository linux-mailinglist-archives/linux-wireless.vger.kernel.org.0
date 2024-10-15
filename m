Return-Path: <linux-wireless+bounces-13955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91B99E292
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476FC1F21F26
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 09:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911E1DD879;
	Tue, 15 Oct 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3+wvof/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7D1CF2B2
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983593; cv=none; b=UGjT6mbi6vuzGXr7/EONReKFjIxTBd2fsnOEyZ/k7gZbksR2P1S5vJ0ys5rybKHYeBrrB20VJBZJLkhg+60w7tCuHmkT+m7bR0Ve28YEYpooVSJ6QedYaOLNUEJlmabGUbLgkmBXzqd/6QjMXadInDmw90yK2duRSU1xBll/kAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983593; c=relaxed/simple;
	bh=jqQ1nz0krq6XUEqspWi/B9TsA4bhDkGLd3MWQabRryQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=TfbBSV4g5hWJeOb+DIejHRuOmSqighIBsgBZ+BjeBCKn7iiQafsLdT9qwYrnZElUaX3b86PBfWO7ssQiyeiyVFMmE6nb2t5haFlTS/aiZeVLk6Ku8bgR3h0TgIt2xiuTANUUqQbMg7BxAO6EOCgzwUM+U8sLlNMAKoNM6Y68RxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3+wvof/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F9BC4CEC7;
	Tue, 15 Oct 2024 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728983593;
	bh=jqQ1nz0krq6XUEqspWi/B9TsA4bhDkGLd3MWQabRryQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=T3+wvof/HiVgWsRvrKu/EstnWFh0ksjavbAsisFFgCsA+QfjxeB3pY2xsUyFf6j4+
	 N1hyKpJYOFqoxlMVeq7nd8UI5dJr1lVUFWNcy88l9AK/h3tXRMXZIhfF2vCTtZ7fka
	 iw3hk6QN156MerluJrjGFLWuEO83z2BF7Ki8vyK1WBw0UqXuqgqmYeaLwKHJbOi3wk
	 dTdtArGUFfV2ZjR62t+26ANgTBra1THg2RdrH7KJ9+i7NhFOFgOI2Qqocr5LBM17ce
	 kjqfU9s/7lcBR4W0ka4AoPY8Xx6/LEjZn1aTSuIyAFkLq29dsTqVp902ZlbV2Kca4P
	 QK2WQjqd/TDiQ==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org,  johannes@sipsolutions.net
Subject: Re: [PATCH wireless] wifi: mac80211: skip non-uploaded keys in
 ieee80211_iter_keys
References: <20241006153630.87885-1-nbd@nbd.name>
Date: Tue, 15 Oct 2024 12:13:10 +0300
In-Reply-To: <20241006153630.87885-1-nbd@nbd.name> (Felix Fietkau's message of
	"Sun, 6 Oct 2024 17:36:30 +0200")
Message-ID: <87ed4h6861.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Felix Fietkau <nbd@nbd.name> writes:

> Sync iterator conditions with ieee80211_iter_keys_rcu.
>
> Fixes: 830af02f24fb ("mac80211: allow driver to iterate keys")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

I see this is already applied but why we need this? Please include a
description of the bug in the commit message. That's too late now but if
you provide one via email I can include it in the pull request.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

