Return-Path: <linux-wireless+bounces-31399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4F6wCzTgfGmpPAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:45:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B64BC9A9
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A74301052D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B62DC322;
	Fri, 30 Jan 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEtLV68g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD924A064
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791536; cv=pass; b=pVh66mEG2fsI5HY1WEKGOEZj6CZxy2YV1mPeI9MQ4lr1LDNB2Z+N7y5HrN7QBkoxitBO2lSsDXPzDVC1+SJgQupkpESv+LRPMrovgBFP9MfiFy6khuZPo0sGXvxkB4PF4luGOIWIVah9Iia2lXjgw3Xro4r1CgM2ZCgpxeplxco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791536; c=relaxed/simple;
	bh=R0ZYFkodNECW1hBhW5QEpLxOE2Z1dNRWPiVSHuO642I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJvEQLQ4xZ28Y5rCpNcBbbGHYzGcFdqjpIFI/TdGPqg6y3INP3XrSs++EV8ANjfmg9nn+uQfbf5qK7kbbCAZui0OHLiBaZ1udBtaSC79XIuteHYWJ91Dug26mq6K4R2z3/Zi6jQ5C0w3DajzexySbdW77+IRmmNz9WyW7efEfP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEtLV68g; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c3259da34so1536515a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:45:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769791535; cv=none;
        d=google.com; s=arc-20240605;
        b=KNl7q8GM9CeATDbshQ7wALrYCOMHoBiqSXkoBrgeaJb/JBbBXrpwjvcYnYMD9UyFgo
         ep97l2Y2NFBt3+Q/qAPTksF0+2Mwp2QKanYldJQMQpig8ZkrH9Ybd4ehDqD5Fv2Of/oD
         UzRvyLOgXda0ZeXR0gzIbj83cNf/VeT2YD+3AkrF8Ebs6yuFuCTOviMZtaE5cq01+fau
         PHNdc4dZRgngoZX7Ob5yOqXJwCDYYwQE5TX2llzjYhBa+O0f8ipAY0vqvWvqb4XXXIgr
         tD6yzbgee9Jp8LXQIcl0tLNiCiMXMzoxgkWmDF+SOrsuWhJeuhLlSHhYXYgc3/L6MuJa
         DEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R0ZYFkodNECW1hBhW5QEpLxOE2Z1dNRWPiVSHuO642I=;
        fh=wy5iqssx5m+Oq4PpGq4u72fEG4fLvqvXIWOY8FBv6R4=;
        b=R9y9K7fZNKqh42IQp27YWgz+CjFUP429tVH514ExgKqOwnG8GFnal78iUAJSIivbJi
         duTV7Pebs1fMmFunzmf4er/YzFYTuAB6YlcAdLhrICFyIf3HnxbkdSrYqv9oXzrJv+6J
         JTdlAzxqSvzt4pVyJBP2+2cV8/hPBSj/AgM3XHznr9TdQCBGpCc4Uu9wRiwbGArVx3HT
         /JHzgRfx9zOFwrhPoWe9ZxBsLOHBDlq4Q0eyr3GLCxMY3Zx593jTgYuFKIOkT/pl8llv
         cPZ5s6qudzpzsAYTDxNd/is2uu+XC+uVgommJJUyT9j5DDsyNR1XtPWvLNS8T6Cqqfz4
         tA6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769791535; x=1770396335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0ZYFkodNECW1hBhW5QEpLxOE2Z1dNRWPiVSHuO642I=;
        b=ZEtLV68gXqDFU8vm+9cG8Ip7FHK9CvgoRp3rtyIr/pUWLWc5BqirRNbbr/0QHr1G5z
         70Cr1NvP5Jhnx/9nCwNIKyuH/IV34bEJ5i1FeI1Yr8XMSkb31W4YXnr2nLhA/Cic4Ua7
         VSovsLUpng7Dfd87DT6cU7V4VvOere1sgLwaUJ+RjrH8JNd1aBXJs2BO+42XQKFjMLCH
         Z9+v8i/0vqaPWql01bFUptvzjzLcDy7DQD/dKIAlbHiXLdB1iiEV7EUssXT3Jn+JuN7w
         fQnhoC4rodP5WGZuWIuAaO+tJCAirpi7aRTCoaiEP4AlqOtKYnql4rWk+k/GazB9OogM
         RLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769791535; x=1770396335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R0ZYFkodNECW1hBhW5QEpLxOE2Z1dNRWPiVSHuO642I=;
        b=jYMUWmOG2BftSwiwmiMbEXgaHStPtzWZCqT8lm8hn1j6qm0+QCzYTwL031wja+ia6t
         HycprA4813JBs6llCvjyhOLgXKv0bhPq04SvY/0RCK7xAi5Fph5juL6ROB/K+eZzJCqc
         JLMFprs9pttjGJ5TnUBlPg06VR+g2eym7/MPSNZRQpQ34wzXyZd5wHLNIxgMLTimpE57
         Mln618oWOGpyq+UqDHP74sLggLQ1WbGRaT2loOUU+0w1DT2KLTb9EA2BN9hUlK0Ev2St
         9zuazOEFQOkpw8l5oHb9MkJzUDL+NnF1HQC1jGLvd+xVcGARBVw2s+bP0EDCifGFSsUk
         Q13A==
