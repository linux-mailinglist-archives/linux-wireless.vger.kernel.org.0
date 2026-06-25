Return-Path: <linux-wireless+bounces-38100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /wpSO2U4PWpozQgAu9opvQ
	(envelope-from <linux-wireless+bounces-38100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:17:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9FD6C6815
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lvappkec;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38100-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38100-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6337A300F5CC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DF0347529;
	Thu, 25 Jun 2026 14:17:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C703195FC
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 14:17:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397022; cv=pass; b=LXTinZCn3oMLqk5NoyJL+SAK91DwyfTyy52nxor6m/jMKJSyDr5imNCdMojkLX/Q2Rfh+ZN3/wyYIn/Dnz1P5TgY2Px+AVLRQP5H8ExJAzkgiWKhaEKik23E5HuBtYsiBtWBNlLUW1zhjQbGv37RkRPBsKpLMkABxedxP+8p9UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397022; c=relaxed/simple;
	bh=AW47DFsonYpM0oyg8iwPfNaK52wbnQUJfNfAnPtXMNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pcu2B3KLqjrf9CA4Dgi3soAzBp46AsOxaeEZknzeTWbqc6zMQAlVmWZY8UytGreB5RSxGHSlVN5WuH2uJkV2nyC27N9ig0ZJua/izmN0LMIU17g0x5/6ww06Ip9qYhc3WSxTDl6CfHKJ7/XFzb/q7MSCuKpKSyuJpbj+G+g1WGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvappkec; arc=pass smtp.client-ip=74.125.82.195
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-30bc871ecdfso2784296eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 07:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782397021; cv=none;
        d=google.com; s=arc-20260327;
        b=XgK6xHlqFyRQsN8ZlOZFwU0fdZXbr9XYbCOQjS36dAbPbH6SdVl6H9wj4iqnypipQM
         vOwHnFlXx+TnLGjXkU5w3uogXw8A3h2nSDGYZsUbAKGLO4TWGzFzoUGNIf9I9Tv95ZIK
         btadqX7A0syVh67+5+o46NcDyPSpsgc6kObNpIaW0fIzF4m7rnm8bGkj0CDxnkErCLb8
         3/OoPVtC94ih1Hw6rQ6oFSnAF0eWrK4Eu6Q9r6ykWRF9PHagkxlW1K0K625q53+icBy2
         Y8BcaAXz+donxHbujgAHN5ItdnJnZyn2HdMJLjn5uwpO45Y1i3B4uMvtrrf4mBbRk/6/
         /mFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AW47DFsonYpM0oyg8iwPfNaK52wbnQUJfNfAnPtXMNs=;
        fh=8IAy5qup0a2EY8QRGpBSpKR+Jn4fWjWAV5x6xozgXOQ=;
        b=imP8r3Z3fWV7nRaLBxtcjKk1/jEOtn7hzdbI6VstKCd9/83FfXAQ4BRcIhikpw7KXA
         Eoc+U4V3OsW4KTXaf6Y3Ol/UDT1Z0IQl+j8qCLqsbcs63PH4xYYj55prW3550zNABiuq
         YY+61ZmEcCajnR1SeGtJ1OLLZ2tWVcpONEknXd5P0IbbiRtzUK4wySer4pKjC7Tf/aQk
         ze28uxCQtJKc67aNeo1vT4rPzDw7jD8FjiJ1wre3rixjj65t1KzAKtCbgrwK9emviw9/
         sW8nVJzu0V9ku/B0XhibrkeKzXcjV30foTZLyEOdkGqOdOnhaBB1sB+RpgvMjz5rHWMM
         6emg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782397021; x=1783001821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW47DFsonYpM0oyg8iwPfNaK52wbnQUJfNfAnPtXMNs=;
        b=lvappkec9rwZHgvCxt3//1W2k1/ei6ASGyib6EzsZaeWHGPxh7FjZdyO2xU1XCnas7
         PlvKQH7I3J9f0ujOGh+QeradlIyfXBE/Rho5ccsBlwEfKjIs2qMKxOxRV9F5OsmSfr2L
         Ycr7IN5sBo9UNMHqudj+CeZPuyjc5mruO2NaKdq9Z0L2wd4sr8wRBJQR6ljtRfikAJk9
         7+hCOVe99Ql4flLzN8TeFuTa898E/M9fF2VGKc2j5ct081aguFlRm0DaJEZ0Zw1XTFTP
         oLlqfOLZriFSurAbR+1JtoJyOl4YV4qi0+Rp77H4GPhKyIqFNP+F6fzCGgKOTMnzafdO
         W37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782397021; x=1783001821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AW47DFsonYpM0oyg8iwPfNaK52wbnQUJfNfAnPtXMNs=;
        b=b9tDzZQssM16b9ilGrs/BGC4EvU/ALjrKA41TpCAbO9nbcE5swen/7/4sDNspbHbGR
         rlITQOC5t+xv5IPalY2rc/ZMu9IpnKBhyQ2OohRlphA8VsBYAJ1M1SMaq9akE31bUP7r
         +HDQiNFAxBPkSMz6d0/Q/dWWfrQJWCibwj9SUyYWvrRALs1h0K1h8jPGSd57iN1nvgvG
         omkIR5Ei7BRsLPQnAc+ssOJPvJJ0MPArkNfk1YinDjm0oRB+jhRAbJrf2zFEtBdXWBHW
         4yi8cVzLAldoM3N+n+zbfjCpxabL/syp1d0SHl7EGyg3MrbLdtrBXD/N1ggScjok6whl
         Razg==
X-Gm-Message-State: AOJu0YztkZqnBYCw+DnbNiC6c6QqlcHovltd5dB7xLT0gi72YJYXwLT8
	e2Kic+PkbrXiopJ23KHEM0+nGBJtLOsxR7+QcGvnbFPXAcquFEwpSonn9TfyHoP+aBys7sT5U/0
	HpXqjqPJUon13olGowm34GkrXjHi/8Rg=
X-Gm-Gg: AfdE7cnK07cHwFTFjaQ2NJ8zvl9acTnL0arUdDIo6JFNRVu6ND1jR4D4GlvZrkUHEHO
	4ty76jWuJKj25CyFoQ5MBkGTEzJ2s8UVV5ZeRavZHmrs8lXERglgbXZngPAj/PpQCKbHqnZBo3B
	xjI2KP1eJ2PtHDqSLM2x6uEJvbnA4KtJNvuYj4Ie7GOBF/dUGzkf77/yGaBultmNus7eaoR3AUd
	zT9rCOY4tjeK1mOrUUSst72+ONc+65mQ2dKo4qRmFt+A4rae2pBAFIq5V+hoPoB9xsJhZwSTA==
X-Received: by 2002:a05:7300:3245:b0:30c:3da7:39b with SMTP id
 5a478bee46e88-30c84fb35bfmr3481932eec.30.1782397020847; Thu, 25 Jun 2026
 07:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624204938.15222-1-serhatkumral1@gmail.com> <d1db2391fe528c4e79b1afd9c80e49f44b948beb.camel@sipsolutions.net>
In-Reply-To: <d1db2391fe528c4e79b1afd9c80e49f44b948beb.camel@sipsolutions.net>
From: serhat <serhatkumral1@gmail.com>
Date: Thu, 25 Jun 2026 17:16:49 +0300
X-Gm-Features: AVVi8CfhBWNbIzVXpfW7LKPX2-bOIMF0CMsQLy7LWov7t38ilsdN1x9uQ5e8iqo
Message-ID: <CAMXN=BWNj6hR57rvh+1EZqMEzGvFCfrqb7PkMqBeO6HbPV5=GA@mail.gmail.com>
Subject: Re: [PATCH] wifi: cfg80211: replace BOOL_TO_STR macro with str_true_false()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38100-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[serhatkumral1@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serhatkumral1@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C9FD6C6815

Hi Johannes,

You are right. Replacing the macro breaks libtraceevent parsing in
trace-cmd, since it cannot evaluate the kernel function.

Please drop this patch. Thanks for catching this.

Best regards,
Serhat

Johannes Berg <johannes@sipsolutions.net>, 25 Haz 2026 Per, 14:22
tarihinde =C5=9Funu yazd=C4=B1:
>
> On Wed, 2026-06-24 at 23:49 +0300, Serhat Kumral wrote:
> > Remove the local BOOL_TO_STR macro and replace all its usages with
> > the kernel's str_true_false() helper from <linux/string_choices.h>.
> >
> > No functional change intended.
> >
>
> I believe this breaks trace-cmd reporting. Please check and resend
> indicating that you have.
>
> johannes

