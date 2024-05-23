Return-Path: <linux-wireless+bounces-7985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF78CCCC5
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 09:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90801C20C0A
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7C113C9C4;
	Thu, 23 May 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l63V8xgk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238613C9BE;
	Thu, 23 May 2024 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448134; cv=none; b=YK2jwV045KlG/wMNdB2H9I7szHsengGnLSoiF184YnNKtH1fONKK/ImQgcQMau4xZrrNScH8li8HQO/RsvSaIW65WwpKI2xwKu6Z44TIs627jPaB4zpEo5pBel5vfRVdwhATSMLAHh33a813YNKfHNjWzW4BYd0k21H9Mx3RKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448134; c=relaxed/simple;
	bh=elwm805QhpZ+JSQ57a0ibr5IqKEmbzKJWPEUZdsebmw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dK/zOTtfqIItIVOoziYH/CGqvXkppJfF0j6Zos4aKV+7eZ+XoI1UVSBGT7yyIM8++JhqEZ8ioUjC5zf6RBsnIaBUc1dGM8Y/VDqNf2Ns6+nn3UILF+hc/181y0/bJJtHCPorNj7fsnzbi4kTzOFVFaHyDCuSiMy1d51RQFSy1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l63V8xgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410BBC2BD10;
	Thu, 23 May 2024 07:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716448134;
	bh=elwm805QhpZ+JSQ57a0ibr5IqKEmbzKJWPEUZdsebmw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=l63V8xgkLsin9j/UsHEcUmVjXnzjfiGdErSNS+oVeeGFrpFugjuh4UK37h6Yjhlxj
	 czy4pMnIc5RnMYPB8rnUWVCWz2JX+rz4intjIUALmpK+Yvpu/so8YbEsj5ZUeXjeAS
	 qLJGbkxNKx/5U1LTfOE5f0HkFBiXKJJfRTTWsD2DtrqJ6kh76BD01V1c8taxtSRy/f
	 4aVWLboQd530xEOtCGW3J8tnW5+MCR+hX1xuvQwkSXDqFmNGF6M1AndjXKhMiPFfcA
	 mfMarDezHDRT7DMqueb1K9eH6I8OXkqcDStKYF7qsCAx02JHxHERSP+z+9oRXFwGm0
	 jPe0MsPjYGyPw==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: michael.nemanov@ti.com,  Johannes Berg <johannes.berg@intel.com>,  Breno
 Leitao <leitao@debian.org>,  Justin Stitt <justinstitt@google.com>,  Kees
 Cook <keescook@chromium.org>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 13/17] Add conf.h
References: <20240521171841.884576-1-michael.nemanov@ti.com>
	<20240521171841.884576-14-michael.nemanov@ti.com>
	<9ba9d156-ce38-47ba-b0fb-63e6174c3094@kernel.org>
Date: Thu, 23 May 2024 10:08:50 +0300
In-Reply-To: <9ba9d156-ce38-47ba-b0fb-63e6174c3094@kernel.org> (Krzysztof
	Kozlowski's message of "Wed, 22 May 2024 11:48:20 +0200")
Message-ID: <87r0dtattp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 21/05/2024 19:18, michael.nemanov@ti.com wrote:
>> From: Michael Nemanov <Michael.Nemanov@ti.com>
>> 
>> Various HW / FW / Driver controls unique for the CC33xx that
>> can be set by OEMs.
>> 
>> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
>> ---
>>  drivers/net/wireless/ti/cc33xx/conf.h | 1246 +++++++++++++++++++++++++
>
> So you are adding one file by another? This does not help review.
>
> Add logical chunks, e.g. users of header after the header. Or all
> headers together. Or some features incrementally, like basic working
> driver and then feature foo and bar.

For new wireless drivers my recommendation has been to submit for review
one file per patch but the final driver to be commited would be just one
patch:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

