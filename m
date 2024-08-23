Return-Path: <linux-wireless+bounces-11824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8F95C50D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 07:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158FE1F25463
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52254720;
	Fri, 23 Aug 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugVotz1p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47D5464B;
	Fri, 23 Aug 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392575; cv=none; b=IlaMYb1jUnaTkZo6rlGGgHAVfJJOfaex+6RVoS3ESVxhhjW4gib+MglBf/x/aWMBlObfocwnuxYWAlEPKnkiVwiCSn3EcmgRj7si1clSs/XMp/J5W1iGgDe3f0Np8nwulYWUk5kUoP8bOqCm+QLggVEQQm3GBjbHJHiPl1UgkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392575; c=relaxed/simple;
	bh=5LiBOirHa4/3WcTTbqSgaXl3F8Z0uPmHwxXkUB6akuE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aAHz0Lpc5nZhMC30rJRK/UVoHW3b5semgR3euHgC9ap+ouQFyyHOZ23HkE8YxDxEKs+iOoYMmrUTIEa/G67hw7jBVlF5hvPqbbhEQ1wSWXjWp5VbCtzT7odU964woUxdQKHjqSWHTiDYE/XWxZRZRYCEUj1V59xdV8orJU9EvUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugVotz1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491B6C32786;
	Fri, 23 Aug 2024 05:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724392575;
	bh=5LiBOirHa4/3WcTTbqSgaXl3F8Z0uPmHwxXkUB6akuE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ugVotz1pO0bTIKXbwo3pZOknV+SfLRU1t3YBPX52rov6OiME9yG+BKscP4MaWLUxL
	 hC/4WMOmDJaS+o6hBOReRuop3Uc+9PSnjmL1Q62TL0VizLRUySeyWcXwJV+3cBUy+F
	 y40uuq8Nhp5WgC8E1tTijL6OCQr4MEz41zNP8PPFozln+WlKv7OCw3PGJ5zKKmcg4a
	 b3pNilqqGGGWSrblgScI4mroPY/msXVhR/UwRUe3GzYWRTaPFmnm5stjV0sDJ4pIdV
	 KSq2n76HOTs+AWvVtzMRXBRGV8ZY/C9EzIzRwjtgWpn+7/x0EqlsxTE5K1pRiWj7Kb
	 RgyqtytnueDtg==
From: Kalle Valo <kvalo@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: dan.carpenter@linaro.org,  benjamin.berg@intel.com,
  daniel.gabay@intel.com,  gregory.greenman@intel.com,
  johannes.berg@intel.com,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  miriam.rachel.korenblit@intel.com
Subject: Re: [PATCH RESEND] wifi: iwlwifi: mvm: fix an error code in
 iwl_mvm_alloc_sta_after_restart()
References: <575625da-60bc-4444-a5f3-a7acf925f1e5@suswa.mountain>
	<20240823030423.1781977-1-make24@iscas.ac.cn>
Date: Fri, 23 Aug 2024 08:56:11 +0300
In-Reply-To: <20240823030423.1781977-1-make24@iscas.ac.cn> (Ma Ke's message of
	"Fri, 23 Aug 2024 11:04:23 +0800")
Message-ID: <87wmk7vl38.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ma Ke <make24@iscas.ac.cn> writes:

> Dan Carpenter<dan.carpenter@linaro.org> wrote:.
>> The Subject says RESEND but doesn't explain why you are resending..
>> You probably meant v2, but again it needs an explanation..
>> .
>> On Fri, Aug 02, 2024 at 12:27:40PM +0800, Ma Ke wrote:.
>> > This error path should return -EINVAL instead of success..
>> .
>> Why do you feel that way?  Have you tested it?  What is the user visible.
>> effect of this bug?.
>> .
>> I slightly feel hypocritical because I have send lots of commit messages.
>> with exactly this commit message.  The difference is that I only send.
>> really easy patches where it's obvious what the intent was.  A normal.
>> kernel developer wouldn't need to leave their email client or view any.
>> outside information to see that my patch is correct.  If a patch is not.
>> dead easy, I normally just report it.  (Sometimes I report dead easy.
>> bugs as well because I am lazy and maybe it's the end of my work day.
>> or whatever)..
>> .
>> This patch on the other hand is more subtle and it's not clear why the.
>> continue statements changed into returns..
>> .
>> regards,.
>> dan carpenter.
> Thank you for your response to the vulnerability I submitted. Yes, we .
> believe there is a similar issue. As described in [1], it gets pointers .
> which are handled under the protection mechanism. If the path is error, it .
> should return -EINVAL directly instead of success.

The commit message should explain _why_ it should return an error.
Currently there's no explanation neither in the commit message or in
your email.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html

