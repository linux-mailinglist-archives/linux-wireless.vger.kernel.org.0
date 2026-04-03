Return-Path: <linux-wireless+bounces-34330-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGI/OKHHz2kS0gYAu9opvQ
	(envelope-from <linux-wireless+bounces-34330-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:58:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F822394CD2
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52BF93081D6D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8D53AD508;
	Fri,  3 Apr 2026 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="eMcDUq4k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF8386C25
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224525; cv=none; b=Ixe2/HAsn5ByecBDZ1828aXtxwBGTYdDGt06x10K5BjIEPAayCOlNqnu7oTEbyfX+sXo1IIiRaj2JAOYIePsSfyNxEDLObKjQjhmQ5rhHZhCCIt7aJZ4sP6uUKsecvQC2EmKvgA7P5+MmoxyIT9f4ffgSt5nQzSFzGDnEzP/DWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224525; c=relaxed/simple;
	bh=bX0RSkEhHMY0CQeWiiphb/xjS1x++AeW72AXUrJMhfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5BFQm5h9HyzOhGH359WL4dF3O5lIb7OtfziljSWRpYqjY52RrYZNJW5u9i1a6mDnFN1EQF2Fy3ryx4S293CPl2l1HO8NdhPkZr1193Cv8ywYdaBgw88KdDdzGcc+FUm+nFJbDhAelJNxHJfaXktSPUvNvvfPmtl4y+Ma7q+fAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=eMcDUq4k; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c745e18a0so125304866b.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 06:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224519; x=1775829319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00QsAJAs94/ZqUyZhadzKRAFArz8oATvGeKh7GrAju0=;
        b=eMcDUq4kDbXtJoLjYpvN4DIgSbal4SfAiQ0Bxs0F6N25Fnb15cXqGtpmsKKdnHVpq8
         CqLdZzyAlFZF0Pg6taXCioUz7T70PZlIyUcFqndMcZvtkhWtJdV7ifrGRv4iQoEkzWt+
         LutD/N5YlETUMeRA+y1H5VXvk9QNwV6ekKOL/TBPSmBoBbOkbWWsjWr20FJbFexyVJA4
         6z7DNHy3x4lAfjn+IjV8t5AFlAvu9V17eucFr2iaXX9QwJGtVsziti/srrzqpDfl2WgG
         XPoae8DCwCp2WfzEYiwRVA7m98eNXSbdZ/wcKK0Qz2SJyVvWaVboN2jj8VpK3NgT+PSs
         jo9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224519; x=1775829319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00QsAJAs94/ZqUyZhadzKRAFArz8oATvGeKh7GrAju0=;
        b=Kg8Zcm9pq/tqw08hcmLIrYH8DSPuB6pihJcnOlckJgvLxlLk2puCLpc3IBY5GnSUUE
         NFGanO80JobAvfLlOX5rD+XmJRhzlV4BiMe1g27qviu9whHZOAgxkMlcu4XBapnl1WPF
         Emm2JP7RpYO4G0V3BtgdvnHWe+RkVM3MUKhbw79UDZ57ZtAs54GnmIKEvypQcBjbb5+3
         leGqv6BPQ1Rd1eCmXV5v7t+FMfNlG4IuUxQ5J6ChVOqeXiiHlbrmzMHVMdXaVHRYcWDJ
         weh9j6RfxaKaEXdnHZgdJGBOvweK4jQ5+iFdBAVtxjJ+bk+/F/emCyjvJtyHyvHur331
         M4MA==
X-Forwarded-Encrypted: i=1; AJvYcCW3B96hUW6vi+JA/j9sWJ3jowr51WSUtW7UO3+1i/IRrqejGsYGCQVp0BB0ce+xNc3/48jGXrKTFF58jRRWTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70TWni5tt9yxSb1wd1tKMNcsNmZ5A84k7hrjeYB/52seOnTvl
	wN0nwAM71OMTDe8Zqm0eMsnm7rJ2Z5hWh1F7NQOZhfgP/M1uvsRsL6RX3Os+c9+Ju1o=
X-Gm-Gg: AeBDievYGwozmT3V5q+fFGp3xnYL6yiTMJNHsYGfPJx5lR2Ahl/uajq8NdWOJ32GNxl
	wjlh4jDPH3biCE1S8fc2zSq+u0KXMmlkRSESKD3R2bdbcFiZ3GfMT6466XaevicTaPBUTXwrELO
	d3XA3c69d7VRzqz75ZfT3xEAlFuejwMFGiMtU8WTiqENPu1vUpuDuXtrVLRbAgoFa3dwLEsnZ/x
	KCRAafLWm9xcMUaw7ViT+I42uu0LbAO35xX44VDraXn7lMv5Hz4+9h8qcGYnR95ppDmMhAhSMDp
	PX6GLPRP2xDWhe0U2OifAcHbe8Vae9LsihC7hMT6oxpZ5yQJzE77OMPCcKG6MYJGhQpgtIhWyUp
	lEj8GIxH1YEIoTnqvggyZZXLd1V0OOX70h/5lUPNQHnApH9JjTQSnmcRBUmk3iz6iJsXfwUxDJO
	ff/WFhIVJ1qC/HmV/HO6+dxjKTmRSnWD2aW6IlIkpdvGBQJETuY3VvMDcfCiiEECXwF2KAKVm7K
	UUZwZSKcsYtN8W4YVB60NAubIav78u+8ZaC2w==
X-Received: by 2002:a17:906:6a02:b0:b9c:cb1:a61b with SMTP id a640c23a62f3a-b9c658742acmr142510866b.16.1775224516202;
        Fri, 03 Apr 2026 06:55:16 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:49 +0200
Subject: [PATCH v2 3/7] dt-bindings: net: wireless: ath11k: Document
 WCN6755 WiFi
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-3-393322b27c5f@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1239;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=bX0RSkEhHMY0CQeWiiphb/xjS1x++AeW72AXUrJMhfA=;
 b=DTJTtJ7BKJd8qPXVe3nd0JrxaYiQE2N8bwiN41dxZ5jihuyHGd6fmesGzuo/2w99jisvtHofF
 h8Mx18K34cAAflNUNQSKgyj8B17L/9Yc4dJVyM76qpuovDBjx8PeKjI
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-34330-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3F822394CD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the WCN6755 WiFi using a fallback to WCN6750 since the two
chips seem to be completely pin and software compatible. In fact the
original downstream kernel just pretends the WCN6755 is a WCN6750.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index 0cc1dbf2beef..94f8f8551756 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -16,11 +16,17 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq8074-wifi
-      - qcom,ipq6018-wifi
-      - qcom,wcn6750-wifi
-      - qcom,ipq5018-wifi
+    oneOf:
+      - items:
+          - enum:
+              - qcom,wcn6755-wifi
+          - const: qcom,wcn6750-wifi
+
+      - enum:
+          - qcom,ipq8074-wifi
+          - qcom,ipq6018-wifi
+          - qcom,wcn6750-wifi
+          - qcom,ipq5018-wifi
 
   reg:
     maxItems: 1

-- 
2.53.0


