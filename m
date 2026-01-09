Return-Path: <linux-wireless+bounces-30590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6CDD0729A
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 05:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8CA03034A0F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 04:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF0B20C461;
	Fri,  9 Jan 2026 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLObp1ro"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E9285C8D
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767933909; cv=none; b=rAhgwHQm49dOAnW2CsUxOkubwkjPX60abDAFc9P45wisOhx9MS7/sXmhm4BTf9/R7JpQoJ1nGOJnLUg36Q5AWryFKxC/VigflSn3akXaLgeRCY8Dwnl3F3mEpL3HroKGx+c+XWoW3yU6dpCr37t9AR2gajd64blbZxDl6RhMyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767933909; c=relaxed/simple;
	bh=5QJq1c9Ekc1jzwnvdU3h8OoVmYxREZvgYI+XyP74jOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+ap/jEDB0JJ+vcgFxpsRc7p4A89oyl1WxGC4munOEGt6FJM7bBSWIuxbhtXazshB4qTuz6xrvaRkQpIQM5gVEbjIP7aYk0/TZD+FEAM9jMDsdnXXGoTFCAaMOcCreo8dBXCUgA+HbfuwpX18OiFDRdamVnoEe0ygu79qYldEVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLObp1ro; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6cc366884so2099044a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 20:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767933905; x=1768538705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJPG8HYsRBUMTKq3yYRj3COPO6PhtTiFs6OmvlSy5Iw=;
        b=jLObp1rosyFSFWGcp4LStakVAs894Y66aFHPDUGaFiLLqcG+3Vmn4tGcr0xRBN/0wQ
         hQor9i5Js8vmtzTx7zgpdQcX6D037h33hpChduVS2k6l0Fe/MtuC3f2Fs994zoPvdt1p
         B8DK9c+fW1N1j/lHzm7zx/r9+yCYseZ26WJQ8LrpEL3tNi07XaJrBqfxgUshTDwJ3l+F
         WXPNKE+IUbiCFE7UgbED81cdD4RYIu8XyfKYAbuTFqQu1XE9nrlJo7ljgR19yanwpgnh
         C9lCv/QgwI5iBlmeRT9VcVLxafkpeAb8cpCnZWQ/kgJ13IMWeBKDPTdL3WAmc7OZGgWF
         Rp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767933905; x=1768538705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kJPG8HYsRBUMTKq3yYRj3COPO6PhtTiFs6OmvlSy5Iw=;
        b=OTPoHrDOFrCHcpTIpvIsqoct4JFPtCNmwfbj19BzgVuRu050LRnB+r8Y2kLnC1xns/
         Zp1P36Lr6t4Kl1pEWMqNt4zS17i+fTT+9m23t3Eqr/cagzG8YGvwIYv0mpjI/FshYnVP
         xMlDu378mQK8V0AIVe4QkRqnqIER4UFwwmhn7VxZdCGUry23y5BVIKzBu//yp/b3iff/
         IicqwHXs4wgtjdN5o9wAi3Y8sD4FjpSYFz/RVBNhgwSJ9tb2IQd1Kr2AhOPsr12rDRcL
         IYDO04EHbjldMXW/LeX4GnPoRiWwdimJeu7DS3DzJzcWRnPGBI6WcWNMYNS+LOidKoP6
         VCKg==
X-Gm-Message-State: AOJu0YyEc86COYWSp27lqG6rqz6oARf8GXrwTvuxui50f4lF0ulzD68I
	5yFgtsurEMMTVinaZ69WnbYyiaBArvFwooICavn4rhD8cl+UxvkMIWKj
X-Gm-Gg: AY/fxX4muy/R6A7X5SMRH4zQu6VN3wweAbzEOu+QJVJqFAXCjfA51HTqe7sZkeYAq2B
	vd0+GPNuwFEXltTgRTxsLO4RHRerAD9yzJGgaDe7Cxsq8sxBcxvPghoKtWdv8AnQsiQ8tZP7Sux
	wsZVWddnGlrI3OmNtoMtoBB6eCjGKW3XHuCLQBNLN3/5EOkTPje0OctuzQU4fmwuylVIOWvtI5/
	FZ+0EGkyYPOxUvbFld3ZmMyv0yfAdEeh6ZzLEgt3YKuLXNSlck3AbHYFOPL1hA0K2scyv6jlTSn
	y36x5a6qGDfrfspO05wCeE/jffRXYwBMWLbbGYyaR79KvTfNrgHgSrAFejc6kOVjUvcp3avZMPD
	slvl6go4o2i1DvQjsGvVYqpv8Q3RqKy4gGSyn8mFMcfGmFaSWBXDngshP0UznB0vwjaRcGwN6Q4
	69dhKosDNtp/wi3L5ghaHqlRFmJYIRwyuZv04EKCQJ63XI9871j6Vm0jpXA5HK3ziAVSJ6TKsDB
	g4oaLJd5W+ucnuk7xL8OGNjOV6gaSeH4LreIvs=
X-Google-Smtp-Source: AGHT+IE6wRQtca1hyce9+QhI7Rf2o0Jk0Cj8P2ShkldcfBNSsrVRhd9DNnZB/kaAAlL3WYBTPdAf/A==
X-Received: by 2002:a05:6830:2b26:b0:7ce:5287:494d with SMTP id 46e09a7af769-7ce52876fc2mr5062598a34.17.1767933904785;
        Thu, 08 Jan 2026 20:45:04 -0800 (PST)
Received: from nukework.lan (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47802551sm6683515a34.1.2026.01.08.20.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 20:45:03 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jjohnson@kernel.org,
	ath11k@lists.infradead.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v2 1/2] dt: bindings: net: ath11k: add IPQ9574 compatible
Date: Thu,  8 Jan 2026 22:44:53 -0600
Message-ID: <20260109044457.3074510-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20260109044457.3074510-1-mr.nuke.me@gmail.com>
References: <20260109044457.3074510-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IPQ9574 device support for ath11k. The schema is identical to
ipq6018, so add the compatible string where needed.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
Changes since v1:
 - place compatible strings after instead of before ipq8074
---
 .../devicetree/bindings/net/wireless/qcom,ath11k.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index c089677702cf..5efb2ce0a6be 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq8074-wifi
+      - qcom,ipq9574-wifi
       - qcom,ipq6018-wifi
       - qcom,wcn6750-wifi
       - qcom,ipq5018-wifi
@@ -103,6 +104,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-wifi
+              - qcom,ipq9574-wifi
               - qcom,ipq6018-wifi
     then:
       properties:
@@ -221,6 +223,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq8074-wifi
+              - qcom,ipq9574-wifi
               - qcom,ipq6018-wifi
     then:
       required:
-- 
2.45.1


