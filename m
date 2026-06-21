Return-Path: <linux-wireless+bounces-37947-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lx27LOW7N2q3QwcAu9opvQ
	(envelope-from <linux-wireless+bounces-37947-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 12:24:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2F6AA96C
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 12:24:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=icKwojMt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37947-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37947-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B627D3003349
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BB257452;
	Sun, 21 Jun 2026 10:24:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB505233722
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 10:24:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782037474; cv=pass; b=EaJyWSg5fC8JfUp3bqn007jQdNf0YtexCPRtz4iJ1AMcPE3mkDy9eeZQgYy1IwLJ/k5wMJUoIj30ko7jjbx+vb3g1I/zOaVhbVPRdkS9HloB+lbetOkpb0JucAD10FzY2jA9XKYloDmikfIIhvA86AsRipUjOfLUkSxHAEYEDpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782037474; c=relaxed/simple;
	bh=W4TDKJC+abNfGZZm3nLu3Y9unMh1uoL0yEu61M4eCFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxSsKKw8d5jJuvw1tYQNyZ+zn6rGPC9tVgURlC3P059FJ4V9gUlAdvD02VD9AvO6a34UvbQDMvwdZ+D+NJ7pJ7DqqaIRiy+9Pdg12BcAYnNRcQiJgeRT4YjQE0DpynM1uGotZJA2JnUQsDISyurJsttyov/0S7QV9ag0jnykGcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=icKwojMt; arc=pass smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c40397e746so20112875ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 03:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782037472; cv=none;
        d=google.com; s=arc-20240605;
        b=OV071lRiYaXLvAIB/4wLOeaeRx+SQnB+3+HDsu7pq485FlQo5//EsmGk+yYmVHs191
         3QdlzOu6EyH79MwXvMkK56LoLTdKXM+QdILqTiYyXryI3hEvKc2vhMkI0faGa4mm2Zef
         2nQGpjamnkqzXFOdGDOIdjei0lTj5FWI1sksF/pZ3yIkKFj7a32ImkFA6asn+axi6jyi
         gu8xBCh00AF86MGmAAO3KUjX4itJTkCxzeCGMfdRm/PmDrvD86g+n8quByvlKm57Lirr
         7ZbapvXmi1JZfYZa6p7JuESvF6qG9teBfPb0c44+k5Ykdw6MrVVlMzLsWrNxDtUS5t0p
         zEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zPsiAR+MabBF88h2oEH/QhoFjtwrYM0AHuhcbXT9hmY=;
        fh=imvwrIGzz0AX7W9q8dpzn0L+MR6lcXacq1LvnQOIUvY=;
        b=ZNuLvQFos+bNO21bTJd438MEA0s96F+EKLoaPjGrsXmiTCyoYoSJt88YlEoVAiffId
         0TvU02qb7OqUhy+hPjxPkvRjlONaDm5gIqkD/04MGrIJvZh77bhXXzyODZ3AL5s9Knrm
         9obmagE7HEfPOpm2jXuV90kAc8Ul4CWH/zXGPEAHEeU1XNtq1aA3+kn+aY3iSAksADF+
         o8+pyMIjO60zAtwCOF2pAISHwOLJpky+6ncam81K5UDvuSX8k0SuJ6SnTUDOS4HqD6HH
         U3CZb5CbzabyWiHecbtYfuF0wB4Bil44q1J118+T3UlNxwm/kQRpNUhwq+lSp5uJsq+C
         cxQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1782037472; x=1782642272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPsiAR+MabBF88h2oEH/QhoFjtwrYM0AHuhcbXT9hmY=;
        b=icKwojMtKvLCnWfqNEEYtNaDWlCdCQYThDMARLyS0dWcH7rfb/jHZHz7bgkAPusGGq
         yTMliHmcn1T6GlOGuvmd12k6lf4qc8+Ymyv0P7vJ7a+a9puj319vCbzCy+4Q7Vyw69wC
         rkrY0jrilc/qp5iC7VnwAAqYcEXH/cM2EpYx86zzAtxrJiE3HhFZ2D7EyKfApEZhpVK2
         CE/+ZqvJ3RuPxqXcZmk0FiK4jLlUqPsfoFuKOM5d70MEABmt8JgxM3EKmWZBNd1Bc2Xz
         GBCkJZgBY1McmNGZ/dvJjABGRT4krI3HEGSSIgLW9z3dju5XGKOwfPzs38fG6HqsOmb1
         JmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782037472; x=1782642272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPsiAR+MabBF88h2oEH/QhoFjtwrYM0AHuhcbXT9hmY=;
        b=cK6uCCB4pEDTcQHghCUa/+auWDdw6TsCJAVipxIIbdrBV0dD4XQkzOc81UNNHE1XDB
         p/IcqtHFB3sS2kzg070pdzJxIFNv8tlJSvCfnH41ohI5vPb+ep+ZPJ8gGwYKzS+ZLjhE
         YYRkR2pRos37DS7uC4h60NfFW/j2FubxgO2Di8xJa4wIFAGt42H1JgQ6mFi9qakTTgNs
         cA7RCqlznoucRWfy1bKNm5KO/75Y9BAkWczR5pw4RUtU9sZnEgQq09kcAJ33fiDyU9on
         FrRfGGPtjwNAb/uSvrOepyvcWW1ptJ0+DXf46qtfDl+YS0HR371aiTmLRPLEF3I21mSl
         dmwQ==
X-Gm-Message-State: AOJu0Yw6qwRVFGyryJw/GZ0dtQoM79XT0ugeepbl7zt+hSx0sEA5znS0
	96VCUCDKpRJsN5YbPtgRItXzIH8wNDysi6hbPC1nuFeljLCayESRh6LmAO10XnGLAAZL0wewbiQ
	Fut0rs9xzSfnheK5pyDHR3QKlykfdJs1BYAlUSVcVA8T6Qn5RQgrPfigs
X-Gm-Gg: AfdE7cmHKcyJs2SuosAq+C0kxF3IeDXlOIgpQEf8jOHjJnxqQe2v8SdCb0Ickh1nvru
	xhP+AeURagumTXFHWUUTL8kJvzxSvSAW1zl5q/x3ZRX7jGXCAbhjD786eKoEM2D6YAQ4lGQLTNV
	WG4jE4tc48udiM/IIZHjeIAIO1AFW1eHOQLJy39esdu6CCWDz59XlE9ZJUlHpeSpVz2gX0MdAvA
	fee/y6mPfa40P0L2lwjl9gH1/yfv1bsZOraMI6roRXmoD2RUr2GYwOXJ/E6m+XJPNKxLH9gA0jP
	vLb3jY5tC+Q3zaFuJYgGVXR4d9t7IhpyuWSZwt/FvjW0rIu/LlddVtUZfIK0t8ktd14XvPk=
X-Received: by 2002:a17:902:d504:b0:2c2:8659:da2c with SMTP id
 d9443c01a7336-2c7425d58aamr62923065ad.14.1782037472081; Sun, 21 Jun 2026
 03:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619224818.90751-1-doruk@0sec.ai> <a2bc98ef-fae5-4309-9066-452ee780fe04@gmail.com>
In-Reply-To: <a2bc98ef-fae5-4309-9066-452ee780fe04@gmail.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sun, 21 Jun 2026 12:24:21 +0200
X-Gm-Features: AVVi8CeckJujpZJhDYoPnHubcpdWngVVOyJ4MNG1v7vRWrdv_xCClmX7LhwOXUc
Message-ID: <CAPdMp1oWXvtdvp8D0f32vpvzGa0H9PhprQcACqqoc4Gnyy=f6A@mail.gmail.com>
Subject: Re: [PATCH] wifi: carl9170: clamp command response copy to the read
 buffer size
To: chunkeey@gmail.com, chunkeey@googlemail.com, johannes@sipsolutions.net, 
	jeff.johnson@oss.qualcomm.com, tristmd@gmail.com, kartikey406@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37947-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chunkeey@gmail.com,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:jeff.johnson@oss.qualcomm.com,m:tristmd@gmail.com,m:kartikey406@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,googlemail.com,sipsolutions.net,oss.qualcomm.com];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[0sec.ai:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,mail.gmail.com:mid,syzkaller.appspot.com:url,0sec.ai:dkim,0sec.ai:email,0sec.ai:url,0sec.ai:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45F2F6AA96C

Hi Christian
sorry for the dup, didn't see Tristan's version; feel free to ignore mine :=
)

