Return-Path: <linux-wireless+bounces-38302-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OEW2Ar5tQmrR6wkAu9opvQ
	(envelope-from <linux-wireless+bounces-38302-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 15:06:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17E86DABE1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 15:06:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=L+pzfhh9;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38302-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38302-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA378302CA9B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA1408636;
	Mon, 29 Jun 2026 13:02:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86D406290;
	Mon, 29 Jun 2026 13:02:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738121; cv=none; b=JoZolcdSYfwI09hncxVjjioCFlMGWCP94qvdIO3QGibQHLK15O1hRU1CZQurAfU4MaAKXPa0ea2DwtQNE3AnMoOFOkzUI4lv3jJS0om1q1r+H/Z+U3dVjJlERFAMycxsnr3aw2ie7ucor5nXcLHsY9+610tniST3ci132roWKko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738121; c=relaxed/simple;
	bh=sVfZV5FAtAUUUFWxrC0Zg7CsOdSgFgkDNnZ7Y9T5fBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qozYfwTRn1SFFfdt4lPeyLcH2IKkH0jiSrVWvS4Oh9ylbL4xgg0XNNZMio+wh3tsSlOjj9LC+oDDaErhQDa94xWA1jw81J7Y32B9NoYdDemVAOYOAqQfRf1DuHR+kqn+8eMCu07NQx6ZvU/6LbDmFulukV7Y0DyYvPkX3Y+qDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+pzfhh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A6E0C19425;
	Mon, 29 Jun 2026 13:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782738120;
	bh=sVfZV5FAtAUUUFWxrC0Zg7CsOdSgFgkDNnZ7Y9T5fBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L+pzfhh9NATwjEl/MgOmoWhFnhdxeYvwUOjjCY1lXcCCkCC4M0d8chna8Yk+IedPr
	 qWaHdDrsDhKU/9X34pK1/OANQ4ZVJuos471wzrjYGlw939Zfkv+UR+DbUdo/VUH5L/
	 3Ghs+YJf5AoJLOvnUBilnqhuZLzL3AhoPWXzfIwBf531VE95EmpbntlWQeVX9iCXJ0
	 ZcaDXSJdkAOnOVRuf7brPOCIe3eY/8+Z63MTog8F8ER8w8QpD9qQ1tHb+SJtBUWd1K
	 ZTGZvo9JixsMgMtEApIeHSK5QToVz+Jeq6XmaeKFdBd9MBeeTHnuKquvL4+EEQhD6D
	 ZUscpYvdft03w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763B2C43458;
	Mon, 29 Jun 2026 13:02:00 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 29 Jun 2026 17:01:49 +0400
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for Qualcomm IPQ5018
 Bluetooth driver
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-ipq5018-bluetooth-v2-6-02770f03b6bb@outlook.com>
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738117; l=906;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=DrQrzkPl3cbWFmYstKvKokgP5FFWzafGXK+cjmpTmUA=;
 b=WHjMybUgY1YmSj4Ea/kchfwjt9e395GAYngQB0uqV2f8fpoxFPAByR3nOPcenEnDMEMZ8Y3yx
 mlGy6okm/1TCDAfx2bhlJTXU7gZa4Ap8w7tJAuCmQsqRCYAJytae/qt
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38302-lists,linux-wireless=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:george.moussalem@outlook.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,outlook.com:replyto,outlook.com:email,outlook.com:mid,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A17E86DABE1

From: George Moussalem <george.moussalem@outlook.com>

Add maintainers entry for Qualcomm IPQ5018 Bluetooth driver.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b9d7c8276ac..60f7251d1a16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22289,6 +22289,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 
+QUALCOMM IPQ5018 BLUETOOTH DRIVER
+M:	George Moussalem <george.moussalem@outlook.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/qcom,ipq5018-bt.yaml
+F:	drivers/bluetooth/btqcomipc.c
+
 QUALCOMM IRIS VIDEO ACCELERATOR DRIVER
 M:	Vikash Garodia <vikash.garodia@oss.qualcomm.com>
 M:	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

-- 
2.53.0



