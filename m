Return-Path: <linux-wireless+bounces-34329-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIciJmPHz2lH0QYAu9opvQ
	(envelope-from <linux-wireless+bounces-34329-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:57:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02545394C80
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C973D3046989
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CEA38E124;
	Fri,  3 Apr 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="lhspZ84U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7C37187C
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224522; cv=none; b=m/GMLR3c9dSzR9vwtSwQ+XbHKgC4somF98D9YINMzltiq/7WHw63CjYIuRXUOQboP+cu1IVFnHTLdWAyi/79SOceiEh1/+v+vwu4I6Lr/3rfRr+tY/j42iwNtM6TqDU6IU1iH3bciljxyf5dwACaEZP57XAauTjUK+nejAahtrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224522; c=relaxed/simple;
	bh=pHexCrMEYsMQQy8zIs+sRrHJ1/ttZ3VMNeWvno6IS14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTQ3mLzlSxGe9zCJnilwX3lzYjyHg0cOj3qcRCYNc8QoiElOvjEs/KdFsJuXuH4yZN2H13wjp6IIRebe9HG1AWGB6o5fG1AGc8sccATwg88/m1nHLp7LzstXbE/FwdpxKdvQN9W6NgfXDhlQWARuIVBgGNE7eqtSvlh0D5jJoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=lhspZ84U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b980785a0bfso242393066b.3
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224515; x=1775829315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOCuD1EIBix+K2H4tXL5BYaPaJquyNo2g3/MFSpuIHI=;
        b=lhspZ84UwlEkwAdlqjW5n7AVdmK6VsAiJ46y93iH/lNolffn7OPkbasRDhuPcWmmuX
         BgOMcQcCeBibMYg/ffAMRc998pjmsYuwBu5oPVaP4pdWaJlbXPeIn4Fotyva5x8S2N2Z
         GPtxOVEb9oQa3XB23ngXTYBqUTWnXFSj9FexaYvclASjAlf0EvxQJ7yQWCPqi6hryNav
         fqsnytSrW3F19wTB1X38uE0aQCgxyEaeb1ztiAE57Nir4f9+L/glB++C83mbIgk0+dZX
         w019zZjzxC0qeMU0dlidIWaQwouTbryA+R77eZZRYsUxVsfoWcKCRTvxwFzP/pP5SD10
         nSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224515; x=1775829315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YOCuD1EIBix+K2H4tXL5BYaPaJquyNo2g3/MFSpuIHI=;
        b=fQQMzHXTQ6s7DDNVzyDYRxDLk5zwHDV3Wqgi0DV3q0wDNPcjohrUmeEdsqLQS41BwR
         rQztoKzTwStxo0thr6aE6ND0uWTbqOM5o9HX0Q+XG1vDju3JsxvKF/lx4MzSm0Dta8nN
         5cpTdZ3iL3wQCQBJV/xtlPeXeKwUdudSFy6ikpfCzNHjf55nZe0wV2pEHXGUGRYCOoU9
         plJeYhwcJUeS6+gsFavmmLgjIHzvryOX+lbktIaZWmQhJsfQF7tbzXQUEDMLPJzpy3Wy
         7qWhkn9Xbe6dgcDxJQqHUvLr/YWgTIOMcSXt1El4r1Ic+KZLV5nnpf5DxAmoi/JHXMss
         EK2A==
X-Forwarded-Encrypted: i=1; AJvYcCVINACrRsfkgd6v7TcYpeAELhmYHQKei+jOvCt6cgLa5cIuckcl0fYi90xJn8PuFjOCcPpkLojQMsVefgN2ZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI8gnRISTo+/LlL2OPdb5EEy6qkevaFdfVD80TuSyz6LtSwNiz
	VTkFvC2lieyw9ge9Yk9cqzPFf83YxUTgGUeEC98WISEpaBOBozVUuFlPMfpOd9DVvr8=
X-Gm-Gg: AeBDietTPe6EpwtQR8aL7nS/xjXf5LU/ZAdkojmDf6OqdRUGmOQoLwpHbwA+oKgxBGE
	4V3HAmr8bBRACx9iHdAsk0knjF0ZmYWEzi4R4M6uxvi46ynYsaiOU/0yhPJzpNQZpUbvILbqyhO
	ToxZog2qmRmfhQu28PzOf4WX2dz+OCHrD2vB2ziPn8ql+Li6ity4/VWguHpeofpPGyQcOrh+gMR
	GctlJsWfsUStkuqYGIkR6DJKtTki+RVnRNJRputVBa/AHDdNPfgqJkk6UxYKomSeo7dWsGHoaC9
	0frv+2WhhOoGea2v4II89eGmX/bg8nzFcbcGd3BEMYKnF1IYBaxGX2blpDFwn30ClgZIK4NXSYw
	NuJS+MOhuClGyndJhFOjzi3GrUEBLIn/SpKiZpFjPA0ITpIxkOCwP+dmCgQVmQZfkE62qHZm4et
	ZaBEvu4s3sLzcB6PbOEaIXDEhAL10LMEBWz0DE6ID6cB4LG9dHwEo8FVRiH/xrmOIaWL56Wwtgh
	eIHSJJgGGUJTgXwlwuWKPbB4DjG+weHCfXfAg==
X-Received: by 2002:a17:906:5189:10b0:b9b:1ea2:97d3 with SMTP id a640c23a62f3a-b9c67924de3mr103637866b.35.1775224515233;
        Fri, 03 Apr 2026 06:55:15 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:48 +0200
Subject: [PATCH v2 2/7] dt-bindings: bluetooth: qcom,wcn6750-bt: Document
 WCN6755 Bluetooth
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-2-393322b27c5f@fairphone.com>
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
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
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1081;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=pHexCrMEYsMQQy8zIs+sRrHJ1/ttZ3VMNeWvno6IS14=;
 b=XCK+78nLfEjrwFntw0oaIZ6QCMaMqe0pdyMGnaJ0nfiCKkScqZ/j56Z2tA7Pr/+6ADMeTVzTg
 pRaItd1h5BQBiCmYvoHhG6jioNRifeUAqMjZopZPnAysEnsr3FFCL+h
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34329-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fairphone.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:dkim,fairphone.com:email,fairphone.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02545394C80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the WCN6755 Bluetooth using a fallback to WCN6750 since the two
chips seem to be completely pin and software compatible. In fact the
original downstream kernel just pretends the WCN6755 is a WCN6750.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml     | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
index 8606a45ac9b9..79522409d709 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,wcn6750-bt.yaml
@@ -12,8 +12,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - qcom,wcn6750-bt
+    oneOf:
+      - items:
+          - enum:
+              - qcom,wcn6755-bt
+          - const: qcom,wcn6750-bt
+
+      - enum:
+          - qcom,wcn6750-bt
 
   enable-gpios:
     maxItems: 1

-- 
2.53.0


