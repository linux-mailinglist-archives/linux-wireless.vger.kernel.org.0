Return-Path: <linux-wireless+bounces-34884-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAy2D+vH4GnjlwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34884-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:28:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA340D63E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 13:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7ADA30953D6
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 11:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC83A7582;
	Thu, 16 Apr 2026 11:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDLEgrju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E93A7844
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 11:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338897; cv=pass; b=remkKJbNOyhWUhySosrLYstrg06JzEBGKsSh2bKJxJ5hDawqT3BOeHuyByGW9fHNJnsanjgWQ0kYhfK9xKAMH6cxFSVIfad1uajonFpU3vQxdlnstBxVl3qCBTLxXxqDcfa0ddyE2mOBJJmTkpp90Wnz4rlOyF+LixbAkjtkMPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338897; c=relaxed/simple;
	bh=YHHAfX8cmV9rExuKRg1S+fFZ986L82rojpaEkfEi3D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEE6Vw2DpW45ZcIpQSKRchgP5KK7WJlasQLlzCoY6DC5lY7Oq4mz7IRdVJf01s/Rj9sGR9vZ2mO4aiyu1dd+wwrnGVRJMaCH2c12wwjH4rE6L56ax9MrPLFHATo4vreb1ZVWAIrtOcVt6riMyIz3WeVYpUAgqzyfES9X+JTmlhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDLEgrju; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2503753efso69580705ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 04:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776338894; cv=none;
        d=google.com; s=arc-20240605;
        b=T+Ws29X4q2/4uwQN2tdSfHbmX/XNx+iw8KQSJVoXTXQwlp/unO2LgqikvOK6tvanWL
         mwNNr0BLtpJOdJJQhWAnKh3YJ8C+E4eLAiTAZJ1vi3qDwJ6NHJhaJz3zQEyUgkQFdxnJ
         LZ6NLDIB59//JcIrmVJEuXbzH+v/aYrmmEgCBiDTRdU1/gJxZmItGySn76JZ8qE8vEgy
         C84A1KDEBEwl493sRV6LcU+YpScPqh2EnGAY5n9/041D+Bz4feAZCTfvlplIw5IlFw0F
         wnGrGV8SWhV8bS03BkI9tNRxHSz3NTjWvxL1l4LIcw65iszzu83GX6V+0U1KWvnIGntj
         W2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TPo11AHrBsOSxlNvFHVp7gmFFasCvxttVzXJYOmT1Fo=;
        fh=tIJ14iY1eHyjAjI5Ru33VXW9C1oUgebVEhtgg1XyvQc=;
        b=kOz8sI7pmwS+kX9FcuLJk1KeggckkGo4yqVHr5+FV86LlsUE4qCI9HCN3nG1m7tzLW
         nIhnq5I5dRRHOm+TuOtSCV2W06UmJwvAXosZYeDZKC9kiGi2UeKmDkIgwd8ftIBZmasz
         r8EEulKx2GVKa8kw0vSA92xUuONbBuCFuFtHhKytoDQyu8G2bc+mlg4u2311H2+8NJTz
         lM9IOtehU0Ow0N5n3kOnS5xuc21/Rgp8J/NWet+Y/rUcjpNcO5XlQ205wZGMeOp+VdEl
         IbR6KcXRXH7/pUNrZo8UHlS6YG72GuFrpLKInhkYS4EcnI498CTkCNT8M0P8fCY/2Ils
         N+Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776338894; x=1776943694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPo11AHrBsOSxlNvFHVp7gmFFasCvxttVzXJYOmT1Fo=;
        b=RDLEgrjuu7NVcG+c40QkAdnZs30E9ezZxowYDHGj+cXNCxmwZ6K8OnzWn7XDQjauGF
         eZggNbhtfaC9jzKiNUNieDM4m8EgJk5qXI0YVVwGMUUcPRw8MencuePUhjR3dbCbE5Kh
         yqzcbkgFJtS5e8INLTwdWv0f1HynQE3o7ou3JUNIiCGDcSsyZtl7BOV8Mpk+/c9yLtS7
         rUU0aQyfjVXkmBPVWU/p1UBoQ2lk+W2ckMnqsmK+EWoyObxfL5kBXDNnT5TQ+AwJf7bt
         M1iYCsVAEEeAvtTRxJMqaQpreiTYDzln9rdO2WT+7bNeG3EdlfvJNh17gsbl0ndlfkgy
         PMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776338894; x=1776943694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TPo11AHrBsOSxlNvFHVp7gmFFasCvxttVzXJYOmT1Fo=;
        b=beYuOQcgQgnSrm8OkabeD3iEhrpfpsq9TxASLChhk+2OdoAtkk17abzBceRGMW5CFF
         20bEIiekIrktBz+2wvoSQDDcz/0YPVpcH/YIQwKUMLfT+xVXmo2QQcQU3IjYBRe4KKTb
         5L3oE6WY2ihsLx5mTWTV8LOWTB7Grqc9hWjkZt8kFaouHqI8entdsC0HjGueYz5aWize
         PYXlO6E+CQxn29DKA6zaXKrwpjE/UhTwIMsrlryevHj2Ko0uZv1Kw1AvlxaueC59hteB
         R5zU4XLI2jqOdGQoUJXgWXerce1ipTjwk2npK5SdkuZcalYX3WuxObKoIAYiUSzUkZZf
         UaCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NkBdXwOypG7mO8uuW4XJTG4I+KdWKHO+6yQEWZ0Ki0VX4vvIsuWzarqZnucC5cWCzIONZXoqFZl6wHiqnVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yk+BTHYTIdQDuiN5abjNSN2Lu3T7BjqTrt2yeS4eXYHyxKfK
	cvp7Vguu8z6rO/pRr/qrNUsU/RQeV32WOZ2WCI/7NpoihLbo4L9FmU9VNDU/8uUJmQmX/5o+9n/
	jihi33Ni0CPCWNecOuSvtHrxyAnawFHn9UPWUejE=
