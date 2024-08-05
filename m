Return-Path: <linux-wireless+bounces-10902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C550394734D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 04:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81219281020
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEB63F9D5;
	Mon,  5 Aug 2024 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+MtMLIH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5542A94;
	Mon,  5 Aug 2024 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722824307; cv=none; b=r8eL7RQwTxpF2MWuXWiN3UD43VEUTgVM2qWCN9++cNo39NCNXt+dqQEDdNsgBBUPxllehP9ees3sBe1Ij4DjqZxIzL76I+6BcsaiQkux4QXL6iYhVlBhxU/V2Eh3Lk0y6oaNctmdukoMbhW2CscHowJH2OXsyF89sdAq4td+ysQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722824307; c=relaxed/simple;
	bh=jT7CQvRhW8taPMY4BcCMX2qVxPHm0tLcFeBHgunm6IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dIYGzju0Awal4Yk1yi6T5FMkzUOk7KKT3XPA+W4BRU4ePEcv0yAcAONE6kYwiRkxqMn37V5raTeobG/2MfLozNKDmaDjEGd8/b7Wsm3DQIQLtZK5VG0tlEgazUxQ9GRD3Pj3L2o1xcVhv7xA8M1Zu7b8keiwdkWi5wibLlU3Tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+MtMLIH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d18112b60so3880179b3a.1;
        Sun, 04 Aug 2024 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722824305; x=1723429105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT7CQvRhW8taPMY4BcCMX2qVxPHm0tLcFeBHgunm6IM=;
        b=c+MtMLIH/lbocbv6hTkt0ptk8/d/7aiX6R9c0Jzm8v2I/91YUQ9Pzkw7NjRAwXXHMN
         wuP5xZOAR8OSnhJGlYXL+N7zJmq4D28UuRjXNN8/c5B6fVb6+xXix+o3StTlp7//4xzz
         yCNWtutTBfiSZIMWYcyGZuMa19N21MAVXXSQZHZYxAh5ZTBIUN/FE6cTImpjRAFPVrUh
         XcKwWLwM1O2sqrwg9zhxCeBUMogsuCR3zBHMA4EsdlVp2hqMlZ/NvtywJXMGM7SSV1Gt
         p9CH98DFgkxsYJRaqYB57vOFIf1E0VzoMT9mcwsjhA7F3Lv3pmCAdWZBIF+1Gg+aOl2n
         rIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722824305; x=1723429105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT7CQvRhW8taPMY4BcCMX2qVxPHm0tLcFeBHgunm6IM=;
        b=HjvLOlSyTYhsKQDPSw6FdPnOmxxZ5NJY1aso1eNGzy8f0J5McZfzKgGeUS2eD46snR
         Bf33AJEuFZcspFLkjjhxgGkKztM/eAxLj7NjglZ/Nc8dZ1AenOdQbhPsR3CbG8ZCrAqd
         IwhEUNVZuHnQwUEVzk/byR4iShQh/xOTf/HOokn9Ev9U/IJ45A286O8NTokI9KD8b1hL
         Oh99y/Ty51EJ8nHjJKRh509wcZcFBTr6F5jfJKxkTHUxxpKMUdzcFeXd58rTCUXR6VcM
         U0BZC7CtXxvWiNN5jRxFUJj+cCKARWCyQBYJcQpFIvbRKZcgjbKgU4AnSKXwzXwGfwl9
         qykg==
X-Forwarded-Encrypted: i=1; AJvYcCUEU14YgvcqQoQeRZCZ0wsxfwrT8IAK3z6YR15uSjx1SktsgeGSDbplOX8aC1MGwOCiHdqQ6RQZcPfOX8RX11Roo5n8Mg/c+ZU301YX7bHdR+9IlbGbZnNQsnw4MWgm5Wr7nIFE9BY+IJ1n8xEQUNBhLBwyEF3YgFUMy1f66oo+QanTSeGgnYM=
X-Gm-Message-State: AOJu0Yx15u8ZiHp1oKNiU8T5QnIo0+bXcHA6Tn6yuI3thpCa8jog6w/6
	Ja5GNbXEInpvesGtcn538f42G+W7wNcR1m9RgzY6N+hAhkwY2qk=
X-Google-Smtp-Source: AGHT+IGmv8HtpX3mOmL8aLB0jq6Pnp6Rj+WYd8ikUIFq5559iKMNNa6zYN+uyDbgmkzNtwZ8fhopwQ==
X-Received: by 2002:a05:6a00:6f5b:b0:70e:98e2:c76e with SMTP id d2e1a72fcca58-7106d9f5bb3mr16110775b3a.6.1722824305186;
        Sun, 04 Aug 2024 19:18:25 -0700 (PDT)
Received: from swift.. ([123.113.245.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2ce47sm4487683b3a.203.2024.08.04.19.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 19:18:24 -0700 (PDT)
From: LidongLI <wirelessdonghack@gmail.com>
To: gregkh@linuxfoundation.org
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mark.esler@canonical.com,
	stf_xl@wp.pl,
	wirelessdonghack@gmail.com
Subject: Re: Ubuntu RT2X00 WIFI USB Driver Kernel NULL pointer Dereference&Use-After-Free Vulnerability
Date: Mon,  5 Aug 2024 10:18:16 +0800
Message-Id: <20240805021816.1921074-1-wirelessdonghack@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024080359-getaway-concave-623e@gregkh>
References: <2024080359-getaway-concave-623e@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

We tried it, and after configuring the udev rules, I can run the proof of concept (PoC) and reproduce the previous issue without using sudo






Best regards,

