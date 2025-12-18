Return-Path: <linux-wireless+bounces-29875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9FCCA03C
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB555304569B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3EC26ED59;
	Thu, 18 Dec 2025 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OPST4mig";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZoS3VmIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88426E6F4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022935; cv=none; b=Wv9o4OTZaFEi5J/iFiphaImddR0Jg6jJSoy6FrtatUvfmzS95igHwh0z82cceymzk0rxAOy5yW2LwGlPWCIriTIVil0be+Z9R42hPPi7fGNCgtoQInxKh85KbknQUAG/p1MJQQzf64afixTisGcXcaM5Ybsrx03GGs3IOcqcato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022935; c=relaxed/simple;
	bh=HebJeyr4f14Me0I/h4egLQm6bT2uYmIAJIaI2IEHoMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aNWxxHNho9QITHuinB3DWWbk7jzluzMXQammhgdst0h2tBtsjEU9I0BhjLwV1IKt85YA1OmpH1yoNvN1bN1ts495nxVDAIEUw4CckQBb6bRQvPijlG9T9PEslv9ve+ycQK8UvSm6OEYA3qrZzCuFaC5gP4nbo5ACpiXGtcU9ePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OPST4mig; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZoS3VmIF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YZ78174303
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q+DDj03Q/JZ7H86NZCwW9Onb7O0YE7qrXi49wOwmk9A=; b=OPST4mig2+rzmNLT
	Qj1hFlt0+2gWPw+qIUv63mAc8UlpimM2AcmaemYbmPyp8aCPjehmebBRGIFIszk9
	H8VNO2tzwlborFw5lGnuJkMxPjQ7LdGD2xP/v2IUCy1D0mwrBfPXKm4EMDizemFe
	5Tw6Vz0VdjJVZibZizyL9TsOyJoPUNrF1CNaEMFlkcNMcUEBUUlYNZbEHero2n5x
	JJqVpsz9YuuNyuKKuCTXiddmij3EuxehK7qSQQRjtdOklFPC8/7XdbRyNwpT0BL3
	YvCsCtpyUn/39fSNlbkqLQyo0imUvO5Y2NZUiTdGCwrecjBP2TxuRiH5iXnX4A37
	OtWGRw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43nmrqrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0fe4ade9eso1675115ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022933; x=1766627733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+DDj03Q/JZ7H86NZCwW9Onb7O0YE7qrXi49wOwmk9A=;
        b=ZoS3VmIFjqLqzS2Nr/0QvuDRGNE/uTb+zBPJCiRchlta4xpGhR0NSp5+col1nEPCIC
         lhjv/zM5LsjEYyTTs7ZkR5vLBAYVsRY8dZqsF1DUgXLqzOCXa2d4H615Gf1ImWWYG0WQ
         aYmaalIDdAg3xpfpO/bQpvf8Ap/9U1V+QWTmsaf/wzkE3AR4ydiHh6wDKsG1TSxG2PHB
         1zb4phpS8MtYKhkFv2DD6gabUbqcs0ROBkNFFHZjmB/QFYhTj8+suG9AjTHIPTi8g6kY
         xLVH/2K7Zr/S5Z07w/GN2WrJu9Xsp5GlCEQ/FtjWqpHz1OuaJ/ye8Eg2JQTZRfrIHEHO
         uATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022933; x=1766627733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+DDj03Q/JZ7H86NZCwW9Onb7O0YE7qrXi49wOwmk9A=;
        b=Cj3u3fyDscCCSKE6Joyvz5GtznsBmLKc2f8IQdhiHfMR56viH9mpzGGvJ43bOEWjcE
         hlFb5sSeYKkiA8dy78JlXOo2uaPLfpkgIgsE/zhwjk2UFPS0JgM09doLxA+2ubwEkrXQ
         78LcQEC5t//qaidM12NMW3+Hnk7cGhAYnstFJE1PeIcq+VcCeF24q2YUaM6RxnKpDQS6
         U7BW/MTGUdT5H9ULkwixxgMXJMksVvBc23TWYkqNBYFZVP1sonKxpWIVIHwNlmN5bqEk
         cN/cYHjjTSMy5YKOi5eE3CmDArOisDh44Cup27TsRlhYCkdSyT/hRijNB+pCiXz+9yIv
         WsqQ==
