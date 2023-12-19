Return-Path: <linux-wireless+bounces-1016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99675818FBE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926D41C2526A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03637D35;
	Tue, 19 Dec 2023 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHAmqfcs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922A537D2F
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 18:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46964C433C8;
	Tue, 19 Dec 2023 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703010268;
	bh=jRAZdnaaVTi2KgSnKBcf8uT0X3s4ufbNWJviPiLm2Mk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jHAmqfcsGm8ICBikWzyPbOY/YwSf1XEni0rNq9zjkvjN2cwVoLgOyr68ReLYHrcg1
	 blI51LGsqjY3DhE16X2QAUOFDwz83ckn/gG/jec58M+w+//7bd5LysOb0Y9vSQ9pSd
	 7bwHbItmkZ2T+Zz/hD4WcIX5pDQA51LvBOjjoYCssIlGG3j0gyJ83Z/AOy7Rzk+hz0
	 XDJ7QZtA/vcZY6Be5zxiFl/YayBbpihgNyM1eJmrQstwJFU3iZMgtp18iuSAGq9YEi
	 pMvs+X1EyT27MSXRyuakJvDownClPjM1KCH0D2tP86CmlhXeswGqFqJjqeBnLL/nKc
	 yBbEKDHUNqaZw==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>,  ath11k@lists.infradead.org
Subject: Re: Ath11k warnings, and eventual phy going away requiring reboot
References: <ab00ff77-23de-43a1-9eb9-6ac036ab80e3@gmail.com>
Date: Tue, 19 Dec 2023 20:24:25 +0200
In-Reply-To: <ab00ff77-23de-43a1-9eb9-6ac036ab80e3@gmail.com> (James
	Prestwood's message of "Tue, 19 Dec 2023 05:51:24 -0800")
Message-ID: <87edfiqcdi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Prestwood <prestwoj@gmail.com> writes:

> I noticed this after one of our devices dropped offline. The device
> had roamed 7 minutes prior so I doubt that had anything to do with it.
> But then we get this, and then tons of warnings. I'm happy to provide
> full stack traces but its quite a few, not sure which ones are
> relevant or not. After all the warnings IWD got an RTNL del link event
> and was unable to recover from that. It seems after that ath11k tried
> to power back on but failed.
>
> This is a stock 6.2 ubuntu kernel, WCN6855:

BTW I don't know how it's nowadays, but back in the day Ubuntu heavily
modified ath11k. And we can't support distro kernels anyway as we don't
know what they have changed in the kernel.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

