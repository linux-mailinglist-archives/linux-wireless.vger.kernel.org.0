Return-Path: <linux-wireless+bounces-16012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299B99E8A64
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F342813B6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA327176AC7;
	Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkqVNOGv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7A160799
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718962; cv=none; b=Wvc9hGEDMKTMNMXIUVFyycfBLXADHS6jiKoKxpZHvf0wfl615FCqhk6PKomqvEzMLozXLBUGQBRU6UohfSknIyLkb6whptYF9888FwhpM/DMpUxH9dBZDFLV1rGgB8/DGJUG0YDwKkG/pOG3L4Bs/WFbdBYt9MoUyKm4YwrJ8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718962; c=relaxed/simple;
	bh=83tUZJ6NHvdQri7jF0me9UhRmeINh6Os4y1s0HOlHP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=diCqW67EnAtRtS7+5urf/MCOZ/XSy9sGLQk4cmdULYx6fz8n1g24JoNch0RB13k3GupHFWg4bRqzBhLk5IiNyGd3T7n9+x5fFHkq5oHzVSZWuAUqpim9qp7O36XW4SpfUWr2lxb+AQu4lnnyUzYLluFjE1c4TZWfgPFxcmnI2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkqVNOGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB36C4CEDD;
	Mon,  9 Dec 2024 04:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733718962;
	bh=83tUZJ6NHvdQri7jF0me9UhRmeINh6Os4y1s0HOlHP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YkqVNOGv9hWjy8aY+iyOxTReT1wCQsPNIzql50Um8JdP35bB1JuTeKxjEOFWVOGqJ
	 63zj/C8/MY0TwLIzEZoFRxYd+jWm+4OwKQOxljhBwcGgAh07zWazKwoLanb5FjHU4N
	 E+6ObAbUWSUXqUDWFijtWoMXUzakuHCS1d9GtNcWKa2Yds4uYPjE14llQ7QAEb9Oqm
	 cN/2d1iOP69SE/tIsqY49z54b5xTOZ2yXp3VasLYGmPUbTG701z42ASS7wWFpR+fJo
	 DLrz0KbkkqrtlBnIMtgaw0v+KjS31V3p0A7FtfGYgHg+g/Rh5/i4WkRLx6fjFnXQiW
	 uCCnYU4tgnoIQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 82B325F870;
	Mon,  9 Dec 2024 12:35:59 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
 combuster@gmail.com
In-Reply-To: <20241118011503.4694-1-pkshih@gmail.com>
References: <20241118011503.4694-1-pkshih@gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: assert and correct maximum
 bandwidth within frequency difference
Message-Id: <173371895950.3369899.17402064216179762683.b4-ty@kernel.org>
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

On Mon, 18 Nov 2024 09:15:03 +0800, Ping-Ke Shih wrote:
> Since kernel will reject max bandwidth being larger than freq_diff in
> is_valid_reg_rule(), as well reject it ahead.
> 
> 

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: assert and correct maximum bandwidth within frequency difference
      https://git.kernel.org/wens/wireless-regdb/c/b43aeb518a07

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


