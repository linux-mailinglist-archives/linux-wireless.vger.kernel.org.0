Return-Path: <linux-wireless+bounces-10859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C926C94586F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 09:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F91B23121
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32DF15AD9C;
	Fri,  2 Aug 2024 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbmAZl5H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C6D1598E3
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582686; cv=none; b=DwXhVoTdnNSUjiJdakvDzqgQAnk1G12rD9Wri2aKr7Nv+ajEi0RMgO6C5e9JfhlMOta4804jlRZ0pg/6aYf1+oQKQsTiormCk5a6OwX7NnmEEviRY7qEC3jZRKYpQBObfhRdWs20qgUfmQ1bF+1LEFiFKprdlMKCGYzGtNmH0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582686; c=relaxed/simple;
	bh=LVUmsQy0KJmBZ59E9Yj2LFomv5aKkmvnSV3+zITXWqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n90aJa5TdwAg3AeWrOelqsFTqXAb0AECdi8v52VHZRT/WXGzy7heGh3ub2OFJqazVHGf4RJjvhi3EIq+stGLXI7pTTONf8S7zBkSk9KsDM2j2yxFBwR/D2XInRXZQuvbbPKMr++AKqV/v0YzSFklfANaTTTxavuGRkb9VW7hfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbmAZl5H; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so10348189a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 00:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722582683; x=1723187483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rL3LCwXqnNTYA9Y4g7jU1WfA6AXlGw5PuhRK9q1C4/Q=;
        b=LbmAZl5HqA9gpu1UTyLDhABpMfvKi/1W556GpJUhv0amqy63YZQ1cTSoiAlKw69fX0
         4K/lAzlzTWjZCxnUM3Z9Y00IvOlvFLA7vzbheZL1ZhtJBa/pbQLXs/9JE8tOCFGGqBMx
         LWdJkDFvQKOBih4daAL/2EgD6UBwiCXSLXZnwNcPkZefTYLsFwTYQFoehfdCauIUJpqk
         gdJqVZz7KfHXP1ua3FGHDo/qyb+grbuAA77m8+MJOP2jhoGQSC1aWsH5UaHyRb/dGMoS
         paEH+e/4rlmE3Lupe3wnfBfisbekuUOOi69XcmzZF9FCjASFVKP3jQJSG+KF11W8gsnv
         w/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722582683; x=1723187483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL3LCwXqnNTYA9Y4g7jU1WfA6AXlGw5PuhRK9q1C4/Q=;
        b=P/rfH0e9xPAgwHtxaWbCimAGbJ6uaDE18Sv0S7XJZo/oOThHUFKBQBXj7HEy4KSTHO
         S1mbvjq/wIuXYw8QZr78L8xhuo9JIpeMJ2bOBjefSZ6QxPH8j6gdnE49UjVKMl4EonPQ
         c6vib25HERFj8SYegEGyh3GiXOxY5riU9vJcT9STXCYogx+pICY2TbtWJbD6I+ORaQLL
         4FtPbU/QyM/C+ZUj0z5FcWhF7Lu1hPbohbjpHLY5c66jkBbsMtCtqyVuPCbHD9vD7fHb
         p6+EzJezRTj8izkx9rN+LgbAD1jBKwv7tapa6oEO8cyVZHZ1mqbZJHle26MdV4kM0Nwf
         BrkQ==
X-Gm-Message-State: AOJu0YzrZyaD2U1SbkuCXcLmLHtAJzvafp7IMDWjd376u9DrcWw9jm7z
	pKjI96MxQHvV2qAtqzOii+JIQt+WUkLbK3iv3NtV00VKmA8HJDWmrzyAQjhGaJLd3vlk9Iz8fTe
	a+/4s1qbiRYxCNyskzqVfYoVCbrD8Sg==
X-Google-Smtp-Source: AGHT+IEWi+M3sYrEJ8/kXVwNsKMRWQtmQiXh7HBmAwg7L5Y46O0LeQtUAz/OQhNC+oLIoNjxQF2iX6OqExmJfXcXiUA=
X-Received: by 2002:a17:907:720f:b0:a7a:c083:8571 with SMTP id
 a640c23a62f3a-a7dc517a6c8mr167605266b.52.1722582683193; Fri, 02 Aug 2024
 00:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719032326.7353-1-pkshih@gmail.com> <20240719032326.7353-4-pkshih@gmail.com>
 <CAGb2v66QO-F6r6Ay5yLiYwFXxob6JGnv_4k-oZiZJWfboGt0pQ@mail.gmail.com>
In-Reply-To: <CAGb2v66QO-F6r6Ay5yLiYwFXxob6JGnv_4k-oZiZJWfboGt0pQ@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Fri, 2 Aug 2024 15:11:12 +0800
Message-ID: <CAHrRpukJ=uPx+J-KD0TcPcYyMwNMb2t__7sQfMPv=PnizHkVYQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] wireless-regdb: Update regulatory info for Togo
 (TG) for 2022
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> > v2:
> >   - in commit message, describe typo that 5925-6425 LPI should be EIRP
> >     density 10 dBm/MHz. Otherwise, PSD for LPI is lower than VLP.
>
> I applied this patch for now. But could you reach out to the ARCEP to
> notify them of this, and ask for clarification?

Sure. I will contact ARCEP.

