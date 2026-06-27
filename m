Return-Path: <linux-wireless+bounces-38199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a8Y1IBupP2p5WAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 12:42:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2626D1C69
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 12:42:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qr/7cipu";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38199-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38199-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 475C230091FA
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jun 2026 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0135AC12;
	Sat, 27 Jun 2026 10:42:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B83A7194
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 10:42:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782556948; cv=pass; b=gOjZzTIkYsg8F7qtorfY1cx8gxbLZXCD9U0pKbTA8HjK2ytGo3yhsFkHsSqu0HBsR/0NgNfq+cB5weiux9nIqglnSeI4cs+E5upS1kbkSPrtLSjh4E2V1Rp/IB+51HZ4DLlBK/L7pJkFMywiIlz60rQsHq34Rk9hT2ELyYoGOlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782556948; c=relaxed/simple;
	bh=yiPkMTj9yA2sXk/vwvHof63/CCEubbjonxxn7PtyAb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPJVL/LQ9f+TZcCbJ0WNW37nE15m0nyKkskI8jouRtsKShcOkVWK/8dLg5lFwAF1oo5wPUhz4IZehhfSEUWyx9xupORaILmnNASfOB1j2t8QJOOGLN8SAkOq7azq57IvgM6KLm+DRWPNgbb9kUKDZhAp/gVvkYxRCNgJMsiIS1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qr/7cipu; arc=pass smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51a92a5aacaso6004071cf.2
        for <linux-wireless@vger.kernel.org>; Sat, 27 Jun 2026 03:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782556946; cv=none;
        d=google.com; s=arc-20260327;
        b=dSRH0vb1PPrDpHdzqA4bolg6OeLn9Le4bBlgH5/dOTxJ9KgRbp0yPRrnQnTCMa3pWr
         e12C46m+rkJ+I9sSdyb2xKHG1urM1s6OiekXGB092E/8ePD5P840yZ7quPKpChvdVPLq
         GvfNFNMbTkkcG/bpN9VLBynuDbmN58QT/zWc6ZxpBmMCo18p47nZ+cMwi4P+qVhZA+9H
         jsabIsHczqjhXciJ5Tlw/v5mxzw0VcWB8EpB6zcgm+W0Z1Jh6Wd5OktfCTkiNj5Kmtty
         JYC9jKt29sevOp19zNYW6xwHWfAdYVVtRc0M5betmIq7J/locNkdB6xe2hiQg4sGSIFB
         fv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yiPkMTj9yA2sXk/vwvHof63/CCEubbjonxxn7PtyAb0=;
        fh=aGRW5/ukBDYN6qwyta3Qs6nnKGVqiAW7ZuRUO1+GVNA=;
        b=Y1JmKo5I4imCEjk+BhiYubZ6qHiguJLZVTX8aiJCd2SN/xajjoSWSTWHTiSvkahyrN
         eSn/9hsx7BQN/u1ImkbEGJnTU/48vq5uB5EQSgHZC66J+rPkdIH9a/8VQ5tTlauNUkq4
         J/Kd/Uac83CdapqOfs7WERd1YLWtaVeGV8oI8IZ6ytZIJO+3oa2oNj6mCxsLVyE+zs5n
         sIc0kMkOZ7ZBbjf5Z7BsdKpExSFNuBsTE8JrMH/rVBMLVFghDwatZF4XzQ5MWGJSHUhN
         yH1lrL/MW0Wg/eYLWuFaRzSe4E7rMFB4VOcNwtt+TqSxqn4S+eI8jR14MRUQ7BhpBCYL
         6SBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782556946; x=1783161746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiPkMTj9yA2sXk/vwvHof63/CCEubbjonxxn7PtyAb0=;
        b=qr/7cipuJ+vdHr1C9cd2wPueo7VVf5iMepMvkTg5REDa7him57FWENlNAOB/mcIQpp
         dTiXBbYxU/1sDLC1HvpXx0xcIUUZYEMEK/2jLt23qp6pYFMiRBwMYPklfE87cpd1PRfZ
         j8LrYFnlq0K73AZ6b9682vxcDKQTOdQDQBbr8o4fY2MRs10m+eAn167XFT11yxwGoV6T
         wWlnwW00f/HlSIaajsvko99KgQJGJYXRTbrEtDRWcHXwQTC6q3RsbHjnu2zHHCfC9odl
         sNVnyzwspIxKqNCb3OASCw6WhAWkLYgwXX6AHqhmPxB6jhcD7TaFFGcSBlSPGB4hQXSe
         1qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782556946; x=1783161746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yiPkMTj9yA2sXk/vwvHof63/CCEubbjonxxn7PtyAb0=;
        b=kea+gWyItK/SD+PO9eQPKdKmTjefqdEKz4GPQZSUH5Fl0GotAm0Fc1XDpNCZG/Z0lh
         rEzfGJewfw5WDef0L4dzO/Kl9Vk9J/lz0dhDq8k5jF1kyD4AqWY+UJqRoV2AcS9ZNxZA
         1QXjH2EG0Tlmp+FpUpmnv8ST7/R/j1Mrt0YM2ZiPKLR8cEAt87mS/2bDFraEjlTCMLIa
         bA3OVbwa1xseSkThN8GhT/h++VONXe09klKpzjyWOxvSoHJ/mETfzotaXaAVM3eqrnYn
         AILGZSiqlCM9gwyZGNYBW7xH5TppQJQLno9KL+7doKXmENWckzohW1DEDJv2/xqHlw+3
         VkLw==
