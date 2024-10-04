Return-Path: <linux-wireless+bounces-13498-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B40990073
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 12:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE47F1F24B90
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ACA14900B;
	Fri,  4 Oct 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyi9nyqg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C140146A72;
	Fri,  4 Oct 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036209; cv=none; b=dC8n8eNOxHyQ5fWIf426joT4qOr+HCgq3x2bSBPnG7fiIBeAfVe7mmxNEY/zl+9jmgOl1LoAbzArP8JR5w3idIxti07vAXv86uTfElEvWaXChDR6tyk4p7onU47zb1p4E9dJ/GgZ/aW/izJpzMNgKepwXebopFIIePFRrPJVVG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036209; c=relaxed/simple;
	bh=w8bWlQBTvkReQC5vkKIau+hsj+b10X/1li97V1B6tvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mtgxUxxJ3DiYS8196dxTF5enYNeu1iprEQmUg881+5WoqQU0W5YfdMwHI4PwPabV737ECQflkz5UyqNDQygfQP9UtZHW1FgI49LVUBsbMztpfdDedcfDRbdrlf7nkUh0XiyV6eUBjuL1HLlYzf/wAZhxwJ7iyol6qlJJyQ6FM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyi9nyqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C3C4CEC6;
	Fri,  4 Oct 2024 10:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728036208;
	bh=w8bWlQBTvkReQC5vkKIau+hsj+b10X/1li97V1B6tvo=;
	h=From:Subject:Date:To:Cc:From;
	b=gyi9nyqg+EMzDl2tNtN1yhFefNYCo6HbhJr2mjZJcUBgwZ0fTp4UE45YpId12nblT
	 A4Kk30NGKLqdJyeLC0C/fTJt8ocRpAEotRbNAFH+n9W3QC7Wx4DJsUsrqW3nRS2X0u
	 lhUA1FdDNAD9BfLox31troxtqVGeyfElsjpqzNVUtAw8uDA+86J39ufm2X0oUV9sFZ
	 vtsGhQwSBk0BYXmK77By4i2hkuPkJyfy0uUNL2WzbEeaTmE7y8UuNZYUY5rtbZkx3c
	 tZSQZSNG00bb/GaYuJNucJEcNaqOpw+m8t4W+R8OJhvfX46tHi39oj4UWfYq9Jgu8A
	 rfwIBJqQXku4A==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH RFC net 0/2] MAINTAINERS: Networking file coverage updates
Date: Fri, 04 Oct 2024 11:03:20 +0100
Message-Id: <20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGi9/2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwMT3dzEzLwS3bzUEt2MlKJi3TQLU4uUJDPLVGNLYyWgpoKi1LTMCrC
 B0UpBbs4KQJVKsbW1AMwe/RFpAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Hi,

The aim of this proposal is to make the handling of some files,
related to Networking and Wireless, more consistently. It does so by:

1. Adding some more headers to the UDP section, making it consistent
   with the TCP section.

2. Excluding some files relating to Wireless from NETWORKING [GENERAL],
   making their handling consistent with other files related to
   Wireless.

The aim of this is to make things more consistent.  And for MAINTAINERS
to better reflect the situation on the ground.  I am more than happy to
be told that the current state of affairs is fine. Or for other ideas to
be discussed.

---
Simon Horman (2):
      MAINTAINERS: consistently exclude wireless files from NETWORKING [GENERAL]
      MAINTAINERS: Add headers and mailing list to UDP section

 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

base-commit: 096c0fa42afa92b6ffa4e441c4c72a2f805c5a88


