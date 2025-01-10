Return-Path: <linux-wireless+bounces-17326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C999A091A6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 14:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECC63ABD30
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0E620E325;
	Fri, 10 Jan 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY409uwi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6520E320;
	Fri, 10 Jan 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736514878; cv=none; b=VECKnCqwEUAd33Pj+iNDXmmF79XYFSzz7OTKai2DiY3j4SQ6mvM03OekANY0UdITCXw3Jxwsh744kE3FUSBu175DNm98sxjPmVEf95JQh3W3A2MfaaTdTfGldt3fNbdDBHcAv+XhqUtrL9mHq1u5HZtG//3snGGYxYTtA1yJXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736514878; c=relaxed/simple;
	bh=DSLKVv/krrAdDin6xUFCag3f6iFvd8LlMR3JZIo5N+Y=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=KqnwZUmtQO5aCbfGHBXsYjGuQN1s4n+QX+pj090ke8tnNQUJ+OIRjtgMC3Sr7PqWCpOQqEEyvMuevrukZiBAyHdLBM+xiXbmKy4Sl+GF6dZsgZ6HOKBfU06eRGiEQVPYyPSmafLzNyxMyFSUG2VDpE6dyXJOZP0+KpyJpSfHbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY409uwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CD1C4CED6;
	Fri, 10 Jan 2025 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736514877;
	bh=DSLKVv/krrAdDin6xUFCag3f6iFvd8LlMR3JZIo5N+Y=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LY409uwi22GKjJKIPTiWkdo6+IZY6y3C5tPYzMZBQoK0q59gmxoMZfe5R2G7cqoQ0
	 izYNMIWo/h9XfCuYfUcT/xVBo3KHZMM0SpzLM6D1yYo/6ByMOSQ7MEV84D5IOjVrqO
	 3UvMMu1Udfb3tcRgOMsE2YXCfJ1pGIdi09DJVGA6m+dPtYJZPytuJh8u1gNKm6G+gF
	 GuPJKrNrQjy+nN88cTMXokTshtZwwEJzF8F4HMZdQW9U8uCHA4F51MoPvDgEO57FyH
	 lap4RrH/iCiPF6rNz60am8rk+B4264EWuvMTAHC4s9IvpNYVlnOiPYQbCkpbFXoq3l
	 4sRaMapysvLIg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Add missing Return: to function
 documentation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250106-brcmfmac-kdoc-v1-1-ed72196e21a1@oss.qualcomm.com>
References: <20250106-brcmfmac-kdoc-v1-1-ed72196e21a1@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173651487482.72755.16429721895960725368.kvalo@kernel.org>
Date: Fri, 10 Jan 2025 13:14:36 +0000 (UTC)

Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:

> Running 'scripts/kernel-doc -Wall -Werror -none' flagged the following
> kernel-doc issues:
> 
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:823: warning: No description found for return value of 'brcmf_apsta_add_vif'
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:907: warning: No description found for return value of 'brcmf_mon_add_vif'
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:7419: warning: No description found for return value of 'brcmf_setup_ifmodes'
> 
> Add the missing 'Return:' tags to the kernel-doc of these functions.
> 
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Patch applied to wireless-next.git, thanks.

8221712a174a wifi: brcmfmac: Add missing Return: to function documentation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250106-brcmfmac-kdoc-v1-1-ed72196e21a1@oss.qualcomm.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


