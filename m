Return-Path: <linux-wireless+bounces-14024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7BC99FD1B
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 02:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8BCB23246
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 00:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5EEB641;
	Wed, 16 Oct 2024 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVnUjrir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7221E3BE;
	Wed, 16 Oct 2024 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038440; cv=none; b=AXda3WNdYv5PDeGcAk64HZ3nlc6FMTyIesACNHAmURYvf14bDdUO3C10K9OejfOMXXqJRgZ3zpN/4FC8nm5gNv7Xz8VN89H3es/Jt1BWoumRGJN7C5SfFA8U/DwXaPlgZCzer4tlSQpneBqAyUz0gj2DeBgik7o9fPEvTpYmdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038440; c=relaxed/simple;
	bh=tb27nyjCDeyfMIeUU/H/vPrhrpUAIwTNDYMgKdWPE/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6BveyD+Bqv1iNj+myTSlS7qRkMy9QTwqeUp0pxgL5XPxNNSy6caB/371irePsBePQ9gpnEC9lrWo/Wofd93IPL9jmLPkuP7B3364vxRZNuIUfHYwfTwJhft7qztFhWr2mDMTmpSgIi0IXy7dCaOE9WR/Ag31VgFWeFlNBc7ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVnUjrir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A437CC4CEC6;
	Wed, 16 Oct 2024 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729038440;
	bh=tb27nyjCDeyfMIeUU/H/vPrhrpUAIwTNDYMgKdWPE/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVnUjrirJfI0CQ6PbgD9SsPhu0EYkLRiy6T4LvhzCGWDRwlT6ZNBIiDhA15ejC1GS
	 CaqTLPLzonrxQV+iQPTJETIShHv6gKfo6dHHoz/CFDkAuHriwUkm3PFQCjQBYw6zKm
	 8oP7yjcUVwyTRarcEYaMLCt70EJmi+kMvaQzAFXjhdSOLLggBWSQgkj/ga1wDuRLc0
	 3gvd8h6ZNn/vQhwwuow4w1prgNmxpfIPUT+/zlPMPkXf9GQuZ12B9MoLBHjzt1l+qf
	 h769qvKrVGqmZCMDzsgVf9Q7TQu8R5kNNDUptV1KTs7eeiBfGVAUEYRlri4rDGnL1H
	 EEt2NmRME0thQ==
Date: Tue, 15 Oct 2024 18:27:16 -0600
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
Subject: [PATCH 1/5][next] net: dev: Introduce struct sockaddr_legacy
Message-ID: <1c12601bea3e9c18da6adc106bfcf5b7569e5dfb.1729037131.git.gustavoars@kernel.org>
References: <cover.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729037131.git.gustavoars@kernel.org>

We are currently working on enabling the -Wflex-array-member-not-at-end
compiler option. This option has helped us detect several objects of
the type `struct sockaddr` that appear in the middle of composite
structures like `struct rtentry`, `struct compat_rtentry`, and others:

include/uapi/linux/wireless.h:751:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:776:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:833:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:857:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/wireless.h:864:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/nfsd.h:74:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
fs/nfsd/nfsd.h:75:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

In order to fix the warnings above, we introduce `struct sockaddr_legacy`.
The intention is to use it to replace the type of several struct members
in the middle of composite structures, currently of type `struct sockaddr`.

These middle struct members are currently causing thousands of warnings
because `struct sockaddr` contains a flexible-array member, introduced
by commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible array in
struct sockaddr").

The new `struct sockaddr_legacy` doesn't include a flexible-array
member, making it suitable for use as the type of middle members
in composite structs that don't really require the flexible-array
member in `struct sockaddr`, thus avoiding -Wflex-array-member-not-at-end
warnings.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/linux/socket.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index d18cc47e89bd..f370ae0e6c82 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -40,6 +40,25 @@ struct sockaddr {
 	};
 };
 
+/*
+ * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
+ * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
+ * array in struct sockaddR") due to the fact that "One of the worst offenders
+ * of "fake flexible arrays" is struct sockaddr". This means that the original
+ * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
+ * flexible-array member was introduced.
+ *
+ * This caused several flexible-array-in-the-middle issues:
+ * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-array-member-not-at-end
+ *
+ * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances where
+ * objects of this type do not appear at the end of composite structures.
+ */
+struct sockaddr_legacy {
+	sa_family_t	sa_family;	/* address family, AF_xxx	*/
+	char 		sa_data[14];	/* 14 bytes of protocol address	*/
+};
+
 struct linger {
 	int		l_onoff;	/* Linger active		*/
 	int		l_linger;	/* How long to linger for	*/
-- 
2.34.1


