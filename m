Return-Path: <linux-wireless+bounces-14023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5B99FD17
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 02:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2701F244B3
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 00:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41530B641;
	Wed, 16 Oct 2024 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT0mHu/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3AB21E3D8;
	Wed, 16 Oct 2024 00:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038341; cv=none; b=IAVIniYY7+m/jKbMGlRI4NNASqyy5B8G4/FlaUuR3hAIdHtnvYeGilPGuji6YkNEN3645wQZwmde4Y604a9IMLh7aL4RC6W7ksHOa1yyKWglVeBXY6Y7e6usfFKtGUNg9Z8mlITpT20gR/yjaJZIj6ZLkGmFvIQX5VKJO2IK3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038341; c=relaxed/simple;
	bh=4tkLvYTJB2i9PrvH5uF6H6W5HXbiZmsTQ4xDNwK2hpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UunA41yVQOiifYAnelyT0uLJihx1hmxNdqXbXVIGS20X6a0N0IuvUgWqo6g1E+DCyiNrsvxuaR96F5dqxs5IZR3dGzauxmAs+jc0r+BkpxpbfwEvER0jAvvZSjuHPxtc5PG2cempmW6q81IZAhcRxt0TuYm0i5yIMeJWNs3sezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT0mHu/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5858BC4CEC6;
	Wed, 16 Oct 2024 00:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729038340;
	bh=4tkLvYTJB2i9PrvH5uF6H6W5HXbiZmsTQ4xDNwK2hpg=;
	h=Date:From:To:Cc:Subject:From;
	b=kT0mHu/SDGeeOejIZF+IY7/OqtYCEzec1nSfOoZRxASLE/uUj8LkBRjrEno9xUv1S
	 5QWHlBjQcgqATX/NhcSviz+QhQMitwM2CNPcEK77A+JGxzzJCPP8VQCiHPC9V7t1fr
	 LqoZUIwtG8VfRoURazf1VBAXm4P+fliO17Bv62LBBkPk6mr00deCKY/1HfdDbwEn/S
	 KAnyNd7q9mLDZDg4GZuCvOPKiu0cEP7o7vgL7sT7+445/IL1OvT6rM/u+bUi2D62+r
	 ZDuZmNvfyES50UebmzxJmfUkztIz6ZIH/gSQw/PbJdew+N8DI9b7bL5n57zZH/9726
	 TiTxr7BOn1p9A==
Date: Tue, 15 Oct 2024 18:25:37 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: [PATCH 0/5][next] net: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <cover.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series aims to resolve thousands of -Wflex-array-member-not-at-end
warnings by introducing `struct sockaddr_legacy`. The intention is to use
it to replace the type of several struct members in the middle of composite
structures, currently of type `struct sockaddr`.

These middle struct members are currently causing thousands of warnings
because `struct sockaddr` contains a flexible-array member, introduced
by commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible array in
struct sockaddR").

The new `struct sockaddr_legacy` doesn't include a flexible-array
member, making it suitable for use as the type of middle members
in composite structs that don't really require the flexible-array
member in `struct sockaddr`, thus avoiding -Wflex-array-member-not-at-end
warnings.

Gustavo A. R. Silva (5):
  net: dev: Introduce struct sockaddr_legacy
  nfsd: avoid -Wflex-array-member-not-at-end warnings
  uapi: wireless: Avoid -Wflex-array-member-not-at-end warnings
  uapi: net: arp: Avoid -Wflex-array-member-not-at-end warnings
  uapi: net: Avoid -Wflex-array-member-not-at-end warnings

 fs/nfsd/nfsctl.c              |  4 +--
 fs/nfsd/nfsd.h                |  4 +--
 include/linux/socket.h        | 19 +++++++++++++
 include/net/compat.h          | 30 ++++++++++-----------
 include/uapi/linux/if_arp.h   | 18 ++++++-------
 include/uapi/linux/route.h    | 28 ++++++++++----------
 include/uapi/linux/wireless.h | 50 +++++++++++++++++------------------
 net/appletalk/ddp.c           |  2 +-
 net/ipv4/af_inet.c            |  2 +-
 net/ipv4/arp.c                |  2 +-
 net/ipv4/fib_frontend.c       |  2 +-
 11 files changed, 90 insertions(+), 71 deletions(-)

-- 
2.34.1


