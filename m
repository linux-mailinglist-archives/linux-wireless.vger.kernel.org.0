Return-Path: <linux-wireless+bounces-7346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6448C032B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D11C1F20F8F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91912B153;
	Wed,  8 May 2024 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1hS5wSh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A96012AAE1
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189523; cv=none; b=Ym8FJBWTlYi7ay/CzrXeLX8XChvoxiwmXmZP8yMKYs0fC3YzC98Lm+tSfHsI72JFaUfXU82YWYiGPlEw5O2Wc1/StIXZlbgaQ8rbTos0VVDKxmPW2tcu3rE4IsVS2/xNgiZBFGAcjN3g+5I0EbWYxKFD1x7mf/wJrwIvOSwelAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189523; c=relaxed/simple;
	bh=h71adRGMua6fsLcVFc0iWoshhPMTSlTYWP/WRSPlKSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHLNvkrjRytbFHYAVrQVO4ycWaYo3AQuaesLJBpWZIIeIQlTniMaN8Um5YWrQfaUe8fX9ox1M+em4uN3vhJ0pmZqy/+yEvGDxmcveIg6cgpe0bVpgljqVDANPcUUlG4UV6NgcywfdnwxqCwEvnfuPLYM1fXPf2llTpbQBSqeQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C1hS5wSh; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cf8140d0so945969666b.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715189520; x=1715794320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H03hzERz4JoxgCmruYHpPPyb6baJd5J6GUwTegv6RDc=;
        b=C1hS5wShF8UKL/XzZm+OfSjiyV3Xo/1DrH96UfZtT7ZNqubcuT1ngUN3bmOOMC6ACG
         g4mxmo4IecwCzLvhVSNykGLjciDCb67jl3hyA+s23pb9Flw2Olryz6VgTbhHWe95c1gA
         0lIyOo0jvnxyv4M3pFHkuFjT6Pn6AyYXkeRBl2bdYndebgX2gZWFCc7tgxGwmYp/lv0A
         q0p57mbAJEMqE4fO6B3SV/HnqDsjMAxU9FFuh3lnDJTtZsANO7T0wLUqNkCawHamsdED
         VkVSp5EDGz32GFOSZTGiUGWwNL7iKow9d+7zd2VDbD4z3PU0RoADiABmlu7qSzRLA9xw
         F+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715189520; x=1715794320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H03hzERz4JoxgCmruYHpPPyb6baJd5J6GUwTegv6RDc=;
        b=r5MIr/+T6IVBBf5tYe0uCikKdsTE3McZkbHA7ltdVbPzcqPXhlPf5FQO6mCzxmr8Zy
         EOIETA+bEgWqV9Pl9mYVphzZXQh6BcVIzA5g1ksvXIvlWrR5i7j7R8LiN+7eIB2JUcz7
         4+ZBgUPPYxR16jsr/pNG60xAKd3Bu7NR6cd2GLucBPcbfQQvs1uyyziMhF0ivqtq5CIO
         dAzD9KWpEzdHmFzxhyk/p0gazbLXGQ6f63gwkyHHOA3DnfmUIPKu7HCtzDPgfX0lmuM/
         PrpmChG0/tld33VPWB+MeAPkGoVVuEFVdGYZP/JewLqU5uSrD7INcNZ6FIa9CB62Np2w
         Pr/w==
X-Forwarded-Encrypted: i=1; AJvYcCUeLEs+NQegVzgNy8Pg7SnsfBiHfp46rvGyQawunu+gKoVB1jprU/VycH0ZS7KZBWFrrY4RiYWrPcl2AhjLBhY0Uwf6fmG2viTYHtlN9hQ=
X-Gm-Message-State: AOJu0YwbjcQpxtsrGX9fqJQ4TIVONqVrQJ4Dxvs69xCVYUJPi9zU30Q0
	wGysSdKSDrhbfC40UH6UkgROnDMry+KBX1vXgo6L4QHAkBxvx95wFvvrz/WMmEU=
X-Google-Smtp-Source: AGHT+IGSX5KYRRlOmtsIHtQh+KlGgLx9KF2+R8ni4Fasp/0KFSTJ1kLt8TkaHr7EIcs++L0+0+8LZg==
X-Received: by 2002:a50:9ec8:0:b0:56b:fd17:3522 with SMTP id 4fb4d7f45d1cf-5731d9b5d13mr2395210a12.14.1715189520241;
        Wed, 08 May 2024 10:32:00 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u1-20020aa7d541000000b00572eebbfc61sm4848712edr.35.2024.05.08.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:31:59 -0700 (PDT)
Date: Wed, 8 May 2024 20:31:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: quic_bqiang@quicinc.com, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: Re: [bug report] wifi: ath12k: flush all packets before suspend
Message-ID: <d642bb50-5d79-4968-a001-13bd075c70b0@moroto.mountain>
References: <7a96ca11-80b5-4751-8cfc-fa637f3aa63a@moroto.mountain>
 <1abbdd0c-d4cf-4e24-9b68-d732b07300ff@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1abbdd0c-d4cf-4e24-9b68-d732b07300ff@quicinc.com>

On Wed, May 08, 2024 at 09:51:33AM -0700, Jeff Johnson wrote:
> On 5/8/2024 5:29 AM, Dan Carpenter wrote:
> > Hello Baochen Qiang,
> > 
> > Commit 692921ead832 ("wifi: ath12k: flush all packets before
> > suspend") from Apr 22, 2024 (linux-next), leads to the following
> > Smatch static checker warning:
> > 
> > 	drivers/net/wireless/ath/ath12k/core.c:58 ath12k_core_suspend()
> > 	warn: sleeping in atomic context
> 
> Hi Dan,
> I'm not seeing this as part of my standard make W=1 C=1
> 
> What do I need to do in order to see this?
> build_kernel_data.sh ??
>

Yeah.  This is a smatch warning that requires build_kernel_data.sh
(probably you have to build several times which takes forever).  The
might_sleep() is in synchronize_net().

It's better to do run time testing.  If you run with
CONFIG_DEBUG_ATOMIC_SLEEP=y
then it will trigger a stack trace.

regards,
dan carpenter

