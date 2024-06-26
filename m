Return-Path: <linux-wireless+bounces-9616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCA8918A5A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 19:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0CA2841F1
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 17:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17BB18FC7C;
	Wed, 26 Jun 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIUejT+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997A2186E2A;
	Wed, 26 Jun 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424238; cv=none; b=e2z8T1+wZbHEa9TBXfq1YtbDYPKh/O1doWajrSH86hTEXaAv/x9C0BxgqINP8hzBn4aXk14cmnksMGHGlhfakIORqk6U1ZjApja2MS64BHgexkWpI0NsT4KeVDbHDK1Do82AW/F1PgMNi9zXI7uo2arfNoQY8+93UHE/AYRY35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424238; c=relaxed/simple;
	bh=noGhJ+IZiQzYlV4tMfhIrbP6akUn+3KbyMt6o9CALt0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=qIKMgiUjDtfoPhuukUD9KvG8iYC1DQlh/PsEJeRXQbRT6iJa0t8wUjg6MB0fBMegrUgnE3T7k5bCdGRfDv8B8Q/tuzYNEe8a4rznn2caTu4kGl77gCDr3MzXrYNjcovt6/N/E/iU1XwjyOBHaLeTfxeOOoBfmhaG8TYPlut5Axo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIUejT+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D13C32782;
	Wed, 26 Jun 2024 17:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719424238;
	bh=noGhJ+IZiQzYlV4tMfhIrbP6akUn+3KbyMt6o9CALt0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=sIUejT+HvERYs2iBIhNSnHfLRLplDLAWbv0Ytx/Zp4Ef6k1KKg57z/7ueWjMdk8JS
	 UPFj22NzmMebgz0TGU0naCdTh7KuYhQgBuWR2a0W2DQh8EycTUBUqsrVDNVYV7s+Hd
	 A/7p7pNSg0ofV8LoDZRwxJTLd3vSwvK0rsDajeZ6365eAwkyE5/TLTM7LUQuJAIssI
	 8RaDeTSXC0XGxTLPLMVXX3x8m9g7LkkxGGAaTsKW6bNH6rHTN06i3sWUNrSWfB01jA
	 lXLLrSizJeWJQSVrgPbka05QbS13INxhtPMDzr06/bBsiwgWJua22U3SBf6w8KCh0L
	 90GxpnfMLDlZQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
References: <20240617122609.349582-1-arend.vanspriel@broadcom.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Arend van Spriel <arend.vanspriel@broadcom.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171942423559.1834296.8112157805524148363.kvalo@kernel.org>
Date: Wed, 26 Jun 2024 17:50:37 +0000 (UTC)

Arend van Spriel <arend.vanspriel@broadcom.com> wrote:

> After being asked about support for WPA3 for BCM43224 chipset it
> was found that all it takes is setting the MFP_CAPABLE flag and
> mac80211 will take care of all that is needed [1].
> 
> Link: https://lore.kernel.org/linux-wireless/20200526155909.5807-2-Larry.Finger@lwfinger.net/ [1]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Tested-by: Reijer Boekhoff <reijerboekhoff@protonmail.com>

Patch applied to wireless-next.git, thanks.

dbb5265a5d7c wifi: brcmsmac: advertise MFP_CAPABLE to enable WPA3

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240617122609.349582-1-arend.vanspriel@broadcom.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


