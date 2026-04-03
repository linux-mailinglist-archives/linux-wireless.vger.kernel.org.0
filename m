Return-Path: <linux-wireless+bounces-34327-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ1GKy7Hz2lH0QYAu9opvQ
	(envelope-from <linux-wireless+bounces-34327-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:57:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B20394C61
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54E2F3006950
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235236495E;
	Fri,  3 Apr 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zLJfnmrd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804836998B
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224519; cv=none; b=okb3CiWwQLPXJjFaSc1a6insfqAF7cNLwH5UpKoDafumNO1PbE419gGYZL2XN4VEIRsbx6hVSLOvAzrzCXrLoSLNEQO+ro2CneoPD4drF/A12kPv/gj8ehRGkXp7VbJnEPCShYqzUEGc/X+MxisjIqySah+LPaMRmyz8U3qh+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224519; c=relaxed/simple;
	bh=BF5TJfTjAHAamhIZ3z7tthOS+Ma4qFWW4uI2TjjrfiU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sRzPul6CWviJ2HLa4vPQWfAT7CYNWY2TRcU9Ta0A6JL2cZT1FFJ2TAYdQj+3IeS8QUdbmWtNVeH7Vwuyekf+ZjPzrH/necYnbxsd9CiTdjP00C+tJ67nHwd32se0JTDaid4XcaU54rpDI/Uh1JY4nejOZvHjKqSfMeADa41+BDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zLJfnmrd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9bfcbaa81eso272007966b.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 06:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224513; x=1775829313; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr3vVgaHqynfRwr0nQihQQVF1MqwcT9adBqdvMVF6WQ=;
        b=zLJfnmrd7IwQH6jBIst/CazD9GSOjzcGAuig9yuWw1DOrhayV6t1lZMRxZqpfYCnMA
         2QKoIFcFmROJTgiDrucvnel4zQwLuBBv6EtVrR68ODcmMyXL2ZbVOzv2o6EEHoc3FuNj
         K/Z2Ve0zOat0xTN4zbDwhf46fWIugfUtReye5Zt2csFDp0l10y/0YaQZFrnyqVA70AiW
         SUVPLbXqPPbbPJJnnQu9+cq0xLWGcMa9CAAiitDdVd12Fvb/0qSKOUkA1HrfqsiDBPgS
         eg4+6MqRCqR+qSOxISzdXoICL7k2ex/raLt4VeLyoIlCyElFn5XS4f8EBJAUcV/oLO6V
         zdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224513; x=1775829313;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr3vVgaHqynfRwr0nQihQQVF1MqwcT9adBqdvMVF6WQ=;
        b=jM/QeX2SJUFcfNwJ34gQaQ7+wem30qSlaCjrViOqWS0H65MzqaiXHrrU1lD3k5e1uA
         chCpjIf+6TwyJ7Mnlcg9fTXZFaR9j4oCjl2MhlL0A6hC9TOHoQA34Appnld7ZUhBWD+4
         wC5NMkQR82taIbM1EaSMOS46qhlWhsbX5q3YFgjZtv4CFh6S14+7q8MAJ2kK0yp8CXCo
         PgJKVurRLuwvwC55OX4qLsGvMbJBeLYHyy5DXVvlVPkYa8xwuPBTe48u52qzRGVC6cbp
         Gxq4PeG1MstidZ7twTS1X+FipV+qsIox0JTfR9CtMCmFTcT/D+eUkKhvs445QWw94ATV
         A0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXWZc2D2S9M3k1TIrHkY2omjiSEMDP7e5sae47Cd4XCm7m9GIYNVBw/UQ11ww3ICLRTSTv7KmrGrClo6t98ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3M1aWuOak0R2ErdK5CFtisVELn/G/jtuJHIoFzWbZlUS9Ytp
	gYZvuEfquuQYKur6XUJp6owRevUZpuh1o2SpIyUYjzIWJHVNlcrLEX7s9NFihQi+tFI=
X-Gm-Gg: ATEYQzzcYdTZU/uDGxQhHMx5V/BA9O7QgtcxkBIGm8PGk6PNcJI4cbu6KJ1Sh2ZnmV3
	pIaaW6EKjhqo60RGwotprf17YuUIqoAMKmBxxOyljJ92sv5j+jnD074sIPUKscuaw1B6O7SAcOL
	sSNw5/YWuj6UnD47dyx2YB5RnqGwhL7SazYolfHOJY9Inzn+861n/7ebUXHarc4QgCg3PbZx/pr
	oBby8mTlyOnv0XB50lTmeSQyfaHrL6EEoXOPdMk19ncyv2K2NxpFhpK627ZXB6ptd4tLx4vUzJq
	aKFuHi1a8g0SdSuRBLpy8AQVgnTuVSSbcvab++xH15hSt2CRnnDTqnvl4c3ax+bic6VGWrk1Z4p
	7euqD8r2H0+DLN+TdPm0as5pDlMbr+3I+FEAWnI+bHWD814yrNI4rGIL7Wz8afaUy6C5YvtazCX
	wzaWNrCnfGvsmScDBcNlEhIY24Xeq0f+B6dTMCpXNulGYdGfdNGkQdQvrhehvZ+AEi/demZoWO3
	37huiZm1Vek0bmKhYGVpYxA27KLZaYMNRBk8w==
X-Received: by 2002:a17:906:478e:b0:b9c:69df:4d8e with SMTP id a640c23a62f3a-b9c69df5f1amr156882866b.25.1775224513349;
        Fri, 03 Apr 2026 06:55:13 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/7] Enable Bluetooth and WiFi on Fairphone (Gen. 6)
