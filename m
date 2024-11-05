Return-Path: <linux-wireless+bounces-14917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8E9BCAC7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 11:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC769B222DF
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC41D174E;
	Tue,  5 Nov 2024 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plUhP2C3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453918DF89;
	Tue,  5 Nov 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803602; cv=none; b=YxfVsTKRjPtDi70AL6Qj+g1qyWdgoyxj46hznoXBhc/hkgEy3w6xsoJaEqzxnPq26vKw/TDiF3186zY+3PlBh15LTsDO+YAfZ1hDQU8VnAX+cHCacXI2TYT+SwqLKlnMcDLcnj1HU7ydGxySWu/RNSphYl/c5RqZQVQazBUmAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803602; c=relaxed/simple;
	bh=VdcGAmlztfS3pzAXrj9ZpjnvuwLT/ZrczgsQ13dzYRI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qfKRl8VToytBMdyjy2ROcptGnZmPquf4kTx8WxbfAK51MY26rdHO7vGNbIZFGU3yiJjKQsWa8md3Kx4zU6JVusaF/HQOna/TlKRl29ezCGLxDNMFGtvGxioCmAfmjJbCX16CJHvOGN7lTAjDMgcesu8Bij1erp7MPZXiUQGqOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plUhP2C3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8E1C4CED0;
	Tue,  5 Nov 2024 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730803601;
	bh=VdcGAmlztfS3pzAXrj9ZpjnvuwLT/ZrczgsQ13dzYRI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=plUhP2C3q5UJFvR7SkoJu0skGSKd3Zydrusbb4zLzR+s4Rf8ogXEU9j49UIMaeqAT
	 E6/63KVyAaUfXUnDLAM2xfTyhdB26M18/lm4UFbtZahe//vqJzE9mL2xCYJ8GAP5Dg
	 gn4AV/2elGkC+4ApsIZfZBqApkDCSQLpeh/21eq2LgPp2osoAh+g8XL7hfHMA0VWY9
	 2UjJrvwguhT4/QsKvOmnSKOKrzelhb/JqkOJn4pVk1EM6aFtLbwKf6k5jdgiTULfM2
	 egGuBN8evTv0xyIFhIYALu+zN4iA0Jlcsu89UJ/EGa0JavoI61bW2UUBiZoHxM0apB
	 a8GVm2IjwY0Zw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Aleksei Vetrov <vvvvvv@google.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Kees Cook <kees@kernel.org>,  "Gustavo A. R.
 Silva" <gustavoars@kernel.org>,  Dmitry Antipov <dmantipov@yandex.ru>,
  <linux-wireless@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-hardening@vger.kernel.org>,  <stable@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
	<0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>
Date: Tue, 05 Nov 2024 12:46:37 +0200
In-Reply-To: <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com> (Jeff
	Johnson's message of "Mon, 4 Nov 2024 09:12:09 -0800")
Message-ID: <87ses6x8j6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 10/29/2024 6:22 AM, Aleksei Vetrov wrote:
>> The channels array in the cfg80211_scan_request has a __counted_by
>> attribute attached to it, which points to the n_channels variable. This
>> attribute is used in bounds checking, and if it is not set before the
>> array is filled, then the bounds sanitizer will issue a warning or a
>> kernel panic if CONFIG_UBSAN_TRAP is set.
>> 
>> This patch sets the size of allocated memory as the initial value for
>> n_channels. It is updated with the actual number of added elements after
>> the array is filled.
>> 
>> Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Aleksei Vetrov <vvvvvv@google.com>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> And it is exactly this kind of issue why I'm not accepting any __counted_by()
> changes in ath.git without actually testing the code that is modified.

That's a good rule. If we ever manage to write that "wireless cleanup
policy" document this is something we should add there.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

