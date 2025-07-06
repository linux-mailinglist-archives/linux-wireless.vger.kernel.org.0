Return-Path: <linux-wireless+bounces-24852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C1AFA7E5
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473D43B6FCE
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60D01E572F;
	Sun,  6 Jul 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjyRKWZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF2819F41C;
	Sun,  6 Jul 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838075; cv=none; b=XVpTs4kZPznLPDh7+p5tk70CLsoywNjYGHTxrhTZ93frm6EqDRUS6FQRnunPj2n+zbK8Ib7Ab2X2IpDxd+nq2tN5cfM8yxrnu6cej4yGYG8A/nRh2FxIU5RpOtrGKA2I9cMMaI8UrI0bhepcGHknpsYnue5FgEQnmF+9YOlEaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838075; c=relaxed/simple;
	bh=KYU15iGRWMySB7s0gh0SKffjxn00VauBUYrQ/jqPQok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5vljz7bpmiCE1ZX67mhu8dwQ9ptnwHY04ygeyV99wrs5E07J/WmmPVT1eDNGoPCUnXnx4T1BaJRmB79O//0mHvZ0q3HYUy1rXEK4hj2V8hAaG3GqkMLSI0apgzs41tN2Mc7gtLHvxjHU8dQf1JWACxelpixVuYq3uaLELyXE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjyRKWZB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74924255af4so2283342b3a.1;
        Sun, 06 Jul 2025 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838073; x=1752442873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UEFRrppcFHZATwPoos54W9hcQwwdollH5Hvdy1WxMYo=;
        b=UjyRKWZB59No8YDAKavtOwcw35qhKrNkEkhHnj8Q5OkcImMQouHWEWTEt9r6+jwZnG
         ndDY3eI7NNQpPcIUz2IAoCIogFHKZOcUOByUKwasHi8S0ByPhjZRWzkILvMlDeaCMgX/
         3Hm/pwYBakbeMgOYXCMKA2/iRjGHRO9YXXATZsFVM3nVc3MmSF+ikAUscLP2ip/9PHgv
         9YCLC5deQ5ChtQr2/YIMLVfbaB9guEEGEwwl8mzmJaM63CR0zvubE6JIQ3f8naT6oUa1
         3KJTm046Dqv3lY1MCKAhN9cid6BCejLyFlukhQ2Yv4P9+f+EWvLp548hmfAjLTFDl7A4
         NXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838073; x=1752442873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEFRrppcFHZATwPoos54W9hcQwwdollH5Hvdy1WxMYo=;
        b=IvrbQymGTFxbxpd/EncCr/wzbWBY9C1n+8NwuwVrDcf3LfHSEvZaXqdVFGRSbfolPS
         i3TwiExT1HZxQj3GYjbzjfEq+aE3EyYwFxyWoxl5XIBuo1fmUuN/Tc1BKJonwSVEe5um
         7xcaMpLrXdGPV410Ii+7Sa4//OGWOmBV+DYY9MX6iV23V/YA03BV1B9veBV8kfh/9Wyc
         Me1doGsV8RcPOOpy1q840AoyiJrFnlchEdQCDcXyaLXNfZaScd+yyZKZScRbpQcegO+n
         weCcYbLGJcPBjsQjg38WYoFmy8rHdjr3KlJHXyyL6usu/bSl994SnvPycepr390zC/XD
         DGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeRbdznxlBlD/3LNCYYjDmKLoB0H1YBbTkUOeBpIVQXM0a80iLoTYf0GsMpMLljgjVQePf1qO14Lum@vger.kernel.org, AJvYcCV9gMdPuob3HRv7Iv5bs5k23hjij3IDm9s1zJeGFiRF7bozpwEZfjE26UQC5FuFygw++xKpGb+LgLWf3g==@vger.kernel.org, AJvYcCWSlsAHhjVjqIB/M5+zVlvLPPMmjls/kFyBTbAJda0d3iOXzcrOtG5ybPkTeFJMYN14HgYWWX7dbTmjJ/87@vger.kernel.org
X-Gm-Message-State: AOJu0YyLk13pYdIbeMzaNGxH5Z+H5CQDK6rFUtza4znqBvAyXsUU7tOY
	I3wKY9LsAUXE9mXkJDrc+1MET6Y5AIRSUPUfdWmnGFGjkfSDpwtftlJHn5XlGah2bPc=
X-Gm-Gg: ASbGncvRiuss64TERzkdFHgcKAFw3OMZ+oGqD3XuBh/meZh7HjMr9V4qnAdM8eQupY4
	7XLj1zu2YzOqUsLfSUcD3JY5CI72TI1+kWd3j1bUJcT9g3easW1wbM7cneAprbkRav8cIBO+Eaw
	a2rZbssQLcm4MmhJBh7nfKroVpoV4uok4xdxPMZm4dADtRpVcR57CTc/nNfqmyGawHMBV7QXUy3
	0GW+FyBAStiSQrCiE08Dz6kdcknSiTRePvsnrjhmsoVh/W6LF19oCgdWM9RG/4Mw58P/FQ2RBx5
	we2qq/n/z6o1cBGbQ0UYYLsa5w89Vlpc0hhPzcgge3E=
X-Google-Smtp-Source: AGHT+IGwKdpyijxHBEuxiWpktwVPqOdmEARgRAnlFV+5B6kzie1HeDmU+tDrXvf31ZBdmm2Ca65x7w==
X-Received: by 2002:a05:6a00:2354:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-74ce8ab166amr15315143b3a.15.1751838073517;
        Sun, 06 Jul 2025 14:41:13 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74cfad75020sm4126416b3a.109.2025.07.06.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:13 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	yangshiji66@qq.com,
	ansuelsmth@gmail.com,
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
Subject: [PATCH 0/6] wifi: rt2x00: add OF bindings + cleanup
Date: Sun,  6 Jul 2025 14:41:05 -0700
Message-ID: <20250706214111.45687-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't even compile. Added OF bindings, documentation, and other
stuff to hopefully this doesn't happen again.

Rosen Penev (6):
  wifi: rt2x00: fix compilation
  wifi: rt2x00: remove mod_name from platform_driver
  wifi: rt2800soc: allow loading from OF
  wifi: rt2x00: soc: move and modernize probe
  dt-bindings: net: wireless: rt2800: add
  MIPS: dts: ralink: mt7628a: add wifi binding

 .../bindings/net/wireless/ralink,rt2800.yaml  |  49 +++++++++
 arch/mips/boot/dts/ralink/mt7620a.dtsi        |  10 ++
 drivers/net/wireless/ralink/rt2x00/Kconfig    |   2 +-
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  75 ++++++++++++-
 .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 104 ------------------
 .../net/wireless/ralink/rt2x00/rt2x00soc.h    |   2 +-
 6 files changed, 133 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2800.yaml

-- 
2.50.0


