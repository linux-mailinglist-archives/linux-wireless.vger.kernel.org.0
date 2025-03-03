Return-Path: <linux-wireless+bounces-19777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89DA4EB5F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 19:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FE88E5FAC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934C23956D;
	Tue,  4 Mar 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="cVRnCZE2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA7253B6C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111382; cv=pass; b=b4ZlRXpLDa9uD9SiDRgvphX2EJX9Zfo4E3xojc5cJrHJnGoi3ZNUHKkR+nbwdoUfNGonry3Rf2ZmR0Rs8U5Qnh0uKbDs6xm2V3XYO2dHrr1qIxIXwBWWqIz2yo7WsGRpl6OzqoQFmwDo0l8a3Hp0vpcYF5fwxpYa0JoLd5WZg9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111382; c=relaxed/simple;
	bh=dlzlgK1uuPwJmnwi9znbAsJgAX3BfyutzQnKO6E48gM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=atSImP2AKgeoEPxaJUDkyMweGovsVFO8mOdDctOmqE5Zhl+jqstFBNQOSes5Q2WTyjEbhRE7dqsXPebbLeYOWp9DbxAyqmz8GGRXoq23IZvkM/hrWGZ53YIAQFtcWW1ZD/4ZaExuQD3iDJEV2LyNuxMRVhkuMiT5TSHf8Mv0whc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=cVRnCZE2; arc=none smtp.client-ip=91.236.205.1; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id D3D31408B642
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 21:02:56 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dMl19SPzFwkK
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 17:28:35 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 2E9224272D; Tue,  4 Mar 2025 17:28:31 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=cVRnCZE2
X-Envelope-From: <linux-kernel+bounces-541121-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=cVRnCZE2
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 15A0142266
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:09:59 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id B6A7F2DCED
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:09:58 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D214316E3C3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F299B1EEA46;
	Mon,  3 Mar 2025 08:09:40 +0000 (UTC)
Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF813A3F7;
	Mon,  3 Mar 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989378; cv=none; b=ebhlCpCPfQpfGzDxgSTyYtKUxTMM2UpTGNl3Z30US178+dsGLAAIkvu2eOLWxcu8HP6/3RecQdh19km/r9VRIILtojffhePjHEZxvtCOA6+ErstbJbmR1cSctKnu7CJ6tplDR26Z140TT6RLOO4puzpFQrq4M/ENjylh9pH8tkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989378; c=relaxed/simple;
	bh=dlzlgK1uuPwJmnwi9znbAsJgAX3BfyutzQnKO6E48gM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SIFMNuRyKXtPel8BoEZWHTlIuvhtZiJMGDKfkt6lSsDSkFox6djV3uxbpcQYz9xfBh0RHGLHWBAaG9MqiG0jqWdqi1tOr7LyVIak6/cDHr3VgyKcQ8VFT2gU7eSYeJA5Xlt8rB1YrrZMzKvdd7nqm/rs5ERdC0SVITVqZg4YjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=cVRnCZE2; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Received: from mail.crpt.ru ([192.168.60.3])
	by mail.crpt.ru  with ESMTP id 52388PGD020784-52388PGF020784
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
	Mon, 3 Mar 2025 11:08:25 +0300
Received: from EX1.crpt.local (192.168.60.3) by ex1.crpt.local (192.168.60.3)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 3 Mar
 2025 11:08:25 +0300
Received: from EX1.crpt.local ([192.168.60.3]) by EX1.crpt.local
 ([192.168.60.3]) with mapi id 15.01.2507.044; Mon, 3 Mar 2025 11:08:25 +0300
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: Johannes Berg <johannes@sipsolutions.net>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Jeff Johnson
	<jjohnson@kernel.org>, Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>, Govindaraj Saminathan
	<quic_gsamin@quicinc.com>, Bhagavathi Perumal S <bperumal@codeaurora.org>,
	Rajkumar Manoharan <rmanohar@codeaurora.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH] ath11k: fix overflow in tx stats calculation
Thread-Topic: [PATCH] ath11k: fix overflow in tx stats calculation
Thread-Index: AQHbjBNwlu6FEnv6mkuda429t7F2NQ==
Date: Mon, 3 Mar 2025 08:08:25 +0000
Message-ID: <20250303080819.48872-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 2/17/2025 9:52:00 AM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 192.168.60.3
X-FE-Policy-ID: 2:4:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=GXCR2/qllsmPA+9VDf1WpC/D25nO4d0B9V4QL8xXBpM=;
 b=cVRnCZE2yRwZueFBHy4v+SikDM43pylMgfh911GYqPN0IIt3BSzNGN8ZlKb4vq/dq6CY2qpD4sfg
	8kRyBybkjfO93Vpxt0HV5zMAGEIcdTOmls/gMqxjyK9DRaPFWd8FWIq+bAPIMDLC72Pq0ZafQrM/
	xkJKWHQtjde+9Y/OdG/WYtLulJ6X7ojMB1n/zUWXkKLUcTvhw0XU4H6EdBz9kmGEvuV5vTpSZH0Y
	/8kTPSblVtkLGX1AiybAcIR7naqN66Q8716J6HMQGkYdY7HPAzKtmKWHaS7Fy3/hb18+hHkhSGsA
	qTQuNNn92yGO2ALB9srRBlcPXvw5W4B2bqxLzg==
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dMl19SPzFwkK
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741716061.01692@UaDjNuCYUuddFxUAf5sqXg
X-ITU-MailScanner-SpamCheck: not spam

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

Size of variable peer_stats->succ_bytes equals four bytes.
Size of variable peer_stats->retry_bytes equals four bytes.

The expression peer_stats->succ_bytes+peer_stats->retry_bytes is currently
being evaluated using 32-bit arithmetic. So during the addition an
overflow may occur.

Since a value of type 'u64' is used to store the eventual he, it is
necessary to perform the 64-bit arithmetic to avoid overflow during the
multiplication.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
      =20
Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wi=
reless/ath/ath11k/debugfs_sta.c
index f56a24b6c8da..982a7add6ea6 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -69,26 +69,26 @@ void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta =
*arsta,
=20
 		if (txrate->flags & RATE_INFO_FLAGS_HE_MCS) {
 			STATS_OP_FMT(AMPDU).he[0][mcs] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 			STATS_OP_FMT(AMPDU).he[1][mcs] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		} else if (txrate->flags & RATE_INFO_FLAGS_MCS) {
 			STATS_OP_FMT(AMPDU).ht[0][mcs] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 			STATS_OP_FMT(AMPDU).ht[1][mcs] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		} else {
 			STATS_OP_FMT(AMPDU).vht[0][mcs] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 			STATS_OP_FMT(AMPDU).vht[1][mcs] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		}
 		STATS_OP_FMT(AMPDU).bw[0][bw] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 		STATS_OP_FMT(AMPDU).nss[0][nss] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 		STATS_OP_FMT(AMPDU).gi[0][gi] +=3D
-			peer_stats->succ_bytes + peer_stats->retry_bytes;
+			peer_stats->succ_bytes + (u64)peer_stats->retry_bytes;
 		STATS_OP_FMT(AMPDU).bw[1][bw] +=3D
 			peer_stats->succ_pkts + peer_stats->retry_pkts;
 		STATS_OP_FMT(AMPDU).nss[1][nss] +=3D
--=20
2.43.0