Date: Fri, 03 Apr 2026 15:52:46 +0200
Message-Id: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6CMBBFr0Jm7RjaIFVX3sOwaOtUJhGKbUUM4
 e5W2Lt8k7z3Z4ZIgSnCuZgh0MiRfZ9B7gqwre7vhHzLDLKUdSlEjR0/fEQ31GgSvtkxSum0VkY
 c6Gghe0Mgx9PavDYbB3q+cjptRzA6ElrfdZzORU9TwjVflRJ+Qssx+fBZfxrFavyZHwWWKJWpn
 DFK0clenOYwtL6nfd6AZlmWL7EDcifnAAAA
X-Change-ID: 20260116-milos-fp6-bt-wifi-22faa7b15e8c
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexander Koskovich <AKoskovich@pm.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1518;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=BF5TJfTjAHAamhIZ3z7tthOS+Ma4qFWW4uI2TjjrfiU=;
 b=ednRrit/bAoAzVhkyGxL0NIrpVGJR0/5C62DiVQLNXJsmwqOGJ0X52r5uAazLmVy1hmNy7lOE
 ooCDQy+mLlJBCy0nu87HL3O/iRHxdVPR3Q8pIcTIF19ewqq5MrpRoDg
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34327-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fairphone.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:dkim,fairphone.com:email,fairphone.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14B20394C61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the required bits to enable Bluetooth and WiFi on the Milos
SoC-based Fairphone (Gen. 6) smartphone.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Drop applied pd-mapper patch
- Add compatibles for wcn6755 with fallback to wcn6750 (wifi & bt)
- Rebase on linux-next
- Pick up one tag (discard the rest due to addition of wcn6755
  compatibles)
- Link to v1: https://lore.kernel.org/r/20260116-milos-fp6-bt-wifi-v1-0-27b4fbb77e9c@fairphone.com

---
Luca Weiss (7):
      regulator: dt-bindings: qcom,qca6390-pmu: Document WCN6755 PMU
      dt-bindings: bluetooth: qcom,wcn6750-bt: Document WCN6755 Bluetooth
      dt-bindings: net: wireless: ath11k: Document WCN6755 WiFi
      arm64: dts: qcom: milos: Split up uart11 pinctrl
      arm64: dts: qcom: milos: Add WCN6755 WiFi node
      arm64: dts: qcom: milos-fairphone-fp6: Enable Bluetooth
      arm64: dts: qcom: milos-fairphone-fp6: Enable WiFi

 .../bindings/net/bluetooth/qcom,wcn6750-bt.yaml    |  10 +-
 .../bindings/net/wireless/qcom,ath11k.yaml         |  16 +-
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |  16 +-
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   | 191 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/milos.dtsi                |  74 ++++++--
 5 files changed, 285 insertions(+), 22 deletions(-)
---
base-commit: 83acad05dee54a5cff0c98dd7962e55d4c6b145a
change-id: 20260116-milos-fp6-bt-wifi-22faa7b15e8c

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>


