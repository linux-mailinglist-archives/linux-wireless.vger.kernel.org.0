Return-Path: <linux-wireless+bounces-25878-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F3EB0E573
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD39544833
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F96286D69;
	Tue, 22 Jul 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ochs6KvB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196F27FD56;
	Tue, 22 Jul 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219741; cv=none; b=BdQLZv9ELbHBbDDPhK8cnUTaZxwitv1rcyAwBUA5MpFjmwWUyEMP7FP3UGBI8xd73PFyUCxCwBb76J/KoJQYX0JoBKR22JfwdgeFpLNJ59jdEtTtkHPSedPnvKaSximoeoUmGy010+lrpVwG/TU1NbRjKhVyMmJp+z+vXakGtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219741; c=relaxed/simple;
	bh=+7qBsOdy1wA82Q11XxilxhrlLkSDeuVOQ8n3SfUZKqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRffnAvUw9TgyMQ8IDCpTlJWbrz8ZHrHZrjfgpB+FNoua8+rFPLDCFSY4+HoQrIik3kbZy7q48RVY5OXoJ92+8qyBzhujKgocd4Jqp9AokB3wCJIsNJY/lLHvg+t8cOk3SOkWj05JoLoGyNgvk3pSdT9NvTLBlT6PPIERkVLXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ochs6KvB; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso6236790a12.2;
        Tue, 22 Jul 2025 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219739; x=1753824539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPsJ4CMcMe9NfhSzbVCOjzfDWB1kVY5Qa247gGHQe3o=;
        b=Ochs6KvBJRBp94OKtWYHVIkZbqh/4d+r/C2hJvtSXt9h2K07datBe2GEK83JY9s1GT
         HzBCzxt1HbCdsPkLK11h8Lau4XMAOeFMhOVvzg9dcYGUUOkJTJBVd1TfR+OoaMLaqopD
         QiEyrGCMG5qHUdeVpfd2eprKNP6JZcmRo1W8mxX9JOGcjtUGOvc7Ze2F+839mq/SSqNy
         PEjjRrCO3931q/JEPCVAEftwOxmGFmcsTsooNVMW1tWlp49Et2+h6RDM1pwmvM8Aab1c
         6ZIcCZ4QaczYqCni3apLhThNJsD5qxCwNpOXS0bF7V6e3ktuZB6QiHGYOuwMfqKHd25+
         7weg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219739; x=1753824539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPsJ4CMcMe9NfhSzbVCOjzfDWB1kVY5Qa247gGHQe3o=;
        b=nRGVNNIlw9GOIPVozEwR9lo7AFHifgNUPRbg3b0TFpHVOGjqBjUP8cs/s1i0Q+trGP
         wyiRVrE77CJQhWgHbA7gFYGYGrnDXi9N7HWyu2jDjP9AiYFdOCXT8dKiPbbB30TrQFnl
         EY9Z4I8+j6332d5Kcu722b/FOe/9ReOeci8J2V+LScjui58Tv9VeS5+qLzITCB4hk7q0
         CtBXfIeHLsANWy9K2O2Y6Fe10HHtQ++BTK1GGdH1HUX/fZxX8IRXWyk5HPC3CyCHWWTi
         oCEsZd7RajLPY0f5vErbONFDnyUaE7kBtG0KxjqlUxPU1jDVLeauL1YRT/ocA35iSXf1
         f62g==
X-Forwarded-Encrypted: i=1; AJvYcCUHiS3TM0MuTah7Ca61j8pQx82GvbepQbXjycL1UQr6wb8dWgZVHpfHdV70OQwxIloZMcb3qpsgNzos3Q==@vger.kernel.org, AJvYcCX1RtfcI9otEvfEYQKfBWb8M3GxxkZpyLqpn3qsK2qA/PvTcQx7ok+SP5hLFDcyqNw4wrlt9sgJiXt9M7+j@vger.kernel.org, AJvYcCXoUmEW5bruRCKmA308dKdOK6NNuctBap7KUrAP0oEsAYpjR2qZ/j3rwwN4RuBK6CfJvPddd4oV1AUW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz423lp1mw3qqByB/hrzqGS/IzntT5s/Th29Qy+abL3ds/qoTqE
	8bHzGKznXBbgF2McSzk0gWO6ArX4O+FraIktU7SFmEL51Mu3XgZaXd4b5EyZFkmJ
X-Gm-Gg: ASbGncuq55kCGlagMQQP1eNKIO8GB1Tdmhie4JrTwnIIf6nzd/NX1HyZXIP/aYrINZY
	QSW3gnuKJqmccw6yTxj2HlYEBMpnsuTVIzWnyfw+OPkTYNBbmq/qf+q1KcFkncWCPyHPuI5FMuG
	ke3EVznlM0IeK6slBI8MqlDIy9pFo9uzZH1yKQW1OvJBl7rZQzj43dMQ7n8YULsVQJdmfOtmrVF
	DML79pyOk/u3YBz6I7wl13AtrMbF5V6zWIkNIDZvuqKQCX0ANvKu+QQV8txHI32gxfmK/Abjzf2
	uOjg4XACl4YevnL0TQBV7GF0QVH1OOFT4yvTYYmRul1zg0pzZrRdNLmSWEQJHReCzcHx9UXlut0
	WN7iEFyoeVD2GrA==
X-Google-Smtp-Source: AGHT+IEbbYJBzvZDQvAsIkV3QlZ0kiIfsWL443r6EXrQLyZIxgWxL6sqZ7lB3fbfVSpJVV97L3dmqw==
X-Received: by 2002:a17:90b:47:b0:314:2840:8b21 with SMTP id 98e67ed59e1d1-31e507fe4femr824094a91.32.1753219739276;
        Tue, 22 Jul 2025 14:28:59 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce384sm94942a91.2.2025.07.22.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:28:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv5 wireless-next 1/7] wifi: rt2x00: add COMPILE_TEST
Date: Tue, 22 Jul 2025 14:28:50 -0700
Message-ID: <20250722212856.11343-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722212856.11343-1-rosenp@gmail.com>
References: <20250722212856.11343-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this driver is for a specific arch, there is nothing preventing it
from being compiled on other platforms.

Allows the various bots to test compilation and complain if a patch is
bad.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/net/wireless/ralink/rt2x00/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/Kconfig b/drivers/net/wireless/ralink/rt2x00/Kconfig
index d1fd66d44a7e..3a32ceead54f 100644
--- a/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ b/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -202,7 +202,7 @@ endif
 
 config RT2800SOC
 	tristate "Ralink WiSoC support"
-	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620
+	depends on SOC_RT288X || SOC_RT305X || SOC_MT7620 || COMPILE_TEST
 	select RT2X00_LIB_SOC
 	select RT2X00_LIB_MMIO
 	select RT2X00_LIB_CRYPTO
-- 
2.50.0


