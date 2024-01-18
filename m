Return-Path: <linux-wireless+bounces-2156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C77B8315ED
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CC8284572
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22481F92D;
	Thu, 18 Jan 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxS26i8o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE82E1F922
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570498; cv=none; b=SBzwvhsD2XG5UifVoz75cqUGAggFnfBs25ub6KWMEaiSoP0xyRXkRGmXf96nA1GiFnyvAhUPVsDct7oAZIxu3qsvhp/JSj0xUIK22kIR/2BGKA51RBojQrDST561exxlpVbdhjA1lW8rcXr95CykB0hs1qSNUqqHts8ejlnySUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570498; c=relaxed/simple;
	bh=jjGU8SBil3ovYJwjQeXIPrHs0IgBjQKjzMR3H0g5mIA=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=PVDIUDaBal9NdSvd94lYXTFbOvtaolx+UqI2r/FpNChh9fjnAjdUh7YvcKsKX8zVHKK+NuhyISzRY9Rx8G6gUvIw5BWcQEAvsQ0elacCmwAfXwwobHwfN/DqLbSegFBVkDZf2u+grBhFhEKl23PYydNrz1/3WyPlMvKxjfD92YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxS26i8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B2BC433C7;
	Thu, 18 Jan 2024 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570498;
	bh=jjGU8SBil3ovYJwjQeXIPrHs0IgBjQKjzMR3H0g5mIA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UxS26i8oEafF6v6f9UQBU9QLq1Co0ALiRgIetm5wJdA28COlcJp6HAAOS8U91nwej
	 4hVRrfr7QAqRy8VJ9yo3WZ0BESFDJ9fjyRoAY8hYfQ2Unr/c/FQMq38zLE0IoYSUTl
	 PA3chjKvmGtKWieNIAn2OzBhvx169rH0XAGww7H/eRFNt7t/TEfaBNZ5FJ85O1TqMN
	 ul8PKSyJ/BuFTjeWRbIKSJp5ZvsNEICSzyPPHUT3/YD+fqHmRMB2ZHhpfs5BNsePWt
	 PlOvhrRuzdCFHHhLM2V5sPc5l1RjISnQeGw54rII5maakMiqCNdFQmWoCpAMdRz9rD
	 eWqOLVgpLA3jw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192de: Don't read register in
 _rtl92de_query_rxphystatus
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <19a3e023-0eaa-4096-9f78-a2c8e909cb54@gmail.com>
References: <19a3e023-0eaa-4096-9f78-a2c8e909cb54@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557049546.2797779.11828652028578423722.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:34:57 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Instead of reading bit 9 of RFPGA0_XA_HSSIPARAMETER2 every time a frame
> is received, just use rtlphy->cck_high_power, which is initialised in
> _rtl92d_phy_bb_config(). That bit never changes anyway.
> 
> With this change _rtl92de_query_rxphystatus() can be shared with the
> upcoming USB driver. The USB driver can't read registers in this
> function because register reading can sleep.
> 
> Compile tested only.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

0635d73d85c1 wifi: rtlwifi: rtl8192de: Don't read register in _rtl92de_query_rxphystatus

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/19a3e023-0eaa-4096-9f78-a2c8e909cb54@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


