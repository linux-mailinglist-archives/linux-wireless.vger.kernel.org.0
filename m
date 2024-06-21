Return-Path: <linux-wireless+bounces-9428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029F0912275
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 12:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DAC1C23D45
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C0776034;
	Fri, 21 Jun 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b="CpXoZXkv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0EB84D04
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965875; cv=none; b=mWXsWwBjzJDTg5CSJmL95oTBg3FW74iU4NSHgxnXH0zfD2AZv4AvyhIYGx/F+Bu6ItzJBPEMGshmu0FtM4uMv4QAkGSUx6O4bhFKu3rczcQBIBfOa6xmBIQow3+JvI+TICqLZZEU1v5/732ZXdDJISx0xELPmhnx/ytkKuxLGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965875; c=relaxed/simple;
	bh=FBOHhE1MiOyev8w2dqWF2XtGTCQMoiHwW0KiP/RGv9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/Jx1IWqPRHcAJTISdZfhNnQUMhjRE5LiQI+VqjCHiid8ePLnlvdU5FaJR6j75g42LqdcWZK8vnNLAGI2zJdHOBlIQy7IFP6I/T/nD6zMdp+GgKYIgB3qqTAj8mzCG2HTp9XEm7PDc+ebo3l1IUl+EwfO35V7sP2/WUCQwM4bcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com; spf=pass smtp.mailfrom=citymesh.com; dkim=pass (2048-bit key) header.d=citymesh.com header.i=@citymesh.com header.b=CpXoZXkv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citymesh.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citymesh.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d1d614049so2242973a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citymesh.com; s=google; t=1718965872; x=1719570672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBOHhE1MiOyev8w2dqWF2XtGTCQMoiHwW0KiP/RGv9Q=;
        b=CpXoZXkvMeGmLD3Ni7y5MtAPIs4wT9mU2sHPEBfrReOjPosE5VHsRYXHFxjGoCBNWH
         t+OzbxXZSgwtF3LTDVyJgdW4LiaqDSPGU9BwbPn3/L1eFAS4AN1iq+XRkbeCp/4xZM/H
         hM7QVLoRNxPYkPWY6aUFDYGfZwAucsWIapWONJ15jRpgf+6GSjdHsauItVJsZj+YMCi/
         CJNr0vXGWI/5qtt6nFHgBAsYSwnSB1xAcbkEfuamR4PElF6hc466vC7WLqaVmVS1OCZO
         NsLFwlMl7AYt6tG7Y1v3oMqA7/J5F7j425M2+zZHVqDoVhl2alzGT+tSIBonU29Br32I
         YtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718965872; x=1719570672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBOHhE1MiOyev8w2dqWF2XtGTCQMoiHwW0KiP/RGv9Q=;
        b=FJmSra8pn9Y4mzjysS2dXde+si22LvVjABkRBCJwhJXElS6Nd72vl4R6X8lFY6Pasq
         yD/XKvp5ak+xxaqt88CBTY5Ld3lYI8TFC3GmiWn4C+rlvNClqiW7q5y8Zwv8UgvPecfk
         u6fiWv9wtZsMrEpc60x5hnKMguWuHLObgx8GikCPnGl932bUXDjdwuNYrviiOryz6B8z
         kw8yRAdzVl+4iVjo3EoQDdaNgkkq5LDJCjNVJj+6nJilPg0igEE0xTGzWtXD2ANp/bqM
         MXwiusVx1Omp7JLhnZP03Rb58PZOy4Ojs7PxrkicWK9aYLu7Ifty6a6Rae9SG3Ki1hYF
         nCBg==
X-Forwarded-Encrypted: i=1; AJvYcCVMz/MrKu1ITW5qP83YYUDnicrSkRw4yM0ZYvOKWlYODPi93P+DKaV02Hv75leK9p6ZK0YnPGeygsTVBXBmfWc1frwlixEZYuhoYowwQ+g=
X-Gm-Message-State: AOJu0Yys2fmoyTrUkCxyEGaljqhJ4ia14tb2xMioFIPE6sjB72mZqi9N
	803ohxznXMJVJ+qzENZo4JBcZJez73J7C7PQSfp02/7/VJ97o7GwYd5CBrFsbMgm78EDbO74tUW
	mTQXCzze9KvyTay2dHTIrNj4vG99GXIL3CNiqNQ==
X-Google-Smtp-Source: AGHT+IGKLwy1FF45ea+S+UHbyw7AC3VPyEGJzQG+CliR1MRDmrMbiusd4p08/41SD2+uJ4amap86quQYp6/RCLP2Oj4=
X-Received: by 2002:a50:bb44:0:b0:57c:c2b6:176d with SMTP id
 4fb4d7f45d1cf-57d07ed3a19mr5254671a12.32.1718965871951; Fri, 21 Jun 2024
 03:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
 <efc8cdc0853a921ce4dad1a36b084608fe0b01a8.camel@sipsolutions.net>
 <CAPh3n834eg1_+gmh_LMTQnc95aLBWNVOANjZsMap=_szOY2nHQ@mail.gmail.com> <83fcb33e3fadb457466126255297899fbc4186f8.camel@sipsolutions.net>
In-Reply-To: <83fcb33e3fadb457466126255297899fbc4186f8.camel@sipsolutions.net>
From: Koen Vandeputte <koen.vandeputte@citymesh.com>
Date: Fri, 21 Jun 2024 12:31:00 +0200
Message-ID: <CAPh3n80PF4NULjKJVVMEiGuuJZhLQszYSTCv+f6e9LfVJbKesw@mail.gmail.com>
Subject: Re: ieee80211.h virtual_map splat
To: Johannes Berg <johannes@sipsolutions.net>
Cc: quic_jjohnson@quicinc.com, ath10k@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 11:30=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>
> > will this one get backported also?
>
> Why? It's not even a bug.
>
> johannes

Because without this patch, it produces a splat on kernel 6.6 (which
is an LTS) at least ? :-)

