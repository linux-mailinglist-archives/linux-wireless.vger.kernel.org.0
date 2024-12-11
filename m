Return-Path: <linux-wireless+bounces-16269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F8B9ED4A3
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD099282887
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDB6209660;
	Wed, 11 Dec 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHB7gZBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC4202F8B
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941248; cv=none; b=KZDvxs4ichZ9eK1BMfxsg0HI7Yc0yTSpDyjwEIC6nPPfQTUaZ35wT/j9O14gPt1gPVqYkbEU+Y49Ab7SuKY3fMIVOTe9lyDrtn9cjMQPDZF1zpaJmvj86UVtwE5iQ/mvHtcqF2KrMksvjqx9XmiNZ+iyiZsAJ+t5txvIsCWxju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941248; c=relaxed/simple;
	bh=78QZdd6X8zm+faGrxMfqRp5lVZ0ExehFKUMtptgXguI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=anzLkHA0gKDeiS371tEQyF6OFaz5KpFrrJJi8CBe9jEol0q5Dp6DGrySYC2Pw/u03U30LPEF7CDWuS/DxCNZmFhB9usQdH6b1O57pI9EKGwtqlVFbKQ4RAdDlEsVNvrza8hsBLwfpxL4+U6Fw7Zia5Im3UkorjZSMqhhUfMu9Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHB7gZBL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ed193c9eso3250716b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 10:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733941245; x=1734546045; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:reply-to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nfhOsoAmalBsZqFwjyIZUECadP9++XwufGxfbG6Lk08=;
        b=MHB7gZBLgxyalEcHupAIdLrIuixQ7F0smSZymjE2gleq185BDpJBLtsxGSRT90EJ75
         OKMTVJAVqm0JaMOpe5SOlR5iID7mSfGbWQRE3MoNi0xJShhXn0AjoGGSdH7dztqQAzlw
         DX5WvoHB8LJvso3/T4bwRvS4dpiQqw6Llp7lyuzIb0saKr+DCXwY7IA0u+1zzWrCcj+E
         hB7pcbiLm54Apzx6UJqX8xCb9EVHI398NX+zgi7wJWVTDLWPgiyYkWJRLo7dEKLUBW51
         JZ9e0Hfe8yhe7M63mZJQndaLeV3v1Pd8EzOhEKNmyCdf4ot/oPmS29VbM+xmbMsZWJJb
         TVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941245; x=1734546045;
        h=mime-version:user-agent:content-transfer-encoding:date:to:reply-to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfhOsoAmalBsZqFwjyIZUECadP9++XwufGxfbG6Lk08=;
        b=ACTFmZajn+x0O+o0VK2V2vyB6jaJL8wKIoZo4AcfOoVAcUotMA0/FlO4XQXo4Bg5P1
         cq9O9VLrTZzvmOhQTGnySREIrdM/Twyqxbsj8PlFWfFRin3qHcJmh7CO7c6mBGTnVSwy
         OnuXxwcjhcnBwIfzHh8GPsa3jyHrIYjdzH8IgcFcretQWig10FFF89DuoJ8UXjkEeMoZ
         SRrxZ0VklFbbKaHyA/Y7pCrOZlnY/XcWl3HNc/DI+su84goLOqpUzkIJht3IYjTsxWQw
         0ihHGhBKXfmZRjwLMibVQ8olkGsSsbUXhVztWSE4OQwRaRn03IGgJh8GIya6H4p/OmvJ
         dFmQ==
X-Gm-Message-State: AOJu0YwinjvcUKXuggWjUc5nQkSjK6YplGtITmkytXiP5GfxRXiT7z7E
	+qSPETnvFj8xyKTjshpwrM7xmtzLJB0evqsVygwyfon7AQ4h9m6tx7Om4PQr
X-Gm-Gg: ASbGncu8fCII/cNlRWyQKISyj3LxDt1ilSZzKoJNL7zh3rV9/xhzvP6tUFwCRkoqOdj
	zk9PDHIlY3fR2wF7f+iSD8LARlBVvunv8MnkMis6O2Nni243Pw10Bprg+jZGs5DkYrpPRxTRSDq
	ToTVHNAKIttGt7EnM0Tys1jHqCr4GWPJiH+ZVFa4h9gsCt7ZLKVT+Ofsnq244VMTx67sTiC2tt8
	kzCtvOYm8b4qBAccShjXalw+elH9rdo41me8uZXL0nSPDjM5e4I444fArU=
X-Google-Smtp-Source: AGHT+IGVJvwrItcwwiC1TSaSsfNqExLnf6jy949LXq9fw3jYAMDv230dNLxt1gPoZyBwTYn7GqBwGw==
X-Received: by 2002:a05:6a20:db0c:b0:1e1:cba5:8e1b with SMTP id adf61e73a8af0-1e1ceae4121mr298769637.18.1733941244609;
        Wed, 11 Dec 2024 10:20:44 -0800 (PST)
Received: from [192.168.4.35] ([150.107.174.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd37745f99sm7751007a12.10.2024.12.11.10.20.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:20:44 -0800 (PST)
Message-ID: <9cd0b40bdede35982117a0d40e01a17b6a8a0239.camel@gmail.com>
Subject: Realtek Wifi Keeps dropping under high load
From: John Shand <jshand2013@gmail.com>
Reply-To: jshand2013@gmail.com
To: linux-wireless@vger.kernel.org
Date: Thu, 12 Dec 2024 07:20:39 +1300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi guys, i have run into a problem with my realtek wifi hardware

OS Details:

Operating System: openSUSE Tumbleweed 20241209
KDE Plasma Version: 6.2.4
KDE Frameworks Version: 6.8.0
Qt Version: 6.8.1
Kernel Version: 6.12.4-1.g16f6531-default (64-bit)
Graphics Platform: Wayland
Processors: 12 =C3=97 Intel=C2=AE Core=E2=84=A2 7 150U
Memory: 15.3 GiB of RAM
Graphics Processor: Mesa Intel=C2=AE Graphics
Manufacturer: Dell Inc.
Product Name: Inspiron 16 5640

Problem Found:

When using steam from valve to download all your games under default
settings causes connection dropping due to excessive download speeds ie
200MB upwards.  if i set download speed limit to for example 10MB, the
problem goes away.

The bugreport link is
https://bugzilla.opensuse.org/show_bug.cgi?id=3D1234360

Many thanks

