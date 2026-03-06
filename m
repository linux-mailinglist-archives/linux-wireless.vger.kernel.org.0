Return-Path: <linux-wireless+bounces-32637-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFodGeKyqmkhVgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32637-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:56:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B932921F560
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1393055409
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA65D3815CB;
	Fri,  6 Mar 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7PhcnFA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A560C1B4257;
	Fri,  6 Mar 2026 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772794392; cv=none; b=qcWU0pGlpb5uu3GOo0RM77IJ/Y/OOFHdev2YE6+kaIMnWC8YndyDaItlyB/aCZVwKCGOPhNGSEEzNe5zzfExfDs6kq72BYLR2DrlV6s0mQ9HCnOxSou7artvigsVM30xal7HbYcBV6Dr/OTwBEJFMNXD77bcpAkxOt3BRMd1DvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772794392; c=relaxed/simple;
	bh=+WPauxWCOutLzKrZffBXMMITweY/oTZZzgDQTHSVJK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM8peQLYqAPVkfqg8Mjm5DRbc3LC1xyEzrwwkr0l7vH0eXecp3+ZV/Xr3QdsdjOmd2T5dd2frzV7yG7AkQibDEkk/6zyMlHrwkupWVgioxCjgO9TmsEtrFNvvc2rl5Od2D4745Us5ZuGgEcajMTFWQTysbhy1zlJSvL3HNeIzto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7PhcnFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4384C4CEF7;
	Fri,  6 Mar 2026 10:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772794392;
	bh=+WPauxWCOutLzKrZffBXMMITweY/oTZZzgDQTHSVJK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7PhcnFAEzRzyxgHw/cbf5mEr841YyOIWlZLl2ZNlY9PuX2vclREN3lUqy9yprLN4
	 bZqiryg2nneuOQREQrnbzevSJb6ARUvF0/VZ0v6h3XwfDmlXzFHfNQjFj9Zoxu2ZWl
	 wHN2maj3rGdNsvkZSHjF/bmSEPvq2NWi399tbd/OnU1VUNaU9Bq2TIjXJUrIuj9r3I
	 FgT1lXhmePq99pV894LN0GOWaH3ov0wj8ZDX+1l4xKVfdsTfl5izbxuUgS5hMcf6Bl
	 sUJLIR6H4Y8U6znn5OKi1ZLSZ/OspWEc8BzSQf4iB8Xgx7zRwFHNulC2d2FEuYWUwU
	 gZk7tRNkpzqww==
From: Sumit Garg <sumit.garg@kernel.org>
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Cc: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robin.clark@oss.qualcomm.com,
	sean@poorly.run,
	akhilpo@oss.qualcomm.com,
	lumag@kernel.org,
	abhinav.kumar@linux.dev,
	jesszhan0024@gmail.com,
	marijn.suijten@somainline.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	vikash.garodia@oss.qualcomm.com,
	dikshita.agarwal@oss.qualcomm.com,
	bod@kernel.org,
	mchehab@kernel.org,
	elder@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jjohnson@kernel.org,
	mathieu.poirier@linaro.org,
	trilokkumar.soni@oss.qualcomm.com,
	mukesh.ojha@oss.qualcomm.com,
	pavan.kondeti@oss.qualcomm.com,
	jorge.ramirez@oss.qualcomm.com,
	tonyh@qti.qualcomm.com,
	vignesh.viswanathan@oss.qualcomm.com,
	srinivas.kandagatla@oss.qualcomm.com,
	amirreza.zarrabi@oss.qualcomm.com,
	jens.wiklander@linaro.org,
	op-tee@lists.trustedfirmware.org,
	apurupa@qti.qualcomm.com,
	skare@qti.qualcomm.com,
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH 09/14] remoteproc: qcom: Select QCOM_PAS_TEE service backend
Date: Fri,  6 Mar 2026 16:20:22 +0530
Message-ID: <20260306105027.290375-10-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306105027.290375-1-sumit.garg@kernel.org>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B932921F560
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32637-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Select PAS TEE service backend driver for the generic PAS service to
enable support for OP-TEE based PAS service.

Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 drivers/remoteproc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index ee54436fea5a..0411a38530d8 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -230,6 +230,7 @@ config QCOM_Q6V5_PAS
 	select QCOM_Q6V5_COMMON
 	select QCOM_RPROC_COMMON
 	select QCOM_SCM
+	select QCOM_PAS_TEE
 	help
 	  Say y here to support the TrustZone based Peripheral Image Loader for
 	  the Qualcomm remote processors. This is commonly used to control
-- 
2.51.0


