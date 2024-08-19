Return-Path: <linux-wireless+bounces-11636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C19C957649
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 23:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DEA282736
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CCB158DD8;
	Mon, 19 Aug 2024 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJGCjxMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249A15E96;
	Mon, 19 Aug 2024 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101196; cv=none; b=gQsXgbeIErKni4X2yB8DNz0cAY+s9dnRldRlNHpn5s4l/+uShFR81i5nPtz/i4II2YlZog2Mhl35FCJwmJYvbJ3suxlLd/4eWPQutnYQZBqK8Wqh0dsgzx7cta1yEjg6+2tqQGGM0EsaLSl2RvCp0arLl3uUMgX9ePLAJai9KAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101196; c=relaxed/simple;
	bh=ZxFkS9fOsned6xG4oSpUEIn6I1VKxDOoFV25OtHhgf4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JhyZcikYSkOCBqfgLUo+vw3q+RFMfuOCCjJfwIlJzDWQ1Yo84NVU5nAqwKumyYlcoRo9JZTnHYCjYBFilmWac92NT6Q47t142bT2Tdc+9n8goviLAKkagZQBLX848qz1bp3Jolb0vjcuu/9+mBCIj8Aj5sLhhRySBed+e4Uu3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJGCjxMx; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so3271156a91.3;
        Mon, 19 Aug 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724101194; x=1724705994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZxFkS9fOsned6xG4oSpUEIn6I1VKxDOoFV25OtHhgf4=;
        b=fJGCjxMxdGUQgWs2enuWkzbr3AOn7NektoGn6kMzKb6N+wCR0BxUzmVeUh8L1bTzLJ
         sN3jholuLo2TsZcP8fZbyn1dF3vWDvde7gAzv1VKlwJK2ocxGHgdNbKdtehq4uEXZ+wY
         2I5CsuUrG+GyoPtkwQbemqh5eaMMPjyz6yziGCVhCoNMNtUlXUkEA9UHfiR/4usCNfm2
         NdYSceuXYZRBXJJHU+4ivh5aEPj/YZG4qv9gqoEwiFI12zzDP/tBsvPdNQ0sXzujI97a
         sulWkUGtViE9FxB90EuNhFlZr/HGUt9cZLq46f5jEjMzZ7y2Vcxk3Jzjf/UZKoaCp1s7
         0NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101194; x=1724705994;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZxFkS9fOsned6xG4oSpUEIn6I1VKxDOoFV25OtHhgf4=;
        b=qqPBEknDQ64LaS82Bput08d9EwcXx1AsZ8r3vAmWr+igxJc06IHO7W0GYy+eseOvat
         ToziA0L/9o/VBgPCSHxamr7i6RR9sUTQJKeHc2x7BJStrGjymCrXAVwR1kHcjDf5z3sr
         6lrth7S4dWhklzhI8ebMG2el3vIL/n6wo6uhhGXv+dgyVo+SFNjobbRzvS7NwMGxKIMu
         LZDpohIQE8mh+pDqBvLrWuax/soKAP8k5zK5es7lGxLICVlyi1dGPWerjEaf4kfyr0UZ
         T7BYqmVhz7EyqMIZ9DdzhyJtwFVvMhFhuSvzqbtj1kUo+2mpYeDZ/OG66MCsMpoX/W1M
         cczw==
X-Forwarded-Encrypted: i=1; AJvYcCU6LEMbtIPNkMZZdNQyWGQQ2j2dX694uGPxf7kpbzVvTSlKNMXAflns2UBHp0uJkZQpwd/hDMXR2DFdCh2Le4k=@vger.kernel.org, AJvYcCX1gUps9LW7/JPKrUzk4fzbNhcqOjXyCHJyngKdhcIBng8yAFxBrlaX1eNL54rdFxkgqlrS/FmViQ7cF/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEYAweo0f1AetDAVCd4aaFtHgd+ojnOQaAEUQwY6IPdP7DXqwZ
	l7fLZOCCiqZOd+Jf67Y5+VdIst7U9BCulXp80C6ugbQKLyWINN2iXnfsoBafydXoP086HWliPMl
	wCRvTNnBZeLCmr3e2Ut0ciGgjz4Q=
X-Google-Smtp-Source: AGHT+IFi+AUQxiTAadxuBKsKstA4xZBeuuVjyRNaRBiFtXI5it0qQGSeTLdea/3kDXx4zoxd+cMPxlvLGL2/z4qokvw=
X-Received: by 2002:a17:90a:d50a:b0:2c9:69cc:3a6f with SMTP id
 98e67ed59e1d1-2d3e00ebf73mr10771065a91.31.1724101193803; Mon, 19 Aug 2024
 13:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haoyu Li <lihaoyu499@gmail.com>
Date: Mon, 19 Aug 2024 13:59:41 -0700
Message-ID: <CAPbMC75nfHS=rV3XJH8Pkc_q_A3UmsCrdTs4DL_0s=Mb6W0N4Q@mail.gmail.com>
Subject: [net/mac80211] Question about `ieee80211_copy_mbssid_beacon` func:
 misuse of __counted_by
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Developers for NETWORKING and MAC80211,

We are curious about the use of `struct cfg80211_mbssid_elems *dst` in
function `ieee80211_copy_mbssid_beacon`.
The definition of `struct cfg80211_mbssid_elems` is at
https://elixir.bootlin.com/linux/v6.10.6/source/include/net/cfg80211.h#L1304.
```
struct cfg80211_mbssid_elems {
u8 cnt;
struct {
const u8 *data;
size_t len;
} elem[] __counted_by(cnt);
};
```

Our question is: The `elem` member of `struct cfg80211_mbssid_elems`
is annotated with "__counted_by", which means the array size is
indicated by `cnt`. Only if we set `cnt` before accessing `elem[i]`,
the flexible member `elem` can be properly bounds-checked at run-time
when enabling CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE. Or there
will be a warning from each array access that is prior to the
initialization because the number of elements is zero.

In function `ieee80211_copy_mbssid_beacon` at
https://elixir.bootlin.com/linux/v6.10.6/source/net/mac80211/cfg.c#L1073,
we think it's needed to relocate `dst->cnt = src->cnt` before
accessing `dst->elem[i]`.
And https://elixir.bootlin.com/linux/v6.10.6/source/net/mac80211/cfg.c#L1090
is the same.

Here is a fix example of a similar situation :
https://lore.kernel.org/stable/20240613113225.898955993@linuxfoundation.org/.

Please kindly correct us if we missed any key information. Looking
forward to your response!

Best,
Haoyu Li

