Return-Path: <linux-wireless+bounces-37041-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO2gAjJcF2qRCQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37041-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 23:03:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E585EA4D9
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 23:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC846301C14A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AE1364942;
	Wed, 27 May 2026 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAK2r7Gg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCA3101D0
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 21:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915726; cv=none; b=U+4d6Iyk6GlIrKSOLGx9ngwdthA8pXHnNQrIUW/FEX4R96AnPmL/Ee1wtQ1oTxz5LU8czkpf5ArjO+YuRO75fts70GYmFoTDbFkfGhxRL2MlQ/ZlThkC0xV1Q8l2b20worpWWTwvzmhnypD874lRVpSlLa8nNn/ErerGqRKaT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915726; c=relaxed/simple;
	bh=6YQOFDEn/esbb8Spr6eRaA0TCzjbs19zP6cHL+qvQg0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=InxmizMx21zAswNFZJ7uZhaNR8HajvwtfLtp47KrZp7usaDJ4e2rIpFpc0iK0ljogxyj7R47chmB7fRwfbr0QfkiHEUBop9xvh+yJohGoFg9tEfYPBlsY+xeX4oZz0Bz3KyJSev8B17gTwJodPeQIuKKvFEZZ6QWkMJHr7j8Q7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAK2r7Gg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9144163319fso1269055585a.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779915724; x=1780520524; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YQOFDEn/esbb8Spr6eRaA0TCzjbs19zP6cHL+qvQg0=;
        b=pAK2r7GgRvU2DYV67t7R0JkXNucec3Wj+uHJNTA7p+IJYLsW8+UQYh4kAUYsTE1+J4
         5nw6kNmpppOHSslJoCvZwlA7GeU+B2GTHD7T28F6zB5Bo2w9FSAVJRIqFApL53bXnAuk
         9UHXQN6NDCYKY6367gOxPyWCfuzyoTsBn3dYecKkDwe8NjoEE4qCgDbFpLfiuxIom0lo
         0UxweG7n/KSFDfFrANxbyiwwQA0sOgQo1FfAC7qWI5lGnmnXQuo1h7MkzEVjIS+FEtbj
         CCx0t4Map6ZH9yJZdX/AEN2sFCiNWng36sDm3Y6r015ktS6nmFO/l74IGAHZmyn4Gbe3
         ozpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779915724; x=1780520524;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YQOFDEn/esbb8Spr6eRaA0TCzjbs19zP6cHL+qvQg0=;
        b=HKU8WM3n6p5pUhnF8yZDhv70H2MrNRDv3cxlP9EZNk1w3zAUCzPrmYjOP4VpgogmMb
         pzMQ/JFLfHOkB/t1TP0d/Qai1W5mjLj0PjGnvd4IFVRS4BwxZ/0GWBQCquCahslJf7Lg
         5eoDZdDNsYErUdT+z2Ck1g88+mUC1S2EIQnNEyulmMtz8xCB6oCDtCf8HF7kuOHifqT8
         i70xcI5zkU3uzzPXL53oSboxDh923IdlFzyUnchUDLuAyPivJx/wv0Um2yRXUozp1tMN
         rJUrl7WFnZHDc6brQTQEKfuzPuSvxDNEJSb7/R+C7WCZNHmvGt94CJmqFQ0SF+I/rg0M
         65rw==
X-Forwarded-Encrypted: i=1; AFNElJ8nEn7aTZqdmfegorc0ORIhO5WeWOt8bq4YJZ17HYmuPG+v9eBOL5xTdphX2v6GRKoMpMxGjXUKM2qbf7qcEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0b9hAL0Q4uhgUTDPEhfWDidiwy5tkg0VhJWRw8Vrd/EOc3xoT
	umia7tQho0MfjUIPgNN6rZTVxoAQroPiEmObHCUEXuSYzpUiZUyY0r+X
X-Gm-Gg: Acq92OHFKsN9RFjy3FF62L9n6oBXG7rzG4bmrxlXAPnUnweUvRBmKAUmQBbiSD6TCek
	RGNzFkX+f1sn16H00pzXPLuxi0D4g6wT2C1wV7IFFkQobXG7itGqudRCOTjWK7rhKejyl22owJu
	BqbkgL6d2rtJPIPH97FVxEo4ZzF/PDHqm1xtQcYE8glI5fAeX1VfJXGDpdPW1rtluEcszOcO2z0
	RX1Hc4cCFxHEnwa6vyQUQRiGHgjn9VNFDSD0pu+K2Gw3iUF4WYugMZesgF+eVf4Grj7noiikR33
	saYQlEKMr17+sDktoZkM/8Z/Q5u1SxKxjKj/DY5BWL8Lixu46Ek+BPnLxJqFaKhgzO1OsLwwud4
	P7PwsI9zmtQGWEk+xIhtvKi3zAo9UfY7g6bC1BnKgK+nkgvH1BF4XpTOzWVr9jWrY5Y03KEnNLk
	gos9wK/i73DhOyR6PoCcNng+S/ER9JDOL87xdAEpWrFc+8tIp43ZzWTmZvQx06a4JbAmQ2n0EeW
	yt2GsGHWVTsSIIiHHVNPgQazmiQt1ccuiJTydRPddywVLRPLuCn+KgQJlP+hQ==
X-Received: by 2002:a05:620a:1d0d:b0:90c:9b5f:84f5 with SMTP id af79cd13be357-914b46ca130mr3452925485a.6.1779915723821;
        Wed, 27 May 2026 14:02:03 -0700 (PDT)
Received: from smtpclient.apple ([2601:19b:4200:392f:e976:246b:e928:1bf7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f8706968sm578168685a.17.2026.05.27.14.02.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2026 14:02:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/1] wifi: ath12k: support calibration-variant from device
 tree
From: Andrew LaMarche <andrewjlamarche@gmail.com>
In-Reply-To: <dc8c9c9c-dc85-40dd-9313-845a808a35f4@oss.qualcomm.com>
Date: Wed, 27 May 2026 17:01:51 -0400
Cc: Jeff Johnson <jjohnson@kernel.org>,
 linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B9D1FBE-37D0-4902-8C0C-8AB57C1310A5@gmail.com>
References: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
 <A2E3AAE1-1A80-4265-9497-0C95C3308CD7@gmail.com>
 <dc8c9c9c-dc85-40dd-9313-845a808a35f4@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37041-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 52E585EA4D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ack on the deprecation of qcom,ath12k-calibration-variant in favor of =
the
generic qcom,calibration-variant.=20

However, drivers/net/wireless/ath/ath12k/core.c still misses the logic =
to=20
actually load in the BDF, which this patch also accomplishes. I don=E2=80=99=
t see that
in the Qualcomm-authored series you linked. Perhaps a v2 to address =
this?

Andrew

> On May 27, 2026, at 3:52=E2=80=AFPM, Jeff Johnson =
<jeff.johnson@oss.qualcomm.com> wrote:
>=20
> On 5/27/2026 9:12 AM, Andrew LaMarche wrote:
>> Hi,
>>=20
>> A kind ping here. I=E2=80=99m not sure why this functionality is =
missing in the first place, but it is needed for loading caldata from =
the device tree.
>=20
> Your patch duplicates functionality in the Qualcomm authored series:
> https://msgid.link/20250228184214.337119-1-quic_rajkbhag@quicinc.com
>=20
> And note the upstream device bindings for ath10k and ath11k only =
support the
> generic binding qcom,calibration-variant.
>=20
> There are no longer any generation-specific bindings, see:
> =
https://msgid.link/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89=
c53@linaro.org
>=20
> /jeff


