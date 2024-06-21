Return-Path: <linux-wireless+bounces-9418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68636911E93
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E240EB25745
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB4716D324;
	Fri, 21 Jun 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZZItTa4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED513C9A9
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958175; cv=none; b=gBuTbXmFJHlZTRQtgdT39Xz9jqtahhnu6oO0Y8iq9hWEmMmeQhd+cQupjRNsdIXVE6lPn6CwcgT+gD6Z3WrFu98Ax1hqYadTXh/6GhxG9SiUo7Tdc74ZtmrE4B/1FvMfWRjSLUJwRNqdAlQP2aVl1m/wLLdqcsz9OnCtqKCHaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958175; c=relaxed/simple;
	bh=dCgkEwIj0Dxo+X7oHepSbWBlSMWuRCLj0Ypw6Ajwa+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y+Q3xS+oqld/X6UUwExR6d6tl7SXE6P1aYQXh69xcTwzi1VPC76afZQNKx/R/fzX2s15fm0dt91uqHJTA0pStnAy+KEYIRpsrSDNMM/cO1sZrbtxW048QKAe6It5yj+Mp+xgfIY4kUxvCUMDznJy97MJxenNIziINo3LBcnoR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZZItTa4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E45C2BBFC;
	Fri, 21 Jun 2024 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718958174;
	bh=dCgkEwIj0Dxo+X7oHepSbWBlSMWuRCLj0Ypw6Ajwa+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QZZItTa4e2zTcAsVJNMPcAJVBJlPEBX9cvGW18wYOvcWM/jUAS0DQXzqyyXeQRC+z
	 WqUobLTrIma7B5MykLDFAjxn5vC73SEbW63bc25CKYLT0n8qwG1AWEgfMTRq8WkP1T
	 sPl7BcLZMLgGCWwCU2Lvf2Vjbk6S7fgpmx7NEI/K9vyQZoAJkbDR3IWEAZj+992u4f
	 8sN1wsMZhPoDDF0o4pCqHsC1vISEX0KywMmHcI9mBuzIzfggxx/JZKX2OXxMO9VR6y
	 OMpH+3pgmQf3erO+BVEdM0bX7Ik5EH1NCkTIfVKcTHBONr8s8H0l2rwSBme+HZk9MY
	 2exqw2H/oilJA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id E5E8A5F852;
	Fri, 21 Jun 2024 16:22:51 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240621052205.28925-1-pkshih@realtek.com>
References: <20240621052205.28925-1-pkshih@realtek.com>
Subject: Re: (subset) [PATCH 1/6] wireless-regdb: Update regulatory info
 for Iceland (IS) on 6GHz
Message-Id: <171895817191.919704.16861228006783105122.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 16:22:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 21 Jun 2024 13:22:00 +0800, Ping-Ke Shih wrote:
> CEPT ECC/DEC/(20)01 of 20 November 2020 on the harmonised use of the
> frequency band 5945-6425 MHz for Wireless Access Systems including Radio
> Local Area Networks (WAS/RLAN), which [2] defines
> 
>  - LOW POWER INDOOR (LPI) DEVICES
>    * Restricted to indoor use only
>    * Maximum mean e.i.r.p. 23 dBm
>    * Maximum mean e.i.r.p. density 10 dBm/MHz
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/6] wireless-regdb: Update regulatory info for Iceland (IS) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/cc6cf7cec1f7
[6/6] wireless-regdb: Update regulatory info for Mauritius(MU) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/ce03cc096bb1

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


