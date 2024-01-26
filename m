Return-Path: <linux-wireless+bounces-2512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1F383D417
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 07:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C9BB240C8
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 06:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E4BE7D;
	Fri, 26 Jan 2024 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEsZSgps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497AD2FF;
	Fri, 26 Jan 2024 06:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706248877; cv=none; b=Ji3R3Tkyu9u7PHS2P8LXXIE+sVDQx0fLSvG/H5Hd6oID6oBdg9g8M/Y/Jkh7piRAuwW3bpWKEfOf4wLLqIMqEos43/dP6ryBapqGzDiDk8liZgJhg/0rpxniiUMMeqkXgLqFTRfU980zIMWn+KF0yzNLBPBAl9eI1nUoU9H1o0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706248877; c=relaxed/simple;
	bh=WvRQN6apuTFdmllfWsGSib4xTmlTxxmL797lDKQp9ys=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=tTYvNIU2RzcTiO/YQEYPOaSqLZ/L3MqEM8N3KQM9Jb6MW08Fybb9/SYJ0LbrIJGomxb1rM3NnNwudepiIzsuTe74cEX+OzMftydfcctGw1xCEVOe7BWfiKPaCSlRZVHkueuqT/i/ZGNRi9GKPNZNKuWdA4jrXV018wj4jY3Uh5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEsZSgps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2194CC433F1;
	Fri, 26 Jan 2024 06:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706248877;
	bh=WvRQN6apuTFdmllfWsGSib4xTmlTxxmL797lDKQp9ys=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FEsZSgpss8BlqvPcClEtcMUWS6iCG9AEJh0B/YOV95p0qSvhINOWoRMyHKTQygpm7
	 zAqn+iQf9WyJfd9HLa3AD41A/cyyJTzSkHKcxB74MOH8BG+4p7CP4KNf0sTfatUzBU
	 jie+u7K0SjvEWtGxIs2KLM33wxh/aANjkVl8vJPkMPYFR0SIkJbtRnX5vpM3jRzjk6
	 5rklBIrsjGgPNShactkUgSuQFlbxM/d1yKhjQfvlnqyQZd7SE4utYcuKlaxig50dM9
	 Wd+6R7Dsnf/DGiBEFUonCOI7Jh7cI3pee2JpkYmfLJhJr7e82J7JAbhvrsvMFHxaqG
	 kTuQSzybtUPHg==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
  netdev@vger.kernel.org,  linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-01-25
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
	<20240125165128.7e43a1f3@kernel.org>
Date: Fri, 26 Jan 2024 08:01:13 +0200
In-Reply-To: <20240125165128.7e43a1f3@kernel.org> (Jakub Kicinski's message of
	"Thu, 25 Jan 2024 16:51:28 -0800")
Message-ID: <87r0i4zl92.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 25 Jan 2024 10:40:30 +0000 (UTC) Kalle Valo wrote:
>> The first "new features" pull request for v6.9. We have only driver
>> changes this time and most of them are for Realtek drivers. Really
>> nice to see activity in Broadcom drivers again.
>
> minor thing for a follow up:
>
> drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c:432:49:
> warning: no newline at end of file

Oh, sorry about that. Any tips how to detect this?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

