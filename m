Return-Path: <linux-wireless+bounces-257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69687FFB25
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C6D282141
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F7822066;
	Thu, 30 Nov 2023 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsquDq4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4A5FEED;
	Thu, 30 Nov 2023 19:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0612BC433C7;
	Thu, 30 Nov 2023 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701372139;
	bh=+7y/SoB0oekqe7y/gT33Bcz6gA3T+9Zo09+5P9Q1naY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=VsquDq4ozGnJM2AsKT3V7db8lUQAoqT0ku4HmN0YvirIuLernk2g6FugwhGB31BNO
	 RGhvSPM4wZEgJqhm44lXuMQaEY9YDmdKy5B94p2cBC5Sqqz36CQNRxfFJ37s0mcC6k
	 eYk/07nfaZ0MahKCvz9cbGNJv66QctAShqOvhfeY1O+fCh1AlzVdRkEHiKxM2BueXN
	 9CZiO7p1eKUseIb2B+NUaN0sHU7c5HOFjtPB/qp4pjfMrgAiS0v/5WNjlM0jfRVkm8
	 fyubqsRUC1nO8b5v+BYyb2fD56UDZuheA0JjkIbkG7oh/hoFHGktuycO44Q37I/jSc
	 HiTnyJSpBzIxQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless-next,v3,1/2] wifi: rtlwifi: rtl8821ae: phy: remove some
 useless code
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231127013511.26694-1-suhui@nfschina.com>
References: <20231127013511.26694-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: pkshih@realtek.com, nathan@kernel.org, ndesaulniers@google.com,
 trix@redhat.com, Su Hui <suhui@nfschina.com>, lizetao1@huawei.com,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137213526.1963309.2251579800524493199.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:22:16 +0000 (UTC)

Su Hui <suhui@nfschina.com> wrote:

> Clang static checker warns:
> 
> Value stored to 'v1' is never read [deadcode.DeadStores]
> Value stored to 'channel' is never read [deadcode.DeadStores]
> 
> Remove them to save some place.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

cda37445718d wifi: rtlwifi: rtl8821ae: phy: remove some useless code
bc8263083af6 wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231127013511.26694-1-suhui@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


