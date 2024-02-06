Return-Path: <linux-wireless+bounces-3215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35EA84B25D
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FF71F2579B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7215812E1FF;
	Tue,  6 Feb 2024 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZasbJg4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA912E1D1
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214706; cv=none; b=DJDU67/F3X04+8qYZGERppaGTgdROMkY/mPmaVIQ/BHv9TAMSP6ksFjDBkLhBMmcjYQ9bbg8pXqlJwavpBoQc/2nxTAhiF9ZRJsGOEu+CBp2iNOAVZToGWalTjFfHbXKF+Rrlxkry8zEPJPDWgrldJ4UjvFlEzYvT6v6PrJ4Pcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214706; c=relaxed/simple;
	bh=AbCZAtWLWmMYgK23qd2M57UcqI2KxapaXPHsUsnCwAY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=U59ASq5CsHte4AUZYVFbSqV9GhKWhRHMEd1lrozV+yhHatEMhRc7UcIMwxGlK6PQxsRLpoJgY0d6hAfNtxxuJffHDqlp+8G5rLaHee3Kuk/KIUUAl7pAWSXPJRcEUzak9agPHUI8MSpUrwg1BnwSCenJqwwXSd/IHOKfIox9UrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZasbJg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F4FC43390;
	Tue,  6 Feb 2024 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214705;
	bh=AbCZAtWLWmMYgK23qd2M57UcqI2KxapaXPHsUsnCwAY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kZasbJg4zRMWxZyTp1/s4Gwonl0iUKI2sLcQ48JUoMTmrMpMhiBg79zGpCdnOxZzn
	 xv/tnl+a9Lk7C8fd8sz2nYJYiPDUqGJWB6cNhA7UGAeEaxJtzRjNVw7Je33TlZ7Zvx
	 0FZ83v3UXk2ccgDE5ItrfSsjnlfx8nToQuohOI3r9Tj/DTJGUOYv5cOlB6qjeUsMaj
	 fz98eMVdX6cN1Q/rVivIiewL0Kvs35ddSGqqQL7d5MpZplZ2d430n4jdeLxJhnxP5T
	 nsFDyjQl3Roy2MHiVCHy1mX7pA8nrBASIp5E5sSOEmj42qX+Z1Jk8wUzE8i2jjX/pQ
	 UmpKlx6/E5ofw==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Avraham
 Stern <avraham.stern@intel.com>,  Luciano Coelho
 <luciano.coelho@intel.com>
Subject: Re: [PATCH 12/15] iwlwifi: mvm: advertise support for protected
 ranging negotiation
References: <20240204220617.1456895-1-miriam.rachel.korenblit@intel.com>
	<20240204235836.608a307e4dd0.I578af1c9836e91069ce318b265bd221f42955992@changeid>
Date: Tue, 06 Feb 2024 12:18:22 +0200
In-Reply-To: <20240204235836.608a307e4dd0.I578af1c9836e91069ce318b265bd221f42955992@changeid>
	(Miri Korenblit's message of "Mon, 5 Feb 2024 00:06:14 +0200")
Message-ID: <874jelj3pt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Avraham Stern <avraham.stern@intel.com>
>
> Advertise support for protected ranging negotiation if the firmware
> supports it.
>
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

"wifi:" prefix missing.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

