Return-Path: <linux-wireless+bounces-23043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089AAB933C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 02:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BF09E62F4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4C4683;
	Fri, 16 May 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="grPnQ9yb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7C42114
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747355933; cv=none; b=mIoMP/w6j9yz+u/n6HF3dlGNQTPJ0dn1RHejrDjmyj7cooOy/P+4r45xLiV8Q7G590cuyaw6Dml4E7CmSbQzQ4iBzztSPLF8F0/1w3s3qmWs4N/MQvirRRX0P8B+QtkslnXDbnaItDwKPE1GCerebHz5kms68fOKDv4r6EPpGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747355933; c=relaxed/simple;
	bh=rv8k0wyEoKPUYTeLSMzP7hCq20sWkhmDbO98OIYmMHc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ATNNx07LOrvyGHCMU0SUeQElSLx+sqM1kJ/7OcU7Pgaz9rhfA8nLsk4IVi97EeKqxeX0OX6C/rR/3WSICKGeeXliQceutBnCbLSxub2I4R/aF3+sUnxLzu0IRMriwVN/qS9GMKQkhT0sSAiQ2QbKW1+fWV2OTjLYgJSIx/C0AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=grPnQ9yb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-708ac7dfc19so14357047b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1747355930; x=1747960730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rv8k0wyEoKPUYTeLSMzP7hCq20sWkhmDbO98OIYmMHc=;
        b=grPnQ9ybLMCHG/5mOyMEo/7xQz+1qsD/HEIt45l5hClImThSAOxL85Yt1mf0XZqst0
         /hbRprEO5cyEajiSH4A+sNuzSP8+XszTa3y9XfD+QwP2xmm2iRqlcVun1Kdo7tmeZaLu
         hdWaEKlqHlOattNGLfunhp9XmLJmoteT7rg7OT6bVcTS2KXTCHeqQD2tYvrPaaZzVzpg
         tnDprXlIi614gXGjZWC52jJRT7JKVt/hwn1QR6mGH34j1ZQd5B0gzLcxAyxkKm23tmVh
         GvcDe/hIdTEsm23/Yqf54yD5y/aHa1Z+EFBk9Vm4BJYsAjx5XRDLdOIOTQO/Qkg+mERT
         WEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747355930; x=1747960730;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rv8k0wyEoKPUYTeLSMzP7hCq20sWkhmDbO98OIYmMHc=;
        b=IP+rmJivPYmjn+nCxn2Pbrj5FXPuZir3CxLbQLPzzKmn+6wxSrOW81aSkzate0CAj2
         mk2j3iUHJY4b5oHnnRwlm6FLxl9tGwNp3KNqGDq/3LnKV4W63DTbyUZxiOMJz/eg+s75
         peZ2lEjCUSnYUphCaNe/Pjyx9k3diC1qCmqc6cR9OKI1FPgMkWZ+DrSJ4YnIpHzSuAU5
         jlyBdR1uOPImqWl/bg6sKhobk586BvmVTjT/pq5DXn3IatcliRms9fI8tV1RwbRaDNLV
         CWz65uEfHphYLF634sZqesL7HCKQmmzcazQzuzFO3McHzm1lwEkf3WIkImWr1SVCsCDo
         ouOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2/4iHoSCilBc1hwL+i/kkuLDUOeQUF4Bcx9o3wH+Zx6kmzVH9I8kJvWBIXtilZz8BPXCP+Iibeqn0I5kr+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+mMBOFR5BhYoQnZNrv5ppmRiT2PqcP6HeTYA0bnjZBhDvvccd
	OJZTxvsGdN70sxGYB/R6alhiFA/cQweFgRdoM5zOyuisyJ+IPCJ2+XnMnp2sQM+acI/BO1TP11L
	C5ielTdwf5YBrCZIE2X10Yl5SLjDVUaPjMhKNnSLGGQ==
X-Gm-Gg: ASbGncv0jj4Xk9Gw9QibTeXhVFDzEUpB+/AuTnbZ9Y3+9LE8Qga76yJH5gl+9Vjn/KX
	+4i93r+2ijk8gphf5gKmpGsUFgwZSXs15AFvYwPfT7wF8iWluuugki0BWUJ9L0QV8XBIhQk+Irx
	CS+S1I7XIz9BVXVP+ysJALv2ofDKYIhZf+FPm3I4OI4dc=
X-Google-Smtp-Source: AGHT+IFRpXGKDPWrLmfhwlXxhUUwIzv8YoXZz3lTpbIBPWH+XJCxnhvJTLL2KDmJ1ao92uXFoEyzYAlWmI0MBwDW1Yk=
X-Received: by 2002:a05:690c:b8e:b0:702:d85:59b5 with SMTP id
 00721157ae682-70ca7bade9bmr27437477b3.33.1747355930425; Thu, 15 May 2025
 17:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 15 May 2025 17:38:39 -0700
X-Gm-Features: AX0GCFtchIFFxA06JruNHyaVUxwAeZUAjl7Me10PnolLIUMyP_CwgT3Ej-tDxjI
Message-ID: <CAJ+vNU2pLJd696Fc_98arrzs8QK70HfstPrZv6zVJm3G13REHQ@mail.gmail.com>
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth
 support for Infineon devices
To: arend.vanspriel@broadcom.com
Cc: brcm80211@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Arend,

Thanks for this series! This allows WPA3 Personal in STA mode on a
CYW4373E based module we use on our boards however AP mode with WPA3
Personal does not appear to work. Do you know what is needed to allow
WPA3 Personal in a CYW4373E AP?

Best Regards,

Tim

