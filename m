Return-Path: <linux-wireless+bounces-30282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66CCEE2DB
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 11:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08F783001034
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D727A47F;
	Fri,  2 Jan 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNlVEOFi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98591C68F
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767350091; cv=none; b=NbwsyPa2Wi1aD/hNk4/ckZtR98egpiMdckvhacF2C+cbjslptmkqYCV1em1Tc6oQ1Gi+FHZVOWl43HZZCnnj0WBQyaJPEOszHrDcp4o+VFcqkt1f5gCLEtMOlirSaI3SNl8AtPTdtUJiTy2vrzxeixtdzZhLFUooH/acFgF4Z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767350091; c=relaxed/simple;
	bh=5XB8+dD1DC0QAAVZVH3obB0l4GY9CMJn8XT+0uQtA24=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MPG+ulyblHyrjRBckYTBtQ8dYrmHoGFAROuBLvgNSUxL/rDReAmWFaH6tn/+2EBjIduhj/cjqZ0BiAlmKruTjOIzQ3BbG15N3uwJU0pjVgCssdcQL8TP7pi98fe2ITYabUlKuZAY5mwUqOhIoQEwaMs53/aqx7m9kpqlKgNwfz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNlVEOFi; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so68091725e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 02 Jan 2026 02:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767350088; x=1767954888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XB8+dD1DC0QAAVZVH3obB0l4GY9CMJn8XT+0uQtA24=;
        b=fNlVEOFiT/YeE7wxZvDBN455mMRPRDsTFb++yulW0o0LucXhgPhdCDVx4HNHpwbstT
         TZXsLRffWbxIY7pnX8s7mQGMkPTeCuNPwf8uDfXT3lGH81jGmaWZkCzQpznI+rBGjEzU
         bnVy1FZfP/K2a4UCEiSXZcwCQDhtMxs8AEsz6ZuGCzD/mAQllHjzj77hV/xgaY5Bdhkx
         wK9uf9qztID0iMZZ1wbCVuyuNCHTWoSNONi/8iB2PdDOQ3KcRS1UCA7xmciLcVLc+yuI
         hGYVlQbSesyOl6vMN1G0H1Up7Z6/TwIdf6jxtyMYMLo+k9UA8T/tq9AiEz5W4MR4Md4v
         AIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767350088; x=1767954888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XB8+dD1DC0QAAVZVH3obB0l4GY9CMJn8XT+0uQtA24=;
        b=GdR6eFhIYRsiTizejK6k4MYeXVFKfQvBnnJnqKzUFnOHBkW7nXAHe/knaojfsaCsQk
         g7e0P64m7tIqAGAbc3WZATnl2qim2ri22JdUG3OApzaR4HdP8GdzEvPrC1x7qnE/XB3j
         xuZo9oMqRk9k/EQ+azOhBd8aNhCVbE1dKnYN2rzJmfi8ZGAntSEJceWe/ETA71RLPlxO
         b83ESqtr3+HY/qlggL+i8MifAHjxcw6+G/XQ7cb8aWqrhpnaC8WoGzMAbaaQXhV5ffzw
         qUUklmG9IDHGSb/nRi08oEgM7GGu4u2pO5nw2J5Z45dUbbCnd4J96/tCJuhJPNOSsuxX
         lnsQ==
X-Gm-Message-State: AOJu0YyxqGVbz3DmpvzH1GhcyiKrRl77GDsY+vn98O9phev5ISkOl0gz
	NJJU/yfTXynzmMjFI0gNGAhYR4bxA+DVJBolLXN/IKsv6iSHphlg+EGv8QhVqmLX
