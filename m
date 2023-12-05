Return-Path: <linux-wireless+bounces-414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B35804B99
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 08:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448241C20E68
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5097834189;
	Tue,  5 Dec 2023 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hLPLGfwW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D453D3
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 23:58:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40bda47c489so34368665e9.3
        for <linux-wireless@vger.kernel.org>; Mon, 04 Dec 2023 23:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1701763126; x=1702367926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g7FpkghBvKrwkpwGugGld407jjY5p4c/xbnuRbVmo3M=;
        b=hLPLGfwW6c2v6Kho23LseK8L2lF+eua2pXpLm83bwYrKsK4RVhFP/Va2QnHmsV4jde
         +FpbfflTFjlH3Ws5eGxdNYrM4rGM2HfeI9xcwgS+3qLb4ZrA+CLsnOMgRB1/GBCEzdrO
         nQcwF7qe6HElv0wyVChb7/lKqEMy7xbGEYrwvlRxoeKA1N5mPC+JuoZZaXyEsm6qo78v
         0QGRpbCukyQYkZvb9GCT+zb8Y45Sqx1kQ6Pxck42kptVX+2Nm1HCBaSFOGylD+5L7CC1
         HX8Dgwhtn6uR1SjI8nYU3kYLkIgj0/duZ1ymtFCrWs2EjwQH5LPpA2fWiYCfXMCe/RBL
         cakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701763126; x=1702367926;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7FpkghBvKrwkpwGugGld407jjY5p4c/xbnuRbVmo3M=;
        b=bNS7QEGMwYl8w/jdlBzEilT2aw575uCl/2HBo7DXl/E5gU32+fXOMdugeLYIvHM3pr
         5GwGGl8kN7sf/+JlX2aiQpbbxPbPQpOAzIk5JBk6YeCicJsPojyQGv5OqXfM+yRi8OW7
         gdq/d2kPNrKw5hD6twR0wsH1sUUZ8x8rAWaU/Q93ItjWAiMKN4BXFGNwfvxBClKXWjt3
         IirUwCB0thXQUX4Hoe5b5TS9w3+1tpEvscxJXfoPQxgsgvBR8T8cIdx0xnGwJWEV+fWE
         ssr2ZaEs++RPTyvl6bq/wl2Nz1uiLybNN4sHJxn9vO7OAlW+NMqYc0H/p8ewmUpLefbn
         NC4g==
X-Gm-Message-State: AOJu0YwQFDdHNyw7htcKm5Aok61F99HGDopHNHFTisVfQlA/y1temOam
	p5og4sDESMKJrGvZ/fviZ1hpqA==
X-Google-Smtp-Source: AGHT+IF0WcZBXfMmBhWKPfp1EXfUTOotIxbbEXjRjIn3xrmPFKEbABwnOm4z9SZDfBvjEsjFHau4YA==
X-Received: by 2002:a05:600c:1907:b0:40b:4c39:b4e with SMTP id j7-20020a05600c190700b0040b4c390b4emr204745wmq.1.1701763126671;
        Mon, 04 Dec 2023 23:58:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:3e2e:5141:80dd:488f? ([2a01:e0a:b41:c160:3e2e:5141:80dd:488f])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b0040b3d8907fesm17817224wmo.29.2023.12.04.23.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 23:58:46 -0800 (PST)
Message-ID: <10737d34-0070-41f5-8903-dcae30ee7ba5@6wind.com>
Date: Tue, 5 Dec 2023 08:58:45 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] netlink: Return unsigned value for nla_len()
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Jakub Kicinski <kuba@kernel.org>, kernel test robot <lkp@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, Michael Walle <mwalle@kernel.org>,
 Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231202202539.it.704-kees@kernel.org>
 <95924d9e-b373-40fd-993c-25b0bae55e61@6wind.com>
 <202312041420.886C9F3@keescook>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <202312041420.886C9F3@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/12/2023 à 23:21, Kees Cook a écrit :
[snip]
>>> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
>>> index f87aaf28a649..270feed9fd63 100644
>>> --- a/include/uapi/linux/netlink.h
>>> +++ b/include/uapi/linux/netlink.h
>>> @@ -247,7 +247,7 @@ struct nlattr {
>>>  
>>>  #define NLA_ALIGNTO		4
>>>  #define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
>>> -#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
>>> +#define NLA_HDRLEN		((__u16) NLA_ALIGN(sizeof(struct nlattr)))
>> I wonder if this may break the compilation of some userspace tools with errors
>> like comparing signed and unsigned values.
> 
> Should I drop this part, then?
> 
Yes please.


Thank you,
Nicolas

