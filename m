Return-Path: <linux-wireless+bounces-22052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B9A9C249
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EF83B9A9E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB72B9A7;
	Fri, 25 Apr 2025 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PyGZ875F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C517AE1D
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571177; cv=none; b=mzLqbFCRdpUHpkJRXCfyeI4hUnXpL5JNL/0BcrXUTzzusyT89SxO180Ww2e/pbXXB6nPgh6cEPihFkEl3fITuarbkau0b0qmA61uRld2jBZ3xjSccVU26jgD7Y3UJ2ArzRW2zs6JQKKNRI+zKnvU+oWMV7LUO6mU96rfke08z38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571177; c=relaxed/simple;
	bh=wOknFun8vvCNi5rTuhIalm9N1+tTgbVpmOUmbQ1mYEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7Yw09p3YB1WuxEre5YUL4KCvfXEkZxPoWWwQZnIcrXegn7gOL4oMlvhjsj9taP75f0JB3jB6pmxfYNM5fd1DM0q2A1RMne++oHtGB9+FpiafweJQPgL0+Xu5YSJaS4zlB2xyeLq3zJ/TJescqiQcVWbLZdRtIMYm7ZSNd+CP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PyGZ875F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736bfa487c3so1575819b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745571175; x=1746175975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F3ijAtwm58urWDhiH+VcJS1gPBR6GMMnfVVS0gX6wiw=;
        b=PyGZ875FytWcd9Xv6eSS4kF2N0Ljo6irSoFS9w1/iY6mN5xfjUovItJcSz7jb/10mW
         O9T6DTDaNjaIAZ6xhgt/dfzseTYPL+Y5LsU+4PUuR5nM5b7D8l/D8SRguQcUcsMLPH+Z
         ySl0Ze6wxu5ruAJvM259CpM/OZMyJrBhKsZ4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571175; x=1746175975;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3ijAtwm58urWDhiH+VcJS1gPBR6GMMnfVVS0gX6wiw=;
        b=MxSmwCdYrBVYjYkQ/cCCfa+YTj9A4Fl5xf0BDCghvASGZJD2GD3SF7Gk1pvo24h4hg
         jlBQA73y9EEtOFU9KfEIyfmWur0nGt/9zIsSUokuYs770F3smg4Myd/+/tgG1jMg+bsY
         dtFRmgPaYY5brzvhGffCIalW/2LXBggK8Pkom8Y3fy/J6fXiomVXleep5MvOAo65bSaU
         0HdtEFZK320sDGx4pqCZYoygT/TRxyIU7lIhwIghfxXSpB3DfhQWWZXyeHs5VxLNNdgu
         pCcEUKU0UzS5juzYSkve7qrlUM7FMLJJelmjUd+HPZZncLVUflEYducUSWE4+xKgyTeP
         CcMw==
X-Gm-Message-State: AOJu0YwkO5kokgeCd2D2rS0DM15Ag31zcCpU77jsCXKjE1JBn8lQ/6ID
	oojlx5MnxCgKdpaZNhEYCEPIE12ZK07zIuWYazHma9U5kUnFQFcWCslE/Tuhkg==
X-Gm-Gg: ASbGncu7TDJwHThTWsH/jjiaoCYPA/Fo0izeshS5nwNtta5qlMMIX3bDBXUx/QN/LNZ
	T7RCbCCQqlzE9wqxcvH3M2Qs2HtUE5duiq+yG9O9E/MqzZ4dlm3OCUmehc/f3cSGAAY4DEcLqjU
	nyRC+gnTM9qaoxa9ZUnDOZVI7FMrVsaloHW0Pq2SwJ2WTkd990eTJhBWe4K59xmBKnCJCMGskVf
	MuFUIorZhFPxF/yhKZO5HWn8f3h7MLslKSbi1CKj9N0paoeCCuNdJCRqeELlHoHSEpFVAHepeDL
	cXtztgs93lP0Uo/GoUGMOadIDoHNQeL43hEM1jdB/Y4hW92Xh+M6/xygivJjsNqkiLQOZOLv0T2
	7D37DBbqv5txnHQuCqEwqE73ZPsk=
X-Google-Smtp-Source: AGHT+IESppfwTh+mbIGQfOpE5IHWQQ8kCFI4HqsV9dNdmGPrtsg/CZuAWjzTLsrvQdxNwgQiYyxi7A==
X-Received: by 2002:a05:6a00:194d:b0:72d:3b2e:fef9 with SMTP id d2e1a72fcca58-73fd8e5323fmr2173179b3a.20.1745571175578;
        Fri, 25 Apr 2025 01:52:55 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a3casm2758114b3a.96.2025.04.25.01.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:52:55 -0700 (PDT)
Message-ID: <18407c0c-bf4b-4bcc-b029-831c23a8bbdb@broadcom.com>
Date: Fri, 25 Apr 2025 10:52:49 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 4/4] wifi: brcmfmac: Fix structure size for
 WPA3 external SAE
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 Ting-Ying Li <tingying.li@cypress.com>,
 Ting-Ying Li <tingying.li@infineon.com>, James Prestwood <prestwoj@gmail.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
 <20250424194239.2825830-5-arend.vanspriel@broadcom.com>
 <850b42ab-a637-4dd9-af18-e12523983ded@broadcom.com>
 <44916ff608ee53238d79e57ee31fcbf86dfb672d.camel@sipsolutions.net>
 <95cbaef6-761b-4ecb-a722-a546bb034939@broadcom.com>
 <c03e8384c0c1e338ee9e874780f684d45ce1f1e1.camel@sipsolutions.net>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <c03e8384c0c1e338ee9e874780f684d45ce1f1e1.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/2025 10:51 AM, Johannes Berg wrote:
> On Fri, 2025-04-25 at 10:49 +0200, Arend van Spriel wrote:
>>
>> Crap. Just sent v2 executing my plan as stated above. v3 or is the
>> mai..eh..custodian willing to fix it up?
>>
> 
> I'd say yes, but honestly I'm not sure I will get around to it today,
> and will likely forget next week. Sorry.

no problem. Expect v3 soon ;-)

Gr. AvS