X-Gm-Gg: AeBDievyzRyLif7+xSjlibM5XJhpFDE9XrMzTt0pWksILP52HFnxsv84uNTdheZCkza
	/e249DUFtTCdSP7ZdH4AzUZJ1J/j8pV1jWsn0to9xOeDtMmACUw7SHk5PtNamFpgzJYIbFla3ca
	tOuHR7zNwpXuwUhqNsNVRdeji+650/RkuSSv61P+wIOQF2nouaKifnkCMU1Pcsr7zJyFnkhGORm
	tK48YwV6IbZXaFKA4bUKdA9BdoGV59sO4BbeacV55xnZPyoJfZvNlLGKNXsoFVCJ/osc8HBy+9i
	upNTnWGgmCGtN5As95XyXA==
X-Received: by 2002:a17:902:8211:b0:2b2:d126:4e77 with SMTP id
 d9443c01a7336-2b2d5975bdfmr182408115ad.11.1776338894469; Thu, 16 Apr 2026
 04:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACM6vn7QGKQcR5Rs=wmzNA-SgMDZX4Hw=UiPQHfYkWgLURcbAA@mail.gmail.com>
 <b1a7678d-8e87-444e-b38a-bb7aedcd4f30@eskapa.be> <CACM6vn6UXfSXw2WpYvzF+ODPGHw-LtsBMgtvc6n7s9iF9eaS6Q@mail.gmail.com>
 <ee6a0a4e735b3e97fbe96a25d2af59ee0f663fc9.camel@sipsolutions.net>
In-Reply-To: <ee6a0a4e735b3e97fbe96a25d2af59ee0f663fc9.camel@sipsolutions.net>
From: Benson Bear <benson.bear@gmail.com>
Date: Thu, 16 Apr 2026 07:28:02 -0400
X-Gm-Features: AQROBzBqLbNG8yMSegrbRAbdz3_hV2SbhjOS_9NmuFx2kABmda3E8nCSRnbY5C0
Message-ID: <CACM6vn57J4K1PDpW5gY1OauE8p=j7xZGUQFruuVZ+2rH3tJHFA@mail.gmail.com>
Subject: Re: Wi-Fi speeds degrade from 600Mps to 30Mps while using WPA2
 security, but not on open network, shortly after ISP firmware upgrade.
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pablo MARTIN-GOMEZ <pablomg@eskapa.be>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34884-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bensonbear@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: A2EA340D63E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 7:09=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:

> I think what you're referring to here might be this?

> https://lore.kernel.org/linux-wireless/99Mv9QEceyPrQhSP52MtAVmz0_kWJmzqot=
JjD9YW6LGLqk-AZloAueUyHCURilFkuqOh6Ecv8i2KKdSE1ujP3AnbU5QEouVisT1w_V3xdfc=
=3D@r26.me/

Absolutely yes that is the issue, but the patch I found was different.

As far as I can tell that patch did not determine any specific
conditions under which the check could be bypassed, and this
one does.   And, I assume, it does so correctly?

 So the "correct" way forward that I was asking about has already
been found?  Excellent.

I will apply this patch myself and determine that it does the
job for me just as the other one did.

Here by the way is the one I used, from out in the wild:

https://github.com/WoodyWoodster/mac80211-mcs-patch

So I had two issues with the Rogers XB7 firmware.  They
seem now to be unrelated?   I think plausibly mac80211
could be said to have a bug in it, on the BCS issue, but
what about the issue I originally asked about?

