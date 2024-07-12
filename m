Return-Path: <linux-wireless+bounces-10200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F55592F3FF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 04:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E555B1F22D11
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 02:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190679D0;
	Fri, 12 Jul 2024 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8ifrUpy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312755228
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720750994; cv=none; b=mE9xcEgXoM8L1GajBfhJhDnODAnQymsr2OOrErfcyfmiEA+Y0vTX8UQ8pxtHZH7l1kA12E5KYShNh4Wm1RzL913x4rgK9+K92tPAbQyYWrs9H38LOiZmYzm6vCyMM4LDG4rmngSiR69ygGqLbR3tYA65rHHFruF8djZTNbRN4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720750994; c=relaxed/simple;
	bh=alBAO/xoO2ePBbtjdVNUpSBOq7pZY3YzoZKCFhJAY3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Yp5zVPn6IxPsjOkFm2sVXo0TZZ0XNkE9rG7/fuU40kMcUogY5qTSbHlC0LLu7PuIwUJNcGmWMvO5v84ygqSWFySAN8RTp937HIoslOeEGBE4qUHf1BpsHGwElbz5o7BBQUE3IsSVZ32ZkVf40hUE2866go/H/2gDJeoGUYiTd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8ifrUpy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-75cda3719efso1031468a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 19:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720750992; x=1721355792; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fiWSJevl5y9gP16KdJqZOZIhr3FbgcenXMYGrOBShHE=;
        b=f8ifrUpybjdXfRZOnw2WNYrJi3sunR2mssTuHs8MaBEyEHrDtvz2j1L5jcgWR8zvIb
         AZDgqajDWeHMEEsez+ASOVS4HIEJGg3t8/FL+0oalCvGJ0m8LoKAZKIoanc7UfIH+em5
         AUqwG9R8sL9E9DMSqKHfjJUbGakzo4neF/5wb+e8kPzEhlgCu8dYiG7K1VgzlqHSmAE4
         WKrNc5kY5cmEz9ZcyWzD3PwfH5hdU43sT+wMk/TXGtCQijeFtFmVusS+3cz4Ek9MgC13
         BUUYY1fNbwMmvAG91taQGTeU1L2MSMTZpZ0XN0Fuesx/MGR7BdDr5O7gUZYSMCY0SToq
         Cvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720750992; x=1721355792;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiWSJevl5y9gP16KdJqZOZIhr3FbgcenXMYGrOBShHE=;
        b=M2D0qbhTRUPk1GvuFWV9p/CLjKFciVL63BvRw1tvnID6WIU+X163W2UkuxGlGMDbMC
         rotNoaA5tENIB/IS7I6qkkFYdLQ0KJDQ1tI5Mcms4qiMI3cfxfjZCf4DQB6fDJ4OuRTr
         4CpBYEr7HBSj1e4vvm4ENyP1KmNgNIe8BfDPAFVDctIfBf3Li477JbZ82YPtE1KWyFJf
         xIQ0yHN9k1mdbELsM5LnUVqn0djrIkk7RoElwGp2bx9VjGWClm+NLoT2DtrsgW86me07
         WZWltuAk5l7kLXycEX/qgES5E/DJb6cxPH7D6fz5nGoDaRB00WnFf+sRchyfce0dj0qQ
         FHng==
X-Gm-Message-State: AOJu0Yzw4Ul2glvegaRqwX3LpJp8L+maqlbn2+lClqmVyVvVRaVOBFMP
	ltZWLuGQiAsq57xR4qZlGMfOLd0v/M5vMUFxBY9KIU1Kle4yx+0b8IXivhfhWE6ZaGxmK3nXtPZ
	R0nnR11n695g11Rq/Iu7XL1MSeUI2Gi2D
X-Google-Smtp-Source: AGHT+IEw/qZxDioe4xY/eHTlHDcYGDdC8hkvQSuyBrujW36QzPmk/ImlUHiBiHa8yu5rL2f1OycDNQ8Mo1sMGhFl+NI=
X-Received: by 2002:a05:6a21:a343:b0:1bd:2a0a:c183 with SMTP id
 adf61e73a8af0-1c29820c07dmr10611796637.9.1720750992144; Thu, 11 Jul 2024
 19:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cedric Veilleux <veilleux.cedric@gmail.com>
Date: Thu, 11 Jul 2024 22:23:01 -0400
Message-ID: <CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com>
Subject: [REGRESSION] ath10k: failed to flush transmit queue
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

AP mode.
Both 2.4 and 5ghz channels.

Using WLE600VX (QCA986x/988x), we are seeing the following errors in
kernel logs:

[12978.022077] ath10k_pci 0000:04:00.0: failed to flush transmit queue
(skip 0 ar-state 1): 0
[13343.069189] ath10k_pci 0000:04:00.0: failed to flush transmit queue
(skip 0 ar-state 1): 0

They are somewhat random but frequent. Can happen once a day or many
times per hour.

They are associated with 3-4 seconds of radio silence. Full packet
loss. Then everything resumes normally, STA are still associated and
traffic resumes.

I have tested with major kernel versions:

6.1.97: stable (tested for many days on 10+ access points)
6.2.16: stable (tested for few hours single machine)
6.3.13: stable (tested for few hours single machine)

6.4.16: unstable  (we have errors within an hour)
6.5.13: unstable  (we have errors within an hour)
6.6.39: unstable  (we have errors within an hour)
6.7.12: unstable  (we have errors within an hour)
6.8.10: unstable  (we have errors within an hour)
6.9.7: unstable  (we have errors within an hour)

From these tests I believe something changed in 6.4 series causing
instabilities and the dreaded "failed to flush transmit queue" error.

This is a custom linux distribution. Only change is the kernel. All
other packages are same versions. Everything rebuilt from source using
bitbake/yocto. Same linux-firmware files.


module initialization output logs:

[    9.335682] ath10k_pci 0000:04:00.0: pci irq msi oper_irq_mode 2
irq_mode 0 reset_mode 0
[    9.543221] ath10k_pci 0000:04:00.0: qca988x hw2.0 target
0x4100016c chip_id 0x043222ff sub 0000:0000
[    9.543270] ath10k_pci 0000:04:00.0: kconfig debug 1 debugfs 0
tracing 0 dfs 1 testmode 0
[    9.544296] ath10k_pci 0000:04:00.0: firmware ver 10.2.4-1.0-00047
api 5 features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
[    9.603583] ath10k_pci 0000:04:00.0: board_file api 1 bmi_id N/A
crc32 bebc7c08
[   10.985663] ath10k_pci 0000:04:00.0: htt-ver 2.1 wmi-op 5 htt-op 2
cal otp max-sta 128 raw 0 hwcrypto 1

This is followed by hostapd starting and the "failed to flush transmit
queue" errors within an hour.


If there is a way to further debug and collect information please let me know.


Regards,
Cedric

