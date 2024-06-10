Return-Path: <linux-wireless+bounces-8750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1018F90200A
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 12:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9550DB20BBC
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 10:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72734501B;
	Mon, 10 Jun 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaYXttOT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8BFC01
	for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718017099; cv=none; b=sEemLxMdFP3jf8KHhXU+oNzO6TeSPvlScWnO4pctAABmImXq/JmjUBOt5vXmjbXkX3OoVYljUq1PswEM1gfWR3h6EmsGkmNUm0feXF73lbIo++8k0e18Zh5X70jMDnmZQO0RvFFFrJGHppG772iCyqE9dRkA6cZW0DGi0mqFyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718017099; c=relaxed/simple;
	bh=RXBo4a7vMan1IHbyzlt26A/f2TFPFS+nqiJX75WCI0A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Jc0Mhp0fYj7Pv9jKBJo9eopBYfqh6GWW5DMSfWh0ixNUcmmf8cnek7n8Fv9z9aCBSgmsb83TP98NHSRrR7j8p+iMx/e3YKB3HWelmugAKzLvXJaFFG7FOC6wB4DSyl75hw0XFRcs5pbUPSV4T0DP9XBhXorFceAU0hzWTjxuBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaYXttOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6329AC4AF1A;
	Mon, 10 Jun 2024 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718017099;
	bh=RXBo4a7vMan1IHbyzlt26A/f2TFPFS+nqiJX75WCI0A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=YaYXttOTbX/rMtg9Lzd/q3k6dTNvS+7fQw4EmrVJjffDRrJPCuoPVCU34tmABMkek
	 JX4EdisdsP1R9To4qXbxTzqmw0T2HiJVOtvLFDjfuPYjUQ3sEkscTsAuLlNWE148SQ
	 TiyupqUD9gKkT8qHCxoyu3lMiQ3djUIU7/moRiWOlkioc+IRHSYgUw5KK/BlWywhj5
	 FRAYth4EmBtl4TG3c6W/6Z1LID0wSkD38Gs2MNjCNlMVJ7+1Irs05Cg3m7pbj6/bJk
	 dLAUlR35lOaf087Ja7lS6iW8MG9xG0uIcoEK+sI4n+a9MoDDwBtL6J2J0M3Qt8H+U1
	 CL4WAoPQ0OLwQ==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: rtw89: pci: support 36-bit PCI DMA address
References: <20240607140145.8180-1-pkshih@realtek.com>
Date: Mon, 10 Jun 2024 13:58:16 +0300
In-Reply-To: <20240607140145.8180-1-pkshih@realtek.com> (Ping-Ke Shih's
	message of "Fri, 7 Jun 2024 22:01:44 +0800")
Message-ID: <87sexlkqt3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Modem platforms can install more than 4GB memory, so DMA address can

s/Modem/Modern/?

> +	option |= le16_encode_bits((u64)dma >> 32, RTW89_PCI_ADDR_HIGH_MASK);

upper_32_bits()?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

