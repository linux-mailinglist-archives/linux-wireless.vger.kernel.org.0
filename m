Return-Path: <linux-wireless+bounces-11727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12083959618
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 09:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC238284112
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4474D1B81A5;
	Wed, 21 Aug 2024 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T1I35gDN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A11B81AA
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225384; cv=none; b=KX9FX6/7T70clwcwnNZXBqQ8nIkK/906O5UCrPKPHzjJkU+9GYcJF5i0z/J77UT+H0g0OEQCh//ejeooVWrczhn69QdgAB+PRdjKCmOrtu7Mbtj9tJT5uDWXyXbHhtd+UJ/J5gJKNrLKaDtwW1KgbLZOa1MfW+1IfB04YTvAb2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225384; c=relaxed/simple;
	bh=CXsMjHtViyxnXvurkLsmDZhKvM+hxio+5Y21oNTilug=;
	h=From:To:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ExRqOK+n1XbAxSwYcTK69JFOmk6ODu24r47bmmXwL9JgK8c98qN+USd85jWcjuaGkD1AnDmxoR7vEvMpzz+T+DoMMcj5mc4WypaR9cDQo/+V0BsFGzCAZJHlVq52ITeULYkQA3bGImHydHqHPQzTq8B3afgSAOWLyddh+PcL2TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T1I35gDN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so813672466b.1
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724225381; x=1724830181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LViZ5W//qjT0bseWlRdDR+ofHchDTbNOWpLQNl1QIyI=;
        b=T1I35gDN6hW/sjDAW+JX4ziUrSJgppAeucLXKxYU7Rz2gpJ+nOPwQeIq7o4HnFlI7v
         Tjg12XcQMaLziZzprzrSoMN786blfyHCD4k4f77Q8ia4Y4FImEWdYjctS/cWWZf9SUuf
         B4dbgbiY8TfjUcRVby230f+OI5Hvd+TuRCNIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724225381; x=1724830181;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LViZ5W//qjT0bseWlRdDR+ofHchDTbNOWpLQNl1QIyI=;
        b=fU26uHfb3B1ZfLcdi+X/uFtAGUXKsiTzj69Tk6tMHzjfqiLZr2IJ9UDT/qTgV1QY1T
         8yzcT250edqlzYdnCIFgYUEhiUDxqUrvFrB6l52pML9Hx73927+rbM8u3Nm8Id5XjTuu
         XJFnqhPpApZzQw5RxjDNg0qnHoWJY8Hhr6mJrOPNAZD1qj3J4/u/TKp3PFoDFkjmHuv5
         Vv4am06eYljUqhJTlqj1RZ6oBGJOcN28Vv3TOXQ6py1y8No3Eu4DBPaxjpOyo6P7W/+p
         ySn+njSsOjHjaeAMLUV289ancjQ5kr2sv3twVG/95qGAc5ouvkLabXszIVE+qVPmLn4u
         KhNA==
X-Forwarded-Encrypted: i=1; AJvYcCXP3hOiBuaVVWmVwDacbmEtgmAIH8h77OY+6ILrn+6CRiICXUlkqf60/xS/c27fXWbmrxDiLMX7mOyaRkP7SA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhs+0DBrtmVi+Qn9wrwLMCNKfNQmAWHVsLY17POzNESqLt3XW0
	rV/n7U0wOG55hoVA2+IYCQ+NXe3P4BAdChc1x9T9xySzqQqvpaDZCHzvcR79Xg==
X-Google-Smtp-Source: AGHT+IGKn74dxV2xpiUd9ElOKk0FOMWO4jT/VEVtlz36cLm+Fq+nLXczxRXRbPVXS8a8j/ROdHSd5w==
X-Received: by 2002:a17:906:cac8:b0:a7d:a0d0:f5c1 with SMTP id a640c23a62f3a-a866f9d965bmr97484166b.65.1724225380332;
        Wed, 21 Aug 2024 00:29:40 -0700 (PDT)
Received: from [10.195.133.28] ([109.37.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396e0edsm856400466b.222.2024.08.21.00.29.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2024 00:29:39 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>, <kvalo@kernel.org>, <johannes.berg@intel.com>, <miriam.rachel.korenblit@intel.com>, <erick.archer@outlook.com>, <emmanuel.grumbach@intel.com>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Wed, 21 Aug 2024 09:29:39 +0200
Message-ID: <19173d75ab8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240821070257.2298559-1-ruanjinjie@huawei.com>
References: <20240821070257.2298559-1-ruanjinjie@huawei.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH -next v2] wifi: brcmsmac: Use kvmemdup to simplify the code
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 21, 2024 8:55:44 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.
>
> No functional change.

Thanks

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Update the commit subject.
> - Remove goto lablel and retun -ENOMEM instead.
> ---
> .../net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c  | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)