X-Gm-Message-State: AOJu0Yyo9zjrdAFkIiGooayinLMd3jY83S/0Qsf/uMTvUOlle0vW6Sn+
	zfS/K+ZnBvUKPG+VLRtKLBauhHfFdDW/w8ijTGuu0tzdMhKDG287XN3vJr6iEzMj054PYWIgDm5
	jY+0nZ0CtxSQWNj2Uv9e3Ev0gURoMButZyE8=
X-Gm-Gg: AfdE7ckeyzLip4gThRtuEgG14JssofYCwD3vQ5rI4LJ2DdZBCo53umc6OMt59Yb+OdW
	hhfh1QjhnDm2NqqNobhrYZ7J4jGJsf+OZ9+FV8be1cQPdtWi4QBc9IgEKmVUadC3G7T57Tm7RWb
	SrMhKIXixKaKdVjvI5LJ8hOJOAzfLuqiS+jwbKH9sRr6NJ5SD01ZkLnp2Z8NKqSJN4QsjwER4cm
	zAFWWXXMw6q48C3RtuEhBijk8cKGvVKUyTJbvdA0cAgmMjYF4E7YyS6Ql6JuxVlefx7eSAOWbs2
	6Mwws5vuYTwcjs2QphRxugOU
X-Received: by 2002:a05:622a:5d0:b0:51b:1f2:f38d with SMTP id
 d75a77b69052e-51b01f2f4d7mr23795521cf.28.1782556946532; Sat, 27 Jun 2026
 03:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMe9DRPx8KTmSVPmb44VVE+Ebu_8isVncWFfwEHvSk=DLh8i9A@mail.gmail.com>
In-Reply-To: <CAMe9DRPx8KTmSVPmb44VVE+Ebu_8isVncWFfwEHvSk=DLh8i9A@mail.gmail.com>
From: Nick <morrownr@gmail.com>
Date: Sat, 27 Jun 2026 05:41:59 -0500
X-Gm-Features: AVVi8Cdho-EIdC_mkIFPTJwrx4j6CcmBDiA8KhFBvUfbbO9ldM-Zv1OGNwFPlPQ
Message-ID: <CAFktD2fMi-VEkTofOVq-pY+-VHbZ0GUhFjoOtDG3iF1UyqHCCw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5Bmt76=5D_MT6639_=28device_0x7927=29_lacks_mainline_sup?=
	=?UTF-8?Q?port_in_kernel_7=2E0_=E2=80=94_out=2Dof=2Dtree_patches_required?=
To: =?UTF-8?Q?Rados=C5=82aw_Poprawski?= <rj.poprawski@gmail.com>
Cc: linux-wireless@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rj.poprawski@gmail.com,m:linux-wireless@vger.kernel.org,m:lorenzo@kernel.org,m:nbd@nbd.name,m:rjpoprawski@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-38199-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[morrownr@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F2626D1C69

On Sat, Jun 27, 2026 at 3:07=E2=80=AFAM Rados=C5=82aw Poprawski
<rj.poprawski@gmail.com> wrote:
>
> I'm reporting a missing mainline kernel support issue for the MediaTek MT=
6639 chip (marketed as MT7927/Wi-Fi 7), which requires out-of-tree DKMS pat=
ches to function on Linux kernel 7.0.

Hello Radoslaw,

You might want to go to the following repo:

https://github.com/morrownr/mt76

We recently set this repo up to help with various situations.
Hopefully it helps you,

Nick

