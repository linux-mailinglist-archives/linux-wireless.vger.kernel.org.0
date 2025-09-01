Return-Path: <linux-wireless+bounces-26893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87539B3E5EE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 15:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484C73AA4EF
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE03D994;
	Mon,  1 Sep 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPPK/THa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912124DCF9
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734466; cv=none; b=M2WrAuMq85/Jw44LUInc8BswTJWU2XCvcCNnvfGrxiRrm1I/4+qR86Fsf6/48ihH1erSqMXbrR2rviWrXhyr6ilFxM1WdqeYLSIgELFbBXYBRbrx/yONqT4Xtq/xJBwzlsx4uKl0RFIyU8cArwU/6/66QhaBRxf5Fsl5heXq66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734466; c=relaxed/simple;
	bh=bJF7BNk7fHmyanBIuIlDMFXdX7ASwMTslJLoQOykjpk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KYsTsqEDxhZzXrWkFahijDnUh32abojs7F0B6fjBUrXL5lNRoNVWXERLMpS0XuLvUNiu+C+jp7vp4HPjayXihbr5yonyX7vnRRaQwwH61uhKAX5x3A0SF3xgTgecKlFd4qV/Il8ufSRYz8detTGFtexo8e4gyfkIIr/URFpBG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPPK/THa; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-544bac3caf2so398071e0c.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756734464; x=1757339264; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TWkyjmfsO29N6leMHssUfrkLr6H/36rjsz9zILMRK6w=;
        b=JPPK/THaYOlF2A3E8rnQe+FicrMTv4z9VVjo29mQnC1bLhORbCeK3/eDz3GwcivtGj
         VcN4/JM9Jht7L2gSiHBGMBbz6tGIzkfdE//GUWku/lDEFIOAEHw66ZwPXPXZPiRVmuL7
         A9R5G5aP6xX3l30TT4dTi5lVgA++3BrkjCiChIjvn71NpzwjFD0d8V8zYm6+FquLZTck
         CW+fKUKavL3jKdLjcVPhIkpCDztUKMZ2AImibVCKijFN04T+u4qiNxa7RA/n5t2oKTAV
         SYIR4uzDzM4pFWsXf862n4anpEfg0RHeZEkE990i2MOder5oqmuqQ/1GNIW5G9h1ho0l
         zrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756734464; x=1757339264;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWkyjmfsO29N6leMHssUfrkLr6H/36rjsz9zILMRK6w=;
        b=S7og7A4JL16mAhPuxZPVEWg06CJFirEO5xDsr1H/TxWPQ9xqpKKXEWOlIgdov5i8JJ
         sINCNdDEb1UDiYuAF+Bb2WMyRvLcsq8PMRX5F80bP8lG+jGizJbtN0LB2CtAMYsEerP6
         r/rK6TtK9rci197iR+PajgDWdx69Iw87L1ImqmOWuGSRK3H9MhLR6MSx5NsCIg/xXNVs
         mqJQ/SEyQUJJ5NXj3uG8lIkKVkBWM92nZyJZxTTZzd7UmrBkekuQeOQIM186SRfobXDa
         okXfVM9JHZjtsCy2yEYgpIs62TMi2vAw1d6du0iozbrJIXmc7J+15wfrC35ohR2v29gp
         Udng==
X-Gm-Message-State: AOJu0YynxUnwq2cm+l+hTKZ1JPtGsWhTgUMadi+RxjOE9oG0pmkd9ntr
	n2zEvxHaDMptnZfXuF8PqO7sKGh1579WI9ai5teYhiXrJEJazZyYu/yBdKxagm9uIKGf8uNanNB
	nf1sjQ6Dq22lZrBuKY2Z1ErYkdDwaGbkAK/rlVfs=
X-Gm-Gg: ASbGncuCHvMmXtrgY7QJ1d5n/37rAAhUPETwhUA/t8Y9gnF8ENO7XbrIKiM/ArIjhpF
	fKfPP54p0h9/VD/RQhBXAQJu+cQ7JoO6spH/NcGbeS3/CsE0K7oMAjFcqh3laTJPnEZzxYduUo1
	X4N94NpHpaM8TGgEuaOorVQHMmchn8jzteGMHUw0YibZ3rH7bRK8jrIgKOX+b3TVXAFzyUtkPUU
	2k9
X-Google-Smtp-Source: AGHT+IHfZydWZvhZrlwuEfXrjmZ74qfnRs1G91eTukPkm6qd3O2JGxPCcMDwQ/WvX/HLGAUufU042L3EpwYXpMe9n2A=
X-Received: by 2002:a05:6122:1883:b0:53f:ea13:5002 with SMTP id
 71dfb90a1353d-5449e88dce8mr1901800e0c.3.1756734463983; Mon, 01 Sep 2025
 06:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jose Alberto Reguero <jose.alberto.reguero@gmail.com>
Date: Mon, 1 Sep 2025 15:47:33 +0200
X-Gm-Features: Ac12FXyvZrBqYM160IjGMyu2xJk9mMAJGaPup5r0dsyJYnRloh08xmoCZ2Ecc78
Message-ID: <CAKHHu8oZ_ZKMXHt_gUgGh0CqxJJvjJFDJDQtMzhojxkdsCSwKw@mail.gmail.com>
Subject: iwlwifi iwlwifi-so-a0-fm-c0-89.ucode firmware
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have this error:

[    6.017937] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    6.057193] iwlwifi 0000:00:14.3: Detected crf-id 0x2001910, cnv-id
0x80400 wfpm id 0x80000020
[    6.057232] iwlwifi 0000:00:14.3: PCI dev 54f0/00e0, rev=0x370,
rfid=0x20112200
[    6.057236] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 7 BE201 320MHz
[    6.057334] iwlwifi 0000:00:14.3: Direct firmware load for
iwlwifi-so-a0-fm-c0-89.ucode failed with error -2
[    6.057343] iwlwifi 0000:00:14.3: no suitable firmware found!
[    6.057345] iwlwifi 0000:00:14.3: iwlwifi-so-a0-fm-c0-89 is required
[    6.057347] iwlwifi 0000:00:14.3: check
git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git

But I don't find the firmware in linux-firmware.

Greetings

Jose Alberto Reguero

