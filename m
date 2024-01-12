Return-Path: <linux-wireless+bounces-1777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C120582BA14
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77421C23DA9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9B1B27C;
	Fri, 12 Jan 2024 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="YQtN/whC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7F1B27B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d3ed1ca402so55208275ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 19:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1705031004; x=1705635804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kDTe6dq4ZbdCI1wHYvjq/AoF72v7AhWzCodCD9/4a7k=;
        b=YQtN/whC+YehJZsp+mJTsFUDnV1wMUlw7qnxd1Vt5nWFTtdGihIN5Jt7tPl+ACOxy8
         Fo7efdG7D7gf55Yt72/5xQDMMGT+upGkE54Zx3HOfUJZIq8XWI4P+QAjiSGwWzoSfXib
         B4nxkBmAyFG/MadERlCduk6ml0kctb+NJyLCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705031004; x=1705635804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDTe6dq4ZbdCI1wHYvjq/AoF72v7AhWzCodCD9/4a7k=;
        b=Zd3B4uLt8ucak51gQORXI7+XFaFvY2JVW1g0hziBYacTuOeslCWUAp3vNMX4WFUix6
         3t/LmxRBkYWKZAGJWkgUcScsX2PjenbTGkpka2q3CEtHVx94kWdMplQN6hxn67raVUzS
         mtUMeb+lvGJU9/a942aTapHMIaR96hbWHUwj0Zd5qy9Ypmylzeq4scTaQeCoQFuuAi2M
         E96ds5s4DIykfh7PiwjMndbeS3c9FQBhHHc4J5OM0s/yGxDgfnHs4+DWulHspI+S2BSE
         T7NFmEtptKhwK1xThT9oSQMFosdGWehlU0ILRlZoFWej1Ly6EGGXja4WdBY9SXS7e63W
         2Txw==
X-Gm-Message-State: AOJu0Yy4PJuIRCT0e++yHjVzcPvCnocnlFG0UUpHxwsa9p3lMd36o3y0
	QTdhm5QfDXEHydWTJMiOWrT8oFrq4NXH6jhsDZ+EPa/vs7Qa
X-Google-Smtp-Source: AGHT+IHD12pOw4meQQLHOwjvuDUfGikCy2nDIa/z4zY2svMy2hx/99tvMbCPC14k+WetDUB2OqihuQ==
X-Received: by 2002:a17:902:aa44:b0:1d4:c445:c705 with SMTP id c4-20020a170902aa4400b001d4c445c705mr367513plr.26.1705031003810;
        Thu, 11 Jan 2024 19:43:23 -0800 (PST)
Received: from p14s2i.. ([2401:7400:c808:b52:9565:61c2:9ce0:d352])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001cca8a01e68sm1943145pla.278.2024.01.11.19.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 19:43:23 -0800 (PST)
From: Andrew Yong <me@ndoo.sg>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: 
Date: Fri, 12 Jan 2024 11:40:43 +0800
Message-ID: <20240112034311.23677-2-me@ndoo.sg>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
  - In comments relating to TPC, provide absolute mW values alongside relative dBm increase
  - Extend (5470 - 5725 @ 160) band to adjacent 5730 MHz to enable Ch 144 similar to US & TW regdomain as opposed to AUTO-BW in patch v1


