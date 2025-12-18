Return-Path: <linux-wireless+bounces-29876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDECCA054
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1541B3067307
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A827280F;
	Thu, 18 Dec 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WC213rCr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E3Qw22C7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9481271470
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022938; cv=none; b=Mpby1PMmIrjFD6UIo6+ld29Uw5QRDdBpPMXHnnC/Q1lBDW1YtIhrd55oJNy0hKAME2Fcc9OEYudokmsM0plb2CM5UBRV84Az3hVnSmEghvt5/glDqndAeRZw05z1LD63K/FrpxUVY2GmvGvQ4d+9t202M2r1h8/64MUQWF+I9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022938; c=relaxed/simple;
	bh=7mTvMhkFhO2X7+DVV+/tKSoDtreydHi3IoZQV47YXvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJvZeKiukeSbx3cxG5Sq7CLGTaCJftBiUVnfiJEk7aqji/ATE+IqScKraGT0uVkFFfvG9Uepk8P7ugvdw5MkEa0pnGJ8r6oJoReMhtQXNC30LK4Sq4m5Qc7A0rKT6qOEWlJUI2JF/TtO1olK38T+hT0qKeH/Gh63GKwIX/LEOF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WC213rCr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E3Qw22C7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YZ6M174300
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jZvo/PgqxxzPt/YAqJn18tnE7p169uzy9Tl+w5hbSkY=; b=WC213rCr6tb12V10
	d861Fd+JpKoQm9Am8XCQGYOTX2vDkWKh5Wk3dnSABZD90Ttajkmon68m4tlRm7kl
	1xsmlhGxM5SEObveRzeUgkn3M10Hz9A6cE8rL3jnmtS2PpuPjhDWWzvuXkoyUl1l
	JHIKMMV20UvHZED9y1PEMAS+rOe2ItWBqcBIpt/j4pbc+gXXIQ7NBlen3wNQb/Vh
	4nPUFZbc6Y9yoYYrnyDlTv+odhg42+JqIaGeCma8fOEo4L3ZCjhZaGsPSms27hSM
	JnNQfU3Lh4n8gTGCjvDKJOZS6Wsi/QHMaLJvpvlpltTYqGBgAD2RCreAB6z6IRvg
	syW0VA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43nmrqs3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0d59f0198so1937195ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022935; x=1766627735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZvo/PgqxxzPt/YAqJn18tnE7p169uzy9Tl+w5hbSkY=;
        b=E3Qw22C7rSUddcAX2kuYCvvBsLuk1fAJ+xTyshoFfulW86eVjKsjM/DUaGDkvsG8IZ
         I4f9xvf76lqGEu3lRYf8+18xt60BzuR8llr4xzAfr2ePvF0fP9D87wnZV72JK/Ic5vmK
         83g//0PURFSBHBPjkQbYlu2EL+J0c/wKaFmPBXhqnuwCARq34ACxa4hTJJHnPmyD7tWe
         4tu6ANLpPpXjPOknrqddtdBcNN8ifph4Tg/Bw1yin3PcGMUGxXzaTBK3YqgyLxzyYJl9
         xugtW2gEZPoYhNbBT6NswT0eb27zn4lwvz2yq55P8kb3C/ScLaQ5rIpbPBIoWr9f1AJN
         9hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022935; x=1766627735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jZvo/PgqxxzPt/YAqJn18tnE7p169uzy9Tl+w5hbSkY=;
        b=VV71Bg3TupGg8gZm1nN8P5PJIXCY17ettic3BtgHWjbvZJ3OuJ/tW0930mruDg04ZK
         ATl1Y7GfeA/3LixXZQHIqUWojWzWi45aeoXQjNSVrltKQCMaFAYGWK0cJ95hU5wDwjKv
         Okwwj4Jbt4LwoS+HyFKPFnrh+58c2Id0ySheKGif6AdoK8OAmi0Mx8CFa3zBHkDXbISD
         kc8UikASnYahIrvGgL0ObGITW1WWE5d8wM5aM5kapEK6vd0a5aTXTxO+FAjynKj8+qsv
         xOr6FEztB7IoU5rRRx4My8283fWXpc273xF17AklcXWfK0RyF4lFqjx2ZkrxgBRfCHZO
         9RLA==
