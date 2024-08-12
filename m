Return-Path: <linux-wireless+bounces-11294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449A694E836
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7764B1C209DA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 08:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212781474D3;
	Mon, 12 Aug 2024 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUTTW5fG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221255896
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449958; cv=none; b=dGAP/iI/hs1nRAch7MT3Cia3tZN1ClukJPDdKQIaZ75AtRrXFP/DlbmBUoYn1FIstZ65QOilGjpG4+Ivi2DmenRwcXV/OwSDa5cqp+S55eiqp2KAbJbVDwKgl9unHUgTHVL+lIfMVJ00sGbbpYj7Xt0eeKDvmNTR337s8yz2FFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449958; c=relaxed/simple;
	bh=YHsPwLz3iU7dY9Jpz3PW/EyfAJvVEnMGT+yMlteKF/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mc8i/mnlN8BlxipE9ojg0XAuQnhFZnKwNcs8irG79HpoD8r5LOoKhLSC7kaZyDlCiK9jwnN2Nd6RUwMHGCRKKTaBYB6EQlSHMz6ZxWeEsnF7dFVHVPIJc6eMZREc+AXZJ8tP0e7t1SXRp8KotShnVwvAKqRovERVEkuK7GFXM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUTTW5fG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D212C32782;
	Mon, 12 Aug 2024 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723449957;
	bh=YHsPwLz3iU7dY9Jpz3PW/EyfAJvVEnMGT+yMlteKF/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sUTTW5fG2sJ/mT54lnG/derKYtZVxcJHYqytPSYBf9xe9OBCVHmSCy3XI+HU+T8Ay
	 1huC6oFA03ss+wnqfhneD9xstNFF+tG0keZX8bNgkqk/sQ1LVPTZglDmiH4P8wKMlu
	 XLnTOI2ygdbn6VWFqMjgB9iExjePYbMVDYmeDTr/op+cxPqB0EPLAlbmQFE9AG65Wf
	 CNA3f1Z8j97ahK8gh3bW6TUcb7Ia6j4IkYmfVqVdc5u6RjoRvy94pzBGHTKj7Vzylq
	 t19/bvxE6cIdRT6cK1VlmkJUcFHwY0KbT9IfhgCBEYg7htktAtf91nYo8YPBaaPVz8
	 WtfUI0B+DC75Q==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 693495F9C1;
	Mon, 12 Aug 2024 16:05:55 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240806014109.5258-1-pkshih@gmail.com>
References: <20240806014109.5258-1-pkshih@gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Bahrain
 (BH) for 2024
Message-Id: <172344995540.1735423.17760115087090773263.b4-ty@kernel.org>
Date: Mon, 12 Aug 2024 16:05:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 06 Aug 2024 09:41:09 +0800, Ping-Ke Shih wrote:
> The Telecommunications Regulatory Authority of Bahrain (TRA) announces that
> Internet users in the Kingdom will soon be able to benefit from faster and
> more efficient Wi-Fi 6 technologies, allowing them to enjoy the full
> capabilities of both fibre and 5G. This is in line with the Kingdom's
> adoption of radio spectrum ranges 5470 - 5725 MHz and 5925 - 6425 MHz
> for Wi-Fi 6 and Wi-Fi 6E applications [1].
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory info for Bahrain (BH) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/158f10565163

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


