Return-Path: <linux-wireless+bounces-36751-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MTEOq3ODmq7CQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36751-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:21:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F135A238A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 11:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7E430488C7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79923392E;
	Thu, 21 May 2026 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpCxlVzn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399B242D67
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353767; cv=pass; b=XlBCbvzknYZBx2yLdUEHGGBg8L+gxdzHzNa1QfCmEgCXXF/yvTGhK+Pag3Koxi/mc8p4qAHtWwcdWc+CnUMI5qzFGSDSPYW+alVSPU9pUMKkCwct1e0YT5q9AuwRy12JP9faUOKuXGhF4CX8VHtOAfybfEgQN67z1MOUpRVW10I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353767; c=relaxed/simple;
	bh=ail8dtnmR+aoRlwfqPNeycPr7DwnSdiCvg5hxeFDMS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzu1EILO29vrmYE7auIRHuzVcTTLFs1MtLXgVSVzlIr4frasgo2SPFL6bj8sUvnGO4bXwtjGh1npvqIVpRa62T4YMq2aE9L0OZeChbl5oaA89+EYSCXbPdcxQz4t4XLRWaz0/PMP+1KbgVZ1GRAqLwrXD52jIoxhS4z44ZmJyl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpCxlVzn; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so68225875e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779353764; cv=none;
        d=google.com; s=arc-20240605;
        b=IY3c0TAZhCNltKFDUP429VaKoCm2ab16tAO9NjioykZZI6GHeRH/lAzTlgIsfnXZDZ
         xHq4F+qxNZnJJYTbCy85EURFNMtIfGUiAtnDUfJCMqb2OGIdoDHqVEJGeNn8OZTp6JvU
         Rn4pUIIAKLCbKGBmfJNgQpUcL5G/22wNKy6p9dBW44M5IqImR4IOfOfhM54r5n7lrWjM
         koEkuszluR9gjUW8JAmvHMBLQ7QUzJCTxgr+jJl2sVISNvBjCp6aMfTTuTBdwWoxnCXa
         HW1emPIjoraRHQCycWHwnok2netDZbjSoEtvD717+wvWjm5+B9PCDdzTu0jOTZDajs1n
         qXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GyuTyTzTUt+3jxkO4NHCcRAN9xNtTB9KsQFIwobBOao=;
        fh=kiH9BsJ+TyHZ/0f9lp96S1R8k/374lMiI4doNuDXH6k=;
        b=aDuKp+hfKOt1l/b3yxZCYpp+o5COZEujRKNY15mkriUF/nlweLfWLJ+sX0UqqKnTPL
         b+ZD+43zU6StwypXmOcauET40V3YehY4N1ZrzPgjea165RxPHXgt0WYoT6LXQNmfQei/
         NyavwPak/JPeqU5vKJqPUPtwBW09qGMIi9nhJdhLR3hJkAqf4sBnxGA7vyQQ2qKmeTlM
         MQmuPKJZYXAA4DiHphgdfQYZoDYV8/fpCTSpkg6eHSzYYPecKDiSb/sNA0o+E6+ds02s
         +gojzNqcjKoJyPIn7Ysavl6HPk7VLbvooIvRz+Uqn0ez7fRJC3Sjc5wWNhrWaTQLEX75
         mncg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353764; x=1779958564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyuTyTzTUt+3jxkO4NHCcRAN9xNtTB9KsQFIwobBOao=;
        b=DpCxlVznziH5Zr75hkig6o/2DcgSkfNY5nDvFSk4FZ0X89qCRwXhsuNnXaKvPwkKbz
         bI7vb2bo71OOnwx/BHtKMtbpN+4GcA8hAh6FaeMHcQEdQy/hoW2OdDREsjOCxnCkNiPt
         5rPwRLCeP0ozPQ7vowLbRjZmtHbIiKjPrzLEukZfTcSw5SLvgrbU3B8GwbtUTbSkcl1H
         mlEBQB3jgsGAi24RnFDaTtg34v+p8sEUxsmPehXdNOUAdyv2iX6yvQn4s3pO3y7QPmm+
         VJBH2Hsh08FQZYs2gg7HPzTFCC483wFzHnQyGSHFrZKEk30/EkWWufmKhmdWb5F4BKv0
         W54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353764; x=1779958564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GyuTyTzTUt+3jxkO4NHCcRAN9xNtTB9KsQFIwobBOao=;
        b=el3yGUbJSAWhVR4aK8uew15HvS+TZptFu7xiarxQLdj26bDiAkkPolrJWUq14q0M5h
         lWYcZ6MTmvPKNr+w2ahE3CE8SPaXGdjXw2dWJc/rF2e84vnbPJOVB1KQL/wKdm+LyYRX
         Lkproq14RLOtDl8YcK8TLcxBFgDZga3JM0sr1zyo7kruh+IKVCh0X+66Ju/adm8054Ra
         BQSt+XGq2AWLw73Kyo2LPLfftvZJApbd+lMdL7X/CjL7PJd76Jf1hU3Lphsr2SQLZokj
         KHlyk3ye6Xv8nIIPJ8dN8hoAcq/ik6C0g9x/0mKHKjHCio0pwhnFBmWx+MOi3DBn4qOJ
         2dAw==
