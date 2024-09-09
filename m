Return-Path: <linux-wireless+bounces-12665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B4971965
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EA31C230ED
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A471B3B2E;
	Mon,  9 Sep 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6bbQeX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568A1DFF0
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885180; cv=none; b=lb/uO1CC78pXQu+HPoi5G9WF3BfIv0+wRcFgbBD/sYvEKa2VawBfDLmkAyUqLjM8jmsg6bZAWucrziHAAfR5tvcEScFDB2rhKtoRY3neiBkY6iUqLXUJ1zydLhwMfLawuZjATTZalYQRV78wlDtrXMOaBB0ZbfRp7iuleLd/ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885180; c=relaxed/simple;
	bh=yS1D8yIYRqpxvcMQnIbSL5JvzfAoodlGQY59bWwZnes=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=aCPDntfrgrGI1OugZp7NTQrBqfIY0WQ5q7WE6d5Nd/OrQSH8m31PgzL3oW7TpR+goYpD70DGL02Nq8SElt9u+z8XjJ2Hj5egCAPeLx3tHOj+5M3SJZ9ev6nOQjEliIRINYwYT3pu5Av2pMjzDv2bPiaqU2T5OT37d0f0sylQF24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6bbQeX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77623C4CEC5;
	Mon,  9 Sep 2024 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725885180;
	bh=yS1D8yIYRqpxvcMQnIbSL5JvzfAoodlGQY59bWwZnes=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=i6bbQeX5sibYR+o2Tx5DzInaKsMogKOwDbQTcQDJsPb+OXwHUcdbTQixydNVwP7Cn
	 o7JhGCuICZkqRPDhG94PN/TMiG7wtuoU8SJHqEHLZGKTl2ebdOtdgGoUPMt33MTPk+
	 Iv8DM3UQfc8ut1O06zyT8cTEm5QCvjMEDTgJddGOp3dCEIyyXj957rWcy2B6GGerRN
	 xLb2Avzsys5F/Vfg2Y/I0lZaQOuaI9Kc8ZuqycXpX26J2H/xy8qXL5bemAdpA1fgV8
	 EN7nkaez/Pd7iWLGzULm3TrujfcvVjIW7SecJOmcRRQqPMydZnEpC5o3GasjZqDnTu
	 KO02yeKsHPIyg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2024-09-05
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <02ae85d2-f1f5-452e-8c91-be9c9882a7e1@RTEXMBS04.realtek.com.tw>
References: <02ae85d2-f1f5-452e-8c91-be9c9882a7e1@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172588517792.2095526.16274592786747747767.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 12:32:59 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

0af2b1b20292 Merge tag 'rtw-next-2024-09-05' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/02ae85d2-f1f5-452e-8c91-be9c9882a7e1@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


