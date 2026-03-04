Return-Path: <linux-wireless+bounces-32476-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePScMvGGqGn2vQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32476-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:24:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952120705A
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C21B301440E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 19:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A663DBD6D;
	Wed,  4 Mar 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEp3LPr/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45853D75CF
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652266; cv=none; b=T8yzOWFEdK8QXYInwAS2IOiO93L9feKyqXZ0peRcnIw72/8QibFrjHT/QObbojlq9hJzRUqN5ozPXK7P6Oe+Anw6J3bul4yEIsJuNH/iS0DGBCSkSqrLzL780W3EeBYPeXGv1OC7hrcOytHuiT2hdYAP+nKPVkhJL9qDqzNYmI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652266; c=relaxed/simple;
	bh=eTpf8Vsj1twgoqcMO4yuaGpGo1vNlv+UQm9PaoC/e+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI4IbPjJ014or+vsUh/iDWcVP4pNbIgb8ad9EOH0a3FkFXL+gPlsx7hnwXI5s14fKZmEF7uOgjfUpa9+EAxZFTK+RhzuEk+Y7axIxvVVn17ao4uocdSVlkxPzWGIm7bt6SJ9mQA7yUkI7xPQDatgMoO4JhHpIV6YmIV78b4+pZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEp3LPr/; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-66f3e7d9eccso4723541eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772652263; x=1773257063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKd1ZgsaUe4wWSBNNBKtsv2kKFvW/83dcciLxcaj/4Q=;
        b=SEp3LPr/aPxtpwZtmz1By2CPLWQ00u6N41cEprzFIOh7G4weTMissZdv5INkTKU5h+
         FkIe1s4fXPLY/hqVvAC6WEt2AvHhtm2owKv/20sBZWuG1iaWpiGwSDFXjA/TSwI4asdo
         ZpJUTHopoKHPMsE/78gbZ2kztoldTm54/S5xJ0UdTXidf0f/OEcSlqdclL0oOOdfhRfc
         nl2y60m3OJBGvbQ4SHiWoUh34NqaUPpJ/j40J7RNcLJyKe7TNoppK5ThLhndpDARK7Jy
         oUNawud9+rZUySEbNo7ABV00izn2VrsrccTuaP+tVMI3d35cv05yfsXdfC1BYElbUsQ5
         Lieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652263; x=1773257063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YKd1ZgsaUe4wWSBNNBKtsv2kKFvW/83dcciLxcaj/4Q=;
        b=e+9XfEOlqQQ3LvbaSBR+iaXiR7LdO9nra7/aR1WkvqHyYXUKONQj13YvTLXVIaKVUk
         +QrwZNKtFgWl6qsQ6umuEnlFmu59Rjhpsyf+CZmH9WfTg3EL0/QND4+yrZSs8zc5Cn7I
         JKyldN7Hu626p8fmh1ZinMtyzkphRJm43PUdX1HqJJBLYOz5yYb+QgkWR6wvvYrYhGEx
         cRssMV2VxRTS/Z3K09rOJQE3NoTuSbvCgnBaaXiXTKp2VOMC2M14mBBlCYvTU1B5XCuf
         WL63Q9r/ZAscsv1wT89tgviKKQPBctUPVQRtw29K3PevJqJGp0yqi0e/4sUD/V6Azstd
         /Wyg==
X-Gm-Message-State: AOJu0YyZDK22xCIz2oWMH5JQZsUU/BI1eWoW/+ndwsHt4ZBvPeU0jfL0
	Dx47/mWySZlm9eU8NjTQ6CO1YHGoB04nN6Q1FVTusMmmWXTjhBQhlSSUeipCPuXF9xs=
X-Gm-Gg: ATEYQzwV1qs1t6m2Ujh25zoV7Bi6dVyY9uuSuXZDgyRaVHifHCGkKw6EmGZYujzT1xb
	Vv4IOlsnUdzUCk4uNR/lvUuURs60x/t63eC2ZXA76WaViDXK+OOOdu1RNFLJyZEe4+zux9N1ZT2
	T6KYiiTY+XyWhBt2Ra8lDvXZjBSyMwGBeyz+ahWsz5upY2wDHvR4fn7lgXBuOMV1T5leHZVDVuX
	nko41p/07XKZDbnUPpIQea1emT5cTPEq1EVRUSuo1z6ZhWFZdE573hItf6LJTQj4kHENRTKJK2M
	FzyXjvc1397pIt/RhzbTNHfYxScEsAHrMsS9+Doi7gah9l4sOcn2w8Cauw7N19bCPCvrvEZLpZS
	aXfMtefCdxwrU/anCIlcTjycMmIO+hLLxJFimcjZHpii+HyF23hchDyImgCXJTXRV2i1/2tcPJY
	NL4Y1eeHHlqK5l2sxJSUdRezvpBrg4ELjysongXhIfRUseGzg/MnW9sdPSvCqkgeHVS7GNTvxty
	cqxQjbjfpezTsT0Ez3slhrcclKqHm3PbiHdCJbKhg==
X-Received: by 2002:a05:6820:f06:b0:679:e750:6c10 with SMTP id 006d021491bc7-67b176f173emr1909516eaf.24.1772652263389;
        Wed, 04 Mar 2026 11:24:23 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:5b2b:e942:c11b:ed62])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d85297sm13294165eaf.11.2026.03.04.11.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 11:24:23 -0800 (PST)
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
Subject: [PATCH 2/3] remoteproc: qcom_wcnss_iris: add support for WCN3610
Date: Wed,  4 Mar 2026 13:24:08 -0600
Message-ID: <20260304192409.927562-2-kerigancreighton@gmail.com>
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
X-Rspamd-Queue-Id: 6952120705A
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
	TAGGED_FROM(0.00)[bounces-32476-lists,linux-wireless=lfdr.de];
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

Add a qcom,wcn3610 compatible string.
The WCN3610 shares the same register configuration as the
WCN3620, so its configuration is being reused.

Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
---
 drivers/remoteproc/qcom_wcnss_iris.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
index 2b89b4db6c..e58b59355f 100644
--- a/drivers/remoteproc/qcom_wcnss_iris.c
+++ b/drivers/remoteproc/qcom_wcnss_iris.c
@@ -95,6 +95,7 @@ void qcom_iris_disable(struct qcom_iris *iris)
 }
 
 static const struct of_device_id iris_of_match[] = {
+	{ .compatible = "qcom,wcn3610", .data = &wcn3620_data },
 	{ .compatible = "qcom,wcn3620", .data = &wcn3620_data },
 	{ .compatible = "qcom,wcn3660", .data = &wcn3660_data },
 	{ .compatible = "qcom,wcn3660b", .data = &wcn3680_data },
-- 
2.53.0