X-Gm-Message-State: AOJu0YxJDakZYTxbPAVoF1x6hdK1zUmG6HGdIV6z7EhjVepvOuWzI1Ps
	ZAy6yGL6Zvk5mauWpAcohO3bs0qBS59n3nhcTXCBf+weyk5gZphRHcVE5mNw4NgFSPG5IFFs9zH
	cn1CnY5MsvNCgjk/A+eRum1Ex71PJeKIdwQ==
X-Gm-Gg: Acq92OHlhavwyo83sLUQUE223yDiW+S75luV1JXqzUnLtDM6BWDrUR/6DccLtBokcha
	NSLXzYauY1zBjvynYf6xUHhQ6qfA8wcU6QefTqlboGhYlpSWJ1UX2J5eWSdYzXTqIYZpTagxgk3
	vwNQyublr7GB15GpJ03hsNOkEBkl3/Tzte3iZsAt9+ni7CWcgbY7nEkbBcLpG0RDkMbKdmK3NsJ
	52xS7vubL/Yu1iL2NTXq9Pv+DfhT1pgNSD0Q+iblIRSqLL5hWgoXCgiwALQd97wWxSWAbCk6awY
	VPgA
X-Received: by 2002:a05:600c:4f8f:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-4903603536emr24906625e9.3.1779353763882; Thu, 21 May 2026
 01:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515233839.86829-1-masashi.honma@gmail.com>
 <20260515233839.86829-5-masashi.honma@gmail.com> <46554aec366d99839894bbcca066daa3450df9d2.camel@sipsolutions.net>
In-Reply-To: <46554aec366d99839894bbcca066daa3450df9d2.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Date: Thu, 21 May 2026 17:55:52 +0900
X-Gm-Features: AVHnY4IYiyKJf7u6x-UzomHHXrx7R-lahalhSntyeEaM-h3YsSTaTduVVWER1A4
Message-ID: <CAFk-A4k-0f_GjVZy4VcqdR4vg3tKyyjakcAAzQRoFaX2G3nkMQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] wifi: mac80211: Fix overread in PREP frame processing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36751-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 82F135A238A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you, fixed other _size_of functions as well.

2026=E5=B9=B45=E6=9C=8820=E6=97=A5(=E6=B0=B4) 20:16 Johannes Berg <johannes=
@sipsolutions.net>:
>
> On Sat, 2026-05-16 at 08:38 +0900, Masashi Honma wrote:
> >
> > +/* IEEE Std 802.11-2016 9.4.2.114 PREP element */
> > +static inline bool ieee80211_mesh_prep_size_ok(const u8 *pos, u8 elen)
> > +{
> ...
>
> > +     if (elen !=3D needed)
> > +             return false;
> > +
> > +     return true;
>
> nit: maybe just "return elen =3D=3D needed;"
>
> johannes

