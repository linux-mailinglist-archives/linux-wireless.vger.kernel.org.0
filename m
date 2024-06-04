Return-Path: <linux-wireless+bounces-8474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334D08FAD38
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 10:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E392228424A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 08:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC461411F6;
	Tue,  4 Jun 2024 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ17OP03"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC23446CF;
	Tue,  4 Jun 2024 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488832; cv=none; b=ljO5h7Ls9PUmovLkK1s1gpRtsgv6AyWUEAHACTm6sBWLQ/VSg+Dh10fH/1aPdG9ok6PCY9sKRfHFoQWeTr0o0c8D5AOSKqbmsn206biVUsE3Ra/rQRnEHbqKzU4rT1T0W/av9GUp2DiMPSdGk8K5eYQ5dFmQao9NCDLMEJ+jQPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488832; c=relaxed/simple;
	bh=56WLi8CXo1AcrdLwJh+EBDJTq1lXFHmxgYbS9a/UTg0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=U/6vlby5FAxSnH8Y4dwjDmxMy5NvSouF55xdvBaJaeRtNU0O8Vf97wsWK9ZJRzFUPDFkISuNs7W1lngJe3vBUXPYFELgkSIqMzfMZOPIjpVb9LNp1x4KcURz4pIWq4/vYYvIN1sSJxJsni79qsivFLDL3bcTZHMBhqodguH2PWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ17OP03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13D7C2BBFC;
	Tue,  4 Jun 2024 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717488832;
	bh=56WLi8CXo1AcrdLwJh+EBDJTq1lXFHmxgYbS9a/UTg0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=cQ17OP03lb6oYLzf2d773K2wukeyoY8gV8t5ZG4CXOzi/Og1nGwYzOz5cW1VdIPKs
	 GfXmUvphwJe73lWW40vZMMzVv+ka+zLsxNZLf/cGEF47Isd0SWmnzEFdLUnL88GvaC
	 hMI1cHETWj0/LjNdd4kxEJo+/HrDHMj/1ErtCyyntP5LexIo/7KV9+2aolkrHbmSVz
	 eT83yXofsMIjTwXaZpc5xXabFs6vzRVxgptsJjuYUC5qN4QOnA7YaXTCvrNx5/59bs
	 iXyBWof5FUAKJK08lvLJdrlRljtvDbYrEiwRMwg24uwcrCUFXSrdLSt6Dob+w6kaoS
	 VZjwjwf2K8+TQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/6] wifi: rtw89: use 'time_left' variable with
 wait_for_completion_timeout()
References: <20240603091541.8367-1-wsa+renesas@sang-engineering.com>
	<20240603091541.8367-6-wsa+renesas@sang-engineering.com>
	<1fca9d83960442b0b637d4e9586766bf@realtek.com>
Date: Tue, 04 Jun 2024 11:13:49 +0300
In-Reply-To: <1fca9d83960442b0b637d4e9586766bf@realtek.com> (Ping-Ke Shih's
	message of "Tue, 4 Jun 2024 00:35:27 +0000")
Message-ID: <878qzlt9aa.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
>> There is a confusing pattern in the kernel to use a variable named 'timeout' to
>> store the result of wait_for_completion_timeout() causing patterns like:
>> 
>>         timeout = wait_for_completion_timeout(...)
>>         if (!timeout) return -ETIMEDOUT;
>> 
>> with all kinds of permutations. Use 'time_left' as a variable to make the code
>> self explaining.
>> 
>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

BTW Ping, you can also take it directly to your tree if you want. But if you
want me to take the patch, then please assign it to me on patchwork (ie.
change 'Delegate to' to 'kvalo'). My preference is to take it to your
tree, smaller risk of concflicts that way, but up to you.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

