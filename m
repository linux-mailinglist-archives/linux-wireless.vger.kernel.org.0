Return-Path: <linux-wireless+bounces-35323-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDbDHhxP7mn2sAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35323-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 19:45:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD33A46AB28
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07CE300EABD
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5460C2580CF;
	Sun, 26 Apr 2026 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC6AiJWH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03BEEC0
	for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777225497; cv=pass; b=coJkeuAz4PlYeHnTNqzSzZnZHW+G6ZZ59YLYZqlb4DqEiUu2dtW65G++JfiaTljpApPtArivCfFvZCMT6wBsRtHfJzrc/jRODwuyBa0Jy2Oz/C3l/rvYYUe07/xyAlPELxlxKQUT9v9K/1peXdGBq7Fg9RbimxJWfo94d2CIOk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777225497; c=relaxed/simple;
	bh=S4wlVZkKvS7xha03qTHm/ko6Ftrs8aKXjEqNGebAgVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRAlERfqNxMefk+VoLjDWMTQboONBNRpgLGk6w40DTDWbCq2F7YllDo4dN3R5f9qyK+bNx4oLNb4vE6tnYRNwysSqkgZPI6L1bBE6eiWzuQOFwQUeSU88Qev1/xbphMlcokgbC1B8o22PGvJhTPC2xYzFl9FULChmodBRvMfJwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC6AiJWH; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so7095428fac.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 10:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777225495; cv=none;
        d=google.com; s=arc-20240605;
        b=U++bWnmOl5JubUxQPIbSZY/IL6YuoVt2HiOwrzjsyFHH5nFwLuPuau3MTnIFK3gbGQ
         QSI3pP5EVjdB8kKL518EEyYqpMtBc0rC7LsZyCAOIRdT6JwJq9iQRtQx+gliCXsehYN2
         6hOcSLIWcRPPAxsMDNRC9CJwBoRoRmT7glpoGV1CtDdHQ6oGqzQOOpMfMsxvDk/KCME/
         skbm8/+z5MsNf7Ws23yvtqW4Ci9vFhbgvhslPEUOVAo3bzXoSFydj/9JNsFqP/0Ri4GE
         g3q37NZ7kwbw/QmEWI+IzWCNr6rX05Gz183akyoKiEbS2LiTTPZWaEYhiqczEEMZgfur
         8jJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYTGPaSzC9g9Aelp0n/1FXmbEEOQq9vF7j7gnyJSjcc=;
        fh=5jxfMGK8EKbZ/k9iWiPZ0zrH9jWlWyDhBCAhA+fqSQQ=;
        b=EcxrG1btFCM9dOQE6UD7ZGYjHe05d6wM0rTFyCijEtaOuyF2RBZZ3bLjdqwnJhjWfl
         b9DumL+S3Ezr6V/kvtq8j09DlB2bvbeYT/zZm2LMd4Qsag1aBNCk88/OWvQyjPQyOQiu
         TLDcLRPCCc0JNJVFKEu7z8x7oUkHF8sKPfsxrQgrxzwevBI4UpjeqPN5raYMNi7qzcgy
         Xp50NF9oJdXEdPUpKOlVzmaAd53It+9G4xJkuCK8kra9k70qo26lPZHP3oEUBj/RwLtT
         DPzxmDUlG4tu174UOGUzlAGrjJXmK4pY6Bka8vRkrBb5uyGmaI9ljs7fCI5Q28ArAu7x
         eLnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777225495; x=1777830295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYTGPaSzC9g9Aelp0n/1FXmbEEOQq9vF7j7gnyJSjcc=;
        b=PC6AiJWHqEhB9amnrcFPXCkLxV+2TQdFkF/waQRnHrbOBlp/XGAV69f55C8T2FsPVB
         O5eU8lGDvssMW9yU/OFpSSsaJh7xQm0LL1o5TG9NSR6O3ZTEbaiCZpURXd53EkdIWlOK
         JJrPjuKi/JCbT/SCvAy6PLMfSh2kcRjFeB9/PdZTJxSDXFHDAbCfnDgJ6N6ajDRLCM5u
         Nc82I5d/NPS/TF5+sszjZwe5g6XGV3aeBQw3fgqpnXc2Ds1YXMuQ7yHhbC/ucT2BfUge
         62gSkR4qiGLPZ9a/ZvJxawYmhO6xZak0iRvaJIWdSx2odFT+B5ybop/xzD0C0wkWIoqs
         8gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777225495; x=1777830295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYTGPaSzC9g9Aelp0n/1FXmbEEOQq9vF7j7gnyJSjcc=;
        b=mypGG3biM2T3nyPNrBnCM7fxTAbmarleN2h5YAb86BcXD21+wT7ss02pEkW/FnHS9I
         BZTbIPLs6KZ1u+Sech5GKfKGY5lu/aJP9Ztn9ZU0wBasXOZeBuNpEi3cJKiP+dq4xhVz
         TFP2bFcAKOEvh1Gz7wJbw3hTTiFt4P18JyneOOmArtqG93vzBR2DvVyqA6pX22o7c6zk
         zWz0QBzWOynJ2GkqWC4i7vc1qXbgayFGFyQ6QR8JGjFXDnToZXCcvH/ejNs25Na70r8S
         zZxaU6yWZsfz3qTBlfROIswOa7EFIdVUqxOXtOp8KH7hSucZGekUZnj2KqpXn5k7ew1x
         t6ww==
