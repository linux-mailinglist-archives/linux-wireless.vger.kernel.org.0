Return-Path: <linux-wireless+bounces-3278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275EB84C7A2
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC15B21FF8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Feb 2024 09:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C12E25779;
	Wed,  7 Feb 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4A7WbbJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6C25770
	for <linux-wireless@vger.kernel.org>; Wed,  7 Feb 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298540; cv=none; b=mdPEavJn46668necq4kA7MZWwcVKZFPsfsDipFCY/W9tvjJFsEcso6tDQcfeLH+w3nY9ZP8R0X1cz9rvTpjN2wyXoMJqWkIFjYvLVKdTMXbHfnojNDCCQADc48yzKZ42z5rKIH3yu/a9zOLLuxq2G0vpJrt1DJ+FcbUCpTbsfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298540; c=relaxed/simple;
	bh=IQFgUkw9zAIzZyClb+qQxTyq07YPUEUtZe15s7fDJAA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DutwmvDplbTyiL7cboQvpkNp7CjXaWgQ11qWWwQOJ1ljfFF/Jw2pqfknjPUIyhD2w3BAgClAT0gQLPIHeRBcZZoO5qTC+LGz9/mUBtskVVlo777pqQlSUyukaBNk0d+9Jr4xlM3rmw2kMthiX2Os4qGTWWkcFFID0iqJohqbFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4A7WbbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DDC433F1;
	Wed,  7 Feb 2024 09:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707298539;
	bh=IQFgUkw9zAIzZyClb+qQxTyq07YPUEUtZe15s7fDJAA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=I4A7WbbJs6AargGnVOENATikNs65NNU5GEarg1Lwam6jjuSXJc7UDx0N4scZeg1on
	 gHBMhXDWHeiI8xg/gvensa2V79yjtzAcEfpaE+Kl+oMnbIb8N7WW9s3OMM2lkrKz2i
	 tgqdKeVRV9P6iq+jGOrS0TU2HvA8JyRe8ZB2gHOHOxTTy0qj6MXyNs7ZSzzee9hW8y
	 8BgTtmsCzcA3X/SxOF81dlNywR4Nmp1BXilJVeos3E8tdKmM5wvdlS+ccpAb5UcwmY
	 SbF8vGHjIbAxZfHqILjcN2c76BDP142xZDkJJw9OoPRNYmPhzjSP0o/Y70VHGAoKTI
	 v5h9MmDn+t/JA==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Johannes
 Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 4/8] wifi: cfg80211: rename UHB to 6 GHz
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
	<20240206164849.c9cfb9400839.I153db3b951934a1d84409c17fbe1f1d1782543fa@changeid>
Date: Wed, 07 Feb 2024 11:35:37 +0200
In-Reply-To: <20240206164849.c9cfb9400839.I153db3b951934a1d84409c17fbe1f1d1782543fa@changeid>
	(Miri Korenblit's message of "Tue, 6 Feb 2024 16:54:07 +0200")
Message-ID: <87r0hohb12.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> UHB stands for "Ultra High Band", but this term doesn't really
> exist in the spec. Rename all occurrences to "6 GHz", but keep
> a few defines for userspace API compatibility.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Nice, thanks for cleaning up this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

