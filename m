Return-Path: <linux-wireless+bounces-7686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05048C66E8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 15:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754CE1F22935
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2541514AB4;
	Wed, 15 May 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7QMTgKh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011515684
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778689; cv=none; b=lK6OriHiFrOsZvRbpJorI5kk3JcYUcqn3rrZp4UYr6xtU4+HG2XxlyfHZRSlMaKHjdeokyYyuk0XS9cgcFSE3PB7iGfzVJDXsN0AOhHNM+nEjGObZGyG9v7qxC4L+o5w9OjGL1V71L3Wjn0Jt9PE+gJ3zCqi4xy0wPMRaeM2n1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778689; c=relaxed/simple;
	bh=6tFIF8gLUCzkMqbWQK7T2OC2FdXTrN4SIi5Pvie0B+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LfUkNkRKpohN0nnchzzP5W3OyjODUYCUrf3kaM1PQiWRnChhz6mAQ/Qm4TnRBw+YOlaiClhibqZRb+EDTFN1pXexjAFEAhik2EvYVCkE2nysZmqidjMSXLrDrw1LIoStCV3bIz2jwRBs2Kr5qQzGOAhzVQikyJ5kGX1q9lUiMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7QMTgKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA95C32782;
	Wed, 15 May 2024 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715778688;
	bh=6tFIF8gLUCzkMqbWQK7T2OC2FdXTrN4SIi5Pvie0B+o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=d7QMTgKhmZj5a1cZ9MODURcIsXFLYiWIBRFp8skvBLTzX7BCqVmL44GcFc7ek0hsR
	 ujCycTLZReco0ZDi/f8CRoLvjyf/oYshmktbTeFjmp2wO6l0QI48f6WhRmgbRrx1zL
	 YwzJ8e1k3XciIcWAD4e0fJvpj5Q3XnbtOPCyfHoU8QzFzLnaY/O5lfJ++KVyd5Jwtq
	 f6yfFNgtt3FzX+qGJ2+jaylHoxK5zFFAA5CfzdNObR0nPn++RAxqKFGgtLS8IiS/Gt
	 hLCHTvmHw7ljTsd0Jd5+L0xt8qWU+VePchWq+ZDRXj5HYdcC++5MRaN/MeBk5UI+cg
	 WWq0QY1mYv++g==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 2/5] wifi: ieee80211/ath11k: remove
 IEEE80211_MAX_NUM_PWR_LEVEL
References: <20240506194536.102148-7-johannes@sipsolutions.net>
	<20240506214536.9818e5471055.Icece7e47e963d6b68e0d97ba13c102b37fbaa689@changeid>
Date: Wed, 15 May 2024 16:11:26 +0300
In-Reply-To: <20240506214536.9818e5471055.Icece7e47e963d6b68e0d97ba13c102b37fbaa689@changeid>
	(Johannes Berg's message of "Mon, 6 May 2024 21:37:54 +0200")
Message-ID: <87r0e3cj9d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> The define IEEE80211_MAX_NUM_PWR_LEVEL doesn't make much
> sense. Yes, that table has a maximum value of 8, and the
> table will actually remain that way, but EHT introduced
> a way to encode more levels for 320 MHz channels.
>
> Remove IEEE80211_MAX_NUM_PWR_LEVEL and, for ath11k being
> the only user, add ATH11K_NUM_PWR_LEVELS, where it makes
> sense since it cannot support 320 MHz channels.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

