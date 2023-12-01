Return-Path: <linux-wireless+bounces-292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BBF800B1D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 13:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD9CB2112A
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556720B29;
	Fri,  1 Dec 2023 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmOMEFfW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE8025554;
	Fri,  1 Dec 2023 12:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7840C433C9;
	Fri,  1 Dec 2023 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701434344;
	bh=35D2snuMpVehcg+ViRKqORPYjANnyd0dWZydo9aQjGQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=NmOMEFfW6fJYpHz4HPWPs01Kdiw9UkXJlzEdrOuD5JqZaYVuO0EDaw1fynUZXiQh/
	 hbEAjKNi0Pwgm+nLj3zAYSZJIZrWxm1Q1lc/dLirL2phsLIEg6Od3fJlN8r6VLhcw7
	 BCiamNIgbUrWDteWyqzbt1IUNhkXRcS0FehssX2g1dY1Fii1ZEbdDzxJXP9LRh9WaL
	 pTAi3UTr3Cl8m8hkIG6T1vjf/JmcG5NZFl9i8z/9Vl68WTGZpsCu4ALXx4lXTwRMRy
	 zsRRLQc1mEor6+rXAaXQUBM5jrcB1YSgBjypU0YyICzR35akLHy6XBv3rTFx8A8unC
	 ZLoIlHUQd1esg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy_pad
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
References: 
 <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143434079.2072551.9169872706121192136.kvalo@kernel.org>
Date: Fri,  1 Dec 2023 12:39:02 +0000 (UTC)

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
> both dump_info->dev_human_readable and dump_info->bus_human_readable are
> intended to be NUL-terminated.
> 
> Moreover, since this seems to cross the file boundary let's NUL-pad to
> ensure no behavior change.
> 
> strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
> it.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

70582e26f5d9 wifi: iwlwifi: fw: replace deprecated strncpy with strscpy_pad

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


