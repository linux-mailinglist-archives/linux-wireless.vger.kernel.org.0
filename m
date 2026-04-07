Return-Path: <linux-wireless+bounces-34448-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJYhO7en1GmkwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34448-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:44:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4473AA66B
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2239F302DE3A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3C38A72D;
	Tue,  7 Apr 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNp65Dmb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95A2389469;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544240; cv=none; b=tdCp7CjUi2XdTMcB9a/ppeEo5KIdHdUJw13FtuSHChR99Je7o3AortCxLMS0PqritRnRmbU32bxbFIcobADl3OQFJIUIZruALnk/VyFbI6bsvc75xLjjd5VlOCDnwXHepWBG0rIaWBtbe2BZ+6/fC5oVslUITmGVbagMhRbHvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544240; c=relaxed/simple;
	bh=U9QnAdkvD3nYzFEe9H4Oehb+Ag2cpOlB5/v/LOfg9tU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=POJMPQZNCWfQWEwlUFxKTwbxspPXtzBNxHc0vT3NZvWbuVuwxc/adjA+SjFsToDwj0KKt9ShbuPcXVhw14d1YQITzf9HblcT6qb2yZgAWQ46GHWs5qWd+9hbjD7Fn3m03uuoNazrQweziEIu4ImUQNJe6M1e7wdcC3cay9caH8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNp65Dmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 852A8C116C6;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775544240;
	bh=U9QnAdkvD3nYzFEe9H4Oehb+Ag2cpOlB5/v/LOfg9tU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JNp65DmbVEyb+d8rvvrUwWuzqNVU0D4RW0lHPlql9RcJe5NEKO8dYYFDqdF7tBLEC
	 wW7jmU1qaMFhm67DrDMU5jcHhRaiOVIGHBwAAoVaOrznJWHVuTs1E1uv3pOIiw8PZk
	 iXqthscub0WAuX2MvAry1eILMqD5F6xrSgdYoJdONPTwtqazc54PiXnHSI/z/z0SmD
	 CoD2QQ8eKPTcfuCHdhS7ElTubu5Zt3thHUzPGhrSZDJ9C+muOeCrl6cvpghrjduOYW
	 GhwFoSsZj2aoUDPytQ9F0qQWgNqwJt4ixS+E7/J9WzVG4bzOn0oomJVrqNuyrywGtN
	 mb14ApsNioBDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74047FB517E;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v5 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
Date: Tue, 07 Apr 2026 08:43:53 +0200
Message-Id: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmn1GkC/43OTU7DMBCG4atUXjOVf2LX6ar3QCwcZ5KMaOLUN
 lGhyt1xIiHBAsHG0rfwM++DJYyEiZ0PDxZxoURhKkM/HZgf3NQjUFs2k1xqIQSH9EozDCFl8G6
 E20gQ8QYotDbSYuNVzcrfOWJH9919fim7i2GEPER0uyYMF1xbbQWIujLlhZ4yJJxawNHRFdxI+
 Ti/TS3Fy5UmF8MxxH6jB0o5xPe9eJHbgb/iFgkceOu6ympX25O70L3o/oNtaYv6MgxXUv9mqGI
 0wijfnRrlrfhpVP8yqs3w3Gplq5LxrWNd10+QucI1iwEAAA==
X-Change-ID: 20251110-skip-host-cam-qmi-req-e155628ebc39
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Paul Sajna <sajattack@postmarketos.org>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
 Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2286; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=U9QnAdkvD3nYzFEe9H4Oehb+Ag2cpOlB5/v/LOfg9tU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp1Keub60q5mQEpUHGJXTQFQ7qWWULRkCPbdMRK
 eCsbVZvf/mJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCadSnrgAKCRBgAj/E00kg
 cnFlD/9047bYzGRZ3blI36JI4PtmYhXFdOJ/+ywcceqoWf8WuFYetD3CUaD9Wijcw+G9+UiAqQ+
 rPMPZEcj0xKWM2zNNK3r3vmW6wghqi48c1jYWzLQKRwAqwoDPTO0xyk2Nvhhjvs7nznGCWur8RE
 /HiuW5VIK90X59+2kLWhkVWTmttUBA6UiL8PWI+bJchIimJkqj1CFKNgkheUFfnm/M6YSKWrJAM
 3iPVgPekQ8m8icmm4kd6cX2Lv8OKQKZjfnyIMcGHRP8ecNnB5Tro8pOLVzs3l8Zt14TKJRw+Q6Y
 Bj34uhZGPqxHSx/CIChyr2WSM2YA6AsieZh3L7hxGrV3VatrTK2UAb4Yedekw5bGs681z1D4syk
 RV71v4ar0Ox5vwo9zjRwlmPUF0+O8RshqT87E6noKZmGwDj8uJbCuJuTz4SlV1/IDr8Y9BbSOpu
 2hR9r1/6R0x+5WexVbPP/yFWrYlG5oBc19FwH0Y2P8bpDrylHJi32kg/wyxS1WbNFTCkTZfX1Hf
 0ckYAx2nkBntecoTL3UfTDB8+emi1q7bo7AYgkEUwD1hsX6lFAzVRW8/LR8C2WSeSKaSjaaBTWN
 c/gijt6v7F4zAf9YNa4dICd31TKKIa7mKmNTfbAm4iqkBp6HvM6ly4FWwGM8Dbh0V2xPbyQ131A
 +J+u76xZxycuXgw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34448-lists,linux-wireless=lfdr.de,david.ixit.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[david@ixit.cz];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D4473AA66B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This quirk is used so far used on:
 - LG G7 ThinQ
 - Xiaomi Poco F1

I'm resending it after ~ 4 years since initial send due to Snapdragon
845 being one of best supported platform for mobile phones running
Linux, so it would be shame to not have shiny support.

Original thread:
  https://lore.kernel.org/all/b796bfee-b753-479a-a8d6-ba1fe3ee6222@ixit.cz/

I tried the embedding the information inside the firmware, but the
information is required *before* loading the firmware itself.
Firmware quirk thread:
  https://lore.kernel.org/linux-wireless/20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz/

Until merged, available also at:
  https://codeberg.org/sdm845/linux/commits/branch/b4/skip-host-cam-qmi-req

Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v5:
- Implement device-tree mutual-exclusion between
  snoc-host-cap-8bit-quirk and snoc-host-cap-skip-quirk. (Krzysztof)
- Link to v4: https://lore.kernel.org/r/20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz

Changes in v4:
- Added my own missing SoB. (Dmitry)
- Improve the commit message. (Dmitry)
- Link to v3: https://lore.kernel.org/r/20260325-skip-host-cam-qmi-req-v3-0-b163cf7b3c81@ixit.cz

Changes in v3:
- Rebased on recent linux-next (next-20260325).
- Improved motivation and description. (Dmitry)
- Link to v2: https://lore.kernel.org/r/20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz

---
Amit Pundir (3):
      dt-bindings: wireless: ath10k: Add quirk to skip host cap QMI requests
      ath10k: Add device-tree quirk to skip host cap QMI requests
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk

 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml       | 11 +++++++++++
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  1 +
 drivers/net/wireless/ath/ath10k/qmi.c                       | 13 ++++++++++---
 drivers/net/wireless/ath/ath10k/snoc.c                      |  3 +++
 drivers/net/wireless/ath/ath10k/snoc.h                      |  1 +
 5 files changed, 26 insertions(+), 3 deletions(-)
---
base-commit: 816f193dd0d95246f208590924dd962b192def78
change-id: 20251110-skip-host-cam-qmi-req-e155628ebc39

Best regards,
-- 
David Heidelberg <david@ixit.cz>



