Return-Path: <linux-wireless+bounces-32492-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF/aCLDPqGlIxgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32492-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 01:34:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 760FE2097BE
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 01:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A1630D63AE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 00:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721D31EDA2C;
	Thu,  5 Mar 2026 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Mx2Vob"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE562046BA
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670813; cv=none; b=M300x0BcNBXUrCpjY6qyBdCrc+q0v1Hta+BiFfdSvfppqS5kop+qS8g4Djh6pFB4ZNE3l4eV2UNkL7OLxMP5UVbyRpPYr1/pZq5W7d76pSBq6n7dZgRQgHlMrOL12aSlNKp5cz+dJO1r1NWhtEfQETITEs/43JWz0W/P8V8lYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670813; c=relaxed/simple;
	bh=hb/cStWwgMoJtjIPOyJ8b2rzoiwM6AlB0L8NcvGTri0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxsp0zFSt7bHqV3Z9WdN95861pgY5v38qpjZablrVpOK1+Vz8yjlioKspij6ELQG2kLLADJXLhE6VRTn2nF8ehio2SmhfnDQ3pF/8SPqyh79psiwKv0Xn/lxXEw/32fAtCbcpuWjtkUlREoFP4m33bbjwmapurqjQccOGiTQ8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Mx2Vob; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so7564388a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 16:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772670811; x=1773275611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO6/PAcNzwOa7Dt8duIwo+5/9N6iahdFoKK7CawFXAQ=;
        b=T0Mx2Vob6byT31Az9zVHK1jy1n5BB9B5JYzve0iJCeAizL28vPWVHvXXrxN/izQtiz
         VxTwzkAHm+zVUHYL87jnylmnJHLH10agkiJ2A99Lkul7SAQ9TA4OqECnnjGLp+adF5Ch
         TavIbaskvs3sEIc8ECj62BU0wtOf7kLs8aZohTS4D3G8nAzIWe/Hv5SboxgfIXgpSOkD
         AeyQgg1JoPl1HENKi0YsvXcEdrHtO4PSXXK6Ryo4Gvbv3+pfauB88Fi00gx0c8M7hD7I
         qup2FoZLs5ZIibod8fkFpp4Nf3ny74+ctQ90PAe0zIvuHAFQemQ0CdGjKE2mM8qoCwfj
         dn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772670811; x=1773275611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dO6/PAcNzwOa7Dt8duIwo+5/9N6iahdFoKK7CawFXAQ=;
        b=kPDo13i85A8uK5VjikHCcM5DsKLY8PJFthHItBS8ZktG5YX5r8HcK4v4gHG5Xwp5UJ
         54yFsdeHzoZ4qcfHbu/SwDmvU8nncfUFsjQi7cDD21Il0ItiqFMqf3ZriY3jtGrRqhj1
         kJJs5PpnBcOWUhgYhw6bsTO38pmNeh6ZWgXcN8OheK+S8HOnWSm0iTd8b5EDK4FiJLbB
         1BL0TiuGI/mS0A6Tg6ado7GqEK4nDolOeQKJjbuajH3sbXT2x8whs6/7Apup82o71zP3
         cwxGO1dAqyQcHdwAZsacq2iM3uv+zvMCPkPlaNvs8/Ql0mHVoycYgC22xG+qAu23UYdq
         dSfw==
X-Gm-Message-State: AOJu0YyODvprr5vL1X55fk3a98u7KLMAHJ4oy0MsfmikKJdW1L74PvTu
	GHlhZnfhCjzS0psPVp3mHyexBi6lRw45MNHXnZmtH2hTyR75IdCgLRZlS2UYj7bclR8=
X-Gm-Gg: ATEYQzwx1TRsB6ZDeVDzTTvppL4twVtosuxYaJy9MZA6J48Axrxeu8/iyJdvOwvlsoj
	3xqbUIRDJKj675Se2XKHUC7ZUKGWnPMAPNnLIaXQUhit2K4tjLo6tvY/Jh8adUwcEdR5wD5brvC
	IgU5rf+/YdEw4Dd0P/y5XqmgChMyVkC3DUM3M6+b0KWQeDVGu6LvW2yU7Gx21BhRiDOcqh15Se/
	tWSp8hqMvgsie9j3iHnfVWnli5myVPekpFVoF9sxLL6Zhj5T2GhZDrVAUo+4C4WvUM7xvcWIaJy
	6XDpnPUyWYdDJeY0t8ZjPpeAQ8RXv5BLkmuxqggbHMCrVEL9Pd7ckeokoVgWgYNTYnSvcd5iqNg
	u8rFY1fL236eqGJSL5d5L0zsHa519l1GinOE+JOeF2g1XjGiGUXP4JIPd6XR9xIutrYxTmubZIi
	tpfFdtk3lb3OAeURlZB8V/d/nMXsAqsI74RIoPCBNFw4994Nd5VSRGbPhBNX+xt6Vu20L4LpUOL
	kRlg4o6OkHEd7U4ATK6obtBbYpp2d+Is0nGl/bH4w==
X-Received: by 2002:a05:6830:6185:b0:7c7:18e:913a with SMTP id 46e09a7af769-7d6d139f75dmr2154983a34.19.1772670810741;
        Wed, 04 Mar 2026 16:33:30 -0800 (PST)
Received: from framework.misc.iastate.edu ([2610:130:110:25d:2aa4:4aff:fed7:9b19])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644dd17sm16633834a34.5.2026.03.04.16.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:33:29 -0800 (PST)
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
	Kerigan Creighton <kerigancreighton@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 2/3] remoteproc: qcom_wcnss_iris: add support for WCN3610
Date: Wed,  4 Mar 2026 18:32:52 -0600
Message-ID: <20260305003253.1022386-3-kerigancreighton@gmail.com>
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
X-Rspamd-Queue-Id: 760FE2097BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,lists.infradead.org,kernel.org,linaro.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-32492-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerigancreighton@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a qcom,wcn3610 compatible string.
The WCN3610 shares the same register configuration as the
WCN3620, so its configuration is being reused.

Signed-off-by: Kerigan Creighton <kerigancreighton@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
 - Move remoteproc compatible string addition to the middle of 
   the patch set.
 - Add Reviewed-by Dmitry (thanks!)
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


