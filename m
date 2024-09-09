Return-Path: <linux-wireless+bounces-12660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B0971950
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DDA281A19
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7ED1B78FA;
	Mon,  9 Sep 2024 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE0j7kUX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F71B78F6;
	Mon,  9 Sep 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884938; cv=none; b=u4aWtrqSbdlwXcBpvOaKSrQPeGpDKscJwrAy2WopIyhLuSEdr5Chs9Oj95Dvdm/ewX+TCMlWSKBvk4UbhLSQYRsDx5ruVlKnwA6GruPk9AmDFu5pT7CriJRLRw/q1VhM3T2dToliER23IwVZNKgy54HakIYWuyNyvrVYdmnbqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884938; c=relaxed/simple;
	bh=5O2h9ZBRnHFV0BV+f7wiOeOjlbMGcr2vAgVBmYYVJnc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uVKKuFW+GCBjRv2DiHl6i+6zPg1WQX65PolBlmvA2P24GXjKvJAOsplZi+cn9xhv3jxWlVmFWfOu64zsHWaSwtHSyEZYFwhZoTu7AKBCn+mH8bHpJwCoX6Jdq9zlwSuBMG8lr6wzrfB8J8PRszZmz+isb+i+E6zpZqTT/jNFO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE0j7kUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32984C4CEC5;
	Mon,  9 Sep 2024 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725884937;
	bh=5O2h9ZBRnHFV0BV+f7wiOeOjlbMGcr2vAgVBmYYVJnc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IE0j7kUXjC9JZfuKX542/C24MiB3E81jpqu+3CvAoVLU53+Ig93ne320fT045i9PE
	 KHDl7OODbEx56+8cfAIB4utqcNte0hR5hnCc9tP7/9B1UXcoF2j4dclEU5c+pR82bW
	 KSLjizGmDHw+9zyK3Qj72uKPqLY6/KV+pgUqeqGH3AAX8pRTCJkOZ7IXO/HtSuvWkf
	 6ISpB/cFyAjwko90OoafwUf8Oj94Hnxm1BlG90r4Oeu+Zc63PCJvbkxckccUAVRL5l
	 CrTP0AIY5t1TOBb3cBLG6eQERgOpAOgkQEEfy7lIcXbsbTCo+IiRE+pZsbaTefvcX9
	 Mzl6m37f0c7Dw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: wilc1000: fix potential RCU dereference issue in
 wilc_parse_join_bss_param
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <tencent_466225AA599BA49627FB26F707EE17BC5407@qq.com>
References: <tencent_466225AA599BA49627FB26F707EE17BC5407@qq.com>
To: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: ajay.kathat@microchip.com, claudiu.beznea@tuxon.dev,
 alexis.lothore@bootlin.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172588493454.2095526.12090951581547763945.kvalo@kernel.org>
Date: Mon,  9 Sep 2024 12:28:56 +0000 (UTC)

Jiawei Ye <jiawei.ye@foxmail.com> wrote:

> In the `wilc_parse_join_bss_param` function, the TSF field of the `ies`
> structure is accessed after the RCU read-side critical section is
> unlocked. According to RCU usage rules, this is illegal. Reusing this
> pointer can lead to unpredictable behavior, including accessing memory
> that has been updated or causing use-after-free issues.
> 
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
> 
> To address this, the TSF value is now stored in a local variable
> `ies_tsf` before the RCU lock is released. The `param->tsf_lo` field is
> then assigned using this local variable, ensuring that the TSF value is
> safely accessed.
> 
> Fixes: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

6d7c6ae1efb1 wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/tencent_466225AA599BA49627FB26F707EE17BC5407@qq.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


