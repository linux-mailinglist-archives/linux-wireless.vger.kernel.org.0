Return-Path: <linux-wireless+bounces-31479-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPZbASoKgWkCDwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31479-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 21:33:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDE3D11F1
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 21:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5250303A481
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 20:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4772C234B;
	Mon,  2 Feb 2026 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBbfZ/nP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CE62BE630
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770064401; cv=pass; b=sXTkFDCVXNvCNIgNc4bRgnmaQsYI8SGXpxUiWMpJrqC16P1SyQdkvC8ht996vob9DoubS4mPlaq3ahMkQFMGJm5Isiw0l6Lbqe0VTUlmFLH82c2+//MYk2F8cArm0e8Nw7bXno+iiZ5d3oncuwK8bSJJQol42qcIrBm4P5RWdVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770064401; c=relaxed/simple;
	bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wesl659FdGe6Oq1DHWg7NVPSbuaJ0NyGOpbNT1yenPf9tBNMcWZzEk2dlBQsgA/7GhrgfTldCG1jhbpN5OlFbY20I0norZnkbQFMlaHVmr0B2e2StbK84Zb2aMqNVD3D4jWOGTDINlvuRxUKMDabvot3O3UbG2nkXgPRuUfKKYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBbfZ/nP; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-894a2309a29so1497566d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 12:33:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770064399; cv=none;
        d=google.com; s=arc-20240605;
        b=EiNRNffh/HZiW7HKn4ChnXbVKBTwzkB3MBUU8KEx8PGJ/oYWDanZrUSEeUYJAlNnlc
         NMl4n3ViriL0ckyh9S2pS7A20yjdrx0icAWtNPG9NlKAzIdAoL9ktUranQORo6pGrzxt
         6hBal6/xLfSORlhmg4CXDEBxovwKIP9WZGIwNoz7IoMOk3321pOmFRoRwgVAT2SO1L+n
         BPDXzoJ7LKYBWEZrN+68Jr6f5zoBziXpZ9p3Dm2fHtnrP3uB/+urhq+lcJrtRw7YyTW6
         N9sFHDoVEC+hF2UXWmkcQcZ0axVqJIhI46ZV2IyGEhEQ/Q5o6hNmiAcuI6nncTe6rdRJ
         vMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        fh=Z10I51xaA5Zd3cyf6YsQ3U/LafNJH8BD3OWWx3HCFwo=;
        b=L69D2uYHpsNrBWQiweqLo/7XML//VjOQY6ug7AZQcpIJfS3FR6cQhoMpgRtb74xkSV
         16W97HsDqmWysqKMzALns66UJqKEHhMK1s1zEdIO1m8zv+iyCvrs5uplg2a3PAbUsHoH
         hL86VtoP35ycJRuakGVR6hpO/TWYtRCnskybqkE2i/9Gs4sTI/sDtzPd5mf2YCmhhhyj
         /nFoWVstk1G6krIt56wvSeXZ4sOTup0YcvQk+UvQwJTudM2M9lOKG+wR9HhyfRNkV7qo
         LDd+X/LXN3GFqXJEYpDEIz/N+rAg/tz8peErvab8Q4/I3ro7NzcdO/dumdO/L98NSQ31
         g0BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770064399; x=1770669199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        b=iBbfZ/nPM727rAHUVpxDEmU9ximHbZm2PZsukq+QQ6ysWqaAcE+pX4uF7bALK1g2+H
         6oVaWZ3ajgONPypjpjYReHAlmos1IS6C0OzzOqDrHPIilISJtcwMJbx/rmY9QU1o7OmN
         UXf0vh8pYTN56PWZSFiz4Jf09CzEShZ1jTeeP1MM3wZyNjdzuYpO6EinNFMXdmVeqotd
         jNpbm0GYZf9zOpkm5+y7w1hjr8DveNOGkgi1r8AsUNgR5QPOywyBZ8XRUO0j1AspDxc6
         CMwYQMAgfWAqPzblGt1LhOJ1bcjn/fWMIYp/cEnVDoZ3mDL2k1tNZP0ayDoYcBUPuL+j
         SlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770064399; x=1770669199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zw33QJLuj4zDH1jnM7FwsEfVT4ksE2HRHBtT8OxgQ2Q=;
        b=SBzdY/wONeRJeRhr1oIas4GyS+W5YrITCe9BEgllLr/cZ//ku3KgKnRBL/UlP1rR8P
         EABybIRD9ACz6WNxZi/bOLxGPU5qLKlh17Ra5Z5z4pb4/FoiB8x58sUIdg7O+MFQw0Sv
         DvADgt3X5m7WFOzNoPiYysMYIG/wvbgv77ADhwqudNg1Ihif6iEDZDdEcqS6SirOov4O
         fd9zO75opPow/k649+OUxoXnFxr0TZmpFX40ptZAEbRua7Uucf8kDHuRQOZXmRfza5z2
         UOhG0haN+d9oAmekn7KaCDlSzwf+as0uv0kJkjn0gy1MjWr83fCWnO34S4zHGvMsNrGh
         bgyg==
