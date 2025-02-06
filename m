Return-Path: <linux-wireless+bounces-18606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D30BA2B4DB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 23:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03D6167004
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074E22FF53;
	Thu,  6 Feb 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CRgD98VG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CE22FF37
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880011; cv=none; b=MQf2SoHG5fUdVhMe234/SZKbm/fr/qRSfXxV/UYCeYBELKv3Nu2Whc8vPUzB6Cj1Sm3JTRge9ktNVmkkj5dsclwh1WA7lLp093S8Dubm7xDG+t5cXKiVgiPRCqPSwv9u4dIrzBrCH+2xnHiwjRX8NaebqPXEE+vWkYLg9H0k0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880011; c=relaxed/simple;
	bh=4jeXmYT9XZLE4PA0fI3aucFc2etq3iYuQtGNNdGwnLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DG6L5eo+foUxNsVB8RCYlLK5GZEETErXJcMjCMakUufxSrfcWTHatkuTFdG157MUEWMhnw52i+5yQj42J4hrTjOfFVHBAYx2Trxc2S4+Nhx2nmC53INN5S/5joeQ+RPY3hQCD94iTxC+zUBMGKzT8ODKz4oIjfbPJ4YNXZYycqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CRgD98VG; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Yprw85mfVz6CmQyZ;
	Thu,  6 Feb 2025 22:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1738880005; x=1741472006; bh=AVJ8WuxC4yXkdDdbjZk8+oDzRdxvNMJrvKP
	xyZ0bnBc=; b=CRgD98VGQDwWffd9T0v4Um+LYNODVCReMXS7YsVSophJMkqwQFi
	/pfVIBwOfF8cb9cpIjdGpkpUYwZ8rvJBzn23yZa5lOZ/jkhqgLJyb1rGO31FBpN3
	hzujUCs/goG861cNYblh+iD5ir4TIPe+bJ2OahOrVwZ4kPSmPqrXnlM05uIu1VZK
	Qf8uplYU/JbABcyBnnSfjM/JXK1S3wR11wjxcU2Y+2j78/IvRh9yyfIFM2VVXJzu
	xe20IDeZxath4pTA1YxfCycKLukV2Qr9z7pljiwL+vOlNGxk0alQ+ZjiZ3Sre9B0
	BRrZPQPhuDR1rwCzMd3wFnGRipuIoNAcwRg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rkzGGjQIbGhL; Thu,  6 Feb 2025 22:13:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Yprw23XScz6CmQyT;
	Thu,  6 Feb 2025 22:13:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH] wifi: ath12k: Fix locking in error paths
Date: Thu,  6 Feb 2025 14:13:17 -0800
Message-ID: <20250206221317.3845663-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If ag->mutex has been locked, unlock it before returning. If it has not
been locked, do not unlock it before returning. These bugs have been
detected by the Clang thread-safety analyzer.

Cc: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Fixes: ee146e11b4d9 ("wifi: ath12k: refactor core start based on hardware=
 group")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/wireless/ath/ath12k/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireles=
s/ath/ath12k/core.c
index 0606116d6b9c..212cd935e60a 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1122,16 +1122,18 @@ int ath12k_core_qmi_firmware_ready(struct ath12k_=
base *ab)
 		ath12k_core_stop(ab);
 		mutex_unlock(&ab->core_lock);
 	}
+	mutex_unlock(&ag->mutex);
 	goto exit;
=20
 err_dp_free:
 	ath12k_dp_free(ab);
 	mutex_unlock(&ab->core_lock);
+	mutex_unlock(&ag->mutex);
+
 err_firmware_stop:
 	ath12k_qmi_firmware_stop(ab);
=20
 exit:
-	mutex_unlock(&ag->mutex);
 	return ret;
 }
=20

