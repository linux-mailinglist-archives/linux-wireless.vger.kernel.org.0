Return-Path: <linux-wireless+bounces-697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457E980EEA6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56CA1F21163
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C552373177;
	Tue, 12 Dec 2023 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK8sHZ8t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C36F62E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 14:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8686C433C7;
	Tue, 12 Dec 2023 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702391157;
	bh=3yoY6ZENbVsfyH/ugD0vmo9/2n+g85FXdsmcJYy0V0U=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qK8sHZ8tBPSAAcQINegEqfs/2ZhplJlwK9y+SkLh3Ym0OxVAH5unGsCxcjY9eyA4u
	 PIRQOQUBvy4o1c9p5Ujy4R7Ix40bGqITgGuVYcsniRpLmNa4CSuUAMk8SEmOtk4RQE
	 Clma7/CrDsbelKlJMCqaP/VnWaZ5LrbQPV99+kHDopVntJt8OHv0y24nhFPWr0AVhz
	 WH1DdRXhEGJ/ppLB21/2Rq7W9Uq9PDol6k76jcvbjnCaJuPyqsz1atwBDZvwFCZ/YE
	 sAZSlFyFi861EoBOhiaGbgszeLNsz+2IUgfAfa3crZR3l4ixfe1Duhlb7Wtw0ALg5O
	 e9Dq4LITChmqg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: fix crash with WED rx support
 enabled
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231208075004.69843-1-nbd@nbd.name>
References: <20231208075004.69843-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170239115444.238941.12599442147553247928.kvalo@kernel.org>
Date: Tue, 12 Dec 2023 14:25:56 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> If WED rx is enabled, rx buffers are added to a buffer pool that can be
> filled from multiple page pools. Because buffers freed from rx poll are
> not guaranteed to belong to the processed queue's page pool, lockless
> caching must not be used in this case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2f5c3c77fc9b ("wifi: mt76: switch to page_pool allocator")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Patch applied to wireless.git, thanks.

cd607f2cbbbe wifi: mt76: fix crash with WED rx support enabled

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231208075004.69843-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


