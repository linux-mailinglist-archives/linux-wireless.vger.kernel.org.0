Return-Path: <linux-wireless+bounces-18908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80621A33B0B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 10:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EEC16B2BD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 09:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F720E709;
	Thu, 13 Feb 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co/u+qf2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38420CCE9
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438282; cv=none; b=af5HcQ+KtituYYkmHug8j//zFm1ce449YA5y9JBXQ4LYsYVR3G73+G5o7ChUdaKI0mc7iexniMHkCmBWThH+Ebb24SYNW5FldCZBDwtDAeqZz6SgrSQeGN8Ro1fVAbJwopLCtJBdyHRGb7cgbb4o167QffExMd6auzBtUOXqnwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438282; c=relaxed/simple;
	bh=tZFHp6UCOiU6zKu3uGe+iZ5zxsFxAKP2QH0K61+Dvo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ0Ht4u9RoyGnFttO8oI1do0KFRvewkAdDEGHXOcQxKxBDJF54bTNDTWvja7Oq7ngeSy35NUmX5gWyzXVh/DOtasKLoP+wHSTUQQQjqE4K2ez8RhEw2JiqzR6IYLaU4AJSr4Pte8ww26ATFmuRyxmb6M0PfmHLcPPvmIXhrMXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co/u+qf2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739438279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
	b=Co/u+qf21ZwIdkBXtAG5D2wH2IqqKnznG/PjBXZQn+K6+DkumYTo9cQLFdbZttENRiztUv
	Xb6co98mYtyXlPD75JQMwJmxoxAC9UldR1DCTFcFzRlNDOays1noWseqZY7vOcCpLXrWKu
	HwCxV9drvKQflRmE9jfMfSIVHtoFP/Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-DcMJ-AijPamK4bpNg8IHMg-1; Thu, 13 Feb 2025 04:17:56 -0500
X-MC-Unique: DcMJ-AijPamK4bpNg8IHMg-1
X-Mimecast-MFC-AGG-ID: DcMJ-AijPamK4bpNg8IHMg_1739438275
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38dd533dad0so443702f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 01:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739438275; x=1740043075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyhNP3qOlJ39umXMZfckH2nuz/m9WI3f5NG3i+yZUF4=;
        b=JG464Ds5c/91YIX/xZNeg2qEuNSV9Zz37M6woHOAv7LeAAesLGFdmCFiUSB+d3Lg++
         kzMTBL5mYAcgEl6l6Ikh6f2/5UjtgeoxX0UDX0u3zOkyyjVJ4X4vmVLw6PsMIs4+d6v5
         0lrwgLWrK+8MEo2K8rvrLMnt8SZedXuPbE2oLdSPxMpqFeahLI9tLZp3bvxUBgtZBRqs
         hu75I/aPqNR0hsP2/unXj0j1703glG+0EY3bX8AhqFyIXpUZGdipoDD6ld200sEXaL8E
         KCYTCqXjp+mPETHK8QGX/67xTmuDyZqbyrKhzBljpe2vjJRz9YQZgk2RgeUW0Gy6lXuZ
         y6AA==
X-Forwarded-Encrypted: i=1; AJvYcCXlInCdqUmc8nTjNkfhYuE9g/yKBnV5kbOFUVqDsVSepi2SwF3OYxY5zA+bFpG9WwDKAq/AqSvd+RZH3p3dEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRJnITt5dfAGUQzOCtSRQh3CQAiKkiIEs2LY0RgHDOp7RpeM0
	78ngg8v4LvfgrYRyNWZ/92x0LCh5s7fRP4gGZd2KnHhaaqUnXW2IVji01igMsmqsrohu+X6amAM
	UtpkbzGQ8DnfFb07rCLz77hEssr3W7XoRxceLkh1CiYbLPSVc7rHq41hUAMeL2Vu0
