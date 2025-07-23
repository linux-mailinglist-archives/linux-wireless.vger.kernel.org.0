Return-Path: <linux-wireless+bounces-25928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540FBB0EE9C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6668B3B70AF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3F288519;
	Wed, 23 Jul 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OcKagD0T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2BE28750C
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753263689; cv=none; b=T9s5uxP0V8JhjXVdHnyUIOcKxWFi74qbMFuj1557yX0XEv6zEOqURcfYvHXUOyaJEa2F7XxCAoGM4msR5q9HOULhLNJAT+PQaxt+W16u3q4xS+vurcslFSBU8Was6eGnvBbjVxwzYXmMk1J/DKj/w3Es7Td7IAeh2n0cz+uzMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753263689; c=relaxed/simple;
	bh=Fpdmetq8rTUEqq9WkszaFi7bbWvejmQcpH5dX9vmY9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEJKsuRN6GyNfyIDs2nH1KLz0RHetz+gN0/gXV0msyWJOvS19w6NXZkVtOZ8+WmVBKYkNX/BjMePTIywCjc0mtHng/cB30PshX//63GkTBcAUs9XxT53/QiShMAwTul25rPdSfJOrBL7fOWv8vCbK663zxGTattxxQSK4uGEgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OcKagD0T; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab60e97cf8so81080401cf.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1753263685; x=1753868485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DQm6k6GRfRb1Tj7sFMA4AF0xS4uSgjz3/cpurFAQcNU=;
        b=OcKagD0TiAPBI+edj4xGiwQZ3O0xHrlgwAGt+Ke63PlIQ1e43RjIiqbV2oefX7fUit
         1nyNbbtv2T4j7T17soUbg+tXXaXhsdS6SwAeRJSbZITGL23ThaX247AGdgIIX4A3r2cM
         Ms78ACrbwWQLzIBfRAuUzyuZrhrZhvh+wiYvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753263685; x=1753868485;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQm6k6GRfRb1Tj7sFMA4AF0xS4uSgjz3/cpurFAQcNU=;
        b=EWQf0wCwY8fFm//cVDPbbQPf6wvZAAbDW+iiN5bFFlXZJVbwdOfX4A1ihJw035ecsA
         KKbflEc32SLvTxoIjqvYEoP/AVBhEXwnZg62dn4RgRDGIFivdLuDQzQF+zNn5DzIy1sC
         hXLqx6yiPxX1LB+lSIhKzhROVc5hixp+7bwDq55ivX1iIJ1Oeh/w5zZ2Or+lSpASNp84
         i/uitq0Wee2dOOXhcsWUzdE4ucz3aI1oYQ0cQaBChYzMPNx1YEb9CZJ7d+Q4JCv60//4
         D2MPrj396urwbfi7lXqGLqzWGuDCfpN8a6st0i+bqqAk2jEFIy5wRjhBvR51Hy3jmLJe
         bXaw==
X-Forwarded-Encrypted: i=1; AJvYcCX4F2Ez4TmlF9yUDHo2bvisXCzAnGi1wuRZR/oYP5ZbuHAWrBDSNTuh8wwJ9+W1hZ0ryGH3LY9/F7aJnS+nGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY9FCarwRl0d4LbvpyUEkEb69N5VBRhp4H22lKSzlvhNlU4UT
	1ma6uuxcfXfjz8m0GxAI1QJKhW3OnywjSHV0YQu3DBvaws627uZIJynowlQPsRoiFA==
X-Gm-Gg: ASbGnctj/jZ0J5ByJawV4Aj6h1v0HLKsb1igiZXRHbrWWk/k6kSV36zYhzx4IEcSi6R
	9HwrLELwe1cVKxnbf9vGlpG5jq6nR821OWtNNTjxt9wZK5N4IwYMJwp3lbZtxTvVRfkWSFdb6lv
	okvt18taCJG1hu/1N35ASe3/CR5C4DGQJSxJ9KKxpxwtuByeAsFPL/6yphAvoK8cYDyx50l9qlY
	oiEnO0popk82EIGxgYEhjOdoChZ0Nw+7jF+Ves/BnSlHvMEs1Umct3I/6iic+d63GYoWnV/e4MU
	soc4BdKljuCmCqBSMEg9HmwEWAoLxzSWMGwE087aHL1/GvUYszAsbwSuPM4vzyDvzP1Tuv04Wvg
	dQa8yRXpqQuK17uVlVMF162xOIgVYPLNmGTdJEdWf30HrY2DYO/Q+
X-Google-Smtp-Source: AGHT+IEHPgcqDK0ElwBxJD+Ct77IecKVvreRBKmNCknReGOOR5dFBvm5oE5wCWsiVBuPzM1GPGxc2A==
X-Received: by 2002:a05:622a:164a:b0:4a9:85ee:5ace with SMTP id d75a77b69052e-4ae6df3f69fmr29212481cf.31.1753263685416;
        Wed, 23 Jul 2025 02:41:25 -0700 (PDT)
Received: from [10.176.2.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb499fcd2sm65370471cf.17.2025.07.23.02.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:41:24 -0700 (PDT)
Message-ID: <96fa566d-120d-4501-8926-df3a76854116@broadcom.com>
Date: Wed, 23 Jul 2025 11:41:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cyw: Fix __counted_by to be LE variant
To: Kees Cook <kees@kernel.org>, Johannes Berg <johannes.berg@intel.com>
Cc: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
 Chi-hsien Lin <chi-hsien.lin@infineon.com>,
 James Prestwood <prestwoj@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Ting-Ying Li <tingying.li@cypress.com>, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250721181810.work.575-kees@kernel.org>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250721181810.work.575-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/2025 8:18 PM, Kees Cook wrote:
> In brcmf_cyw_mgmt_tx() the "len" counter of the struct
> brcmf_mf_params_le::data flexible array is stored as little-endian via
> cpu_to_le16() so the __counted_by_le() variant must be used:
> 
> 	struct brcmf_mf_params_le *mf_params;
> 	...
> 	mf_params_len = offsetof(struct brcmf_mf_params_le, data) +
> 			(len - DOT11_MGMT_HDR_LEN);
> 	mf_params = kzalloc(mf_params_len, GFP_KERNEL);
> 	...
>          mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
> 
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")

Thanks for fixing this.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>> 
Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>
> Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
> Cc: James Prestwood <prestwoj@gmail.com>
> Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Ting-Ying Li <tingying.li@cypress.com>
> Cc: <linux-wireless@vger.kernel.org>
> Cc: <brcm80211@lists.linux.dev>
> Cc: <brcm80211-dev-list.pdl@broadcom.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmfmac/cyw/fwil_types.h   | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

