Return-Path: <linux-wireless+bounces-16011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19289E8A63
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038721883101
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973F16F8E9;
	Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcSoS8Ko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2815B547
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718962; cv=none; b=aB94FyjQncdUN97z5zf2e1fbetfzrI2EjKvr0Ay5Jl22nrogNlwir09mvtHpUODSmXFcg00Fe1lJWIYuxgQjeerswrcKk2sUoPDf5VcFniziRB2NuXMuOwWdLlXHv+xkiRD/wbORyYJxq8H3Kvl21RXM5LSRY09W1tUtKJkbXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718962; c=relaxed/simple;
	bh=f25M2eh0d55sqiZE1JY5NhARXYucjEs1MPAC776VqGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LSrAEnJO+I7kJ9kt8fFcqak4ejt/BAAErOAoBLeMi5TLWL96cCpRRyTHMWGUZ2wkmiFKrh332sfp39gAtM5Uj4EJtZLqXWzaiXaA/Os/UCwhKKCSE2sSDuIOYDo7PXbC5DGyQ3vLSReBa73MErRwiEP7wkIdxV1TOa7WBrR7Xn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcSoS8Ko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3EAC4CED1;
	Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733718962;
	bh=f25M2eh0d55sqiZE1JY5NhARXYucjEs1MPAC776VqGk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fcSoS8Kop7+d5tMnWhcdjj9CjJRlFiADMY+MdE14nHUWCpQ5Bq0hL0EnzRHWxfp2Z
	 5yVwJnwkwlmAJFYYJg+JgLuI+xo0nOEEJXFXxkX/vdLNVpuxtNMhHkJ4Iu4g6PDalC
	 /8cqlX5Oiw6xkI4Ru15WMPHOLgAMwafSBR+t0W2y5vLzhf/5AjYpctuOnKiXe0taiF
	 2K+LPFtWBHCbC5FX9OtuUNWeyqHUBuUOgeWfH891kUsKlbKdATnXorib+B2RN+QDJo
	 TKKRY5DYSnNx82qkUGKwiTW8hS0+m5klhhf3G2IOvEr91z51oeDroXpYYjO/GutKyJ
	 Cgv6/lUo1DFYw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 9CDBF5FE30;
	Mon,  9 Dec 2024 12:35:59 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20241122024207.5535-1-pkshih@gmail.com>
References: <20241122024207.5535-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Moldova
 (MD) on 6GHz for 2022
Message-Id: <173371895963.3369899.11403233488132375989.b4-ty@kernel.org>
Date: Mon, 09 Dec 2024 12:35:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 22 Nov 2024 10:42:07 +0800, Ping-Ke Shih wrote:
> Republic of Moldova released STATE COMMISSION FOR RADIO FREQUENCIES
> DECISION No. HCSFR1/2022 on 23.12.2022. [1]
> 
> I says, by translation, for wireless access systems, including local radio
> networks (WAS/RLAN) operating in the frequency band 5945-6425 MHz, the
> provisions of Decision ECC/DEC(20)01 apply.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Moldova (MD) on 6GHz for 2022
      https://git.kernel.org/wens/wireless-regdb/c/0dda57eb854a

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


