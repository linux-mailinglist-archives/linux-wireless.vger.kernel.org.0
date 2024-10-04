Return-Path: <linux-wireless+bounces-13500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02E990079
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 12:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0309B28464C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5514F9D5;
	Fri,  4 Oct 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFPjPb8V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B214F108;
	Fri,  4 Oct 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036213; cv=none; b=Q91F4HpcfXzIQSC+yGJUGQx9dRDCAxCkC5xo9YuNk3ny90voLj9aPU5yoxkcXHVFnkozrNM14H/Cdp7cSTUCevChA4TcynBnP4d+4boXeYTXww5+m8yru9sdTi8gWubwLceZD5Zn3mqhTvCOD63pXs3JnWXXzjcKYD1upOq3jjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036213; c=relaxed/simple;
	bh=/u/BTCA2RCcOV7Qrd+JkcQvXdbVt8hEgOqSwOK3/wqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dFrONPVuEWQpoJjs6UQ+RdeynTn/3Y1tPW5Hqn0o8+S5pFY/T3N5wmLgeI1KXwVBQ8IpJlxSKTgbQP1Qw0bvoLOzXxwR7uP0T/Wgz0WHPhlTKTsuAxfgw6oPGsS73X5+wdNEstkKZWNr/lolAfUvGLSrpGNE0osxablcepuoGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFPjPb8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB65C4CEC6;
	Fri,  4 Oct 2024 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728036212;
	bh=/u/BTCA2RCcOV7Qrd+JkcQvXdbVt8hEgOqSwOK3/wqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mFPjPb8VsyXMk+h0p1fcTGJzwq+WZb9ypQl/T73zLBp/S/BhmB8+ckK5XT6Hhty02
	 IjJOKlNwftij9QjF65y6wD/WWUwjm3DCS/egIKDUwGhNwRchB5ksPIIdSPPc0QIjIX
	 9WQ1sYXx5SzFnxJDMd64ZRH5OB/b6U9xBFtN9Lcwjz1alVJJjf/XHRZ3HN019F22tm
	 6EBwh1YcLeta+xUhql81NYtO4I1slXoLETvQbUrjs//NCIDy3kd2zgjerjVQoDnOIK
	 qhwADEjBA3WcQ0Z/ImNvAjHWvsdtdziykixudtZKHwEYlU4+G8NA3VFQhUjIvstmTd
	 QAL3aHngX2XQQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 04 Oct 2024 11:03:22 +0100
Subject: [PATCH RFC net 2/2] MAINTAINERS: Add headers and mailing list to
 UDP section
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-maint-net-hdrs-v1-2-41fd555aacc5@kernel.org>
References: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
In-Reply-To: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Add netdev mailing list and some more udp.h headers to the UDP section.
This is now more consistent with the TCP section.

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


