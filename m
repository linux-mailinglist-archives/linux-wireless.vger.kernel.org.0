Return-Path: <linux-wireless+bounces-32987-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOBrHdVtsWlVvAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32987-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 14:27:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 160FC26482C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 14:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E9923062951
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2026 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5FC242D72;
	Wed, 11 Mar 2026 13:21:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF441EEA3C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235293; cv=none; b=UTSiYq0g8sVX1FFallkA/lROeYiyRVj4BAy/n16wU7SUKbSwleiyahAawgrRB/Y/UONa81Nzbdt1iB5+CaO3oEZrUCxkIzltEzmufc3PHKik1HKfOvgft3PmWEUtRKWfMR3aNfMmPZvetxyusd0yQ//rhBeVYhWW3XT6OIhLC9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235293; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UN38xyfyMXtcZtQ9gFnZ6CCuVdd8RHVk3PIgTOsOOUwHm0QyRV1LEnEAd+tc/LCTY5m3zvsE0AuA6TndJtSOGDU/YHeov6prW+NkEaAUp5lMaKaB65Me7YW7ZG7yrMFz6VsHnEv26Y3WyrAMqB5l6tKOiJL8t1IS5Rsw57CrgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2422738e0c.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 06:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235291; x=1773840091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=tehVQv1wB2wtVXceIr4MWpjBDq4a6kii8BMLWMXISf3tDZBBJNt0JbGb1fUQ07REC/
         UPgxFnW11yh8b86ahj/vWX/l1QnDK6YkD0mwaiDTfcI2rge0ysegZqV+1vWT8k71L6aW
         MsDeRBmTOlrD4kbtMGlZRQob73RmFQzEpfeHbPjxXctn9WV5siJodY/jv3e/I4jlQf0I
         6KUdXuh4qOXkvZIVvmMoNQ1IquC80rGMTZt8Skw/KTOKHtT3KsN6jQBsEwYC0jFuC8RW
         TSnoI70S88EzLxxYRkXUve9CDwEd8JzsFqg8er+s05sh8qevAHXWf0M8qx+H0WnZx9vW
         Puow==
X-Forwarded-Encrypted: i=1; AJvYcCVl4ooiGII1udOF+sBI8ot4XOPQ5ngaxJU92UzhSVGg4I6NZO9J0qJGJSB2qJtR52gu3xETfMhZOMTQnkNcqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2Q2pZzj3d3wcmL9A1lAYA2ehlgO1zkeMNlbMRNpJyiMkfJs9
	hAOrvZ3zHm9JZnJSZ2OajPnLB+Cffe27B3bIpiqT+WoFPYvpnJhO/0POFKOMJIdUoj8=
X-Gm-Gg: ATEYQzyV2bkFKg/JDn01PacMxr15n9vS2yverbLngqhx1J+GKZzuWd8DrxMQlhq7p5y
	6Ry31mCBF6iHmVJWvaZn/oE9CkOo2fcM2w9nXOKG6XqRexcYGjtwfTrFs+k+mpRx3KQZUBrQ1i5
	hNxbyAcj0xVF8INKaQK/PtkyNoo6UhrGWQkAaKwbMEbZHVmbLdBwG89mZRwgaYQgZzlUkChzq92
	5v2q1TKWVkjuZOofrvtUPXcX0Kqo3E3uNVLKUbcRC54bi2Sw7H++tJaSFmO5WUUVZLdJIvNJ/8W
	R3n4O9N5zhmZyNqW5vc+oNamS9KcZVuyU+pZRZDkN5V4bIqtoiMAYb7wtpL1uaRkMn/iY637bBs
	vTKVE9phnqn3+W7B20PJkZSYYaAerNaugjvaHT38ff6tz4k6r5C3ho6UI162jpA0HhKtun6cOTJ
	ao4aoD8cURK3gUpIzrkxGBE7uOeu14V3KcqxH5nkXmTRCXxcaQMS/uNkvCeYnFkAdi
X-Received: by 2002:a05:6123:147:b0:56a:fb7b:7537 with SMTP id 71dfb90a1353d-56b4769d7fbmr873806e0c.19.1773235291530;
        Wed, 11 Mar 2026 06:21:31 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b47d7269asm690723e0c.17.2026.03.11.06.21.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:21:31 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56ae58f3fc6so6635104e0c.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 06:21:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQE0ka7+g32gHXdcoB/QXYzdR6ZjvWk0Hx/DghRxdoC0J5dujyLCVk43NB8uH1gNGViWtVHNd6ZIpVgUXBjA==@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 160FC26482C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32987-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,sourceforge.jp:email,fu-berlin.de:email,avm.de:email,glider.be:email,linux-m68k.org:email,libc.org:email]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

