Return-Path: <linux-wireless+bounces-25767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAEDB0CBD2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815DB3A7823
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F361D22D785;
	Mon, 21 Jul 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="KLTyLzcP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265711DE8A8
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129578; cv=none; b=IdjJOSLlmFpCYUg1HB5Qkekb9LznBTmV2ZbT40dmoKJx+tlxFYjGPBRhK4LphupJrfEP6dVfdG5iWdjY3CYNhfpIoV5JI6Ej7bB7ptsqODZnq4gpfRa3CVhSNdoxMTKY21wVyETVBRA41Aobr1qeDL9Xd3suOxDapL87/Lr9pLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129578; c=relaxed/simple;
	bh=IqnijroTydVFCtOvpyIp9iWWXTrbBekXqbBTfllmUV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShxkOD7ZjmoOjANLLQj5lVJUZ+HWbcshPjfa5204F++VazyqFAyf7OU1QdjVygPRmjmicE6aQKKIXP7lxw0UhfzRoE665FYz2NCdDD+0SRBpZ3Ca/Is7gU2khRhNZxL71wk4FWhpq+x1J2LzBfx2BFiz60rwPmFeAj44j03X4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=KLTyLzcP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so796724866b.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1753129575; x=1753734375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kul46oDGMySL80RtDbXtq1ttSr9peNcRDa4ByzOncDM=;
        b=KLTyLzcPZD9oBkI/y0HmmGDD0x2oJtUHhFMwhgT4tth0F3H/qwaWufip4ZckTXah+l
         3x5lCydbYcntWXxqmWm6OxepqVNV4z3dUIcpO0ZYwDNIjR3yS/KW+w+jHQNMSk+Bw8xu
         QqJbV8jyQbZYrywtmNj92aBNY6pXstDP3ImFAwmKJ7fGJnwW+m4Aq5ESL0c+LKj7yfKw
         mdOH6OBwOlZDb7EaJopZgal7kL3DQ4MrD3jPrR8SidG9wNWM0nl7GRhqSacKsMW56V2a
         cCWWUa1hVZPswwMCQBA2t6Ik1KfpL9Fc1Z/8aU4RBS8Cpz+JzbhzDMyR35o5+p+sgoVW
         F/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129575; x=1753734375;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kul46oDGMySL80RtDbXtq1ttSr9peNcRDa4ByzOncDM=;
        b=TdOzUdHNmsa/v37W69suensUZvGbxhXYqy+Pe5gMumX8qpkLGXACilm054/nq2H8BH
         uz3f95xyMPAu9egWwVg0MtqCh8ohD9Y727z4zEu/Z08N77g2DWS4Z14f1BrC2Pc5YQMH
         I1Z5JukB9ah4GVxzJBbul2v8EaV4fICy8gDSlrOOOx0aZmLYjAC0TrWfXH+B/2wsrXNK
         RV6qoSMteeOkmwloRzHnzJnTCfk3KoQD9xmmTxgAFqSVoaCS/ewzJ56siTII2+XLxUPu
         TS4jEoQa6MME6u2KsKrpyuOf2txwKTWGrsTlcBUeGxww3y3f+VBA0d05cZMQQuIPypuj
         LRaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjfREFhsZ4zioVy+jfDt32yCr1LXHegeZbhudxsjsBoPnBEsMXBc8hsBeCTZl6y0UKFrqA02MewfYCsQOCMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLdXvt2dBFEwVJZ5qtI3ISbU2p20xSW9tVvb+IaUXG0wrm6YAq
	D6cIbvHwzJqZsl2cFYiaiXfiN7/hTfJ6hPGJf3NSid3RDyfewFzEFvXvYKVa6a+1+Ys=
X-Gm-Gg: ASbGnculUWgBbbJGsKW8vgUAxJkmASavwgtVbnt2xZLeuMaO6oo8M24Przz/qKpnbAe
	LhHFxEZnHyhPV3gsJnkSVKUVuPJFi4nSfxv/lpNkNV8U+eKukPcFlsY4xj4g69JYNrs9ng0F94p
	Ssx1ZbiGRXYEssB5yIB7eQ+uVTOs5HtpN2zetD2SxiaK8QVXv6xXslDuYJ6yPtZKUdDE1r/T/RG
	pMfjehzSyzARiPvugPtnlH1w7v1qm6ScLW98HsL9rxBXyRgETJIM0DEXm8DPBwiXdYodbeQR6x/
	MngyEqAzKWBhon/F2J80RZ/2gGXIIzkCwWYJKdIOx72jy2xQHyWQ6CUN5GufekhdkMU+GAt/Fa3
	hhdZxfgE8MrSQTdAVOtQaJZcVeWCeltkR6GgFIISzMxQpqHKdkhifGPkEqw3WY+0=
X-Google-Smtp-Source: AGHT+IFYzJpWkQpNRYDA1dYZoGSYSR0oRqfqRVtzaMv9KEuGfKU2u28lfqMN3NaB+tUj7vNJyuQGxw==
X-Received: by 2002:a17:907:9816:b0:ae7:17df:d8da with SMTP id a640c23a62f3a-aec6a4e8a71mr1410576066b.24.1753129575226;
        Mon, 21 Jul 2025 13:26:15 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:834d:bc8d:cdb5:bc29? ([2001:67c:2fbc:1:834d:bc8d:cdb5:bc29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d5255sm733030466b.40.2025.07.21.13.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 13:26:14 -0700 (PDT)
Message-ID: <ef83d87c-7bde-4fca-a4ae-9d84c250cfb2@mandelbit.com>
Date: Mon, 21 Jul 2025 22:26:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: fix cmd length when sending
 WOWLAN_TSC_RSC_PARAM
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Berg, Johannes" <johannes.berg@intel.com>,
 "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
 "Coelho, Luciano" <luciano.coelho@intel.com>
References: <20250716201911.700-1-antonio@mandelbit.com>
 <DM3PPF63A6024A9D3E27E675C13CDAF6DD7A35DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <DM3PPF63A6024A9D3E27E675C13CDAF6DD7A35DA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2025 22:21, Korenblit, Miriam Rachel wrote:
> 
>> -----Original Message-----
>> From: Antonio Quartulli <antonio@mandelbit.com>
>> Sent: Wednesday, 16 July 2025 23:19
>> To: linux-wireless@vger.kernel.org
>> Cc: Antonio Quartulli <antonio@mandelbit.com>; Korenblit, Miriam Rachel
>> <miriam.rachel.korenblit@intel.com>; Berg, Johannes
>> <johannes.berg@intel.com>; Grumbach, Emmanuel
>> <emmanuel.grumbach@intel.com>; Coelho, Luciano <luciano.coelho@intel.com>
>> Subject: [PATCH] wifi: iwlwifi: fix cmd length when sending
>> WOWLAN_TSC_RSC_PARAM
>>
>> In iwl_mvm_wowlan_config_rsc_tsc() when calling iwl_mvm_send_cmd_pdu()
>> we are accidentally passing the size of a pointer rather than the size of the object
>> pointed by it.
>>
>> Fix the expression in order to pass the approriate object length.
>>
>> Fixes: 631ee5120285 ("iwlwifi: mvm: d3: refactor TSC/RSC configuration")
> 
> Is it the right one? I think it should be:
> 493681d9f95b ("wifi: iwlwifi: remove support of version 4 of iwl_wowlan_rsc_tsc_params_cmd")

Hi Miriam,

you're right - I got it wrong.

493681d9f95b is the real offending commit.

Can you fix it on the fly when applying the patch?

Thanks.
Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


