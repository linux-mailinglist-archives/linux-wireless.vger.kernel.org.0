Return-Path: <linux-wireless+bounces-16949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DAB9FF1E2
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 22:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8605818829BB
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15A51A83E0;
	Tue, 31 Dec 2024 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIAZrtyf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CEE18871D
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735681658; cv=none; b=oN1x4ZQey2IyC0yaR5+8XjJOgFFKyQ15pKnuN82dbnRqMIQU6zoEEFs+sKibT95hI1zCuyxosIAW4raYGT0LCdEqu4mpVWNRXE1kvPeGyJnkglBOlWQVi9fWk7Ia7FF6NbjR7EdXOtbYFGF1HJE+zWu/n8lgcWsb7x5GIvShisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735681658; c=relaxed/simple;
	bh=eMOuGzkMREkVWG49W9lq8tYjMA14B0Sf7+VYdzgkigA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cu60qcGraNo678LvarTx3IeEjspPsO/aKZbJi8AgGDOpntqo4y8z2TLKsOUmEA5WoXq7PLZN3KQZvzAzuS238yGVvc7JZSR08zbe8bVcJHsO5ctTr7F2gOXMV2lsksBhXA4zwlQ0MF9yrojtxgLVgQSoBVzLUXn1y1Zx+J3bGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIAZrtyf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so1472037366b.0
        for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 13:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735681655; x=1736286455; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pjj/zYjd8/OfCiSbvc+u05DecshFCs6NNjQx1IIb0S0=;
        b=BIAZrtyfsC1V4daLdjnf8ucTz1QbIqX+UX/CK+BsxQNJYvw8yvET8ka9QF9xcHzyuC
         vxdmBGZmnlfumypTNMxwqyVfZR6qgnnNCbTu76TsA8JkwEzcoQLArREVUK69m4YHitm2
         xBdYDrAtKCHwpC6kFUN2SuHX708ReImAV8z9yCmDmUpRhvsVPoM3ACAW98MQnM6I5JH1
         rC2i5mlW0v3ai4mxLyVCAts9uyVilVROiaZckthy21pTFCNZLoe9QBP7C0oXvByTBD6v
         /CNE+/A9UtnnFThz/IMGWEtF3I/CQ5Z/mjC/dgANRw+4SSjQT3+WsdEmkLYl28Tj8nkw
         xJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735681655; x=1736286455;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjj/zYjd8/OfCiSbvc+u05DecshFCs6NNjQx1IIb0S0=;
        b=MJ05jnnNBrQS20gsntX30jx57whte7u5iCz1s6cm8SqGRI0Lu4G6hr+yphIlv2OLXt
         0HcLuFZ8OvQWwwjgP00GTxbI1uoVDHXsHJJQu6rev9Ulz4fwIkhcX9m8ZJYKKwrjpr7M
         r/gYFTRXaPNFyOXSXV2XTlj/JSfcwdEkiohqItiwsikQD9IH1sHrw7gegYG77ti5YiHN
         7LqQzDzS0Tp/cpqjPW67PsVpx0r7xd4RSU3HDXJnY72uosMsmpAinP+Y7zuVVWfsxGaK
         QvOYrHLt4/UZ7iq6++PCEBOXQmGq9d+zgWWY+GQKUmUSFsslbw/LNnjgTzPKnP/U5PuQ
         CX3Q==
X-Gm-Message-State: AOJu0Yyq9447WaS89KPh8RwLHGIB4y8SqnCG4t2jrTFdeeiGw+LTBpXe
	RZxwAjmQcYOYvF3AjJ3dYeDTNX+S98a9PAm2h0Vffs6URRN7/jXcxntQSYgod+0YuMrH5IuchpI
	ekA2WmonxHuLVaB/g+lLoPFWymqGWjzvg
X-Gm-Gg: ASbGncuA0PZaH2uP+eJhCfKZv0mGoMaEoMuIKPr80o/K/AllAFFBm/CfAfBCtINRZqu
	xG2HbdR+Tr6KK74XDk/YlFJ4iJyC1GduU/92lomLNG4DA+ka+FfRBnwnwXz97cbKzJDbtcMvX
X-Google-Smtp-Source: AGHT+IG73rjttZogQABMCdNFsFwSGuvlJHVPDu/F8Bu2p6S7A430b3ZKTftfnZQPLWEGN1b3nAvru2ringixUIAP7a0=
X-Received: by 2002:a05:6402:4403:b0:5d0:d2ed:ebb with SMTP id
 4fb4d7f45d1cf-5d81dd83a72mr102550827a12.3.1735681654560; Tue, 31 Dec 2024
 13:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mark Baily <mark16829@gmail.com>
Date: Wed, 1 Jan 2025 08:47:23 +1100
Message-ID: <CACZGwE92CovpNv5qGefCKeffk+Y0zgqrhgq-pqOmQ8eDmXzA4w@mail.gmail.com>
Subject: MediaTek MT7922 or similar
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I have a Lenovo E14 AMD laptop with Ryzen 5625U processor and Mediatek
wifi / bluetooth adapter. The kernel module it uses is mt7921e.

Starting with the 6.11 and including the 6.12  Linux kernel, the
laptop won't resume from suspend with the bluetooth turned on. If I
turn bluetooth off, then the laptop resumes OK.

I have read a handful of other people's online posts with the same problem.
I am using the Debian Trixie 6.12 kernel but have tested with 6.11 and
6.12 on Debian bookworm - same issue.
I am using a fairly recent linux firmware package downloaded from
kernel.org (like from Dec 2024).

Just wondering when or if this is likely to be fixed as testing
upgrading from Debian bookworm (which works fine with the stock 6.1.0
kernel) to Debian Trixie results in this issue occurring.

Here is a snippet from my laptop's journalctl which seems relevant:

Dec 31 20:45:38 debian kernel: mt7921e 0000:02:00.0: Message 00020007
(seq 5) timeout
Dec 31 20:45:38 debian kernel: mt7921e 0000:02:00.0: PM:
dpm_run_callback(): pci_pm_resume returns -110
Dec 31 20:45:38 debian kernel: mt7921e 0000:02:00.0: PM: failed to
resume async: error -110

Thanks
Mark

