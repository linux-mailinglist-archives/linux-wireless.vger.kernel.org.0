Return-Path: <linux-wireless+bounces-14066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87609A05CB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08DF1C208B7
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BBC2038A4;
	Wed, 16 Oct 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy7jxljE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD61F8199
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071672; cv=none; b=mqQsYMIX9VpZJPLgYgvHM+j04ZBwrkazb1SsOtHAT+Um1RQ1s09qH5/REET5C3rE49oEjSc3ZjyuwlwAbSfZEwCzWYmKJkUUGuUPF1RfYOmzSfXPgIuD11Lmlyaxu80KYaASGhhyLIvz4cE/b7CkyEjMkA6Iiyhaj69dO4m8cI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071672; c=relaxed/simple;
	bh=TLsTaqD/pm+PCLhsg3ChSBa9IAbdPESXVq9kKw9fz+g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=usiAa/kjM+Bd/AfM7Y4sbOII9CuF7pbGuu+vlph88Unmd0fEfV2AJHGYycaZSnjkBAxr4mvyORpqKBoLopW3l8Em1KzaLulnwwwIj5jgk+a5wVP5vq0E2SnQmTy9ZH8iqiaidia0bRKWOZR+nLmnzAocWLzviF6bF/bLveK8rU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy7jxljE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A71C4CEC5;
	Wed, 16 Oct 2024 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729071671;
	bh=TLsTaqD/pm+PCLhsg3ChSBa9IAbdPESXVq9kKw9fz+g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Qy7jxljEvacZvZIZ4yqS3R6e+JOFGMQJwwgmMVgdwdkjcEbtqkywZO/gP3V8m87hl
	 p+RIfYJRNczBTsFCYgHsdzabChSdz/6MbYqHuHVxHR6uhIhru6jv0B5E+uvV09i7Ns
	 x291y9JfPX9FP//Wu8MICYooqv9d+XBRPk4VjgR/WExp8d2BNGULvMVEJlKz8FMBV0
	 tNVphvh4H2DkSFWferIH4PRy7jiMi0y5PQk9Xyw0fTkzRxxpA+V+tEz/f389g/iTKu
	 crLt1aP9g6vCmsgFBy3VZWqeD+R865snIMF09FYg7sWDp/p2t36bGHo3egGyeeI+Fu
	 uofcBaoakaWYw==
From: Kalle Valo <kvalo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org,  johannes@sipsolutions.net
Subject: Re: [PATCH wireless] wifi: mac80211: skip non-uploaded keys in
 ieee80211_iter_keys
References: <20241006153630.87885-1-nbd@nbd.name> <87ed4h6861.fsf@kernel.org>
	<cd453040-aac3-4b0d-bdba-89881be5982c@nbd.name>
Date: Wed, 16 Oct 2024 12:41:08 +0300
In-Reply-To: <cd453040-aac3-4b0d-bdba-89881be5982c@nbd.name> (Felix Fietkau's
	message of "Tue, 15 Oct 2024 11:42:26 +0200")
Message-ID: <87ttdc4c7f.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Felix Fietkau <nbd@nbd.name> writes:

> On 15.10.24 11:13, Kalle Valo wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>> 
>>> Sync iterator conditions with ieee80211_iter_keys_rcu.
>>>
>>> Fixes: 830af02f24fb ("mac80211: allow driver to iterate keys")
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> I see this is already applied but why we need this? Please include a
>> description of the bug in the commit message. That's too late now but if
>> you provide one via email I can include it in the pull request.
>
> I needed the key iterator for not yet published mt7996 work, and while
> reading the code found the inconsistency, that (unlike the RCU
> version) it could pass keys that weren't added to the driver yet.
> I didn't see any specific driver bugs, but the mac80211 code didn't
> make sense to me during review, so I fixed it.

Ah, if this is just a theoretical fix I don't mention anything about
this in the pull request. Thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

