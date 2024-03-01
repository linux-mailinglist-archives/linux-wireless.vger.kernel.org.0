Return-Path: <linux-wireless+bounces-4280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F098E86D869
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 01:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9121F23A04
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03903C1D;
	Fri,  1 Mar 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UZAW4Az4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6C2571
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709253640; cv=none; b=pawMkexXzTKerbTf3+8jLxhj1xINwHMHTUDn/EB5QY4oqmqCzy2w2xtyXmHmppo1caIH0KutBktx0Ghr4iU5o79EpL+a3rUZjLSX41/87pMbTc+bsYcR9ESvrBaCvJ4peKxtGG6V0NM6yAsHtjcswY5t1QYf3MSMU2lqJU3uS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709253640; c=relaxed/simple;
	bh=muLgGupmanQwoOkaJ46uTZdhMTCwpFMyxV8hvto3RLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFkpy5VhgBYd6gcmy1lIZoGVkFCp9t4xvhFEo7prSee+RQu+S2eV6R60kmZJxfWA8tMmKDpHADPbxPZStqU0pk/jt1F5FWeH7Ocrrt6fj/0YAWVcNvST/poUWL4fGDnB5wTZ6mIqdCHdKcVLqtdBeZOpvrpDasFdCXoz+yEZYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UZAW4Az4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e56a5b2812so1033138b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 16:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709253637; x=1709858437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLux+aUHo/V4i5EAKecz3RknuLa58zL1C1hJWsd2v88=;
        b=UZAW4Az4iJ8wP3f9OBpYXXgPY/U8beXjkZFTnXJlC8pIWoRutqUDWJNnq8J/Ac5+PG
         884axoo+xguxaWvklp9UTwrJdGHBFE4ngbNc2jSlwGPuoLuCwpUrWaOu+A1jSsLyjKCv
         KQXHiudCSihXgPjFK7nQpSmDlPbILalf4K+H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709253637; x=1709858437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLux+aUHo/V4i5EAKecz3RknuLa58zL1C1hJWsd2v88=;
        b=uLv8hUVYGOfQNwPLC7JpgBK8yrq0S0xf4kjk97h48SgzFD0nga1lnla/No/xw8Anzo
         ELoKC+o5SRhg1RjqdDyvzmdKMquLUkHSZNcsAnv9K0+rDHG9G9o3Ndach5QWxowHrQYh
         eANsyIy55gEUUrbD1A7SliLD20LdkgUb39NfzGxqarrhF/MGr8zBaQFJcnkhcjTiEuMu
         rriGiASEsv9Msjk79BH0mE0mXWy1F9rNSzm0HduC5HVBSSJBCmWV4j2aC4pjGnNplCaP
         SFBQpqtUtANbZrS3ydSL3fYc2SRqk1/pAWz0gvITzPRUPkBpGMkMjBgnBahjtUObkzi9
         WLvw==
X-Forwarded-Encrypted: i=1; AJvYcCXX8TN+VV9FqcYFq5A4AGqlVi38TKPeU0gFbQB6bE0zokjHG5K6YNkV5OBSAwF8G2/dtKWLpGo4P6d9NICIAsxa/RGoTagCJFTA5P58/+M=
X-Gm-Message-State: AOJu0YwjPhrS+f5+TAv8RUJzrHVgcB9248W5DBNadIbiKbqjkgE0qvph
	u8G0bWO6DWiAURuptxDzQ8Xrj9YT/u43BdtRYgksBwvor0VzRIgLCOrE162QlA==
X-Google-Smtp-Source: AGHT+IHFUeR1ugKofHFnvWfCfO87r1lfl6kXIYM4J/RlEeAi/4GNXDb6FENvl1zIyk1SVIFJGbZskA==
X-Received: by 2002:a05:6a20:1582:b0:1a0:d57b:1c93 with SMTP id h2-20020a056a20158200b001a0d57b1c93mr50622pzj.33.1709253637593;
        Thu, 29 Feb 2024 16:40:37 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090ad60800b00296a23e407csm4249537pju.7.2024.02.29.16.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:40:37 -0800 (PST)
Date: Thu, 29 Feb 2024 16:40:36 -0800
From: Kees Cook <keescook@chromium.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
	brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
	justinstitt@google.com, quic_alokad@quicinc.com,
	jisoo.jang@yonsei.ac.kr, petr.tesarik.ext@huawei.com,
	hdegoede@redhat.com, johannes.berg@intel.com, kvalo@kernel.org,
	arend.vanspriel@broadcom.com
Subject: Re: [PATCH v3] wifi: brcm80211: handle pmk_op allocation failure
Message-ID: <202402291640.9AAD719D3@keescook>
References: <20240229103153.18533-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229103153.18533-1-duoming@zju.edu.cn>

On Thu, Feb 29, 2024 at 06:31:53PM +0800, Duoming Zhou wrote:
> The kzalloc() in brcmf_pmksa_v3_op() will return null if the
> physical memory has run out. As a result, if we dereference
> the null value, the null pointer dereference bug will happen.
> 
> Return -ENOMEM from brcmf_pmksa_v3_op() if kzalloc() fails
> for pmk_op.
> 
> Fixes: a96202acaea4 ("wifi: brcmfmac: cfg80211: Add support for PMKID_V3 operations")
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Thanks for the respin! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

