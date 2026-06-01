Return-Path: <linux-wireless+bounces-37242-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFRpOAhXHWpLZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37242-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:55:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5737D61CDF6
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2BC3306DF98
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D735D3939B5;
	Mon,  1 Jun 2026 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GA8PIvCd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XUwDAYWa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCC397AEF
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307229; cv=none; b=iVumxbSTBRa7jkoB0Z9qpFbW46lu7VJXSbgBGQuIHAmxKnCwtmNRoV0d7fxKcwGMdqQMjy47W+tZKZmFnY4WFBncLHvU632OyHzRUkzSdRGEZHqMWoTo7QSUMfG7THejggxAB/uxxo9o+Bd6JNQ/+AreBWcgoNV2r0nPkmmWXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307229; c=relaxed/simple;
	bh=y45NCsNzLa0LZnjcZqaFg8apxQ3FaLRPDC5rkZ5zHog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTbh+UU3nL4jkGRBOHkfgaHD/lgG8NZ0ksyg0LJ/8UVYxFs7XuTp3odtzF34Tku0Lcu8GmwCjp8QA+P2TnZJS5ZglvBNeSgLVY0f52k1O/KPlGdK4Qvw9nWKYvNxJFN7HKzN1nXC8mJh+tD5px3GkCKvibvimvnKBeW3gS9Tl88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GA8PIvCd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XUwDAYWa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6517VmQX3029821
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 09:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mDmthOZDE3oCNTwdUq0Bs0V4XD66xhAulJQ4u/yolHc=; b=GA8PIvCdbExA2H10
	CNT4vPPC7Ss9Ioa2J+WZHIGA7WeEK3ncNOnyYts9XkbdTVldeoFSDOYFUahkLySq
	du8S5C9IQxjy/IdLtoQMq91DLvT5P3Gaov5sqCWtR0pCPQFTBByMPcq9ZHnqsZWJ
	CX4S2Q5jutw/aGBt+DUR+6EAAfc364D8pb7GYEiZnMQ20zO1MeGfkYE557cWxqQ9
	TfKfwh/Nb/+ngJI7SOi/63sp0eSmmLFt1mvpfU3L8C2MinuACtxn6/E0263jbB9E
	TWUYgePXoIbZ9p4rPmGUWJDxD7PxsFXVR3lv8seuMqsx8gy+dgBDnYWajy1UjW6E
	XJiNnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyuxyy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:46:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5175842d1abso10677751cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307219; x=1780912019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDmthOZDE3oCNTwdUq0Bs0V4XD66xhAulJQ4u/yolHc=;
        b=XUwDAYWazlDHJhd/Wcy7XWbpn9I5UG4hIuOMhtM/KLgqkQMe0SF9jMJHTRGm74WK6r
         4inDAFijkjRxlHzqGd+mNsISZcsv0YkqmxGG10DyKqYXy4QkvE1LKgdMu/O7GRWp8pC5
         iszp0uDdDCo5AaQ7rccGbYDVh3dXXgi5WdJB3z6+oE1PyJ0egpD6T2Da5Fm5v+lObD2i
         tUiKp4J+poyxIa456+NMm1a/fBsMu5huP+GsVp1BDJhqvLCvCJbivj7ltjXz2Zv806Tk
         2xXUr6ArIHr/+Z1JBnx0az1VOM1pbTuupFMhcjmbRWMdnQj9VBdayZynkqAzwXJziCH/
         ON+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307219; x=1780912019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mDmthOZDE3oCNTwdUq0Bs0V4XD66xhAulJQ4u/yolHc=;
        b=SPvwmdWJeEL2p1rGrsMS92B59yCzsfMZAwpGUXHnKn0uxZ0bfKKzLtZMZ4mdORSdQ/
         qlqyZdme0vdHri7dPsEpcSTCy+qroIWHgoCS/rzmUcvELIwPHbduZj9tRHdLQgzPAmJS
         Xnutmv1JPk/IMLLIO806lRRViTF6OB+iN0CoLTva/zwgu/+0DYleXknHQZy+kSjByeQH
         RF5Sqeyjk58uVSKjJU4abqwwHvz9FRqnDgXxU6RkyePMWM5vuLeQLJdnYFRYoOX2TEmp
         o/+MTYp9hwNHFjoXDtCosywvwhxvVjhJGio4887VIM9kLtGoiquDBr9siipe6m8MiRl8
         vl7A==
X-Forwarded-Encrypted: i=1; AFNElJ/a4LDm1v80F7nKMwygQirorAf7s2CSjcAy5mbtl+l+8EaZSfuZsNTn/69wIHT/hrbsHj7XsFk+ErEHqKcL/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxy6d5IpyHwk11XlmLanSieEJ5S7lOEhhPh/V2xsTBVO+OgOrH
	Mpl9mYmfPVJR8rCGrXxQm/QIo7S5MFKuicTqVCQTjzKA3n1wG7HpaklB8CXsDxAmdLAyv8fFKwh
	4akch2OK7MCx5dcZ6AKVYTawUUiEpVo5pmtdfRSWhUksxpzrGtm5gnien2uQhj5m6eUpKug==
