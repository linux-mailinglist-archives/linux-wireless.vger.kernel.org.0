Return-Path: <linux-wireless+bounces-3148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03AD84A1EA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26C11C21B46
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E0E481AB;
	Mon,  5 Feb 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxXXyx8e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9B481AA
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157007; cv=none; b=R0764R936i9F9qwDhw1MZnOab4HXf10Bb3lbPtFvFVNPLznfTIdynXqTojV7XzLGcE834lqWiBQuqHqCUdK8l9FZXUhSaZCXxmOXbj5QCflm8uNaj3GH1gIB6rwJ24EH+3CLHU7WL6w4tPET3QJo6sXwZF8EODC0Tu+H8iUzl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157007; c=relaxed/simple;
	bh=1u4ZhHMAUi/E2eBh4HnDdhCY/9dqGmWDchTf2ZYFiDI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=eD+OMGVu66w+apfAP5t+KWY5i+wjVhgh/86f8pzJcw+y9k+HsWyOdwnD7DDsv1W+PbHRjyd4zql70MqQrO2iCsOOp72XdgajWyuUgW7F4G1UjHY2GefhmzvZj+outb2pF4U/BRtfgHgCkpIIF+XS5/GpHqJFwRpa+tsP4qzfYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxXXyx8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46D8C433C7;
	Mon,  5 Feb 2024 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707157007;
	bh=1u4ZhHMAUi/E2eBh4HnDdhCY/9dqGmWDchTf2ZYFiDI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UxXXyx8eqCpWFuFHZRw2rWxoLnehOjw3fkPCSDUxiYMNqXZm4GrqzF0eddc3TjBmu
	 dDqyVLWPsulPByWLsF97qCcc8dXca46al7yzlohka+jCAGkwYzXG8JWhOAgmIuBhfi
	 4zlT7MR4UdWtbOXxu0iBP01RBjw4OjVWeGUAdeecdqbRSrdB53DU545zAQs2ThFZSv
	 fSuOd9XvDHVYFqeC+0g/KzIoZnB9KAyVDvh7Sulgnm2u9o5p1a60lp0OUSty8CQ3gt
	 wlLEpvM+i5G7oQeHyO0BlVcI8S7OXzEG4Ye7bn+VwPKsay0vvq2fMlA79HuEH8TuhX
	 Unt76quEYXcZQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: zd1211rw: remove __nocast from zd_addr_t
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240130151556.2315951-2-kvalo@kernel.org>
References: <20240130151556.2315951-2-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, xl@wp.pl
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715700503.1586694.7894322297990961524.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 18:16:46 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Sparse warns:
> 
> drivers/net/wireless/zydas/zd1211rw/zd_usb.c:383:24: warning: implicit cast from nocast type
> drivers/net/wireless/zydas/zd1211rw/zd_usb.c:419:24: warning: implicit cast from nocast type
> 
> This is an ancient driver which has not have any meaningfuli changes for a long
> time and hopefully removed soon. So just remove the __nocast to get rid of the
> sparse warnings.
> 
> Compile tested only.
> 
> Signed-off-by: Kalle Valo <kvalo@kernel.org>

3 patches applied to wireless-next.git, thanks.

2b59c9c30b9c wifi: zd1211rw: remove __nocast from zd_addr_t
0583e5acaf43 wifi: rsi: fix restricted __le32 degrades to integer sparse warnings
7ceade653429 wifi: cw1200: fix __le16 sparse warnings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240130151556.2315951-2-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