X-Gm-Message-State: AOJu0Yy6s55WNFPfk0avTC6l6x5D2C4b3iJb52bU4Th7xonBgINr2get
	V37bfokZtCm/DGcrVwnOwTBbQASiCgsZrCrb9Wg2gBoy+baKliL3yWGqXz33ECyGhgVxlZkgACk
	9mU7zQoePVODHXbtuXGHPvNCpDl7XJ9RBTKlKDc89F48ebsrwYx6M/YMN5eivcqjy+Y5thA==
X-Gm-Gg: AY/fxX4aqw+Jlx7x0y+CQa19ArnxpFZkGfrn9IRhIP8WsGs9O5GpFoqFFdONly0NYQm
	q1t+mQ8FIYn+ZGXn48s7f9JKWPWIVvEVp8IG8Gvv20hAm7y1q0Ldwkkjsxpl91mMTcOb/W6imw5
	Lgzpe1zG8kVdgQ5VahY96vwvq3lNdf4YL+oeQmzDlcHevaJUTEG53iXpM/LhcW9xa38QkmFoa2a
	2eRgV0Vu8M8RINec3ieSzX9aBCYqUsoht84gB7Gr5I7cTyJ4S+/uM/qR0+Xp4k8Bxf7Hk7XofyC
	naMQtBE2YINvRTGYBYHJPHSPn2u9CGQwT25YKnO9Sh/5fCZ6l9clHscaw+l0bn4slzj6oq4ohHC
	7ErF69fwIqpE5qUr+ijAFfRomQfcNnhRDrQLYSv7hR07ROiIgxMVtXZ8Diz3d0jA=
X-Received: by 2002:a17:902:d4c5:b0:2a0:c884:7f09 with SMTP id d9443c01a7336-2a0c8849791mr139750175ad.38.1766022932518;
        Wed, 17 Dec 2025 17:55:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEH2UVqIC4y4+JuhQmcmy2peK7sD1Q/kN3Hw42zPpKYf6Jl8V2DzPluWZoR4Z07tW83cPxvw==
X-Received: by 2002:a17:902:d4c5:b0:2a0:c884:7f09 with SMTP id d9443c01a7336-2a0c8849791mr139749855ad.38.1766022932013;
        Wed, 17 Dec 2025 17:55:32 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:31 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:28 +0800
Subject: [PATCH ath-next 14/19] wifi: ath12k: handle REO CMD ring for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-14-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: dJ9mtzBeHDXsY0SSVVHpZei96Rdrivup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX12Hg6PREvE1i
 g648ofSojaW448sLvjlfl53w0bfsNTUJgdGEb6ahfgUu+RQ8JWdyT979L02UUf9NnuDSFksVDKi
 uIjezsy9gQEPVrlUl1oQbuoIk79TosLfQa2ZEtLUQdRvoSt67KRaauU9FooHfD4bUrsJwhsb3mz
 15cg/TZpKlqVVbCjyk9WE1MfceLlYlbVmk1vIg/cIbcM4MQ5fx08jvmBE/JCNn8Jh8GDIYyBe2u
 +A7/OLTth59ld7wVqm+/wk9ZlE80wJcII97iImWLZvKL0yTEhHzEwLGgEbDgQSlw4Tlw8gw+JCq
 hpesojaoV3VDapkh872iOPJjskka4vk1zx70KBcWA7O/MA8BuZeiDnLDLAzKY++Anl7ip4HccCe
 WvL7UssnHQRY7MQd0b/i6KBQMQydzg==
X-Proofpoint-ORIG-GUID: dJ9mtzBeHDXsY0SSVVHpZei96Rdrivup
X-Authority-Analysis: v=2.4 cv=A6Zh/qWG c=1 sm=1 tr=0 ts=69435f15 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=FdA_q80-M5M2ZQSmf9kA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

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


