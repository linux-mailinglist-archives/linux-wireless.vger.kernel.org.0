Return-Path: <linux-wireless+bounces-13006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3600E97C5AF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C131E2818F9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF41CABA;
	Thu, 19 Sep 2024 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="KXaYadC+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E218C938
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726733731; cv=none; b=Hm4Ssjj6OrlzC/JD4kJ7sWMsDUvr+LjLak5vlICrTlK0Q3wSz06fGv9pzTv9Y6bY20h6rB5L+L+ufhWnXIwBNoesdM5zbtZbwRUpkjDinRWag8g5TVADf/zCm1IT6rQRur4SLNZRFHoheWWelZWIAZVr2DsxSUq5N+Ibgri3Hik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726733731; c=relaxed/simple;
	bh=TQWjZ+duUUwF2sZYOa+ZbGQQiqu6lWRYNoxHECrnZiE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To; b=MPUcNpQ8PbbTT0hU6XM7oS3w/qfx4UjPvqwZ70WHFltoWpbnaCZ9QLTqiSFwLk3W7gF36SLJDAFDAVVgl1ewvJP1o0a+mjWI7K+RzI5JEE4oUMdtAxT0XyRBR9deFayJVwyq4HQytxLIscki1svALxFmqXUZoNEFQw9Hlj9nTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=KXaYadC+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so4751105e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1726733725; x=1727338525; darn=vger.kernel.org;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ufV1ksORYrGcczHqQg6kaw9jx/02+oC1nfRvJmBFo+4=;
        b=KXaYadC+305TVOuY7c08yEcZho/EjUUmQUGCX2raqp3Q1kZs3uS2Piw+RSZKhjbx6n
         uoJmHwXWvotAfJRwU/p+ql0mH0krvsl3p8FKnj18bOcuPtl/ktbzkiNxnilu6/qQ3QiA
         aR3lffyMWiv/risj2gGc8JhbFlhxWPxYZUaGISysGJf5umU5DPkdgimD+DNnV859ZOto
         BwYIHkQHMXhA0f+b5NnYnFxCBZK1jS09WyjcvzLtwMGHoqfsoakNSmTEb3kNYbC58etx
         aftrrDi3yazs2drYOHWizjcb3/cBipCLL2gkNzmU8d8W2HidtBDn5s21AF85K9b115uR
         MUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726733725; x=1727338525;
        h=to:from:subject:message-id:date:content-transfer-encoding
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufV1ksORYrGcczHqQg6kaw9jx/02+oC1nfRvJmBFo+4=;
        b=fdSaPrMF+LJinmTMJ0UwBvtrhQ5EHKtIlFz1vvoA1T7clvQap3+j5nGc6Y4/m1dUAl
         cM1mCGpcwADdbk2XVxc1kLDz1ncgu5rEPA7mOUHPQ+fCw/smQSSZyYretKFBHZZWktZK
         AnrBCA4CMejPwVk2j3PmsCvRXLxHkc6f9xJ61CUGc83i/JCKq8FttWHofJwyRKNqSMCl
         O/cyh6ASODQ9I/FZV1xWhgT8Bv+X7lH9yZC/TwcgjIsWYJXErDsrXeHB98dnhpBh1nr1
         jkZRTiVMtOpjRi4w2qjVOmWlc8xa//ETR2H0HjK3odrkNUrEGOT+e/IAK7VAjY2S+8o+
         DgjA==
X-Gm-Message-State: AOJu0YwnwA+MwK8gD+GwT7F7WAD/bOlda7Gn+A+ufSkq3GgAYhiL5fzt
	ZilliG0jpxCCGnbPDdPLRBFu1qwEHgKQkzsJvp+AAlQbKOJhrUnlE88ueFETHvws54xt14kzh5n
	5
X-Google-Smtp-Source: AGHT+IHJjzt5P8r2Ru/qlHCGbfV17wvUAAousfLn5zrp4YFjWCqnHzS43NY4Vwph9NxcIjmzcUE+dg==
X-Received: by 2002:a05:600c:19c8:b0:42c:b187:bde9 with SMTP id 5b1f17b1804b1-42cdb579f3cmr193940075e9.30.1726733725495;
        Thu, 19 Sep 2024 01:15:25 -0700 (PDT)
Received: from localhost ([2a01:e0a:0:2100:21ef:6d50:511c:bd79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e6bc2c4b8sm63940375e9.0.2024.09.19.01.15.24
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Sep 2024 10:15:24 +0200
Message-Id: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
Subject: Missing wiphy lock in ieee80211_color_collision_detection_work
From: "Nicolas Escande" <nescande@freebox.fr>
To: <linux-wireless@vger.kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049

Hi guys,

Running a pretty hacked up kernel under lockdep, I've had a few splats like=
 this

	[   75.453180] Call trace:
	[   75.455595]  cfg80211_bss_color_notify+0x220/0x260
	[   75.460341]  ieee80211_color_collision_detection_work+0x4c/0x5c
	[   75.466205]  process_one_work+0x434/0x6ec
	[   75.470169]  worker_thread+0x9c/0x624
	[   75.473794]  kthread+0x1a4/0x1ac
	[   75.476987]  ret_from_fork+0x10/0x20

Which shows we are calling cfg80211_obss_color_collision_notify and thus
cfg80211_bss_color_notify from ieee80211_color_collision_detection_work wit=
hout
holding the wiphy's mtx.

It seems that we should either explicitely lock the phy using something lik=
e

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 847304a3a29a..481e1550cb21 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4833,9 +4833,12 @@ void ieee80211_color_collision_detection_work(struct=
 work_struct *work)
 		container_of(delayed_work, struct ieee80211_link_data,
 			     color_collision_detect_work);
 	struct ieee80211_sub_if_data *sdata =3D link->sdata;
+	struct ieee80211_local *local =3D sdata->local;
=20
+	wiphy_lock(local->hw.wiphy);
 	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
 					     link->link_id);
+	wiphy_unlock(local->hw.wiphy);
 }
=20
 void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)

Or switch to using the wiphy_work_queue infrastructure.

Did I miss something ? Which one should we do ? I'm not sure of all the
implications of switching to the wiphy work queue and why it did not get
converted like the color_change_finalize_work stuff ?

