Return-Path: <linux-wireless+bounces-30686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512F6D10EB3
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E67C30BA7EF
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AD331A5B;
	Mon, 12 Jan 2026 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QWJlSThV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fHnUCBVG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EE334361
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203441; cv=none; b=N4YncmBkv1H3ovPY61FeGbCXs8mvz9a4y8FG0zgvKixhsWYqqcrW8usU40AONf4eH6gVPae6e/m8Gz3OgQdAOozjt/HfsHxQC8GI3iBGNXdvd4QuSTWJd5xqkVHL/wouWvKc7qsxHlNmie3a3Mpqcuy0M39Tp4NYSo6saOL4Dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203441; c=relaxed/simple;
	bh=HebJeyr4f14Me0I/h4egLQm6bT2uYmIAJIaI2IEHoMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jCh9pNWZtq4Rk+SXz7nsG46s2oVgLlZ446hkrbmlWir9x/Sz6TI/43A7tuBtV78mALeu3ZyOOXytRmepe2UsUNHCAV/Ow8MlcsiF91BrXfDH8HaEGwq4kKyK1wgWWHsvHGKYTuXiq7HeQlHRfBDCHFk7yky/PGNp86ehuTj6ewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QWJlSThV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fHnUCBVG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNFbuL4097398
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+DDj03Q/JZ7H86NZCwW9Onb7O0YE7qrXi49wOwmk9A=; b=QWJlSThVf8sa2q4K
	y45RguH8wCGViIadLoJgOKd+dDyGQmROQaDP0rH4bpHgSeQ+EN/pBa0GkxdkoSos
	nYUtHY/X4CC3wOSqUB1pR2uCAmw48MvDvct7dUJ1QGV6BVqCv2AzHvNh02/siqsb
	fMWB++OSRm6nozOP2L4bAr4cKxza/2Jp+OFbZVtJcJywrGD83H8XkzDFUG4FD/l3
	GJRP//2eMEVYz6CVpccl0HsQohptEn5BhfadN+I3mLsllbO9CXg9itSEozlIz0gl
	5kt1LiNRzfZ8DqrGzuV16jdnIUzjcHwoFrlGX+q0ttI8KrPCSNaR3oBuKEOi5d/Y
	Rt4kYw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkfhakxd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f4c1412b8so2377692b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203438; x=1768808238; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+DDj03Q/JZ7H86NZCwW9Onb7O0YE7qrXi49wOwmk9A=;
        b=fHnUCBVGiCAV4X/Hvpb0IjWcffOa+FsBpTiJXS6uQuNGkpDU9f9OE1RP4mvJMKk1BL
         X97gwiz5X05/UIqgSWUdZIcKO8oplpLhX28DbzEJGr4UY864ucCNfvX9yQz/LtnFTMlM
         KStT5R8zwT1kb2aWakvOfj4kg210Ht0l1yitR1nOM3p4TBuFNBkwId8mhNs7LBUOVoli
         hQEMG8hpOg5F17I5gNS0gjiVWoo2UzPf0HkWeNhNkoLX4GpDDD7cT8af/IfHCgqPbk5N
         D27GJu1DLVSSChakKrAwqJ2/ljLmdvM1pUms+rvgeo7dAAobgxUvC+MmEUmQAGkHfv/d
         Jw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203438; x=1768808238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+DDj03Q/JZ7H86NZCwW9Onb7O0YE7qrXi49wOwmk9A=;
        b=J0gg2CnyljcHEyhgkQkWebWwi+6efmNU6D9CxCbI5niyB6p1yzn0tmu9UkaXEeU+ho
         awwy9dPXNdL9VsnNi1i8G5pyRQ6ViwpdKBqCV+SPcvX0FbtRl38qGFYXLrKiPIPeHYfg
         cwIo1mHp09qrLtede0BhsO3k9FY+//5ED8roGfk44fpS1eqDlbzrOGjoGkX8OgN0kMs3
         Xay/WmTCd/HffLPocWYbZQULqthVPm6TftL5JGbxIxz+391HBI6I6sLugEifYlNKoOn8
         DsPEUkh2hMd7JxiAbIiugr7JcnfdyJKoYCLJ2mQSm/U/bNyXIgzza64PCwCbpFwyugd9
         4dpA==
X-Gm-Message-State: AOJu0Yzss1Uason+mXaQHC52HG70OGnD+95TSRfVqHW6RnD+rT28p/AB
	ccQhpRx16G7mX8fndrBpw4CShdPQZROaXQm65v+PhCipPc1zdKptsZDchckVEM1cFexNUJG7fOe
	erIU0wbd9g8RnfM23NAnzszAuZFAJVCmVhDLKyIzNZ9mROp24zpBQW0qTcsPNSdZBnJtD3SAYom
	iepCfv