X-Gm-Gg: AY/fxX5NM7uXon6XcNo4In+Ku9ShDQ67UdzNV+vTgnOA3sziy3geb0xNjl73zTP9I4j
	Xtazy9xkzPJZWpTviYeehXceuRbnRWuZerwJOui/Lm67v5oGSnoWpR8xzlg4jDu9tS/sf7r192y
	9gpFvlphaI4ceMQGI0lUjs61nfN/zwvo3GyfKk+hyC9smNRxr07vqYVej0eIvJqzWFtH/ctH6Go
	NF2WHCELPnvEwYEBEy3/e1kY8/p6U5W2Tg/G6nE7WLDnNqGvlbBzKG98+sd7MNESwW06eERti9v
	6wZ0FUe1I1m59ESPCheC+JcOPrEP/yHjxJjRA3niHb+tclG92WkRJ24aQY/ufnG8Bb4BV1Toxfd
	w5P0vbWYZOohy754fmzfq+7wj/JKbYiqGNp7NhLsgDbOcT3LgmNCOUR59/FUir7KL+VYoOg5exl
	rqFiJfTDj7CZ+U9RTmzxYnC4PGT/cgZNrsYtmTAvPg+2rEDa1rID3MXVZa3Uuk2/52l8HSrA==
X-Google-Smtp-Source: AGHT+IF5e0ckJi35cvHmYuXfMdMvuwff6RlULG9A/lqI0RKidE9Y4reI862Xt3SgwFmui0IU5CvUJw==
X-Received: by 2002:a05:600c:4f4c:b0:47a:7aa0:175a with SMTP id 5b1f17b1804b1-47d1958591bmr538383885e9.26.1767350088211;
        Fri, 02 Jan 2026 02:34:48 -0800 (PST)
Received: from fedora.fritz.box (dynamic-adsl-84-220-246-20.clienti.tiscali.it. [84.220.246.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm83525172f8f.5.2026.01.02.02.34.47
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 02:34:47 -0800 (PST)
From: moosager90 <moosager90@gmail.com>
To: linux-wireless@vger.kernel.org
Subject: mt7921e: repeated driver own failures cause hanging
Date: Fri, 02 Jan 2026 11:34:47 +0100
Message-ID: <4870974.vXUDI8C0e8@fedora.fritz.box>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello,

There is an issue with mt7921e which causes repeated failures in chip resets,
bringing the network down and causing hanging on every command or action on the
system; the only workaround is to reboot. This is what the kernel output looks
like at those times:

mt7921e 0000:62:00.0: driver own failed
kernel: mt7921e 0000:62:00.0: Timeout for driver own
kernel: mt7921e 0000:62:00.0: driver own failed
kernel: mt7921e 0000:62:00.0: Timeout for driver own
kernel: mt7921e 0000:62:00.0: driver own failed
kernel: mt7921e 0000:62:00.0: Timeout for driver own
kernel: mt7921e 0000:62:00.0: driver own failed
kernel: mt7921e 0000:62:00.0: chip reset failed
kernel: mt7921e 0000:62:00.0: Timeout for driver own
kernel: Console: switching to colour frame buffer device 360x112
kernel: fbcon: Taking over console
kernel: mt7921e 0000:62:00.0: Message 00020001 (seq 1) timeout

I have observed the issue on many untainted kernels, and I have had it happen on
vanilla kernels not provided by my distro as well.

Mine and some other people's reports are available at [1]. More logs of the
issue on my system are in the attachments of my original report on the Red Hat
Bugzilla [2].

In the past, the issue was reported at [3], which resulted in a patch [4] that
only keeps the system running instead of panicking. This means the driver still
causes system hangs.

I still don't know the root cause of the issue and I would like to get to the
bottom of this; any help or guidance is appreciated. Crucially, I have not found
a way to reproduce the issue at will.

Best regards.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=220353
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2411854
[3] https://lore.kernel.org/linux-wireless/VE1PR04MB64945C660A81D38F290E4A4BE59F9@VE1PR04MB6494.eurprd04.prod.outlook.com/T/#u
[4] https://patchwork.kernel.org/project/linux-wireless/patch/727eb5ffd3c7c805245e512da150ecf0a7154020.1659452909.git.deren.wu@mediatek.com/




