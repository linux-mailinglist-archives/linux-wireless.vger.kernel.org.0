Return-Path: <linux-wireless+bounces-15787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD6D9DBA40
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 16:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50EC280C4E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BC519D06A;
	Thu, 28 Nov 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSelw//q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F819EEB4
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806717; cv=none; b=Yo2hbg6/TOY+ORjmYfgCYWIl5ZW09CxBZi0JRci2SRqKDMI9H9HXWokildtW/tCJsQ9Bt5zYYHW51KivWx5eXQhrgMmAX1WXKKafgMVLSzoi3mkq6LxefwYqgnqUxpqqVrkz3c0o9h7scVlCvqRQStl16KSN1VV1xrzy29jVOKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806717; c=relaxed/simple;
	bh=ubSjwegGqk2k+Kv+39CIWOclRtIl5/xMR6j5qodAjJ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H0UL5VqoQk3L8kD+B87ksk5jwUiYjIKp9nXBSZUWykUOheXP4YPw1q4bI1/LyCG2TeftFMXdniUJF4p7SwslAqUSLUSqL+eUxHGTCMgmdzP0MVCU7P+8H3VFeXn9S08rLgN4dAyGQ6oyOM7PwUQbr+fjwhkJjmAG8wwlkSC9ZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSelw//q; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4668283eaf7so9070631cf.1
        for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732806715; x=1733411515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=25wwbL1/aRSxbqsU55Z0VkbAIYXueGynmh1w5+yJMjc=;
        b=JSelw//q+jDBJ+sH2zY1Of20dnuH1GlGOgkQOaofuKpLQSCwbriFDZJ5nbwnMMJQME
         TSfFwQMLXvbc77Sm0ysDMZ1KanSun5FPHEb9EnHBBO+UXCBirFqG7NEDMlGMSj/SyyLG
         6Jeydd3u7JkgLfr9wxXwIyeS1SdmnQJyJXDCKrqCkaR6T38ls/03f9Z4rjh71TidrI7F
         SA9StcONIaD5Ce+7ZYBC1yB5nizjGJjxd1gH+asyIp8CnmdShbDL9zj0MAco3rBf8Qd1
         sez9qcUPWhrBI905wIGo7hFqZr3q2kxXeC2Ytoc6k0Ks6/Iz2sn0jO2auLEfB4Xe06XY
         BxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732806715; x=1733411515;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25wwbL1/aRSxbqsU55Z0VkbAIYXueGynmh1w5+yJMjc=;
        b=eFXLA5R8j0T6km4ClnVT/1p5Z2POGp6Yy1Uqgk4AnojndacKyGuuXRU15UURuX+dud
         QhkptAvA7K+ZmYBt7WDIXkWVkGVKnljkHBD6luo2P6OZL8IzrN6UsFMm+nwFikWJnuu1
         sSL2fodxnI3xB/c3/uw/1YQ0JWCa0JSUT1TMYsMh42fBymSb6VqpAW/6wtmLSHKmpEap
         xRnxaYYwxnh50P3skIPL3aMnt+7m0ytpK3cD75J1NiRRvPCb4vbru0G41PHRDzr3CjXr
         oCskK2BIcyzYHv9vn7u9yiPgmPMRNDJ5jamXBQSlUguXm6uuzaBNig3fkFafBuxMuCSS
         qOOQ==
X-Gm-Message-State: AOJu0YzfIlNwj43scMppGDX98I1HJbH7vTQO82mmy8KG/QIuMDBIELLv
	EQLQBcRFijpucqh4UlxwEjZAzhY5tA86td8AFlyLvF0OcJWm5H6uE7qZNerUnEfzji5mNa0NL34
	6dM1IFt1NC3ozfGEG+P8RJ3nf/c1fTnUE
X-Gm-Gg: ASbGncuecmfU4A4xTW0S5vJFg3OYMQmjK9+SGhDgazacU565pA8XNXBiVoWD6/8cn2k
	WeujWljnWT6fvQipLAvKHAWuIxZAlzAXW
X-Google-Smtp-Source: AGHT+IEifM1337CLrhWPHOO81150TVJgoX+NHWzRWcccPa88mfWytNRoCBNOFahy29P/0lowUq1Vwk1qSx9rUn8NABs=
X-Received: by 2002:ac8:5ad3:0:b0:462:b7d4:42b2 with SMTP id
 d75a77b69052e-466c1b19550mr56494631cf.6.1732806715020; Thu, 28 Nov 2024
 07:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Demon Huang <hyh19962008@gmail.com>
Date: Thu, 28 Nov 2024 23:11:44 +0800
Message-ID: <CAF8Er24cwadjjFdN5fsHpfiqoyEOi9htHvOEjhMDkZAD4cNzuQ@mail.gmail.com>
Subject: ath12k-firmware: WCN7850 hw2.0: add IDs for Acer Swift SFA14-11
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

  Hello,
  I want to add my laptop's id into the board-2.json:

* description for what hardware this is:

  - Acer Swift SFA14-11, ARM64

* origin of the board file

   - downloaded from
https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware, it was
commited on October 15th.

* ids to be used with the board file

  - WCN7850 hw2.0

    + "bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8001,qmi-chip-id=2,qmi-board-id=255"
      My device has "subsystem-device=8001", so I'm placing it next to
the existing entry of "subsystem-device=8000".

* attach the actual board file (board.bin)

    + "bus=pci,vendor=17cb,device=1107,subsystem-vendor=105b,subsystem-device=e0dc,qmi-chip-id=2,qmi-board-id=255.bin"
      I'm reusing an existing bin data.

* other message

  After adding the id and repacking it to board-2.bin and then
reloaded the kernel module, I gave a quick test, it can run up to
890Mbps.

  Tested-on: WCN7850 hw2.0 PCI
WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3.

Kind Regards,
Yihao Huang

