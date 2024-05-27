Return-Path: <linux-wireless+bounces-8078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCBB8CFC35
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 10:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813911C21F45
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146B6BFC0;
	Mon, 27 May 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNe7apop"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F46BFB8
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799871; cv=none; b=WyWPXgYKeJ3o/O18jJPQi6Xzmuv3I4R6CPwB2yxgRW7N44Tj7N04EFzIKF/xvS3tWXTR2U51DgnC33B0s51LeTdVVxNxkNC/jJkJC4q8TrqtYIexYilCnV8VgoJpGQu56n46ulbapqUkzqYYBVYsQKKVwyvF/vWjXl0UGrDUHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799871; c=relaxed/simple;
	bh=5EgZLX9WWhrclezvZPe1WELEMHvRlBP3DoZwmo0GzB8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FObkxccPWKHjbjno7QS7xOfMDm5WCyJigfyzdqKFrc3Z3uGzOsYBD0tyx4yqa08kYQGD9rZzdszTYJJp4pqGSv3MvWYir6hk/AmBgXz3EuY+oDKIjLhZkd6+UmbarXlCG8I2+R7hSSPkT5DtccSwXvR3OQHcU3aA1jdEo/4LB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNe7apop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D7C32789;
	Mon, 27 May 2024 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716799870;
	bh=5EgZLX9WWhrclezvZPe1WELEMHvRlBP3DoZwmo0GzB8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RNe7apopcTaSKGidNF40778z8EqwBRy6kjKCIT/4uzXBC82ihLzfvWl6YaPaM+lcj
	 jFu8sKfO9Nj3+QZEMwAeX/X4BfQdIeUIh4R8RKTQ3fuqeR4qF9O+Rz6ZBZ3E3ybsMj
	 hRm32xu2FwWs7FFU372jM6SVDaBIeSVrSDS7sRQoe6RaCPjJl0Q1CHOG5UF9iaRzpY
	 U5kuLwMc8esbg7aEbm7OtsRMDlYs+1+69xwhuHIvmCrHsmMBHZ5e2FmfhPjgXfvjQU
	 f6VeW9kXtQ6fbAqMFVZ1xHgCV262wnOuOBgdrq3/duUqLpEGnegPLHtC+BNZTThtlN
	 YC7olNx4F/rpQ==
From: Kalle Valo <kvalo@kernel.org>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: mac80211: fix NULL dereference at band check in
 starting tx ba session
References: <20240523082200.15544-1-kevin_yang@realtek.com>
	<874jamnrb8.fsf@kernel.org>
	<b642c931a087475bb2fc021582e3269f@realtek.com>
Date: Mon, 27 May 2024 11:51:08 +0300
In-Reply-To: <b642c931a087475bb2fc021582e3269f@realtek.com> (Zong-Zhe Yang's
	message of "Mon, 27 May 2024 06:46:38 +0000")
Message-ID: <87zfsb8woz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zong-Zhe Yang <kevin_yang@realtek.com> writes:

> Kalle Valo <kvalo@kernel.org> wrote:
>> 
>> <kevin_yang@realtek.com> writes:
>> 
>> > From: Zong-Zhe Yang <kevin_yang@realtek.com>
>> >
>> > [...]
>> >
>> > Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
>> 
>> Kevin's s-o-b missing.
>> 
>
> Sorry, I didn't configure sendemail.from properly.
> (I will double-check my configuration before sending patch next time.)
> But, my s-o-b has been there.

Yeah, I got confused. Sorry for the noise.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