X-Gm-Gg: ASbGncvIvNKznU3q1pxGoSDfTs4gi6koPDPXNvH7ugysuUBDaNs2C+N1b0uBve5i+vu
	2QHiwtB7Mjg8LdXrmdhfDFwyrMYJmWLxLxIboYBp3yynsHb1/H1uS7X3HyXZh8ecNGTrTVgzFNW
	8b1RMTbZ/IEkFInSZqDEZYg46dkY4ZKGWnzLK/s4v/a6Dms3vBCRazKUCVfxy5ZWIRXWFtnOCNn
	cliswfKdc1qcyU7xAVL5Ax/DjhoJDOsyXQ8CLpcNrF1JQfFaMS01fybELMoHfVFIIY+aw6lCs0M
	OIw1itzNrjBw4NiUiD22KOqNAiamwKUC2ec=
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38dea2e8252mr5537722f8f.42.1739438275373;
        Thu, 13 Feb 2025 01:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvdEpVIGWCwTdkiFI9VeLvCiv6OrrtGDZTcFYpY+kBOdDZTqd8HRvUuOkaOwq9itdXLKF4sg==
X-Received: by 2002:a5d:59ad:0:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38dea2e8252mr5537666f8f.42.1739438274976;
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm1314704f8f.26.2025.02.13.01.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:17:54 -0800 (PST)
Message-ID: <2c294c0a-26c4-4ec5-992d-a2fd98829b16@redhat.com>
Date: Thu, 13 Feb 2025 10:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 02/11] rtnetlink: Pack newlink() params into
 struct
To: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch,
 b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org,
 bridge@lists.linux.dev, davem@davemloft.net, donald.hunter@gmail.com,
 dsahern@kernel.org, edumazet@google.com, herbert@gondor.apana.org.au,
 horms@kernel.org, kuba@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-ppp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-wpan@vger.kernel.org,
 miquel.raynal@bootlin.com, netdev@vger.kernel.org,
 osmocom-net-gprs@lists.osmocom.org, shuah@kernel.org,
 stefan@datenfreihafen.org, steffen.klassert@secunet.com,
 wireguard@lists.zx2c4.com
References: <20250210133002.883422-3-shaw.leon@gmail.com>
 <20250213065348.8507-1-kuniyu@amazon.com>
 <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABAhCOTw+CpiwwRGNtDS3gntTQe7XESNzzi6RXd9ju1xO_a5Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/13/25 9:36 AM, Xiao Liang wrote:
> On Thu, Feb 13, 2025 at 2:54 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> [...]
>>> diff --git a/include/linux/if_macvlan.h b/include/linux/if_macvlan.h
>>> index 523025106a64..0f7281e3e448 100644
>>> --- a/include/linux/if_macvlan.h
>>> +++ b/include/linux/if_macvlan.h
>>> @@ -59,8 +59,10 @@ static inline void macvlan_count_rx(const struct macvlan_dev *vlan,
>>>
>>>  extern void macvlan_common_setup(struct net_device *dev);
>>>
>>> -extern int macvlan_common_newlink(struct net *src_net, struct net_device *dev,
>>> -                               struct nlattr *tb[], struct nlattr *data[],
>>> +struct rtnl_newlink_params;
>>
>> You can just include <net/rtnetlink.h> and remove it from .c
>> files, then this forward declaration will be unnecessary.
> 
> OK. Was not sure if it's desirable to include include/net files from
> include/linux.

I think we are better of with the forward declaration instead of adding
more intra header dependencies, which will slow down the build and will
produces artifacts in the CI runs (increases of reported warning in the
incremental build, as any warns from the included header will be
'propagated' to more files).

>>> +extern int macvlan_common_newlink(struct net_device *dev,
>>> +                               struct rtnl_newlink_params *params,
>>>                                 struct netlink_ext_ack *extack);
>>>
>>>  extern void macvlan_dellink(struct net_device *dev, struct list_head *head);
>>
>>
>> [...]
>>> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
>>> index bc0069a8b6ea..00c086ca0c11 100644
>>> --- a/include/net/rtnetlink.h
>>> +++ b/include/net/rtnetlink.h
>>> @@ -69,6 +69,42 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
>>>               return AF_UNSPEC;
>>>  }
>>>
>>> +/**
>>> + *   struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
>>
>> The '\t' after '*' should be single '\s'.
>>
>> Same for lines below.
> 
> This is copied from other structs in the same file. Should I change it?

https://elixir.bootlin.com/linux/v6.13.2/source/Documentation/process/maintainer-netdev.rst#L376

In this series, just use the good formatting for the new code.

Thanks,

Paolo


