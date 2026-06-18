Return-Path: <linux-wireless+bounces-37902-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Si4eNYlENGqnTQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37902-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 21:18:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF26A2540
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 21:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=A16mBf4C;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37902-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37902-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE12C300E165
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2026 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA630E827;
	Thu, 18 Jun 2026 19:18:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60EC2F7EE2
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 19:18:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810310; cv=none; b=skwqeyTVYw/SsWVB93oBxFR4KlT39HGMjosRNizp6ePe5xX9VD9peDi4iw3GRFbnXuGZhSDhlfsjhGVIZ7NvWrpDGVOJSvzdELIxBDhIFM2+NZ1i5aRAPaaNbS0CvL8g6LkbXMPS/iccvJGZbCLnmIl7d7scRDzq9Ohh6hrCwo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810310; c=relaxed/simple;
	bh=P9S/ro0jLovo+hTyzTjQmckWVQ5guKeABPZquxPYww4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rdsmsSuP3msYm006kDqWS1hYlQbIBY/3KIukvCz+u33PaIfLfS3X6lPh/VPhbxm2uKOYwXziM08e38l8zsXAWcS/wkch4PMXesvSQ5uxNAksAUh87WjDVBPWYSRzHVhaJZWhbVT8Jro6e5hqNfTbqn4DsW/7vmEQDaEiSjkMk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A16mBf4C; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842848fd613so1258901b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jun 2026 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810309; x=1782415109; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43N4w0QFi8owa3jf2IaG5CDpaZZD0IGgzUSSpl41OlI=;
        b=A16mBf4CyhrLRAHKZBidFABoXEF9x1T5eoV2D7GVw/Gi70BFGe03Rv/2N4Eui0KW/T
         eVUl2BtyHjrh/E5xzQq4R/QcJncEfmq7Db52M8X9zwVqnZAxCDAStoHSb+XbEa0QQHX7
         2H6cZFztkJBWyFdPDBSnP+R95Cm1nuSpBbVY/IqnSNIjPYvdkvHDBoIEgi/76AooIA9V
         tau2Po+1N+25Pe/cLaDSKIbgyZVzqEIZ6wYQpYtEOoZwKi8pQ0OsDb1pZORMNweoGkfJ
         xIz/kldYe0kJjOb6IXDeqEhDiPrOq1T0bH4zlox3j12SUp46SsasilZNmkj7cD0ghM+0
         wIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810309; x=1782415109;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43N4w0QFi8owa3jf2IaG5CDpaZZD0IGgzUSSpl41OlI=;
        b=AAodso9XLNqYqRhx9WbESDTiUEgnBJMqAdaijMQ9aGqqur1TGuk9Rfzi40qXSHNac9
         ev+KH7MZ2kXBnyXOfJIAssbN5cWbz4hafAp3MtqZweq8ASe13umTfZn4qq/bsfPpRpit
         0xBS2phUfb2yA7fYmT4/fAw936a83iJAp+g1erqTrd9EHuWxHBRUK/csgF/+Gy6bwPZd
         Kd2age/BQOVMWKhEZ9HvL/KdrezOBa1o5RtsTOSaOFyGegpmbBageN1j+QcZ9p+DngbO
         qtri46ACiAqJynk6klYZh8R/GhDukm+Av16zQfdYfdI3PRBeUQx9mSU+Uu/skdtynSqr
         BCvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GLrRLR3ScxI0amSkGQA6upgpDBmrrIqH8+IUZb/jbqD2KoGfuVj2f8HxARYmwpIDNZI4cblMo4zzqkJCiJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBRsiwTrLIU7G7igaaCfGB968LKC00W8h2mivsF7PcYPLjeap
	u6SgCdndiBg96w/n9HvzwYNNSbkWqKphJupWlasdwrsgTEiuhpoS6OSq
X-Gm-Gg: AfdE7ck9DKPsll4DNX5ZxwIGQdlpeu8HBAyagMudZvUP3fpsfaxdA5uv9Xgd7JcCG2Y
	z3kvYEygcQCQF3vTnJS3D6tjK9tBbwo/BqBf0migrTYcwmV+VWceg1edSdnazDAORZfh3Rg0t6q
	YEEl0OmEhOWaAEsENEEf7LVn0uMhci8fIRqELr2Xhe7tmi3t4XQVXPE9NAIdeD2/Zdqd2517AwK
	XLHtzxm/fpZ+rSFXfIRGifOsitknbYQ51DFPn5zi7zNzJoFuAHiM6juq+sNwlTmt3BCbud4b8Ne
	IobRCXKTD+Qu1mAYY4jaSMn/NeNJ5DCDoULYU95+4cQbcuD9Y+Vr8O+VB9TMD/5MpM/FJ9G/hIQ
	/OSgbE5qwg0g9UmomcV3X3K5bhGBrpPAs81SEMu1KjUaLvQjoKeI/x98U8nnpW2v1hM565dlScd
	xsiuaaYgusXwi++0T1th2WKnaFwzuzcCbY09SpYwdgpcTu2WcpfL1hO0WW+3224BsR2IEtA597s
	B1JFOkhSMVvLpZk7VnES7uX1DTy4af+BszkcEmA
X-Received: by 2002:a05:6a00:1a8f:b0:845:3ffb:ac2c with SMTP id d2e1a72fcca58-845508d71bcmr229586b3a.46.1781810309055;
        Thu, 18 Jun 2026 12:18:29 -0700 (PDT)
Received: from localhost ([2601:644:8000:5b5d:b427:6f9f:eb5f:94ef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acd96d8sm24450477b3a.19.2026.06.18.12.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 12:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Jun 2026 12:18:27 -0700
Message-Id: <DJCF1EZ3FVPH.2HTGKC5T5ZCYW@gmail.com>
Cc: "open list" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath9k: drop static from local pdadc and
 vpdTable arrays
From: "Rosen Penev" <rosenp@gmail.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, "Rosen
 Penev" <rosenp@gmail.com>, <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260616030828.655310-1-rosenp@gmail.com>
 <87se6kfa9b.fsf@toke.dk>
In-Reply-To: <87se6kfa9b.fsf@toke.dk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37902-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[toke.dk,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:toke@toke.dk,m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72CF26A2540

On Thu Jun 18, 2026 at 2:50 AM PDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Rosen Penev <rosenp@gmail.com> writes:
>
>> Remove the static qualifier from mutable local arrays in three EEPROM
>> power-calibration functions.  These arrays are written to during normal
>> operation, so static storage is both unnecessary and misleading: it
>> implies sharing across calls when no such sharing is intended, and it
>> makes the code subtly non-reentrant.  The sibling function in
>> eeprom_9287.c already uses an automatic (stack-local) pdadcValues,
>> confirming this is the correct pattern.
>>
>> This keeps ~1 KB of data off the static data section at the cost of
>> stack usage, consistent with the rest of the driver's coding style.
>
> As pointed out by the test robot, putting this much data on the stack is
> a bad idea. Pretty sure it's static for exactly this reason in the first
> place.
Sashiko points out the opposite:

This is a pre-existing issue, but by declaring vpdTableL and vpdTableR as
static local variables, doesn't this create thread-unsafe global state?
If a system contains multiple ath9k wireless adapters, or if operations
like background scans trigger ath9k_hw_reset() concurrently, threads could
race to read and write these shared arrays. Could this potentially corrupt
the EEPROM calibration data and PDADC hardware configurations across device=
s?
>
> -Toke


