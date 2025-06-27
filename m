Return-Path: <linux-wireless+bounces-24636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48289AEC294
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Jun 2025 00:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F02A1C45155
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44128D8CF;
	Fri, 27 Jun 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeVBI21d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03EF14F9D6;
	Fri, 27 Jun 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751062787; cv=none; b=J4sZ/GMM5O2O4SsqR99cdiwfHCjdD/aQ730UDD1pBwdGNyEDbyo8v/IP37IQrx/KMZ71J3guIqHiJi9u9LPfrhbbVxNRbYJzU5FqJz06Wnds+nnmI61pRajH4YWHLY3Hlwi0/rjPOlWHSAHu8XlSegknnr3BGYZ+opstgVoYUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751062787; c=relaxed/simple;
	bh=N0V4BZdMH/VMOZWlTiUnUi2RLPy+t6c7H7VRP1hkvI4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pvvg1sA15DdHU1oTEzJOwMD6sVruAtxMD6ctob0Ue/kILa203NJK414/AXfSwq/+EhO79nf5I5Hhv1vdHHqI3gNioRXrp6zZP35AIHanR8BjemgZdFzBGK6o7lwYsFciPN0Ez1LUrZ0azNIDlcLNXatgd5HxbQLFoqQmvTEzReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeVBI21d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49578C4CEE3;
	Fri, 27 Jun 2025 22:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751062787;
	bh=N0V4BZdMH/VMOZWlTiUnUi2RLPy+t6c7H7VRP1hkvI4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TeVBI21dhl1/DYXVMMVKW2B705RhlpboV6f4DisDbPbjiTsap8ypete8NTP5D4fec
	 pzvE+wXwp/Xm302YK9sP3ZJ+WAn20UiKglAwi/eAfO5BrBX1YBGe6xbt1NhzUO50fP
	 p9oIAFBcIk1ONe4Smm4GRmG/id1OvEoRFXKKVw/AZ0YhugVKHL/ub6/5vCzdafl10V
	 x22tJi6dzPbpsrmbVS5zoGNYtVOq428UeFc705zAGJoG4RCRe7rpUn1pHE/d/jr5oS
	 /C9aBmRP3RcfHvVR/RB9wYfPBRPdXZgwABvdkXdoZnivnunjpcSOH8rVUjzluDqFtP
	 cFr1fiazE3ZXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA238111CE;
	Fri, 27 Jun 2025 22:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] NFC: trf7970a: Add option to reduce antenna gain
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106281324.2076129.2162106005861598496.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:20:13 +0000
References: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20250626141242.3749958-1-paul.geurts@prodrive-technologies.com>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: mgreer@animalcreek.com, krzk@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, conor+dt@kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, martijn.de.gouw@prodrive-technologies.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 16:12:40 +0200 you wrote:
> The TRF7970a device is sensitive to RF disturbances, which can make it
> hard to pass some EMC immunity tests. By reducing the RX antenna gain,
> the device becomes less sensitive to EMC disturbances, as a trade-off
> against antenna performance.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net/nfc: ti,trf7970a: Add ti,rx-gain-reduction-db option
    https://git.kernel.org/netdev/net-next/c/2bee162a28fb
  - [v3,2/2] NFC: trf7970a: Create device-tree parameter for RX gain reduction
    https://git.kernel.org/netdev/net-next/c/5d69351820ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



