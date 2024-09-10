Return-Path: <linux-wireless+bounces-12742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7282F972D6C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6E01F260A0
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6B188012;
	Tue, 10 Sep 2024 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3ZOJiN3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B111862B8
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960217; cv=none; b=hZO250N/cKvYmfxrPeDY3wvkFJhsX8zXv28nzVVSxmLm9BQG+GKMbaJPiiQIMkqyY8P6PO6FfTKBpV+lP1y7n2oop45ZwjdFIDsKUwH9r8+lzCXmPt5UgNj4KLdc5S4oV0y+a4cgga8qmSFKy6m/LVfTas6oHxR16dpbyXv1RLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960217; c=relaxed/simple;
	bh=RHKfWvlyDATplkCyalLpaVoYdWyYE4JsNzmkEjE+L0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJGgHtbbK/S+EgwUpEThXOFkIm49g9dKez0zftnaNvmV2/JAtsbowcAgGtXkgDEdALthFQ197iin3o2eLRKh5fsKpkzW+ZpbO66SgkgOlEytPL/UX1u3s226IrWhZC9DmJ2m9V6QwFxyI7UawamGPxIhOIS1IPLpBsPUy/x7nnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3ZOJiN3; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1a8ae00f5eso5438734276.0
        for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 02:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725960215; x=1726565015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RHKfWvlyDATplkCyalLpaVoYdWyYE4JsNzmkEjE+L0s=;
        b=f3ZOJiN3bMxMryO/l+YzS7oJZE1dhYPh4C2s+wbKDvCeWnwYckzjsfnRQW0qtayYnA
         M1/t/m1jDSX/54FIdGAhzfYO8ebau7/vZUDjF/ftlyC2FDJUCJmtOR1vsBBam4mpGFDZ
         PwH7TlkId0fP3guAqmueiukQT9m2l2lkWbzFHGW4xJM2nCZBPPkVf+ngcGuvJMz0ZFeg
         hxRmUqFUEHpgYW/TdU2WDeoEwaVa5ESHe62iMNijDYx8d0n1sHan4K5bp6CED/0GBhGd
         cb7V9NZPodCKerYY8fc0Egq3AtcqqEfI3EpLP5jpEdRg+K8G0Ob4dcuXk/lxZj5jctCC
         jj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725960215; x=1726565015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHKfWvlyDATplkCyalLpaVoYdWyYE4JsNzmkEjE+L0s=;
        b=ePt48IVoDEJoewmmxqJe88bMPvoiLld7/7+5n+inSVkPESAPc0eZdkFB/lEgQd43Hf
         x2uRrEmTDPtlZgSIg56CJCwsE/A+W7SUMHQdVpHJdBfF2FHDINZE2MrEdcINbl9tkUCf
         ybyxdI0pwqoirXpfGZ0I2hkicR9JmZQ3hhJK3G0rhx7JC+QNQyJmBYOp9txq8QJYYYh4
         KWGVLJj3wxYe9lJ9b83kUmweiIC+U+kDVoENtwGI0BlT/OK3zbyvz3MH9+0xBVpk7RYn
         G0NrX48x3RQXK2MtKoIO3gdbUXPykFho9LHnAbvPB8cqKMF2XHNltxHouJgjbOYEdwmK
         umKQ==
X-Gm-Message-State: AOJu0Yzgx8htFJOgo8STCaaV/hjJUbgZL04jfrq3u+4ZVtsONt4iZay9
	SCsD6j5K/Q3rwEV89vQr9IaCWwmkv3rcnVcwPe+cGh+B965+wsg+kwkykzjpi/BIukMKopqWZUb
	lM5hrMU4nz2QH3QXtyVWP6uKwr1Ah8Bo81gA=
X-Google-Smtp-Source: AGHT+IFa61QRgfsiOf9BDA5CrcYUn1VdOL7jl6IcZS0vPsKkLHHtnQKOh4PPaSk6RPhOu5rvr7HTs/mJnSuELrHplxE=
X-Received: by 2002:a05:6902:230d:b0:e1a:90f4:c1f6 with SMTP id
 3f1490d57ef6-e1d34899313mr14831493276.27.1725960214744; Tue, 10 Sep 2024
 02:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com>
 <9ada34661b93fa5dfe3b0c66816a62c1a27f22a3.camel@intel.com> <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
In-Reply-To: <CAP-bSRZm4CyxY1VdtWvZRcfLMwc3njd3OTSd446Q5dcSfjJY=Q@mail.gmail.com>
From: Chris Bainbridge <chris.bainbridge@gmail.com>
Date: Tue, 10 Sep 2024 10:23:23 +0100
Message-ID: <CAP-bSRbon4O=DCLHvOZHm452Svc3-gsZ133Jn7-TFt8f_Y1CFA@mail.gmail.com>
Subject: Re: [REGRESSION] iwlwifi resume error, bisected
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, 
	"Berg, Johannes" <johannes.berg@intel.com>, 
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Sept 2024 at 22:21, Chris Bainbridge
<chris.bainbridge@gmail.com> wrote:
>
> It's possible that the
> HP BIOS turns off the wifi when suspended on battery power

This is not the case. Suspending while on battery power and then
resuming (still on battery power) works without error.

If the laptop is docked, and powered via both the dock USB-C *and* a
mains PSU on the separate PSU connector, then suspended, then either
the dock or the PSU are disconnected, then the error happens on
resume, even though the laptop is continuously mains powered via the
other power supply. It appears there's something about a powered
dock/PSU unplug event while suspended that causes the error, as
opposed to just being suspended while running on battery.

