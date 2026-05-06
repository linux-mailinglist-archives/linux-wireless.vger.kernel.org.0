Return-Path: <linux-wireless+bounces-35960-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLr3MvmS+mmZPwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35960-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:01:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D32A4D522B
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC10D301F9D7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 01:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D81F5834;
	Wed,  6 May 2026 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beVj47bC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB21C2FF
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029301; cv=pass; b=W0AgwtY37qJc+VhVTtp95I8L/1VagAZCqHkecKL+cP41STiY5M/n4qibYQ+WYpi2YCEdHzEyKelyRuB8JJ6RerzPLyNSyaaI48HTp+l8LMVxExjI0KYxx0uscG9YP28cEOOfjU+SMWHhxnbwEBhrpbe+beUmLvUxsYxdu2WbYSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029301; c=relaxed/simple;
	bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCM4WwRerPNW/KuepmcBV4XskxdbAcx+oPyTft7GPVlEJphzPEUdYfSkwwZ0wYXdrJm5BThx871ykppSbpClvgODkKM9G0v+Lk7cvkhaiLmkVfbVTv/TYwgcPm/Ls/DtqMveAoDiFEVGL8DJvxXTQGX0PoDhVl03GuHQKEfpu30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beVj47bC; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso3840731a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 18:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778029299; cv=none;
        d=google.com; s=arc-20240605;
        b=OgbT4r02t7giNWpJXnzU6zBZ0xECzx+fih2DpCCNOQW1mDWXSqO35j7elAMC42anYR
         DdvvKXaCRyiIvLp1NmeR5pDNm73DRK6dqvlNBQSAdqsRGtWUVvPhDfc7OnENbkfS5hAq
         3efWzbYTm6A8KDQHv0bLyyomFPYAe0mQ0HFszD8WNSHwH+vmR6rxbZ0UsGLpVTMviLys
         /B08lJKhPLrAY1527ySeqkNrUcS+3FPJj5y/xU++LXBzX7NvQRqv0n4LPnsF2dq9Vfb3
         f7l8e3gUvwzkrwnucC13w4GmUKAw2dw0bhLQco9anAkCPyWIgMFw6vPniBGn3fEW5/3I
         rVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
        fh=X1oYs/ABUxEGgQjQAuvCetejFBMzla0ojnQVqxzLCqg=;
        b=eEgDUy49fVk9RiSppIVKwQ3KUEEokDI+Yid84pVpTZlFFeDIA8IFXmZrgvyG+C2yEp
         VZ9cHm+bbC/doBY12XjvYF99SGei7lBk/u7QhqhDLRoP4y6owoSPpJIpTB+b4DV26Mfh
         2paCUkG4MVLpDslearJZagIYWXHOCkwFhXyWNyT+QNoQlD+gAGrZM7daF/WOQAU4IwxF
         PMetDQC452DJtp4JYpvKKLeBGQIKFe/Hvw8p+8+V7LNVGFlJooq4RodLhTbwzo/263+q
         UhG67VxPrUinK9D+7vFqpvIooTNx49pExXZYIVEXquweaesBz/1a9xR3wK7Pm0KX/o7U
         EkJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778029299; x=1778634099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
        b=beVj47bCKpZ2igL1dl99Hc/2sxsY/mPakX8IJ3RQA/dM0Ieo1SUFcIE/cvQOuO56Gj
         ycKuna4K6/hIRMXoc3vKVdHWPY21fVCVoIMYzm/8YWwjs28qtBznb+ks+VD84QzKz/op
         /XTQsdNTH36ZP/P6/rgctoJz8dBX75n/XmmRFxhxvsXHCji9LeRKjn/uUhY1PviR8gTI
         vOh1z81mDfkxDsPG6zvoE8DXRzHc/L5MAi7jHUqenCUJRXiO+GF4a7W4q4TJ6K8T0K4H
         B9mk9J3P5dlRK0khuD1J24C8kYWQYH8GyuKZmkE4i4JCnRmDghXHTnGpgytAP+XsH2so
         8ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778029299; x=1778634099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwzorkUFHXdlT8TM8w+mRBafUN4j5T2DUosmDnooYsY=;
        b=P2isA2JtTDgkuSGJACl0X/A3Mm7ZuoCBaZgkth/yOEMQJuyvL19zHGtqGO/C8sxfEd
         7hA+YrT89UL6YUy55oo26MxZQPBiSoxIGGRVZbcodjXkvIGFmAqqHbiBI3++iF7Xdd1D
         tIHN4JbyC+A2pQyw1qe524/SzALATFDUXFwleU8ljWrTmJQgGzWa094Gf9aKkU7/Jl6q
         odhaQtpYYOg8xkg0yqSOM8+RbCwTWJzfVPmhvhG3LSl4xFc/0iebkcyI9kblTBdjKEZQ
         7gjDjWRomEiD3/Luq7p5uil9ecpOoZ+2lOjkOQuJMTPi+7NQ86cenurLKv9QZkf2yrOj
         rnaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jzYyuBYh1te53E3OK9hBrPcqgaxKgjGeWj7J3TSu9e4Q5NHOhCJb8amqQAp8HtCHeVEypd2ZiuRGlBNW1uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDSwU2C71JONNWfBOZ6z7jTwJlkiP4HiVRDxT8H/G661DEWYRY
	T/3Zki2cunilcN+tkqf67Fi5ARlJGCF5s/N+AbITj/+jGxwoe6YpgSW/JsJCYuHQyPSsoiNzauF
	Ym0sroGFWY3Y/6GRWge/6T1R2Vi3PRag=
