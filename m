Return-Path: <linux-wireless+bounces-26664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B4B3764C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 02:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637285E441E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 00:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02F1D9324;
	Wed, 27 Aug 2025 00:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeLoaEPU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9789E30CDA9;
	Wed, 27 Aug 2025 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256224; cv=none; b=YW7jSr9h5SsH7acke7f21U5Xs2yle+m5JapVj7Q4tXNZdM78WKygLZVkbws+0hr0JbO5wzYb7GfQLT7IOq4p4YiT9hS68Ip+/KgSgZL/0YzWDaGnC+SzP8v4E7bp8mg1w6TJwW6SMo/4j3sDjHNamNU4BK++lXyAO7Puo2Sm2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256224; c=relaxed/simple;
	bh=FYlh2GJOaVKPBinGP05HkJhjokbw6IALjjGm4apQT8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzRHGMjoPOi3PrkAVCe6ngIBODf6DEXI+oU8acsE0RFZvTv1ZZAzvW85VLGE4vO9SrNpz9EE9nKXLvC66AzXw5U3gzB6o1UqybS1ZaHlT5AlwTEaG22ZAOUnlOXsIVFRcoO8wYRin00uDuHwyjGvG/KLjKkJOwwFnFfBrBQXZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeLoaEPU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-771e4378263so2432230b3a.0;
        Tue, 26 Aug 2025 17:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756256222; x=1756861022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Im8soB73AXrzk24pvs5u7Depffka0aCpKIrwZ80aAzM=;
        b=HeLoaEPU8gQ0IKRTfEGtdoQRauGy5RBQ+PMe6Zxs4MQA1a6+SycGtDMnAVuO6U+DxJ
         OfutomhYKW+nThF6QJO/3P/KaWVS6utt9Yzri7qgmwH7E5Om/zEWCH2L1ZV/jaDXcBHz
         ipIi+6Gp1/AHkSL2E7B/FMvifPG4Eg7Gr5DXi8uAtcH6/zsXgcE5ZCahNl71EqKcPP4G
         2lPkz3lPFha1JPEH3aNes4+nLbiYvpk984RwvrG8lPTApIW8HbqiH1zg6uLqEdtgn0Ya
         JgEpq7U9D86QAwB6iVUtH+kBJXDg9+TJrGL4zutpPUAK45zmvW1yYHTaiL34TPew4TRE
         z0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756256222; x=1756861022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Im8soB73AXrzk24pvs5u7Depffka0aCpKIrwZ80aAzM=;
        b=eM1NVawLwg6ug8U74+CN6zGMRJSz0my+iiu0Ac/4HizPPcQXjd59Owy0+UAaus3Xk6
         T9ipfGDxOVEzmzMuis4WRHYB739jSRpI21tt7MUu/BOgDJPWLt/djwwQN6XM4eG/bxgv
         tNmcrXXIpZO/pXiWmdD7t5bkUGoSsmfrDE7tOo9jvbEOMfACEUO5RZPtZT70WWMqhFyi
         LyxBiOm5KACymobG3yO6vaG1dc/yhyQB6KBm4GL5NuYlfRUyQWm/ccCglnyhQs7cphE0
         tbpeB6nFU/E48b4AA4DXSZEt5pUr4GUllV5T78kXMeAdf+uznnXVxI0ggnk02ma4Ibm3
         PI2w==
X-Forwarded-Encrypted: i=1; AJvYcCUpqiJgqUmm+M8sQxlwMEykFFGeCVpWh4VeqMy4m3rHe7dSlLzrCOsV/Nqek2JqipGGcZjCPDyHrbJNGQ==@vger.kernel.org, AJvYcCWOTtZp8rOj5bOgugOqJwQlRcaRLKXwf4+7F4P4jw6Wgt54/r31wjY+huYrSq9qcwZaaxnmjT7Ka6AW@vger.kernel.org, AJvYcCXrP85EmMxgk2yvuxgTQyYfx7+qzCZDEf9FbPpPrTNKdkxJ/jfauJxuFjRGK7c42XxVp++ORKiqXr/+w14v@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8Pz4U6GIpHrbCvmkDpa0nTWdPjE6vjdTHcWI5w83/Qlk/u+z
	VYbI1XC7oCO+YqSPYOjcvxnQ8Dx/+XbC0Ge2jezoeNdxvbE9Ngrjt+7z2THUAA==
X-Gm-Gg: ASbGncvaFn4sjemd89LrGJjt5nxiPKvm2P9JVpw+SIDTdDRO9BBE8Fa2hCCABnNuxtN
	SHyzD0kKJ0dGqUe9sSrgD0kEAWqkjg3D/wg5DFbodIbuc7mrKBs/XQhyRpWqnIbZvLCDIs99sl8
	KeF78RLhqhL51jYuJSGM6xi7VbfXp3bwXslE970vbZ7xoboqMP90L/RsasZxBu5E/Zh7Pa8ZlXs
	cXZyc0zFnJGsK813eTR+NmwUbYpkAZNAjfJzGTnDeUNeajRzh/yIEqKC9bAqmSacZ3jvTEFcXuK
	ePYmuQYaWORWDa8SFLL7JMn7BJq2Ufc8ekrrjh1iJJxxn4vDettZaKdGGbg27qe5npkk0VYdGyj
	YiL3Uhi/F4BeKtmzF4qX0DfgoOi0RI7E08Qupyklyud4/V2D1CQPA4srlXmS2Adq8/A==
X-Google-Smtp-Source: AGHT+IHejbO69rvncZTX/bX+quJ+9gX+hMNel3u+15JOMo0DEK1nYzLrJSA844VVS0CKYaEyUkgTsA==
X-Received: by 2002:a05:6a00:178f:b0:770:5736:4ecb with SMTP id d2e1a72fcca58-770573650bdmr12867009b3a.28.1756256221549;
        Tue, 26 Aug 2025 17:57:01 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77057368ca0sm8382515b3a.58.2025.08.26.17.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 17:57:01 -0700 (PDT)
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
Subject: [PATCHv4 0/3] wifi: ath9k: ahb: add OF LED support
Date: Tue, 26 Aug 2025 17:56:55 -0700
Message-ID: <20250827005658.3464-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A port of the prior platform code to use OF.

v2: use reg instead of led-sources
v3: fix documentation from v2 change. remove of_device_is_available.
makes no sense for it to be disabled.
v4: add back leds/common.yaml in documentation and rename property to
led-active-high, which is more in line with the code.

Rosen Penev (3):
  dt-bindings: net: wireless: ath9k: add led bindings
  wifi: ath9k: ahb: add led pin OF support
  mips: qca: specify WMAC LED directly

 .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 10 +++++-----
 arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts   | 10 ++++------
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts      | 10 ++++------
 drivers/net/wireless/ath/ath9k/init.c            | 11 +++++++++++
 5 files changed, 40 insertions(+), 17 deletions(-)

-- 
2.50.1


