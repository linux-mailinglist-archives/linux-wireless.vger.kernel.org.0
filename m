Return-Path: <linux-wireless+bounces-38093-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LR1xMd02PWq0zAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38093-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:10:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1786C6692
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:10:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ubJVFQTV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38093-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38093-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D64E30138AB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8205B351C28;
	Thu, 25 Jun 2026 14:10:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7393033F5;
	Thu, 25 Jun 2026 14:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396631; cv=none; b=nnNeG56L53zcsgyTQA8uC2rCoG/UA//QzUh1qJLuEXk/H7oxmQYf7vaMONw3R8jCRLEPZKVPZUuv+2M0Ev4svrju0mlXRouo6XregYIq1Bd2jNg56PvE6TCcQo/9OfkNT67+5RgZnGSAIL4eeyAn2NfEe/GbNCJLXGNBm7hV9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396631; c=relaxed/simple;
	bh=D6SplHxUa3QnaLv8HkHyckjDvA/Fprxyfd+YMfQx7G8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EpYCjUIWjjNUWSOXd2Ux+nJJ6R/ou/hkQUGddnLjevnHuiUv2mIXXp8Vf63G2GNxEnQF1JaVx9MSfCIZH367ISAZTu1Kwptua2TeFyzSvYv5jYHlIlqEVnh0/5oPba+2T2+y8mDT2El4siOfR5wpzFkauu/z6VE9l0JgXBrPSYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubJVFQTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFD19C2BCB3;
	Thu, 25 Jun 2026 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782396631;
	bh=D6SplHxUa3QnaLv8HkHyckjDvA/Fprxyfd+YMfQx7G8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ubJVFQTV+/Y0T9PjEfy0BIHmEqqIZ5iLhuPzgkeMBStfEWlJB970ldJ7/RumWT8hI
	 zNxpj6Zj20HuZiXZ0SMVJa6B0eG+ZlOKhOEofnmlnntB09dgIbWChXVpJFOx4XvSBD
	 224CQRtOsHY4d3HDnf6KWfomftv+4ZZx2sx37y5WNlN3MCY8VVDeCjwF+LThs2MjkB
	 Uwq1qFwSuw5cL0umlvYHmIIWPsH3Fx09cgR5Ld8xz10IQ6l6MF7PFK5UCQNiwPnJKy
	 TZSN/9+D7vLIPiq5zcxQIMhyrayx6JagYhZpKPZ+JBTGaC2kVtOp7mcisE1TILXtms
	 HCt9LiTQV99Yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ECDCDE001;
	Thu, 25 Jun 2026 14:10:30 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH 0/6] Add support for IPQ5018 Bluetooth
Date: Thu, 25 Jun 2026 18:10:04 +0400
Message-Id: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBREr1Ky9kuammiLiPeQLpL0R4NN0+a3R
 RDvbrSbgTcwb96MMHkk1hRvlnD15OOQodwVzD70cEfwXWYmuFBcCQl+nCQvT2D6BecY5wdw5Zx
 Stu6OsmJ5NyZ0/vV33tqNE05LVs9byQIS6b+6Kc6buRTZGO0TNMGwBgywSuBQS+Sm4s65ml8j0
 X5adG9jCPscl9+b0YTwa/zcFIeu1KYSB2fNkbWfzxfm+j9+3wAAAA==
X-Change-ID: 20260625-ipq5018-bluetooth-06ff66c9d753
To: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Saravana Kannan <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782396628; l=3321;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=D6SplHxUa3QnaLv8HkHyckjDvA/Fprxyfd+YMfQx7G8=;
 b=6MKZWbfvyN9Pd5FoUIlXKVCW9PgXMLB8ekM5lOyqEenPO3HzLmd7aZqmcGLCiB4/V1w9BQ4rO
 W7+WbfMcF11AMEj2N5zJ0b/Tu+DnFmNpy3aZ9Tv7SmbNEM6abwmYVk2
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38093-lists,linux-wireless=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:george.moussalem@outlook.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:replyto,outlook.com:email,outlook.com:mid];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,outlook.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E1786C6692

Hello,

This patch series introduces Bluetooth support for IPQ5018.

Bluetooth firmware on the IPQ5018 platform runs on the M0 co-processor.
The firmware is loaded by the host into a dedicated reserved memory
carveout and authenticated by TrustZone. A Secure Channel Manager (SCM)
call safely brings the peripheral core out of reset.

A shared memory ring buffer topology handles runtime data frame
transport between the host APSS and the M0 core. An outgoing APCS IPC
bit and an incoming GIC interrupt handle host/guest signaling.

This series has been tested and verified on various IPQ5018 router
boards utilizing firmware extracted from GPL distributions, using both
mdt and mbn file formats.

[   14.781511] Bluetooth: hci0: QCA Product ID   :0x00000016
[   14.781583] Bluetooth: hci0: QCA SOC Version  :0x20180100
[   14.785926] Bluetooth: hci0: QCA ROM Version  :0x00000100
[   14.791546] Bluetooth: hci0: QCA Patch Version:0x00003ded
[   14.796698] Bluetooth: hci0: QCA controller version 0x01000100
[   14.802217] Bluetooth: hci0: QCA Downloading qca/mpnv10.bin
[   16.393850] Bluetooth: hci0: QCA Build Info: BTFW.MAPLE.1.0.0-00102-MPL_ROM_PATCHZ-1

Best regards,
George Moussalem

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
George Moussalem (6):
      dt-bindings: remoteproc: document M0 Bluetooth Subsystem secure PIL
      remoteproc: qcom: Add M0 BTSS secure PIL driver
      Bluetooth: btqca: Add IPQ5018 support
      dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller
      Bluetooth: Introduce Qualcomm IPQ5018 IPC based HCI driver
      arm64: dts: qcom: ipq5018: add nodes required for Bluetooth support

 .../bindings/net/bluetooth/qcom,ipq5018-bt.yaml    |  63 ++
 .../bindings/remoteproc/qcom,m0-btss-pil.yaml      |  72 ++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |  34 +-
 drivers/bluetooth/Kconfig                          |  11 +
 drivers/bluetooth/Makefile                         |   1 +
 drivers/bluetooth/btqca.c                          |  16 +
 drivers/bluetooth/btqca.h                          |   3 +
 drivers/bluetooth/btqcomipc.c                      | 939 +++++++++++++++++++++
 drivers/remoteproc/Kconfig                         |  12 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/qcom_m0_btss_pil.c              | 261 ++++++
 11 files changed, 1412 insertions(+), 1 deletion(-)
---
base-commit: 4d1ab324fcb7d20df5a071edb0304461846fdc12
change-id: 20260625-ipq5018-bluetooth-06ff66c9d753
prerequisite-message-id: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
prerequisite-patch-id: 6ce8686c1683f468d86b4502f5ec9d19c392a382
prerequisite-patch-id: e362f7fcbacff716b7ef720e6780786a7d88c013
prerequisite-patch-id: 9168930e40551e842c8171d5433a6f39ad4b78a4
prerequisite-patch-id: 64fecfbd1e085d7d2ab0ae23295ca34ec8e14c5e
prerequisite-patch-id: 566804aaa690ee9aa285d0fd75fd16d94fbadebf
prerequisite-patch-id: dc18bec338f54b3051f4523f9d1d3c0566a20ccd
prerequisite-patch-id: b6b3eb46429936ab49423d295433daf47981db0f
prerequisite-patch-id: 75caa99e3bbcdf41b6462b9f5f703bea1d4a65fa
prerequisite-patch-id: 35e9968f482f78ca233eb0306d9c5fdbff093175

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