X-Gm-Gg: AY/fxX7tgX1tgjk3qhC+s7ZJXD+qSiax0P6GsQ2xeBcgatGafGE7hcsXy0BPxc4kNmZ
	LNRZr/UgfpkFeerrQnIqcc0kXZybhW2y1QONfC0gBLfrmvqIfkRp8upHjdoXCnQigBwbSs6UMsj
	LAQGd4PETma2b//Zkwr5Nwr4fuKiEF1uNMc7MkoSWASgYsQIEa67mV9rm6TOgBpN1SzmWKzVPc0
	vHVYSSevt3d+eB9+qriC02u2nxhlvxN3L3WmF2QDfzJBzc9ys0FmdBkqPV2M37WnikvvAmNRfEd
	CBx7rOK5q7AlSM7/avq5ltGgsngUzJxxaumlnrjxVaAZdPbzp6cRg9fQAn+aHW11+gklMNnr1ej
	xjMpoUAH7jWyrdzWxqTC6ZgiIYIGexmsgOMYt6mbO1eNyOJCWx9AVblINhcCNyhA=
X-Received: by 2002:a05:6a21:7a48:b0:34e:a801:8166 with SMTP id adf61e73a8af0-3898f923739mr13191357637.32.1768203437459;
        Sun, 11 Jan 2026 23:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLaTEE3XoeVlTTVh97NjGjIR8OO/m3gjse8XJWaPhp9KYQmYnOcWMnW1Fn475oe/2EBWKpQA==
X-Received: by 2002:a05:6a21:7a48:b0:34e:a801:8166 with SMTP id adf61e73a8af0-3898f923739mr13191343637.32.1768203436978;
        Sun, 11 Jan 2026 23:37:16 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:16 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:33 +0800
Subject: [PATCH ath-next v2 13/18] wifi: ath12k: handle REO CMD ring for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-13-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: W2SvXHWo4XgFzrBu00kP4NNorfI07hjk
X-Authority-Analysis: v=2.4 cv=bOEb4f+Z c=1 sm=1 tr=0 ts=6964a4ae cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FdA_q80-M5M2ZQSmf9kA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: W2SvXHWo4XgFzrBu00kP4NNorfI07hjk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX42Uswxn4sMRK
 kRaUa9R/crwEBQe4vRcBS4P3xmw0c5N7tkD1PL6H955CKR8xPzKuKC32SVqxYrHHjDoWTZn9kCb
 pTDnwOvyWMusAhIrFu1jxvaXZDgB3PMlGyLpmtu+EXsMuoY8KL0YFvk9CE/RV19AtMwGaIh0L4+
 /ZmaBjCTqXetHIfdXJPSbR0XnlQxNYPoZUvayAzNVkoFDpvC/zg4N0CtF6ti28an3QEJZsqlz7F
 JBwUjOSsPkUb04fGwAEYhKSWNjgj6fd2laBNkYBuaMkPmhw16WieFZeqNdIsqi6mu45TfmLyvdc
 RLQgLuLY6kjU3OeIXaK5+hsxZLXSlahKWOxMA6/OKAsiEK+3JXj/tgFvsqFs0/cUTUlXZ85AAdp
 D3kbJzK05QK68XHK0pfABrUNl8OqoWUMWwR1t7laAz0xQ0UtIX/S7pg0koK7WTUt23ay9hG4gPD
 d7c+MTnLTPmHM9f11Gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120058

As far as REO CMD ring is concerned, there are two differences between
QCC2072 and the existing chips:

For the first, the TLV header of ring descriptor for QCC2072 is 32 bits
while 64 bits for existing chips.

For the second, QCC2072 has different hal_reo_get_queue_stats,
hal_reo_flush_cache and hal_reo_update_rx_queue structures. Take
hal_reo_get_queue_stats as an example:

QCC2072:
struct hal_reo_get_queue_stats_qcc2072 {
        struct hal_reo_cmd_hdr cmd;
        [...]
        __le32 rsvd0[6];
} __packed;

QCN9274/WCN7850:
struct hal_reo_get_queue_stats {
        struct hal_reo_cmd_hdr cmd;
        [...]
        __le32 rsvd0[6];
        __le32 tlv64_pad;
} __packed;

Note there is no tlv64_pad at the end for QCC2072, but all other
former fields share the same layout.

These make different ring entry size, so that parameter has to be updated
with respect to existing chips. This is done in the newly introduced
ath12k_hal_srng_create_config_qcc2072() function, which first creates all
ring configs by utilizing ath12k_hal_srng_create_config_wcn7850() and then
updates the individual field.

Besides, the REO command TLV encoding also need to be corrected because of
the different TLV bits. This is done by introducing a 32 bit variant for
each of the existing 64 bit callback.

Note the hal_reo_get_queue_stats_qcc2072 structure is introduced for the
purpose of calculating ring entry size. Existing hal_reo_get_queue_stats
structure gets used elsewhere even for QCC2072. This is working because
the only difference is the tlv64_pad field that is located at the end and
not getting used, hence can be ignored.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c              | 11 ++++++++++
 drivers/net/wireless/ath/ath12k/hal.h              |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h   |  7 ++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    | 22 ++++++++++++++++---
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     | 25 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |  2 ++
 6 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index bafb49ab5475..5ce5e0f89ca8 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -835,6 +835,17 @@ void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len)
 }
 EXPORT_SYMBOL(ath12k_hal_encode_tlv64_hdr);
 
