Return-Path: <linux-wireless+bounces-8812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976C9043EE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B690D28904F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 18:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6DF5820E;
	Tue, 11 Jun 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBhojCS5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68456DD08
	for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131512; cv=none; b=Pbt4nBimDnBIsdeUklnP1BHf0YKKLt2pw4Fa/g2vPa/0ERg2waN/ZZ/dnL8Fu5u/jof2Jh4aQ2V0zHUSNdKpwQ8I73ze/Ibt6hX5gBnjsrCItzXvhU/LIWSfaQDcMo2Wn5cwSO6bQkonfzk7Am+EEXR7nL7ZsHSuQK12AjP5gAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131512; c=relaxed/simple;
	bh=LB+xYWiQgFmIvjz06NaeaI39lPvfaqivVpjZ+4IalEo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MZgGocBLSn3Gw/cskMV3AZGuJDr/Cw94T8Ds+q28afKsecATQYoLAI5KHJOPK+cElSWIh8l6+zBS3o19i/7mB61YgjKWlM3EzBMDXhYVg8eb1H0ZsedL/cxK4Sjb4YnxIf+ApHvYRK2QMkrvqM6XsJ89ZnC6e3Xe0MD4VnLYJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBhojCS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C575C2BD10;
	Tue, 11 Jun 2024 18:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718131512;
	bh=LB+xYWiQgFmIvjz06NaeaI39lPvfaqivVpjZ+4IalEo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=BBhojCS5D61lD363LS9h3qLSju+haMi6m0YyMKxom16DzSY5mcrLaYaLL3rTqBeF/
	 yyRfJN4mjMfvxjrwYhExUELea0lRKDcroBufcqgbZS42VHU+ZpnPUCiaXqpCpEV9ZM
	 +6IBjxTyZ7vT2xZgtQKv2eZ4uGolj50DO0r//pufW2npVrO3ZdEax3+bnl16VxBbPJ
	 z9Mnr1VEEOXiQtrPI5FZdGYAYOQiAQzlkiS4TNJ1SkKUagEBwFjiqpUwlwn62ZKkDv
	 UyBIZMIc1CbPZtjCXBGMpR2disJTOitw6DecMsUdX1n2AEsQnntUR3jhWrNQUz1ZjY
	 Jn6JioJXvpzIg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: ath12k: fix per pdev debugfs registration
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240529043043.2488031-2-quic_adisi@quicinc.com>
References: <20240529043043.2488031-2-quic_adisi@quicinc.com>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Aditya Kumar Singh
	<quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171813150979.3564613.3522946420612603449.kvalo@kernel.org>
Date: Tue, 11 Jun 2024 18:45:11 +0000 (UTC)

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Function ath12k_debugfs_register() is called once inside the function
> ath12k_mac_hw_register(). However, with single wiphy model, there could
> be multiple pdevs registered under single hardware. Hence, need to register
> debugfs for each one of them.
> 
> Move the caller inside the loop which iterates over all underlying pdevs.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: f8bde02a26b9 ("wifi: ath12k: initial debugfs support")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

8dd65ccbdf91 wifi: ath12k: fix per pdev debugfs registration
4e1eff38d37a wifi: ath12k: unregister per pdev debugfs
5a16da9cfb40 wifi: ath12k: handle symlink cleanup for per pdev debugfs dentry

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240529043043.2488031-2-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


