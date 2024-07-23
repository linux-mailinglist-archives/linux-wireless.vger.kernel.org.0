Return-Path: <linux-wireless+bounces-10462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0165E93A980
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09FE2842F6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2024 22:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BAE25760;
	Tue, 23 Jul 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="bsm7d/Er"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80728E8
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775268; cv=none; b=nxfRycvdBopAIA3Zbz6MYjSuBSfMhGf2RH3Jw1yCQbUPq8JBsLLxDRhs8dKq+HRTuCo9s+IOWxBO8m5tdM6CBpjbb2QXPtLkjdPRQMPc9nWhdkDGV06taL3nGMpkCoU7oGpO72VtAgAYqvi/8XAGkfwQamhF8Z7+/OmcvpLxrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775268; c=relaxed/simple;
	bh=VYlgYqkZeIdrFki6QqRWOIsGTyAHnP066oVKUjDpUXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ULN9SLY/0+zilUjvqkvpi4pcZgNQld9OC+by4fna5jgQTKQLBZRid1UBOOy4cBuCkjfYEpIJpPpxCKwrl/b3ziHwcXVg6ux5W7dRiEkxhdSD2xS6zaxnqMuMZAvBc3LRVPErg2Rt5upLlzRUChTBVlOdNbIQt3hSzOtVKJTUMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=bsm7d/Er; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-75cda3719efso862926a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jul 2024 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1721775266; x=1722380066; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ep2ebY/LgQ+HSlIevoblsK15p/7sA/ZLC1oJoiyHAv0=;
        b=bsm7d/ErIrQ9HpbtV5Clv2wGK4/dJXaVCIIWexZHWGThM/du8mHyOrAXXNvNeaoDVC
         52F/VkvR4ysuHxSNHhQDlS4dXSEcylCeStTLySaB2gkMjTGPF41GDrArSu13+VzoRGYT
         FeCv1Korqi/LgNyt9ng947l9Ol/xNmpqmp/e7MNLoZK5fvgxCUFm9vXI+bgBzFnTJC5r
         d5EKHWbuE4C7X+6i7bkOuDe4FLVG63R7ypaWvs7aQHqkxreF2liNWYyeMKa6SpNNj2lj
         KsKaOMBNYbit6aolUjYvexogPcyLBS1Dp9hNHuafueR/K8T28DZGJ+E7tf4ZPzNLsZok
         iFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721775266; x=1722380066;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ep2ebY/LgQ+HSlIevoblsK15p/7sA/ZLC1oJoiyHAv0=;
        b=f8nrSIpocEBfFUKZfP3OAli0TsD3c3C4Bj8+avYD/VAovUS2lojZE2tVqqFfLyk4No
         j7AXnwHJ9Fggot0YpWMVeabt9RecLmjHMNQGUAgz7ftUf3VokmnBqjKdhWLlBCDZWTqg
         rJLBbJg3arFSDoccU2wxCuhw8e2jOH69aGlIb7vdeCEvltOxNDgRo0e+3PWnKrOWZlfl
         If1KMWz+aSHr7eRzZ2PT86T4MHxHGTcosO6IzH62fGizQSkmfSbOudQtK9p5Akpo6pOn
         bhWKZ6B41Q9FDJR+/ErN/ILcGvzNR6WdB2e98KrnKqDeVAoifEaR/LaRZ3ULePCGkgEu
         5SnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpgNfIbLWIq8I3GRBM2vvBt+QdHzzGCwGZrugniTQlJ9QCljL4/Y9+SZ07gEfOP1UzXsWSz/ijOWjZnEEiWWiiO9rEH4IxCvcDN2r1IWs=
X-Gm-Message-State: AOJu0YwnpviyK7fqg2V54Y0iS8PVyyK1kXDwWTpOu2WPFExtVdmNqBS3
	1DzKCkbD5fsUYQ/8bHn0NmH5r3OMiI/PKozf9zApj9TKnqZNYCD7Ga/MOqQWScjCsZbr1/yfHfG
	ESQ5hRsA9jj+k7j3Eu1Gt9I+A821LdIGxazxXrU8sf2lhmj6vZg==
X-Google-Smtp-Source: AGHT+IH+ElKzqkLIg26Sar8bilbRkscy97e39d2IcoV+9SVcpAFhNKNU4lCKEWQdlFr7x1JEQms5Z7YONAX6cIFutS8=
X-Received: by 2002:a05:6a20:3942:b0:1be:cea:d381 with SMTP id
 adf61e73a8af0-1c46196dd75mr689855637.18.1721775266084; Tue, 23 Jul 2024
 15:54:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-219084-13339@https.bugzilla.kernel.org/> <bug-219084-13339-lIpQrjSBmB@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219084-13339-lIpQrjSBmB@https.bugzilla.kernel.org/>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 23 Jul 2024 23:54:15 +0100
Message-ID: <CAHbf0-HOS-jdRGvJOBmEgaaox3PDbDSTgnnZkZF9pz37Bmh2iw@mail.gmail.com>
Subject: Fwd: [Bug 219084] RIP: 0010:mt792x_mac_link_bss_remove+0x2b/0x100
To: sean.wang@mediatek.com, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean

I bisected this bug back to one of your commits

Would you mind taking a look

Thanks

Mike

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Tue, 23 Jul 2024 at 09:33
Subject: [Bug 219084] RIP: 0010:mt792x_mac_link_bss_remove+0x2b/0x100
To: <mike@fireburn.co.uk>


https://bugzilla.kernel.org/show_bug.cgi?id=219084

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Sean Wang, is not on this bug tracker, so it would be nice if you sent your
findings to  linux-wireless@vger.kernel.org and sean.wang@mediatek.com

Thanks.

--
You may reply to this email to add a comment.

You are receiving this mail because:
You reported the bug.

