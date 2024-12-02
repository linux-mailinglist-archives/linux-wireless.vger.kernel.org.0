Return-Path: <linux-wireless+bounces-15812-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE19DF971
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 04:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA439B20BB9
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C71C2B2D7;
	Mon,  2 Dec 2024 03:19:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34952AD2A;
	Mon,  2 Dec 2024 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733109573; cv=none; b=MNtRSM4G/v9YbEED89sqRMl55F6wkmblYTTg/LnLTfZC6zS1ZwRgVvbCh8dHHsnOWRr6ny4FMw3zlrTLcN1qw5vmTw0hI39yvgX/yjzARlPSSZzZPvYaB8VZp9WjNH6Pd2pwE82io5jVHHWfyl/Mz/nUWKw6/Nx6AMTm9aazKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733109573; c=relaxed/simple;
	bh=T8kT3+QsTp4nMh6Sh1eZUOJcDUdQAKHn1KJfgRSGEec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=exmqCTBIvmA7EhBUHDSeqJFk0fPCiQ7tUuX6j5q2BR21MCXpAfoAB32s6Z1XceO9gT+XBZL8Xa0Fh4EhNebzwOWyQ1boP+e9PDY5XChjyYHTQk4P1Q/h8QZgmB1NprmB5pgHFP3vQuL3lPYCQW58CrtTQXC9RX0YVZuPHJPzTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so1842602a91.0;
        Sun, 01 Dec 2024 19:19:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733109570; x=1733714370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vh9tD9SrY2g72tru/wF+GzXI2rvH2WwAaYCCUwc+uu4=;
        b=b2m2kJNs2EvH6zUQMHnaAwX6tJNsa0/cx/OCFFD8GqfYYe4tQDdk8G6pefmaxQ1wm2
         WJPopTWh9AVpplId1BFxfD1eYc9lsUf4XOTkmIUlbsrH21Vzb3qte1HPDykwrIbmb+Wn
         RpS9UZWsqr9H69bOrfQxPR6cBoChwrGBUFN9N94P5FSZ4Nr//eQEZ3xLOT3WnDrB0hhG
         Fuwv2PasgvwaNQPIpkqx8QzJiCT6abDkgC40Bvw4qHoESuZcvRxin2SIiud4HVdwGT5q
         YoRkD5UoSjTb10eBiIffZjrMl+v/J/IqMAH6cVM92g83ILw22kFFGRaH3EzlhL9AO91U
         A7UA==
X-Forwarded-Encrypted: i=1; AJvYcCVKRwZnXKbKzsNNmKYjxXsFvpQOlNp0He/2wgg9h6hn2YCgnflH/DJHoveeZfvdVG7a1Q9hwvhQ0Jod3i4=@vger.kernel.org, AJvYcCX44/ZsT33SAvmYGs7oyc8bT/RXTbgrXNnF7qLFT4zuz9yfMt/ECLUi3B+q8UBEV/p9I364eu/hZg3iLFQgsjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HzYtpHXoXcbO8v618a/pkJkwW77YP2sSKxFJepAOIgS4AQte
	7TcSrNtxPxruZzBr1DUZ51K15bc6/J6sixB3svqa2u5rIHW2NBY+
X-Gm-Gg: ASbGncsUtJRUoptbwDjHG5EbkxZIUpqnwBWLiPPQFtr6XUJ61Mjzs9HPIyuNA59zaOp
	imuZLpgNnolthn/jfU6ffD1x5soB7hhhguDofH0yVE0/Cj6vFlf99SG2ItzFyXFIeoNjS5zborC
	HQijFFEEj11PHGLwjR72fyyMqmpHh/4WLyIk2lcCh/VIDyDRLwlSbT5+Qj1qf+9J2XeU+hqOX5s
	Q4w8YUVLmlpHmUoS3vUIEG8ww9UTDinW16kdRWU2m77ZvxofdfEjSYBfCx5iImGiDZXxZuE1w==
X-Google-Smtp-Source: AGHT+IH7C1NY/qRNbiAs+CizDGqF/VvpgeXetIUzpHeXj6J4+ZGypzWJxzoRraQ19KSnD28F1l8fQg==
X-Received: by 2002:a17:90a:17e6:b0:2ee:6900:1439 with SMTP id 98e67ed59e1d1-2ee690014b1mr15752762a91.9.1733109569845;
        Sun, 01 Dec 2024 19:19:29 -0800 (PST)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eed19aa971sm540723a91.1.2024.12.01.19.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 19:19:29 -0800 (PST)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: howard-yh.hsu@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	StanleyYP.Wang@mediatek.com,
	Bo.Jiao@mediatek.com,
	sujuan.chen@mediatek.com,
	chui-hao.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	make24@iscas.ac.cn,
	xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next 0/2] *** fix overflows seen when writing limit attributes ***
Date: Mon,  2 Dec 2024 11:19:15 +0800
Message-Id: <20241202031917.23741-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DIV_ROUND_CLOSEST() after kstrtoul() results in an overflow if a large
number such as 18446744073709551615 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.
This commit was inspired by commit: 57ee12b6c514.

xueqin Luo (2):
  wifi: mt76: mt7996: fix overflows seen when writing limit attributes
  mt76: mt7915: fix overflows seen when writing limit attributes

 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


