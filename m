Return-Path: <linux-wireless+bounces-29578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4ACCABF3F
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Dec 2025 04:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 218063009FA4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Dec 2025 03:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714ED2309AA;
	Mon,  8 Dec 2025 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gl4Gx8XJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3F18C008
	for <linux-wireless@vger.kernel.org>; Mon,  8 Dec 2025 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765164040; cv=none; b=g9Gb1iT85MINktD2PeJBeG4zFIfvKDry6aX1IL7c4aArwLffTCJhyGkCMGL9VQxxRzeCSuQaUgE7+jTyjlcpHQV0A/EAQ2PNrtdKhfoTYQrrnB0y37r2C+PqbNTLopo1e6bItB1k9fnLTzrbXbeT0CEegZ7CKDKwQOq0aSXj+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765164040; c=relaxed/simple;
	bh=GZWn3Qjd8GHmDIN1qQuNEfkRZnC9rmKwEa7GmK6s4bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExYSMQPGc/+8+L6w9zqumzK7reUWINSVUfA6bnPwM/qC2CsvKQMUgIW+CZdTG3GvhwjaDXKDjb8393LddbiN3G1mj9ZSKAaDagoDLLgKxD84R1O4Z7GLFm6BrWWUlnOirW0Q6oPOllI3pO/RiBYiJgtsGJ5bURmH/NP6VhHqXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gl4Gx8XJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so4802542b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Dec 2025 19:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765164038; x=1765768838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pthQxy69h+U/5CTCNbJzI0/oY5Mp3d9cLENgacgD6Cs=;
        b=gl4Gx8XJLAHTDNqQGGwbDaouTl90i955Ji7FtL2YsMVrc9J9WtSJN7iOGXr0T5+Rz8
         8KgXN0/haBDI7Ieq3+43wRpF3pH5oOXKJ4sBYT3/+1ICjsvn/H3hhOud8+OtClhOB2A0
         pJ45Vo0hOrTSR60Ao2ys2YvH2Cs48KFl6l8F1OlEHP5Be6B1vuQ/zwRsQTRKfjN4hOpi
         G82uK43AWXvtILhAhhvY2QBQnBXoOORCCNL87h+beMkcWWnbHBy/6NN5o0vFetewUY0O
         sVqGA+Ncv5ydhTOH2BH3s3x3y6AhnLailpHEPGAUwPWRMnzyaTPUTFeTJfL5Pip0TFtB
         BNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765164038; x=1765768838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pthQxy69h+U/5CTCNbJzI0/oY5Mp3d9cLENgacgD6Cs=;
        b=Hzt64m68ArB8TyxX7o/U0lOafSWhJG1DOuAp6t85bqjkjm6Ftl8RE1ARVCm0pcE+9t
         lDtCe0+xUeP7JFehzFhwpbYRU8N9gBtksGlz/sLAJiYaqva3votReJGSoSRshDoMxOAJ
         I3XECRo2abgYR93jcycvp4iLJovq2tm8LsMqD6iRWCBu/O4cMjKm/v+PIi9CURAtJZuc
         I7WGrB/So6Xo9EmEWBLAChH2kV+SE29A7s5v7Mpe7or0UCYLZTB1Q69diUXZEQpX+T9p
         WWeqvUXJ2Lr5CFVWN1TqDtuoM9RTgbh4bBi0xKWCpUrmkOQr1jFQMMq3QipzSt9Aw1eg
         lhSw==
X-Gm-Message-State: AOJu0YyfZ9Bb9ES6QTfCb40/PjT8n8cdoRY77fbh6Mk+CrHt/ZFSr2t0
	X1u5c3z1TrjgjSD4dZ+ujvl56i5pcib6X3OgSi8SKy3C8zqLaU8DoQsQLJI7URUb
X-Gm-Gg: ASbGncs1QrCpG0jMU07LZRBXHh1EQ36vJzmpI+jEX/iO+X1YCI3wsjYscYROTeOAudp
	kvZTZ5f0GP4OHwVi8q1ad/YvYXGljR84lzhPrYc+VMJlnwcyzXLkzS3gcN8YSR+NHIaS5In9kCL
	5w4SFx0skFnKFXHLdzEIcyvL/Zj+tAUREsmpfQ6XVbPDvFJPXgUzzZb1iQI2UQ08Yl94c4xu7wd
	+o9AUFTtB6ov1Hob9uTB/L/DGWFWrXXmftHOEqnfXiZCXyoEZ5OeqyZXObTZZzpH+n9l29++cuE
	IL0qWRxA1o5eJH7MEDqz41nJZf21VxqRnyaDS7xAS7c2cwc5vsZ8bhY4ZD0Sm48opmj+8I6do8Y
	WNwED+tUzb7NF4u4tjaibO/YdtFQx8AS31Ha2uj6gsdSVpe68OOMoz+7G9OHVmoV93l3QP8BOea
	V1F3GS1sZjBSfZy+vSuAKCzdSPBhGN4K2bjhJ4coEuLThONScLi+Qp
X-Google-Smtp-Source: AGHT+IFvZcDGotRgp2akcPilSnlmLuKURxDRJIWM/KAl2/617n4tkXWj8jm3EHpF5OMAlL6a+Kf6KA==
X-Received: by 2002:a05:6a00:3a14:b0:7a9:c21a:55b4 with SMTP id d2e1a72fcca58-7e8c1c30fbcmr5979281b3a.28.1765164038220;
        Sun, 07 Dec 2025 19:20:38 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7e29f2ed000sm11551934b3a.1.2025.12.07.19.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:20:37 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org,
	marco.crivellari@suse.com,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com
Subject: RE: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users"
Date: Mon,  8 Dec 2025 11:20:32 +0800
Message-ID: <20251208032033.5793-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <c5ea34777592402caeb7fb83af7d6f07@realtek.com>
References: <c5ea34777592402caeb7fb83af7d6f07@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ping-Ke,

Ping-Ke Shih <pkshih@realtek.com> 於 2025年12月8日週一 上午10:11寫道：
>
> Hi Zenm,
>
> Zenm Chen <zenmchen@gmail.com>
> > Hi,
> >
> > Last weekend I tried applying the v1 [1] to the kernel 6.17.9, but that one didn't work, either.
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-wireless/patch/20251113160605.381777-3-marco.crivellari@sus
> > e.com/
> >
> > [  306.035759] usb 3-2: new high-speed USB device number 5 using ehci-pci
> > [  306.162258] usb 3-2: New USB device found, idVendor=0bda, idProduct=b82c, bcdDevice= 2.10
> > [  306.162272] usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> > [  306.162278] usb 3-2: Product: 802.11ac NIC
> > [  306.162282] usb 3-2: Manufacturer: Realtek
> > [  306.162286] usb 3-2: SerialNumber: 123456
> > [  306.239143] ------------[ cut here ]------------
> > [  306.239148] WARNING: CPU: 3 PID: 2886 at kernel/workqueue.c:5667 alloc_workqueue_noprof+0x676/0x770
>
> I think this is because kernel 6.17.9 defines:
>
> __WQ_BH_ALLOWS          = WQ_BH | WQ_HIGHPRI,
>
> and the latest is:
>
> __WQ_BH_ALLOWS          = WQ_BH | WQ_HIGHPRI | WQ_PERCPU,
>

Thank you for pointing out this. Have confirmed the patch v1 does work on
Arch Linux with kernel 6.18.0-1-mainline.