cheers
Doruk

DORUK TAN =C3=96ZT=C3=9CRK

Co-Founder


0sec

Universit=C3=A4tstrasse 33

8006 Z=C3=BCrich, Switzerland

www.0sec.ai | doruk@0sec.ai | Linkedin



On Sun, 21 Jun 2026 at 10:17, Christian Lamparter <chunkeey@gmail.com> wrot=
e:
>
> Hi,
>
> On 6/20/26 12:48 AM, Doruk Tan Ozturk wrote:
> > carl9170_cmd_callback() copies len - 4 bytes from the device command
> > response into ar->readbuf, which was allocated by the caller with
> > ar->readlen bytes. When the firmware/device returns a response whose
> > payload is larger than the requested ar->readlen, the mismatch is only
> > logged (and the device is restarted via carl9170_restart()); the code
> > then still performs the full-length memcpy(), writing past the end of
> > ar->readbuf -- an out-of-bounds write driven by an attacker-controlled
> > (malicious/compromised) carl9170 USB device.
> >
> > Clamp the copy to ar->readlen so an over-sized response can never write
> > past the caller's buffer. A response that fails the length check is
> > already discarded by the restart, so copying only the buffer-sized
> > prefix changes nothing for the valid path.
>
> This is contested territory.
> <https://lore.kernel.org/linux-wireless/26e33fea-c81e-48f4-a058-4b3bf0dc9=
5c5@gmail.com/>
>
> Original patch (as part of a series is from Tristan Madani)
> <https://lore.kernel.org/linux-wireless/20260421134929.325662-2-tristmd@g=
mail.com/>
>
> Yes, I do think each came up with the patch individually. But I have no i=
dea how
> this works with three authors / tools? Does anyone? I don't think this wi=
ll get
> any better though.
>
> > Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> > Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D5c1ca6ccaa1215781cac
> > Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
> > Verified with syzbot via "#syz test" against the public C reproducer
> > (Tested-by above); I do not have carl9170 hardware locally.
> >
> >   drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wirel=
ess/ath/carl9170/rx.c
> > index 908c4c8..897e682 100644
> > --- a/drivers/net/wireless/ath/carl9170/rx.c
> > +++ b/drivers/net/wireless/ath/carl9170/rx.c
> > @@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar=
, u32 len, void *buffer)
> >       spin_lock(&ar->cmd_lock);
> >       if (ar->readbuf) {
> >               if (len >=3D 4)
> > -                     memcpy(ar->readbuf, buffer + 4, len - 4);
> > +                     memcpy(ar->readbuf, buffer + 4,
> > +                            min_t(unsigned int, len - 4, ar->readlen))=
;
> >
> >               ar->readbuf =3D NULL;
> >       }
>
> Regards,
> Christian

