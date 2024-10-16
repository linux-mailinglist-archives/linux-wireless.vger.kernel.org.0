Return-Path: <linux-wireless+bounces-14029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D34299FF89
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 05:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFFA28687D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A34816D9C2;
	Wed, 16 Oct 2024 03:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BQDhvSIt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169E3157A41;
	Wed, 16 Oct 2024 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049466; cv=none; b=Z6AbgZJ/PhORZG6ng8n6svJW1eUoxh1rgV4UfQKrHUmr7cRMI1wGKIv5vU1jSQoznbx/3SpfjO8soKya1nQqh2DqILIjJwkUnozG0+q618OUc2f74HQAn8o4p6oBDhGG4Ev7vEywpc5vWaT7EknB28LTghEKy5s6prh61uJsPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049466; c=relaxed/simple;
	bh=1RDWVfjt8CeM/x84cXRzvf+PJhV9JF8TakbxdEtOjaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CypFqG11Lyitr81pcvdq448H2VvJhgMUskyOTcLiinlGKtbd58tb6U83vuqFSyjUttWKKO1h2gefbmySyAbgcEulrQGcdOhBKQPA4IZ25ptWX26/QYdYqKFwpnObqL8mYcP1EHjesKUnyMjQgYiUX+4r1WgJ4Qw28ShFyQF4jpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BQDhvSIt; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729049465; x=1760585465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0CkBNDYdSm6bkTWLi6IG3qXSuk5UAVOE/HPqWHE6og=;
  b=BQDhvSIt0P9SlewVzuRBf/3bNc7V6Uull7wSxcCse6kL8nruH/eXCgvh
   FzUst9V8xTcMgKLF+3QSFPywAR3j4nFKv7S64yjl3TwkakbyckUUz2GOS
   wST7iZ8fsZFW7tBQocYfaBpfjOH9qAp20Zy14c4qndVDQBlapZA1Q5Amk
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="766935707"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:30:59 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:34151]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 7a6e1911-5029-441d-8ce8-1b14b5d8e96d; Wed, 16 Oct 2024 03:30:57 +0000 (UTC)
X-Farcaster-Flow-ID: 7a6e1911-5029-441d-8ce8-1b14b5d8e96d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 03:30:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 03:30:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gustavoars@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <johannes@sipsolutions.net>, <kees@kernel.org>,
	<kuba@kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH 1/5][next] net: dev: Introduce struct sockaddr_legacy
Date: Tue, 15 Oct 2024 20:30:42 -0700
Message-ID: <20241016033042.89280-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <1c12601bea3e9c18da6adc106bfcf5b7569e5dfb.1729037131.git.gustavoars@kernel.org>
References: <1c12601bea3e9c18da6adc106bfcf5b7569e5dfb.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Tue, 15 Oct 2024 18:27:16 -0600
> We are currently working on enabling the -Wflex-array-member-not-at-end
> compiler option. This option has helped us detect several objects of
> the type `struct sockaddr` that appear in the middle of composite
> structures like `struct rtentry`, `struct compat_rtentry`, and others:
> 
> include/uapi/linux/wireless.h:751:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:776:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:833:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:857:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/wireless.h:864:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/route.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/route.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/route.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:118:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:119:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:121:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:126:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/uapi/linux/if_arp.h:127:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/nfsd.h:74:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/nfsd/nfsd.h:75:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> In order to fix the warnings above, we introduce `struct sockaddr_legacy`.
> The intention is to use it to replace the type of several struct members
> in the middle of composite structures, currently of type `struct sockaddr`.
> 
> These middle struct members are currently causing thousands of warnings
> because `struct sockaddr` contains a flexible-array member, introduced
> by commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible array in
> struct sockaddr").
> 
> The new `struct sockaddr_legacy` doesn't include a flexible-array
> member, making it suitable for use as the type of middle members
> in composite structs that don't really require the flexible-array
> member in `struct sockaddr`, thus avoiding -Wflex-array-member-not-at-end
> warnings.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/socket.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index d18cc47e89bd..f370ae0e6c82 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -40,6 +40,25 @@ struct sockaddr {
>  	};
>  };
>  
> +/*
> + * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
> + * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
> + * array in struct sockaddR") due to the fact that "One of the worst offenders

s/sockaddR/sockaddr/

The same typo? exists in the cover letter.

With it fixed,

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> + * of "fake flexible arrays" is struct sockaddr". This means that the original
> + * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
> + * flexible-array member was introduced.
> + *
> + * This caused several flexible-array-in-the-middle issues:
> + * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-array-member-not-at-end
> + *
> + * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances where
> + * objects of this type do not appear at the end of composite structures.
> + */
> +struct sockaddr_legacy {
> +	sa_family_t	sa_family;	/* address family, AF_xxx	*/
> +	char 		sa_data[14];	/* 14 bytes of protocol address	*/
> +};
> +
>  struct linger {
>  	int		l_onoff;	/* Linger active		*/
>  	int		l_linger;	/* How long to linger for	*/
> -- 
> 2.34.1

