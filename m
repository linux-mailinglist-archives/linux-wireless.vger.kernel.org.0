Return-Path: <linux-wireless+bounces-37155-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMB4GVQcGmo+1ggAu9opvQ
	(envelope-from <linux-wireless+bounces-37155-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:08:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD1C6099CC
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 01:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D25CC30087C6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 23:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505333624D3;
	Fri, 29 May 2026 23:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5ci9IY8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79535F60B
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 23:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096010; cv=pass; b=f+eUxJMWc+LV31a312O0+FX78AxX5z4NoPmeyP9NYBnN+lznEG6jYp3U4imgPcMHHrAVgfLCGu2ouHpod+4D0N2mvIZOs5D1ozU38JF8TNTY/Ksyok1XZ/n8DCdOaKnNXXQc268EBFXHX43hJIgnyHBSAptxcZm7aqNOkRzX92M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096010; c=relaxed/simple;
	bh=qJ6CWONTJL2LK4asba1iPm47maUiDF76wbKb2frbchM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/umSXG8nBL7MbCC1+f0zy43m85/feWkjaSTFZjlrQfnAQfo0fmNw18WYCqeQL57KGKPOfW/wwlE/Hx6DAMM686xSbXG7IHAv5HS7OVUwoBkOJAy7EfGRcumQTEaO36fu05oTcjethV0ZsO1hXWM8Kz5/CDtWB4yfy0JbDsmY3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5ci9IY8; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eec22fab7so1237547f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 16:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780096007; cv=none;
        d=google.com; s=arc-20240605;
        b=ke3SgNMePrk9iEZvu8G16jsRsw4GzKL6u1N6yI2Csla6oTh9yuz3JHbCUU5H9HpvhT
         CMBk7YcBHifwhyc4Sfc43vEnD9EyQ47X/KIw/JKQqNSna1CHJ+zH67UpDC2z1qx27lEO
         4NMTAH8eVi5rE5QX6PftQtTDWtfSiaTEc4p6epWogrervNTbQ/vXTztEkaOP7TocJ8yh
         yXoPwbavnXkv3ZS+yoBwdSyK60LDZUMP8BXwdpJcXQfbIZuMw+ynbNFvrPJwcySucZAg
         vEJl6IfRQRDNy/z77RTyZVzTGu3WT2KE87Qdd0uepw7Bf02F39uhCd2tN6bL0NDQ2bjf
         xFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6QpNk5UdWgZaeWLkLChXGQ+DQEsr5FjZ7mIw0Xqajw=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=Wo4fVDvFTB8Hwqk78TK3Wph3oUgB5iqwmcOazB+nwZ5CnSmuzoW9eUUWfWtpPwG7/d
         hQ8uj1l2VIodECD+Y2/u+1xCnDyiW9daPooY+IixyoKGwrZCuW+OkCbe8xI1mkfgnaVh
         cBARTYNHxQkgP4hvaJ/XGNLWZpIyvK1BO5cD06T3fOl0MELghXbso33T8gaEZjrCv+qn
         doL4rpwSGm99A6sVyTvzpoeweuPs28WjoPtvBV3B2H6G+JVV/ADwPd6NwnugZyWdMFuT
         KATJxuq1TaOGyAgz5VoM0+4oGi12yaVdGubo6A1PPpG5iBPT78awHTN3pw/7+rsANvCm
         ejpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780096007; x=1780700807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6QpNk5UdWgZaeWLkLChXGQ+DQEsr5FjZ7mIw0Xqajw=;
        b=g5ci9IY8g1r+lwTTAY9RN1C/A0UCFSLjWZhXX6M9fBg9D8g3ZUKu9kFYUAksuAd82q
         F1GYqBtK9Khlsj3uC3mk4QH+a7k/G1YWHAvjBk6FOHCFGhbjDIBMUCZuZV88jIKUXobk
         0rB8avp8UoQJ4vYjZqcK5f/4LiKvD/vcawLYmJsKwAaJZdWiyakMCLkrsyF3BHzmXAmI
         Nb3ckerIGiER8K7Mu0fH+ytl4Wvq5a+9EaY38ShK1AhnRop/tzbx4rk/Oq23fG5K+cKX
         DYXr178Xzxxa6nNPt1Mv7SqParyEagXI/SVfTsnlKwdpzMTjJ4PyqcQag5/pXMoqXnrK
         kqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780096007; x=1780700807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6QpNk5UdWgZaeWLkLChXGQ+DQEsr5FjZ7mIw0Xqajw=;
        b=tUuXZ7XT+PGWuMADj5I0mx9Z9Paus7QAvKzRJWBs3TGDyu+ifEe8/f3Ih1XWliE4eH
         P3Pzn2V0ktCyZpcT69oSXI7OUUXStGmEVY96yjsX/FRB8qRQTqE42XFX2NXf44HbutDM
         AhwGNxo4oFF3O/kw1tsOfYy9x3Cugeq1QJLx9lLYu1K6NYFPg4a2AEMb6Qm3KmqyiJyp
         UO+fT13KETnuNB1Lck8qDbgSalxzobRgfocv8fXzO4erHv2bnpGvGF7RcnhFMmW4BHT9
         hd86mUa8MEjZckisdw9xXEXcALugnUWusybU+onOdD3n2TQXZoZDUA+VluwF4JuJBtcI
         BzNw==
X-Gm-Message-State: AOJu0Ywjj0vewckBGyHvef8OUhbrks9GVLDRwH6ZVythbmTl3GFfibue
	AD1RTROrF+OLW9YPeNtPr8itPfw8zpYA2Qr9TM5hiIvPwK3GxH5x/8Lf4xB1oddjdU1EFCTT9yc
	hXzheuCX/tg7Zy/3wUiCdenusaOpPcx8=
X-Gm-Gg: Acq92OF3MEB5b9B9KgujfdT5K3cw1eZKlIa94qNFcMMElalrlnk03I8puCptZyvHJm5
	kPUmxK7+Xq9JllpLrM9glwn6S+DHTTzCaYODw9AV1MgX615SBscxB5P0k/XQUUH+P9NMAQeM7HM
	5SRFi+X9NQW+xaJJ2UVZEEo11O+empIQj6ouZeaC5rMSs1HkwnC5sM9MTgWQB7NWSYii0uo5BsF
	rSo12oeOknNQElUkDOsQ1Dp7t9Mq4fjn34ftEzHYOBIhxpfx3IuH3+GC2A32PIhVzzdm2fEzgCd
	2tGbj/L+VtWMFCFS+Lf2FfvwdWKPvqk=
X-Received: by 2002:adf:e344:0:b0:45e:e561:4184 with SMTP id
 ffacd0b85a97d-45ef6b73fa5mr2504468f8f.29.1780096006936; Fri, 29 May 2026
 16:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521225842.31815-1-masashi.honma@gmail.com>
 <20260521225842.31815-3-masashi.honma@gmail.com> <8ab957b3c31dec7be844ea9e1ac2fbb2fdcd8278.camel@sipsolutions.net>
In-Reply-To: <8ab957b3c31dec7be844ea9e1ac2fbb2fdcd8278.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Sat, 30 May 2026 08:06:35 +0900
X-Gm-Features: AVHnY4In39qjvFTsVvBbL9P4nZR9P5ecCX0qmiXFKh1jNKVe7BHoZu8xmFh13p4
Message-ID: <CAFk-A4kbjJO1iPG7b6YOxVd6UOkS2NOjBJL-TbGcqYuBvE2ygw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] wifi: mac80211: Use struct instead of macro for
 PERR frame
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37155-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0AD1C6099CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your reviews!

