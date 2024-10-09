Return-Path: <linux-wireless+bounces-13798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF79963C5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E95287DA0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C018EFEB;
	Wed,  9 Oct 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbbWOOrm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F21898FC;
	Wed,  9 Oct 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463667; cv=none; b=K1qTn0jfdaWrwTfAomk3OOvQA2NUq60ahr3EOkgnKgFhpQWLuciVq2uZi1SlHNmR/u/wQZMeDTf9BHnDLCWhTXnjWL6d0JBRVoxE7u1eGiAo2OsGKgkP1T5Hjau8Rt6FB3jm1l/eBTGGdbsHxCDypxnjiYBpm/nUqn9LdfPih5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463667; c=relaxed/simple;
	bh=3GkFx057SDb38VlHFTVBAFnu4RYRBKVa0vtcqxib+l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uLWTBhI7IudLRJP1s2HuohklBvvfqoMh+jKYfL5k5OfJ0P9gfr61JpDIwzYhD65MoZLgVxUyi0p4/+u66wEo5DNCJd0MHTsIBB77YaHMf+g3heooN4jtgHlImgzq10zEk8WNAirTTCv1n7wed/OYP4AkVRan7wzP3Jh+FKlOejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbbWOOrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5941AC4AF09;
	Wed,  9 Oct 2024 08:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728463666;
	bh=3GkFx057SDb38VlHFTVBAFnu4RYRBKVa0vtcqxib+l8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sbbWOOrm+KrtfO/DCXuXa1BN9ZNkstCKpYZXknhXVijIvxF0nHa8DTchQ+0Rt+E6g
	 X1WsEI1D4ZV+qoJUhOgqFN/dk1xulgoyxbZtAfQxoCv9gwiiZoRtBgrliKtq2LfHmx
	 tsdMwDy5bd0DtcH3RT+AaSiF+05a+UW0mFP8nhdu3FByChV2lFuH7VUPSyqq/3u0p4
	 8+Zc+pQLjUFnADp88MsDR7ScsF7MXSa6PDq0PUZgYbotqatv4gO7GOxwoc2efofSON
	 viQvigZod/xTd0ewJdEAQDe9F5Duzm+9Hfh77c9OQKffgz+hxJXRAtTDr4NL1AyD5w
	 7d0QAh8ViUcPw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 09 Oct 2024 09:47:22 +0100
Subject: [PATCH net v2 1/2] MAINTAINERS: consistently exclude wireless
 files from NETWORKING [GENERAL]
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-maint-net-hdrs-v2-1-f2c86e7309c8@kernel.org>
References: <20241009-maint-net-hdrs-v2-0-f2c86e7309c8@kernel.org>
In-Reply-To: <20241009-maint-net-hdrs-v2-0-f2c86e7309c8@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.0

We already exclude wireless drivers from the netdev@ traffic, to
delegate it to linux-wireless@, and avoid overwhelming netdev@.

Many of the following wireless-related sections MAINTAINERS
are already not included in the NETWORKING [GENERAL] section.
For consistency, exclude those that are.

* 802.11 (including CFG80211/NL80211)
* MAC80211
* RFKILL

Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..ea3ea2c0d3fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16197,8 +16197,19 @@ F:	lib/random32.c
 F:	net/
 F:	tools/net/
 F:	tools/testing/selftests/net/
+X:	Documentation/networking/mac80211-injection.rst
+X:	Documentation/networking/mac80211_hwsim/
+X:	Documentation/networking/regulatory.rst
+X:	include/net/cfg80211.h
+X:	include/net/ieee80211_radiotap.h
+X:	include/net/iw_handler.h
+X:	include/net/mac80211.h
+X:	include/net/wext.h
 X:	net/9p/
 X:	net/bluetooth/
+X:	net/mac80211/
+X:	net/rfkill/
+X:	net/wireless/
 
 NETWORKING [IPSEC]
 M:	Steffen Klassert <steffen.klassert@secunet.com>

-- 
2.45.2