+void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len)
+{
+	struct hal_tlv_hdr *tlv32 = tlv;
+
+	tlv32->tl = le32_encode_bits(tag, HAL_TLV_HDR_TAG) |
+		    le32_encode_bits(len, HAL_TLV_HDR_LEN);
+
+	return tlv32->value;
+}
+EXPORT_SYMBOL(ath12k_hal_encode_tlv32_hdr);
+
 u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc)
 {
 	struct hal_tlv_64_hdr *tlv64 = tlv;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 94ecc035fc49..f322000e8ac9 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1544,5 +1544,6 @@ void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
 					 struct ath12k_buffer_addr **pp_buf_addr,
 					 u8 *rbm, u32 *msdu_cnt);
 void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
+void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len);
 u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index cdcf24b1d6eb..c4c7ca9ee827 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -1049,6 +1049,13 @@ struct hal_reo_get_queue_stats {
  *		Hole_count
  */
 
+struct hal_reo_get_queue_stats_qcc2072 {
+	struct hal_reo_cmd_hdr cmd;
+	__le32 queue_addr_lo;
+	__le32 info0;
+	__le32 rsvd0[6];
+} __packed;
+
 #define HAL_REO_FLUSH_QUEUE_INFO0_DESC_ADDR_HI		GENMASK(7, 0)
 #define HAL_REO_FLUSH_QUEUE_INFO0_BLOCK_DESC_ADDR	BIT(8)
 #define HAL_REO_FLUSH_QUEUE_INFO0_BLOCK_RESRC_IDX	GENMASK(10, 9)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index 522b94b04f9f..0ae5b073287a 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -412,8 +412,24 @@ static void ath12k_hal_extract_rx_desc_data_qcc2072(struct hal_rx_desc_data *rx_
 	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_qcc2072(rx_desc);
 }
 
+static int ath12k_hal_srng_create_config_qcc2072(struct ath12k_hal *hal)
+{
+	struct hal_srng_config *s;
+	int ret;
+
+	ret = ath12k_hal_srng_create_config_wcn7850(hal);
+	if (ret)
+		return ret;
+
+	s = &hal->srng_config[HAL_REO_CMD];
+	s->entry_size = (sizeof(struct hal_tlv_hdr) +
+			 sizeof(struct hal_reo_get_queue_stats_qcc2072)) >> 2;
+
+	return 0;
+}
+
 const struct hal_ops hal_qcc2072_ops = {
-	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
+	.create_srng_config = ath12k_hal_srng_create_config_qcc2072,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcc2072,
 	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcc2072,
 	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcc2072,
@@ -443,7 +459,7 @@ const struct hal_ops hal_qcc2072_ops = {
 	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
 	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
 	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
-	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring_tlv64,
+	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring_tlv32,
 	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
 	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
 	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
@@ -451,7 +467,7 @@ const struct hal_ops hal_qcc2072_ops = {
 	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
-	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
+	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv32_hdr,
 	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index a88ef126aada..49c693289709 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -890,6 +890,31 @@ void ath12k_wifi7_hal_reo_init_cmd_ring_tlv64(struct ath12k_base *ab,
 	}
 }
 
+void ath12k_wifi7_hal_reo_init_cmd_ring_tlv32(struct ath12k_base *ab,
+					      struct hal_srng *srng)
+{
+	struct hal_reo_get_queue_stats *desc;
+	struct hal_srng_params params;
+	struct hal_tlv_hdr *tlv;
+	int i, cmd_num = 1;
+	int entry_size;
+	u8 *entry;
+
+	memset(&params, 0, sizeof(params));
+
+	entry_size = ath12k_hal_srng_get_entrysize(ab, HAL_REO_CMD);
+	ath12k_hal_srng_get_params(ab, srng, &params);
+	entry = (u8 *)params.ring_base_vaddr;
+
+	for (i = 0; i < params.num_entries; i++) {
+		tlv = (struct hal_tlv_hdr *)entry;
+		desc = (struct hal_reo_get_queue_stats *)tlv->value;
+		desc->cmd.info0 = le32_encode_bits(cmd_num++,
+						   HAL_REO_CMD_HDR_INFO0_CMD_NUMBER);
+		entry += entry_size;
+	}
+}
+
 void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map)
 {
 	struct ath12k_hal *hal = &ab->hal;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index 95f5595b30ad..ac2a8ac03288 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -864,6 +864,8 @@ void ath12k_wifi7_hal_rx_msdu_list_get(struct ath12k *ar,
 				       u16 *num_msdus);
 void ath12k_wifi7_hal_reo_init_cmd_ring_tlv64(struct ath12k_base *ab,
 					      struct hal_srng *srng);
+void ath12k_wifi7_hal_reo_init_cmd_ring_tlv32(struct ath12k_base *ab,
+					      struct hal_srng *srng);
 void ath12k_wifi7_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab);
 void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
 void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,

-- 
2.25.1


