Return-Path: <linux-wireless+bounces-13310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A0989BC3
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227321F20FA2
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B8015FA92;
	Mon, 30 Sep 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss3ne3A5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05021547CA
	for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682255; cv=none; b=Cg628UEjaRRhdCi9G5llOyIOboN1bMAC4ygXdwBieWM6aXyq7CYqagK8QGl5iaYOuRDxU07rjxFA5ALqoUSefa05sAayMyYDqE5qw5zQoSFfCPyX/3dpu2F8wFoVu+eg2F648e0gXmc/FA6sBMLYLNeTJThWhWv62QtG67yQHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682255; c=relaxed/simple;
	bh=Jxs5S8FqqKtOinOcz6fXTUgLw2ZrQLwAaM/ETwjv4yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V4swyI4PFS6rwZKVBa/7U+heMWFbqtKsHQkREsJUEQeSx6eVGKIszYcmtAMkfZCRPakKD5az70BpmGyq2Luw1hndE0OY61vmIg5z+pKtylxC2YlFHaexva7wqmzAetGGRDFin/RWRj4Yot6bKjjPZQyZUhjYgJHZ3geEmm0BNQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss3ne3A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C18CC4CECD;
	Mon, 30 Sep 2024 07:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727682254;
	bh=Jxs5S8FqqKtOinOcz6fXTUgLw2ZrQLwAaM/ETwjv4yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ss3ne3A5rZPQTo9Xc1kiCYW6v4Ny0eClFFSh470nnhBuHh4mUueVTKNWAAIW3BYl7
	 WIe+y09/gUkyHF4Pg0rGwxaSXY5+uqn+hPGd6AINCjf9nGjsI5wUp3OBb3rvYKHaT5
	 X/GOR19Js16kRK35jDY/TqKY6hPNWOcmLXe2FT1j/X8deu1UOiaC9nRwbpwzwvAbKB
	 uHhUmeqPqReD54k2sqC0lpgOoGolFETpd7k4Rw04FKVrstuYudL7nsXCPjiIEaiQAu
	 URwQSuhWX4FrUNoIiZ3kbqS6s+9eroK1/8e/3EpdCS4YeyDibpqsZV7CnFcDHu2vSH
	 /uoM5xlJ1DBvw==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 023CB5F843;
	Mon, 30 Sep 2024 15:44:10 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240902082304.52326-1-pkshih@gmail.com>
References: <20240902082304.52326-1-pkshih@gmail.com>
Subject: Re: [PATCH v2 1/4] wireless-regdb: Update regulatory info for
 Serbia (SR) for 2024
Message-Id: <172768225097.2546520.15568532170446522580.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 15:44:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 02 Sep 2024 16:23:01 +0800, Ping-Ke Shih wrote:
> Serbia government released radio frequency range on February 5, 2024 [1].
> Based on Article 100, paragraph 5 of the Law on Electronic Communications
> and Article 17, paragraph 1 and Article 42, paragraph 1 of the Law on
> Government.
> 
>  * 2400 - 2483.5 MHz
>    - reference [1] page 114-115, section 2400 MHz - 2450 MHz, 8th row
>      * EN 302 328
>        - 20 dBm
>  * 5150 - 5350 MHz
>    - reference [1] page 120-121, section 5150 MHz - 5250 MHz, 8th row
>      reference [1] page 121,     section 5250 MHz - 5255 MHz, 8th row
>      reference [1] page 121,     section 5255 MHz - 5350 MHz, 8th row
>      * EN 301 893
>        - 23 dBM (Without TPC)
>        - 5250 - 5350 MHz, DFS
>  * 5470 - 5725 MHz
>    - reference [1] page 122,     section 5470 MHz - 5570 MHz, 8th row
>      reference [1] page 122,     section 5570 MHz - 5650 MHz, 6th row
>      reference [1] page 123,     section 5650 MHz - 5725 MHz, 8th row
>      * EN 301 893
>        - 27 dBm (Without TPC)
>        - 5470 - 5725 MHz, DFS
>  * 5925 - 6425 MHz
>    - reference [1] page 124,     section 5925 MHz - 6700 MHz, 6th row
>      * EN 303 687
>        - 23 dBm, LPI
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/4] wireless-regdb: Update regulatory info for Serbia (SR) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/388c80ccba39
[2/4] wireless-regdb: Update regulatory info for Kuwait (KW) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/83c175cec096
[3/4] wireless-regdb: Update regulatory info for Israel (IL) for 2021
      https://git.kernel.org/wens/wireless-regdb/c/3ba2c5306fd3
[4/4] wireless-regdb: Update regulatory info for Honduras (HN) for 2023
      https://git.kernel.org/wens/wireless-regdb/c/8760bc37e9d0

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


