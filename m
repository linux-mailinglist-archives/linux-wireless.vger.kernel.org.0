Return-Path: <linux-wireless+bounces-38688-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HUlmD83AS2rYZgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38688-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 16:50:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331AA71233C
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 16:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pmPTIXRm;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38688-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38688-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0687339E560
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 13:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A783DDB04;
	Mon,  6 Jul 2026 13:13:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DC3F6C3B
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 13:13:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343621; cv=pass; b=szrgJyP8+rqbDNo8Y9+aozILQDHwDNp3ZjLmpay2Q8q0tE05V8gFrDVzk0ic5XQjy2RDCTdskU/L6xkHGUJzBXWTHnPNycwHwGvnnacVZJG/mRkVGjZWI/nLv+V+mx5OGJjAA7R5irVkTBtpEsV2nR3OmWympNFLb/Mi3OMthoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343621; c=relaxed/simple;
	bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKo285xgEH6iJiz36KfpQKW9c774sjLeHAyLbHwRZ7OmIVePO407bQgq3cEqyTEPgr9LvUY/DMmlWVCrQEkuyrm81GgnYZYgj3lRwNtG90KrW5ccLoU3YubjjHQOkNk/D2E4WckmAm5Nd9JiMKMNHy5D2tMnpoVQtoUDHIuLUeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmPTIXRm; arc=pass smtp.client-ip=209.85.128.180
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-80fe8f03098so24519067b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 06:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783343619; cv=none;
        d=google.com; s=arc-20260327;
        b=b+SHodlOrtvf7uv0l3PMRODDSK2Gv/rQ3hDXchniQVJsdEtS3CEOueUnbXI6U7KZGA
         9B4NKbSkAau3VYcLUDL51bbxLh6RLyZx6zVo7prRAYRT3cmoNX78NDK2Lxd6MgkeYveP
         zbE4gHiDdfFjFLAyXY8xJiGr35ybfUqVuSiocq2Xj+SZf/CJZDxotXlBiKfrJoR/GmCi
         thcC9ivF1If3/bMkVgGfifZMUuy3vWIjVR721yLv7EquYxZqsgb+RglvxMyPeBbDhGP7
         PSD4NUxEcbKRNtUYYn0SEOURIrB3TUodALsqx5XMZZDSOZkgMW/3fv6nxFgPWGUwTbbF
         oOEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
        fh=fVS0f6SDk+4HCFhUI+GNHDVX4rFxF+kaP/X+0WZ4oyA=;
        b=FWhNljiRVIMbrUwwRtC8t8VgBVVd4sFrY8j4pqOZVKyn+v//Txcd7S95LqgN+5APSe
         tXRpASga8EdYGufrBan3DGEDZBxI15mIAYmcLVGmSJlW9q3cOcDz29MUqdVgIdS3/v0L
         5EOAqJRMBEZ0nV10YtdxGxHNQQkb9ZfR/a2kzGHXalE37npH54kBIDfL9xj0j6pOLGhA
         mLYO0VSHTBVJLlquZYhiGUo50wxqBhuR1kaeCI30Mn9tdG8t4R+D6erzo73lUmSCJNJP
         IUUNlpVddYVtY/jBveVqCb/0BQ4HBIzIZSQqU19HV3VxX1ZTdC04hbWDMjzJL3E4+fE1
         cR0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783343619; x=1783948419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
        b=pmPTIXRmO7vK65MG9ApD5SjHL9fhCFKp0fke0dtwtu3aQgc1lJk/CKTwMDi1EqMP9v
         7F+aON0sSf+W8t8PsLgtGv7hPPaqKgofgs4K3Qe+wPGllK5AeQtrOxPNVAs5q/iQJNa5
         ACK+bhGfyLsI5Q8ju6YTiFUYSy2WcCjDsD4ww3C5iqUTEmRch0VGiIKcXDhg4WU7qFfk
         HOZQ2GV06DieUp5OmueLfAvSePkgY0SwL3KdU27IqUoQBCI1+9L9tAd7RXbMlVYzZEI7
         XKhslW78rzHFHbdup4+id3SOEtef00yhvMSOXaxV8usxtlHaoHu9xpUD2yGqjilGweAW
         uYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783343619; x=1783948419;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W06a+FQhE9CYhRDkSX3d1qnVPXMf+V5F//o8j4fuNbQ=;
        b=L5NsFXy4fAXcG5MGtiDgOzWqTgOYVoM22uu/gywlcPvUcBqWZwsgk3mlyOxjfD02I0
         JqWHJvfkMeKIXv5+TrGKPnxghRx8ltPxpLQEbs5HTvcjoUmXLnsUm08/irInm9a5ilvV
         AInC5SvaZSMHU/CbYjTEsee3dzgn2NP7zdWuVNdRQwo7sN/1gGQZTgZas57pDbwv2K3d
         vulgLiLkNokXFg5g7nuYvHF+v00W+e+jQ05Jy/J855RiABGBUPFwnlDE65ezh/dfq/j1
         kXm6clijwXX7a5zazZHnThUMHKUmm/2aqQijwqB9p2kb+r0etei7nU0GXeIuOOAs1YEh
         v4fA==
