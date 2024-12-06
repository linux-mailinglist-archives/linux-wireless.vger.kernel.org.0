Return-Path: <linux-wireless+bounces-15977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E29E6FEC
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 15:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFAA163A16
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3A13B293;
	Fri,  6 Dec 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="billnddg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4721A0B
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733494662; cv=none; b=a7qPIl7SRdAq6k+l6H9pLF5AByJrDzKUbdTgzD1/uDKikmOkyEoU+csgvUtivh4Em5FHKvCLt1znuZn/p3NgFTGVM8759MHjSxNTbom4rkCvPCs6uUmdTbFWg6cRFxptoCE9yl2cAdzzUEKHx8sVay58g9ktSOrtbsRHojitcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733494662; c=relaxed/simple;
	bh=rX5BU5XNdjlMCUjVenEaq2axHyc/Wr/2Kwz0CjpOqgs=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Sb8NK/SkOai5YaAqGWd8XnfoGwOWnboBCXWE9k9CSAjFEnOnf6vBF8iJmNHwapoU9hiP5qAjvNuzzdr0BdXSD7rjXRUjKCOFnZyYDO49jQuXy6XFq4Oo83BUUsfazco+MScAGZXcJRy+okn6FRAfSOg+ibuOrLTB22W5DYRPWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=billnddg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215a7e487bfso18211595ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733494660; x=1734099460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/CyHjlQbxFCcgXsaH/a8Pz21jQlMrS+kJ0F7SRY7xk=;
        b=billnddgKlPwyH58X5/GIQEhKlc3nV1bOqYtbP7VR6OpwfGuKd3CqNPXROAHUV6CDl
         FQQwXgAdTy9Q0vjKGZOmSYSb+6RNcPNrqX2qa1bV7lPeFcYK+b+pLZA3dOvNcV6Ny06Z
         PA5Z4ZSD3HID2k6yuFvewJmEk+kxchPyobQ5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733494660; x=1734099460;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/CyHjlQbxFCcgXsaH/a8Pz21jQlMrS+kJ0F7SRY7xk=;
        b=vtmzRR/J9eq5CzE6cO56QNDQvGQsJyJ9yYp8F4WjcRZNvZZk3OZpfQHvlNA2yx90uz
         xlgFuxclegN/RVhwBmzjmgqnCjt7S5U5gMh3N3phbu0tidXVeQJBxT/zH5m8r/O2AwIz
         PmNEK9He2+rHzdZ3hIjiYt+1ILI1bg5ihpsmNBJ8/nDA16BvqgE82UF9uXrpzYYfwCgo
         DyyiVgQHvPmqidRZZL3zT4DjDuL1jzTLAa9hIEkHXNUVh1K40BN4DcGbQ3cgd7l+HHfQ
         xmjQEXCp8q7iY+NunF7xPLIwer3xBxZqVsvV17595h7DXooW9VtpGETjZHeCcTFYtecl
         sgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW45DAxvaunt2Y9Oty58cwxxXQqTrW+ewZMUpN78guxWeh+5YRbBSj+PR/bHOhyHq7nHhpigjV7DvD5swRzjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8nj+FXNkJQRVhNP4o/USBGJM3jzJUp+voAa2vFtWK2rQKYMAf
	x9Jfx2IRps52MXBNjtYkQWr2U+ozd8Q+XufIj5eJDHNySs81lC9JQF8Pl1gNtQ==
X-Gm-Gg: ASbGnctiezPSPY8QncA8dqgZLR7hSk4hMmUWsRri5ERpvq/li4SIVZbMJd+TXLCrTt4
	Wd2y5amyixOPnTZSWBD+dhuXnVGbg5QONC7R1FTejCWoFlnW/EL5zdp8USqFy3jXt2dl97AY2fI
	j+Pmrmx+CjWAkpBiFo9RDY8QNq0Nkx9aa4NIh1YJXzILOSQ1zYzzsDozyI3u1CUhbfLFcpXsfRL
	78SyOZJu4HVJr2a9P1XR/7tGjxJ1TtPGoLNcuIrAl/JHcB1jdHZCGNgTpMNflmFgEQCdWAOOeNj
	uZ3gPt0k0hy1
X-Google-Smtp-Source: AGHT+IE/IVrqTruCHjvzbm/ODe55eeUryoE9dcGGsz5mfr3klqIzPy60aDGyy2QEwb9+IH9iUR0fOg==
X-Received: by 2002:a17:902:d507:b0:216:19a4:dbcb with SMTP id d9443c01a7336-21619b41fb7mr32325565ad.45.1733494659711;
        Fri, 06 Dec 2024 06:17:39 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f270sm29197895ad.68.2024.12.06.06.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 06:17:38 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: KeithG <ys3al35l@gmail.com>
CC: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>, <linux-wireless@vger.kernel.org>
Date: Fri, 06 Dec 2024 15:17:33 +0100
Message-ID: <1939c554048.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAG17S_Mv=GemEk=7Rwp-vPsi2Lb=2AY8rPQHFHHaNHde2Rq2Rg@mail.gmail.com>
References: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
 <20241206065324.91702-1-renjaya.zenta@formulatrix.com>
 <1939ae623d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_Mv=GemEk=7Rwp-vPsi2Lb=2AY8rPQHFHHaNHde2Rq2Rg@mail.gmail.com>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On December 6, 2024 2:29:06 PM KeithG <ys3al35l@gmail.com> wrote:

> I built the kernel and got this:
> root@jackrune(rw):~# uname -a
> Linux jackrune 6.6.63-v8+ #3 SMP PREEMPT Tue Dec  3 10:09:16 CST 2024
> aarch64 GNU/Linux
>
> I must've done something wrong, though, as I get this:
> Dec 06 07:08:10 jackrune kernel: ------------[ cut here ]------------
> Dec 06 07:08:10 jackrune kernel: WARNING: CPU: 0 PID: 42 at
> net/wireless/nl80211.c:3822 nl80211_send_chandef+0x188/0x1a0
> [cfg80211]

The warning originates from here:

int nl80211_send_chandef(struct sk_buff *msg, const struct 
cfg80211_chan_def *chandef)
{
 if (WARN_ON(!cfg80211_chandef_valid(chandef)))
  return -EINVAL;

Let me know if next round goes better/same/worse.

Regards,
Arend



