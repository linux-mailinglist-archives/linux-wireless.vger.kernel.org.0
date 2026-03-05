Return-Path: <linux-wireless+bounces-32491-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLSoH27PqGlIxgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32491-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 01:33:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA327209758
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 01:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD34430451EC
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 00:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD851FF1AD;
	Thu,  5 Mar 2026 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7mebY2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505961E5018
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670811; cv=none; b=ePFOD0vN/y6n3/ipW2QTLgFAqh0UbmTGMQre+Y6HZZb8kHxyt8xdhahiwb5RMfDnCQ1AqBV322wEn+MjJNTI1EdrcsTuAxCTs3Gw34fwOMwvmdb9VOFIEejrILV29fg+LktQtOB3wEGhOhxuaWB9XPZlCdT8JbUhCy9Y/J2agvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670811; c=relaxed/simple;
	bh=sNoUdxnKeLRM+2caoT7p7YZBgyoQATSkzyG0/fc18xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8tBLsWo3yO1CbYrvx28Dcq2DL3EsdgWwHyW+HfNb6nurQ09xFd4y3TXWqgcb05OjDxe59h2uB4CSJpq+GTbCUgv2gB3XtESsD3jT61lfqN5FqUs2iWvXWB24E9+H/sO6mM1yTu/x67uh+MmM+kZMhCnaUQYuMaT4i0pJW5Qdbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7mebY2x; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d4c3896e32so4216450a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 16:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772670809; x=1773275609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyyY/6iGZZjBC2RyXoGvRk3mOb2L5V65kz2wmEzA5hs=;
        b=A7mebY2xhqZFx1wR192sAQFmo0+zRAlPeJApUDFnyrk7IPe6gQ8amTgXVYhIBdQazi
         DzN8/Th0sjYYj4E3u91UJyN0C1BCE1Ou6M+5UWtsQ2MhSK2Upk0OGT9sNSOz1A9LylM6
         tTKt4nHQN8yhppIrh+smGSp0QtB5clO+y3+6X4LXZq0av9uT6xy8g59CTNpzbfdQfWR+
         f7vPDTKEwPpLZrFJ0sE80AQThuv28hGnwlpkoiiqz95X0/ieajgXVtY3ERRL/q/WBq9p
         Ezs0kXEJDQReyXZMPgc+ro7JAYXFDLa1UHGrQzdDcqYKPp11i7iajSx1S9ce/k99CRMw
         g7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772670809; x=1773275609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PyyY/6iGZZjBC2RyXoGvRk3mOb2L5V65kz2wmEzA5hs=;
        b=pkhnB8sBki9/2Ge/1JxpKQDf4mjDONRUKda/TexaPYxqzrtDfZBH+zciair+ImdBgP
         DzJs1XH/8a8NNYgeJkh8KsfnpDjmeHsfjVou8kjtHuyBVoqWXYkTudK1+NbCb1QeUfZm
         no/Q/ErVhon/qV3t5Bh84nEv3kcUM3ULMim4ScRrBck5nF+zB9c0Sp/8ltjJm9vJ59d3
         AJsi4pfYQzbS76JacOBEc2KWDCUzkeKb5Xi5fhGbj7DsBuJOcQrAt7xiyWSeQrv9ayZd
         46hWEaNC+KaYi4l2Z0RK9T29dDTXXMDizbI6t9uXPeYDpYF0UmKGYe5mDpuBVl+7DJF5
         zkyw==
X-Gm-Message-State: AOJu0YxDKPIpnn4bYk3uPYzCjgiITu0aODPMAEEUnBEMFgBHMvaUlb0X
	x4iD7rxJdosqi6vXqfWBZFZUuWNDTafTt6jKVzIF7u8xqlH9k4WjH6Q4FnNCSIhP1As=
X-Gm-Gg: ATEYQzyFOPDtZV3rnE9KV2jNFxcrySxNcJ7Ya0SGp6UwSzexDtEGnB568g7Pv/diwxa
	u6u1Elcq+em5d5+eprTZkA/5+v9n3SdYdUjSaYpxsfjNMrYfo1P2p7ISPOrEuUixZ8r1a/UOJDM
	Pxmn4HuLVQaVnbio4J2NwxoKUCSNbXjUxRMeXdkE8LUgSnCAV+ol1slNGZPUQKWdefAUyQ77j55
	9U2eIUgO2qgFXVUBuUTIUoC5wJuh7/STY3JLNDf3Ofq8HGNuoMZ3NBui55/8XT/ErF/E4VHBVcr
	t3tPjy0wXUCmlPcoUkOOKzz5tkrBCOOcqLHbAd/68r4ys/LBwJRiJRJDGXSqT1wVX63A25M0rPo
	dtzZJm88cN4NNNkI8WO8NHOzJsWh+I1gMPVhrD2ZoRzvtUdxunCQQvMUM017xDB1SyE657HXU6W
	J+WYDrpy54CstQC8hMfz6Dcw0AQmyy4FnE2huwfQgzOpRsi+sVXR9MKmaUDpiW032KKxix74JUn
	2Up6EtdQleHXwpkSPdXoTE7kVv6rwyWnN/2ZxY9ng==
X-Received: by 2002:a05:6830:2112:b0:7c7:58e9:8e16 with SMTP id 46e09a7af769-7d6d1253d7dmr2441794a34.14.1772670808874;
        Wed, 04 Mar 2026 16:33:28 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:2aa4:4aff:fed7:9b19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644dd17sm16633834a34.5.2026.03.04.16.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:33:28 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: remoteproc: qcom,wcnss-pil: add WCN3610 compatible
Date: Wed,  4 Mar 2026 18:32:51 -0600
Message-ID: <20260305003253.1022386-2-kerigancreighton@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305003253.1022386-1-kerigancreighton@gmail.com>
References: <20260305003253.1022386-1-kerigancreighton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA327209758
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lists.infradead.org,kernel.org,linaro.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-32491-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerigancreighton@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Document the qcom,wcn3610 compatible string for use with
the qcom_wcnss_iris remoteproc driver.

Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
---
Changes in v2:
 - Move the Documentation patch to the beginning of the patch set.
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


