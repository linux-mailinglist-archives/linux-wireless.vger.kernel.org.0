Return-Path: <linux-wireless+bounces-22191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B8AA065A
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 10:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E64188DF2C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFB529E048;
	Tue, 29 Apr 2025 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JYm9cFm+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A24129DB8C
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916939; cv=none; b=Bfw4E1To6wxTpfK0/rdtlh6axmxsZZPRegILLDqmT2D4qVNP97AWjGEdDUlzaq4FFP9DjnnXy0sHRFCRBOF1pq/PhZfvp0r4nTthG75V4HJYxrWJkXH0uulfInlXW++LHgxNnYNKjDLuwZ5D2Rf/0KasLh/WhEyNn9OjT0MUeQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916939; c=relaxed/simple;
	bh=pAAdWk+lDB+lp9svoKoBUgncHf6I+M0m9Zt2UlIzMGs=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=c7CatjbcAkh2KnIdd9/xLRTr9vFassqqQbo9JeT4ZHg3vgAfOdlXyCoK1VsZa62XqP45n+tLqlBNAxOawSoO68YvPVPepD9Rk77f/J+QhyxFRFYsEC6/rOjsqP4BuTE/cnz0Nd4CwMLbdfKmMoCKA0q8MiY2VRVazSc2EOkZZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JYm9cFm+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ace333d5f7bso932546366b.3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745916936; x=1746521736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW68MXGwEPbFsS4hScMhFkST84R6M8d9wEyh85F85p4=;
        b=JYm9cFm+OJtc/lTRbl3PvrAwmWWWoMOPWgbMOkIXnwOSl26KoiGkQ9cLptRm7Fmh28
         1yVVAWidwxVX7EBtauIW6mGOdpU4iHqd6iOanXm0kHatRpNoErf0nNRbg6cr0ljGwPo/
         K0Jua+lRb19hvnoxSS3kpMWLoz+6PcMNEbwsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916936; x=1746521736;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TW68MXGwEPbFsS4hScMhFkST84R6M8d9wEyh85F85p4=;
        b=a/eJopb+xZrbWAJmvB8pOrd61GTo3/7Ucsqyvd9DZxxWt9DkXbGQMrZNXJJ3RGhj7w
         F7lqQ/ZjyGvvON2pVkfK6IDikeu89/rzO/9rI7EzaTAMH18JqOLMDHJyK79mKT1ZtHYN
         ZCglvBrh6ccQV9dEeqOjBw9vh9J89SAoSF3nnSIs+Z/3gOamrI50mKL5FraW8NByhV06
         yEets4ZSSiRxy0/FRFJTMCrHEwlUvPXEOVfI2iseQb3CXubwtmrE/stky4L9S7Gsknwc
         OGacYTfAhRe8hlcL7SXxGLB0yXe4hOXUtaqKIeFBvKpqDLWU1X3h8z2UN9XVVpeXSV8Z
         DFrg==
X-Forwarded-Encrypted: i=1; AJvYcCVs0By4WeXa1a8BzmMLs5oWZfa3Z2o38g/c0DdLXhAqTc4QuoWt2fD3E25zhYiJvY0CMWPBJZoOTUVAxKarHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YziUviLSRwf3J3DI+FWGB9Wc0ZdBY4rHteEm86FZz+3re7VUfxh
	9WhkwuiXuf/bzvUuUQRa7vrh8mpr5P36kdbcxIAuOUOSFpjQ9isjQ9G1RoK1vipR6AL+oyqRl14
	mSg==
X-Gm-Gg: ASbGncvNETE9kiKI4jRDcvmGOUK+kSSyXWAi3mNRDJmXEzAjHVqJ0mXsx1SGGz1hx6G
	cPEe4WFK7ZW5UAdwpYuMRNX8QeIhYJlEpNAa9exJgBpcrfYZCArTmFKAwQLZFTctYwmHTdsd7OL
	flYRY87KgNVyys3dZKPP4vYL/YJMrY72p7TIEEoHiCqc6ezRqPDtiTWTVvkTDOqAhsueBJqtQx8
	7rNKU8IuCoSbkOM8sd2OCxeG/pGLLktsA+wsY1CuiV0Htavd+37zDFX7wU22M4DqNx/sqqB7Kv1
	7LaNAkQsp90I+csf1OyeBOU58w6EeGMWVaZhJMrq4FKQGzeZmTtBH5tE9vLSExGlJ6J8UTQRSYk
	GgIQ=
X-Google-Smtp-Source: AGHT+IHaYfCeH6nUR/6tAIZ9C/xYs2T+HxF+WLJBGle3a4ZVfTJZo/7fVNbO9mL1lQmBd4GJk0qHeQ==
X-Received: by 2002:a17:907:1ca2:b0:ac7:e366:1eab with SMTP id a640c23a62f3a-ace84af4e8emr1189806866b.48.1745916935717;
        Tue, 29 Apr 2025 01:55:35 -0700 (PDT)
Received: from [192.168.178.39] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edafec7sm744211766b.165.2025.04.29.01.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 01:55:35 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: Johannes Berg <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>
Date: Tue, 29 Apr 2025 10:55:33 +0200
Message-ID: <19680c23388.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CALeDE9ONCUH0pQ4Yux=30Lim_SZMcbQsnWx0R+aPhF0E7tf9=g@mail.gmail.com>
References: <20250425085519.492267-1-arend.vanspriel@broadcom.com>
 <CALeDE9MGXiSN=8E+T_ZGOLHsk8DB4iL=hV7ircqqb9=q1xTUYw@mail.gmail.com>
 <1967fbdeea0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CALeDE9ONCUH0pQ4Yux=30Lim_SZMcbQsnWx0R+aPhF0E7tf9=g@mail.gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth support for Infineon devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On April 29, 2025 10:19:00 AM Peter Robinson <pbrobinson@gmail.com> wrote:

>>> I will try and find a couple of other devices with an appropriate
>>> cypress/infineon.
>>
>> Thanks for giving the patches a spin. The firmware should have a feature
>> named sae_ext. I think the one you with iw are indicating same support in
>> general.
>
> I am not so sure.
>
> RPi4 (BCM4345/6 - 7.45.234 (4ca95bb CY) FWID 01-996384e2)
>        Supported extended features:
>                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>                * [ 4WAY_HANDSHAKE_STA_PSK ]: 4-way handshake with PSK
> in station mode
>                * [ 4WAY_HANDSHAKE_STA_1X ]: 4-way handshake with
> 802.1X in station mode
>                * [ DFS_OFFLOAD ]: DFS offload
>                * [ SAE_OFFLOAD ]: SAE offload support
>                * [ 4WAY_HANDSHAKE_AP_PSK ]: AP mode PSK offload support
>                * [ SAE_OFFLOAD_AP ]: AP mode SAE authentication offload support
>
> Jetson TX1 (BCM4354/1 - fw 7.35.349.104 (775a9ab CY) FWID 01-d55901b0):
>        Supported extended features:
>                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
>                * [ DFS_OFFLOAD ]: DFS offload
>
> So I have different brcmfmac HW reporting different features.
>
>> You can check the firmware features in debugfs under
>> <mount>/ieee80211/phyX/fwcap.
>
> I don't get fwcap on either of the above devices:
>
> ls /sys/kernel/debug/ieee80211/phy0/
> fragmentation_threshold  ht40allow_map  long_retry_limit
> rts_threshold  short_retry_limit

Ah, yes. My bad. They are only created if CONFIG_BRCMDBG is selected.

Regards,
Arend




