Return-Path: <linux-wireless+bounces-14366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E199ABFEB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 09:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7738EB23523
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E79814D2AC;
	Wed, 23 Oct 2024 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O/YRT00V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299914B94B
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729667678; cv=none; b=EySx5Bfd8ubmkaKlactHO+mPMtUB/W+kI22wNwmXY5VrEa09l6j1SxwfgzHTRZ0EBaowD31WKM5HVq26AaM2P6JTcEixIgbvtjllTuEsGLX8uYNcx/IE0NccNv4uUx/AjlWWEzvemMNzE57vxb/iTAUHGxEep6wgQz/RaBL+rD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729667678; c=relaxed/simple;
	bh=I72PARnjhFehtEG2rAaEyLZcUgGCWCfQMi5jN8CTJuo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IL10lDYZatm9GWjn3QQ1ay+mQHwQ53JLTVvKMQtIrhORODnNpvBRpuLB3HXhh4BeGXw9LuKKGEcEN7P34E+4gacNn7FgTLAGzdhqDcPUIiglAeB3YbZOyTInNRLzxxbHeM4pt1ZjT+42EeMYeJwaW+Y3bZ68NrWnL0kzZKXzx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=O/YRT00V; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so4444481a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1729667676; x=1730272476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pRJ+GZAFwtn0kOSMat8djdxy5/xbVF1GRGV31Fs/Szs=;
        b=O/YRT00VfQ346ouxB0pBFnNzfKKd6Db/wldx8T/MYxxw8CfC806+SZXjbdLy9VKh7u
         LThgwfO1XgQE8mpzAEJGMU5Wq52DYQ3FofrbPHYbBUEPUqC0nZ6YIz+LA+g3ZTNmOBEB
         6nSqkku76N/b8hcK931JY+a8KoLDz+sFHyHzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729667676; x=1730272476;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pRJ+GZAFwtn0kOSMat8djdxy5/xbVF1GRGV31Fs/Szs=;
        b=KVCpXgBtcDVRU/lEt4Dp8Jr/B0EeLh7+mxbZrW2fMvX8Eunx/sh7FQ9br68Xjd43OE
         WluveDXIWnoD4+DRi6qgQkonCbE2qykTL6/6xJ2rSs1JCWv+O2giLeWbNVFFwo2M9aF4
         CdmmS2WiFi3pZvk9n5SIC/c38zF5v9avXtxCRp7b8Qi+CW35dT2pYyuBpmsNGjUT1XB6
         Fm+t4GUbWPYSTJ2KnZjAI6T5pe+1ZvhabNY5vsw1Wu8AG2oSwyA0exzzwOy4h/qoriHN
         6wwvvZlgvWvP7Du61b1VpqAfkVCTI7H+UfXiqrS3WTEaC77y5nJTnBPgXdGr+d/PQU0C
         1g5g==
X-Forwarded-Encrypted: i=1; AJvYcCWGmR6vVVrRBCfeRm+tgdpgIFLwbvGnZGmYxSx4B3ZgxyLlfPab0WNjktIyUB6km4KxNJpWkrLLPU2QhzwbKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6W7+C8XBRS1vDjGvyh70N4IO5fR/5LvrG3tjvCed27Lq8vJIA
	knoUvO82P4HU5c1Tf/mEvKdrD7zLNciXD5j/VwoJ61Z0GREsAThbm7brADn/XhuUSAwwtdGH9Ef
	JaIlTyTuABtPeaY1QCAQF8Y6njmBwm0Y5TJM11g==
X-Google-Smtp-Source: AGHT+IHqoz5Q36gQyrAvK8SX4cX+RPO+EX7ZovOrR0jzMjiF+ZHWDFdkTc2ecsYzD01ehe9Oze4H1hAqq851/7V/Wf4=
X-Received: by 2002:a17:90a:7347:b0:2d8:7561:db71 with SMTP id
 98e67ed59e1d1-2e76b6e80edmr1585422a91.25.1729667675570; Wed, 23 Oct 2024
 00:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 23 Oct 2024 09:14:23 +0200
