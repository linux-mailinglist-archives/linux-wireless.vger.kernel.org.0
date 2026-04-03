Return-Path: <linux-wireless+bounces-34328-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE4aCWbHz2lH0QYAu9opvQ
	(envelope-from <linux-wireless+bounces-34328-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:57:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5625394C87
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Apr 2026 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA8223047BE9
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Apr 2026 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964738E133;
	Fri,  3 Apr 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="pitMKBff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F839364E85
	for <linux-wireless@vger.kernel.org>; Fri,  3 Apr 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224522; cv=none; b=Huct4Veq5wYYIKACWrIrseeeRyM7LdgUG1f2RYiUVQnRy1E5y+Eg5KCz1DOlCjUHgFAJSYMJidalHnqPx6oOodpXby+rNQ6rgyL6+S2vpDBDbRvfu049t6W5forqB+iXMrhzoUuf78Uh0+xR6qBqOGAER2LwcZbv2lo1tnnYdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224522; c=relaxed/simple;
	bh=v0N8xo6MFWIwVEW8StRaWQk6fHZBEqBZmxy286b/97Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ps9O1a1nxB7v4WgqVpBtkj7GnRC77zhrf0NY5RGjoqOhjRdjo+YwXc13ivTXExNd4r0SKqbOuBoGo4FZnUggj8MvI8fSC9l3ePd0CXDBVdp0WdWJA5CTwgUSMM5JpyRl3fneYbTzK0LO8/5GChOWuoAWx4yMor36IDH8vI8R9wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=pitMKBff; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66e56756044so701998a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Apr 2026 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775224514; x=1775829314; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m83BxTeATfqd1UWKENZnthRfrI/lStR1Bw2POp0MJqM=;
        b=pitMKBffVYy8pS3eVc2jLbEX/YabbXEkPdmH3+7Bh0wvmHVH5Lx5UqB0JyiLfRV5Xx
         gyb4BVZJlPZ42jWX1Cg7AlUIMGub913rXtCxWz6CwzAJ0NYuDKH3zxo76LIz1aBxqD/8
         r+FJswYi/uKfh7LO+qGKIS/mCccQ0OQWapV678f/NPyiBwjhfpSilCaBOf15iVDIK7tH
         d8UTXctvWm21Z9uVUDxUFIm3NsQuXfrd2OCOge4EiC6JsHDOPizkPJ9I74LvvWZPilQ4
         G6N6PfN5NL+E/YSry+SEI3N/NiRkholMSOzxdYHv7MkciFpqH7VZC6+DJWGtoSr1YdyP
         JIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775224514; x=1775829314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m83BxTeATfqd1UWKENZnthRfrI/lStR1Bw2POp0MJqM=;
        b=LOlMkpXRahk4rSd+Ff3WT4wsQMDiYyy1Rdi5TGSJzkcp9mb/iB5WT1+iHXbKhjbWvA
         d61IucIcXUDY2o+wwu7zgPy39Qo+HrO1x+SA34p8kBxcw0c2NoHiUJ2r7kT3Fwp8D8TS
         d+dz/+EcOVELqxxHtzyMZycIXCGtGyAdJ3ihdZAl/wv65ATHUYJ+aMgXgqu3DPur22rj
         Y+oztVCXJosoIv4k2sXE4bOWrKoZqv7qzhUN1JuEgUSv6VudljbwDL+7rzP3o67Ev183
         9XLVsZ8DldMMjulvzAeJSMqxVSg7ZNiLhaE6UuTG5XJslwXyCKPp8VdOmpmnbgfqaCJJ
         plBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDyFSvzlUBtw3+5nZYMiey+6qY5pMTl3AIfPP10LIjZ1F5KuWh3D+S7mfRZ5muR5bb3CE3n16o3s2oPNKxtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6/9f00b/IAG1TmHYFqgbX0kPN2ng8SinF1bYs+XuQiRfODOWY
	hNb4+CVBL7eVXAqUKED/Cmf7jHL2S9MCDTf6ZUNgJCUnio4eMuQgzPeFXOTksH5xg18=
X-Gm-Gg: AeBDievgnd73qJwsrvBMOlg3Sbme7l61qbSmQ4NzUEfoC7hcyHgZ/dLhJ5jnxPEqIyc
	IeoUFLiRCY+tUSk5jBsoWUq8wtNalSaRrPRPSudvISLQIR9UdiIFd6EnsUejjg174dJs+OtCiqF
	+5uLaYtq8vqrW2gA1517iAe+RgPdsnwC/Hdd5ux1iT6G9woJwhqPKiZKZIDtDrDzyg40VaVO+Od
	VGz9flphPliH3t7gWMtQnz6nZWzqJYCk8d2GxdKdlyObS5icLfHU3r8/YMHL4nVvYE4rFtNvR+E
	qppDleg8LoyopME88yTpkU83wnknMTzZkQO8UtekIXpGSX2/8E99whrS/6ZSQMvJt4tuBaE1U9x
	+zhd+d4XA6ixLGTj4+mAppnzb+c3zmYIKJVotqsSAbAVbZ5J2co0yrtUi+ZWKGQ8qI9WT8UhiSz
	6YtmiS/x950MYtpnkRASRuAUL0DGjOVptIPHuRS2CnnR/GgP1WsYFb60Eo/b3THANGCwpzQafyo
	helRk2Sp7ni0fS7gqtkQ6Advmobn5XkuED4QA==
X-Received: by 2002:a17:907:d08f:b0:b9c:10c4:e708 with SMTP id a640c23a62f3a-b9c67a34a9dmr143022066b.42.1775224514386;
        Fri, 03 Apr 2026 06:55:14 -0700 (PDT)
Received: from otso.local (2001-1c00-3b89-c600-71a4-084f-6409-1447.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b89:c600:71a4:84f:6409:1447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972e28sm198057266b.1.2026.04.03.06.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:55:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 03 Apr 2026 15:52:47 +0200
Subject: [PATCH v2 1/7] regulator: dt-bindings: qcom,qca6390-pmu: Document
 WCN6755 PMU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-milos-fp6-bt-wifi-v2-1-393322b27c5f@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775224512; l=1270;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=v0N8xo6MFWIwVEW8StRaWQk6fHZBEqBZmxy286b/97Y=;
 b=lmSluzrxl2IvHohqbLRwM8ZeK0TA0Y4HsWh+y4B3jOfVOirTRYkehiK7ceZ42CboR9e5Ts5BN
 rMEWV8MPDVyDP+/ux64qnG2NCnxwOhrrXEqE51f24EPFDrswFgQmVZA
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-34328-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[fairphone.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A5625394C87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document the WCN6755 PMU using a fallback to WCN6750 since the two chips
seem to be completely pin and software compatible. In fact the original
downstream kernel just pretends the WCN6755 is a WCN6750.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/regulator/qcom,qca6390-pmu.yaml  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 47c425c9fff1..105174df7df2 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -16,11 +16,17 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,qca6390-pmu
-      - qcom,wcn6750-pmu
-      - qcom,wcn6855-pmu
-      - qcom,wcn7850-pmu
+    oneOf:
+      - items:
+          - enum:
+              - qcom,wcn6755-pmu
+          - const: qcom,wcn6750-pmu
+
+      - enum:
+          - qcom,qca6390-pmu
+          - qcom,wcn6750-pmu
+          - qcom,wcn6855-pmu
+          - qcom,wcn7850-pmu
 
   vdd-supply:
     description: VDD supply regulator handle

-- 
2.53.0


