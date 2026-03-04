Return-Path: <linux-wireless+bounces-32477-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLFQMiiHqGkDvgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32477-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:25:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792302070BF
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB5C309246D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070B53DBD5C;
	Wed,  4 Mar 2026 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCYms1KM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CD3DEAD0
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652267; cv=none; b=FXPpwkYkl/e0twclmT3UmxF5oqy+wD77KIYmS7HGqcT2ixs7QpGRZgAtcbUrFQNmaaySrAkFI9cq+ffelyfBsugUopPDCskQB9ZG0brirKwCWc/4hmy5PNGBqdfXqfqzzieaO8KeBCpCwrLJXocZjnzOKAbo79Nf8fkClLY2Ng0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652267; c=relaxed/simple;
	bh=6ei+Huwh4PKhOxKolosUs5btGNjYQcybQcHfUM+2gg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKtGVjzLza8/pr/4PGE9MZ70gQCXGBIPsjBL5a7JxchrCCMpjSi/iaRm/Ojgm5e2z5nzUuk0+SJ1OGWtvjwwQaPPs2pTWKSlc0O7xyjffNsLRrIL1flH/t3dtNoYq1pPXBkEIST9JWxfP1iybBAeGeI1BloAyVPAZ4nmaMhUSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCYms1KM; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6798f3b7163so5601191eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 11:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652265; x=1773257065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fphkXrW0oEd5iFF9aoqhAXkr62Eqyv7ZOBulCkksYyw=;
        b=aCYms1KMm6GLVKucopsbzahvzXyQLOFUYtjFkjkmIkDtURSIhd09IgKwul3pyz2XQd
         poZSXR7G8Y3CavAaICLtFPr3KLmttlCMwJt2MDg9pqVagTQ25IyidxM0JoHDoNWc2T6d
         gPZX7HmtVWlCUdyTbiJWv63pnaQ6+Ol4bZ7eBewWHnBJTRXD47KS9n0ShHjAsYoYkgfX
         y6lqV8jJoDWpaAuh+m5Ilj6BvrRK0s7IUKTQ/t1MNcr/vVBFNKh9MF2lEAwwPsDcCKvA
         uypiIC6+0ST9LvYDhNDAjNBeFvS/vBwRdddI5nAVUz7Ok+P4qRTIM4btWxBP7WbuZofa
         dWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652265; x=1773257065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fphkXrW0oEd5iFF9aoqhAXkr62Eqyv7ZOBulCkksYyw=;
        b=vRAVU/X2QHCLqa2NYIiztqypjI1RFApDdBT5+JmVZ+B4ITYARSggWN0e/Gwu6+GSSn
         F9xandKsOoX0vvltd5TcAL61IjrxgyvNdOV4607z7F1wQTeLONN3J10UKmOky242W/TL
         oMWckroaFrlR4ibmKcT5ngobOzMDUtsyPcIosRVuZq/Wrjsw335GRF2upqVkuKmtdGRj
         NlBRMgqbE8bNnnu87mG8QoTx8indkzPH9SFaAJIgI3XGLUS/nW3tA42UWWu4kEflKHUM
         7wpxVwOBAUT4OLZhVXsSO9o+j8+rQVCDJSIzr/oWNVL9XjEITF9hlKvUQmvjEqkU+UVX
         oeLw==
X-Gm-Message-State: AOJu0YzIB0uSzNJa1sjk/lq7vhyqxj8SUsUdctys4SJOx98MrTSDLgyj
	Ui4xuyt0P9wbgQ6FW+wZTxo63tyKgQb0nAWQ5XJ66ppcfFXbwUoRHuxf7+9vAjUw4VI=
X-Gm-Gg: ATEYQzwYTTGL41k/20eJtgOzAY9kZ8wLLZgRyLsvkg02IFlHswh2DnScQflGaWax+RP
	wOuF3YmFV49+KR/V6z87slZV5S4HcHOdicrefcY2ttfl45eusze7g8Cw+eLwZsN+psnaYml2/tX
	yFmwzKbMWFc2sjApzTSVI77U4GG8Uz947A0TtDrJNt6kRZboGaXPspd/v72kraiSgV5PPU0OwUy
	OzhAO1NNkkwGGymA703PLcJcV3ZSnGBa9Ggk+N0mwP9tcoehvqcaF1WFrJfGkZfPCOANjFWumo3
	aCerjxcPCUKZnlU+jDZ1ZkNWPriEPARiLFHOeHBOwbI6O+aeLKVQAhlHWPG4g5Gf66A8Mxlzg0H
	2+eL1oB4r+gohH64mtbACD+dUGJ7oBGBxZUymtXaT7FJJAKw2OxX3QSRzafEa4uCKf3aqmYWduX
	lL4Cybqg4cwLU3usYNIO+E2KuSkIbw9xurOgKVzFXcLAvMH70cR0hKdR5kRmeQcb8JfwKyZPGNA
	jsZMIVIy4lBEtTO3YhMnn8bk4XzGe1FFonztZrIBQ==
X-Received: by 2002:a05:6820:208d:b0:676:d076:e4ce with SMTP id 006d021491bc7-67b1e903320mr1702204eaf.68.1772652265335;
        Wed, 04 Mar 2026 11:24:25 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:5b2b:e942:c11b:ed62])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d85297sm13294165eaf.11.2026.03.04.11.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:24:24 -0800 (PST)
From: Kerigan Creighton <kerigancreighton@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: loic.poulain@oss.qualcomm.com,
	wcn36xx@lists.infradead.org,
	andersson@kernel.org,
	mathieu.poirier@linaro.org,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kerigan Creighton <kerigancreighton@gmail.com>
Subject: [PATCH 3/3] dt-bindings: remoteproc: qcom,wcnss-pil: add WCN3610 compatible
Date: Wed,  4 Mar 2026 13:24:09 -0600
Message-ID: <20260304192409.927562-3-kerigancreighton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304192409.927562-1-kerigancreighton@gmail.com>
References: <20260304192409.927562-1-kerigancreighton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 792302070BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lists.infradead.org,kernel.org,linaro.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-32477-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerigancreighton@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Document the qcom,wcn3610 compatible string for use with
the qcom_wcnss_iris remoteproc driver.

Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 117fb4d0c4..018cdf5177 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -109,6 +109,7 @@ properties:
     properties:
       compatible:
         enum:
+          - qcom,wcn3610
           - qcom,wcn3620
           - qcom,wcn3660
           - qcom,wcn3660b
-- 
2.53.0


