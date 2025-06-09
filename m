Return-Path: <linux-wireless+bounces-23836-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20FAD1742
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 05:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969913A9DC8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 03:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD8213254;
	Mon,  9 Jun 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8kGqSZ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D911442E8;
	Mon,  9 Jun 2025 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438537; cv=none; b=ali4PIxTqu2V91qGFBozqg7GcQGD8RNvUEz64YVqIX2bU7fLk2oRrtpDdzPSB1WZH6lkTQ0eXyVZDgyYpe/JHxQnCIomOfr7Vt7isXKU+mKe5e4mow2VlU0axD8CyGVGfnkTAfHq8P9c455zmKNM/cYLnV1tMmH4S4Qj6jVtv5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438537; c=relaxed/simple;
	bh=G1ugksUD70dw7VwPdWruYsa1CRY8GI4Ngi4CaKI0RwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRZe07qzj2mcmq/qrBQV4LSXvl2DA7Rbey1W7bnKE8iPPnDLRDquznmE+6nAUFc0TNGPw24OWYC7xAxPM5ifWLWueB50T6ISVJTsBCIl6378kveAK3D5eAeFr3nWmu8YFzbWLfHH6MTz8guSFyqiPgTW61t/o/wfCuguO6n9uzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8kGqSZ1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23228b9d684so39251975ad.1;
        Sun, 08 Jun 2025 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749438535; x=1750043335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TiQ/BDrbHCoVEau1+y2DDgfhGTvPVaPbBNKA6TyEfTs=;
        b=O8kGqSZ1wBzBfikAgJprUWBwmNoqT9VxaWLPOoeihJu78cStTYJgz5mXP7HrJpcFOr
         /4HDNENa6bWEId3TTRAYRNkX6hOGT1J73Mrw4pDGrM/v97AVEbE0hNvOCa2afgjowjka
         UP1XkudoWsZGJSzZ9LVevy4uyqgAaXAp8ZAROI1TU8ozS6mV2AFFjY1Mjhqhwtu8wwyR
         NKYl6TRS5pK39IW5yp7clR47B+TMJtgHDgDbOYPDSCNzJX1FXsGtEAF6ttncTkP28LZs
         6nJzhzal7DSljQBNPLswKF6fKO18SdpdIbmqRhiER8MOHeqkM1x9DjrtlUrMTMh/ZjNv
         d1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438535; x=1750043335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiQ/BDrbHCoVEau1+y2DDgfhGTvPVaPbBNKA6TyEfTs=;
        b=p5xohNrPo4veaRsHxiM9a6QiBr0OmeKcrR8E5k3pu0xMqU/ISlLIe/dEST+MSpCd9w
         eW7VOZaW0w6kzpwGPgLiUE32+fx9JXLsWWhElQ1on7iT/K5z68OJhvKqo/rw3Ql0pCkM
         ZzhmQyNC5pyqbnkF6yDXCH1C7uMUk+H6YrAQMf73fVPS/08cRP+wDFRdLgLhvEqkeoQy
         jCyOc8NZwEc+6neVZ85Io7nlcJLVLeTmFgn5yhto3xF0vA6zaNs1KeH5fpZlWHTagJ3R
         shjUj/Ejab4gRJKLPzhOA1AIt7dYo6vHIT45a8R3weTjGpW01T6nyNsamm+kIsHQP0dB
         SadA==
X-Forwarded-Encrypted: i=1; AJvYcCU3mZU3ydp0+1UEpijtkVOlNjb4Z9ojJ5yThkVjTjB9C64ryO23ORz2NY0rJRjeC3Z1G+dHCK1aMU725LaI@vger.kernel.org, AJvYcCUXD0xgZuOyAJRoN3JWH0VUKbLebedv77Chg6iZpLLUh5bEKj2qBYMcIYUs5Oy5UhXDm5yxrXxPsRNb@vger.kernel.org, AJvYcCXqWWmOcYzCQXrXp3h2d8VpHO/tY3slKI1xYesIlKih12hnr4qGH4Nm21PKJdxJBHouaEmtgWubhKpDbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YytrG3+N08VlwZXSUN/Ap1CMkOmB4XefDI6CM/+2Ut7iikY3M+u
	lit0q93ASu9VQwakyT4e2Zd6qZhua7QSpdvZ0cDRH5Udrdk4P5qPF4Oy5ZyGbg==
X-Gm-Gg: ASbGncvdzeMWm/m3JAov63VUce5xBBuqq0fP+AonlZ0Z9asyl+xSE2Ec5vHcN8mCyGb
	Vt7+jzb3UnseYyOrEbSmrHsGj03wf+7vmPJoj5kHVc/tqKJWxPjZF6Sj2mKw5pMBwBSDLJjvaSl
	QmjUEkq2EO85rPYAbGAVcswo0CmtbX4K5KXZQiVYBmiQoWPi2TViSDYy3L2eb/xtkIukpbVbPcL
	2MLBrHie+rDDQNecH5ipXKitSUjOERfdB1SF8bED7Jr7Z9ViFNT8Tc/xjL5jtulGEO+VCasUaBj
	zLhOXXvC9KiWJGtlFtCOd4EYVZ1o2TcAR0LOLx1Yb+eyswYz
X-Google-Smtp-Source: AGHT+IGhxdx//dqJ222EDb/aL1JQB44t7nuKf8VuZeMiQzxZdIuIRbRb0DfNlDHtumArzNYMpYWwAg==
X-Received: by 2002:a17:903:22c7:b0:234:bfcb:5c1d with SMTP id d9443c01a7336-23601d71207mr171632405ad.40.1749438534362;
        Sun, 08 Jun 2025 20:08:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fccd6sm45310125ad.134.2025.06.08.20.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:08:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv5 0/5] wifi: ath9k: add ahb OF support
Date: Sun,  8 Jun 2025 20:08:46 -0700
Message-ID: <20250609030851.17739-1-rosenp@gmail.com>
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
v3: Use qcom prefix and wifi suffix as in other ath drivers.
v4: fix up dts example in Documentation
v5: move back to using qca prefix. It makes no sense to diverge between
all the other drivers for MIPS based qualcomm devices. qcom as a prefix
is used for Quallcomm's ARM(64) stuff.

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


