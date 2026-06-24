Return-Path: <linux-wireless+bounces-38029-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dtm8Ga9OO2qqVwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38029-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:27:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EED436BB177
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 05:27:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=X6nvQZov;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38029-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38029-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 674CC3009CD8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119733090D7;
	Wed, 24 Jun 2026 03:27:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27323093B8
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 03:27:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782271662; cv=none; b=YJ4nurCd7RrGIeYt7+f9uJzi5hnxkvYSHmXawEX8rbUtSBe4RF0ZCRqhPLtUiHdvizAm1KGrljDDiQJmrpXwwwzsAUJbgyodPXkMnwgDmArGajGUk+Iwc1zoXqW+wuidSxrHkUwN60BluxJDkMCofxieSPz9kQmafkyZXPlv+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782271662; c=relaxed/simple;
	bh=sjkj1WJTv/H0CBL3yOVa9IwxqJ0YuI5WAJKIPscWoSQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cGL6iOgHChFhAz8cEBLeOEJvUNHq6Fb35QxUZaURIIj1JUkPsPdgHNdH0Iu/8YNxKRsStOPkOkjpavZlnelYX2cfzhxklsmIwhRR7xuUaqloGKZKqZiRYjPQn2j0QkrDH18/6bEiqs9ChmnmDT85978Zsxn0Jc+7ElCpIrhQ6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6nvQZov; arc=none smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13986d61b4fso853140c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782271660; x=1782876460; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FCQeVwYHW6fnTKD9IHniUoGveaqKUFaca/eHDr1Nr0=;
        b=X6nvQZovD0Hq3lRde4TQQLpSSAaFUhHmkndDP1E5qQgXH3YlRWqcwsNGWEdWQp6mbi
         lto6k6L0TyRnE0a+rPS0ILAa+JeZ5QKUwGqhkYTQyeFjgjE/TBn3fdNatFOg/yo7o7iD
         jqHiwJCmGkcoq+QTUnc8kf+X2k+41BMrFmQC6s2/RGuxPdt+ENp7XlIzxmESQTmhj8Fn
         7iB4bEqU50pzCK+cicP8lRTPQvoZTxiciVa6A4ooeZnAc5nRHJQPStbKOT+CWezyRzBS
         zCa/fdARvtvxH6TjJhV9u5I9MBnX5iBfWoYfeJlrmtw7EyvwRPn0otT+Ro5i2fbiEE+l
         mtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782271660; x=1782876460;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FCQeVwYHW6fnTKD9IHniUoGveaqKUFaca/eHDr1Nr0=;
        b=JgrOhR+p6OfTSMWsTSnTmVr5l46EnkcLf4hLLC9NR/o/xKAGRwmjVJsIs8ZCGG8DRN
         IosVBVRnaK2/Z4phrN6v/4aMkYfKh9poWY56WzJDy/YEbZNfJfZDOqncsmL/0avPfcAY
         H2hAf1cDwMoYyyosiP576tFvCiDzmgK/dNkh6IDYjkelz80LlPilh3PiJVPIVwZk+9Rz
         o0AAnhtNtsKTVnOxEwsQTQY3RSK9uKl7PfW5bw2j0KRre+s9Qby3KZ0ypzXXbddimT64
         XtSa9H+UWf3+WBZrs9FxGPJSCJblXNP3QQ7GRQFkUOu+TFocW3Sf9BKlM6PG+k3ifW67
         7GMw==
X-Gm-Message-State: AOJu0YwF+fOxN4uYjdUiQDwnbkrdOm7OhRRrM5oE7dq814J7/hfCaqys
	iGrZRcMbRoA50vzGkolCdGgD7sj4ezjWb+UtyUmh7sHi6rluoTqA+DS+oW69Jw==