Message-ID: <CAOf5uwmxXvHNwycaOECkX5v7+zwHtpuvCKs3pJofuJJNe2Rwyw@mail.gmail.com>
Subject: ath11k_pci. wifi stop to work after long laptop suspend
To: Kalle Valo <kvalo@kernel.org>, ath11k@lists.infradead.org
Cc: Jeff Johnson <jjohnson@kernel.org>, 
	"open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi all

I found this problem on several linux version and I will like to have
some hint to debug or fix:

[  205.690214] ath11k_pci 0000:02:00.0: fw_version 0x1106196e
fw_build_timestamp 2024-01-12 11:30 fw_build_id
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
[  205.745065] ath11k_pci 0000:02:00.0: Last interrupt received for each CE:
[  205.745074] ath11k_pci 0000:02:00.0: CE_id 0 pipe_num 0 54750ms before
[  205.745078] ath11k_pci 0000:02:00.0: CE_id 1 pipe_num 1 36959ms before
[  205.745081] ath11k_pci 0000:02:00.0: CE_id 2 pipe_num 2 36912ms before
[  205.745084] ath11k_pci 0000:02:00.0: CE_id 3 pipe_num 3 36912ms before
[  205.745087] ath11k_pci 0000:02:00.0: CE_id 5 pipe_num 5 4294872919ms before
[  205.745091] ath11k_pci 0000:02:00.0: CE_id 7 pipe_num 7 4294872919ms before
[  205.745094] ath11k_pci 0000:02:00.0: CE_id 8 pipe_num 8 4294872919ms before
[  205.745097] ath11k_pci 0000:02:00.0:
               Last interrupt received for each group:
