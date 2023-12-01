Return-Path: <linux-wireless+bounces-291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACCE800AD9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 13:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FA32815B6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8524B58;
	Fri,  1 Dec 2023 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM8B1w5k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BB21A13;
	Fri,  1 Dec 2023 12:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463ABC433C8;
	Fri,  1 Dec 2023 12:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701433638;
	bh=VLf9TWayJPl8TT4+DSau+I8bCfyYcFQKiuZmn9PQq5M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=CM8B1w5kfjRuNR50iBGF18msF6xVUXENaYt9iSsjPuYmbCGOhHR6lVYoGV/eLiEIA
	 fFqGE0jRrEImgYMm4Oq6pK6iCvVYadEEPHUNEzakNGKb/RRdfEl5MDZ/WqL4er8lEW
	 u+SBIZLvmEDq1+p1oYDDeQ1gH4AIbFFfKO4064c13kXghVFvJ1qPckwhUwTxxKRig8
	 D+MMfSi6MTm2grtTtxWZbWEeOjWzx43ZSAU54z1iEyWyYFDDCUYIJ8Ts3XVferFZZC
	 Zk0J39sxjiGIltm1e8SiQLT2V0CO6Z3mtp1jln1NCIpOXzDm3B9k89C1ComQ3LOHD6
	 mWqCRaqXMbqKQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Justin Stitt <justinstitt@google.com>,  Gregory Greenman
 <gregory.greenman@intel.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iwlwifi: fw: replace deprecated strncpy with
 strscpy_pad
References: <20231019-strncpy-drivers-net-wireless-intel-iwlwifi-fw-dbg-c-v2-1-179b211a374b@google.com>
	<202311301354.0DAC97C@keescook>
Date: Fri, 01 Dec 2023 14:27:15 +0200
In-Reply-To: <202311301354.0DAC97C@keescook> (Kees Cook's message of "Thu, 30
	Nov 2023 13:55:04 -0800")
Message-ID: <874jh2rtuk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kees Cook <keescook@chromium.org> writes:

> On Thu, Oct 19, 2023 at 05:44:59PM +0000, Justin Stitt wrote:
>> strncpy() is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>> 
>> Based on the deliberate `sizeof(dest) ... - 1` pattern we can see that
>> both dump_info->dev_human_readable and dump_info->bus_human_readable are
>> intended to be NUL-terminated.
>> 
>> Moreover, since this seems to cross the file boundary let's NUL-pad to
>> ensure no behavior change.
>> 
>> strscpy_pad() covers both the NUL-termination and NUL-padding, let's use
>> it.
>> 
>> Link:
>> https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
>> [1]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thread ping. Can the wireless folks please pick this up?

Yeah, I'll take this directly to wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

