Return-Path: <linux-wireless+bounces-33864-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE3vLycjxGmZwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33864-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:02:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B1F32A3C3
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C92D130541FD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B240825C;
	Wed, 25 Mar 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbDVLN8F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C003A6EF4;
	Wed, 25 Mar 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461438; cv=none; b=K+v7Jtr/sXPwPibAmZsNrW6I8Lo8ONdQtcxW4HLvqdWXHBbewmBaQSFLi360L6pvl5fNwZdf1oeTW+IYvet2oWGq6Q8n57oSQhi381iijvaW9jyB2LLqXVCUXPbpxJoCM1PKCTJXOnoFXolX4vZBMc1C/aoyiB4djUpJqFe3fy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461438; c=relaxed/simple;
	bh=qsTEgT/W9QOLmt4TqjUxrRDazuJnu2x+qBXV69+B19g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr7dpgdmKd0hjs+7Kh/xRsUlbcvhwJgIK0zz7CxBq7hlBl2w3bBQ9nrpv0tT2PTyWDixIzL1nzNsdMItJ5ba1hxCaAPg4vSZi0lwCk9Jr85lTglwaf3XT+Ai+KCuwf58thzg7Rkbr3OoKZFrLa+gB63EgXR+8f2lLGuwNaJghP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbDVLN8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9C0CC4AF0D;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461437;
	bh=qsTEgT/W9QOLmt4TqjUxrRDazuJnu2x+qBXV69+B19g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gbDVLN8Fpu3Y7PeQcKnWHkJUTKf7w+RjrgOa4GMGSBzumrQ3tRCcOw1dTcUkw+RJ9
	 kNnF5Qz3on9ZZ4/8YlCe8Kej/Q6SkMbd/NoO7lntP9qggA2ZK0IaV+/8LTqcLfez7L
	 bqcvltmDsasyZiAyCULo1aqYerh7lQTGrHCX4n1HC9OJ80YOmJLkkAgrehPhoTFl/H
	 xod+SHD842T1SzWIrradQuinkf1r1q61sFnju1crX2dfDXVk7i/yy7e+xTNNTanYnf
	 dQ/15NmiF0wufdYttkfRec5qB7cWXyXpKQons7uHXbzHn2+MfnjnDgqs8zSwtZFBED
	 27V0cw/Rumj1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA3109C04D;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Mar 2026 18:57:17 +0100
Subject: [PATCH v4 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
 ath10k host-cap skip quirk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-skip-host-cam-qmi-req-v4-3-bc08538487aa@ixit.cz>
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
In-Reply-To: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=7WCT4AIXs3RES5sBwcwPY1VLLZLiJwKsEh3sFLY3XeA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxCH731ERAs00JnGTMwhjDc7fvFNGG6zHnruKt
 CzctlaDyk6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQh+wAKCRBgAj/E00kg
 ch0UD/9bRRDJsrM0G4teP9+2n5J/36wjbkVECTL3P9N4I0zEVmBUPaHYndwRhiz2OdWQ850FzrC
 9l3RUNEjqdi14CbA3wNDnNBlqGdS4m7pnEjPTCgz9rUa4pqqV0blSTnsxMPUkldndytGhBMwCKv
 0FZ3HnHYNjX/9p/OrHglUWmuuSeWS7pCWZQEuTC+yNesYSgdUoFJpgQKZ/AIephysyQGo06c0Cx
 3/5FajViggtoX8K9bYrnoRaOiBNoGs2i6iKNn6ybc++JRtcwDkUjKzhE36jVN8YpsvijHreLHyu
 73SmHDNuQxi7fq7P6paQx6SjMpNMrhSEvQocilCvJmiUYAH1t8Q5OFXGiuDDWcvcsz80tr+o37x
 R9i5YxVJ6xDXBT8XEJWfEIyqsu97obj4TILDO3NDEKOkduvAnVPsirgFlsnxi4DSL/i08yJOf3y
 eQGFnhEqzkok4HpJyylXIqGQ0sAQHXcPijZhs0lpdUz9hnhnzdCLxl8iUBx5Wm2HrKONCex7uSz
 VTG56POA1mOSu48mQV2blAZIyNk8lM52x8t8OAE1j7Ny0ov41eHqmcBT2KYnB6c0ZV4V+8/wraS
 zazwSChKzwhWB4ku7qk80ODz/xgoYzcE/trWbyUqIeyNCwAzGWpXLJeeyZisCa4PEQLcyF8covI
 zF7BssX7Fpp7DYA==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33864-lists,linux-wireless=lfdr.de,david.ixit.cz];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email,ixit.cz:replyto,ixit.cz:mid]
X-Rspamd-Queue-Id: 11B1F32A3C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

The Wi-Fi firmware used on Xiaomi Poco F1 (beryllium) phone doesn't
support the host-capability QMI request, so add a quirk to skip it on
this device.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 1298485c42142..950bbcc3bf91f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -661,5 +661,6 @@ &wifi {
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 
 	qcom,calibration-variant = "xiaomi_beryllium";
+	qcom,snoc-host-cap-skip-quirk;
 };
 

-- 
2.53.0



