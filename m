Return-Path: <linux-wireless+bounces-37081-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEEPNF/ZGGpDoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37081-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:10:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFF45FB9BE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F09A30892D7
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 00:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434978F2F;
	Fri, 29 May 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="UeDSWsAm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpcmd0757.aruba.it (smtpcmd0757.aruba.it [62.149.156.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177B6FC5
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013355; cv=none; b=gJQ5StkLmiut1iCapSVjTGyPSfFVXP1JHo5XsZCV7MpxJTFei0apFlqxnmU78ndwrSwAuuFE32bT9Q6zNYhs7WXqsq45VMmgqP6dHcE7hD2IQmaTGKh+J5kDuJvWCT5ybt8X7Kd78VV+VVhRiLqlDaRpVoqWOFyQ1oOOg7M1hQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013355; c=relaxed/simple;
	bh=xLykC2eIwzjFRI18ogQQECB3XMRxQamtyZ2VzPNDeuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RCO2DWe2P7y/NAYXf/O2wDFM9z1nquPV8eYbMsr1KHXM49RmKFjgSMXW7Ohd3xRSr116vwDDnmzAHEZViv+6dGAKBMKZQg3ZobDEBePnFP0yiJWgGX5ARt1aisyuSSFo3sKtfHKLu9InlHXJZAL9mq4Uv9Mt+wdNjogklG/FZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=UeDSWsAm; arc=none smtp.client-ip=62.149.156.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Skjiwb0oZtpTfSkjiw9YOk; Fri, 29 May 2026 02:06:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1780013162; bh=xLykC2eIwzjFRI18ogQQECB3XMRxQamtyZ2VzPNDeuw=;
	h=From:Subject:Date:MIME-Version:Content-Type:To;
	b=UeDSWsAmaJY/u4obrPt/JKq2i6mhd+IV1r0A+VaXkhyq4TWm0uBZyne3hXvtOJHZe
	 zc1PtnxJvSNku4OVrprMFF0Shn7d543P1pzhasZDgEpXEqWJkrhW9FBNhAyAoy9gLX
	 HQu9Ymw2t1o1zId9qrFDcxjmt7Hf+3lZtEy0It5+lXbCOl/fEh6OHsfuzdgvAZ7iC/
	 Opob933Wj4FIPCgtvX522gZ06C8lSSW4zRDFSpYbVnwTZclC7j66/TZEjOntS0RfJj
	 gI/NKJYyS7zOqjDKQ92yZSPr2jiOq0+2aRoEWOv0PaxaqF/OW92Enl06tQsOi5H/Ps
	 L9Uh0Nxxr+7zQ==
From: Alessio Ferri <alessio.ferri@mythread.it>
Subject: [PATCH 0/4] bcma: support SHIM-attached big-endian SoC backplanes
 (BCM6362)
Date: Fri, 29 May 2026 02:05:58 +0200
Message-Id: <20260529-add-bcm6362-wlan-v1-0-722242777f58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3cSUFN2k5FwzYzMj3fKcxDzdVONUc6OUpJTUJItEJaC2gqLUtMw
 KsJHRsbW1AJQksupiAAAA
X-Change-ID: 20260529-add-bcm6362-wlan-e3e72dbdeb8a
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Alessio Ferri <alessio.ferri@mythread.it>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfEqJjOvyNZ7IZw8V1bFtR0LGeea5ChksvNZ/vFRqWLblRWonEW4o1mQgGMKGBkzXg9MbUUlCThxHNDCAI5EXMQwRXBpru5vfb3sv8WzT+dBswgBcmRGg
 7IoMBI8WbC8Uo+a/V6XsFFbR5zJoUAdvH0m3+PaInfTSCKpOSGk/xKgX5QDr4I236FRUXZEpZ4Q0Rp/WCotHtH5iqfsUmXSx5RmIkps90Paav5D/n+X2GOsZ
 EFT1+AT0PWzkojKg/0tf7d9RRjhqoMoRoGid0EBf4g0BAsEZjyUgsXUrKEmc2353OdOTyuC9ykaeEnFuTLAW7NEfxWKSnsCg1pjvrVHFNwTjXglL+PBfMDCc
 QJQ+0NEKRuaNxt1D+VJUvtfeJXQWdhh+tPUwQi07hgodLFWfgCEWgCNmUSG0i2rrLBs6ka5gY5+wnAaQf+RtQnPUi1OTDq7YKzG/LUnytlyhlWXm/dyuhN/H
 svFVNKdPo7XbiS8qxGOMmt6vBo0EG9SRPAZfBpplSiItqoV8MuN4/LK8550=
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37081-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,mythread.it,kernel.org,pengutronix.de,broadcom.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3FFF45FB9BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some BMIPS xDSL SoCs (BCM6362) integrate a Broadcom 802.11 backplane that is reachable
through bcma but differs from the BCM47xx SoCs host_soc was written for:
the AXI backplane is big-endian on a big-endian CPU, and the cores bcma must gate
(ChipCommon, the 802.11 core, the SHIM core) expose no per-core DMP wrappers — clock
and reset live in a small SoC-level SHIM Control register instead.

Rather than describe these quirks as DT properties on the bcma node, the SoC-specific
configuration is delivered to host_soc via platform_data from a parent bridge driver. The
bcma DT node stays a plain "brcm,bus-axi" and all the 6362-specific knowledge lives in the
bridge driver. The standard brcm,bus-axi path is unchanged.

The series is:
  1/4  bcma: support driver specific quirks from soc pdata
  2/4  bcma: allow SHIM-style mini-EROM wrapper-less cores in scan
  3/4  dt-bindings: bus: add brcm,bcm6362-wlan
  4/4  bus: add BCM6362 on-chip WLAN SHIM bridge driver

Patches 1-2 touch drivers/bcma (wireless tree); patch 3 is a new drivers/bus driver; patch 4 is
the binding. The patches are sent together to keep the whole context intact.

The original Broadcom driver materialized a fake PCI device, i don't think that would be allowed
in the kernel.

Tested on a D-Link DSL-3580L (BCM6362, d11 corerev 22, N-PHY):
- SHIM brings the backplane up,
- bcma enumerates ChipCommon + the 802.11 core,
- b43 binds.

b43 patches are necessary for the last point, but those has
already been sent in linux-wireless.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>

---
Alessio Ferri (4):
      bcma: support driver specific quirks from soc pdata
      bcma: allow SHIM-style mini-EROM wrapper-less cores in scan
      dt-bindings: bus: add brcm,bcm6362-wlan
      bus: add BCM6362 on-chip WLAN SHIM bridge driver

 .../devicetree/bindings/bus/brcm,bcm6362-wlan.yaml | 106 +++++++++
 MAINTAINERS                                        |   7 +
 drivers/bcma/host_soc.c                            | 224 +++++++++++++++++-
 drivers/bcma/scan.c                                |  19 +-
 drivers/bus/Kconfig                                |  13 ++
 drivers/bus/Makefile                               |   1 +
 drivers/bus/bcm6362-wlan-shim.c                    | 252 +++++++++++++++++++++
 include/linux/bcma/bcma.h                          |  14 ++
 include/linux/platform_data/bcma_host_soc.h        |  31 +++
 9 files changed, 654 insertions(+), 13 deletions(-)
---
base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
change-id: 20260529-add-bcm6362-wlan-e3e72dbdeb8a

Best regards,
-- 
Alessio Ferri <alessio.ferri.3012@gmail.com>


