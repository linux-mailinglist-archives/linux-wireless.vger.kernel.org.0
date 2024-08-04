Return-Path: <linux-wireless+bounces-10892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4941D946DAE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 10:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80C51F21374
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E774200AE;
	Sun,  4 Aug 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlamGhEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371261CF9B;
	Sun,  4 Aug 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722761877; cv=none; b=kgA5RKAr4wWvt8IF0SeYkYQzAPENMBeriA8KQzvoI8QjduRNH8681Pe1u4SH2XGm7N8r9TciF0tBf4j3ke6AcxNVQrCiUxIwQt5gbmv+Uy0FJ7/6sOWJE8z1gDjdRi5yqc7aRZqef4bBdQOO5JyAT1eNUldFlHKJnHqSHM943Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722761877; c=relaxed/simple;
	bh=LzzWpbndsCzxP0UVHsK60G7SP62Q14uzWV2Osr5LxI8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=cRgfzPqwcpljAHpD3OXup/mKc2LNCJQlbxQ7FH1cPJijnUKFeY1GvbhXOCou06GgB4QNSOoFFlkoZVxww0TstWrGHdPlVq4C7YvqtDUD+5uozKYYvuvD+S6fxAcetDSEodljL6ePQp01pgCra5hR/2PqDM8DL4LGuM7LPwjqrCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlamGhEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD2C4AF0C;
	Sun,  4 Aug 2024 08:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722761876;
	bh=LzzWpbndsCzxP0UVHsK60G7SP62Q14uzWV2Osr5LxI8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=RlamGhEq4I8pjQj2VF9stTMhQceAMCbaVrM2mcYtOzVESZEPiokn7KBiw1JvEydgg
	 lTRPYIruS7ieIK3Ps004/zPjGgjeUkWLuSbmUZ+9IWH90baEPmTjeq1d9ysUhwIGsb
	 QOCRvSotR2z45hC9xfNstky4Phn9AbLznYEFAv8dGQAEABvwOm4l2oy1qi9OLp8bcQ
	 R9JHfBrVhvocqy9b/K4vjA4WBHaVkREH3xMjsTAw4t93dQnX6DNh7crhSkmWVLeh1b
	 QIdHoBaerbK3V9MhKezWCQRV0K9QhIU2ngg0sQnkaEPsnXrFR6yVaiOE8cndcozhAJ
	 ldkH/FjkuRyJw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] wifi: mwifiex: simplify WPA flags setting
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240723-mwifiex-wpa-psk-sha256-v3-1-025168a91da1@pengutronix.de>
References: <20240723-mwifiex-wpa-psk-sha256-v3-1-025168a91da1@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, David Lin <yu-hao.lin@nxp.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172276187336.2804131.2752806886332298409.kvalo@kernel.org>
Date: Sun,  4 Aug 2024 08:57:54 +0000 (UTC)

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The WPA flags setting only depends on the wpa_versions bitfield and not
> on the AKM suite, so move it out of the switch/case to simplify the code
> a bit. Also set bss_config->protocol to zero explicitly. This is done
> only to make the code clearer, bss_config has been zero alloced by the
> caller, so should be zero already. No functional change intended.
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

There were conflicts on wireless-next, please rebase.

Recorded preimage for 'drivers/net/wireless/marvell/mwifiex/fw.h'
Recorded preimage for 'drivers/net/wireless/marvell/mwifiex/uap_cmd.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: mwifiex: add support for WPA-PSK-SHA256
Using index info to reconstruct a base tree...
M	drivers/net/wireless/marvell/mwifiex/fw.h
M	drivers/net/wireless/marvell/mwifiex/uap_cmd.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/marvell/mwifiex/uap_cmd.c
CONFLICT (content): Merge conflict in drivers/net/wireless/marvell/mwifiex/uap_cmd.c
Auto-merging drivers/net/wireless/marvell/mwifiex/fw.h
CONFLICT (content): Merge conflict in drivers/net/wireless/marvell/mwifiex/fw.h
Patch failed at 0001 wifi: mwifiex: add support for WPA-PSK-SHA256

3 patches set to Changes Requested.

13739655 [v3,1/3] wifi: mwifiex: simplify WPA flags setting
13739654 [v3,2/3] wifi: mwifiex: fix key_mgmt setting
13739653 [v3,3/3] wifi: mwifiex: add support for WPA-PSK-SHA256

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240723-mwifiex-wpa-psk-sha256-v3-1-025168a91da1@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


