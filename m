Return-Path: <linux-wireless+bounces-12614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0999096FC5D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE3D1F23DA9
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A241D4618;
	Fri,  6 Sep 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5CVDkxs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABC1E86F
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652443; cv=none; b=WxMtuNMvakhtXCDjEI+ReSlGloTUjkgUuHLN6J9xcV9yuUY11rQ85oDU4oJa6Nlovk0Xn5FPcCL07MX4jF6dekCBmRg0ZX/OZYDRYYsmHtlXwta8t8AQ4RM0xyy1zvdkI/4n2hdgvCVGBc+1xRvSZ9+Ebj+UZEFyDImDQ0cXxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652443; c=relaxed/simple;
	bh=VqVjyXjq3eGyHhJ+GFk6F1psxzpai7erQpQK27ezZbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnmUDval5Cpyk8GnSst7tMQEZOtPZbHBKDwGiTsNxggIMEJB4975e6uOXrt1oUVaTN+53XzbivtjP+D14HTJH4hfImP70DdcHE4jCYojBj2K2RrrU1WYasZzMBwAzyqQlRBOWARIBMLeG/2vXPLd7kmNgviWCfAaUJE8OyDW02s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5CVDkxs; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d885019558so1862179a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Sep 2024 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652441; x=1726257241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGqfRz86vWQxMc6jQTlUwTQySdYFXK/3bX0eDxmIlRY=;
        b=G5CVDkxsER0Dk/vftpUQg0nEUyWES5hIMXq2bBJtQCeLGL5jPsWTVhhMVGQP7J8XIL
         I9f26VrWaBh/qCCrCL3lxtxWz/4xxVVQbfLaglTb9rFIXs4N8IXoSoaJbkSCOpi/2hAN
         zvGKVbcOpnAippQvv7Vfr570lYJvWoZxQiYi2/R/cNFK7ZQzwutRmtovytvDw4rkrQbN
         2UVgrGWHmfYyRAPKVZg1094M8AEUHen+AuXSXFMNa7HtQi4jK5u8Q2ZLDVb4zuj6O8p3
         RRX1KRgUbWPDKhVWYzHgD9Xucqefi4zQ0aFs29IvaaNG7W67/QbBwbIYUhlORj2xDt+c
         LGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652441; x=1726257241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGqfRz86vWQxMc6jQTlUwTQySdYFXK/3bX0eDxmIlRY=;
        b=ajmQ0f6VvJ/nTsf9OblT2cYu7RbTci+NEQ8QIS6LWPeI8BKksdQ3ig50GcJcHd7ROR
         M/vOS21KjldZZ2Jm5LnkwqD3H8xMdZlEdcgkfiXrViyLs0J/+pfeOQtvrOeaLJkL19fA
         zBJljrhiXkffX2TmHLYwqWsRku6sdXb8zTEfaICc8Pl5b8/T2nPU36y6zJ/pwffTNX2K
         8RlaHhiZDdWztA0mFgMG/oXS0D21Jc2qc96rJ0maSsomBNpqYz+lU9eyrgCuiCib+Yy6
         D3vxY8/Jso9QejQL65C3yr9Tsv35XZlyLa4bHZlBP5eCyc7sO8ZeQfAzgA6bcnidzpYl
         pQEw==
X-Gm-Message-State: AOJu0YwS52rVmYxecXqkax86RM3p7jIxuFoVaBaq+fLb2G1tLqw8rj1o
	HyYmGidWX2FtdGGZ4PnVYQKl4dPn+7DuYC8L79/bSNJxmm/mouPjrBPcmh92
X-Google-Smtp-Source: AGHT+IEPjXrz9x8+GCsfkE4L+bi0ftciCOjhLQ4gnaGbmYdSv2WMISyb33muAAzIM6QC3hSSKuYy1A==
X-Received: by 2002:a17:90a:304a:b0:2d8:82a2:b093 with SMTP id 98e67ed59e1d1-2dad50d297cmr4483292a91.13.1725652441313;
        Fri, 06 Sep 2024 12:54:01 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm2015954a91.34.2024.09.06.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:54:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com,
	hauke@hauke-m.de
Subject: [PATCHv2 0/3] wifi: ath9k: remove platform_data support
Date: Fri,  6 Sep 2024 12:53:56 -0700
Message-ID: <20240906195359.6982-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes platform_data support as it's deprecated, unused,
and replaced by OF.

v2: just remove platform data.

Rosen Penev (3):
  wifi: ath9k: eeprom: remove platform data
  wifi: ath9k: btcoex: remove platform_data
  wifi: ath9k: remove ath9k_platform_data

 .../wireless/ath/ath9k/ath9k_pci_owl_loader.c |  1 -
 drivers/net/wireless/ath/ath9k/btcoex.c       | 16 ++----
 drivers/net/wireless/ath/ath9k/eeprom.c       | 12 -----
 drivers/net/wireless/ath/ath9k/hw.c           |  2 +-
 drivers/net/wireless/ath/ath9k/init.c         | 52 +------------------
 include/linux/ath9k_platform.h                | 51 ------------------
 6 files changed, 6 insertions(+), 128 deletions(-)
 delete mode 100644 include/linux/ath9k_platform.h

-- 
2.46.0


