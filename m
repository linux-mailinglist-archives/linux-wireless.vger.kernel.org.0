Return-Path: <linux-wireless+bounces-2676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4F3840B92
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1B51C22C0E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CE8157047;
	Mon, 29 Jan 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6oSvW+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2D1156960;
	Mon, 29 Jan 2024 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545785; cv=none; b=HiAXDFLzUqHBNMNykTAslYvX6LK3ois/FoO3cyjs2/dfqsAZ69WVqcRUbmU93Mfq0CJRKFO/IUXjmpba99Gfepw10ePfltnJ79gAku7C96rm0fdk0lZhJTxlBsSpFU1HuB7Egr3VfQFDYjBPRWFkWmUpbX8dZyD3oacwdCkRBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545785; c=relaxed/simple;
	bh=NqSOlR2pci3NKI5tDqkrXonYLQ+F4frw95VDMxivu8Y=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OxADC26hSWGT27nWfYWPzj1Ir1CjtPnxYnU4YTrEPXMUgH+qVl64Jn+zQWKJTqY59Yq0/OUHjqODKwAu/0W32qqiIxY5vw/A3c/Xpd9akpzAZMmO4WBklSd9uj20vhoibRQaRtMaq5/SA1XNKW8j9r/bPIiNvhBX3lQPV3I/D6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6oSvW+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D417C43390;
	Mon, 29 Jan 2024 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706545785;
	bh=NqSOlR2pci3NKI5tDqkrXonYLQ+F4frw95VDMxivu8Y=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=X6oSvW+UV/lFHGaSgC5+VAqLHvGmUgF67Jj4BZFa/8sMR6zPVyGn5JXrLJd2Xk+kk
	 mVr19iQRNxoymW27dY+RFYwgj2QXcmFqQULgKWEoAO6YrETQSb4K2htVkmcgEQ88a/
	 v2QU2sx23W1EPoPtgHkgLDBbRNU28diJGrX3ppaWToXPSijsYSecWyt+cRspYu7dE5
	 25ORGbPEpLzokEdzdVrXJnYY74lQSqGhARB9+eFVsR97+R6SinXPThDoJ1AxJztV0B
	 8qeKffbOV57Lgysf+yz9/CAJE4szhDDrCdWv7YvvNkklld4BtNGMlf8nXA2vg5EOMn
	 b+UG6/t+Wy89g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] MAINTAINERS: wifi: brcm80211: cleanup entry
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240126105724.384063-1-arend.vanspriel@broadcom.com>
References: <20240126105724.384063-1-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org,
 Arend van Spriel <arend.vanspriel@broadcom.com>, brcm80211@lists.linux.dev
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170654578211.2154127.3968638235616199834.kvalo@kernel.org>
Date: Mon, 29 Jan 2024 16:29:44 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> There has been some discussion about what is expected from
> a maintainer and so a cleanup seems to be in order. A dedicated
> mailing list has been created to discuss brcm80211 specific
> development issues. Keeping the status as Supported although
> help in maintaining this driver is welcomed.
> 
> Cc: brcm80211@lists.linux.dev
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless.git, thanks.

e4ad71e2367f MAINTAINERS: wifi: brcm80211: cleanup entry

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240126105724.384063-1-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