[  205.745099] ath11k_pci 0000:02:00.0: group_id 0 4294872919ms before
[  205.745103] ath11k_pci 0000:02:00.0: group_id 1 4294872919ms before
[  205.745106] ath11k_pci 0000:02:00.0: group_id 2 4294872919ms before
[  205.745109] ath11k_pci 0000:02:00.0: group_id 3 4294872919ms before
[  205.745112] ath11k_pci 0000:02:00.0: group_id 4 45367ms before
[  205.745115] ath11k_pci 0000:02:00.0: group_id 5 45367ms before
[  205.745118] ath11k_pci 0000:02:00.0: group_id 6 4294872919ms before
[  205.745121] ath11k_pci 0000:02:00.0: group_id 7 4294872919ms before
[  205.745124] ath11k_pci 0000:02:00.0: group_id 8 4294872919ms before
[  205.745127] ath11k_pci 0000:02:00.0: group_id 9 4294872919ms before
[  205.745129] ath11k_pci 0000:02:00.0: group_id 10 4294872919ms before
[  205.745133] ath11k_pci 0000:02:00.0: dst srng id 0 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745137] ath11k_pci 0000:02:00.0: dst srng id 1 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745140] ath11k_pci 0000:02:00.0: dst srng id 2 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745143] ath11k_pci 0000:02:00.0: dst srng id 3 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745147] ath11k_pci 0000:02:00.0: dst srng id 4 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745150] ath11k_pci 0000:02:00.0: src srng id 5 hp 0, reap_hp
248, cur tp 0, cached tp 0 last tp 0 napi processed before
4294872919ms
[  205.745154] ath11k_pci 0000:02:00.0: src srng id 8 hp 170, reap_hp
170, cur tp 0, cached tp 0 last tp 0 napi processed before 21825ms
[  205.745158] ath11k_pci 0000:02:00.0: dst srng id 9 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745161] ath11k_pci 0000:02:00.0: src srng id 16 hp 0, reap_hp
4088, cur tp 0, cached tp 0 last tp 0 napi processed before
4294872919ms
[  205.745165] ath11k_pci 0000:02:00.0: src srng id 24 hp 0, reap_hp
248, cur tp 0, cached tp 0 last tp 0 napi processed before
4294872919ms
[  205.745169] ath11k_pci 0000:02:00.0: dst srng id 25 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745172] ath11k_pci 0000:02:00.0: src srng id 32 hp 12, reap_hp
8, cur tp 12, cached tp 12 last tp 8 napi processed before 54750ms
[  205.745176] ath11k_pci 0000:02:00.0: src srng id 35 hp 120, reap_hp
116, cur tp 120, cached tp 120 last tp 116 napi processed before
36912ms
[  205.745180] ath11k_pci 0000:02:00.0: src srng id 36 hp 48, reap_hp
44, cur tp 48, cached tp 48 last tp 40 napi processed before 45394ms
[  205.745184] ath11k_pci 0000:02:00.0: src srng id 39 hp 0, reap_hp
124, cur tp 0, cached tp 0 last tp 0 napi processed before
4294872919ms
[  205.745188] ath11k_pci 0000:02:00.0: src srng id 57 hp 0, reap_hp
0, cur tp 4, cached tp 4 last tp 4 napi processed before 36959ms
[  205.745191] ath11k_pci 0000:02:00.0: src srng id 58 hp 160, reap_hp
160, cur tp 164, cached tp 164 last tp 164 napi processed before
36912ms
[  205.745195] ath11k_pci 0000:02:00.0: src srng id 61 hp 1020,
reap_hp 1020, cur tp 0, cached tp 0 last tp 0 napi processed before
54751ms
[  205.745199] ath11k_pci 0000:02:00.0: dst srng id 81 tp 8, cur hp 8,
cached hp 8 last hp 8 napi processed before 36959ms
[  205.745202] ath11k_pci 0000:02:00.0: dst srng id 82 tp 328, cur hp
328, cached hp 328 last hp 328 napi processed before 36912ms
[  205.745206] ath11k_pci 0000:02:00.0: dst srng id 85 tp 0, cur hp 0,
cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745210] ath11k_pci 0000:02:00.0: src srng id 104 hp 65532,
reap_hp 65532, cur tp 0, cached tp 0 last tp 0 napi processed before
54753ms
[  205.745213] ath11k_pci 0000:02:00.0: src srng id 105 hp 0, reap_hp
504, cur tp 0, cached tp 0 last tp 0 napi processed before
4294872919ms
[  205.745217] ath11k_pci 0000:02:00.0: dst srng id 106 tp 0, cur hp
0, cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745220] ath11k_pci 0000:02:00.0: dst srng id 109 tp 0, cur hp
0, cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745224] ath11k_pci 0000:02:00.0: src srng id 128 hp 8190,
reap_hp 8190, cur tp 4156, cached tp 0 last tp 0 napi processed before
54500ms
[  205.745228] ath11k_pci 0000:02:00.0: src srng id 129 hp 0, reap_hp
2046, cur tp 0, cached tp 0 last tp 0 napi processed before
4294872919ms
[  205.745232] ath11k_pci 0000:02:00.0: src srng id 132 hp 20, reap_hp
20, cur tp 22, cached tp 22 last tp 22 napi processed before 6ms
[  205.745235] ath11k_pci 0000:02:00.0: dst srng id 133 tp 0, cur hp
0, cached hp 0 last hp 0 napi processed before 4294872919ms
[  205.745239] ath11k_pci 0000:02:00.0: src srng id 144 hp 0, reap_hp
2046, cur tp 0, cached tp 0 last tp 0 napi processed before
4294872919ms
[  205.745242] ath11k_pci 0000:02:00.0: src srng id 147 hp 4, reap_hp
4, cur tp 6, cached tp 6 last tp 6 napi processed before 6ms
[  205.745246] ath11k_pci 0000:02:00.0: dst srng id 148 tp 0, cur hp
0, cached hp 0 last hp 0 napi processed before 4294872919ms

This happens for now on some specific access point but after it
happens the only way to reconnect is restart the access point.

Any hint?

Michael

--
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