X-Gm-Message-State: AOJu0YyDj88+TFHmmSi0mzf62kiJy1KmKREhwj8QuB/M1N3xDB/oI3/z
	jxajYgfpwkzw9F6st2264QWEhs1Iv4yiaCiy2PEUs35rnjoO0z96RrCOjlUaEJfEyFeYWcj8Iv+
	9luUcS3W7O4O+qaZOvFokPu/i/f6ixrzeKoO9gpeTfXBTEY1YjjcejMpHE+pcuWJrvmfT6NKDDV
	7u4xUA
X-Gm-Gg: AY/fxX6sJkcReYm74zhuNe6TJvFtHnb6hvEH7oZBe4hnH7MMTojaDs8bELTBFkTh1gm
	kdMDZw1mgv6thM2wb8Zi1y3KLLn87naUv7Fp6i4lrpZL8pqMixXwvVjtJngE5jPGur/5hja7PFb
	fVb+hoTCFGXdMLnQUvHHAROsm8GP0XGOCGkLo6GWuuOvKQMHg0N+kBZael/uS0rxKfhFgzIx3vt
	IGbs+4pAPIkpZt8OEfVfQQDtSHhAVEsaYIkIhTdmp5w7cLkgSERdFnvnfG0QTysev8ykPtOJ3fE
	4W/bC1B5paQvvR3QhUUz5B4qHH4LaiJK80ovbvU/CvMzUiRIKkrZRh/CSwAvmmdWAeRt4NcZ1xO
	HREN+eJiGndtTEcrkhmbmKA5ukQtROuLdSC+iiQfdrEaLw/NTakRsflOwTDlqDwA=
X-Received: by 2002:a17:903:320b:b0:299:e031:173 with SMTP id d9443c01a7336-29f23c7be2emr224283005ad.35.1766022934672;
        Wed, 17 Dec 2025 17:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ1T70JdNTucTwb5NwZg/55VozzIfHt+1/wLS4kLIzpPnRuTWhRR2DZjVwA/ZIzEkpdccoeg==
X-Received: by 2002:a17:903:320b:b0:299:e031:173 with SMTP id d9443c01a7336-29f23c7be2emr224282655ad.35.1766022933927;
        Wed, 17 Dec 2025 17:55:33 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:33 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:29 +0800
Subject: [PATCH ath-next 15/19] wifi: ath12k: handle REO status ring for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-15-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: OjRffDFtETpPKWlwqVtaJBoNzKjalBJh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX16o2XApyAl4X
 3GVCiDIfeNbSaPqOqQ2m8Csu1ths4iVCnBQXbMyBVNM2Hejs1IStO3k5ggF4KqxQk5Ls775HO21
 Osjzy9CJ318g2QCMXkepsK22te25vqeKatXOi5KXAnJybdwiFtLyYA1irgD3zZuCPEfmPlb51AO
 uOG178prLrb0+sch+Ni1OC2uSJJHbNVPQJaRoOI9PTDNw7ysqb6ClJ9zUq/TUTSwM4USHNZYWSX
 liQ/p67q8Wf4QGcvCDl6KB3fouOBVg/MTQBVAYWTY4VNG8rE9XgkMwZoNz+UStq0GfGEzpflE2T
 +ty8DCx6LNuQio1FvnRgrZLG1Kh77mhZGBCwfRgb8hVL98H2UYWf2YL2J6625DFJ9ioO2rtdSdj
 EkiGzyxmTPqqfmPE3EmsZ31M28xD8Q==
X-Proofpoint-ORIG-GUID: OjRffDFtETpPKWlwqVtaJBoNzKjalBJh
X-Authority-Analysis: v=2.4 cv=A6Zh/qWG c=1 sm=1 tr=0 ts=69435f17 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gK-fc3CfFqufNovLaDoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

For QCC2072 below REO status descriptors are different compared with
QCN9274/WCN7850:

        hal_reo_get_queue_stats_status
        hal_reo_flush_queue_status
        hal_reo_flush_cache_status
        hal_reo_unblock_cache_status
        hal_reo_flush_timeout_list_status
        hal_reo_desc_thresh_reached_status