X-Forwarded-Encrypted: i=1; AJvYcCUTdG0iw6YdmoDXu3lqSND19Bgk06BryKPH40LQPBSIDe4uxf8pdIgwRKfYQPft0v4Ybh3MqssexH/m+tpBWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBlKALOmjj1ryVIvxsMLjUMTr/U85khmVxBzpbRbWJglNB6xD
	t2OP1wYrJ6LEpWSPHKXwdsMYEgBoGOWQm1aJVtC8lgAoKnl2HjhHP46vewTdQtwG9J0b2bAknN5
	X+02oEscY5X9P3LuWFXuNXwarsLxJUZo=
X-Gm-Gg: AZuq6aLdGy0V4t367D4ijQC42S4VHIXF4Fr6AnUM33DUSnuB5zzDWiJoL+lsDyL5p3y
	ZPxcZRoZlBnmmRZCHgkFMvHwCugzK1zCtKdBuYtAwgrWuGb5BAVcsdcKGYca5P0lm5OXgkQQdd3
	XcxyVNWdq+gV7ZZDsXDhludZ7Ouyw8ZDLmxW5ZP9STz6nlqG+hkdYGQOGcOw4W/gqFGjSQ8A0Jh
	oOjBscWtqAmc+S3QuGJErNve6AYCPUYdneKumRAWjGppOdS8p72qmsweFm9WGhXSL9h126GLArD
	j26Y3ATF3ow23Ajg0ZslgyloG2l+
X-Received: by 2002:a17:90b:2cce:b0:340:e4fb:130b with SMTP id
 98e67ed59e1d1-3543b324fcamr3550336a91.14.1769791534812; Fri, 30 Jan 2026
 08:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126095244.113301-1-bjsaikiran@gmail.com> <20260126095244.113301-3-bjsaikiran@gmail.com>
 <9ca7ceac-2799-4993-844c-8427508c7d9b@oss.qualcomm.com> <CAAFDt1sxWMb1xPaWGWGE1XVFxRKwjOuQPZ__fNTH2+ujXJ6d5A@mail.gmail.com>
 <CAAFDt1s8HPQWJpSiDDk8PmUAKqkQHELcJj_F0faZ1C9RfiYu6g@mail.gmail.com>
 <7fb6b431-58ea-47bc-b251-5144575db17d@oss.qualcomm.com> <CAAFDt1s_NtY1vXa5STRW7oQn9yDJBC0g7CPSZXn0tFhd+CSHrQ@mail.gmail.com>
 <fbcbeb0f-c073-4da5-9dbe-2518a1d31f20@oss.qualcomm.com> <CAAFDt1uSQce_9AG2488yaeeEjCwQwQubW51K51VHiJF8Rp6xRQ@mail.gmail.com>
 <b96b9fb2-3313-4c3d-b20f-ea477f72bd62@oss.qualcomm.com>
In-Reply-To: <b96b9fb2-3313-4c3d-b20f-ea477f72bd62@oss.qualcomm.com>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Fri, 30 Jan 2026 22:15:23 +0530
X-Gm-Features: AZwV_QgSn6Pkd4HnYBcShPydd4sW93l20QxbCPitlbZLmxOdzbWGi6aTvxu9Mlg
Message-ID: <CAAFDt1vck6=sp4N+yEi6J8WwOmW-ZLfHaFXOaB+R9tMGophMDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Fix firmware stats leak when pdev
 list is empty
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, kvalo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31399-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 81B64BC9A9
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 7:57=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 1/29/2026 11:32 PM, Saikiran B wrote:
> > I have merged the tag, applied your patches and I can confirm that the
> > leak has been fixed.
>
> When I apply the patches would you like me to add the following?
>
> Tested-by: Saikiran B <bjsaikiran@gmail.com>

Sure.

Thanks & Regards,
Saikiran

