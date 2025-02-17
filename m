Return-Path: <linux-wireless+bounces-19084-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA981A38FB8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC663ACE11
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00FD1A3A80;
	Mon, 17 Feb 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbBJnJ85"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39E7404E;
	Mon, 17 Feb 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739836022; cv=none; b=Uh1AYyy+S7STORUzlwUyKYttytLCFe/81d2N06UaQDQZKTRDWIgxXMBWpqr73HFjCAsJcgQqZiPvTDzdxI0kXA6ulcnWTrZJUc2UR/ElKQ+52NIR23quEespbkmJOVj7RiL7oB6CBR3hl89XILqcAsLBQ+AxOq9pUKYhoi4D9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739836022; c=relaxed/simple;
	bh=KtTFA6BxoMx2wTauDjB3MIJGMaVanSteNnBqy7zSKnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTOaM2ViBP07W5NNFdZjXrXcqeQZh4Fm/p/8gbmyAadkvVKFsC7Xm/0BnOnbvnVZNFIR5/SMA0GT+5faqmR6fXe3pYK31UBe4IjmXif8Mn6zWb/gmJl0K2lpHIJ+0OFijaLuzCj0tmZvZFtL0bpNO8zMmKBMvdcGhic3mQnF5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbBJnJ85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6985CC4CED1;
	Mon, 17 Feb 2025 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739836022;
	bh=KtTFA6BxoMx2wTauDjB3MIJGMaVanSteNnBqy7zSKnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qbBJnJ85+I82OYuJeWf6Ydzop158a+pw12JLnJ9gxr4USVUlpj8mQsTzfa8yZdzpe
	 Qa6E3w0Zlg5qQVfY5fn/c7iUCuc9yaoKcP3pfgbFvgtkGhg+rK7SQdn+G/5h0jwdxP
	 SUqtf899+tILoA8UvS/XgvmEWw4ml0W6y0rdHr4WiC+Xtfo5xzCikA7pSV6n+VvY7X
	 vHOsHZjCphmvc92crZZIpqo+sdHeVAOhgDp16tGLYO4sAaLt50k7xLmZFCQYiVmONi
	 I/2okhAlZDqyxOmW1AE7PRH9foK0LNfKRApayfG2dM6oNz8FrjmGyLonaAeh99O7ZW
	 wsk3TSufu9zQA==
Date: Mon, 17 Feb 2025 15:47:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>,
 Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-doc@vger.kernel.org, kuniyu@amazon.com, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net-next v4 0/3] netconsole: allow selection of egress
 interface via MAC address
Message-ID: <20250217154700.34616bd7@kernel.org>
In-Reply-To: <20250217-netconsole-v4-0-0c681cef71f1@purestorage.com>
References: <20250217-netconsole-v4-0-0c681cef71f1@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 00:18:43 -0700 Uday Shankar wrote:
> This series adds support for selecting a netconsole egress interface by
> specifying the MAC address (in place of the interface name) in the
> boot/module parameter.

Breno is submitting the first patch with a fix, please wait for it 
to appear in net-next then rebase and repost. It's probably going
to happen on Friday.
-- 
pw-bot: defer