X-Forwarded-Encrypted: i=1; AFNElJ+qpPcQxaih9mjkS5+5SFSczbnwrnA8iHDdasn+9iFSASw4T+RcoZjO0S7DwpT38kLJPelvnoDXRCzo/8DBuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytX3wTGC3jpwI5jsC8utvexAsjynKRmTwv407f+ayLwNp1NgYt
	h3RUPhY5a5/Zy7PsO3o+iFeToJKZiUd+/S4Juo3N0CYKA7+0HYIer1NBFU7a7pEQUUOPZogsePN
	LZnqObr03EZV9ZymGU3aGR1IrHgx5aw0=
X-Gm-Gg: AeBDieuDfA05aWdqIZC8Elslt5xsRFkVgpakd6yXYsqF5RffmiltqQQKOEQGOYDiioi
	mcSDSaWYY75W+9w8yzsMOj0STgVufPBi95v7a7mwFiveImqkw2tbG7N3bPicvdP3ueUBbJ5xogs
	jYbTMpx2h2pou7S95K+jvZO/kzQJL1Mbt0/5kZG+/izLp64LAzEToIVXXFJf4Leib/6Wq8oA/tZ
	8LK8E4t4zJg5pwtOTHpxHyQ8EVz//kTZXtG6Zo4mtZLEoFz53EMoOqmc3TVM4uqO51cWfTX2AIu
	IyTNcPJXV+SPsWyVipUu0lGDrrAWu7ioJLlohSnU+gVLpFo=
X-Received: by 2002:a05:6870:538d:b0:417:685e:3748 with SMTP id
 586e51a60fabf-42abee7de58mr22571979fac.0.1777225494749; Sun, 26 Apr 2026
 10:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423211458.458911-1-santiagorr@riseup.net>
 <IA2P223MB1199153665E2AFF709BD2F52D02B2@IA2P223MB1199.NAMP223.PROD.OUTLOOK.COM>
 <aeuH2chCSi57RYVU@voleno>
In-Reply-To: <aeuH2chCSi57RYVU@voleno>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Sun, 26 Apr 2026 10:44:43 -0700
X-Gm-Features: AQROBzBchYflWzFZAnRxvq1wPZX_0YofjEZPYiq9aJN6bwju_Tkgkgo__6pvNzs
Message-ID: <CAOPSVF3=BmOUw5+nnk-EYnpP_ff7wXsFAaz6sHbw-brLy-HojA@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quirk table
To: =?UTF-8?Q?Santiago_Ruano_Rinc=C3=B3n?= <santiagorr@riseup.net>
Cc: Kyle Farnung <kfarnung@outlook.com>, Jeff Johnson <jjohnson@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"koike@igalia.com" <koike@igalia.com>, 1132343@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD33A46AB28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35323-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,kernel.org,vger.kernel.org,lists.infradead.org,squebb.ca,igalia.com,bugs.debian.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,outlook.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:email]

On Fri, Apr 24, 2026 at 8:10=E2=80=AFAM Santiago Ruano Rinc=C3=B3n
<santiagorr@riseup.net> wrote:
>
> El 24/04/26 a las 02:07, Kyle Farnung escribi=C3=B3:
> > > From: Santiago Ruano Rinc=C3=B3n <santiagorr@riseup.net>
> > > Sent: Thursday, April 23, 2026 2:14 PM
> > > To: Jeff Johnson; linux-wireless@vger.kernel.org; ath11k@lists.infrad=
ead.org; linux-kernel@vger.kernel.org
> > > Cc: Mark Pearson; kfarnung@outlook.com; koike@igalia.com
> > > Subject: [PATCH] wifi: ath11k: Add two missing Lenovo IDs to the quir=
k table
> > >
> > > Commit 0eb002c93c3b4 ("wifi: ath11k: Add missing platform IDs for qui=
rk
> > > table") added some Lenovo platform IDs to the quirk table to address =
a
> > > wakeup from suspend issue [1].  However, at least two more platform I=
D
> > > are missing in that table: P14s Gen 5 AMD, as reported by Kyle Farnun=
g [2]
> > > and P14s Gen 3 AMD.  This commit adds one ID for each.
> > >
> > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> > > [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196#c23
> > >
> > > Tested-on: P14s G3 AMD.
> >
> > Lenovo products have a pair of IDs, you'll want 21J6 [3] and 21MF [4] a=
s
> > well. I submitted a patch myself [5], but I've been investigating anoth=
er
> > symptom.
>
> Thanks for the notice. I will adapt my patch to remove the conflict with =
yours.

Feel free to just merge yours and I'll withdraw mine. I'm regression
testing the WiFi disconnect issue I'm encountering, so I'll just focus on
that. In the meantime this seems righteous.

>
> >
> > I have the same "wake on power removed" issue, but I have another issue
> > that's more annoying where the wifi just dies randomly. I only have the
> > wake issue when power is disconnected, not when power is connected agai=
n.
> > I mostly leave my device connected, so I only realized the behavior whi=
le
> > doing the regression testing requested in the other patch.
>
> I've also been hit by a similar annoying wifi randomly dying issue that
> you describe [deb#1132343].  With the patch that I attached applied to
> 7.0.0, my P14s G3 AMD laptop has been running for more that 3 days, with
> several suspends / weak ups, either with power connected or
> disconnected.  And I haven't encountered that problem since it booted so
> I concluded that the patch fixed it.  But chances are that I am wrong.
>
> [deb#1132343] https://bugs.debian.org/1132343
>
> The latest bad version I tested where the wifi died was 6.9.11.  I plan
> test the patch on top of it.

6.9 or 6.19? My issue started between 6.16.10 and 6.17.4.

>
> >
> > [3] https://pcsupport.lenovo.com/jm/en/products/laptops-and-netbooks/th=
inkpad-p-series-laptops/thinkpad-p14s-gen-3-type-21j5-21j6/21j5
> > [4] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/th=
inkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/21me/21me000pge
> > [5] https://lore.kernel.org/all/ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@os=
s.qualcomm.com/
>
> [snip]

