Return-Path: <linux-wireless+bounces-9979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6481927088
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 09:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229D51C233EC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C681A0AF2;
	Thu,  4 Jul 2024 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6aIkz0H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641DC175B1
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077980; cv=none; b=qRoLFGAtnv9JxokWMDRtPBVBrlmaawiGxzRcMy+ZMI71/GmUtMMiC4EnnXqbuBTzW6GAST+SUpfwGjoMNc6BU8qf5qSEowiQkYtNbyXiDuW5Th6nhCgdUwN2JfGqLtXl0zhtQyXCo6wWlQ/C/76yOJ94CQf7Vr7AglmUqG7eZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077980; c=relaxed/simple;
	bh=c4QVKaFK6ZmjMg9dncbSLXtp/cNdlCMHqpItdpE0hTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GXf6Z3XagzypRBFDJ+1NGoMmzqgMNFIz9foi76KfgFQXuzwKENwv5sc74Roaa7prFIE/dZs8GPKIWovXmF9wALylOTE6kx238W50N6neoXUrzRPiJfg2c95mEnfhHDOWC+O4AWjcnsgWkCNcl0Cefcom3lOQIWGO2inPZ0AFTA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6aIkz0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D097CC32786;
	Thu,  4 Jul 2024 07:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720077980;
	bh=c4QVKaFK6ZmjMg9dncbSLXtp/cNdlCMHqpItdpE0hTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A6aIkz0HrZ6MlJXR2f7AD5NKIhe9V63YiL5yWgR38upLg/lTES5/SSXBJmIdVYuFb
	 HGK4EXBQNiVS2YzJDOUFJK7tLjOtmqZU7bmcU61dbIlx9MthxxReNx/1ZI59ob+wAr
	 bWr1p6nzScrOAnmwrmusUqTnDgoslGwPSUjVxhcJCkXlOHUvX8YLEpRcA6XNgAC2x2
	 wyKbnZbLDIvp8P7qqNfcFbXOtB8220W6n9EkHluVCGDCmUxV6o2TgKc1kR2BNcgvka
	 0VBWxoFcN1VWEjYnU+ax7VJt98csWkaMzKGltpBCwJSJTIQQigl+CrdAvCs+vPQGEP
	 fSZw58tXkRShA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 6A8BF5F882;
	Thu,  4 Jul 2024 15:26:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
In-Reply-To: <20240702065100.13644-1-pkshih@gmail.com>
References: <20240702065100.13644-1-pkshih@gmail.com>
Subject: Re: [PATCH v3 1/3] wireless-regdb: Update regulatory info for
 Jordan (JO) for 2022
Message-Id: <172007797741.1245979.14807997228875413304.b4-ty@kernel.org>
Date: Thu, 04 Jul 2024 15:26:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 02 Jul 2024 14:50:58 +0800, Ping-Ke Shih wrote:
> The Hashemite Kingdom of Jordan, Telecommunications Regulatory Authority
> issued pursuant to the provisions of Articles (12A) and (22) of the
> Telecommunications Law No. 31 of 1995, as amended. [1]
> 
> The effective radiated power (EIRP) of devices used in local radio computer
> networks must not exceed the following values:
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/3] wireless-regdb: Update regulatory info for Jordan (JO) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/a9ecabe9844b
[2/3] wireless-regdb: Update regulatory info for Kenya (KE) for 2022
      https://git.kernel.org/wens/wireless-regdb/c/5a9fdad41aeb
[3/3] wireless-regdb: Update regulatory info for Macao (MO) for 2024
      https://git.kernel.org/wens/wireless-regdb/c/19326c3fffab

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


