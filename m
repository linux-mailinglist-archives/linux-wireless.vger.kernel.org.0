Return-Path: <linux-wireless+bounces-32578-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE6yLJsjqmkPMAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32578-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:45:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14652219F11
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 01:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F638309E28B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 00:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1E2E8E16;
	Fri,  6 Mar 2026 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQGAv6Hb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5C2E1F02
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757843; cv=none; b=Obw4AvNk9nnN3jra/lvHpaVTxMK5ZOQAjSDHL+A63hiMAHOJwj2OQW+4Va5J18uSuyvpXdYawUR5TH+6t/oOZ6iY6GH3GN7SRJJRwa/W3ge4pUqdcyvUzimob+L92jOWiMzgO7xhj2XLztYItvMvM8u4HhXMVsgdjh0rEDsbh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757843; c=relaxed/simple;
	bh=7+7vEfBpNq1FeJYJEFDLB71C+eZ7mjue1YQ1Lz4VM4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bR6EQoSS81+KzmTh4t6HVyO+xr2S/ycrXgVm3+dezgLJbngn5ORafLkhl2Bl2Apmb9Fe4Wcby2McRHYfJEhL0rZOV4cpXAvL9HErb4bbJzFsHuJxdO1WccW4UdR7xu841rHrPSi7J/7ywj2xfBSkH2RYkB5MpNqMpZTg/mUfY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQGAv6Hb; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so2450590fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757837; x=1773362637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWzAa+zn92+13s1CRMtvzeiMVSLB+iLeHsYqLdK601c=;
        b=JQGAv6HbUQNC1gjJ68whaYfxEDPpib0XsPN+2anKdPc28e2ptzxcM3hqxmzT46NpY2
         PPtuI3H2L6L59816oobgEWbYekvQP2LfTM4/sRW1h43bIrp07lcDsuNfHX44FU+ehV+i
         +LCuYAodD48FRk+5efGiYRV25gV5RJev5yGxBjEQzbFTQcVjGgDWBCKI9X72iLKSEKlN
         n1/YRSCeps3tX/DcIBPfWGtCi38EX2GETIYpKuMTYWiEy8bDaISVoDKKMjvXOERox/U+
         sU+gUy3x/O/tdjFtGYk7BcXTjEmjCxTpHSPjZRSpipJP5lzvymZQbYSrQHs54BgHDuuP
         S1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757837; x=1773362637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWzAa+zn92+13s1CRMtvzeiMVSLB+iLeHsYqLdK601c=;
        b=QAJ8t/Te6jAGGl0A7TMJsksaG2QjPE346CxudkCRUi/3zqFNJ8QCPILYf6E6yS6XoO
         xBpJ6gMcysNPErHupmWkBMYhEPjP0qcFXaQH9FgEHtZfct0ctLTKzQj2DsoOpLhZ8p4a
         aDELxPBo4+AuzIY4gDYmazNRm3SXUp1XkVv9tCuef757DAPbj8JNzdgOCb2TZ9gQ2cJk
         xB+4/w6UPIFmVyggOjuq6eNYfB0Ylcx/fd8aAaa48a/BS07zYAqscn34Xx5ZKjK6r4iv
         cnXGFrh0ukURBq6om5zs+8NAZIKrCpGTL/L91tlbrCTgiZU3qw+iJd8QSQHeRlMA6XRu
         Ud1Q==
X-Gm-Message-State: AOJu0YzY7M/1ajWnz+CxqTPSyQpIplTLwvqEZWJHNgrKUArb9Hcbxe2W
	hHd60goQYUshWqEosG+7hFS+34B9tLt4OVkacGuv7DKP0YR8guPbhkiVCyHJwXRo4jE=
X-Gm-Gg: ATEYQzyr7vcbEIj4EgROw2MsX1zCnpWzrJaiayZ4n6CBg9U/6cEYuuT9WdBzBDdYmO/
	cbjrL3jFXsKxV9SrhTtxPQgYzn0i03nVAod/v5DSDjLPPJfbnaBepl5Rm82PG7OCKJSBOlXtWxj
	UCxoCTDMS82nUUNRdISsliVZbHdLWIs5IW3MOmqxVPyzrLLe1Nclh/jTZZYDYSyJaGpJDqXzN0C
	s+MN1+ANrYolILZqRTUiqVYR+VmtduIfsPBte1nsqMwOquVD1BiGqK175drdCLuIb9iHdUArYYB
	RA6QnGSzaTLqfPplpynkDkXy2ftT82WTh2VRVBQRzE38F7OJC3GQPVga8SVLTa+JK6V692gViMY
	sYdLV8ONvjrQnem1omLIdDUKXx9VK428A50i3Q8fI54PdKDRS2CTUXF2UVHOHTQoiG2V+Z27ziX
	sD3f90j0C1NwPStvXztcH3HFKHRL/7NsgigX/3XXSOncNAiFkKRVYVnW/eytrvSEyd6GDiK4IgA
	k/M/hqnWz97Ndu0VfE35eSo+lJD54+LGXJrCkFG4DrO1SY0j987
X-Received: by 2002:a05:6870:8252:b0:3e7:e420:6229 with SMTP id 586e51a60fabf-416e3e6fa13mr252903fac.6.1772757836776;
        Thu, 05 Mar 2026 16:43:56 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:2aa4:4aff:fed7:9b19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm69335fac.5.2026.03.05.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:43:56 -0800 (PST)
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
Subject: [PATCH v3 1/3] dt-bindings: remoteproc: qcom,wcnss-pil: Add wcn3610 compatible
Date: Thu,  5 Mar 2026 18:43:42 -0600
Message-ID: <20260306004344.10968-2-kerigancreighton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306004344.10968-1-kerigancreighton@gmail.com>
References: <20260306004344.10968-1-kerigancreighton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 14652219F11
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
	TAGGED_FROM(0.00)[bounces-32578-lists,linux-wireless=lfdr.de];
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

The Qualcomm WCN3610 is a 2.4GHz-only WLAN/BT combo chip.
It's similar to the WCN3620, though more basic. Add a
wcn3610 compatible for use in device trees.

It needs its own compatible because of chip-specific
configuration done in wcn36xx.

Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
---
Changes in v2:
 - Move the Documentation patch to the beginning of the patch set.

Changes in v3:
 - Describe the hardware rather than the driver in the
   dt-bindings patch [Krzysztof].
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


