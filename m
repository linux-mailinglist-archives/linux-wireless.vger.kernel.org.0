Return-Path: <linux-wireless+bounces-256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375C47FFB22
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6884E1C20CAC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D383922066;
	Thu, 30 Nov 2023 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONSjEr2c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B640322063
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 19:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E35FC433C8;
	Thu, 30 Nov 2023 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701372102;
	bh=xFJaBUGhTRuqos9uOdVZgNT7AXqJONxi3TV6qgLPhjE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ONSjEr2crneS7MCJyTlRbdfXdOwiyT4E+4vzk3eQZUeV5B2IWSlLEeSmx/7KNLNik
	 2n1q3L9SKgyQYmHlHuBwEx0h2b45KVwD/ysN8R0Cf4T5EUgSQDa5/Ys88YZgaWOMng
	 +gbFjLMXFAvhCAKDK+KpDxPri+bwTXZ63FE+DKJXEyafIV8mgHZe+v4kgEDxPXsgmn
	 RTbIfGGYDayr01NBXDUcqBj3YBDMMASpARwE2ObSX1PlpKE2iWwjo6HccCcLWUgaNx
	 SxpmD3i4KvVgUIVYR+QmXBWoPPoqhYDGQPceurVDJc2cJluIRR/O42tKnn1HvUx0yZ
	 BPG9L2VO+kXtQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 6/6] bcma: Use PCI_HEADER_TYPE_MASK instead of literal
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
References: <20231124090919.23687-6-ilpo.jarvinen@linux.intel.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137209833.1963309.16652947115996666871.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:21:41 +0000 (UTC)

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Replace literal 0x7f with PCI_HEADER_TYPE_MASK.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Patch applied to wireless-next.git, thanks.

ac586b8401c9 bcma: Use PCI_HEADER_TYPE_MASK instead of literal

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231124090919.23687-6-ilpo.jarvinen@linux.intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


