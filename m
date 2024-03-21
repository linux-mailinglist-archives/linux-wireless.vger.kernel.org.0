Return-Path: <linux-wireless+bounces-5081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30D9881C6E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 07:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474E7282B91
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 06:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DD03984D;
	Thu, 21 Mar 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwRscf19"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31F17F7
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001943; cv=none; b=YPjTfB4LNxgjD+MsOJDSSAjIhdlyMx/cn9SljJKQQHu2ifkVfViuSPUhsDwrJ8wPFjTgMGwocl/Z911s+MHoE8CA/wf+bJ9O3Z1kR9IOrp4algeAvGTkb/FoIW84KBjj6j9+/06MSslGM+Y+MebRcevHLyGyUTM4wO6ceagzL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001943; c=relaxed/simple;
	bh=5dGzTVUcGNYKLimkoBkJ4HyafL20dyFrQnfQHlqKomM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=OjR6rVqlK8jIR+Kz3ajHpbTapsB6JH5fNpmwByru3Hf6wQYmDIM9uZLWB846MFZOKG5iGj/KPm1JaJx7hgdsfY47jT+bSi8Gpv6eJGhmMsMa8jSnBd3BmLjbOsA7pzKGKMZaO6W+l04Wm5/8xaW3/h1mGCPXD//jl2w+392ffmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwRscf19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A56C433C7;
	Thu, 21 Mar 2024 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711001942;
	bh=5dGzTVUcGNYKLimkoBkJ4HyafL20dyFrQnfQHlqKomM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hwRscf19EE3iI19oTAIETD5fkhOZxrM4d8BsqMOWF4MDsnKd4Nw5qYkp0uD2l9zkg
	 BCNZdfYmvy0IOhTYORUaoDJbMCghc9kDFjXgZAS93mzSy85yvFS//3WS3nNUnxOcx2
	 gsgp75qrfPpmd+ns6g0kmpmUaTSnBrnaQCcHLseWG9B2jBqhkU0PkOCEJOctJuSYyC
	 K25ecFeBTtxKX14u472PLh8ClCEYNNsCeYwRo0DUogfNoi/H69G/lEzlqCFFnU7XfV
	 K+f9jWqyC11c9SXS4uZo+gHoqlGB7ovP60p3E+wbbyVWZGarBwfyYdWqq9JLAZICGg
	 oqBqJZbUk5r9A==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  "Leo.Li" <leo.li@realtek.com>
Subject: Re: [PATCH] wifi: rtw89: disable txptctrl IMR to avoid flase alarm
References: <20240321025603.20614-1-pkshih@realtek.com>
	<878r2c2mob.fsf@kernel.org>
	<2eefd73994778c1fa1dc03acf04708d686ec3185.camel@realtek.com>
	<87jzlw9l8y.fsf@kernel.org>
	<01c674f6f1442494bc7ec9778bd650aa63e6ad95.camel@realtek.com>
Date: Thu, 21 Mar 2024 08:18:59 +0200
In-Reply-To: <01c674f6f1442494bc7ec9778bd650aa63e6ad95.camel@realtek.com>
	(Ping-Ke Shih's message of "Thu, 21 Mar 2024 06:06:59 +0000")
Message-ID: <87frwk9kfg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> On Thu, 2024-03-21 at 08:01 +0200, Kalle Valo wrote:
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > Should I change to wireless mailing list as To field and no need to
>> > add you in neither To field nor Cc field in the future?
>> 
>> Yes, please drop me from To and Cc fields. And if there's an important
>> fix you want to go to wireless tree please label it as "[PATCH
>> wireless]" (or comment on the patch) and assign to me on patchwork.
>
> Got it. But, still add you to To-field for pull-request, right?

Actually no need even for that. I take all patches and pull requests
from patchwork anyway :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

