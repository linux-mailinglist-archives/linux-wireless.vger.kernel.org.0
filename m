Return-Path: <linux-wireless+bounces-25838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B432B0D52E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D611AAA090D
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2426EAC6;
	Tue, 22 Jul 2025 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="k8Mo5J7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36E222571
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174825; cv=none; b=Vkkl+yaclLD0x1y8Clu5EYsBNnfVSb1g55GLeOXdTSr1YrPlI3iLGGj3pAM1kr48fsHf2IHz8AMlm1uXs8eSeoP5wwwzEwzDnz1S4uyt1LoUe19vrK3GxgCqToeN7O/Js22YSLRC2Zt0Ri604v3lSr0rRMsSS7n/jxOWWHGBfws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174825; c=relaxed/simple;
	bh=MvWiDQBFSxo3zghuUACGJoe754sT6U4p4R/d9U4GRYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJAS9Z4171h/eeUm0lyvYDAt5GHoZyxAh9/t/njXaeWFh+S+DCtNd/FMMP47PwXAgb0mTCVMZBZ8ZzLF1IRqSyaWlCAK8jTJfC126Rzx0vKLsrvjAFgx/OdeaAmhwnlHnXLjj7/zzq+4rpkl6Ipki5YdctMGpeaG3tPesFvqSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=k8Mo5J7q; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so9336048a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1753174822; x=1753779622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+wgdQjQdMETdCjaE+n1D+f0xwzmBgbN+gH4YChh6zl8=;
        b=k8Mo5J7q/xl+wPc8DeuynVC/bqNBpUzV2TAwnPv2JJN8Dqw5Th7owxJwjN6nfe2ewC
         8xkqMPK5rE3VGd0ZPtfca8KjTRMddyD5tRr3A+GtMxK8uSzjPjIivHSURqY5Uaoisvvm
         CCtj9tRA/JzREt0BT3n6+d45E/MqohHuB+4t8lCE1Za1TJa1l91rOxGS7vJS8TTjZ5pz
         i9c+YV2I7D0YYwP2C27ZmmFDgcGajNxrNbeg4IxPj3efwHU+T7wupgZVplvE1Cq7RLE6
         ZbXpb0QpBtKUWEep0VZti+wmdpysuX0Rz6Nn9CA4czl9T01DUrG1hPMbJ2zgEoR6XE7L
         VdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753174822; x=1753779622;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wgdQjQdMETdCjaE+n1D+f0xwzmBgbN+gH4YChh6zl8=;
        b=MYwZmSlGIiDvi7i/F7lU5WerkehjUqMoIKmhPIBtR3ZFteB1uinDW+unTGsAYC4vVS
         vqoAAb4l+7AZ0wT0SszN12kNcJTIwMRJUHAhkO75RiOqHTvv0T8ew8wBn4cGdZKXE2ES
         jYprPt7+MSCsaZRy69+aab4m8i0h6pKwIMN0Bs/2n45B6fPIYvmeAd/yT8Hp4BCgqipI
         Tfk284Jrxq+cV6uFd1kFVoisbPguoGcS/pXeo4WrRwhiaUqfP2J42FHM5p9RuOfbHqIJ
         +EjnacJAlR94PLFbdwDkgkRlsZwZTxhaUgLa58cQX16B6kxyhyqNfnAzt31YxIdkzmkk
         Q20w==
X-Forwarded-Encrypted: i=1; AJvYcCV6laWaD38MAkUIEU5hKnswW2lZ45tcy8n/+gZm0t5DIzGklGlU2OeOWH69djHSK0Kcnx+a6dWpQvRX71WPIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYT3P2Hmskg4UUr0znlcru2E4HHwfosYnl04UT5qttJEHruSRz
	KR7twctiMbkdyxgXNAXk5kUZdvUSKrJvOh/3vGCYTNXZ86GD+cUQ+QeuUOU11NYSArh1cO4VUXA
	VDIzSjFq4fQ==
X-Gm-Gg: ASbGncs44NqAVfShzKl8SzyxFTqtRAlstbCnGz8EmYmqkX+B6mJVL7P+CbOMCf6D1mQ
	jykt+tzrz+Ix+xMPgQkmjuAsSRK0HzPgoatoFEbNS+r3sX9+DVCFfWaQlptusLBScjBDPuUfMMn
	QY2a2kcJVT59mjjlOHCqiAT48LuNN7e6SBRm1gtjhRTldR7NEvfwvnkuF8jePL3naJTtUOsV9hb
	i47ORtqfd8uwQQUFHT6eQw7lLYtDhRMlOyIdQZHNPSDHW6kb0OI1dx0Pn/R8vVjJ1mwpJDxfu3C
	dXgTcu1QTvF54UM5XbrjY6CzckvwMlLxOn9SHw31N+GRBjyPz0d7RBVecCpuyuvby77eC7uyl0G
	fKDnt0hRr7fTgJeeyx/fp4ASHvkOEqHYP2tde4oxsg4TdpWVzYYNEsiJ9pNYk
