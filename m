Return-Path: <linux-wireless+bounces-35183-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJdNEgS/52l6AQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35183-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 20:16:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A98FD43E8A6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 20:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EDF0300B10A
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A953BED02;
	Tue, 21 Apr 2026 18:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOvlH564"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD413BD64B
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795297; cv=pass; b=PTRXRWFkbMLNudH2uz5of63XuO4m4s8x4bl5DmCJK+ilDTyOf9nPUTufVQVgRsp6npIzTDWdlSH4F/aWY5Nxe5S7h2bmr5bpKyJMvU3EgdrNrI0tQr+Nuep312M9/qE1R+v+V8yetWZd4JXm/6ir5/eWjp+PH3TKsS0kkZYK20E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795297; c=relaxed/simple;
	bh=V9LBOyY4yP9MA7+jTzqrzB5ZfmbtnAUDaYhz3nch+e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvArLGGTUy+spApeWi64vZZPTQgF4JqL6IQLNnbCo7lt3ndUcBzf0wKiphuqctxK+/TXC0VWEsJTFWNhOtEaTQMjwdamFn/IX6UcZaqZWV2A3qcuibz+qIlf57qEwyuw2nd+AnCiP+4KKEE3H10+Foto2AhdCYJgWLrNy3b00RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOvlH564; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6540fe6a8e1so3577332d50.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 11:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776795295; cv=none;
        d=google.com; s=arc-20240605;
        b=PTDJH6E9Pvx/eiJCujDJG5a9oUGrfqsE9V7ZQ/Lr2aDr4150grLKtQeDPWlPup5Rq7
         LG9XhZJLCHYD8HBYD/GkoPuqRIs3xwxdmDsSWvzrJ5ioDq5TFgD6y8EPB5AGTpKlJ2CI
         D8M6kbMwOl32FUfoYOvHXdOyQZG9qxBnWt/d6N2xCGxXEOKC52qDTw5lBSEk5m1wdUUi
         lUa85UDvv5HSnvArPFQLFFWDoRRkV46/izsO6SMuzK90otfaitWMmgeupv/am4O3z9hV
         AxcyIic1MYPMqG3X733ZZtBScttKAubdEB7G5YUbLhYNvE+CWpjWFUQ5vuKYUJhQnehM
         KylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BSdZOdpXD3sE0p2GAOVnSc/e3GEqKyNowrllvhJL3vs=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=JApee6KUWT0dpPK+AXhQh58We2JVg5dox3wJRdJy4f0MQKSr7CPhlYUA0suNesDWEN
         Yf2y5Ui+C9abu5Sdc+LQ+KPDN2V/Q6QFKDcZ7rXCDFHwx79tDirc8cupvLAl61jKApja
         EWgeoa3jIpSfJQODhN6CGFYB3q70yTl+tkjYG3thOJxwrbqmSsyXadt2uucJ99MY9AnV
         EyRgPa2kDWIDW6NVAAHRLIh2Wfgj1ldDPtzmeYmL1z+/kA+lFCHusfEhvqkKTb3/1N4l
         3r79fXoj6hkkx5Qfr+fNqF+1eNUDqX3E/PA/FNndGghQ9ofbIpLeUjCEy+szojeYp1qH
         D3xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795295; x=1777400095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSdZOdpXD3sE0p2GAOVnSc/e3GEqKyNowrllvhJL3vs=;
        b=FOvlH564bgkxUKAijYeto2fDMNwY6GFRaf5huKlzL3Bzk1Cv27vHlFxm/vp2tgpoyD
         LM3a/5DdnGHxlmg5gGKERKhSfSqVd9eF+heVMSKcgYt0wTT7EjbDPYW+xTfq6uVb5Utg
         dbtKyX6uuNPWzAg/wwcHQzIUczk0rAuhWH8ZBeUZzH9T/KhrAVGU5v9H7zgMCq5+GOQZ
         uchmcwypRxegmqCUJjCaFnVkM/ur32NCcy8ZUBNjyhaMVrPTpfxYrvIY1TZindmRFqpL
         cSEOuSPzWr57CTUeJ5k6i3n10Kddq1widvnAb75S1zhbiYShIHxVzLUQ5PJau3HSvoyW
         7zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795295; x=1777400095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSdZOdpXD3sE0p2GAOVnSc/e3GEqKyNowrllvhJL3vs=;
        b=a+OrC+4eHdgjZenLM/NLet5tB/rvgkg3DUTDwU2l8nLePkzpeBKtRG6cyLQBLXTiHf
         XCEo7ELf4w6IlCXL9uT0Sg1iRaNSVeFz+um+MCGuH3MhBTE+xrqIBa1gYPhfk2/NkAmJ
         yc9ivn9KL0NTuo3FdIR8uAYmZHEC3yZUWxqcXRJQwJelB4oJsIdsnVh86r09gqc/g47G
         bS9Vvha6plJieuTPl1ShrCGuBllUVv+7vA5m/5Ioq4H3TvAyKdNpa/rn+MGcgWxvKFZY
         lw6yBa80Dz7zJ6ej48lZxzUQvI+Qh1tU5+N99y0tWIH80wfQ1oUqQ5tgh7jo89k9ecwp
         GlEw==
