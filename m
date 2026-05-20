Return-Path: <linux-wireless+bounces-36690-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ExXEcV/DWosyAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36690-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:32:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1C58AD34
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 11:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8617C30207C0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0B3C7DF0;
	Wed, 20 May 2026 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbNQ5TGo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CF3C5859
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269554; cv=pass; b=TMpDN9F63DEifVQr7UvVNOp8cGhKKoM0e+ND5o7aE8rIwYtjAazEuuINtr1QbjXywwtWdwHlMUciRZpmcXHzc2w1MV4uO0i/hX6cXYWomHpLpYdV/XeUHSCc9DxRnzaIszywV1J1C5yf7fZHa2f+Ec/x5e1UrL6VlHdzqEN+KmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269554; c=relaxed/simple;
	bh=T9ao8cUQVvg6n4ivFEhZHRUILcJAkmgexz/HSrqn5a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NjyvGHz05zBT8ejfi2X/6YGXbjq8bn6elqVKyipaBuetT08+4rKLP5w3IAuyD6hpjTfRYKB8zpyrnjKkIwBxJR63lDpjQ/cPq/1hIrevYF6p5BZCNa+rI7mXrdQQ+uxgzcPg0FF0ZLBbXblVZganQ6niXxcFxjFKI3or0WJTlM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbNQ5TGo; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-394413a63d3so38911221fa.1
        for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 02:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779269541; cv=none;
        d=google.com; s=arc-20240605;
        b=XBa2T5h1RUeN24TXAgbxqjxjCa7x3702tcranpoBmsXlvkmUhR6AuAQrivyYtIkA72
         YyZ17O+RHjH2J8H+Axa2EL2r2sYkIdWRb65xPotQ3lCxEHC0wyf4IdeLaTArC5wfMtjN
         onZomYdLOpquB48bRxznisxVBv6YI+KmhcRTOTexXq2KjKYFnYgJEsFz781MgE1yiMJY
         FXu5F8y4BlX9INATkuCSpdJJHtcyWieXQ7Mc9PCfAxxY859gZUoNT1314B1qnCcQLk2K
         Uu8QGgxLg1b2eVnm7Y2WQ35BM7uQVfNfzFrVzGRnAx6nhWX/m4Zuqkz88solli9GPKf3
         1mRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=T9ao8cUQVvg6n4ivFEhZHRUILcJAkmgexz/HSrqn5a0=;
        fh=fY+ClKWvxu8PR26t2ryTvKGVqzCs5LX+VkZyjdOQ7LM=;
        b=KtRmNKYjyLzTNprSpA9NwcHJB8w2VENQLmwxsZoks4Raq3pKwQ/kUopgEORbJyHCyZ
         VZeoXrU0sznJPiJbsfxRIeivBv7Jkmw2ALyn6Yk9Xh9L3ag69H1uc7BFD1uAUf9UnAls
         ESfWCHNwZKulfOd00sG6Kk5CxNs1Z/I9bwcmeA0+Axf2k2bSGKxODA0938TPKtoMoeNq
         pk1HjO9dfumH54k2RM9FHL053SQ6ysWJR7YDZJYsUGwPGOr5ZVO4eA7Ww0ufv6oHvjjM
         dhtkilJhPi4EhTRZsWgaI+gIBKOPlfUthv3YWdeYwxrcKZNZDqzLOBkxo/AbPoQwx2Jc
         T1Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779269541; x=1779874341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T9ao8cUQVvg6n4ivFEhZHRUILcJAkmgexz/HSrqn5a0=;
        b=IbNQ5TGoesfCfa6SUEK8w8ohiDVYWlxbO8bmu/AIcTD+XqdVUV1wCGhBVc+q3c4Nlm
         ExdLPVpWW4r8m6OBB+3EYFpF4cH6zMCF5QgcHNM9DVz0yph1ccRpgd9FX/jln4uvqdqh
         njXVqXdMIi0gxoV3SIYraIBXy0aT/J4HZJRBZvZj+f7hnqwresl/kbnXpMTYYOgluHY8
         6vT28eT2Ivke2u82MgJgSLss7prxjf5uf/HrCPmp5Efswk5R6OJUoQ2UjzjRxWIGVJ7o
         QPlSL2t2yFwe1Q7aLe+oS/9DxeJ4tvoTeu/RMVHGHdiZwxKJccRWeE84BBzdCXROzSrr
         GeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779269541; x=1779874341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9ao8cUQVvg6n4ivFEhZHRUILcJAkmgexz/HSrqn5a0=;
        b=gzBcuRgm4tA84+NahRh0rrF99wOe6n0f/uiZ3YrnIu/yAnE/0HllNa3Osiy+sZd/s5
         G6ZVRjj4cf5vK0UGo+GN5fZIbrJD9j4RgQ5lvrJC37dq1TsSksLtFlQt/Bp0H8M50cXL
         DIiGUuk1SnZdFHhFhz1zVuxYnoDAUlzZ4zjwi9s1Ceibl25gZC08R71DDLmyqC0RhliI
         TZqurvBVcXuz587gRPuXXjpzV0b4Mp8aVyp7UzJEfBoXM99bcTL/bewIIb6sjVAtkiRl
         YsKU4iKVXzOr+N3bmBJcFi7QSnBKYjRJUd1T15wupkovyutisNgM78OiV0L9ouQ819e5
         WybA==
