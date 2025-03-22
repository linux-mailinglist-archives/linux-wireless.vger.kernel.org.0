Return-Path: <linux-wireless+bounces-20696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21776A6C9FF
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 12:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D6D482B5B
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Mar 2025 11:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50D620F093;
	Sat, 22 Mar 2025 11:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9pFs0gY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115AB20C019;
	Sat, 22 Mar 2025 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644331; cv=none; b=cpemEtaVvmEVUIGAP9hci4lbjYeaHIiPe4eC8n4npIUe0REepC42z3EtkHRzCyacyPnX21rFOsUzvYrE9Ac6LxwpLhUqc7n1FGX8cimrMvx7utTUmNMn8lOx6xE7PdNCi5MENiRdSmI1Lq1mOT2o9vAtt/BWgzW96uyrqAyMP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644331; c=relaxed/simple;
	bh=JrrN3txU/9ksUlwhCYnysfKDPc0BcxepXJy/n0PP12E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUt/d2ie9ZAMTAc2HB7DYBxU+FtliCrd/xf5O6St7dywUoRS6L2p+6YE1MDT94i6gSddA3orwyrfZ0hLw4OsNRJGphmQavTzG/M9SC1qXGXWYU2p+W4siU0cXuYf+ng2WF6c/o1F4r74ae/Up2woZgcnbjXG+HleiVcUhVaayvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9pFs0gY; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e53c9035003so2352204276.2;
        Sat, 22 Mar 2025 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742644329; x=1743249129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/38SpXX+t/RyNGR7UIeutSrg3vd9sf/spj62Z5/lVQ=;
        b=I9pFs0gYEh2lT+6KaPE37KnTkR/aEQ9enjG3VjbFlJWsR3o+UCn70RaoXtvtk7USH2
         +5F7FK4y42+t6gh021D+Ss22LN2cPRNZ7CWU3+7gxqP0fIlmZGXMlr9oIirr5fXmgP9I
         k3/kxHrcTKamHrsvp8UU4M3EfmtR5oyTkVUt7UKAZ1M77MUoqvDc2gclyEo49bB35mmy
         Fy45lh8oS6Bjz0uxIEFHjpktDt8K4ivyZalzhHxuQ/LE5B/bQVaui3yqripfkNQCYtAF
         CQTvI68ZhrLGTOmEd7XPO1Mf00/uIT5DAAKx9a8+8fHUY5yto5y10R3joRxFBYRe9fPw
         2xSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742644329; x=1743249129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/38SpXX+t/RyNGR7UIeutSrg3vd9sf/spj62Z5/lVQ=;
        b=ZNhznluGLKd6i17k+F9Qrl4EaG6erIxCKZqXkBwAlQMw8Qo4j8Ppr5aN34+UXdkiou
         YbNRsqKwZIAhAQ1ErlotJNkd4bzyrl9ylojDgR+xDEm+zB1jV1fmMcp1t6rZXd0xDb+g
         IDJ6haVkV8c2kP3MgjR11/CtFV9e0jZd/4ttsPXuKBF+xFvXBhn811sSEAYaNesf+yEw
         FBhwrfAwRqkd0gbz4OBQqLE1Qc8AC9Fs00y+8w6g2GXMdv3MNdSizJhv6gSndljg8fAM
         X9n2pPFw2Df8pcsPfzPbG+cOLOC0b9Q26EM5tjEI9s0+K7tgnNVBId6VYZW8Lk7zhja/
         1j5w==
X-Forwarded-Encrypted: i=1; AJvYcCVI/6yRbee5oDUx5bjmwad4DDWAM2xnP7c7H3h8Fd3ADn3KQecQEpze7NNWQlaUgarqIcAOz8nOWwmWP0I5Fkc=@vger.kernel.org, AJvYcCWlNO0YPytp2Wes9wbgUVMvMLy5LB1vSfrI1uVnTaYvHJRgtVcK8Fwd4ogYGqaYz8S/evxprkDG9oW9FCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJwUbhZEuG5LDumtooodaR8gNYJBO89JNVEk1WbzOsuX4hZhWW
	cBI35T7UUPH3so/luXdhab8Rnw/ZpyVfknEu/2O0NgtImersP2KgUd76T33kqGSp7tQ5dqIqjLo
	dmKrEDHPP2yVn/mGvCzhGIhhD5vM=
X-Gm-Gg: ASbGncsRFXt0ZLl+t0yoTTStvFgbRGDsqHay5WPJXpLpUqBjvk2iBBsp/iCkc6yFmAm
	f0XDrDamu5pF48FetcD+8ipFaWL0Y1gfJt3oJ3qX6yM86KvD7NwxU6s8ApbAiPbGbEw41blNYnE
	JxJ/jTeG99aHwLhf7Ac0enDmA/
X-Google-Smtp-Source: AGHT+IHEIH+TD7S8LIB0pgaC3Heq4ilCGl8dSsQ4Y2jB1WCnC9MH4oZaTqBRO+rXtE+U3iicvoBJ0yr1yUCPg/w5PwU=
X-Received: by 2002:a05:6902:2845:b0:e60:5d76:f79d with SMTP id
 3f1490d57ef6-e66a4fd7596mr8057025276.43.1742644328776; Sat, 22 Mar 2025
 04:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320201914.48159-1-qasdev00@gmail.com>
In-Reply-To: <20250320201914.48159-1-qasdev00@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 22 Mar 2025 12:51:57 +0100
X-Gm-Features: AQ5f1JoRh53ceEml7E4eB4zyrreqx0RIlQoRBpJCDeq9YDF93pFOkWwS8Y7fB0k
Message-ID: <CAOiHx==UCeMQpywQJCLPQqipEW0tK9youRxdR5+_T1LuGp_EHA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in mt7996_mac_sta_add_links
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, chui-hao.chiu@mediatek.com, 
	Bo.Jiao@mediatek.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 20, 2025 at 9:19=E2=80=AFPM Qasim Ijaz <qasdev00@gmail.com> wro=
te:
>
> If link_conf_dereference_protected() or mt7996_vif_link()
> or link_sta_dereference_protected() fail the code jumps to
> the error_unlink label and returns ret which is uninitialised.
>
> Fix this by setting err before jumping to error_unlink.
>
> Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to ML=
O support")
> Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_=
add/sta_remove callbacks")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7996/main.c
> index 91c64e3a0860..78f7f1fc867e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, st=
ruct ieee80211_vif *vif,
>                         continue;
>
>                 link_conf =3D link_conf_dereference_protected(vif, link_i=
d);
> -               if (!link_conf)
> +               if (!link_conf) {
> +                       err =3D -EINVAL;
>                         goto error_unlink;
> +               }
>
>                 link =3D mt7996_vif_link(dev, vif, link_id);
> -               if (!link)
> +               if (!link) {
> +                       err =3D -EINVAL;
>                         goto error_unlink;
> +               }
>
>                 link_sta =3D link_sta_dereference_protected(sta, link_id)=
;
> -               if (!link_sta)
> +               if (!link_sta) {
> +                       err =3D -EINVAL

You are missing a semicolon at the end of the line.

To also do some bike shedding, you could initialize err (with 0 or
-EINVAL), and then change the err return to return err ? : -EINVAL;.
But your way has an explicit error code assigned to each failure, even
if it is always the same. So I won't claim my suggestion is better.

Best regards,
Jonas

