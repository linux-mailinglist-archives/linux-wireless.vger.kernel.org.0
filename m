Return-Path: <linux-wireless+bounces-17556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725CAA12741
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7B03A0F6A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F621482F2;
	Wed, 15 Jan 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbfSIwbR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7871474A0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954438; cv=none; b=Z5W+r9n+oNDulVdAKke8NpsvFVPCV4eYz01vJ2fd2Y2dE1rDsoDC3KpcTtWnhz2/k56CrzbybEqsa3XOXtwqc79EoGOUCpxzmOGhlGjOW7OK5EmCjYDZttVqI3zzg3o5qNU/J8Oq/3eJ0M2jpNiyLFKCNkPDV5cHq5KC9gIhsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954438; c=relaxed/simple;
	bh=PUqi2mYiOsvUxGydZKl6eg7gBFeLAdEd4l5RUfdOoMM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Iq5IkSsR1Wa2ETR++XvptkWWn2nhGCyB26W0JhnG1f5B3qPPSxiByenW41MReNzyoJNRDN7GdQDm1CD2nFlaoFM4bnncNzF8GgP13ZatxlXpSZFQcWjop4VItTtB3IukWmWh+eOQ0YgkPmdXRqwOv4PP5MssebLLcK44JmCzTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbfSIwbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD4C4CED1;
	Wed, 15 Jan 2025 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736954437;
	bh=PUqi2mYiOsvUxGydZKl6eg7gBFeLAdEd4l5RUfdOoMM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=pbfSIwbRCTCJ5fuP119eBKqeRUTLRdsv1B1Sp3sNphvkigFHd3k7j6i1WyYpx9eE/
	 35+fH6RuQWH3eO3nulnMf/UuLr+bXwfnqkyDQsct05aEx3ZwCMcFnyhyL1omZRloZs
	 7ickMwH9J8p1EsWiF784X8q7hfEfIDVK55NwDMKi9YKsJphhXxrC17pVScvQR7CeFw
	 S5YvUizwXR1SQIPFCdZcKoKchfveZBFdn8DEmF7tHCE41ANEwVKGUBwOxYpAC4HZMk
	 GLCFq5XwuE83+3TL/bL3UqOrsEhyvM0xDOZza7XDPRHDn8PFgFzqaR7F0S3j4EQSoX
	 qTjH6EaiQ8dLA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull-request: rtw-next-2025-01-12
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <b02292db-3d80-49d9-a95f-1d70c0af5321@RTEXMBS04.realtek.com.tw>
References: <b02292db-3d80-49d9-a95f-1d70c0af5321@RTEXMBS04.realtek.com.tw>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173695443509.512722.511740507600045269.kvalo@kernel.org>
Date: Wed, 15 Jan 2025 15:20:36 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Hi,
> 
> A pull-request of rtw-next to wireless-next tree, more info below. Please
> let me know if any problems.
> 
> Thanks
> Ping-Ke

Pulled, thanks.

80524ab28457 Merge tag 'rtw-next-2025-01-12' of https://github.com/pkshih/rtw

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/b02292db-3d80-49d9-a95f-1d70c0af5321@RTEXMBS04.realtek.com.tw/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


