Return-Path: <linux-wireless+bounces-33201-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDIKNh/fs2ktcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33201-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 10:55:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FF280F31
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 581DB3187245
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2026 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9D3264D6;
	Fri, 13 Mar 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR7y1eBR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646EB35DA75;
	Fri, 13 Mar 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395338; cv=none; b=nKI0lLSkH+ufsb7tKRshT8o8S2vnnJNscytHmUmo6pEYS7+fVyDWUuysUmy4l3BqQYAQbyA1bSTG1SpQwHjE3+JGr4J820bjM3bCqovvMMAd75xcBuQ4KNAF454R8RuqX0OOoPjhVU1s+rXpIUgQNpl/dr/ZY3OI0uuC3LoZQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395338; c=relaxed/simple;
	bh=N36s9TyRo50kU5WTBNeXzMxWJFN3vHg2opY5lTeBvaw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKOyGs2UKSFOT1rwtPwjy0dcNvKxdDSbf5VfqAHUcfZRCZr2+ogfkjljinqQgyVCgQfFf2munBeZ3JDGFY3sEZ7wBp0YkC+GyY+jBKVF17QMH2YnaWgyAaCC3lSFdha6bOS+tqOicY603AuLTiazf3/2lR8Sy23NGGe29cHTkAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR7y1eBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5B2C19421;
	Fri, 13 Mar 2026 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773395338;
	bh=N36s9TyRo50kU5WTBNeXzMxWJFN3vHg2opY5lTeBvaw=;
	h=From:To:Cc:Subject:Date:From;
	b=YR7y1eBRsx4vs2saHXaASI+RfcDzQyWZD9EgofeJNlX0+qqhuakoUXhTDIqkc0G+n
	 bGqhlR4UWnUYxYrtnIMp3wQLZsXduU5WWc5h88cn7T7tiquW8+eZiotuQTSU47ns+4
	 U8wqoJnZ7dDOm2gSlzD8+QRJV5T3hMoOsFxUmXg7KuL97nQGMsDCUJq4oPSnkxqFWZ
	 /GAfvRrWinbqRSLWIgLr23nJhBSucwFOdeMepaAgieZdC0DwpQ+RWiign9ikEDcqRT
	 par1Qiajl8pLyFki0hbKzlM7pN70FJPii59Tyn5OiXaqRo+iOWnL7G5osYhTy051oo
	 RJpYfyuLlwDVQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	P Praneesh <quic_ppranees@quicinc.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Balamurugan S <quic_bselvara@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: ath12k: fix QCOM_RPROC_COMMON dependency
Date: Fri, 13 Mar 2026 10:48:43 +0100
Message-Id: <20260313094852.3716715-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33201-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,linaro];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:email]
X-Rspamd-Queue-Id: 380FF280F31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

The AHB driver depends on the remoteproc interface, which could
be in a loadable module when ath12k itself is built-in:

arm-linux-gnueabi-ld: drivers/net/wireless/ath/ath12k/ahb.o: in function `ath12k_ahb_probe':
ahb.c:(.text+0xb2c): undefined reference to `qcom_register_ssr_notifier'
arm-linux-gnueabi-ld: ahb.c:(.text+0x1000): undefined reference to `qcom_unregister_ssr_notifier'
arm-linux-gnueabi-ld: drivers/net/wireless/ath/ath12k/ahb.o: in function `ath12k_ahb_remove':
ahb.c:(.text+0x1146): undefined reference to `qcom_unregister_ssr_notifier'

Add a dependency to only allow the AHB portion to be enabled if either
remoteproc support is built-in or ath12k is itself a loadable module.

A better way to fix this would be to make the driver more modular and
ensure the AHB and PCI components are built into separate loadable modules
like it is done for the ATH10K driver, but that is a much larger rework
that someone else can do in the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/ath/ath12k/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index 1ea1af1b8f6c..ed18e0624e03 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -18,6 +18,7 @@ config ATH12K
 config ATH12K_AHB
 	bool "QTI ath12k AHB support"
 	depends on ATH12K && REMOTEPROC
+	depends on QCOM_RPROC_COMMON=y || ATH12K=m
 	select QCOM_MDT_LOADER
 	select QCOM_SCM
 	help
-- 
2.39.5


