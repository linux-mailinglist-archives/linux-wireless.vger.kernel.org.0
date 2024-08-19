Return-Path: <linux-wireless+bounces-11633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E7957444
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 21:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A6528441B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2521DB44F;
	Mon, 19 Aug 2024 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTYSRtwj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEFD4438B;
	Mon, 19 Aug 2024 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095162; cv=none; b=MeG5ZcT/f7HO7+dQBzQFB+NfwYHtuchGpzzhke105gH/79iGQunmnaVGLSY10BcEDu+oIVMv0yRJPn0uS0nkuYu7d95Ipf4CEA/lCUpHD9o6ZjgKbxAFebGGQ0/hQrfPKEEIQfahdrUstqWEsq7DUl1gPJ4CyroUCBd48RfCAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095162; c=relaxed/simple;
	bh=/gEJd6NW+LSDAYBoOI1U7WFiokyKchCo8Jpm5wb3nOQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=anKABYE5cw/Fx5OFW9DSkqHwdJg/JtyE3eX/bJEapc4LauxrzGB68up4k9QEbDailIP7Onb+fL/p+M+3fu3vHaPp1VJDtwUjuCFVbDPH2LX3ibN3WgWRVF678vlWAp0gYBgrUEnH7+o0tStnkIF8SiJCdtAVB35bfCzGwrGuW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTYSRtwj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3c098792bso3663324a91.1;
        Mon, 19 Aug 2024 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724095160; x=1724699960; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/gEJd6NW+LSDAYBoOI1U7WFiokyKchCo8Jpm5wb3nOQ=;
        b=iTYSRtwjNUSu/jPzCevRjWBOE179xnk+etMpv5+ULrmOkaC0teHJ54P86yi4+8738M
         JLErcshX+zl2IE/KJo0xQJhm78X1TfQRYxiLqZcGNG3hOcWU95Pahzz/XQmgfEbmBZV5
         gIqXwaymYvdLr0eVttRGgAAnB0qiZVMdN4EbaF7fuZQdHoRxemt53P+wOenXj2TyDyGg
         KX3EX/QTpX0SzifUC4o+XTxCVr/w5BArYSiXlz93i1+YgheolMrRYptBSScAiQXZucbI
         YN5rk7JQR9rOlGEb1HBdGwIgee+G6OcICvIxXLqJJyvE2mVun6WHnic3NMH7E6i2xgnE
         76zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095160; x=1724699960;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gEJd6NW+LSDAYBoOI1U7WFiokyKchCo8Jpm5wb3nOQ=;
        b=I9AATGprPOnG1/aioE4gpbb3l6KJ1OJdF4f4UiLk+Vs8cvhIWuu0bnnTyq16Dantaa
         f9e/Fx8e5nE1Gj58BJ408SrRA8BZkgjeu+GgimAEOKQwJlIFITLDGNIBXO0ZTIJejZuK
         5kyEBs3MbhMIY3NkcW+cE3kcDtScx37GO2a8ctlh9XzsueV8LPfEau0XAdIAyoi09d8l
         DkYs1MtHOVGS6GlrJtnln0YRUaVuL0cQ6sU3X2VXZhAiLLi0WzfMYy8XhbLkz9RP61sN
         LNqR7h9vREjUPlJwGlgSJ2yRbCB+ilZD+0pHjyHEphS+ivbZYt7FkvSly1WQcxvlo5Bb
         Nziw==
X-Forwarded-Encrypted: i=1; AJvYcCUdKTBQpnRVFqSUKGsUWtc+qDt7v8p559l1kUqH2mnT5sWmlu8d4bnaOg3wyZkQZIfeZECTAqqozhfndeuKC+k=@vger.kernel.org, AJvYcCVF4w2pblSEXUDGhUqrp/5OExsrWQVmHJnbBF5jyne7qG/8hM0aBxMEAE99KKP/ADH9xdnTtxoZ73qHGNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Hvjlf/e7Vnlo9ztwHdA0a78wudP+VG+nUp3FxPILWILLhiqg
	CUzKQ1IJVwT/r0YEmIZxK5zefdK+nkcsQ57QysTHDbzoMfoEgy3ou61XnXtOOGmbwyF+tVD7GiJ
	7p89QdheTdPEMJi/1/gaMNsLAq3IdNd5mu+JzGT4T
X-Google-Smtp-Source: AGHT+IEP1iDwqNwYD9UxTJoeWVIFCGa+Q0ol+t9ArKqsxN8dBdhyHAZbZdV7+V6AMwJbTVvvXZZkXFz9VNuDAHEGqXg=
X-Received: by 2002:a17:90a:c28b:b0:2c9:96fc:ac52 with SMTP id
 98e67ed59e1d1-2d3dffddd10mr13653919a91.26.1724095159998; Mon, 19 Aug 2024
 12:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haoyu Li <lihaoyu499@gmail.com>
Date: Mon, 19 Aug 2024 12:19:07 -0700
Message-ID: <CAPbMC760=5UeaU2wwNZkBMi2ZMVhr2GQgG+VkM8Z7zNbt-FtTA@mail.gmail.com>
Subject: [net/wireless] Question about `cfg80211_conn_scan` func: misuse of __counted_by
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Developers for NETWORKING and CFG80211/NL80211,

We are curious about the use of `struct cfg80211_scan_request *request`
in function `cfg80211_conn_scan`.
The definition of `struct cfg80211_scan_request` is at
https://elixir.bootlin.com/linux/v6.10.6/source/include/net/cfg80211.h#L2675.
```
struct cfg80211_scan_request {
struct cfg80211_ssid *ssids;
int n_ssids;
u32 n_channels;
const u8 *ie;
size_t ie_len;
u16 duration;
bool duration_mandatory;
u32 flags;

u32 rates[NUM_NL80211_BANDS];

struct wireless_dev *wdev;

u8 mac_addr[ETH_ALEN] __aligned(2);
u8 mac_addr_mask[ETH_ALEN] __aligned(2);
u8 bssid[ETH_ALEN] __aligned(2);

/* internal */
struct wiphy *wiphy;
unsigned long scan_start;
struct cfg80211_scan_info info;
bool notified;
bool no_cck;
bool scan_6ghz;
u32 n_6ghz_params;
struct cfg80211_scan_6ghz_params *scan_6ghz_params;
s8 tsf_report_link_id;

/* keep last */
struct ieee80211_channel *channels[] __counted_by(n_channels);
};
```

Our question is: The `channels` member of `struct
cfg80211_scan_request` is annotated
with "__counted_by", which means the array size is indicated by
`n_channels`. Only if we set `n_channels` before accessing
`channels[i]`, the flexible
member `hws` can be properly bounds-checked at run-time when enabling
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE. Or there will be a
warning from each array access that is prior to the initialization
because the number of elements is zero.

In function `cfg80211_conn_scan` at
https://elixir.bootlin.com/linux/v6.10.6/source/net/wireless/sme.c#L117,
we think it's needed to relocate `request->n_channels = n_channels` before
accessing `request->channels[...]`.

Here is a fix example of a similar situation :
https://lore.kernel.org/stable/20240613113225.898955993@linuxfoundation.org/.

Please kindly correct us if we missed any key information. Looking
forward to your response!

Best,
Haoyu Li

