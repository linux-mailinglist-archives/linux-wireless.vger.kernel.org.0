Return-Path: <linux-wireless+bounces-16302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A99EE346
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 10:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791251889DD8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F1B2101A2;
	Thu, 12 Dec 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wt5smD3g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB1920E716
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996462; cv=none; b=pDH00ECJ34dVAqSCxS6qq3pbtByBSzdfuyMD3yInFjNkTzh2NxjcUvDAKEiyee8TtT0KKDF1qgdKamgpcSNnmKnrJT0JWgwAcjA3Wd7DeBV8PPy5IxNVGSeMrayFI91IvQl1WL5IfUBOSFpDRRYS5lgOGNhf3mieySVgAuTZzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996462; c=relaxed/simple;
	bh=vS3YMZ8TTS+sy79u9btJFf1HSWBg0QXdTjZNCNiaehM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJT9rAiIQxSV0Xl3mjW7+qGn0qh270Ww0q6yraytYSC8rfiSHB5a6LPmQPzjc1MApvi0k/jh/zRNRVs1Tyv6q8VuLMZN1EaxyTPD9HpWDfHGEj+utPULYNkSJK5oVemjTWyiQ5NQmRzO+cL8M3oakMR53jJyEEDj6LXnYcc3Xkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wt5smD3g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733996460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
	b=Wt5smD3gzh6j9DJogTxsTXE70iFXwZVIgUJt+e/grgSTq65A30eOn/EJqSdbyQ5eED/bPV
	ZHvy4Xhw5t+0S4axq3lsqMxK1Q2NoiZFSm3Miqg+CI2NqnQ3l05w4YyvmfR+3jFckWj+ND
	rmlpGPylrYu3xVTw4eQR03upQiY6N/0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-EbL3_gCoMfScJ1tpoXnU7w-1; Thu, 12 Dec 2024 04:40:56 -0500
X-MC-Unique: EbL3_gCoMfScJ1tpoXnU7w-1
X-Mimecast-MFC-AGG-ID: EbL3_gCoMfScJ1tpoXnU7w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38639b4f19cso261723f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 01:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996456; x=1734601256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vO5x2q/Sa0e5fTHlXfwREEvSvA3RWPrUa1t93Ro/NiA=;
        b=EzSvUuwLLKMAbkLFNUJdrbOAeyNZ/9+ggS+9VsFsZFSj+PKFARczZzXqdsjsGmAh5D
         KWM7IcGz4KaAArpB3/rYXVhR3tejDdKJkjmrcRGgdYA9tknoSyDY5RmYHl++qmipmf6I
         o6RRKD5igv+ZKIa8tr6DQaQPEh4N0w6Vf8GOwrws5ZQAt8lL1ZSfLCUq8mCtKzXEaG9g
         +jEjKFLVsQkOhWnzdjJM1e2Ry37SahJKSJDMC67rAPgnJWe1acIo9HnpAe+KSfddQFkl
         cZaJS+G1tN+qQbRf4nf+Zoc8qfo0U/2sgvtlIC7shQuh/dH+YandXSQchG9R8wnybpjJ
         DZjA==
X-Forwarded-Encrypted: i=1; AJvYcCWabJ10yrWmImQNATzbZefizPWgEveXdjLnk4Ga60br0isNLESSZbvos/oQQi5UJsK+fa07A8dQDZ6Ra0481A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhC1xsp1J1AfuNTtcYLjars4c37BYjugWZ2KapNGywh+v3ql7T
	nuWnHLLfA9UOqv7d2KfQfdQquemzxca+/A1gNyjjdYMNC2GWQuUYwwgiMCX5Jdf6xfoGAOVJpza
	/QFrf5ZHFru/npW3SxFUSqLVE3atRoaOn1VB8wK5iw016jIYa+wFRXSNILjBfaHDK
X-Gm-Gg: ASbGncvf3bqRA5LXzDPkMteTesst5VQyjwD9OV6q8tCUZCbgu9VeN+Jn1QWg+D85v0o
	s1xRu6qUB9O60WtLVH3uqgtwRocpmuPXYD/KlPFmOl4QCkMlwrDAzpTdiGWsL+y66Xj9VtXDT40
	68HnY/oxKpyUDS7RyN9a/uNhZfyNiV/XAjkfjWwHSVr2Q5+qYy3SAudflohKi6CZycFYBVFYqLI
	qblvnLS711IdXSyaR1ZJ2vW3NxQMMSAjE1xBS926Zs6fgNKioIdr1Ozsoj8DCzn0Ww+T54UAuVr
	1RbCOIE=
