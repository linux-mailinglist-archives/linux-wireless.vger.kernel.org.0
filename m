Return-Path: <linux-wireless+bounces-19674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988F8A4B496
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 20:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBF1166FF0
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Mar 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0361EB1B9;
	Sun,  2 Mar 2025 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="csj7qKSQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53370821
	for <linux-wireless@vger.kernel.org>; Sun,  2 Mar 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740945415; cv=none; b=PnsDj5iSHvomWcX4ODo6j4pvPfO6s18P8wTvn9EqUnv8QWAXj/mFIQTiTIgnxnhCqqdDNuhal6aae4qd+vm3wuxc5rU2xeKnRuecN0G5DoIIzhAwevexKCJMwlWi+Luf/0g0GcQQkoasTMuUe/UVqbPLntkvoZsk2h7EpbpTq0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740945415; c=relaxed/simple;
	bh=OKV1efYMrZxsnJ/rWVIilTTMcKzd4WopWuD1/2wnSV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGCmkBqJ2MD8L7yViRCXZ1PmaSupVXzAfeZmYJzvalcF+hbejs4N9BDX7bHpjCmDK1kVyLUHo3jIHzgcefqDP47KBogKJkEi/sayLIx/OfujOu/5SsR0WMUGJGoLMI3Ci3MiC7eMnBu94bN8DZg3FFtBgfZRgPWYb5aUO2cyGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=csj7qKSQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c081915cf3so523425685a.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Mar 2025 11:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740945413; x=1741550213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGINuK0Lq7qG+F3Hr7JCQc8hjE7AHW/exSMusJ+icT0=;
        b=csj7qKSQejYh8iFxM6qi5ZZXZsX/5hcCXUxWjNh3Q+/b3XZUOYE05n1Xh3OH34viSq
         Qxyfgo8Hw7bMXfVD3XzsysjPDRCTLwMYRJlGfbCOx6fXp1V42+qGca4OD2a0BjYjOGdb
         t+hj+Py5xxkdS3zYU0YqjLOd45arC9tbP5yvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740945413; x=1741550213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGINuK0Lq7qG+F3Hr7JCQc8hjE7AHW/exSMusJ+icT0=;
        b=mJBZd5967PKmGG8KJxj7ipxQFUeoqd/7O/yaE621KaDPDLWYJokA11q85/2N++ntFX
         0/PHIDFQ50XaEBxwfXhtGRNj6A2eGU0pT045+nSdxvIkg0Ja0K0LJqyd+y0z8svN74xy
         SwbAwCayXkh+TdGx8Mo8IiZoBGNgxs2xqk7vWO86RaMWLtY6WGFKFh4z0dPuR3GbJa3x
         SOD176nx6nEV3+VNRiFPR7AlCjbuIlkRcs7+pV/tUjhVU83hjSLc/+1bDctNSh1xSwsF
         2e+CNx3g+cW2red8gmdPH4/9lBjaGm/JaRqQfeQNUzUqu3QTgLd+pFqsaz7QRpIESEht
         y6zw==
X-Forwarded-Encrypted: i=1; AJvYcCXFUrdL8DGsylgzfNd65W550BZKclSvu4b1sJzAOaSkSIfMNFCxDguoEoI2LG8wyWWzV7j0nCOHp6eZuTOiOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2OxlML23HiqKwBKetSGTphV+W+G774ihsVF0Q3JERg0HuRdYB
	TFcHRCgM7aON5FnQ4GluJTlFtu2YxgYfN7nFysp/O48M8bIXcJSIoRlTmekaPBrJj5HodVka9pA
	=
X-Gm-Gg: ASbGnct3m2FZnHLod8kBhf8ceSNtSkGcbbydvzvGl2Ih5ZlbiWvbZ4AIPYof7g8FrSA
	eubWPV0wlYJICPozxsFkd1Vhp0N/hBk1wk8riGNheFY7h/NosIjiR62FLW0VBFsUGVxabcDptg+
	ea+9kvD0ARfpIaWtrNFU6V2oObVT1YFsVcBUaX9XRVlQDglxGX3rw/UOifW8IB262/ynt0adUsV
	pcXtg15BYhvRa2B1suF1WXXXwK2SfSyQILESwv8cEwghWk142/sAniwVHiPdCQqxe1XJC8cfW/Q
	sn+a/C2H1kThP0XaHHVsR4U/dJUzv3/VCGXvTL4JNb4Ct2PItqgZAliWAuK0nbIbeqmuVncxk6N
	7CAigGaIh
