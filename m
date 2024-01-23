Return-Path: <linux-wireless+bounces-2376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F75E838DB6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 12:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4F5B2140F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6D50268;
	Tue, 23 Jan 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I24y5Ieh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640054BAA8
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010237; cv=none; b=KhUnozSg9fQn6GlInkCuv1cY/cGjHP67ktKNFRkPSUdFz1bqV5DPKIF6QI3yO2IZKLS5SZrdXYFZ+NIFw+k+hSDV/7ThCj3ubUr4ATqWOQp+f3YUYjsTvlQglwGMaX/3Ksz9S1BhWLE/KxRToAcUfYrkwgCGNvNq4IBNTlscJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010237; c=relaxed/simple;
	bh=s0V7GHpf63yU5Ahp+XUdiMpFDwH86KbmA1WqyxH7ONk=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Y4syEaxmdKDLr5Bl640yF5p92AlC3umrmockR+MQh+xSS62zj2keAFBkIDqUEQOgjG5AIszraje5/Vk29Scnrc5i3JzB2yilpCFezjuWxbkH9aZcOAvN18NZgOApQCrWNWxb4PEXDlTVhU16ksv6pqSCmXigTxoXvLukrJPzP8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I24y5Ieh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA311C433F1;
	Tue, 23 Jan 2024 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706010236;
	bh=s0V7GHpf63yU5Ahp+XUdiMpFDwH86KbmA1WqyxH7ONk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=I24y5IehZV2AjLdoAoHeOnK6JG2SfhN/Pr6t4JWr9KgsJFfmOCPR2Hyn0VsJ7mDmo
	 hKhZ1uYyV51iX3Xd6dpkYtWx08wGLhNAk/f/oPzcm3wHbCmznG3zOV4jpF83J26Ye3
	 gkByebHt/oUOFVyPSFfvOefIlp3uFRDHlLxRQ2QZVSNcjJE6SeVE2YfqMiCeidIWSi
	 1T1As7FA1VTxm4fDC4z5tm+U9F51eTBUvY41vhJdfjaqGJE2BBe0Yq44eDtotkylVv
	 GV97vDQzH5WxW0fHMwHh4FWbzghZmr0O452GJCGCWjWBqmJfuzwPqeVpQlBmYTS5ss
	 C1fercHecGPtQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: mwifiex: cleanup SSID-related data types
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240118145715.475513-1-dmantipov@yandex.ru>
References: <20240118145715.475513-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Brian Norris <briannorris@chromium.org>, David Lin <yu-hao.lin@nxp.com>,
 linux-wireless@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170601023387.3962299.2804573379810764117.kvalo@kernel.org>
Date: Tue, 23 Jan 2024 11:43:55 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Drop unused 'struct mwifiex_ssid_bssid' and replace custom
> 'struct mwifiex_802_11_ssid' with generic 'struct cfg80211_ssid'
> as a member of 'struct mwifiex_uap_bss_param'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

The commit message should also explain _why_ this change is safe. I have
no idea if you just randomly changed this or there was a proper
analysis. For example, there are changes in length field and if the
firmware uses this struct there will be problems.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240118145715.475513-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


