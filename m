Return-Path: <linux-wireless+bounces-10788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE3E943D77
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4731C220F4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D5416EB6E;
	Thu,  1 Aug 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGj87hUE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6058B1C825F;
	Thu,  1 Aug 2024 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471915; cv=none; b=kWKAFD00dY5XSHUekOJxkmZGGAbupVIcRFC5PB2p3Z7+m2yKwuHCOefjXFKLWo52EPckgTGRr/s7O+qT1XbUlMq+T0potU+hP28ggMaoc1NOVeuZdg64KwkNYqWG2HKT4gJX40oFg47twTORF9DI5OXVz6qBNl9D0E8XB6O4x60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471915; c=relaxed/simple;
	bh=uWsydtAxAezU/3Ux0EYTJiH3XD7NZxOj5OAzoHq4vDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emQh7+SUd62bqX0huBCo1rb9AeHFRr9RzpU6/8iqtGLnrGTa0x5QaMwtSW9vGP6kW9tolousYZmsrP6aZ6gZI6QCg0ExPFUoen5TDTUdItqjAqWGuZsOqnnFZXwxhXy3L8kCI013CWR32LjTUGZU8vWCE0KMI5kATjmOHEtlkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGj87hUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC80C116B1;
	Thu,  1 Aug 2024 00:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471915;
	bh=uWsydtAxAezU/3Ux0EYTJiH3XD7NZxOj5OAzoHq4vDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGj87hUETbWCAaB92vXAcQGQ8nXb9WD5wJIkl1oX+ye3WwLZrr0ThT7Qa+IFjNB0v
	 CdQBZIEudUrUgAmYUsSxV6SrU5Q8eluZ7r5Bnfr7pwgy6NDxR9a8iZh0XN2ZUitotA
	 aNYTyg/CY1T8bu6tLpR1Tzi73FUKozi5MqY37YVsltrizUiNALu2bEaCS5S7Z2AYgo
	 6mqgTjskXZcuaSJ/kQwR187RbxTHxPGObPs4aFOWO42J3JlAve/bd/cYaJJnvp58DU
	 b7MSAChX+LtTPsC1MPwvThxSmCRNg802JAS357GkGCV/03wd6TrwGMJyNXgvsa4BrU
	 hemuduCt80yTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ajith C <quic_ajithc@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 60/83] wifi: ath12k: fix firmware crash due to invalid peer nss
Date: Wed, 31 Jul 2024 20:18:15 -0400
Message-ID: <20240801002107.3934037-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Ajith C <quic_ajithc@quicinc.com>

[ Upstream commit db163a463bb93cd3e37e1e7b10b9726fb6f95857 ]

Currently, if the access point receives an association
request containing an Extended HE Capabilities Information
Element with an invalid MCS-NSS, it triggers a firmware
crash.

This issue arises when EHT-PHY capabilities shows support
for a bandwidth and MCS-NSS set for that particular
bandwidth is filled by zeros and due to this, driver obtains
peer_nss as 0 and sending this value to firmware causes
crash.

Address this issue by implementing a validation step for
the peer_nss value before passing it to the firmware. If
the value is greater than zero, proceed with forwarding
it to the firmware. However, if the value is invalid,
reject the association request to prevent potential
firmware crashes.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ajith C <quic_ajithc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240613053528.2541645-1-quic_ajithc@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5bcfc1cf5adc8..0f4ba1c11f728 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3357,6 +3357,11 @@ static int ath12k_station_assoc(struct ath12k *ar,
 
 	ath12k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
 
+	if (peer_arg.peer_nss < 1) {
+		ath12k_warn(ar->ab,
+			    "invalid peer NSS %d\n", peer_arg.peer_nss);
+		return -EINVAL;
+	}
 	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
-- 
2.43.0


