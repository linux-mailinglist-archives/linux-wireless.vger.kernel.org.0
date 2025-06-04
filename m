Return-Path: <linux-wireless+bounces-23691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F51ACDB26
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BD93A51F3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA54A28D83E;
	Wed,  4 Jun 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cCCxYB/u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1428D836
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029925; cv=none; b=V7oh+ltxTQyI+O6Tl3Qf26YxBRC/glyxN1XMXJDBzyr2SHJ2SDLmVci1j1f0h/Am8zoGswjNDqCDAPWCM9dnYssvmI/69Nq88Y2ZlFyaJeQfML1+VoXf2hlwMD0l72+F1ox+M4JTOT4QJ947ibwAOObb6XXDypiufuLtyOVLS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029925; c=relaxed/simple;
	bh=bTqY3mmXzyFFv9EYPhTXt1gNNUwtUBEVMYKoCDpcjTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HspJPHnDMeGTMr6+rnULlGXMyKVBo2USyDh9FYTEwXPI1uwQkZNBNQGFZ1AFFEXiMsWP4uitQ0JtGp7L8TCvST1cGgg7s6GAKSu81lxFqSGPLbWx81cfGtnI9iM6T70TsifOAOzMUHvSz8zoKm8F//JaeJTRF/h2MYg8Vj70/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cCCxYB/u; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74264d1832eso7362435b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749029924; x=1749634724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R61rovpELAXLVRfgYuxMxG0BozH+MJff6pqZs/BVTDk=;
        b=cCCxYB/uNMgdNIIRnydCQt0yLI6Dsy3MTqo5D3+Sd3j8rvlJLMzPZp+luRQuOnpqcG
         lsbUEmxibL5O0fKoUUuleJWoakiwC2+ntP9EDPahJeSoniCotcdiPS1g9O9mBBpY7ect
         nIqZxXgY4KU7F9LHagV8/b7qmBWcMJtb07pvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749029924; x=1749634724;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R61rovpELAXLVRfgYuxMxG0BozH+MJff6pqZs/BVTDk=;
        b=lYTMbduiJ89CRlcKCqUGaTYylrboHhUi9eIei6+/yYC2ay0ffSqJ9j6HgnQwbSrIhW
         ykIiczPpD4U9U5YCAgyJ8PVN7B4CaO0s6k97Mhhv/QnOuqU0rp/rxGIP7hEwqBCkW52H
         Jqp+VwNHJGGrk2vcsfijXD8gcxmeE/gM5qkF5fvFOM+rpF4pXTRHKsjoa3vFT3pHLUsm
         r/BL9D5lwpAo5dnuN01tuv5Gl2uGrgKZeVGZKIu/J4uLjFvYRPLCaAgNr4fBBt+Fa8RB
         4Y71nQcBZYjsoG85zgEQifIBsppHN9e76l9mUfvNi1NGFt5LHYh2CJitOmMAwhgK3ePv
         dbMg==
X-Gm-Message-State: AOJu0YzoakhzadjwoYf00UJz/xwNLwS+LfNfIZCPjCTHlQQUmi6ZdnMb
	gR58nyut4U0ITQeUmP9Mtyhf4L+sW5Q7zWvgtkYnqGYAqAYhVDrPdW1JIcss7SJ8/w==
X-Gm-Gg: ASbGncuIfdD0jPTqFJGw+v2Msjzhz035+vGNaO63knV/DRWThisxGo/O+FdgBJ00Hgu
	PPmCidm0zm0Wbxr+2r9COLm7Ium0JGqGH1SRZDpGQxPm/voGZ8F27c9uzfPWCuE9GB95WYu4agg
	pwT8MXGCLgjPsma4qAsF4cjBHJQFnSIEgz/E8mViiEIDGgyxg+Fi3DQCA031RrqQFvOipgzpHUc
	turQwgMkLUGxrVx9mbljo2xRUkY7DOYQOQeveG5eoGspLpbEaIPTuBqta8the/WMZYY8ER+7aQq
	aj6UuWUKGpvz9qNzi3MPGoVenpD5F8xcyguJimXP8GOJoJFDKy6iWFSVspx85Ar6HbXcPX/mQSH
	4irBsgH0y5FZAR3p6Hlx95hUK
X-Google-Smtp-Source: AGHT+IEOoM1fMnixwVmmnzP7M0aPXxsStlj0wscerdIiUBfyKFMZyvnoKZ5z3eILaYW6oMAXEetXNQ==
X-Received: by 2002:a05:6a00:39a4:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-7480b1f26efmr3900127b3a.3.1749029923603;
        Wed, 04 Jun 2025 02:38:43 -0700 (PDT)
Received: from [10.176.3.8] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affaf9e5sm10801847b3a.86.2025.06.04.02.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 02:38:43 -0700 (PDT)
Message-ID: <c393c4cb-ac13-46c3-973f-e123f603bdd7@broadcom.com>
Date: Wed, 4 Jun 2025 11:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/4] wifi: brcmfmac: revise SoftAP channel
 setting
To: Ian Lin <ian.lin@infineon.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 carter.chen@infineon.com, double.lo@infineon.com,
 vinoth.sampath@infineon.com, gokulkumar.sivakumar@infineon.com
References: <20250604091629.3943-1-ian.lin@infineon.com>
 <20250604091629.3943-3-ian.lin@infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250604091629.3943-3-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/2025 11:16 AM, Ian Lin wrote:
> From: Ting-Ying Li <tingying.li@cypress.com>
> 
> Fmac need to update "chanspec" iovar for each SoftAP creation
> because firmware will update the chanspec to current bsscfg
> for each bss. If it doesn't update then the wrong chanspec
> will be shown on the result of 'wl -i [interface] status'
> command. No need to handle channel resource reusing for mbss
> mode by the host driver, it should be covered by firmware.

Sorry, but the wl utility is irrelevant to upstream driver so that does 
not count as argument for this change. What does iw show?

Regards,
Arend

