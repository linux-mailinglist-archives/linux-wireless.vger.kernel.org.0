Return-Path: <linux-wireless+bounces-27869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61FCBC32B2
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 04:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3263C2813
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 02:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB26299AA3;
	Wed,  8 Oct 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="dY0luuB7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD8288513
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 02:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759891204; cv=none; b=N5XsPwj/LdZC1ab4GVWuCjIr5zE3bIFZa8kAS6+aDEo+YdG8a1v+U4KhzasyRgRIRjsIQJyb3nmMwMQJYbGWJDpX95vAyB+0L5unc0qRXuQkXb+labc1FLe3UnZ/AeiE3RGwEU+4Otv+hyqGBlBW2GaaMY1ya4lJxsrLq+Gq1Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759891204; c=relaxed/simple;
	bh=J18UwdBnQvXtVp036xmWAThn9o5psFW3lOhCcwSC3Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht1uuix5Wgynr9OHKzRtJ5MWQ+Zl/P6l9uxq/GgD/z0PwYzHN97jeBI3WgGQoQ85qvuFh9ExwVUGZlCzo2CDtg0nk1hUTksrKehugCH8Vj/B4flIV+vMoWDLj15M20qWksVDmukm9ok32gbBB4HePwQ06e8Io7A8aIhrB9WM8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=dY0luuB7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso529199a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 19:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1759891202; x=1760496002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J18UwdBnQvXtVp036xmWAThn9o5psFW3lOhCcwSC3Dw=;
        b=dY0luuB7Ve75Q76pQYp/s+3IAsCstiTQKY9yyaXuD7wpX24z6Y/rBLN7cySqJXlsjS
         vrPJn47PtcAnqT37wZAc03D4AGCoqlMED8ZWGQ6vIrj4P5R/poM1lB3K0qi8fq7Delku
         cOGeRE33f5cLE2YihYwRhJTuB/KFI/Hjku1MwOtkRAabFZc/3pIFada96kOFGAqlzETT
         SNElAiEEqIf4sPLne7UhzPPBC6mvj6tTJZE6swxk4+200fkk5PoFwEn3xfp3fO/FPt2y
         ywV6O49VWPyV9aBCpjWDvcgEeaqa9w5V/DRnOl2NN5qZkrVjPb2HpO58LvoDbS/ZepOA
         OzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759891202; x=1760496002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J18UwdBnQvXtVp036xmWAThn9o5psFW3lOhCcwSC3Dw=;
        b=EkqJjgraRrmvBt3PFUKM/D6liyxPzgPkVpvtSUMkktWvjkPJrvzXtfDx7iSkG+G038
         KbcbqWud5/x58sXOpfSbFTjFbhfNt5xxcEWJfChT8cojY8cVRAKdZq0cJ58TApwLVN/7
         mF1aUkUqtTWJDWdmAKDl06moUFlzKxZKjHSha8pjb5ZmpFFJ5oDw4cXYhjxQ+H+90stW
         RkQEWSpkIGSRDQPJyk2x1g1EXKt5x5gYetYv5ns+yzSnCbu1qN3eFntjPIxCdG+I8x6j
         PJ9jA9Nt7Z5wI9uuuUS7OYl1+FtZ7ZL9gC6PrHMDZSxGUZFe2Q1+JsL+cBHPHWXaU6z7
         BWlA==
X-Gm-Message-State: AOJu0YxtH4gPFtpPZDaEHvdgiEjGsPmA6HRBg0u4TxOWIh6gAUFaBM6m
	rGK//5Livjz/0IvEMvaZ9kDfksrg01Ili1d8J0tYMTHLc/aerjd3XeZfuBx7P9Y31wA=
X-Gm-Gg: ASbGncvrVezJpsyYsK4jWMd6eBiH4p7zgSMf7g9bRvEAm8W/2Jl6IM/5keHQChQmv1/
	79Xah9PcXOfxAkV4/oN1DS3EjSN5Z4Q+9HP5OAKflNmS1pqLVMeN3+Vpp/38droPHCKcIyWlULX
	Kmts3RnGsZop2+SRvfWnCZ1nDY9H1XdlL2bcHuzw4b0+TYxJnU0IOro/6VhdIQEVU44c2wFOEih
	i2YBdkkBB86Lku5FFYy29NuVs0WhyNX9Wyuqec4iI9ltFd4reEo+/3j8qw/mVY/7jBM9DX9GtEX
	PUDUnogBusM1Yfv/qShCkoo3yJDAV4Amm5wE2EBvl3FjPOhESYmT9GnHtrlFnHpPEKMjGLF2eD1
	7S81rl2NfbayO9uM3ouzTgdCTUv6C9Tp2qWsKHYP4Qh6vxqeohgWd6e03h+mUTmhEeiym3VD/M7
	rfGnUQdVZRavw=
X-Google-Smtp-Source: AGHT+IFgyN531h83yCzScjAh0eo6cpx+TASjoe+7zXaoknVL1S7WUuVGhJkiWuR4HLiSgXrFA5cIAQ==
X-Received: by 2002:a17:90b:3908:b0:32e:7ff6:6dbd with SMTP id 98e67ed59e1d1-33b5154dbb0mr1869484a91.0.1759891202088;
        Tue, 07 Oct 2025 19:40:02 -0700 (PDT)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5288eae7sm352551a91.0.2025.10.07.19.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 19:40:01 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:39:59 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: update S1G channel
 list
Message-ID: <c66wv25xain2iqudsz2xirzb444pfbaaeumkbv6gnaqddqgt2h@hvtkge7zjadi>
References: <20251008013903.219169-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008013903.219169-1-lachlan.hodges@morsemicro.com>

Also unrelated and im sure you're aware but it seems like the patchworks
bot is broken or patchwork isnt reporting the bot result?

lachlan

