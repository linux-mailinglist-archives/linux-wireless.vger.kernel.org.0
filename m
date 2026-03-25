Return-Path: <linux-wireless+bounces-33853-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J2jJsUTxGmfwAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33853-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:56:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F8D329782
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED66B3010B91
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF813EAC8D;
	Wed, 25 Mar 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="En979Eku"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A1B3D8905;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456878; cv=none; b=hAJC1ENCqjsTShz7WDhftC3RDdBCFgLO+Op5o8J5+neRigyddNYKNaFHepYBLILXjO/ksD5f/AR3l8AS94mnJq7mnZXX6HomBmW5h0p3XZ56gDoEbmWq+GvTMOatpUcjU+EHoX7bct9wqsA4FPylwgLkU6nUffzsEyRW36F2A50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456878; c=relaxed/simple;
	bh=vtK7rSLmOZizMz4lOu2txEFWIOZihcAENkHz9Einb/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pi0u3gAh17c+XlgHqEytuqwFqd+pm77nvrlp/ttjFw8T7tggdi5/G12PmU6hDRc38WipcPfhVTi3pNgu6MCs2oWaPiArGQdVtwASgKZqlEKMpL2DDygrXEdN9FJWqqTXg0ZXZLH5ZGWBI2jtwl+ptvUJvkHTKXXRn3aGcdJSqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=En979Eku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87DB5C2BCB0;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456877;
	bh=vtK7rSLmOZizMz4lOu2txEFWIOZihcAENkHz9Einb/Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=En979Eku+qvZsKfSn4jjAUbjbggnL5gq2Ibnvno3DzrEhSILZxBAS7QSoblws4YxW
	 5rgmBqA4mL1PCReTdvObRE0eThDwEl3OWgxH0eze2LnrQevuaWPcKZUOrN7vxlO339
	 Jc3n7n6v8A0t8Va2RT1NGZbFPt9fS+j4gzll6XCoGqQWj8AfsmskI2L9AeMc8bJdRK
	 dXhQ1KPYzgfV5UNpM01WQb1lPtChszAQDw7C8p/B4AXNzV3CzkZbE0MrPYiYVbtOGS
	 GEbvsHw6jtqRO6A1GWhz9qlvtbcloHZ1OwgBTtiyJjUTLdD+n9J1gk5ERG8CnvJeff
	 cU3BU1twZeo3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB39109C041;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Subject: [PATCH v3 0/3] ath10k: Introduce a devicetree quirk to skip host
 cap QMI requests
Date: Wed, 25 Mar 2026 17:41:11 +0100
Message-Id: <20260325-skip-host-cam-qmi-req-v3-0-b163cf7b3c81@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACcQxGkC/4WOS27DMAxErxJoXQaSErlyVrlHkQVr0zbRSHIo1
 cgHvnsVX6CbAd5i3sxLZRKmrE67lxJaOHOKFQ4fO9VNGEcC7isrq60zxmjIPzzDlHKBDgPcAoP
 QDcg411hP392hVbU7Cw1837xfl8qDpABlEsLNZhpttPPOGzDtsakJIxfIFHuggHwFDFz282/sW
 c5Xjihpn2R8qyfOJclje7zY98B/5xYLGnSPw9E7bP0nnvle7d1TXdZ1/QPmdeibAwEAAA==
X-Change-ID: 20251110-skip-host-cam-qmi-req-e155628ebc39
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Paul Sajna <sajattack@postmarketos.org>
Cc: Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org, 
 devicetree@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=vtK7rSLmOZizMz4lOu2txEFWIOZihcAENkHz9Einb/Q=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxBArTJ7PfpWkqgf/dBwhmh4IilQZcFtLdhKrY
 0cNZqsWLXuJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQQKwAKCRBgAj/E00kg
 csJsEACKM0vsF6hpEzSHmJ0lYNQSj7bCkni9QQ5+PB4FQ/V/fhxXw5/NTjomHc5NDBcu9jFzVZi
 kTx46Ars3CTwwhMClTb8+dnBzdTkGC2V9V+CBe+76+jCz8rR8WM07st6+3rsnIRS1d3Qg1/OT1S
 tCDjwTy/Go9nCJeH9b02wseWUa8SWgVQItpXFwkB0PvmLXz0gWEu2DCoWn7Tq/wSd8ixG3+c/zU
 aDeBma7exjYVaAg4sc9OG2j8biUe6tMWuFXt0Y0uys/Rqv6rM/EWHcWXPG7Et9Eusvs3qLAOBR/
 LRFz8m2geTY2vWyWuKG0WaMgaE32VCDPq1st1qnHr94HC0Rhoo5m0C5/KbJegCedNfU1GVAU697
 smIHLkSG8YvAIyGFrSxyVp7OhNWyr8sOaJhxF9apqDD2oAxKsE0ZMZRD9+ggAcS8wKV1W5oS/49
 69Ho3ypEm31JFw/ALPHtKCQgnrmBX6xF/5pcIrYjdDMPUZloV/4b9BcOx15j5lA4Mqu2DuXgTYH
 r9pbBke/IXAVG2ClOeyru19Zvr5UzKVMbSw0/B2z4v/0BogFinvcuahduVJWv5cURVXO8MXoytg
 SesbPIWgekWct70DNyIop6lYs+crUqxV1bG9LIibq5w5C+tfRdWfKU/bVPEUJ3mcc7AbKsdjha2
 qaLtkSOtVRg8+HQ==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33853-lists,linux-wireless=lfdr.de,david.ixit.cz];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[david@ixit.cz];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ixit.cz:email,ixit.cz:replyto,ixit.cz:mid,codeberg.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58F8D329782
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
Changes in v3:
- Rebased on recent linux-next (next-20260325).
- Improved motivation and description. (Dmitry)
- Link to v2: https://lore.kernel.org/r/20251110-skip-host-cam-qmi-req-v2-0-0daf485a987a@ixit.cz

---
Amit Pundir (3):
      dt-bindings: wireless: ath10k: Introduce quirk to skip host cap QMI requests
      ath10k: Introduce a device-tree quirk to skip host cap QMI requests
      arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable ath10k host-cap skip quirk

 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml       |  6 ++++++
 .../arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  1 +
 drivers/net/wireless/ath/ath10k/qmi.c                       | 13 ++++++++++---
 drivers/net/wireless/ath/ath10k/snoc.c                      |  3 +++
 drivers/net/wireless/ath/ath10k/snoc.h                      |  1 +
 5 files changed, 21 insertions(+), 3 deletions(-)
---
base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
change-id: 20251110-skip-host-cam-qmi-req-e155628ebc39

Best regards,
-- 
David Heidelberg <david@ixit.cz>



