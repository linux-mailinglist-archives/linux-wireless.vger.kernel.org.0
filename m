Return-Path: <linux-wireless+bounces-9419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9EE911EEA
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D771CB2138C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33A816D31E;
	Fri, 21 Jun 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxYgU7TJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52216B3B9
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959006; cv=none; b=B91I4LElhUvKrgPKpmfFxBJsIgDA9Bs6RYm0KJsmHfTQrMcLC7bOx49wMozUUAz/m0NlzxfbrXa1L3qMYvGQkARO0lzf5FelCLnUHnNPRXV9zLkzxrD7lad8FiqXZcyn3J4o1OelRf9nCMB4osg16QM212icSLQg81N4B8iQFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959006; c=relaxed/simple;
	bh=2g3e5q2wgc/Fb4K34fTPXTCmZ9H0dU3ILM5fFmsdhas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cSFZUllqSdcE5LLCVBShr4XaX76jnkB5chWn+HKuKQ7LL2gp5sMmJHBHF2bsa++G2ULzXzONX37RKLKxT0ZES3+h3cmH7WKuGALr0djZLP5nm2oemo0lMS6ZDU1S/z7UwZHCm3SJEBs/4ipHTSiNDfIbMqC8KsnhBoPeDsREc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxYgU7TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A65DC2BBFC;
	Fri, 21 Jun 2024 08:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718959006;
	bh=2g3e5q2wgc/Fb4K34fTPXTCmZ9H0dU3ILM5fFmsdhas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VxYgU7TJekGgAOLEyU2XrpW6TZWbWfcDbv+X1D44Z6WyM1ru9bIrI3yzCTYS65m9+
	 fHV9AGIsysv2O9ZCRmSUq1GH6NZhZCqkWFNeEj3DhJileO0ONrErv3t8kOnGbqWuix
	 HcZ630tHF4+4y6JlPvY7Y/wQhV235ne2QjfqJj2hjTRKnG8wWs2TsiOwMVWGDrxiE8
	 Fl4OEMs9AndEtmQJIZXd69PYpguoVvMIL/tgsKHD25yuFFREVieCmar9uJGrMwXoQX
	 JYGT75w4bw9PV6ywVlOPD9hYbNA4ej22S11vwFAG139XFCkJ3zs1P6PzfDzS1fWCWP
	 xYpF6R8aEp/8Q==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 77BD15F852;
	Fri, 21 Jun 2024 16:36:43 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240621080348.55504-1-pkshih@realtek.com>
References: <20240621080348.55504-1-pkshih@realtek.com>
Subject: Re: [PATCH v2 1/5] wireless-regdb: Update regulatory info for
 Argentina (AR) on 6GHz
Message-Id: <171895900346.921008.11652894274798120471.b4-ty@kernel.org>
Date: Fri, 21 Jun 2024 16:36:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 21 Jun 2024 16:03:44 +0800, Ping-Ke Shih wrote:
> NATIONAL COMMUNICATIONS ENTITY issued Technical Characteristics WiFI6
> Equipment on 05/22/2023 by Appendix 1 of [1], which 1) an access point or
> subordinate device may operate in the 5925-7125 MHz band with a Power
> Maximum Radiated Isotropic Equivalent (EIRP) of 30 dBm and a maximum
> EIRP spectral density of 5 dBm in a bandwidth of 1 MHz; 2) A client device
> may operate in the 5925-7125 MHz band with an Isotropic Radiated Power
> equivalent (EIRP) of 24 dBm and a maximum EIRP spectral density of -1 dBm
> over a width of 1 MHz band.
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/5] wireless-regdb: Update regulatory info for Argentina (AR) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/7e37778d99d0
[2/5] wireless-regdb: Update regulatory info for United Arab Emirates (AE) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/56f3a433fa0c
[3/5] wireless-regdb: Update regulatory info for Colombia (CO) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/3cb8b91d242e
[4/5] wireless-regdb: Update regulatory info for Costa Rica (CR) for 2021
      https://git.kernel.org/wens/wireless-regdb/c/3682ce5d086d
[5/5] wireless-regdb: Update regulatory info for Dominican Republic (DO) on 6GHz
      https://git.kernel.org/wens/wireless-regdb/c/dd4ffe775dbc

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


