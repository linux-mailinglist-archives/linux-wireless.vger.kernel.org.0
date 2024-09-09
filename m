Return-Path: <linux-wireless+bounces-12713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A6F97244F
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 23:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B54B22470
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50618A6B1;
	Mon,  9 Sep 2024 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="ozc22wyZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891B718C00E
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725916372; cv=none; b=GlUMh+nELarDMlhggK1diOBCxS5NhLbVl+sDORwgh+jljGdf/RrSZZGXJbny4sbYnIwaY4kBztRdxrtVyuY3U/vdutxGAu3vHX2gabEgb5qxF/mJnJD9JMoAipWPr9igMiTN52Ssk1tHR48xs3YtJNBXfCPtpu9ZDqs0msF4XR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725916372; c=relaxed/simple;
	bh=go2p7n5wPCB3gohcacdZcVGJoxZPBVmwUC406VuzS+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDgnqfKQxojOk4rEL7uSdRjMZ6H/KmqbEjbSy0gF2mqvYf6nI3vmXydnQHD3km8EJCUoehWUzXecbhQBKL4Pl54R02vhZv38+VOoiochIWhaLg+SGZYzfLczFN81LciSjcddtD4RNh1E1f2La2WGHep7Fss69JupncDQeoIdv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ozc22wyZ; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 015DD240086
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:12:42 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 97A8A13C2B0;
	Mon,  9 Sep 2024 14:12:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 97A8A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1725916362;
	bh=go2p7n5wPCB3gohcacdZcVGJoxZPBVmwUC406VuzS+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozc22wyZ3DgO0AdpJtNsOUHi8IAWVOnxbRQ3Lep0rwh31eiu7dpcz52RDgU8PZwao
	 ZtG2FBEypbdoXJMW6APdKKvbqR1crRU0Rr1UwJDc5ero64S1wSEGAXT3TJ6+wiz25G
	 MQNb0QuS27F03XshZJPf1wG6s0QpxIViWjIF6grk=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] wifi: mt76: Fix EHT NSS radiotap reporting.
Date: Mon,  9 Sep 2024 14:12:38 -0700
Message-ID: <20240909211238.3237111-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240909211238.3237111-1-greearb@candelatech.com>
References: <20240909211238.3237111-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1725916363-inZJBaekZ1hA
X-MDID-O:
 us5;ut7;1725916363;inZJBaekZ1hA;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Wireshark and iwlwifi use zero-based NSS reporting, adjust
mt76 to do the same.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
index 92ad1ecf6c9d..2d300948308d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
@@ -231,7 +231,8 @@ void mt76_connac3_mac_decode_eht_radiotap(struct sk_buff *skb, __le32 *rxv,
 		EHT_PREP(DATA0_PE_DISAMBIGUITY_OM, PE_DISAMBIG, rxv[5]) |
 		EHT_PREP(DATA0_LDPC_EXTRA_SYM_OM, LDPC_EXT_SYM, rxv[4]);
 
-	eht->data[7] |= le32_encode_bits(status->nss, IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
+	/* iwlwifi and wireshark expect radiotap to report zero-based NSS, so subtract 1. */
+	eht->data[7] |= le32_encode_bits(status->nss - 1, IEEE80211_RADIOTAP_EHT_DATA7_NSS_S);
 
 	eht->user_info[0] |=
 		EHT_BITS(USER_INFO_MCS_KNOWN) |
@@ -240,7 +241,7 @@ void mt76_connac3_mac_decode_eht_radiotap(struct sk_buff *skb, __le32 *rxv,
 		EHT_BITS(USER_INFO_BEAMFORMING_KNOWN_O) |
 		EHT_BITS(USER_INFO_DATA_FOR_USER) |
 		le32_encode_bits(status->rate_idx, IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
-		le32_encode_bits(status->nss, IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
+		le32_encode_bits(status->nss - 1, IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
 
 	if (le32_to_cpu(rxv[0]) & MT_PRXV_TXBF)
 		eht->user_info[0] |= EHT_BITS(USER_INFO_BEAMFORMING_O);
-- 
2.42.0


