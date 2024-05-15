Return-Path: <linux-wireless+bounces-7688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E008C6728
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 15:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B01282439
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11F286130;
	Wed, 15 May 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVwYMKRd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71185C65
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715778970; cv=none; b=nUWQA7Ahk8yrRxUBNN/M97+U+pgFxIXQa0nyCr8MD78oohymUMpB3iffO+mdT7UILKt5JQx1ooavwmNMRxlfU/zy/aKo602ineEwx4wPfzQL/YX1R9IcsGiueT5nw+o/YLn61IOJ2j80zZ1XxZkzlZkIXA7b1RFXg+49dz9oTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715778970; c=relaxed/simple;
	bh=tMgzvRoRHpCsmpg/SEp+Ei2WcrmJVgJJldNO1QUfDgE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=p4Jasbqqynq1ZafSySQ06s1sZCoFHxZibPMmjP9WpK+kfug1zMTMwpuTZmiuRJFyeerbTJ+VLUtFt1DrTlqtmywM8L3dg7PtcYVCJss/ub0Nb3EEAI8SwZ4EQR2jKhGUXOC4w7f5zRpJusSiIQWW+Z/3f0Uv1RpZb0BqnyIbSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVwYMKRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E02C116B1;
	Wed, 15 May 2024 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715778969;
	bh=tMgzvRoRHpCsmpg/SEp+Ei2WcrmJVgJJldNO1QUfDgE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iVwYMKRddnexrVpSQCArFeT51vvobs9xfTsgYFB4YBNjBHDKIHHankyC3w51wTjIV
	 Dcyp3eY2Qk0LbhKw6mBLyMvAt9VLlGtkdV9qX3A5WQUoNUszW7ZNmcDdJ+rySHV7pt
	 Qpwl00JS9d4EYBJaAFOKDD6CaIj1JtjrxUCo/dwi2D+xmsqLJhzUqsVFQ151xUGj8G
	 pdOzqKuQvnN170FSzhimGQ33QufwuNgUETtPO5S1o6fbI2w3SF+GXPpaIi8C+Q3wC7
	 TTwR1NjyMJ4VTHsIlVkOElh9MYYNR0J0QDPg2O836rplnEOtBljswQXYYMRmCQtmo4
	 jHK2mOJym+QuA==
From: Kalle Valo <kvalo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  Johannes Berg
 <johannes.berg@intel.com>,  Miriam Rachel Korenblit
 <miriam.rachel.korenblit@intel.com>
Subject: Re: [PATCH 4/5] wifi: mac80211: pass parsed TPE data to drivers
References: <20240506194536.102148-7-johannes@sipsolutions.net>
	<20240506214536.2aa839969b60.I265b28209e0b29772b2f125f7f83de44a4da877b@changeid>
Date: Wed, 15 May 2024 16:16:06 +0300
In-Reply-To: <20240506214536.2aa839969b60.I265b28209e0b29772b2f125f7f83de44a4da877b@changeid>
	(Johannes Berg's message of "Mon, 6 May 2024 21:37:56 +0200")
Message-ID: <87ikzfcj1l.fsf@kernel.org>
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
> Instead of passing the full TPE elements, in all their glory
> and mixed up data formats for HE backward compatibility, parse
> them fully into the right values, and pass that to the drivers.
>
> Also introduce proper validation already in mac80211, so that
> drivers don't need to do it, and parse the EHT portions.
>
> The code now passes the values in the right order according to
> the channel used by an interface, which could also be a subset
> of the data advertised by the AP, if we couldn't connect with
> the full bandwidth (for whatever reason.)
>
> Also add kunit tests for the more complicated bits of it.
>
> Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Very nice, thanks for cleaning this up! Unfortunately I don't have right
now any means to test this but for ath11k changes:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

