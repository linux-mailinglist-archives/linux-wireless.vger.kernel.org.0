Return-Path: <linux-wireless+bounces-25864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58492B0DE11
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 16:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2561BAC4C34
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BD32EA743;
	Tue, 22 Jul 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="BpIeopEx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836B2EA16D
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193424; cv=none; b=MBjZWo7C34L1Y+fJ5GleWXlFdJHRl04RavkGs4SzXE/pMnCF5beus+mBXtxKqI832AKDY9m67iYn4VCSwkCtnaR1hy5V3X8SbGpHcVh3R/qkoLfRLYkOV0DaJeJdY3AhVr4eCDiN5BQcOxeDlaoL/QjAFs9Lvtx7hmW+g6+teW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193424; c=relaxed/simple;
	bh=RL4VIYhIktQkUMQHkexEcGYfLU95Rd++wNXQv19IO5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kx/viPizeeRX7xORsGmXBeV+Sj1uq7s6d/ewgMVDG51uUa2ZRq8NPpKgArIYZ+6dW1UdusXIX9RnqPXnCrJjAoDioj/5r6+ifIceQ0kzu4qf+4UA1x4wy9Cv2CRB+ecSSMLSUGYWXizmhymSevzgk7T8t19ac8Sf/qKbtzts79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=BpIeopEx; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so4217339a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753193422; x=1753798222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2z57cD3ZbX687ujnK9a2lJC9rLZAg+To6oTLOd4bGyg=;
        b=BpIeopExk7blYDwi1ylEiEQLo/2e1mvvrKUYuxoyeUXlaDQ9igPF61Jkcroi9JErbK
         3Hz36mQ3AwnmU0tCXgv0VAR3NLZh3M7r5AJ7PAbfa0ljYdEcKmVpGarRPwDaXz65vdwc
         k5noEfW4iy/0QR922ztx3Tu7Uwf4LTmdjp3ET9CTMiZsCwOhV9/hLISoLji8hmUj4+b5
         g2GoJrRvlfiLTEk+oygDzh1/ILtq7P7VsYh/uB6a8uss8yKetxXplR6CWl3v881Nm82x
         Px1gUvMBaJCpDFsMFVFZhxNhYTkab7sm4TQ3f53nUoe5XtF4rSHoJrkE7WYTloWatnzk
         gdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193422; x=1753798222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z57cD3ZbX687ujnK9a2lJC9rLZAg+To6oTLOd4bGyg=;
        b=nBtPC/xZwqBzyZrmb/MNkVPnO0AkQANtApFCvaG2JXyXRcQu46fYqKtzkM51GbM+PL
         b2/wELwOVzm4WxHOobRP0E1pfJoRGJ/nKdYXmjJcrpJKPSFjnh4yMFf0kZD+oeEwD6n8
         KKbgd9rlACCiMUO5Xbj5EuJdV65SWOzlNqv/dDMsXKeDZFw3mowCP1RTbqoZvGG9PkMw
         YuPT7iT5rLUg+h3YTMD8sUAkn/ogPgaon+oKbvm9jHgEVhey3OaUD22IsMOzupqruvug
         CX891j4apIUrCp672voVZshUjxa2yDRBtSgdKByD4nyjRPShGcCjVgqumC1vIU4jWXa9
         2jpw==
X-Forwarded-Encrypted: i=1; AJvYcCWVRlN6B9D6vr3eMvk7QdkgANGSOKFosyv2h2fnewC8iggQSA2ankc4E6DPifMtwM/OiVwcE3jXkQvvik7O3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8IS2dmH7SR6PVKT6lasOl4W44NfBMGEdiPSz5EF7GgNQPW8Td
	WhsBIq62EsS3zIgjylPpmFfJwYE7Cp74FEfYNT1djgPXKXco8xHcIvGHKR2fhgeGUvE=
X-Gm-Gg: ASbGncv5jGFBYieYoN2vnyZfAjICqSPEert7ISJ72iYetUH6mfYqytpMINCt2nr7Mr4
	dC24+JG7efBvGMXt8TY2hiliqbTjQpzRzkLhI1erF6t2R75O0I6gA3E5lboj1TiaW7yXi2MjCUn
	/CMo17/+zJx8nyy2eLajJIdbP3673Z1Xe4zlCqK2MiUynrGKvRdmGINgaezi8nZ8Njqm+lC4Fu0
	0alYaQMPk5R+V1zBOlVJj5cEk/1MCjUScidbDfud7QxUjsFXWn0vq7LEXpH1RbE/gE6a1PPuzce
	Yz5r++vAAudYm8l76UJr7/43opq7d20x+VekETvZ8DCl774/OmNKgoqDuuCfaZxUNdWH1+dpAUs
	/+Y8hoWz2hsCJTpGA1LXTFGlt+fGfcBBsoqTIhVPSRtFkb+s1QhYW
X-Google-Smtp-Source: AGHT+IGGOzkih9Jsk0XC+eX8jhrx/73JUgY6WWlYkdYmHE/bfd/3TMIiUoOWeJ42gcHD+G/7JRq+yg==
X-Received: by 2002:a17:903:2341:b0:235:e309:7dec with SMTP id d9443c01a7336-23e24fbedbamr332318535ad.26.1753193421711;
        Tue, 22 Jul 2025 07:10:21 -0700 (PDT)
Received: from DESKTOP-U69D987.localdomain ([115.128.56.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6fdfsm11865459a91.17.2025.07.22.07.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:10:20 -0700 (PDT)
Date: Wed, 23 Jul 2025 00:10:15 +1000
From: Arien Judge <arien.judge@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-wireless@vger.kernel.org
Subject: Re: [wireless-next 0/2] wifi: support S1G TIM encoding
Message-ID: <20250722141015.inlkbz3b4qeoahly@DESKTOP-U69D987.localdomain>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
 <tx3gim4qbf6qmwd4u6kqspzu7n37cih42elgbnwedxogvpkxcn@vmzo7fiyrshw>
 <c420f02a76d17e44c7f207e64278d3da8e4f03f7.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c420f02a76d17e44c7f207e64278d3da8e4f03f7.camel@sipsolutions.net>

On Tue, Jul 22, 2025 at 09:34:30AM +0200, Johannes Berg wrote:
> A question on that topic: In your experience - since surely you also
> work with real hardware - is it plausible that hardware has both S1G and
> "regular" WiFi support (2.4/5/6 GHz)? Because hwsim does that and it's
> caused some issues with the large number of channels and such before, so
> I wonder if we shouldn't be more realistic and at least make the default
> not be that, unless we ever expect real HW to exist that does all of
> S1G/2.4/5/6 combined?

Chiming in here. I think it is plausible that a single chip with both S1G
and at least one other radio type would exist in the future. This probably
won't happen for some time though; much longer for all radios combined! 

Cheers,
Arien

