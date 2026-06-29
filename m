Return-Path: <linux-wireless+bounces-38296-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d020EV5uQmoP7AkAu9opvQ
	(envelope-from <linux-wireless+bounces-38296-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 15:08:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB96DACD1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 15:08:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=hvqpG0jG;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38296-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38296-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81BEB30B2161
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1F8404BDE;
	Mon, 29 Jun 2026 13:02:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CD4048A3;
	Mon, 29 Jun 2026 13:02:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738120; cv=none; b=RKyHoUt4rqLVkadFuSOfpnWrKvVcGjBwLx1zM/7DFP2e2TXMYoxOTP5mZqfBc+amuDZcf1XFjlxz2BfH/b7OMS3txBc6jblDpzTpqIuRXXtnHvGSGb0Wz9zKF0TdGFe+bt/5Pt4s1h7nSKSvYcrv8ifeKbirYLpp1LVMsDEQwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738120; c=relaxed/simple;
	bh=PYsU5W5Jszwt6dlzc2hq7qPa4TZSCcC7107VrIfpRq4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O75/ZikIOE0BwgnbppEklEme7XVRZcHajW584G1onaWQpR4HqfM3KGZkHsNX0CrjBm2QmTO3eN2CnkNWLSi0ZkIak4ZGSqiQSc3y1BAt/FJsor/wqWMllo9XL3L1sq3z4TNfUEqx0vUekSaj9cfyoXSfYMOwQPXYJLnByLxvIL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvqpG0jG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D951FC19425;
	Mon, 29 Jun 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782738120;
	bh=PYsU5W5Jszwt6dlzc2hq7qPa4TZSCcC7107VrIfpRq4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hvqpG0jG9MLJ2LzRp+rQjOaaz2Eq3EHPANMdl3fiXMPXHEnPd/gQv0DdAM+vaUWrL
	 PCXPlBfinBtSzgfzoBHRJkodUTTLrlmp0alWUQ3pKK9UzDoiYzDK1EDFPfj1Mm9KXY
	 uvAsQ4kZrhS5I8Ky9Yv8iAJGQQuju1bQ9Vzm/VwmaaBd+gVHUbfHK48wk44fO2K2v/
	 o+Izd+Wi3mlhCvjih3zSB0cgnMauXwGTtIiQozW/RD8gUn1aFbUPz/+wkxOCZsgW0a
	 IY9XEHLh5mTAACWekd6c8Ucmwgbxc6dRPyWFjtbUMWPmzdtRyIAom3EINd2aDGrAoF
	 BgfHNhV/P4ygA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70E0C43458;
	Mon, 29 Jun 2026 13:01:59 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH v2 0/6] Add support for IPQ5018 Bluetooth
Date: Mon, 29 Jun 2026 17:01:43 +0400
Message-Id: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PwW6EIBRFf8WwLhNA0WKaZv5jMgvARyUjMgKSa
 Sb+e1H33bzk3uSdk/tGEYKFiPrqjQJkG62fS2AfFdKjnH8A26FkxAhrScs4ts+FE/qJ1bRC8j6
 NmLTGtK0WQ8drVP6eAYx9Hczb/cwBlrWg01kiBzHKA91XXyeZskL0+oFlxHN24HDmmGDBgaiaG
 GMEufoYL8sqJ+2du5TzvduUjID3xqa+agYqVc0ao1WHdvdoY/Lh95iX6SH/Z0mmRTkIIRQQII3
 prn5Nk/eP3Ybu27b9Aaa7V0AwAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738117; l=4779;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=PYsU5W5Jszwt6dlzc2hq7qPa4TZSCcC7107VrIfpRq4=;
 b=xqRVC4qJa5oodNX6Ol6uwLIBboUPhmbP6yhabpjphXDQKdvx+gDmVBXZlPpYq5TIMrRJ0BSKN
 hPwQcE5UKDcCAW/rY7s3lUNt6t/Ec4gVcxz3Q3LmUia12HPLJoDb7Nu
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38296-lists,linux-wireless=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:george.moussalem@outlook.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:replyto,outlook.com:email,outlook.com:mid,vger.kernel.org:from_smtp,qualcomm.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9EB96DACD1

Hello,

This patch series introduces Bluetooth support for IPQ5018.

Bluetooth firmware is loaded by the host into a dedicated reserved
memory carveout and authenticated by TrustZone. A Secure Channel Manager
(SCM) call safely brings the peripheral core out of reset.

A shared memory ring buffer topology handles runtime data frame
transport between the host APSS and the Bluetooth controller.
An outgoing APCS IPC bit and an incoming GIC interrupt handle
host/guest signaling.

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
Changes in v2:
- removed unused struct member btss_reset from m0_btss struct.
- used devm_reset_control_get_exclusive_deasserted to acquire and
  deassert btss_reset in one call. No need to explicitly assert upon
  unbind since devres will handle it.
- As per Bjorn's comments, collapsed the rproc and BT driver into one
  which now handles firmware loading and transport.
- As per further review comments and above change, squashed the two
  devicetree bindings into one to represent the Bluetooth controller
- Added new SCM call to drive Bluetooth power modes. Based on testing on
  more router boards, this is required during start/stop sequences to
  avoid the controller hanging. This is only supported on relatively
  newer QSEE versions, so the SCM call is checked for availability
  before use.
- Refactored resource lifecycle management in the driver so that IRQ and
  work queue are managed at the driver level (probe/remove) while FW
  loading and powering on/off the controller is handled upon hdev
  open/close.
- Consolidated TX send functions for custom IPC and HCI frames into one
  and solved a potential NULL pointer dereference issue under TX
  pressure.
- Replace code to load and initialize firmware metadate by existing
  qcom_mdt_pas_init function. 
- Solved an off byone calculation error in the RX parser.
- Added entry to MAINTAINERS file
- Link to v1: https://lore.kernel.org/r/20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com

---
George Moussalem (6):
      dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller
      Bluetooth: btqca: Add IPQ5018 support
      firmware: qcom: scm: Add support for setting Bluetooth power modes
      Bluetooth: Introduce Qualcomm IPQ5018 IPC based HCI driver
      arm64: dts: qcom: ipq5018: add nodes required for Bluetooth support
      MAINTAINERS: Add entry for Qualcomm IPQ5018 Bluetooth driver

 .../bindings/net/bluetooth/qcom,ipq5018-bt.yaml    |   86 ++
 MAINTAINERS                                        |    7 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              |   25 +-
 drivers/bluetooth/Kconfig                          |   11 +
 drivers/bluetooth/Makefile                         |    1 +
 drivers/bluetooth/btqca.c                          |   16 +
 drivers/bluetooth/btqca.h                          |    3 +
 drivers/bluetooth/btqcomipc.c                      | 1052 ++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c                   |   49 +
 drivers/firmware/qcom/qcom_scm.h                   |    1 +
 include/linux/firmware/qcom/qcom_scm.h             |    1 +
 11 files changed, 1251 insertions(+), 1 deletion(-)
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