X-Received: by 2002:a05:6000:1fa9:b0:385:f23a:2fec with SMTP id ffacd0b85a97d-3864ce88e29mr6040213f8f.11.1733996455840;
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPT0KYgGEFCZGrqybSALsE3Qqj+pmWswO0HlvX3IBSNS8HmdA5fJvJjIK2Fq1iEV0Tr46sRQ==
X-Received: by 2002:a05:6000:1fa9:b0:385:f23a:2fec with SMTP id ffacd0b85a97d-3864ce88e29mr6040187f8f.11.1733996455462;
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c462sm11164015e9.14.2024.12.12.01.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 01:40:55 -0800 (PST)
Message-ID: <4a2fe99a-772d-4df1-a8ef-14338682b69e@redhat.com>
Date: Thu, 12 Dec 2024 10:40:53 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 5/5] selftests: net: Add two test cases for
 link netns
To: Xiao Liang <shaw.leon@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>,
 linux-rdma@vger.kernel.org, linux-can@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, bpf@vger.kernel.org,
 linux-ppp@vger.kernel.org, wireguard@lists.zx2c4.com,
 linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209140151.231257-1-shaw.leon@gmail.com>
 <20241209140151.231257-6-shaw.leon@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209140151.231257-6-shaw.leon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 15:01, Xiao Liang wrote:
>  - Add test for creating link in another netns when a link of the same
>    name and ifindex exists in current netns.
>  - Add test for link netns atomicity - create link directly in target
>    netns, and no notifications should be generated in current netns.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile        |  1 +
>  tools/testing/selftests/net/netns-name.sh   | 10 ++++++
>  tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
>  3 files changed, 50 insertions(+)
>  create mode 100755 tools/testing/selftests/net/netns_atomic.py
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cb2fc601de66..f9f7a765d645 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
>  TEST_PROGS += cmsg_so_mark.sh
>  TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
>  TEST_PROGS += netns-name.sh
> +TEST_PROGS += netns_atomic.py
>  TEST_PROGS += nl_netdev.py
>  TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
>  TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
> diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
> index 6974474c26f3..0be1905d1f2f 100755
> --- a/tools/testing/selftests/net/netns-name.sh
> +++ b/tools/testing/selftests/net/netns-name.sh
> @@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
>      fail "Can still find alt-name after move"
>  ip -netns $test_ns link del $DEV || fail
>  
> +#
> +# Test no conflict of the same name/ifindex in different netns
> +#
> +ip -netns $NS link add name $DEV index 100 type dummy || fail
> +ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy ||
> +    fail "Can create in netns without moving"
> +ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found"
> +ip -netns $NS link del $DEV || fail
> +ip -netns $test_ns link del $DEV || fail
> +
>  echo -ne "$(basename $0) \t\t\t\t"
>  if [ $RET_CODE -eq 0 ]; then
>      echo "[  OK  ]"
> diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testing/selftests/net/netns_atomic.py
> new file mode 100755
> index 000000000000..d350a3fc0a91
> --- /dev/null
> +++ b/tools/testing/selftests/net/netns_atomic.py
> @@ -0,0 +1,39 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import time
> +
> +from lib.py import ksft_run, ksft_exit, ksft_true
> +from lib.py import ip
> +from lib.py import NetNS, NetNSEnter
> +from lib.py import RtnlFamily
> +
> +
> +def test_event(ns1, ns2) -> None:
> +    with NetNSEnter(str(ns1)):
> +        rtnl = RtnlFamily()
> +
> +    rtnl.ntf_subscribe("rtnlgrp-link")
> +
> +    ip(f"netns set {ns1} 0", ns=str(ns2))
> +
> +    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
> +    ip(f"link add netns {ns2} dummy2 type dummy", ns=str(ns1))
> +
> +    ip("link del dummy1", ns=str(ns2))
> +    ip("link del dummy2", ns=str(ns2))
> +
> +    time.sleep(1)
> +    rtnl.check_ntf()
> +    ksft_true(rtnl.async_msg_queue.empty(),
> +              "Received unexpected link notification")

I think we need a much larger coverage here, possibly testing all the
update drivers and more 'netns', 'link-netnsid', 'peer netns'
permutations for the devices that allow them.

Thanks,

Paolo


