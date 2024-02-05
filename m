Return-Path: <linux-wireless+bounces-3144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7984A1B6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 19:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3573F1C21315
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4FF482C8;
	Mon,  5 Feb 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE9dc9Zq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DFC482C7
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156055; cv=none; b=hk80qox2YR/H9szHNx7GC/rJjXhsUa5jt6ihIx0kzY+QYCZ2JSgOyJ5NUER8x0nV+tDzd5VoRzl516/6z9fSzSAxugy9VqEnlPcjG7eIe9rgTxePuqU563AIt0G6iHKBRjmJ+HTOLpmf+8N6TarGG+FzS6W1W3FZIhXsOpeSroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156055; c=relaxed/simple;
	bh=ySEGMClGdy98bAgA6qD71oGG3RNXa0AiFVa84mcbd+g=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Hl/I4CfELawrdRXb7sC9vyhc27dUPdRmEfpI7CGzOM1ZbihxX0rfq2qFbiYV5vRzPmaRhiIzP13dzl5z4pBXbSKvGy+B7l03bqHpmKXOqXdiFGDM5BbBRDdOtSxSIPtL9ExmCJ0m0vwxO38CghNv0OzSthvbTJH02D7oqLUIEAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE9dc9Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2EEC433C7;
	Mon,  5 Feb 2024 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707156054;
	bh=ySEGMClGdy98bAgA6qD71oGG3RNXa0AiFVa84mcbd+g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=lE9dc9Zqdd3muAO6g6iB6HWk6ICtVnJT2zzCRnjuGsQ5H64zTXCPdhA9FmL6bIyNx
	 ph8YDWjNnQhn1H6SjZ7F2tfh48S7HIemswGfcq0wO78YZS77m4CBhdYR74YZZM1WMy
	 KDk5+gurAhVhE5fthrASNRUQBL0fce9a27394IJ7EI8X37/21XoHSPaoDrIG27wjKi
	 U3f6yYegR2D/MXdAJVf2yLMM5BYcWiBehD70XwKY5id6wFuxWspLGpxEANpYQ1TNHb
	 FafRjfUS8txWmolEHrF1JV325a+eAa+2hzwZ8wfhPhy5T+98R3/DyK9RxG8EXPfqjV
	 U4t/ZDZBWjmgQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: mt7996: fix fortify warning
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240203132446.54790-1-nbd@nbd.name>
References: <20240203132446.54790-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715605239.1512817.11784063357420336430.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 18:00:54 +0000 (UTC)

Felix Fietkau <nbd@nbd.name> wrote:

> Copy cck and ofdm separately in order to avoid __read_overflow2_field
> warning.
> 
> Fixes: f75e4779d215 ("wifi: mt76: mt7996: add txpower setting support")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless.git, thanks.

0647903efbc8 wifi: mt76: mt7996: fix fortify warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240203132446.54790-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