Ah sorry, I overlooked this point, so I have fixed it. I also added
KUnit, as the code was becoming complex.

2026=E5=B9=B45=E6=9C=8828=E6=97=A5(=E6=9C=A8) 17:00 Johannes Berg <johannes=
@sipsolutions.net>:
>
> Hi,
>
> So I was just about to apply this set, but now I'm thinking about this:
>
>
> > +struct ieee80211_mesh_hwmp_perr_dst {
> > +     u8 flags;
> > +     u8 addr[ETH_ALEN];
> > +     __le32 sn;
> > +     /* optional Destination External Address */
> > +     u8 variable[];
> > +} __packed;
>
> This has a variable member, and the presence of the address in
> 'variable' depends on the flags (AE_F set there.)
>
> > +struct ieee80211_mesh_hwmp_perr {
> > +     u8 ttl;
> > +     u8 number_of_dst;
> > +     struct ieee80211_mesh_hwmp_perr_dst dsts[];
> > +} __packed;
>
> However this declares an array of these, and that doesn't really seem
> right. It effectively puts non-variable fields (e.g. dsts[1].ttl) after
> the variable field dsts[0].variable. I _think_ some compilers (versions)
> will also (rightfully) complain about this.
>
> It seems like this should just be
>
> struct ... {
>         u8 ttl;
>         u8 number_of_dst;
>
>         /* list of variably sized struct ieee80211_mesh_hwmp_perr_dst
> */
>         u8 dsts[];
> } __packed;
>
> > +static inline u16
> > +ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
> > +{
> > +     struct ieee80211_mesh_hwmp_perr *perr_ie =3D (void *)ie;
> > +     struct ieee80211_mesh_hwmp_perr_dst *dst =3D
> > +             &perr_ie->dsts[dst_idx];
>
> And especially this indexing doesn't seem like it could work - you have
> to walk through all of them to see if each has the AE_F set and skip
> sizeof() + optional ETH_ALEN.
>
> > +
> > +     return get_unaligned_le16(&dst->variable[
> > +             (dst->flags & AE_F) ? ETH_ALEN : 0]);
>
> This looks like the comment above should be
>
>         /* optional Destination External Address, rcode */
>         u8 variable[];
>
> or so?
>
> > +     target_rcode =3D ieee80211_mesh_hwmp_perr_get_rcode(perr_elem, 0)=
;
>
> but evidently, this doesn't really matter right now if only one
> destination entry is ever read.
>
> Still, please fix that, if only to avoid the compiler warnings I'm
> imagining will happen.
>
> johannes