Take hal_reo_get_queue_stats_status as an example:

QCC2072:
struct hal_reo_get_queue_stats_status_qcc2072 {
        __le32 tlv32_padding;
        struct hal_reo_get_queue_stats_status status;
} __packed;

QCN9274/WCN7850:
struct hal_reo_get_queue_stats_status;

Besides, QCC2072 has a 32 bits TLV header while QCN9274/WCN7850 has 64.

This means that there is no difference between these 3 devices in layout
of actual fields, because they all start after a 8 bytes offset

QCC2072:
	{
		struct hal_tlv_hdr tlv;
		__le32 tlv32_padding;
		struct hal_reo_get_queue_stats_status status;
	}

QCN9274/WCN7850:
	{
		struct hal_tlv_64_hdr tlv;
		struct hal_reo_get_queue_stats_status status;
	}

Therefore current implementation luckily works for QCC2072 as well.
However it leads to misunderstanding, which should be avoided.

So add individual REO status ring handling for QCC2072.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c               | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/hal.h               |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h    |  5 +++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c | 21 ++++++++++++++++++++-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 5ce5e0f89ca8..a164563fff28 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -857,3 +857,15 @@ u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc)
 	return tag;
 }
 EXPORT_SYMBOL(ath12k_hal_decode_tlv64_hdr);
+
+u16 ath12k_hal_decode_tlv32_hdr(void *tlv, void **desc)
+{
+	struct hal_tlv_hdr *tlv32 = tlv;
+	u16 tag;
+
+	tag = le32_get_bits(tlv32->tl, HAL_SRNG_TLV_HDR_TAG);
+	*desc = tlv32->value;
+
+	return tag;
+}
+EXPORT_SYMBOL(ath12k_hal_decode_tlv32_hdr);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index f322000e8ac9..520587305dfa 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1546,4 +1546,5 @@ void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
 void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
 void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len);
 u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc);
+u16 ath12k_hal_decode_tlv32_hdr(void *tlv, void **desc);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index c4c7ca9ee827..e1ab47b44433 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -2439,6 +2439,11 @@ struct hal_reo_get_queue_stats_status {
  *		entries into this Ring has looped around the ring.
  */
 
+struct hal_reo_get_queue_stats_status_qcc2072 {
+	__le32 tlv32_padding;
+	struct hal_reo_get_queue_stats_status status;
+} __packed;
+
 #define HAL_REO_STATUS_LOOP_CNT			GENMASK(31, 28)
 
 #define HAL_REO_FLUSH_QUEUE_INFO0_ERR_DETECTED	BIT(0)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index 0ae5b073287a..ee2427fadfc1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -425,9 +425,28 @@ static int ath12k_hal_srng_create_config_qcc2072(struct ath12k_hal *hal)
 	s->entry_size = (sizeof(struct hal_tlv_hdr) +
 			 sizeof(struct hal_reo_get_queue_stats_qcc2072)) >> 2;
 
+	s = &hal->srng_config[HAL_REO_STATUS];
+	s->entry_size = (sizeof(struct hal_tlv_hdr) +
+			 sizeof(struct hal_reo_get_queue_stats_status_qcc2072)) >> 2;
+
 	return 0;
 }
 
+static u16 ath12k_hal_reo_status_dec_tlv_hdr_qcc2072(void *tlv, void **desc)
+{
+	struct hal_reo_get_queue_stats_status_qcc2072 *status_tlv;
+	u16 tag;
+
+	tag = ath12k_hal_decode_tlv32_hdr(tlv, (void **)&status_tlv);
+	/*
+	 * actual desc of REO status entry starts after tlv32_padding,
+	 * see hal_reo_get_queue_stats_status_qcc2072
+	 */
+	*desc = &status_tlv->status;
+
+	return tag;
+}
+
 const struct hal_ops hal_qcc2072_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcc2072,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcc2072,
@@ -468,7 +487,7 @@ const struct hal_ops hal_qcc2072_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv32_hdr,
-	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
+	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_qcc2072,
 };
 
 u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcc2072(void)

-- 
2.25.1


