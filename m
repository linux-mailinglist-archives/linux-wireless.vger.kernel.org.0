Return-Path: <linux-wireless+bounces-18755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0102A3094F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 12:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB46188A2BB
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866C1F4E27;
	Tue, 11 Feb 2025 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bX+FSXdX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AC51F8677
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271574; cv=none; b=IdwJbFcFWKSKZcEBwKnEy7ZaZfgTgDi/oGjH8M7M47Nts/ymH1Zd6I7n5vZyT9+x0LnkehQHpEhZ+EpwhyVna71LD15Cychr4UxxcHeJEg3M6dvkRSCuM5s0A5AWRIEd4A0GgnuhNTCf1UOacFpSwe3PI5Or+BxMPTIGJiPGdWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271574; c=relaxed/simple;
	bh=BFYjJhPbUMtbsig75VlDVJOpJQPrbnG6ujz6GGLPb/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChhyNcMvFxsDIFHK5vsfV5N51JG7rlfz/A8h0n1mD0qMI2ByfbWVBBgy+pFi6zeMZsNXLD0lAAptD0IgsuxLTA4W3PvmvMw2vtejer1E+p4ueBkKRAFVJkLX8YdB24AtkS3iFuQw5Xc/1BEDZejzjn6O5IVLlo7VDP0E4evEvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bX+FSXdX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739271571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kilt61fFK/mP9ZOT4emxv0+lDyqkmWR9Zi3Jm/Pir2Q=;
	b=bX+FSXdXEN+WkYLQ7N5GbMLkEO4G309xgy67sCYaiF8nWqtLzZ/sURM/7L2dphMhQ3T6jj
	hcl9OXQG0AFTuf1nPyh71QeY1pSVk3He8zQlYht8fWwAY5GZDPF+tOTYxz0nZqeSjnShMY
	1gBQ3vsw8mNi+zB03oBj4C/tTMCWY60=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-mLeo62NhMzSMaQimnVbTBw-1; Tue, 11 Feb 2025 05:59:30 -0500
X-MC-Unique: mLeo62NhMzSMaQimnVbTBw-1
X-Mimecast-MFC-AGG-ID: mLeo62NhMzSMaQimnVbTBw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43943bd1409so14231205e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 02:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739271569; x=1739876369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kilt61fFK/mP9ZOT4emxv0+lDyqkmWR9Zi3Jm/Pir2Q=;
        b=IkKhz+8kykNReHj2E61uOoSjxFDumEfKTVyB27EoyX7Qw7NpRfAjCVa3SBa1B1ezw8
         U6TFNKMMGiGGgtTVcbnMNWnVh0mZFYcfT0zhuq6Xqbb38lFWkyr3O8ehW9w/VVcQWRG4
         pScK5zmHBBj5bcWakhctUQlVygg6/ODY3Q734fs9PUhEZs5ma5Uvyn69ZNV3gpzy1L4N
         2KNmEwJuSUnQIklRpJ4mQGxefF2yllxJWjCAKMkIYir5oB2bDLpZLikIzqbajX9JS2iM
         8O+ygWTTYTaOozi9KbSbz79L181CgaLmV6bTD6N3BN6DuGrhfMbIUCuvzWUgdXOehYMw
         ffGg==
X-Forwarded-Encrypted: i=1; AJvYcCU2YGOXpD5Y5rRi0IhxFPZIvcmS/RxDpCg+PAta4X5AkwH4pGHOydy0C/fXnVUuW3LhEe/567+nMRSPgEGyIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcttiUGohSDt53kXaKatxdCFp1e2kf0phZpa5B6CUu8+kDBrwZ
	pkJLmqFWQ5P+zYu5b5UqU5yapNTPzpPAdzFWZKIwxIDN57OiL8BaAECoy94NEFmmTpZfHhZMiyz
	Tpk3L7UHeqmuJSlhwaNdl58RWkvbdbZ4O9tqqcRXAqluYPRv8drzHbsyMC3VPzJhc
X-Gm-Gg: ASbGncvliO53dPjQajGlaxggx3ezz0wgn+V5Id10f7BUOJi8TYZjuGX/qxbe8l3uKYv
	vCtQQK2/1N56/5f9z1Mj7ckHnh0rU17Ql2xqw7GL8q/bKjo1bYSczXzYwMBlRE2xW0xJ0CK9Xvn
	byRCWrHJv5kHWWonuUZtJQvUci6uwNfCCzHT+fDtkmAdsn3hS4LEfvyRQy/ZILssjBP3GtOF+I+
	uDul4/S4wCb6N7tSAVTvlVieHw64mL0uWAWHOpfVZ4pN+wqV05pyAS0wScLXvcES8J9Yc66NyQ4
	cUUOeeg2ZcWnw6bn4FUM6zQu00glEc9TzgE=
X-Received: by 2002:a5d:5f8c:0:b0:38d:dc57:855d with SMTP id ffacd0b85a97d-38ddc578637mr10222823f8f.35.1739271569100;
        Tue, 11 Feb 2025 02:59:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4QL+Sgu9A6H/CSzW/r9GkNXRy3OgG5msfCNQljMNe0oVIy7gzB9bkONCDIADI1yyYjMt/nA==
X-Received: by 2002:a5d:5f8c:0:b0:38d:dc57:855d with SMTP id ffacd0b85a97d-38ddc578637mr10222792f8f.35.1739271568731;
        Tue, 11 Feb 2025 02:59:28 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dd5b03955sm8568905f8f.49.2025.02.11.02.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 02:59:28 -0800 (PST)
Message-ID: <599a281f-d468-4b92-8b15-6f1292888dd9@redhat.com>
Date: Tue, 11 Feb 2025 11:59:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 10/10] netlink: specs: wireless: add a spec
 for nl80211
To: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: donald.hunter@redhat.com
References: <20250207121507.94221-1-donald.hunter@gmail.com>
 <20250207121507.94221-11-donald.hunter@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250207121507.94221-11-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/7/25 1:15 PM, Donald Hunter wrote:
> +        type: binary
> +  -
> +    name: nl80211-iftype-attrs

I'm unsure if a respin is worth, but the above yields a strange looking
c-struct name in generated/nl80211-user.h:

struct nl80211_nl80211_iftype_attrs { //...

All the cross-references looks correct, but replacing the above with:

name: iftype-attrs

AFAICS will also generate correct cross-reference and a more usual:

struct nl80211_iftype_attrs { // ...

Also waiting for some explicit ack from wireless.

Cheers,

Paolo