X-Google-Smtp-Source: AGHT+IEWKrdz2QU8wU2oFaKBaFakfxmdYxmPemsDelWpwi2WLFmBBol7KjxAnuUTvNzHnAbP66QfPQ==
X-Received: by 2002:a05:6402:4308:b0:604:5cae:4031 with SMTP id 4fb4d7f45d1cf-612c7404ae8mr14440315a12.28.1753174821070;
        Tue, 22 Jul 2025 02:00:21 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:b6d9:6def:525:5a1b? ([2001:67c:2fbc:1:b6d9:6def:525:5a1b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f07fbfsm6645993a12.1.2025.07.22.02.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:00:20 -0700 (PDT)
Message-ID: <2e3aa500-989b-4acf-b6f8-9ee200e67cca@mandelbit.com>
Date: Tue, 22 Jul 2025 11:00:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix unassigned variable access
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250721211736.29269-1-antonio@mandelbit.com>
 <cdfcd722e1f8527809d89e13484bcb25d3e74947.camel@sipsolutions.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSlBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BtYW5kZWxiaXQuY29tPsLBrQQTAQgAVwIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUJFZDZMhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJhFSq4GBhoa3Bz
 Oi8va2V5cy5vcGVucGdwLm9yZwAKCRBI8My2j1nRTC6+EACi9cdzbzfIaLxGfn/anoQyiK8r
 FMgjYmWMSMukJMe0OA+v2+/VTX1Zy8fRwhjniFfiypMjtm08spZpLGZpzTQJ2i07jsAZ+0Kv
 ybRYBVovJQJeUmlkusY3H4dgodrK8RJ5XK0ukabQlRCe2gbMja3ec/p1sk26z25O/UclB2ti
 YAKnd/KtD9hoJZsq+sZFvPAhPEeMAxLdhRZRNGib82lU0iiQO+Bbox2+Xnh1+zQypxF6/q7n
 y5KH/Oa3ruCxo57sc+NDkFC2Q+N4IuMbvtJSpL1j6jRc66K9nwZPO4coffgacjwaD4jX2kAp
 saRdxTTr8npc1MkZ4N1Z+vJu6SQWVqKqQ6as03pB/FwLZIiU5Mut5RlDAcqXxFHsium+PKl3
 UDL1CowLL1/2Sl4NVDJAXSVv7BY51j5HiMuSLnI/+99OeLwoD5j4dnxyUXcTu0h3D8VRlYvz
 iqg+XY2sFugOouX5UaM00eR3Iw0xzi8SiWYXl2pfeNOwCsl4fy6RmZsoAc/SoU6/mvk82OgN
 ABHQRWuMOeJabpNyEzA6JISgeIrYWXnn1/KByd+QUIpLJOehSd0o2SSLTHyW4TOq0pJJrz03
 oRIe7kuJi8K2igJrfgWxN45ctdxTaNW1S6X1P5AKTs9DlP81ZiUYV9QkZkSS7gxpwvP7CCKF
 n11s24uF1c44BGhGyuwSCisGAQQBl1UBBQEBB0DIPeCzGpzFfbnob2Usn40WGLsFClyFRq3q
 ZIA9v7XIJAMBCAfCwXwEGAEIACYWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCaEbK7AIbDAUJ
 AeEzgAAKCRBI8My2j1nRTDKZD/9nW0hlpokzsIfyekOWdvOsj3fxwTRHLlpyvDYRZ3RoYZRp
 b4v6W7o3WRM5VmJTqueSOJv70VfBbUuEBSIthifY6VWlVPWQFKeJHTQvegTrZSkWBlsPeGvl
 L+Kjj5kHx998B8PqWUrFtFY0QP1St+JWHTYSBhhLYmbL5XgFPz4okbLE0W/QsVImPBvzNBnm
 9VnkU9ixJDklB0DNg2YD31xsuU2nIdvNsevZtevi3xv+uLThLCf4rOmj7zXVb+uSr+YjW/7I
 z/qjv7TnzqXUxD2bQsyPq8tesEM3SKgZrX/3saE/wu0sTgeWH5LyM9IOf7wGRIHj7gimKNAq
 2sCpVNqI/i/djp9qokCs9yHkUcqC76uftsyqiKkqNXMoZReugahQfCPN5o6eefBgy+QMjAeI
 BbpeDMTllESfZ98SxKdU/MDhCSM/5Bf/lFmgfX3zeBvt45ds/8pCGIfpI7VQECaA8pIpAZEB
 hi1wlfVsdZhAdO158EagqtuTOSwvlm9N01FwLjj9nm7jKE2YCyrgrrANC7QlsAO/r0nnqM9o
 Iz6CD01a5JHdc1U66L/QlFXHip3dKeyfCy4XnHL58PShxgEu6SxWYdrgWwmr3XXc6vZ8z7XS
 3WbIEhnAgMQEu73PEZRgt6eVr+Ad175SdKz6bJw3SzJr1qE4FMb/nuTvD9pAtw==
Organization: Mandelbit SRL
In-Reply-To: <cdfcd722e1f8527809d89e13484bcb25d3e74947.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2025 10:54, Johannes Berg wrote:
> On Mon, 2025-07-21 at 23:17 +0200, Antonio Quartulli wrote:
>> In ieee80211_latest_active_link_conn_timeout() we loop over all
>> sta->links in order to compute the timeout expiring last across
>> all links.
>>
>> Such timeout is stored in `latest_timeout` which is used in the
>> time_after() comparison before having been initialized.
>>
>> Should the for-loop terminate without ever setting `latest_timeout`
>> we would even return it in its uninitialized state.
> 
> It's really not plausible to have no links at all though.

I imagined so.

> 
> So I think if anything we should worry about the
> 
>                  if (time_is_after_jiffies(timeout) &&
>                      time_after(timeout, latest_timeout))
>                          latest_timeout = timeout;
> 
> comparison, but for that just unconditionally setting it to 0 is really
> the wrong thing to do, since it means you compare to an arbitrary time
> zero here?

We are looking for the maximum timeout, so using 0 (minimum possible 
value) as base line should be what we want, no?

[note: I am assuming 0 is not a possible timeout value]

Alternatively, we can just skip evaluating time_after() when 
latest_timeout is 0.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