X-Gm-Gg: AeBDiesEbgLpZpTj2n8jI1jp9M1KVeYC545j/dDrdvcg+kgv5tipvq5OmIH7UFcZTGV
	J/B/oXy8Zl8djJE+rPgGdDkpu35ghjppeQUrumfmiG6zjMd3rYekahhdcdmMWQ6HDc/jRrcFysF
	oYlbhmyXjVdtGRIwLmemnAclf4DZNgLvutXt/WuikscLELbdqFjd3pClMnz32y1FPXj+UaRsW6x
	g/u9Ti78mgVYeCSHXL6GW92NZFaMO0ieSSzgiWOIyMoFfeHBO9GGb4vaTnIRV8MQXW4iEOetBPb
	dQ6nEUfsfxUl5fiMQHNR
X-Received: by 2002:a05:6402:561b:b0:674:74bf:8813 with SMTP id
 4fb4d7f45d1cf-67d648a2908mr225875a12.21.1778029298587; Tue, 05 May 2026
 18:01:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com>
 <20260503-mt7925-tdls-fixes-v1-1-dde847e21081@gmail.com> <CAGp9LzogKfGovfDw+=m4BkqWAakFTStXH20cQ_FA_5-zo+rmGA@mail.gmail.com>
In-Reply-To: <CAGp9LzogKfGovfDw+=m4BkqWAakFTStXH20cQ_FA_5-zo+rmGA@mail.gmail.com>
From: ElXreno <elxreno@gmail.com>
Date: Wed, 6 May 2026 04:00:00 +0300
X-Gm-Features: AVHnY4INobXxdEOMhemHPoV056iwAV8b_9YlbIjpzUDt0nGFCtcSzWUQppCzglI
Message-ID: <CAJ5_wsS1fMRvD0akfPB-FTcnk+j0pULHrzvOCgVVh1XVbmOmnw@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt792x: disable HW TX/RX encap offload to
 fix TDLS direct-link
To: Sean Wang <sean.wang@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Soul Huang <Soul.Huang@mediatek.com>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2D32A4D522B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35960-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elxreno@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Sean,

Thanks for the review. You're right that the global disable was too
broad. v2 scopes the fix per-TDLS-peer; rationale and changelog are in
the v2 cover letter.

Best regards,
ElXreno

