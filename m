Return-Path: <linux-wireless+bounces-13797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063449963BA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D281F21B32
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EAE189F41;
	Wed,  9 Oct 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULCsfG5p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB61898FC;
	Wed,  9 Oct 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463663; cv=none; b=RgbqGZeIIC0CxBrEPIGzGvzLZ1YhEo4hRnPqsCyvDsIMe/MO195XLcplLSnBBfakF5ph+7zde7l66LojrtYCEgv+H//9Xq2ysoXVtobSoMtB7ZvY30sFNtb5fK1sMEdVB/wxVFzP2uzqJa1oYtHvhTJF+rCi4SClxa/MC5Dqm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463663; c=relaxed/simple;
	bh=31+/Gr5Hh872ec0kd5KrNPTPKQ7X2rRUENhvrK5beSU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aUtp32s9IwqlMdR3+p7329Zu6oTmv1E6c754HWZTVLn4YXhARovB5fNZSv+ygCaAM2U0r1jSoI5G3ywfaPrh8qCAK/tS3TLT0AsJCmgIce/x4u7yNaTDnN5tYN3h9uCG0V/9PSJehJNKQV4bCBqx1cUmmsWmcsX9+1h97k9J7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULCsfG5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF936C4CEC5;
	Wed,  9 Oct 2024 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728463663;
	bh=31+/Gr5Hh872ec0kd5KrNPTPKQ7X2rRUENhvrK5beSU=;
	h=From:Subject:Date:To:Cc:From;
	b=ULCsfG5pmD+57N1jwdOhX/wAYT2OaINiooDlkzykm76qEWFfE6rXFHNtYTE/40Mjn
	 Ssr6RhptNv3yS+3OHwWvE8EY6lkzCrEyBQ+n89fOcQi6MTuu+YUyR8UN9w5mD780TE
	 BHG3dL+NDSx6+TS56V36+1GPOj15gxDkARC0mCx7McAoD3kBt4WOTrIvrB3ptDSbHj
	 ZoaviXhwRjihNksZfsi7DChyNnbaPed+Fav949zQlMyiDD2LQH95MzJ0sHyBcCLiOe
	 8rd5/kGesIqCWlk4GtDenU+lnOsAXRo34y6PrDNc6FydYHs7cp+NmIBSxzJwg0lwXH
	 kr83PJ4MbE5Zg==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 0/2] MAINTAINERS: Networking file coverage updates
Date: Wed, 09 Oct 2024 09:47:21 +0100
Message-Id: <20241009-maint-net-hdrs-v2-0-f2c86e7309c8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABlDBmcC/3WNTQ6CMBCFr0Jm7ZgWqAFX3sOwqO0AE7WQaUM0p
 He3Ye/y/X1vh0jCFOFa7SC0ceQlFFGfKnCzDRMh+6KhVnWrlWrxbTkkDJRw9hJx7EznH5eemr6
 BMlqFRv4cwDuUFgzFnDmmRb7HyaaP6B9v06iw1aM3xljrnLk9SQK9zotMMOScf5uGkg+yAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
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
Changes in v2:
- Dropped RFC designation
- Added tags: Thanks Willem and Johannes!
- Link to v1: https://lore.kernel.org/r/20241004-maint-net-hdrs-v1-0-41fd555aacc5@kernel.org

---
Simon Horman (2):
      MAINTAINERS: consistently exclude wireless files from NETWORKING [GENERAL]
      MAINTAINERS: Add headers and mailing list to UDP section

 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

base-commit: 08c8acc9d8f3f70d62dd928571368d5018206490