X-Gm-Message-State: AOJu0Ywqa/C1xd0IA9Y7iRGtyrWqY8p9n1IDBiZYIQK9G+zoYrCEynpT
	vIDFgR1ZpPytuT+JHWy9Cqhn4FtS8n9KqD5MIvJ17Dbbyn5onzLXKYQrEqo/PjD3hEgubeazArv
	Wlx1EFcn39eOpf9ebuqK8LXAzmWMkTI2H6mcx
X-Gm-Gg: Acq92OHGWCFwExaSfYSsdtrOB4VB14Xx7dXutD5pcFQ9NkwJ7dI90KqFGsIV+KtdYlM
	lYPVRcLu/HPYv9cMCqkgTHJOLblqp4Y/ojrqjZcvJYX0N5X0Ki229aqmPC3N/E+A463RscCdtUg
	0vUbn/JCRjLLhfDb0KSvFvqCHeRdaT3eKqpTVPxruakPitCH4C5NNX1/zQV7DM/P1ugz6+9DfaG
	jsYAMs2k61vikQplNGt6rm3UL5hgdomM4W2RmwmGo3bdUXvPnWgESijWu+K25rOkr26lGMPUP23
	ZEPpgznwfCdOIxo9xfg=
X-Received: by 2002:a2e:a992:0:b0:38e:27f6:41e2 with SMTP id
 38308e7fff4ca-39561d4be99mr70760891fa.18.1779269541185; Wed, 20 May 2026
 02:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1779269054-14963-mlmmj-1e4bac1a@vger.kernel.org>
In-Reply-To: <1779269054-14963-mlmmj-1e4bac1a@vger.kernel.org>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 20 May 2026 11:31:44 +0200
X-Gm-Features: AVHnY4IIdAZQ5EmE4qT3XY08K70QcZ1YzXYJF-LwLNiNKhpR45cmC159_Qhzr3w
Message-ID: <CA+icZUVmdgL1A6mpFxMEtMtikwbkH5qWWyuEn-JOeSU80Q-mvA@mail.gmail.com>
Subject: Fwd: Unable to unsubscribe from linux-wireless@vger.kernel.org
To: postmaster@kernel.org
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36690-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sedatdilek@gmail.com,linux-wireless@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	HAS_REPLYTO(0.00)[sedat.dilek@gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 67A1C58AD34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Postmaster,

can you help me with the unsubscription?

I sent an email to:

linux-wireless+unsubscribe@vger.kernel.org

And get the below answer.

Best thanks and Best regards,
-Sedat-

---------- Forwarded message ---------
From: <linux-wireless+help@vger.kernel.org>
Date: Wed, May 20, 2026 at 11:26=E2=80=AFAM
Subject: Unable to unsubscribe from linux-wireless@vger.kernel.org
To: <sedat.dilek@gmail.com>


Greetings!

This is the mlmmj program managing the <linux-wireless@vger.kernel.org>
mailing list.

You were unable to be unsubscribed from the list because you are not
subscribed.

If you are receiving messages, perhaps a different email address is
subscribed. To find out which address you are subscribed with, refer to the
message welcoming you to the list, or look at the envelope "Return-Path"
header of a message you receive from the list.