X-Gm-Message-State: AOJu0YyjDB3CGxVKmSqMZ5hAmzoAr7IXoNLrrhPP8+ZAPKP5QaDBgPgW
	0r5pqQrmcY2Eev+TinPVneKfupxbR8UkCn/rvKgDKshpZUevHl+bckd939VjlcUnjPEpaDgoRO5
	NzkiuhvhdIuMj//sjG5tvnNImLlW19Kc=
X-Gm-Gg: AeBDievRnY8KK3bXKD3B7b/uJfaMsyaEI6s7bUAmQjyypznBYHq8Ghl+66kz5fJD0H9
	VbfOIm/0YVusrPxPCr3zPsZVWJeadOD6gpjOFXwKBxDVSsXk7F8uEHD2W3LCwZ+cUttDr1ngdRQ
	BIen4FvAwm3xQrKXHsFUCZxdfCwtkgXRNiVMNWBKUC1Aqh0HUcXa18NPgmV5HF5XZbUBX0IymBe
	72XjftENZoM27IC/9QuiUqFaLzUfW8VOHDxTO4yPpPm+51a2Cb09P223WOLzPpZKuFxSH+JBnQP
	6akMkx6AV0dkh8ueFA42yllHXP2eTCdlRdJ6xWuRmBCLRuLIxTU=
X-Received: by 2002:a53:c057:0:20b0:651:c8a5:fdd0 with SMTP id
 956f58d0204a3-65310a6bd93mr13963147d50.46.1776795295134; Tue, 21 Apr 2026
 11:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADUzMVb+JNEcpizCBCho+qCMPG1fzNfJ10Nh78=N7-vvao8Ogw@mail.gmail.com>
 <6e78e7a7e629391ff58d53aecf1b033f205ff21e.camel@sipsolutions.net>
In-Reply-To: <6e78e7a7e629391ff58d53aecf1b033f205ff21e.camel@sipsolutions.net>
From: Ioannis Barkas <jnyb.de@gmail.com>
Date: Tue, 21 Apr 2026 21:14:44 +0300
X-Gm-Features: AQROBzAB6gCAQsqBkF8gFZ_dbgYBVuosYerzr4g8-IhyVNfnlLsD3l1dri6hObA
Message-ID: <CADUzMVa0z2GKARUeSpJEH7fpWd3PvpT1mzCp0Af39enLXsec7w@mail.gmail.com>
Subject: Re: Garfield Peak 4 trouble on TigerLake
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35183-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jnybde@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A98FD43E8A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 at 15:59, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Sun, 2026-04-19 at 13:28 +0300, Ioannis Barkas wrote:
> >
> > [    4.463035] iwlwifi 0000:00:14.3: iwlwifi-QuZ-a0-gf4-a0-77 is required
> >
> > Not sure if this is a valid file but I could not locate it. Is this
> > expected? Also Bluetooth goes nuts.
>
> This isn't (and never was) a supported combination. Whatever the
> physical, scheduling or other reasons, your platform there (TigerLake,
> released in Q3 2020) is simply not meant to use the CRF (GF4, released
> in Q4 2021) you put in, and this won't ever work. Sorry.
>
> johannes

Thank for your feedback, no worries I have AX210 as well. I just had a
boot crash/hang at Debian running 6.17 with AX210 so I tested the
AX411 card I have.

Best regards,
Ioannis

