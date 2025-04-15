Return-Path: <linux-wireless+bounces-21543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EECA89A47
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E45A27A4F26
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957E728467B;
	Tue, 15 Apr 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1KuR5Hu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F3C28E604;
	Tue, 15 Apr 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744713092; cv=none; b=E0lmzdG83dfiOt2Q5zFnWmuBzJBm8MdbLSlotb3UANY7BgWzQznAhTz/krnwlsrpJ4nLxkTP1+W2gSjokcv0q2GMCiCBP+lHFmRGS1WIYivgRws0O2UQYmnEY1u87jnPb9fZyn59cRsa93yH1WRMUJrlZxLWxYEGoK5TWz8Kc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744713092; c=relaxed/simple;
	bh=lMvtUhyunUffiD8LsXcEpY9VpvDraBR5jc0+GJGjPQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqyngQPulGHYIf1Ta9lTQQWqAnvwRRoql5bLX7bYcHzR3OhqXUdhKlhj8z/3R0CzGB4bweFccSgumkOiTkbxdOJddJ8USnQk0WUA8/kdnZRIwQNGk9OWNYYKTW/W4vh24yMqRM9OnDFtCzABKn/9vSvT+FWqmisxaHMqUT6BHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1KuR5Hu; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736a7e126c7so4573373b3a.3;
        Tue, 15 Apr 2025 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744713089; x=1745317889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQMUncuMXTk+rXouvBKfkfVKDnIZqhYDB6eRjO5Il1Y=;
        b=V1KuR5Hueww+/xl6ThGjbIkavaqL5OAF21TPWPDhpqty3hLEpiv4W9g1x8mtgf99f1
         EN9lpvfrPfzwwYwFTHc54WI7iCkBRWzjr1tlV9aklmxVMYJVD64Vp7ZuwC8hluRjJu68
         /jw9CVlyoDp1hp32mek0s62vcujguq9ICKciVDuXa0bZ1RbzUYXxfXvnMfK46OJ4oXSn
         lF/r584ryuaQB5Qv7T2iqYviV5oAkVRbqTokhh65eNis+1jF2Foak9w79fb/Z0v2zNwl
         ESuCsl7T6tZzDD3glHReFtqz5QFzPCOAF11ROKy/ERsbJS9PVcWIwjdopW3au9Kg2/bs
         v58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744713089; x=1745317889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQMUncuMXTk+rXouvBKfkfVKDnIZqhYDB6eRjO5Il1Y=;
        b=OZPWo7wXHo2xj3QJB2XFmJXVLgsUcjOCYVA5Uf/aw5zmjqbDWJYwUvp3hvEaK+yyGr
         pHdL1TwHMFT0HsHsA1wSJ9On5qsqHfz5ABSN3K96oN9XS3C4z2Jw+hlUmm7cDbp+sRj9
         /J6otekdhneVDx4hubqKabXGwGp9Ei9/HvRCyxa3CJdmrBjz97z20ytOp/+MD3YltYR1
         +aHyFjd/FT/MLRrS3iJqFWnEfRUiJq1ZShjQUA1DA5UjB+i26ZNRq9xNH1V2Ux9Dqhdv
         bZ4WkYzY4y7Uvy7vZgnJEeu5wIKLwwcBQxvGXsD0jcfbzdOa+IQgN9VvqKUcnSrUYKew
         GrDQ==
X-Gm-Message-State: AOJu0YxCn0ew/efyiJy8CEMuauDazNoDzUeN5gvZEOgMR3hbfP0UZ8lm
	lrDNApKk4tFxhEkFGMvL1Jw/FKBp6gGuv20KAX1hTNa6D1pqrwjCLVhRb85L
X-Gm-Gg: ASbGncs5sPPXDUTnUBqqIBAquTKenIdw1hMS/BNKqxvGQgSTNwh9ykEezrPLhoJVm3F
	zsRsZABPlMEbAu7AsP1SvwGVylECHzVBBcVr2lfAIC/zkg+EGNZq5ayp5iTaDlstF6pQcEVPHga
	gYvu8h6xRRXCO1GAuJOLjG7GusbcHmQMSheYL7S3Vbc98t2UFHo/hkhgKwbkJnLFFZbcUknKIju
	ByZf1exNxrW8FYvD9UZvX904oTq1SeIDaBHEa7qwL4h+p9W0wrIH1cZqyO0Vnzv/qSUtDH2UDkT
	l89Dp9u0DY8MI9+XWToexfN/7adqfejdquCgC51o+JNWPQXX6D0CCk8JWrZmQiDLXgBnCEsmR3z
	fvBmz03Ui8ZvxOhM=
X-Google-Smtp-Source: AGHT+IFilmJYMoF4ocsaJ1kPXOuHx66bpEJBkxY8auQ1ntN8UeOmd2v/NOcKngFt/WaVus719/5grQ==
X-Received: by 2002:a05:6a00:2e29:b0:736:7a00:e522 with SMTP id d2e1a72fcca58-73bd1193913mr20201189b3a.2.1744713089307;
        Tue, 15 Apr 2025 03:31:29 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd21df771sm8158292b3a.76.2025.04.15.03.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:31:28 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: stable@vger.kernel.org
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	zenmchen@gmail.com
Subject: [PATCH v2 6.6.y 0/2] wifi: rtw89: RTL8852BE: Fix a shutdown issue
Date: Tue, 15 Apr 2025 18:31:23 +0800
Message-ID: <20250415103125.15782-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses a shutdown issue reported in [1].

This problem has been fixed on kernel 6.12 and later, kernel 6.6 is 
the last kernel these upstream patches should go to because the Realtek 
RTL8852BE chip supported by kernel since v6.2 is the only chip known to 
have this problem.

[1] https://github.com/lwfinger/rtw89/issues/372

Zenm Chen (2):
  wifi: rtw89: pci: add pre_deinit to be called after probe complete
  wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit

 drivers/net/wireless/realtek/rtw89/core.c |  2 ++
 drivers/net/wireless/realtek/rtw89/core.h |  6 ++++++
 drivers/net/wireless/realtek/rtw89/pci.c  | 10 ++++++++++
 3 files changed, 18 insertions(+)

-- 
2.49.0


