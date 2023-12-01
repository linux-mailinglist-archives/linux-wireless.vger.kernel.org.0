Return-Path: <linux-wireless+bounces-299-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA4B800E2C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AB4281B79
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152E94879A;
	Fri,  1 Dec 2023 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef4hBv/y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE04125D7
	for <linux-wireless@vger.kernel.org>; Fri,  1 Dec 2023 15:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9EFC433C8;
	Fri,  1 Dec 2023 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701443597;
	bh=bgVpJ6hVee8gz5zZ1AIt7xJ21gnIzgv39He+QNukP+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ef4hBv/yEd9EJg2ynWjE1FK6TtowEEauVr/rqEvpa6uVjY0a2bsZbvgypjHsX+K4M
	 dzqF4XBBtOEZyTgLI9Z+Rzs/ygVkt2MTt3cJleYhMRyX0HW9/BrA8cLC7uDgUxogyj
	 0CqHdynkjFgNz9xZYPxMXiLbe7/DCV6BLAuaKe1X5gzFEvfsT9qXD6oH9O1pmNN+jq
	 Az5CRzqBhRm+z43STBFTMyLe8q08qBWzmd+3z4+VePC2OhYlHVtCNENyIHxbzIF6zF
	 I6d714sbILlW32EQNvnkVq8a3ZqpXhrerjMFaALUi5GRleQYyVP5DC6aou4WgZWcIL
	 NeZSM5wtxzfPw==
Date: Fri, 1 Dec 2023 09:13:17 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Update keys and maintainer information
Message-ID: <ZWn4DVk/eCbcDPKX@ubuntu-x1>
References: <ZWmRR5ul7EDfxCan@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmRR5ul7EDfxCan@wens.tw>

On Fri, Dec 01, 2023 at 03:54:47PM +0800, Chen-Yu Tsai wrote:
> As announced [1], I am taking over maintainership of the wireless
> regulatory database.
> 
> Make it official by replacing the key and certificate, and updating
> maintainership information in various places.
> 
> [1] https://lore.kernel.org/all/CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com/
> 
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Applied. Thanks for taking over maintainership!

