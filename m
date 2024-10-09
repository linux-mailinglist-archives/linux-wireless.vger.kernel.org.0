Return-Path: <linux-wireless+bounces-13799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F449963D0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35271F22A2D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15EF18FDBA;
	Wed,  9 Oct 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYLF9OLW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D51898FC;
	Wed,  9 Oct 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463675; cv=none; b=ardqR48yO278A/W22VK6pr9tOE9P+OhtgGK2pGH0DtD0EyFKdm/qUkT8SS2cZMYg71rk8qMQ6fUqVANYaoOjQ/iGA3E25/8P7w9bk31BBhQMhLQ9MmQveqezcrunfvAau07NKv74VSbE+961M2iMx+dUpfNgQ3DDfuj63nrtbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463675; c=relaxed/simple;
	bh=G0P6RiNBpslu3+oBLFbdqikIby7XuwXzQ6/LxRVfw4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9Pl7FLn7kkcF48aXvM36N3CRe/57Ub8HmhMkXSZt5EE6vRT2/a7bDLhCqjDbkI0Zwa8RnPqacWnmBEUGyzV94zeoNanb/8+J9h+Ear6ZojXjryQK/p3gghs+PSjVvKEv6J8Pd8GMvSncpoNBTZJNb4Bvm7+7/k2F5dI0kveHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYLF9OLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB1C4CED1;
	Wed,  9 Oct 2024 08:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728463675;
	bh=G0P6RiNBpslu3+oBLFbdqikIby7XuwXzQ6/LxRVfw4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYLF9OLWvdUGjEZmuY58CYHfT4bZkNm4c06NZNZLePWA1vn32kclrvK9A8uSLXsuw
	 fwzF52eANhtkEGqqjZo+a70z8PEqYyPt+drnkBem1qYhSXbwbtdfb1nfteo8Z3SkhP
	 R6xKWQOku1+32HxCG6JoCidStp3jI3q92m7mrIw3kMNfab/JIHSHqYZn9yCqUnIUuC
	 tw7i04u+Noi2X9QwiZzV1/FOEProwpPRiMeKQMYQvgYXp6muZW72A3f+hY5KfdryvF
	 shiM5cfanwcaGrNn1Ngodj2WAsNE57QZ6fgjFjliy/eO6DQf+LFWuKQtuLm2bb9hL/
	 XPGdt+/MiWVPQ==
From: Simon Horman <horms@kernel.org>
Date: Wed, 09 Oct 2024 09:47:23 +0100
Subject: [PATCH net v2 2/2] MAINTAINERS: Add headers and mailing list to
 UDP section
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-maint-net-hdrs-v2-2-f2c86e7309c8@kernel.org>
References: <20241009-maint-net-hdrs-v2-0-f2c86e7309c8@kernel.org>
In-Reply-To: <20241009-maint-net-hdrs-v2-0-f2c86e7309c8@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.0

Add netdev mailing list and some more udp.h headers to the UDP section.
This is now more consistent with the TCP section.

Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3ea2c0d3fa..1ce8c86cdbaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24184,8 +24184,12 @@ F:	drivers/usb/host/xhci*
 
 USER DATAGRAM PROTOCOL (UDP)
 M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
+L:	netdev@vger.kernel.org
 S:	Maintained
 F:	include/linux/udp.h
+F:	include/net/udp.h
+F:	include/trace/events/udp.h
+F:	include/uapi/linux/udp.h
 F:	net/ipv4/udp.c
 F:	net/ipv6/udp.c
 

-- 
2.45.2


