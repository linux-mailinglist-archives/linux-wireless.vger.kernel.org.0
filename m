Return-Path: <linux-wireless+bounces-29124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB745C6D59B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 09:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C1793A1734
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9881327219;
	Wed, 19 Nov 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huAkSLjK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9173148C8;
	Wed, 19 Nov 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763539428; cv=none; b=joaJBth9+ZHfwSwxHNtBNSGA/m38Vb5i+HdVJWGoU9p6Cm1HOTFyuAV8kRcde0lfcPq5dRqNUpDSEPireBEcfudle7SlgyxQIogVPMVXBH+Q2Sdw3xAeG4iorv5TDGzL6KlmpG3KidcRYd64L3nn4imp/JvJej4v/nj5U5gwCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763539428; c=relaxed/simple;
	bh=1gTHiezWLSTtMUkTEYC4o5k8gdWKfuDR3DU/1XBo5jk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZbXMf/fwMKAfw7/pnj4bGM3VgQ3iiVDFUwLwaU6SxralCnBh9QYmQnfSFc2o0rTEPQlgyiLrQ4QfvU8SAbEhITOgoGRWw8N/k5GbCH8LVqEP55v8t9NxLyX9qzyZlwvm/Z78RZWog2rST5yG0sLwMHbtkxb4zKLrdiGwp8KdD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huAkSLjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6349FC2BCAF;
	Wed, 19 Nov 2025 08:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763539427;
	bh=1gTHiezWLSTtMUkTEYC4o5k8gdWKfuDR3DU/1XBo5jk=;
	h=Date:From:To:Cc:Subject:From;
	b=huAkSLjKvVAbGIDrRnhGkQwBw1qSs3Tp6AHN6juRDNwzwxALZ4JV3MGxmmWNoIiRG
	 FFqUDJH8mj/n3i7NbiS+/dfVd1njSO8VKeKWjx1Bp86G+0Azvbc+gV5pa1AUdPY1hk
	 OuIR+Cpwfp1hzbkb38CHQC5a0uMcf62IEXysrADbwNFr9Q2to9y2G+qtbUpGpFwsUd
	 undSoc1M383SMzkHex5+5Y0p5TdklfkHfOw3DfUVsSskYdI5rNnkjma7fuGjjZ+e7E
	 1URaX1d0jQ4SqMGPej+TVnGSbfBimwyAokeUzBEAUlwY6p2T3dP81q68JTbi4B8g6o
	 ycTNX/zxAw6Lw==
Date: Wed, 19 Nov 2025 17:03:42 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Kalle Valo <quic_kvalo@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] ath6kl: wmi: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <aR153k4ExCD-QTMq@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Move the conflicting declaration (which happens to be in a union, so
we're moving the entire union) to the end of the corresponding
structure. Notice that `struct bss_bias_info` is a flexible structure,
this is a structure that contains a flexible-array member.

With these changes fix the following warning:

drivers/net/wireless/ath/ath6kl/wmi.h:1658:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/ath/ath6kl/wmi.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
index 3080d82e25cc..0e7810b9372f 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.h
+++ b/drivers/net/wireless/ath/ath6kl/wmi.h
@@ -1649,6 +1649,9 @@ struct low_rssi_scan_params {
 } __packed;
 
 struct roam_ctrl_cmd {
+	u8 roam_ctrl;
+
+	/* Must be last as it ends in a flexible-array member. */
 	union {
 		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
 		u8 roam_mode; /* WMI_SET_ROAM_MODE */
@@ -1656,7 +1659,6 @@ struct roam_ctrl_cmd {
 		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
 						     */
 	} __packed info;
-	u8 roam_ctrl;
 } __packed;
 
 struct set_beacon_int_cmd {
-- 
2.43.0


