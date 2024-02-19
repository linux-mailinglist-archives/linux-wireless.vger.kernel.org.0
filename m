Return-Path: <linux-wireless+bounces-3781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341E085A825
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 17:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE63E1F2158E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Feb 2024 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FEF3D0A3;
	Mon, 19 Feb 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGb8TlHS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4C53CF77
	for <linux-wireless@vger.kernel.org>; Mon, 19 Feb 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358727; cv=none; b=EbI1yvMB35nqikvvbbmvgQoINAFnUzqf7egVD8cAcFy5tn9IFstethxUbNQmQtHm/shPsCHH6dN1xbB+4D2xgs7s0Ov/ZgRdQzbg+asx+ZlpiGjuM7LHu0etHimuMK3PBBrqcvgnUueJNM60EPKJTUD23HC1xeZLh0uHddSDGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358727; c=relaxed/simple;
	bh=6Agzb6Z44o7P580xh6nn/qd3jkzQ0h5pyxtnuYKGtew=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=oo7w0g+jdadw+g/RHCQ5T0i6FK6OE0bxJyvT5igmGFFhDXZjZ/YEJ0RVsizidWjqdDxWn6Dw/HNY7Wlp2ACVkiNyhGgp7PezvoevmmdOrwTLS5jOxKv2VMcT4Luydrr6do4qAP6JVfMbbHyIlBHoCOnhdk9QaWVliGKvDQyPjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGb8TlHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAC2C43390;
	Mon, 19 Feb 2024 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708358727;
	bh=6Agzb6Z44o7P580xh6nn/qd3jkzQ0h5pyxtnuYKGtew=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=tGb8TlHSlYxjmvzEHIgskmwWhPy/GpOb5bH3MuWuYNO4NX0RdxclnR+JsUTZmdX4p
	 K/nJpCtsZ7RYwLCWdux9AY+kM4vWwy8iFEu7/LhMcPjJdwNgVJAe4Wnca7t6zUPT9v
	 lNlnviqwO1eWHZ72GtsMzXqLIAjckisxPCjuwvsJ7tLnHz792E2Z3GRplhNDqNVFSe
	 KRsoQz+Kxz0I01k5JFaqAZsm8EpeJRB55Q2Dnf4Agy1KyRkJGThavBlRPf8EcVbiI+
	 iervVDdIWb1a5WZ9ZrE/GEUQSrGYsVngPkzHNUKaMb6z/YTUy8KQJgyOO8M0H0ApLe
	 nb4XYj0DfFGpw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: wilc1000: simplify and cleanup TX paths
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230717084400.57882-1-dmantipov@yandex.ru>
References: <20230717084400.57882-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Ajay.Kathat@microchip.com, Amisha.Patel@microchip.com,
 linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170835872423.848163.11512257935917209592.kvalo@kernel.org>
Date: Mon, 19 Feb 2024 16:05:26 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Redesign 'struct txq_entry_t' to avoid callback functions and
> replace 'wilc_wfi_mgmt_tx_complete()/mgmt_tx_complete()' with
> 'wilc_tx_complete()' which operates on 'struct txq_entry_t'
> directly. Drop callback-specific 'struct wilc_p2p_mgmt_data',
> 'struct tx_complete_mon_data' and 'struct tx_complete_data'
> with related 'kmalloc()/kfree()' calls, adjust related code.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This needs testing on real device before I would dare to take it.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230717084400.57882-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