X-Gm-Gg: Acq92OGUatc68BPGaz+J2vBhyyUEdgMmVXfRW/FuhNlzADLD7NGtBBYdazwQJzjMO0x
	8/BYTqIeJFsWpIujhXkQ1sbo1B9nHUiLYTzzLvruNztDtIPWgLnQ73HijsqhdYg3gT1nPbbfw5X
	dIhlhLm3/6oMrxPCnmIVHi9hYqInQaqOVN1wktT3J5KaMcV4LGYAZSvlOhqf7O7yYhFiOD5Mceu
	1RtCRIRsR93ydLvuaq2I+0PcDZfkhFnjMvIC6JdoW82/rZEMVs33PfziTvzVFz+vzhQxfsjyZz9
	HbrLIwtyDjh1d/UROm3tAiwiyzHeN5JALV0SXZgowrS5N3deM9MZoiaHOGpwHXcgbRokDHT3RxD
	R0dw1n1ARSrked+dgqagibzO4frzNCZZDgpcKV1F3TKg4FTFJEaZbMVI0aTgNakJqmq9wDvT4xg
	OoHdQuUJQZfLNoBsdxvLWBQ6r9kgjBvF5QeSmtv2kP+bLyYQ==
X-Received: by 2002:a05:622a:1801:b0:516:dc75:1aca with SMTP id d75a77b69052e-5172dc87953mr151917671cf.26.1780307218919;
        Mon, 01 Jun 2026 02:46:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1801:b0:516:dc75:1aca with SMTP id d75a77b69052e-5172dc87953mr151917371cf.26.1780307218462;
        Mon, 01 Jun 2026 02:46:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:46:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:50 +0300
Subject: [PATCH 2/7] wifi: ath11k: enable support for WCN6851
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6202;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=y45NCsNzLa0LZnjcZqaFg8apxQ3FaLRPDC5rkZ5zHog=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVUK7QuYcfCOY5WWIdcP4n/V95KN92adkVK36
 CLoWBZO9qSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCgAKCRCLPIo+Aiko
 1fePCACmpxRJ7fjX6M4d1Hn8bEIkUTXkhbVfYBcp+MNo7FxEDwQfrwU0dqSru85nwTzeJNdlI4t
 O/Da9CX3JfrqNZyRbVykvXjlJwlg9ajAjw1JKZK9X292mm3eLZ07fdivfoxmU8XlswQrk7MmVc/
 DtzKNJ1f8o0J1+fcS0+fJYO8coqo8rkdA34Ad+dFo/PYJFnsPlLfTjYN/VgUa/j5B3rqfXsN6Zw
 y/IZ+Bahb71Hj7mKMCiiRoyC+n+zGEPOeysDfsrgcXxIO5leYGNtCj4CliK5+EAzTWlLbICmvqw
 Vy2iV6ckl2kaMeHXYXWQqlPImhrBv7XpDG8JTuwJYzXULGTe
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX14k+L3vyLWyx
 Y7np5strrQgkL8dvwptk/ni3w/0adEVTEDAzNlDkthc/ILtOYguSVrUFGhuUkPv8udNhF0FeZKd
 AeDPcfbDqMwuNVFsd3NWhcURMEp4uMroaMaoUrpw7Cw//GTfGSoRplPRly/CO8ogpLnPhWK44z+
 0BPwhrjtJgNBgBClgvYKweCdDSCYErU16YXyQp/gZbvDsPaCbo+Vvl5dMjQUSKGRkdqsbmctTvU
 6WOV9zRpj8DOToMMrtg5sseKGwtkoBbqXfLjc1eMuMG2CEhEdZ4IV68DYCScpll0KesDy2UVibH
 j+e9lIFl88YR6/Cb+13V59cWl29z1szMTAcyu5p3YceIEdtRRUqdCxoyP8vioOm/HiVKEFC1oU9
 amz4QB8ouSZMx0ZB2qZRVAbfextGCo2RaDxDOTzSBckEurdLF5q8yAXOdPJ2VSjt0C51rBpGJKq
 GLVphNXjhLznkMhDFHg==
X-Proofpoint-ORIG-GUID: thher6Pp3AX2g7P7WLPQVt3HOZS-EzLs
X-Proofpoint-GUID: thher6Pp3AX2g7P7WLPQVt3HOZS-EzLs
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1d5513 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=1Ms6DnRdHleovX8mdIYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37242-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5737D61CDF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
configuration to support hw1.1 version.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 92 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  |  9 ++++
 drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
 5 files changed, 114 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3f6f4db5b7ee..7e997016cf6e 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -393,6 +393,98 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cfr_num_stream_bufs = 0,
 		.cfr_stream_buf_size = 0,
 	},
