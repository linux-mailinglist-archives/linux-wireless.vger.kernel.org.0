Return-Path: <linux-wireless+bounces-2935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C790B84551D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 11:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C6F1F2D8E9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3715CD65;
	Thu,  1 Feb 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZne8cSM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F415CD66
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782812; cv=none; b=hRVyCr6HqRSZUHrp1RLFv92NR+NrH8nxlDWm7twcxXAYLdXzRSbyik4DONqFwzJgZb3xT161kyWzEMngn+z/hxYsCSt/c0WWuax2Xr1gn1A7InSduuYnQqn7RPybrk+KP32p4yIAZImBVYDzcSocJtNYH9IKDCGRrNbgfpgIIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782812; c=relaxed/simple;
	bh=NXpKrtbBPJff8CbGZmH3CtU61lDeGa994XUd4veHn8I=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GxKOJCgerfOXo8BU914xJytcU+5uC8S56o/4y42BH16pysCPhwhT/4Q6p7nPHlbZGP1Yy+yr47j7mrxTGCjfOP529O5Sc9JIiERAi5rKYhZv8sNbWAmB1M51/fIAb4H2Wv0lo4ZBvttzvrrTCK8uIe9NRlEFNel7L8AmuaeFExs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZne8cSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E4DC3278B;
	Thu,  1 Feb 2024 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706782811;
	bh=NXpKrtbBPJff8CbGZmH3CtU61lDeGa994XUd4veHn8I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=AZne8cSM1PdkMhvi5g2bs/IwI80Uvl2lGZrFt/SYJ8iykJ/5un1pjTacFtc9vLSvu
	 WSdd5UDyF8xjG6NQJK5czW0ShfgLkPISnl99V/ltzekpI2RCXc4CTyfw38z9BED+od
	 eM3yMf5/rT4zZu1KEdLrnNi5fPch/Bhgngw6mp8fzgebRIKUrmLsIkg3w8XPdkgoBr
	 taBMwkP70AqOJXNbEexddqtDDw7hGGArVusvaybm9rlZPEA33347dpoMihrIWyHesz
	 jcMwAkWyHx6DZri2kz7DbOpKLoElMTCu2cNJ/d6UmJvYR8w4nx+3b2dAePkjiSb7gL
	 QyC1/hGJoBd/A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: 8922a: hook handlers of TX/RX
 descriptors to
 chip_ops
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240124033637.12330-2-pkshih@realtek.com>
References: <20240124033637.12330-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170678280966.2736043.15039979542627680694.kvalo@kernel.org>
Date: Thu,  1 Feb 2024 10:20:11 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hook implemented handlers to chip_ops, and fill packet frequency and signal
> strength to RX status from RX PPDU status packet.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

f8a7840e98a4 wifi: rtw89: 8922a: hook handlers of TX/RX descriptors to chip_ops
b16daa62125e wifi: rtw89: 8922a: implement {stop,resume}_sch_tx and cfg_ppdu
1ba63a8a752a wifi: rtw89: 8922a: add chip_ops::cfg_txrx_path
88d1f9b22fab wifi: rtw89: 8922a: add RF read/write v2
1de97cd362c4 wifi: rtw89: 8922a: add chip_ops to get thermal value
a6c759c8962b wifi: rtw89: 8922a: set chip_ops FEM and GPIO to NULL

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240124033637.12330-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


