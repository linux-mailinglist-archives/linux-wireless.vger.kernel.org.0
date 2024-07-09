Return-Path: <linux-wireless+bounces-10120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31B592B4FF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 12:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A8E1C22B47
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78483156653;
	Tue,  9 Jul 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni1ETDuU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B8415664C
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520268; cv=none; b=bGIr8rNZriN3iUzN6udf6zKnph676zd++ExX6tVOYQtHlqlepRvD/wItwbHrMIjzRr06lLK7RKP096ILOGq+b4CshMI7O5zsy1iVOGROM6lu3pCu9c/hi02qMiIV9z4tzlbtC0U0NEASlOM9d+3HVWGWByiKCnz8MHDpAIzqask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520268; c=relaxed/simple;
	bh=S1qCr9W3n2YEgeAuT5UEdbu1n6no2eE7akrTtIhTAnA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aRl1YzcQ4idol/+E7fVeLWvSRlG5bjq77t135W1ip48G/c9wC5pmcGtpNL07Ay8XnyYf1Tymtrd4xpYGJHTgHAHEl+tslhS1iYbCLnW7iVO/mfxpJ0NvTNgDJgKXAPV51on6qohbdYo47tEZ8emW4rRLFmSdBkAlI+6Vb+sc1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni1ETDuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BAEC3277B;
	Tue,  9 Jul 2024 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720520268;
	bh=S1qCr9W3n2YEgeAuT5UEdbu1n6no2eE7akrTtIhTAnA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ni1ETDuU23ROIDxv3fWxSPcUQMB55DCdFgN+6Xoj9OMwY/rikX8P0fviNae4xKS2C
	 PqpTE9TjQ8OS3UHhz/y3le1Xdu3rRaeaVFQLzZcOuxigUYPJvIWbtYrEkeKd8mJB+O
	 MrxJyAVyLfkyMPt0GIvmih3VudOHf8iU7EV9KgaxQ3vHFDZEHculc4QtMKdT95+zcp
	 cktnjBGLNs0j65/vW82ZzFFS3OjlBrvSsimaHHctGbeFB3WgE6yB+s1JkaYPtmhj74
	 3aaycwfuXEhbua7bUvzpisI512a6h1SxQcMqHICfZzmYJ8dxJ1YKx+t5/3oalBQMCy
	 HyQFEtsuThPbg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-07-05
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <9cc1069b-98a2-4404-bdaa-8a1924b1be03@RTEXMBS04.realtek.com.tw>
References: <9cc1069b-98a2-4404-bdaa-8a1924b1be03@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172052026568.761847.8431617046492048412.kvalo@kernel.org>
Date: Tue,  9 Jul 2024 10:17:47 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

0321e45737b8 Merge tag 'rtw-next-2024-07-05' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/9cc1069b-98a2-4404-bdaa-8a1924b1be03@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