X-Gm-Message-State: AOJu0YxANgfOKrWOENZ5lhstCccriN/giPahXDoyAPyMWdn7Q6TnVmwx
	4iM7QTJOq4mMedHqVf2MD4RrrfKeYdN8uOmAtscychjRb3v4B41dj3HnYNSq7nXJcCVllTNEjEm
	O6B1wd6RzdwZzLK8nY42+KgtSPfE5xfOsohcn
X-Gm-Gg: AfdE7clbmz8+tPZ5JHNw5sgdpQareuvXXQTjEmNob+3doj4F77CyyBckP99YSQLVus8
	LPlyvrdEN8H0rm5Hte30etY7KvoGRA2cF/XYhDDV8qHSapEh3vcwvf9C8/xtvZOlmsN+zApLRNe
	5/nif83PVNDrj+955F44wMlxCtD0nsEh9edYDGlbFblQw2Qldo5ummHfcT+MTRFtE4zHCF9BWuW
	brywXc1tbCVKhqHWjGh9oPmkMoNqj+grIM/Z4JjcmWRAgJK0JwkrCBRHmGJrUOCbVRZw6WU
X-Received: by 2002:a05:690c:ecd:b0:7d0:79f:339f with SMTP id
 00721157ae682-81be26663bfmr1394177b3.34.1783343618557; Mon, 06 Jul 2026
 06:13:38 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 6 Jul 2026 06:13:37 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 6 Jul 2026 06:13:37 -0700
In-Reply-To: <741085b4-3892-487d-a39e-75c62a7b6d0f@gmail.com>
References: <20260628092814.40583-1-alhouseenyousef@gmail.com> <741085b4-3892-487d-a39e-75c62a7b6d0f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Mon, 6 Jul 2026 06:13:37 -0700
X-Gm-Features: AVVi8Cdxlr6gMWVrPELRICnA8WPxAFKLDWDEkWzm1kURK7XCvcwCoYib2Y0iWP8
Message-ID: <CAMuQ4bX_z+j7deGvKWGhqCApjwbWNaNB8RT9vpfPhuZ7Mzt-+w@mail.gmail.com>
Subject: Re: [PATCH] wifi: carl9170: reject mismatched command response lengths
To: chunkeey@gmail.com, chunkeey@googlemail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38688-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@gmail.com,m:chunkeey@googlemail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,5c1ca6ccaa1215781cac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 331AA71233C

Hi Christian,

Thanks for pointing out Tristan's earlier patch and the prior security
discussion. I had not found that submission before sending mine.

I agree that returning after carl9170_restart() is not the right fix
if the restart can unbind the device, and that the copy itself should
be bounded instead. Please drop my patch; I will defer to the existing
discussion and will not send a v2.

Thanks,
Yousef

On Sat, 4 Jul 2026 21:56:30 +0200, Christian Lamparter
<chunkeey@gmail.com> wrote:
> Hi,
>
> On 6/28/26 11:28 AM, Yousef Alhouseen wrote:
> > The firmware response length is controlled by the USB device. Although
> > carl9170_cmd_callback() detects when it differs from the output buffer
> > length, the function falls through and copies the entire response into
> > that buffer. Callers commonly provide stack objects, so a malformed
> > response can overwrite the kernel stack.
> >
> > Return after scheduling device recovery. This also preserves the stated
> > behavior of leaving the command incomplete so that its waiter times out
> > and clears the pending output buffer.
> >
> > Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> > Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
>
> This was posted earlier too:
> https://lore.kernel.org/linux-wireless/20260421134929.325662-1-tristmd@gmail.com/
>
> In fact, there was even a mail before that that was sent to security@vger.kernel.org.
> I told Tristan that I would much rather not return and instead fix the memcpy.
> carl9170_restart can completely unbind the device, so it's unlikely that one would
> see a timeout.
>
> Cheers,
> Christian
>
> > ---
> > drivers/net/wireless/ath/carl9170/rx.c | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> > index 6833430130f4..ea3f435fb64c 100644
> > --- a/drivers/net/wireless/ath/carl9170/rx.c
> > +++ b/drivers/net/wireless/ath/carl9170/rx.c
> > @@ -145,6 +145,7 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
> > * and we get a stack trace from there.
> > */
> > carl9170_restart(ar, CARL9170_RR_INVALID_RSP);
> > + return;
> > }
> >
> > spin_lock(&ar->cmd_lock);