X-Google-Smtp-Source: AGHT+IGbXzr9s4ymWGTthjG///u6quWwm7RPFun0olaQsyYMuT3T4IUKRuIvKeZhE3M6CD4yK5y5IA==
X-Received: by 2002:a05:620a:f04:b0:7c0:ae2e:62ff with SMTP id af79cd13be357-7c39c4bfc73mr1629241485a.22.1740945413257;
        Sun, 02 Mar 2025 11:56:53 -0800 (PST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3bace543csm52183885a.89.2025.03.02.11.56.52
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 11:56:52 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c3b4c4b409so112357985a.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Mar 2025 11:56:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXrfc7pjN+/hgUKaWg4B14DAVyvulzrwtwNzdUX/GIzZhf5QXT3Zc19b0Rftqpv7v9hwnZ1+L+kwhxLMtiLUA==@vger.kernel.org
X-Received: by 2002:a05:620a:1710:b0:7c2:4a63:1a5f with SMTP id
 af79cd13be357-7c39c4a4736mr1373896985a.1.1740945411646; Sun, 02 Mar 2025
 11:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABD8wQ=pU9Yc45WE07FGO40MUBf+BSZFGcoO1ff7NxC1cXzx-A@mail.gmail.com>
 <d4c5d4f6f47d4d926c7a2469cb4b85c0850945ab.camel@mediatek.com>
 <CABD8wQ=K=xa4+KoEWuQNaMRP7A8fVY38ShyfW3DLcwVcU8R2aA@mail.gmail.com>
 <CABD8wQnRAdEUnc=NUeYjTXNOt5oX6secXw5jgC1C0Eb2wp4cTQ@mail.gmail.com> <f935443fe3970d0e16462dc53bdb4101855f165c.camel@mediatek.com>
In-Reply-To: <f935443fe3970d0e16462dc53bdb4101855f165c.camel@mediatek.com>
From: David Ruth <druth@chromium.org>
Date: Sun, 2 Mar 2025 14:56:14 -0500
X-Gmail-Original-Message-ID: <CAKHmtrTWj_z1bVEZDkSTNvjidTdHVoHqKO9D70ZfpsBMf5WP7w@mail.gmail.com>
X-Gm-Features: AQ5f1Jq-3et_HWVOPe7HtPn0rYvMjAlKZKXqHpAM4f51RCv2Y65rFVDuuq4d6Wo
Message-ID: <CAKHmtrTWj_z1bVEZDkSTNvjidTdHVoHqKO9D70ZfpsBMf5WP7w@mail.gmail.com>
Subject: Re: [Stable Regression Bisected] Linux 6.13.2 breaks mt7925e
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= <Mingyen.Hsieh@mediatek.com>
Cc: "cjorden@gmail.com" <cjorden@gmail.com>, =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>, 
	=?UTF-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>, 
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
	"kvalo@kernel.org" <kvalo@kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

I ran into this same issue this weekend. I tested v4 of the patchset
at https://patchwork.kernel.org/project/linux-wireless/list/?series=937821.
On 6.13.5 with gentoo's patchset, the conflict I encountered was at
https://patchwork.kernel.org/project/linux-wireless/patch/20250226025647.102904-6-sean.wang@kernel.org/,
specifically the hunk:

@@ -134,6 +141,7 @@ struct mt792x_vif {

  struct mt792x_phy *phy;
  u16 valid_links;
  u8 deflink_id;
+ enum mt792x_mlo_pm_state mlo_pm_state;

  struct work_struct csa_work;

The issue is that the mt792x_vif structure has changed significantly
between 6.13 and mt76 HEAD, so I had to manually merge the patch
myself (which wasn't particularly difficult, but it's worth knowing).

