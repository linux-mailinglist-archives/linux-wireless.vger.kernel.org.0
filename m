Return-Path: <linux-wireless+bounces-37594-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Di+XOOwrKGoA/gIAu9opvQ
	(envelope-from <linux-wireless+bounces-37594-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 17:06:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 425EB661842
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 17:06:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=Kq7nop5I;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37594-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37594-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB52C3101498
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F1383983;
	Tue,  9 Jun 2026 14:53:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55A35C1B2
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 14:53:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016814; cv=none; b=FCmhjedyddr5iYRbxfU+do6yvrHEszd4WecI1u6z13Lk5hYHyuwEO6Ygp8Ymicel+FWFjtdPHVGqNMjFxDQ7tZrhLdUXtxcyaj92+VP175hLTzdXMCouaGrLqgvvRwlsgZa+mLnUTwtd3GKEnPsOF9l4MgTFstJq1GruOUb98s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016814; c=relaxed/simple;
	bh=T5WTr7jmHvoqqrrXzwILgbWbeUmEOQN5/4IBCNi8Xy0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SyhID2g/4Iu/WwKpMXS2BpFBSHf+VUiHXnl8wNMLSFjfkrbDMedO9Gved/2iXTXZqYYnInXBufUR6Z6slKx2BM3b2DYdexZAhcDR7yhtwkdWmK3zGMfnG12t8DRX8mTd3oA56irR/taYxsZooQJtfzt+WkWUUh67TvJnAl5KUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Kq7nop5I; arc=none smtp.client-ip=209.85.128.227
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7dfe7712572so53498217b3.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016812; x=1781621612;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9nshAheis16fsfBtGYld+unMmzzCTRT676gO2+SBa4=;
        b=Kh71rUOSSX085mh3lcTIC9/1OwKO5SFt3MxmjaXUS3UIq8lOtARVpPFWUFVDqYt5b8
         c+28BGj8iRJTiDWHImrJJj8RmpuG/gHmGP5qrwYSN6KwpYjEop9HxfCF63PTXVRl0PRv
         PAUIY0YF1v4L/PNeHRE1FZZy1IR8A6bKpO170W9nGCqptIQxIpe9BU46YBUSCxwO7jGN
         4BuY9kSIX5m5NpsnVnrRqLPIdIlprpgB5z//THw5WO+ngxg8cLaSPUyExkl8yoVu5U5P
         ZGzk27Nk9NMbRBW2w23Uilv/cT9WHqgZBgaWFwfapj70A06J1DL+kvu30xR4ow9Q3wxC
         +zfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8x05H1mYT4s13FJrAOGZXrxk/5McerxpqbWKPwxKjqGZGMjUcFqycpx+9DnH+9ouEKEbInQABS1z69wB6N3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YywNbRbitGQd9BupVUrivOmHzGQ7UX9RC4FsT8Q2Gycs56QLTBN
	ZxmqkxVe/rxBSihGIt9+7ISajsB12NxbNyhLFAKbvRkq50tBySXo/Nrt3EM+7mOpAnjJkeOTdhe
	UWImqOR0Uoi2Kc+9r0o5BD54dj49Ek8Os9KBjlfYkY5LBaCnxsEeKqCm4ibMzLCE/ukbiLvvph5
	hQjkNSaQMHKNNLaxdo2lcUIcM2f24kBEbDOrkda4nAazdQrrtWJGgdauc9CqgLCuVQmN24tOnfz
	MKgbD1tCG3QZ0IW4yK7yNZmnDWt
X-Gm-Gg: Acq92OGsQBFMsyK90qLy17juQQ5+0uNrIaWrlJC5QBlUCCZvuVgXatohjH53mNrOgQt
	wUBSxTngwZUyIjM30Fopx7pByq6L59iETu+sWEqRHrqQyT/4nyBx4uop9JBmruQJBbn7j6VieIM
	lhaIjvSmKSU+/TR+wQ4zooAE1KU/bmuUUhAowfweQa3jCo1+EMYdW3YmF+izuyUzb109lFS0Pti
	vmguRJGCItV5Yt/jAP5Ius/SNStoTLK1uJNIfG9b1CPdcJYOKtCki5bcZxKH1vJ9gbIo8uTuMqw
	1wg5RKNiPTmziiY4XNXrP9h57bjAMSmJUTsAQAHuXAfeHWdREXGZi8G+MtI5x+kDzBw7CiG1+Rj
	mQT6FMp0OyIVk0IeIwJpQEYHaDo8wkIswDiDfLYVSty9eFmLpyqZthahJ+0O4HaUt7eA5payNdd
	+gTz0mEkOu8ekfTvejoHczH0FqnRAWfMDTLC2zZjqCaM+4oMq1SIcE8FpoCh+1fRHfEQrCfXY=
X-Received: by 2002:a05:690c:e1cd:10b0:7ef:d039:a32e with SMTP id 00721157ae682-7efd039acfcmr94338417b3.34.1781016811914;
        Tue, 09 Jun 2026 07:53:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7ea23a95d93sm15332367b3.23.2026.06.09.07.53.31
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:53:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-becd1c46294so549457166b.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781016810; x=1781621610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9nshAheis16fsfBtGYld+unMmzzCTRT676gO2+SBa4=;
        b=Kq7nop5I+99JEKXreHXLjAFIYdMUzJ4gGZW30flLPh6KXcpqNtGm7Fqe+Zu6xeFmci
         TdBZpIkWl4x2OpbI2ey3fdxnDfeNmmqZfY/iKWBIKHBSeLebaJ/kSTlB7D18SShQRkbh
         xPgyTJh3ymt0CzmlAi9mlTrLWM5uTV25CcbBk=
X-Forwarded-Encrypted: i=1; AFNElJ8P+/xVFFzYTfeZRaCKaYhpjRX75ICpFlyuMfSs7m5LymflH9HX3urhfi1u6rhTvVyHFIUs/rRJ4bwECEGeFA==@vger.kernel.org
X-Received: by 2002:a17:906:cc55:b0:baa:1d9:66ff with SMTP id a640c23a62f3a-bf9373dad65mr124057266b.20.1781016810170;
        Tue, 09 Jun 2026 07:53:30 -0700 (PDT)
X-Received: by 2002:a17:906:cc55:b0:baa:1d9:66ff with SMTP id a640c23a62f3a-bf9373dad65mr124054566b.20.1781016809689;
        Tue, 09 Jun 2026 07:53:29 -0700 (PDT)
Received: from [192.168.178.59] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0558f3885sm1052383666b.54.2026.06.09.07.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:53:29 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Rosen Penev <rosenp@gmail.com>, <linux-wireless@vger.kernel.org>
CC: <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-kernel@vger.kernel.org>
Date: Tue, 09 Jun 2026 16:53:29 +0200
Message-ID: <19eacdfce28.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20260608052854.11718-1-rosenp@gmail.com>
References: <20260608052854.11718-1-rosenp@gmail.com>
User-Agent: AquaMail/1.59.0 (build: 105900627)
Subject: Re: [PATCHv2 wireless-next] wifi: brcm80211: change current_bss to value
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37594-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:brcm80211@lists.linux.dev,m:brcm80211-dev-list.pdl@broadcom.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime];
	FORGED_SENDER(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 425EB661842

Op 8 juni 2026 07:29:12 schreef Rosen Penev <rosenp@gmail.com>:

> Change to a single allocation and remove some boilerplate.

I thought current_bss used to be NULL when not associated, but seems my 
memory needs to catch up to today's reality....

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
> v2: change to value
> .../broadcom/brcm80211/brcmsmac/main.c        | 40 +++----------------
> .../broadcom/brcm80211/brcmsmac/main.h        |  2 +-
> 2 files changed, 7 insertions(+), 35 deletions(-)




