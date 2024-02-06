Return-Path: <linux-wireless+bounces-3246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7C884BCA9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E57A1C23000
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A3DF5C;
	Tue,  6 Feb 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAdi+PgT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47916DF43
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242758; cv=none; b=so+hQn2oK+Kl8UH/rd0x4Si8mSySCpNEIqW6L6ZQPyfy6QRpJxe2fxl8XNitVLaS1e79ympP/rhssNFXgXFsbSGxcjUPfEU7CQEjMMeerjdpp3+K49oK41LR+2TsyVcKGQQos1y/6gnKBk7RnQcBS+P0vIYXeYnBihZ4UMUOJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242758; c=relaxed/simple;
	bh=EqrTtYcwu2dr3vRT3cx3p2ooIu+Mb0J9bFPgpzlZTOc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=gHTCGNvZ3P5v/vlYLlz7cDdiiuB7gbnhZdgK3jOPiJo42sl4V4jxWMaoqqsfJUSxR1RN/SQR4iO0Xr0KvEdCQzYnKrlR69Io/VxBVXM3K1AT1172eN74pQK6zyJld4luwHvoKP+jMlIJlOEqyRIMm3JAzxFQ3Irj0+aajwTVvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAdi+PgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5019AC433F1;
	Tue,  6 Feb 2024 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707242757;
	bh=EqrTtYcwu2dr3vRT3cx3p2ooIu+Mb0J9bFPgpzlZTOc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lAdi+PgT5ztSlY6Zc/l5M2l/GsLXPcDy+iH1oZTYVl7A7UfFdH3wopY4x7dCz2tDZ
	 bJsw0XHB2AGZwplaW2hCRo5X7lh7Flyn2oRbl5AKDwLkPNrO+AE+ooqO8+SyhRFel6
	 90MlFGALkkNRzvtS0R0UPYsU6v5f/YxuPE4qoqGlaL8Ic3udoVAKgk/CoNdzL6InNw
	 w9ZlhbqC/RMCMvIz8fhctGQCn2DrljmkjuElD7V+45Jpi6KXmoxfAAZY9C+jaLVX6Q
	 Qz5w8HfqSXVRIKygJmaZR3KvJm7pf/jszKpmPBeSAy9cJyaegdjcgB+JXD7Zijb9rw
	 9jjwZbmSD7gyw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/11] wifi: rtw89: rfk: add a completion to wait RF
 calibration report from C2H event
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240202030642.108385-2-pkshih@realtek.com>
References: <20240202030642.108385-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170724275520.1979906.333537049933941766.kvalo@kernel.org>
Date: Tue,  6 Feb 2024 18:05:57 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The RF calibrations should be executed one by one, so add a completion
> to ensure one is finish before next. The report from C2H event contains
> state and optional version, and we only check the state for now. We also
> care about the time a RF calibration takes, so record start time before
> asking firmware to do calibration and get the delta time when receiving
> report.
> 
> Consider SER recovery, we can't receive C2H event, use half of argument
> 'ms' as fixed delay that is 2 times of measured maximum time of
> calibrations.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patches applied to wireless-next.git, thanks.

ad1c86e92698 wifi: rtw89: rfk: add a completion to wait RF calibration report from C2H event
80f47f82f319 wifi: rtw89: rfk: send channel information to firmware for RF calibrations
9c66da3b19b5 wifi: rtw89: rfk: add H2C command to trigger IQK
32919a043894 wifi: rtw89: rfk: add H2C command to trigger RX DCK
b835141be5a9 wifi: rtw89: rfk: add H2C command to trigger DPK
1a0cba5dc983 wifi: rtw89: rfk: add H2C command to trigger DACK
af41e89ea323 wifi: rtw89: rfk: add H2C command to trigger TXGAPK
bd6f5f27cb2c wifi: rtw89: rfk: add H2C command to trigger TSSI
ff146ec22d5f wifi: rtw89: 8922a: rfk: implement chip_ops to call RF calibrations
7e2629dc843f wifi: rtw89: 8922a: add chip_ops::rfk_init_late to do initial RF calibrations later
4dbd964f33aa wifi: rtw89: 8922a: add chip_ops::rfk_hw_init

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240202030642.108385-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


