Return-Path: <linux-wireless+bounces-33863-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNG1BiMjxGmZwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33863-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:02:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6032A3AE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F2830523DE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40214407560;
	Wed, 25 Mar 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzPFifXY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156983E025D;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461438; cv=none; b=kjjJ4FLpeSpYABvQhocVP7zZF9xbqCzabJ+fWIufRNYGEdIw7qToMmXNhE10nvrh1uG+8sTkWw4dqIVEt0a5IdUDRTUFlYiKP7lLWao7E5k1VvB9psqCMDvYl6omJjdO2/5PQdB8Cknqk2gjRkQWSTh1r7L6HVww5zgvNMaMoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461438; c=relaxed/simple;
	bh=rLDm0/z7gFOJMuRH2GprHEW5mgXEEAaNJQATCQyYAiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNLJmPmAeysgzreqgYkP0lwkZXBvOyRuTjEToWkKQrwkPWk4O92Hqs4Kim8KsS7Z4SQnO8VGOD+qLWKAgxc/tXDOEDShKaR4FendkpOtWVW5miGe2/Ggz33axH6RXzNRU562/Z1Lm0V/M7IkhAKNv+qaNRIdtQKK8XZ7xWzi0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzPFifXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9897C4CEF7;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774461437;
	bh=rLDm0/z7gFOJMuRH2GprHEW5mgXEEAaNJQATCQyYAiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gzPFifXYR7Zkkl+lq6N1p4tLrRencskst/5zPXrwf8edKV0r824K8G81ULINxHK0o
	 Y54ND9Z6HQlSgoNxPTS/FO1jZY/+dd+6ymiszCxmtdTQp+PhSEyAoVkD5gqHFscnNm
	 anhIx0lQWzX9CBD+q8gJYG863rcdaQkKKuAXsjHr3q9tGZK7o6dbHqibRLmOr7QEvL
	 DW+gt0zGum+bRjZh7drnRuM+jR7tupBAhXLOf3DPooIfu2s9TmRlNWyRoFbW22BjSz
	 jQC0q60S8pAqdlwXD4z6gYLq774cixlR1iyqadTo6juAO6utCJLXVtBSEZm7b/c4ev
	 RWP0nPZNIYiOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9912109C050;
	Wed, 25 Mar 2026 17:57:17 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 25 Mar 2026 18:57:15 +0100
Subject: [PATCH v4 1/3] dt-bindings: wireless: ath10k: Add quirk to skip
 host cap QMI requests
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-skip-host-cam-qmi-req-v4-1-bc08538487aa@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1221; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=/8qUsNDjZq5nMAWqSvN26r6+nO/+y9uNfhTrBdSgls4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpxCH7tYvhKdRWxn37UiaCzxwuvwqrhsSG9sPeT
 +oOYgR7E4eJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacQh+wAKCRBgAj/E00kg
 clTkD/48f15KKMy94GM3zg0pd84HcSO316PCHR8euVg4gAPZk054dbEOMbqZUENK/r+w3QQfzpw
 UE/5YYuWDHOmKGRzT301wJROqaHJE5iGlyvSNug/gAxIZwFzQjvtjtExvAnLe4bJoDqNxhctSD0
 ZhP3P0pQruy89bVhnkeXsSua8rzcdMSJfe/XKvWnFN60hXPhNVGV+blfMjWzxhfj2gHl6SCk1yt
 BBarcaVJzWOMeRPf9Bw8Ou6f8EHTZhowwLS5Mj0E5ExVyPsB+m9/WuOnrT5LEo0n6HTdgyd5h8e
 clddgb8GG7qVOqzFX4gJQ49Lyv1kLp7PZTre03ahAycNa7HeVfeB/SE1fNcj44MGXVWEAj9sXlW
 8ZKcbtib3lrK6dklP4zDEOyRaZ72imPMUryvsIvFG3jgps+EssvFIHKllLtliGwxh/IBgt9i3re
 GySSyAFpr/Y8hGpJPl3LdboTLuT7ltA/pLjtoT7gTJEE38QWN7LnFj8GCneZk7QRiz5Je9tsJ2K
 8gK8mf76hf22wnYZduMQvd+bzUghBlhveJHt7dFVizuowDz1tTOtyHMOAKBFNUfo/XLmsB6IdUe
 hF7RgnlzodNclnWz7vUKfxcqPngwmYaSbveSNKoYV/Vgr/++LDcM24UuxVA3JUqSBUBJqy+7bMu
 PUey1Vy5r/dvpkw==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33863-lists,linux-wireless=lfdr.de,david.ixit.cz];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:email,ixit.cz:replyto,ixit.cz:mid]
X-Rspamd-Queue-Id: 9CD6032A3AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Amit Pundir <amit.pundir@linaro.org>

Some firmware versions do not support the host-capability QMI request.
Since this request occurs before firmware and board files are loaded,
the quirk cannot be expressed in the firmware itself and must be described
in the device tree.

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



