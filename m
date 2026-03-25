Return-Path: <linux-wireless+bounces-33855-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKkBCtAQxGnuvwQAu9opvQ
	(envelope-from <linux-wireless+bounces-33855-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:44:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6832940D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A770B30461BD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4E3F99D1;
	Wed, 25 Mar 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQA4HCKo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C93EE1F9;
	Wed, 25 Mar 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456878; cv=none; b=M8N74hr7RRW+SpSUox8zM3b82kNMTeQLQMhlhmi20w0KBB8VgVL48N3DXI1CytGAzvDmSq/9zttt2C44OgkaKUYEpZ9BZ3zzZRZR1EwE76lnSnw95K0WL7YVbfAwdqzZJc737oJ9Cpc/u3Co8KFMGBLB8Je2dUMX0tO5mvMrwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456878; c=relaxed/simple;
	bh=6r56vRLyHeP5BD6dmv04kNmhbxNmzn4mBEXXmMYZnrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIKK9ZXRMzght+aEsyYpotRTwT15ZWMPvB218yjFn94ckWCvw16jcH2BSdddT/Lts35kzKDrI91Ehfqkz5UuDwvdn7ZKrSH7IMdHbBkRCFkWrMxPnXyEspm/OPCWiN2q+HMeRb8nZ6EjylCN1NtGlPXVd7fMMVDh2dAeZIcZFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQA4HCKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E81D6C4AF0C;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456878;
	bh=6r56vRLyHeP5BD6dmv04kNmhbxNmzn4mBEXXmMYZnrk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vQA4HCKoaFd14EWWIhmRqM3gtyNOTWI8R0kWRN00F44guBIBenhjvBPuXj2F1syAj
	 off5sTmzsmGgFgC7H0MUQCq0GZUZWDzlqoODfi37SFRy10yb9LozHSDWk3jENyDV+3
	 Mjsq1+gkaHFFoIBX/mBz8OYFYyv8e0RN4OMl/Kw3VHpXxRqCjo7DXDatu3MThQnsvH
	 wHFlwkjnFJxPkiVuBwu24JaaYN3atwz083qnCURRQ/QkENPsEijG85xz5Bfmnr0G6V
	 qUcXfSfCfGNG+YeXeigKmJGbUxP8Xm9oa1pLwhrW+tD0Bpl+q0H9V+EYSsxY41w1Mh
	 IrkA5MZbWoJ3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B48109C044;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Mar 2026 17:41:14 +0100
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
 ath10k host-cap skip quirk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-skip-host-cam-qmi-req-v3-3-b163cf7b3c81@ixit.cz>
References: <20260325-skip-host-cam-qmi-req-v3-0-b163cf7b3c81@ixit.cz>
In-Reply-To: <20260325-skip-host-cam-qmi-req-v3-0-b163cf7b3c81@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=UMGVnHrK6pCDEFTzYCQCMat5Ekz90Tnn8gJJq27l4D8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxBAsImtUxcwDcuRQMT2RSZfTcA3re//OcMpda
 28Dc4T3s42JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQQLAAKCRBgAj/E00kg
 cs8ID/9d8cdH52NkCDRPgE25911WcApLT2YMEJpTG5Y4a2frJfmGQpsZWKlAeSrofnqoWTNnLjk
 XSaWdtvercDcwqk9kY/CH3tuLpeUJwhu10wuTmejuqCw6r1QgpybI6TQdJDDxhESYrtCGtjXuOY
 mlvFae/u7Fss9Y0HU9Gi0jckJkYKzok4X6/FWDPzU+LvBEcS+yDHh9IlaybcFnhcBGsKiCgfXu4
 GY0cWoujkiqgAFC2cGZc53/td6utuG5+Ek7YMfGt8jyqDfXUxTkMHkx7t0p2iTfyZo8yvyDFR7s
 1igCwudvjHPnulQ+opB7Oyh7mUyG1mNDlEtJQyiHZOqpSBgYlQk2p2llQ70TI1jjY4d8+bhU9Nr
 kJUaXAakMcgZTrrLC4fKutDx+0k1AY/LUz0lmO+YlnijROhTZikHQXKoHC45E5NZqIHw0slDOQs
 Vx0nFbdVR3znZ1GzIIbMFy96GGdiAgo8bpw3wEyu1rOVHzlt+mpAK1PRWAo8weAluR9xGTrWYVR
 B/XdR9rCbYl+gAqAO+ikNRXJvBcI1AUYfLSmMC4MovUjisWpPCm6klUCooiaWpuK/448AKucRNp
 CZkwUwQWpg1jaRUG+tjIWMB6WAA/gXOlqb13/ixqd+IqwVOagJjJfpHq8h034x+WT83P/oSQCL5
 idr7kEpNjPNiALg==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33855-lists,linux-wireless=lfdr.de,david.ixit.cz];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 0ED6832940D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

The WiFi firmware used on Xiaomi PocoPhone F1 (beryllium) phone
doesn't support the host-capability QMI request, hence enable
the skip quirk for this device.

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



