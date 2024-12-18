Return-Path: <linux-wireless+bounces-16551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260A9F6CDF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473F77A3633
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D51FA173;
	Wed, 18 Dec 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArTpIMQ9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196F1AA1DC;
	Wed, 18 Dec 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545120; cv=none; b=SeodENIGjCAI3X1DJkI//6v3z7DG7A4/1mG58z+dpsVp9MqewOuDWDrwcu7Rm2u682GW1e4NQNeJiw/Wb1U6kqgQtoImmxWyQy0Ayww+7u8vUYnlewlzcXSw0gVP6dPz7ELmYQEPh7k1Jgp5vFpa6QOjlLcS1bmnILMbM3NfQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545120; c=relaxed/simple;
	bh=eHkMxHjGjG2Kuus0FshQo8hRSzlZwge9QyKCkd5b0Ds=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=evd6EhuG0wwsTkl+23dYrgVfZb1mxDitXJ7igCsMrm2AYGBI3jpPxgmZh8UDOVAOQ8/4zXDmYBWq9z8Sd08IgX1NS1HRUtk5MuhGzxAilK8Wq05nZU352YGZpBnhKVVakRCfjRpA3yUn9XGHrQ2ElSuTsXE+yRrJaA8Ogy6fk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArTpIMQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581E0C4CECD;
	Wed, 18 Dec 2024 18:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734545118;
	bh=eHkMxHjGjG2Kuus0FshQo8hRSzlZwge9QyKCkd5b0Ds=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ArTpIMQ9AxT91JONTrzn7V3b4sipa8OphJmm8llr5ctwtXqgLHWg5iFm3cBxKjRyB
	 9Vq3/4+wRqtPeLcHvTnf18v204fAq2D6Zjy14/BRh5O3R1TZHWAYGCJXe1Xy7e9l9l
	 3J0APBGyyhHVGigFy/VvQVtqHO/v2993QOPcJfj0mZMBf17ukD2GxAEx9JAKcTnlJF
	 uDLbP4UT5hzD+EpCb+oHOtr+H2S9zFAu781bL2CkAnes99c3Dr3Sa8REQXpsOfdBH6
	 c6x7QEOkF2YBoN3MUvwpeJ6CAX5AQNRstVwEnamehkKSNGcYVvfzH7eETzgvrCBd3n
	 czLQc7aZr1M+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,3/5] wifi: wlcore: sysfs: constify 'struct
 bin_attribute'
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20241216-sysfs-const-bin_attr-net-v1-3-ec460b91f274@weissschuh.net>
References: 
 <20241216-sysfs-const-bin_attr-net-v1-3-ec460b91f274@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shahed Shaikh <shshaikh@marvell.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, =?utf-8?q?Th?=
	=?utf-8?q?omas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173454511264.1439980.13534594940396187657.kvalo@kernel.org>
Date: Wed, 18 Dec 2024 18:05:14 +0000 (UTC)

Thomas Weißschuh <linux@weissschuh.net> wrote:

> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Patch applied to wireless-next.git, thanks.

8ab3bf476413 wifi: wlcore: sysfs: constify 'struct bin_attribute'

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241216-sysfs-const-bin_attr-net-v1-3-ec460b91f274@weissschuh.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


