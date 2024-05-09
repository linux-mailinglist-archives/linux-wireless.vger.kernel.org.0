Return-Path: <linux-wireless+bounces-7385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542B8C0DC2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 11:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C06D1F21AE7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6014A619;
	Thu,  9 May 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE1hmBUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE213C9A1;
	Thu,  9 May 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715248104; cv=none; b=DQjkyhRMT86yR//hEWDH0UZ+Q/jz8qiHMJbm8zNs/ZKYRGhRUXjKUY2bm1Tny11pHsBTaWpwjKfTJGmGGmLGfm3RZ6TI3KZE5tDt2WCjHTKiWGVxqIwLl5kyIgvIEWYCUrSxNf685C5Ye+CreQuxhSnBr+hwd/IkmujrVi3GOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715248104; c=relaxed/simple;
	bh=x91PPA8I915qWgtXq6YkB2ihGWBsWfIw40RlhsjrtDw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZbtO9GxuRoaeM/q1CghGFJeDbjIFb5UkXP+0t4qb0K8O01iD23cS0pToWSPa1zkbTwEVzOp/v9y48Tz1gneVC81mVKdQNN0M+wmOCfuYdHKKdlmIMOE5GT1+cG3wEqmwXUmagjqWkVxNOyE1cwJD4wsZPUquUibUn3iTJbaIgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE1hmBUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA397C116B1;
	Thu,  9 May 2024 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715248103;
	bh=x91PPA8I915qWgtXq6YkB2ihGWBsWfIw40RlhsjrtDw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XE1hmBUrqwarnydIAoimo6HRIjq7uEbjauEQ7vY7pRNpZkOC4Tj5Wvz4BsYgShYCJ
	 7rIm4h6vZkQdo0+vLz24QpN+evBddfEEfgG5930kjQ9rua6sy+XAyqW8teex5koYkw
	 BkaLvAPqOxGjhohCeeMws+NiPY03G3k8wAKAzdMKhw7ZZXCxG2SmNw3iDp5I3k7xuT
	 sGAB8oZLB8klzD+K0E++/I98JH+YqE2bAg+/Z2pW2xODgyb8HvQzl+PRj5NU+LZCxN
	 fCJLvGa1q5Mh5Qoa7tUmhAqzBPO95Wzg9HGYp7FSnICgtxZoJLF1HMYIfbaD9zySWS
	 xi2eLzeBajS0g==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Breno Leitao <leitao@debian.org>,  "leit@meta.com" <leit@meta.com>,
  "open list:REALTEK WIRELESS DRIVER (rtw89)"
 <linux-wireless@vger.kernel.org>,  "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw89: Un-embed dummy device
References: <20240424182351.3936556-1-leitao@debian.org>
	<f46ae94488d1468e9a9a669320e4cfb9@realtek.com>
	<87ttjqgf2r.fsf@kernel.org> <87mspigex0.fsf@kernel.org>
	<acda4194c8d44690b05b83adccb3aa22@realtek.com>
	<Zjx/sKB++v8FJMXx@gmail.com>
	<acf2f82e7f424776835ffbc1f52ba996@realtek.com>
Date: Thu, 09 May 2024 12:48:21 +0300
In-Reply-To: <acf2f82e7f424776835ffbc1f52ba996@realtek.com> (Ping-Ke Shih's
	message of "Thu, 9 May 2024 07:59:01 +0000")
Message-ID: <87o79fl3iy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

>> Out of curiosity, why don't you rebase your tree to net-next/linux-next
>> frequently?
>
> My tree goes to wireless-next, so I think it should be always based on
> wireless-next. Once wirelss-next rebase (ff-merge) net-next, my tree will
> have them also. 

The simple answer about updating to net-next frequently: it's
complicated :)

The long answer is that the guidance from Linus is to avoid making
unnecessary merges so we fast forward wireless-next only after it's
pulled to net-next. And we can't rebase wireless-next due to downstream
trees Ping's rtw tree, besides rebasing public git trees is evil anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

