Return-Path: <linux-wireless+bounces-34447-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMltOF6o1GmkwAcAu9opvQ
	(envelope-from <linux-wireless+bounces-34447-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:46:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2723AA70A
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9493F3074104
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 06:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215F38A298;
	Tue,  7 Apr 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH6nWXwY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9510389119;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544240; cv=none; b=rH1wcs8zj8gBkUYoRbPfZecGkxGjN4CsxWTdCZsFx16u5nijma7z52ksPDVLuvUEonZ9ZmCxN/k8wngQnc4lgo80UThWeFYFGhfn82YViYP5tvHTeZgOFlxKhUok0JXxgWzwqaNaalS+jMyw6Lofq0AQ22ivxe9lzaKNMQZxPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544240; c=relaxed/simple;
	bh=Te43aWuAgzoNv/WPGZnzW3zZ+aV+8/H/z+FNFK7lU94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFPAJ+OgJdoYkKEKC4jxWfkpW9vhsWQIwq+7FTcRGW+4IXMh+nD4/GpMYinLyPcyaLNTj195Y21vIKj64LGQ1sdGVInd/WLmc9Jp3mQSof8jTQCUCdg4DlLke8IPJkMdjQr6e7NgbqzKQu7lpqiJZ8xqRHbJgJoplS2f47FgmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH6nWXwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F2DDC2BC9E;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775544240;
	bh=Te43aWuAgzoNv/WPGZnzW3zZ+aV+8/H/z+FNFK7lU94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nH6nWXwYGakVtZvQSTSHUc1XgpKajBMKcBgbY118ti6DdFgIqFdBX9QfWORtsZE1Q
	 YcO2NEUGJRMdLHzbzAzibKc21A1OKRmhg1KOYgdV1QcJw7Qn4vbamFhYqvGpqtyXOZ
	 hVjThEWh35D7wmKY2lsvrKQN58WHKNbe9qop2fSmBK2Ym2y4Tc3K1GV2yIsiqZr3K+
	 JpMBDxgKJbNSvoB8A1mxlTNbZmbzPfuf+R5nbefjIU44xN/p5MwywmN2e33lNS1hx0
	 gxgFNhb0C0o3kpyCQxFyXq1+5JlaUsNI3/Dmwmo0faoaxrM4u0g967n0IUn2LYt/oz
	 WQVnTHK6gxtGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8892BFB519E;
	Tue,  7 Apr 2026 06:44:00 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 07 Apr 2026 08:43:54 +0200
Subject: [PATCH v5 1/3] dt-bindings: wireless: ath10k: Add quirk to skip
 host cap QMI requests
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-skip-host-cam-qmi-req-v5-1-dfa8a05c6538@ixit.cz>
References: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
In-Reply-To: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=1luENuPnPeyXu5VeZAHgXAvwbtbY0TaE2mQPU89+fLM=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBp1KeuDBmYFxoMD+Feuzgv5t7+yMPiKxBLPkhjo
 BOciIS9EeuJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCadSnrgAKCRBgAj/E00kg
 crJnD/92pJEinb9W7xjyVfljYpzqTfNMPOo4pEvNwTgGCTm7Lq34y5I0iufUO/SBAILukgfj4bb
 j2XQd7yv00r8KhhrdbzXhg43Fj7/rKuSJMCENJBB4kDfverQ/wB7towGcS5lqeXym3D7XU6PS+S
 3uNXhdVG1ok4ZWliDtim/MWXWO3fiGzC+OIijYJX8dGYbmItcmRtfNbVJdQKyoAwAOGQM8jy1n0
 f0ip71zbZYbCIP8BqBXYf+iB0xSlIvY+9phdX2vQW8uwKpsqtIhsFyAde7pMBWYNV7GDPF3l6bL
 4Ge9GhFGiOKQowqoJKTmVZG9Pbq3HTyCebiJd/8WIAjUYEEAZO+4YRZjPXgbxshXDYsSGWDBP58
 Dtik0XR6CTDTMRDlRYIB9n3TGDmWXEJWBFWbIzNhoX5WV9aRVaSkop9wGziturc8MZQLXTotpyQ
 MIktNTjigI8p/KIv2wNQZPUJPKCcToYK3JWXgQ4FWSTSwmuzlCBLxyYlM/oVffbdkyGbrKwkZzE
 de7bXE/i06hqwv/4d0jptGDlzTUK4p8UPNPRVB1b4/qS3vPFUBbpAdwc1D4yne0DTMioKc5yXF2
 9EqOwclRLK6fo2OAo4H/kT9eiZCv69kjKoVShGU9PuEu8Fk+GJLHPFZyGfd6IFLPoFVClrYfwbP
 9SluheIL9DVDPJg==
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
	TAGGED_FROM(0.00)[bounces-34447-lists,linux-wireless=lfdr.de,david.ixit.cz];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ixit.cz:email,ixit.cz:replyto,ixit.cz:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 8C2723AA70A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

Some firmware versions do not support the host-capability QMI request.
Since this request occurs before firmware and board files are loaded,
the quirk cannot be expressed in the firmware itself and must be described
in the device tree.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index f2440d39b7ebc..c21d66c7cd558 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -171,6 +171,12 @@ properties:
       Quirk specifying that the firmware expects the 8bit version
       of the host capability QMI request
 
+  qcom,snoc-host-cap-skip-quirk:
+    type: boolean
+    description:
+      Quirk specifying that the firmware wants to skip the host
+      capability QMI request
+
   qcom,xo-cal-data:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -292,6 +298,11 @@ allOf:
       required:
         - interrupts
 
+  - not:
+      required:
+        - qcom,snoc-host-cap-8bit-quirk
+        - qcom,snoc-host-cap-skip-quirk
+
 examples:
   # SNoC
   - |

-- 
2.53.0