+	{
+		.name = "wcn6855 hw1.1",
+		.hw_rev = ATH11K_HW_WCN6855_HW11,
+		.fw = {
+			.dir = "WCN6855/hw1.1",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+		},
+		.max_radios = 3,
+		.bdf_addr = 0x4B0C0000,
+		.hw_ops = &wcn6855_ops,
+		.ring_mask = &ath11k_hw_ring_mask_qca6390,
+		.internal_sleep_clock = true,
+		.regs = &wcn6855_regs,
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_QCA6390,
+		.host_ce_config = ath11k_host_ce_config_qca6390,
+		.ce_count = 9,
+		.target_ce_config = ath11k_target_ce_config_wlan_qca6390,
+		.target_ce_count = 9,
+		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
+		.svc_to_ce_map_len = 14,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
+		.single_pdev_only = true,
+		.rxdma1_enable = false,
+		.num_rxdma_per_pdev = 2,
+		.rx_mac_buf_ring = true,
+		.vdev_start_delay = true,
+		.htt_peer_map_v2 = false,
+
+		.spectral = {
+			.fft_sz = 0,
+			.fft_pad_sz = 0,
+			.summary_pad_sz = 0,
+			.fft_hdr_len = 0,
+			.max_fft_bins = 0,
+			.fragment_160mhz = false,
+		},
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+					BIT(NL80211_IFTYPE_AP) |
+					BIT(NL80211_IFTYPE_P2P_DEVICE) |
+					BIT(NL80211_IFTYPE_P2P_CLIENT) |
+					BIT(NL80211_IFTYPE_P2P_GO),
+		.supports_monitor = false,
+		.full_monitor_mode = false,
+		.supports_shadow_regs = true,
+		.idle_ps = true,
+		.supports_sta_ps = true,
+		.coldboot_cal_mm = false,
+		.coldboot_cal_ftm = false,
+		.cbcal_restart_fw = false,
+		.fw_mem_mode = 0,
+		.num_vdevs = 2 + 1,
+		.num_peers = 512,
+		.supports_suspend = true,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
+		.supports_regdb = true,
+		.fix_l1ss = false,
+		.credit_flow = true,
+		.hal_params = &ath11k_hw_hal_params_qca6390,
+		.supports_dynamic_smps_6ghz = false,
+		.alloc_cacheable_memory = false,
+		.supports_rssi_stats = true,
+		.fw_wmi_diag_event = true,
+		.current_cc_support = true,
+		.dbr_debug_support = false,
+		.global_reset = true,
+		.bios_sar_capa = &ath11k_hw_sar_capa_wcn6855,
+		.m3_fw_support = true,
+		.fixed_bdf_addr = false,
+		.fixed_mem_region = false,
+		.static_window_map = false,
+		.hybrid_bus_type = false,
+		.fixed_fw_mem = false,
+		.support_off_channel_tx = true,
+		.supports_multi_bssid = true,
+
+		.sram_dump = {
+			.start = 0x01400000,
+			.end = 0x0177ffff,
+		},
+
+		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
+		.smp2p_wow_exit = false,
+		.support_fw_mac_sequence = true,
+		.support_dual_stations = true,
+		.pdev_suspend = false,
+		.cfr_support = false,
+		.cfr_num_stream_bufs = 0,
+		.cfr_stream_buf_size = 0,
+	},
 	{
 		.name = "wcn6855 hw2.0",
 		.hw_rev = ATH11K_HW_WCN6855_HW20,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index a0d725923ef2..29727ee94bfc 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -147,6 +147,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_QCA6390_HW20,
 	ATH11K_HW_IPQ6018_HW10,
 	ATH11K_HW_QCN9074_HW10,
+	ATH11K_HW_WCN6855_HW11,
 	ATH11K_HW_WCN6855_HW20,
 	ATH11K_HW_WCN6855_HW21,
 	ATH11K_HW_WCN6750_HW10,
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index a6c9ff112c68..c94546c367a7 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -393,6 +393,7 @@ int ath11k_mhi_register(struct ath11k_pci *ab_pci)
 		ath11k_mhi_config = &ath11k_mhi_config_qcn9074;
 		break;
 	case ATH11K_HW_QCA6390_HW20:
+	case ATH11K_HW_WCN6855_HW11:
 	case ATH11K_HW_WCN6855_HW20:
 	case ATH11K_HW_WCN6855_HW21:
 	case ATH11K_HW_QCA2066_HW21:
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 35bb9e7a63a2..dc1dfd219d88 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -1031,6 +1031,15 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		ath11k_pci_read_hw_version(ab, &soc_hw_version_major,
 					   &soc_hw_version_minor);
 		switch (soc_hw_version_major) {
+		case 1:
+			switch (soc_hw_version_minor) {
+			case 0x10:
+				ab->hw_rev = ATH11K_HW_WCN6855_HW11;
+				break;
+			default:
+				goto unsupported_wcn6855_soc;
+			}
+			break;
 		case 2:
 			switch (soc_hw_version_minor) {
 			case 0x00:
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index fc6e7da05c60..0f4dc05cc5b5 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -86,6 +86,17 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 		},
 		.hw_rev = ATH11K_HW_QCN9074_HW10,
 	},
+	{
+		.total_vectors = 32,
+		.total_users = 4,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+		},
+		.hw_rev = ATH11K_HW_WCN6855_HW11,
+	},
 	{
 		.total_vectors = 32,
 		.total_users = 4,

-- 
2.47.3