X-Forwarded-Encrypted: i=1; AJvYcCVL04XbpNj5wbthJnbCawF63N1baX2X299wnIhGv2n/eYnzwj9OiWTTccEQ/Ix1Xx6+X/aAcjWjdMNoOtz98g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwW/Y+KmsCuuqvmBrAwFxStEM9VzncDQOyFGw/9JtzROAFoum4M
	ZfokJyccRRWc5zE9So3QtaF0H2vVb9PABEjvKk7kgI5HFYqfSyTZuR59FU5fnSwTJs2QSyEY9JC
	uKMxYpmqBKksfvmk3XAOS8uGRJrHamh0=
X-Gm-Gg: AZuq6aLQfpA2uFY/M8U0nX0VUctpWC6cY4v4EcG21gQe9Gxtw/MRz4meZXql4cWfYOI
	cIVQ3CBGkjYMLMmdbl1ScLsl47iHcGgNGUpzke2I+f9+x1oInSbvVMTlnjN77h9/uqIePCxquZY
	xj1aNFuTkPToBgYK3s97/1qCpxEmx9IwoPx72DxO5oFxvZ9YrPtgCqGhTK2m/xNrrGz0lDlRYrw
	GzRPe8AD8X4xL1+UM0MXpo+GkGPXyCm6J60RhLpiLYqtDGJHbZf1o6lVkln+iAJbwpOkYlqMIzY
	oLXLgLwRp4i35g1YMESJKVr/dYUhKWd2w45mMoI/W7px8Bv0a4xVv/ZvxMVpECRYix1PI3GmCBP
	QlQu9SfpwWQc0hg==
X-Received: by 2002:a05:6214:29ec:b0:890:2504:5450 with SMTP id
 6a1803df08f44-89518339570mr10555056d6.19.1770064399203; Mon, 02 Feb 2026
 12:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131004327.18112-1-enelsonmoore@gmail.com> <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
In-Reply-To: <66924451-2b19-4a3b-ba99-16437dc79011@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 2 Feb 2026 12:33:08 -0800
X-Gm-Features: AZwV_Qg0cHrJ5V_p9yHhT8vkb6bWLIPXh8gwyXrWFaYVQlzEDDO-IwvtsniZn54
Message-ID: <CADkSEUjEYY=Wwyumv3Ft_T=xWLJY2hiy4uw_YMus=4o=61H+BQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove unnecessary module_init/exit functions
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-wireless@vger.kernel.org, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ping-Ke Shih <pkshih@realtek.com>, =?UTF-8?Q?Thomas_M=C3=BChlbacher?= <tmuehlbacher@posteo.net>, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31479-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: ADDE3D11F1
X-Rspamd-Action: no action

Hi, Andrew,

On Mon, Feb 2, 2026 at 12:29=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
> I could be missing it, but which module does not have an module_exit
> function?
None of them. That sentence was just to explain why other instances of
empty module_exit functions were not removed, in case someone else
tries to do that. I didn't realize module_exit was required to unload
the module at first, and other people might not either.

Ethan

