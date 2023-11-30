Return-Path: <linux-wireless+bounces-259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B47FFBB3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732301C2033E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF952F7A;
	Thu, 30 Nov 2023 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgJOjUM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E365FEE6
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 19:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ED3C433C9;
	Thu, 30 Nov 2023 19:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701373540;
	bh=wA2AVl+xYF8fVQzeDAmm/6B0vmPFtUT1UDlpym9BOFE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=pgJOjUM4Zg3/xntGja8rDOYaNnFNN/Qz5PvTcWizxeQ6hbbEB+3VJqAB5g5lJpm3Q
	 pqWEQPus/58cK9lsKvcg0LAaT8lxBmUdHgY8PI12VowrWsvM5zfLF+yLLSbDanY9eU
	 f0Ind5qDqjrfW3CGVHpYttMxifVFjgfSduTEsOj2vmQHMp7SuPVbOvvRkVrB3HTHJm
	 cKD7A6VOQsfGPtRARrkOtQ0lIpH6jdcMAN0RbM4UVRMyjDMMwWYgC5TSlKjHltKlEs
	 2VgBFwjZiJY6NmskTcJNo7gAD3DbNsXipS91UOtXHDyR7MXY17zp7UoIanl+eT4sZQ
	 CnZVS/jc6V/TQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: debug: add to check if debug mask is
 enabled
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231122060458.30878-2-pkshih@realtek.com>
References: <20231122060458.30878-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <jamie_chen@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137353802.1963309.13088855840330928652.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:45:39 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The coming dynamic mechanism of EDCCA adjustment will add a function to
> dump registers to reflect status. However, if we are not debugging
> the mechanism, we don't print anything, so avoid reading registers by
> checking debug mask to reduce IO.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

77abbabaafe5 wifi: rtw89: debug: add to check if debug mask is enabled
0bb185257de6 wifi: rtw89: phy: dynamically adjust EDCCA threshold
d371c3aa35fd wifi: rtw89: debug: add debugfs entry to disable dynamic mechanism
9f4dee32b783 wifi: rtw89: debug: remove wrapper of rtw89_debug()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231122060458.30878-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


