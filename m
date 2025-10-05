Return-Path: <linux-wireless+bounces-27818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB2BB95AD
	for <lists+linux-wireless@lfdr.de>; Sun, 05 Oct 2025 13:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E04E20FF
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Oct 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7767026D4F8;
	Sun,  5 Oct 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sPx2C3dI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4511DE4CA
	for <linux-wireless@vger.kernel.org>; Sun,  5 Oct 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662299; cv=none; b=Il058BjBrcJ3iXb5g8lNkHAP5qEDherx2RPRFL0owob/OE9RfB4mK0a2NJXjQRP9XbacZEwm4raZcu3Z9XOhIRy1MmjJGGd4/cl7Bk4Kl7I6hmAqDvqqBrvGbtbzfff+VoAtWfPe8FIM3WhOMJuD5ftlQaAqCLKfvGUFke2Kee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662299; c=relaxed/simple;
	bh=zxCxml2xTMibvcKTUM6g0Bw/WZztapeGN9bqXDcfLv0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJ8lBsIL3rJc4qltv1hGtaN4142cLRYry/WqjHLsBpL9kdD3QYdApVGJ99zmdUqgxGVH8BxgkNWkD3xaJrVFSRN6f3iA3p+YdTbt1U1Dlvj3ikdjxFsW77s/OUeJW0wIZzCRiAbmF/w+i3wKXT6fe43Fgkad3NCKEI7cCcQfPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sPx2C3dI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3635bd94dadso33063641fa.1
        for <linux-wireless@vger.kernel.org>; Sun, 05 Oct 2025 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759662295; x=1760267095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8xqOvlazB5Is3xhXduZ+JLL/yMhmBk64h+nNRMpQMg8=;
        b=sPx2C3dILzaWNTnxSz0N/1UicS00hpRvVggB1gTLBMTkTrl3hnJ/64ASCIaVvNxfhg
         26YgPKh5cJDqyGwIY9APPydoBhoHJm5isLt7Kmw3iYicd3NoKx5lg7/1KLhzJKHJm0Kr
         +9gsxbW/2W1rvbxNallzb9cnQvaKY2D1W/lbTr0HV6sr9F4Ms3XF7uIJNkaeYOH8qJv+
         FpZtmP1CoB4QQjnf4dQN0W3fjcRPYkxqRU6DleltWolus+GfPm2sM2C33MElJywrVDQi
         UKB0bI5FDEraH4bVC4j4SQGGW1odBo3kdeEPcsAlKxQjrM52K2boFXKhPldh/569Uhh7
         nkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759662295; x=1760267095;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xqOvlazB5Is3xhXduZ+JLL/yMhmBk64h+nNRMpQMg8=;
        b=fKPOjTCmx0GFkxztSIwufI5U+DuQJGkbShdJxFrBpvCKdS9u5KYScMVnPutgFQh8KO
         ANUpiItcGy8XyuUCANwlVQRAPhoAYSoaZqjIJrZMneFMoCOm1kIAY2kHb5NY/fvk1XG1
         hPy7HmirQM0dBuDPQ8TJJ0fSm2Hfcl01KFlEuffRRlzmiibkjznrXEo1gWHQll0Gz/+f
         Auf9Ykp5tfNDgBt7S6WdpH6TrdA3yrJPbeMFVkH0Yyb1Ea/TmKTIZRfJwHbTfSR89Ftt
         heJf/JsbwCTrq3a9OPe6UQWXURenBNcdFYvPAS8iQoj7V41rgxq1aGC4BtYOpw5Oxue+
         1lqw==
X-Forwarded-Encrypted: i=1; AJvYcCWuZt1/knPTHa/8/aBwcbc9G/Ah5JNVYb4D1uNyDfJGPXNyZwHaw7rpX9uDrQlBsm6BPo8gvnHGXVpp/l4U0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrmCjTKVJ1owYypRo0rN8wwejucCdP2MTnAKFnA27g7df3E6w
	cg81NsalNxBjrTUZEebBEOwhiETQtHVKdmgjhovF4z616CMl8ClIwt3E0/KfVb+GxqxTDmPawm5
	kPcK8SQBiHJh2tOvdfyRQp3aoKE8Lfu3Nv9AqtMgBCQ==
