Return-Path: <linux-wireless+bounces-18595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF57A2A824
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 13:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74E31884F26
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A850F22CBC7;
	Thu,  6 Feb 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iik8xUsm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C3418B477;
	Thu,  6 Feb 2025 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843986; cv=none; b=sH6fU77PEY+EzzH2ON+lukr2yJBJRmBEfsTx5isvomUj7Z1KtsoODKg4y7FJLvGNgOY743nxmcL897J+KUH8JLmbWxs5RUmTZupt67OOt2xasirkmhOzoxoluKb/RrOs55xAqSbrECLPQwlKtNvMnlo5vZeIu66+amqBDshN1iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843986; c=relaxed/simple;
	bh=jkqKslU5iaeUw5P1JCvteA2vbVA7QmSYfQYMH6ScSks=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=GZ5xuEdDHHhDdFYb7tR0xouvHyEhc1p2jUtfp7cPG6MiK3vClr2nkmximxfYnqnKgKNmkJQ2rDd657fcrswUx/k5JbPRY47cKU2Z9Z7BpOG854Zgfq1hE67nd4ibfZBYrcIHeIjaGDIb62PSgBsvdO2iesASMgP+KK4BdqcMIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iik8xUsm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38da72cc47bso619873f8f.2;
        Thu, 06 Feb 2025 04:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738843983; x=1739448783; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysJahaWLEfpuza7xgtavoHPxl1xFns3PuCkrhVGngT4=;
        b=Iik8xUsmOOxpvVhuaOEFri42Pke9I/Db7z80D6K/C0ohc3Ffd90pcHSKRHdXh0VEuO
         Es9B3YyH5elKEDAgxkGl4tdQTCrGJcrPgzFAx2vMeciukqbF0N+UYWdIJuhSAn5jDoFz
         AeE7isM+Lbp3NqEP1BkBoUOiqzU7v5wCCeDuLO+dveC2cFGJd22w1WdxSEbmK+rSOZqb
         f2c8a0t70pxsfQb0bEnN87xIsM2bXccRMBRUg9n1pvvvdX7YLtrEq9SVfdq9qzSUVbQJ
         pmozos5sxFY3AcHrc8RAE5uO3SvkJa8iJp9s0rnpPLLmLIIVrxV08cQuKrJ+dwTolAUh
         XGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738843983; x=1739448783;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysJahaWLEfpuza7xgtavoHPxl1xFns3PuCkrhVGngT4=;
        b=lYHYelwdYxogljujkKKbDDqF2vTUVhbN0XjRZbml4mreL6rlYoXXQ5GsFG1xt91jb0
         psLRuwqi28AlGMPkHJBqJbMzKuO0PxK7w9haafLv9fp6cheEZAiCYr43FMB4bYUoy2Sj
         Sq+e8EzcUQLoZZuhlOin8jwWBpHaVw4jpzaEKs4Jf8JJxNhDEW7XVY9v4pzoEZh0RNiq
         rgJ3uQkWpjxVC93JlOPsFhhnyDIn3ViYPXupOaByHTLtv/634WOyQ8kc6VZodCoeIzdI
         tB/wZpJDmWVt6fLOoAlRoYp4Uwi+EWk4o7vuw0PBG6FAsV0GoHfG9OXGcJNz00sYmnOY
         cR+A==
X-Forwarded-Encrypted: i=1; AJvYcCVYmJ5TQl//VuvdeeCH/RrEVB6D6NlnAHXJxp8og6x5U1RWX2Eml2yn+Wd83kd2/NVeIyNUODY9G/NVv+yKZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1BtOGKY2q0jTPyWl6gE29G5MJnN6+gs03Aq2fQ5L/OctS+oR
	sgv4syMPmEpM4i6oOOLRGdjEQObjzcrTGcbGugeBu0Drywf74et5
X-Gm-Gg: ASbGncv08zvxcCvyST8iNKdxnQFVuLJMLlf5e88bU87fOqrJhK7CPfo9LMoa1dOxpUx
	HfFG34ZRgvYFphAMAQpMXgwIpup8dE+DGjCb4B96V6TWti4NV5JbKpLTlNbha9lYqHHlUxLdPW8
	dwJllIa1wXxeM08pUTk7jM7skxe5OnmUSAEDRptCZFbWBPTuazAxBQle7LxN93y0SwisBDfTUGR
	ri8CnY1NbBt6pt/keCZCqm00pccgEfd0waqjI91E99mO5VyyF0brXFAtJKDnat0a/XtD+8Zhhf2
	qp1vNDt/IRVxxycrp8s1xPyvjQnr
X-Google-Smtp-Source: AGHT+IH4JPxboFaXR0Dbn7UK2FmPITpsmJ5wUi/0wrK01F4fk7C0AQk2RjbjIYiLWM2j0/CUoT+ivw==
X-Received: by 2002:a05:6000:154f:b0:38d:a6a1:2edc with SMTP id ffacd0b85a97d-38db48b4637mr4859950f8f.9.1738843982937;
        Thu, 06 Feb 2025 04:13:02 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:c428:5404:970c:34c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd36378sm1603730f8f.31.2025.02.06.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 04:13:02 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  linux-wireless@vger.kernel.org,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 10/10] netlink: specs: wireless: add a spec
 for nl80211
In-Reply-To: <da75ef6287d00bf5d1200118bd48d46d11d45607.camel@sipsolutions.net>
	(Johannes Berg's message of "Thu, 06 Feb 2025 10:43:45 +0100")
Date: Thu, 06 Feb 2025 12:12:50 +0000
Message-ID: <m2v7tnxoe5.fsf@gmail.com>
References: <20250206092658.1383-1-donald.hunter@gmail.com>
	<20250206092658.1383-11-donald.hunter@gmail.com>
	<da75ef6287d00bf5d1200118bd48d46d11d45607.camel@sipsolutions.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Berg <johannes@sipsolutions.net> writes:

> On Thu, 2025-02-06 at 09:26 +0000, Donald Hunter wrote:
>> 
>> +    name: feature-flags
>> +    type: flags
>> +    entries:
>> +      - sk-tx-status
>> +      - ht-ibss
>
> Oi, I'd really hoped you auto-generated that even with a one-off sed
> script or so, but:

Yes, mostly done with editor macros.

>
>> +      - ds-param-set-ie-in-probes
>> +      - wfa-tpc-ie-in-proves
>
> typo?

Good catch.

>
> johannes

