Return-Path: <linux-wireless+bounces-2167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AEB831861
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C961F2371C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DD623776;
	Thu, 18 Jan 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMfy/uiT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DE2376E
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576957; cv=none; b=HQPQrjuTRy1pXJCJfOf+zH8D80z2KGQhGg/UNnE0jQw3koBbR5rUZiPipclQ38RBzm52JJOGiq9rRs5WuiWOfbssnHVgMCRSSJnzxpfVfpx7Q6Pjy2ArQFSbrLxzW1GgMhSYtyXPEe/vX/q54ZrxoHJvD1Wo0xs7Kz7K/S19/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576957; c=relaxed/simple;
	bh=kJ1+f7gxO+YiffBwWp80CS+iQ2pr1dNPzRuJutrSncw=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=Rl2egGGqm2JBj7rX6/UVpYqWFDSZ3zL7+pvwYp2zTP37S3kDqbCidMpTZ11HNDQ5XDItbu+GuM/WoHv306bZQBVjVBxkU34Ee5wPW6VLVsxc+JHCulz2w/DO9HGizlZphcpEcROPEvzbhjcAUlCc+WC6nNt4j5RCRWwDHpKfqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMfy/uiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDCEC433F1;
	Thu, 18 Jan 2024 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705576956;
	bh=kJ1+f7gxO+YiffBwWp80CS+iQ2pr1dNPzRuJutrSncw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FMfy/uiT10fpLfocn9g1Q3dR6DKc1zcG2S+QTcMpqO9ZL+1nY0QAfqt96YTh7ZLSF
	 JDYuEmEd+3TlU1482LOFZeZ9h+yGPLFtGfDHVPIyTV8hU2ISbX4OEc1eBCzueSzMXr
	 NY7f0rS8SSIG3NkMpPrPhmbyzjUlSJdDhWn2QHtO5Bl5vewhISKuXN2epwoP1xGGl6
	 fDBMAVFPb3QIIhLiSjANwFcB8uIs5+trlgQ5qZCTZv8N8/5LKtO9kp7X1F7wocrn/1
	 n5fVPMorMrsoSMKFRs7OgQqMRqHUe7WljNjAHNy3GY3e5x7WsikYRis5nOM0k1wI9h
	 g0/yYXjuc/Fyg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] [v2] wifi: brcmfmac: handle possible completion
 timeouts
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230614075848.80536-1-dmantipov@yandex.ru>
References: <20230614075848.80536-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>,
 brcm80211-dev-list.pdl@broadcom.com, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557695372.2924528.2049717324928380180.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 11:22:35 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Handle possible 'wait_for_completion_timeout()' errors in
> 'brcmf_p2p_af_searching_channel()', 'brcmf_p2p_tx_action_frame()'
> and 'brcmf_p2p_del_vif()', adjust related code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This is not simple cleanup and I feel that these should be tested on a
real device.

2 patches set to Changes Requested.

13279707 [1/2,v2] wifi: brcmfmac: handle possible completion timeouts
13279708 [2/2,v2] wifi: brcmfmac: handle possible MSI enabling error

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230614075848.80536-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


