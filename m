Return-Path: <linux-wireless+bounces-23320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55CAC138C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E764E6CC4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0393E1A83FB;
	Thu, 22 May 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdKMqfbf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF42AE7F;
	Thu, 22 May 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939520; cv=none; b=ZhLjpAG/KXPNJzCt1q8SBk0QHeb2AItMMjEuDc7TUsZCX5sEq5EB648ghT1yFeKFwR8+AiWDdu+hKFFRxAouBd7+EcFEwfgN/wFz8Slu8NggACZ3tRox0/wBDLQfRcumDhmwDqyB5gAf5BLnLJnxe0J7WulOdVlbpn4BVi8NW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939520; c=relaxed/simple;
	bh=wP7ZgUCLjfdfBFrCeaXuLW218dXqDVe2vcNavUuWQJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ityz6iFQLMsfG5dETnJboXHJ6AKnH+JWYY7xm6ONTqBNIbfBWnNl7EK3ZOg1xbC0MFAYl1ItjZwMlbPQdl9vX5sSBQdHEZpmbLVd7ePOFSsnnr3yk5JBBlmJb7UyyUkAgxsS1QjxcYZ0O3PWj0jxye6XZx5nqgQnznpNGot9go4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdKMqfbf; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7376e311086so9744874b3a.3;
        Thu, 22 May 2025 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939518; x=1748544318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHrtgk3cilwDlkLgJATNxCKVWDqyvDZFwi6EiNKD/0M=;
        b=XdKMqfbfrdBLfA682g2Ekd1A19s/UGqhuzf1PUUqQAg+Ccx/HLgA+KhF0uqapgRJLL
         mV6eIf6rHYZ6l3ZNrqTZhZjP7uSgPtjmCQL+ZEGOzPTzGPgOmDqdFz6mJ3yGBXK+kOKU
         DzXEMEBmqFA/ZxFEjYlpend1FUn2wqJxoSuGvYgSLhP0MPX918NJQ5mtZydCmllORe08
         Ty58cCarzRi9Tu0ltqbjB1w912Vvu/2dHMoiMfsr64FNj2PnlYV75o8ZjMG9QupNosH1
         siJtSNj2/8kzzSPIPpSCajcnazROWXnGSl5HQpOKlPWH1jTWcXCaNVb3TTBiaH9vsUFy
         lzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939518; x=1748544318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHrtgk3cilwDlkLgJATNxCKVWDqyvDZFwi6EiNKD/0M=;
        b=jCGFQxP4Pvyamke/DqwuBTeHusfJEftci/pxgqd6gF6VvHjVpvZ8Et3JXYSJqv9+2d
         749gXd5SdsuSHzky7DsaNl0JauNNXx7JyO4YA/RZRIxLXOeW4dIN/ncRsyU6PpnObQw7
         VtYMaFuNXxX38wsjbehfeQFs3EWY/Zx1LYXYRAVC80tSm8loZQA3Y6hVtbeCiKBKLTZo
         /beBLcxexZ2pZAZmSYLLpS2rQcs7NN0rSPHu2bJ0nn8v34AYRU0fS/Q+bEYcdLLrVO7e
         L4zkP3lUngJT5i3y8QMa6TNOoDZdIQKyuNOmuZkEVbWKOYLsL+XQX6L3DD7t/rE9CKH+
         8kYw==
X-Forwarded-Encrypted: i=1; AJvYcCVskp82umhzIG6npLftdeE1fnLUTs7Z9owyFpMks0lGL8tAUAxSULaVVnYJAlLnLbNizAeB4vQJhKLMTQ==@vger.kernel.org, AJvYcCWFlaupUoHQ9Apfs2VPdpaGHfSGSTHJoXyIvz3C+7THt6oZTeBgFWN5h6HZ485dDl8ozGAeUVDd/WvOlrB2@vger.kernel.org, AJvYcCXs3d5JwFs/kbem70QFhC/ovxX1U3CEjvHjP5bGRUEK+FJAgPiU8S0dhGc0r9mU30/ak9p/sMK+30X0@vger.kernel.org
X-Gm-Message-State: AOJu0YzuRJbEOwoBFh0NcHX8wX5nrOht2a1Trss4ePejvIOiDqjASXq2
	ny5bh8sDOVrnbRfTiKFbM95l6VrDcggjlIz/RfMFcDq0r8XQfBJRTkWoePMZbQ==
X-Gm-Gg: ASbGncsnSb0cf3FrCngHAvKuzWhXllV5kJliorh5sm2w2Ihr+8E2sqxZFtSnZQD+U7o
	rInBLl0DHTuiYoOlktL/5IbGD2l7jIS02piBuszA4fOn6Irw/yLsqKeLGDfTiSbBLEusXjbXrqY
	Nudd7EdSaOwylOoMc4BKvfdquufKLRVXFpVq5lC+bO99qMAIrqEcrxXzu/7RbLTzXC3AnGoNJ3Q
	oIMAqhxcd/lUJk25adtOb6bm2QP4oLnQijYhj4fCrzaWOdQtlwMgokwK3EnEfQaaCAztLpE2YME
	rJZ7O1XK43enYFHxzVCos+ap1EY=
X-Google-Smtp-Source: AGHT+IGSdjFB7Jabutdy6tfoYdoTwoUWKiWnrBMyjM2b7Ojmp9Vl71heLBXDgO88JqD+QaVZcTzlCQ==
X-Received: by 2002:a05:6a21:9012:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-216218c0554mr37375687637.11.1747939518433;
        Thu, 22 May 2025 11:45:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6fd3bsm11502424a12.23.2025.05.22.11.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:45:17 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv2 0/5] wifi: ath9k: add ahb OF support
Date: Thu, 22 May 2025 11:45:11 -0700
Message-ID: <20250522184516.13176-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First two commits are small cleanups to make the changes of the third
simpler. The fourth actually adds dts definitions to use ahb.

v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data

Rosen Penev (5):
  wifi: ath9k: ahb: reorder declarations
  wifi: ath9k: ahb: reorder includes
  wifi: ath9k: ahb: replace id_table with of
  dt-bindings: net: wireless: ath9k: add OF bindings
  mips: dts: qca: add wmac support

 .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++-
 arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
 .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
 arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
 arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
 .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
 arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
 .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
 drivers/net/wireless/ath/ath9k/ahb.c          | 60 +++++++------------
 10 files changed, 84 insertions(+), 41 deletions(-)

-- 
2.49.0