X-Gm-Gg: AfdE7clzn7KRu0v2j/MJ+291f2LCj/FCvs278TUcDZDiKsUJ1/9cs+2Ryl153tLlQHB
	jAW8C3QWN2L1joK3cuZe/yNZe3uripnARIzEr9O40SRj2FTPNsQZSqzYJyn9cGmV1RuOD4CGbLB
	Br4/isRuKH53xv08uRgKQzGIWR7JQyUPulSYaYYJINQ8bcZC5wPJeUjKcvJcX82ICpKiERCZnMe
	Gy1aMTpg9lXS3avtCsKZ+VQ7d4g1Vk32uMQ1OE5F+ERRrN1pcYcHeyo6hzm5s9jWQ96mCJAGuDd
	87SlOgXBI5gnHoj7OSPSCShNBMxHsEFjBth6SWQkMQHyKT3+dcrvB/s5XJZWn8b4HtpF5wGMeZM
	mK+XKn/PkilSF/CsNJF+8gV6qgTEc/aHn5c4HJR62HMOcN6/juEaFVpxiRBOvA5Ojku1HM0+zXD
	5O12MHzuRkC7tFm+qseau/exHVN9EgHypPXeKy/AkTJWCq6vE0+Bn9El9krqrO2TUh+pJbbNpdF
	nDKc7jPAf6SxlfhiMTA
X-Received: by 2002:a05:7022:e0e:b0:12c:2cf8:2f30 with SMTP id a92af1059eb24-139d0c1048dmr1326779c88.15.1782271659691;
        Tue, 23 Jun 2026 20:27:39 -0700 (PDT)
Received: from ?IPV6:2804:34b8:fcb8:4401:fdd1:20c3:6d9f:61cf? ([2804:34b8:fcb8:4401:fdd1:20c3:6d9f:61cf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add85c40sm17516519c88.15.2026.06.23.20.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 20:27:39 -0700 (PDT)
Message-ID: <c26fda96-aa91-4372-8d24-35d3fa44fc09@gmail.com>
Date: Wed, 24 Jun 2026 00:27:36 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pt-BR
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com
From: Gmail <helder.bertoldo@gmail.com>
Subject: [REGRESSION] rtw89: RTL8922AE Wi-Fi broken in Kernel 7.0 (and 6.18+)
 due to mac80211 API changes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38029-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[helderbertoldo@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helderbertoldo@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EED436BB177

Hi,

I am reporting a regression regarding the Realtek RTL8922AE Wi-Fi 
adapter (rtw89) on a Gigabyte X870M Aorus Elite Wifi7 motherboard.

The adapter works perfectly on Kernel 6.17.7, but it fails to initialize 
or is not recognized in newer kernels, specifically 6.18, 6.19, and the 
current 7.0.x series used in the Bazzite (Fedora-based) testing branch.

Technical details:
The issue seems related to recent architectural changes in the mac80211 
subsystem:

1. Signature changes in 'struct ieee80211_ops': Several callbacks 
(including .config, .stop, and .set_rts_threshold) now require the 
'radio_idx' parameter to support multi-radio wiphy/MLO. It appears the 
rtw89 driver in these kernel builds might not have been fully updated to 
match these new signatures, leading to incompatible pointer type errors 
or initialization failures.

2. Removal of init_dummy_netdev: The driver code seems to still 
reference init_dummy_netdev, which was replaced by alloc_netdev_dummy() 
in the wireless-next/net-next trees.

Hardware Info:
- Chipset: Realtek RTL8922AE
- PCI ID: [10ec:8922] (Please verify this ID on your system using 'lspci 
-nn')
- Working Kernel: 6.17.7
- Broken Kernels: 6.18.x, 6.19.x, 7.0.x

I am using the OGC Kernel from the Bazzite project, but the issue 
appears to stem from the upstream driver synchronization with the new 
mac80211 API.

Are there any pending patches in the rtw-next tree that address these 
specific ieee80211_ops signature changes for the 8922AE?

Best regards,

Helder Bertoldo


