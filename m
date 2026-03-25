Return-Path: <linux-wireless+bounces-33852-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHleHjATxGmfwAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33852-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:54:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D67753296E5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20CDE3046027
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288133E8C68;
	Wed, 25 Mar 2026 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAHwmzEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039813CC9F8;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456878; cv=none; b=gADiN6AXhOXfOEsE2oYvv94uHaF+NPf9+Dh6IvNWkK7VqOulOiw9dPi5kzeFX1m6yRrnzUtcLGsW1uvfVQIkgWa7wuksgbhpkKA4t4C2yufb6g7qK5PvExj9zsdbocpap+GEA6AE/a29KssJLzytgOkOXlWnwWLdoSKWtG4+ebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456878; c=relaxed/simple;
	bh=ulufeSA1tGGPP1e0QrNAVTj3y0lhEZxQY5RP+AWdRiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DU6Xguzl1Z8YYpYEgLdd8zP9RYVVGWYgkFfUKnP1w7Ogxn7y4r2yxHCm++V1WwpBQdE2ZAnz8MPG9xuZNjheaU2JeRBYFORqGhbof/3RGI0AefXw0yodHwhNdjpBw3Uemk+PdaD9Nc4XzpC14VFimbSwWvoZkn1uU0Ig0WUet1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAHwmzEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5E40C19423;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456877;
	bh=ulufeSA1tGGPP1e0QrNAVTj3y0lhEZxQY5RP+AWdRiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lAHwmzEGQkYHeBv5xcFFsOHJOOYuqwD+LchmosVXriQRlF57OblVZ4ttwhTRc46SM
	 2ZAQdAjXNTBnrbV8cPWWPWiwvi1jPt/iT+PYI/n/J4MBf1U/JlyWnC7ga/BNr/57Ie
	 0xr3pXHRGVPV3W+nkooc2ArNbVZzbiGxF46hAmyvhGa4CAEwL8bAnYeJNpijda9g0T
	 NATdbC6hCEyTu91V8tPrPM8x3nari8RFuyOPIUE+jFKxyk3dnLqQfECViB0eYkJG2l
	 KEeNovgaJsOcp/kuhbtQl6F24QmZvwKpyE2y1Y4niRf8AAYWvb5+N+yJDE0e9PRxp4
	 UrTi+U70YFl/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972AD109C040;
	Wed, 25 Mar 2026 16:41:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Mar 2026 17:41:12 +0100
Subject: [PATCH v3 1/3] dt-bindings: wireless: ath10k: Introduce quirk to
 skip host cap QMI requests
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-skip-host-cam-qmi-req-v3-1-b163cf7b3c81@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=MEOt3SMdJE/GBpWMQAq3qov+9BM1LX4l8sFyx0gK28g=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxBAs06VVgNasyU9OMzOcVIK8wXTqTwoy05ExR
 Gxby/HcVj6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQQLAAKCRBgAj/E00kg
 ckctEADPstXjr6+tPWWuzprLUqZj21UqGEPg57hKPIIiXgIkmkBvohi73ttOJrZwJHx8SsrQvx7
 yS35aDxoS7m5tllrMzJDes06wKJeB0oXUEp3KjcPEj+mGsUz5eSHKaz2sSKe3u90lv3hhMXFZCz
 NS1lez41OuhhNaXF6zxumA0gD4NBXkpChoSTdrjgcP3qcAcP0BGPhZ+d1yRJReT7Ji9+iTOI/X4
 BIQrdHeyjPAohizWMt9Xvhz5FM715UJttf4iE0mnnzF49c6RlVfSb1s+fBocsZ3kMoJtdkHbJS0
 OhX+94KINFkstZtkeSf9Wb+kleF9WmTRJOltvPkAIWjud3IvADff46T23ic+oTFgdbHCLfld3tr
 iVUNq2TQit5eBoTulrxrX8xHPJV+y4/BbW7tfvqy25sKvPejhSWU8n6jQpZp+/dk7un87RDOoPJ
 564yVBNl9Rl9kUOAJZvxkK09h8qgEyzssyyTBq2K2TKWzh6QVbvrrFnTURt6/jS5MZEjV0h00Zo
 53myBSjacOHAoZZ4l3yyueTYgFBJxqeHJQWc4+0PubmpnpWWJoJCV3tIgegXRWGeMd2HIwc2ROp
 vtHGred+Lc+cggPZZ1mvljb2nsAkEdobLrXx18FdusFi7djz4rq6RCTLXjT1zlyovTc75cbhpZx
 wZbOErO56Q9FKiQ==
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
	TAGGED_FROM(0.00)[bounces-33852-lists,linux-wireless=lfdr.de,david.ixit.cz];
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
X-Rspamd-Queue-Id: D67753296E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

Introducing this quirk to skip host capability QMI request for the firmware
versions which do not support this feature.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index f2440d39b7ebc..5120b3589ab57 100644
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

-- 
2.53.0