X-Gm-Gg: ASbGncu3cVsg++TW3MgMh5anwljqzoplT8T2WoB251ZQPlET+kn/BWwQ2qPRKgpup3e
	4Klh3Ns9TAZP2+qBsjD7AvHFPjmNo042ixw3vb0W0L2F+F9g5aGyTleNNG2quQewPQqdyg/4pce
	p5d4PsjZKQn9ck4JmWnIk559LFSobMlx2S4musqQKdCw60u8w1yzb6zrbfLi6a8nxcSyzTXsF5C
	XmTuXHwHwK+7AnJRDXwVwc+5ja8NECQUnGV3ABo6cE1HfLLXm3kbKBKl3Nk6qrNTcLL4s53PQ==
X-Google-Smtp-Source: AGHT+IEWrSLBeSwh841ue8xWWBCz0IGazKam/utBDdjAnUP9kwq2WKJq3+X/Q+HwUi6cY6rSk6yrFl6UveVSx2vH8Ys=
X-Received: by 2002:a2e:be20:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-374c36cbf1bmr28532911fa.16.1759662295570; Sun, 05 Oct 2025
 04:04:55 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 Oct 2025 06:04:54 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 5 Oct 2025 06:04:54 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004141539.6512-1-brgl@bgdev.pl> <CAMRc=Mepopam1zhUONtratqopa6zHhsJfah9JO9D2VKyXcqjEQ@mail.gmail.com>
 <DM3PPF63A6024A97A503FF0208F582651E1A3E5A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <CAMRc=MdtkAFJBGN1biaGDLjgwjuzJ=kjDzEWbrX+DX27e8jYhg@mail.gmail.com> <DM3PPF63A6024A9796B12A990D023532081A3E2A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Date: Sun, 5 Oct 2025 06:04:54 -0500
X-Gm-Features: AS18NWA3dMnXk6NLg3KFRq-98BCFMhOi9RJcV2VAYJtCPLhiWPUX-c1aIwImAOs
Message-ID: <CAMRc=McJ649k44-Y9ugjq1-xKX9QL4c4MX_LeYs12N1SD4D7_g@mail.gmail.com>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: mvm: remove support for
 REDUCE_TX_POWER_CMD ver 6 and 7"
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, "Berg, Johannes" <johannes.berg@intel.com>, 
	"Anjaneyulu, Pagadala Yesu" <pagadala.yesu.anjaneyulu@intel.com>, 
	"Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "Peer, Ilan" <ilan.peer@intel.com>, 
	"Gabay, Daniel" <daniel.gabay@intel.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Oct 2025 12:04:51 +0200, "Korenblit, Miriam Rachel"
<miriam.rachel.korenblit@intel.com> said:
>>
>> To what? I'm already at iwlwifi-ty-a0-gf-a0-89 which seems to be the most recent
>> firmware for this card.
>>
> See https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/?id=70fce2e71a3cbbf50cc57694b94dcb27eb9111f5
> This is the latest update of the FW of your chip.
>
> Miri
>
>

$ md5sum /lib/firmware/iwlwifi-ty-a0-gf-a0-89.ucode
dd86d097615ee98b64d1b78b73697a6a  /lib/firmware/iwlwifi-ty-a0-gf-a0-89.ucode
$ md5sum linux-firmware/intel/iwlwifi/iwlwifi-ty-a0-gf-a0-89.ucode
ae03ce5298a2280e3a22db16fbffb5db
linux-firmware/intel/iwlwifi/iwlwifi-ty-a0-gf-a0-89.ucode

So the 89 at the end of the filename is not the version of the firmware?
No the full version anyway? I wasn't aware of this. Where is the version
information encoded other than the linux-firmware git log?

Bart

