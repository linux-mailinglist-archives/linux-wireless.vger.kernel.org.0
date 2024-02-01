Return-Path: <linux-wireless+bounces-2928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A1845493
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 10:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8A628691B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5864DA0F;
	Thu,  1 Feb 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9aJbKBw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB474DA09
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781291; cv=none; b=Cj964hAN40vrSy8a7qMPsH27Upm6JB3CnDPWIlK52uxvoaql0aVnrwnnI+TFmEXWbbt6tuOxRCDhEt4yKqadYBzOTYy6L9NL1HLYjghMf+f/d9PP1NAiKEtCC9zqGNl7gUiTzr+RsBai4VS5tvvGK3LT8DiwqzQtKrLrEApWCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781291; c=relaxed/simple;
	bh=GV1CxmFWRaWmZs2LuQqpYjOKZM8OWCqdbsmrUovirXc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OUMpx9Cox2L4E1vYf8Anq9mFrWhasa2ZFATBxcFNha/EAUzMCpNuuKcI9eBzf91MQzcDP8FS99OZNoU836cPTxP2761nN2a0PONpVfaWYhkje/o/vTsLUI466QtRYFp1E6KfML2Skdvz0ocliGLXw66e3JgF+6B8cBAUh712WSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9aJbKBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D78C433C7;
	Thu,  1 Feb 2024 09:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781290;
	bh=GV1CxmFWRaWmZs2LuQqpYjOKZM8OWCqdbsmrUovirXc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=l9aJbKBwBAIXj1dN2vvdvr23hFH95aGqYk7HTDstO+lY1+6HtNj7diNNqeVpqoZE/
	 MjWDI0aBxsfXDxXAxp+KRI7cCcFKasgpd6UBivoPdptjz3ZPoP0tbTLZ4bQ4UwjAd6
	 t+Q+2hlh5V/GKbby4UQRQmCTv2UpFsnvyio9UlgPXcANUbpYGMlcY7KQEFoTKSA0J8
	 PBTGmg2ox766wq57Tcn9CZ6JsQcm41Uhu2biI0BmI5jDVjZI8d3LzvoIqENtTTI5n7
	 mEpDQRdxrMVnxAoqtr7f3E4etWECVbQtY0s5AVEAWRO6VPwSHq4zQnPPCrI+juZ7e+
	 PRm6evleT808Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: iwlwifi: remove extra kernel-doc
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240128102209.d2192d79bc09.Id9551728d618248dd471382a5283503a8976237a@changeid>
References: 
 <20240128102209.d2192d79bc09.Id9551728d618248dd471382a5283503a8976237a@changeid>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170678128720.2670354.16146319839725381430.kvalo@kernel.org>
Date: Thu,  1 Feb 2024 09:54:49 +0000 (UTC)

Miri Korenblit <miriam.rachel.korenblit@intel.com> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> This no longer exists, remove the kernel-doc.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Patch applied to wireless.git, thanks.

aa125f229076 wifi: iwlwifi: remove extra kernel-doc

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240128102209.d2192d79bc09.Id9551728d618248dd471382a5283503a8976237a@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


