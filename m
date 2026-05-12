Return-Path: <linux-wireless+bounces-36278-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDQINEuMAmrzuAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36278-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:11:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B29518BC0
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 04:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D22EC3016011
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0DD2C324D;
	Tue, 12 May 2026 02:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V7yG1Iln";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q9dBYtY7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559E25A359
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551881; cv=none; b=O79KRIQH94++3XojKfCpNGDdtSRjICs/lf6JbQMphdtmKKVx8yGwO1uo4pGG+9blD9jMaqhxSqm3j8dij07Vpuqe6ZtjJZu4vNrV+OuTCSAKpKMtZ+zSaNjvh3LGD3ljzMBxyIrNUB1RGoM5jDLu3kk7gMz1W/e4O0RcdYeJIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551881; c=relaxed/simple;
	bh=1ix2v0x4NIueJuSz7S/KNI6Bg/+wH1m9lcEvSIuOC9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=orvt0GTvdE0QbYiWta/FTgZqDFi7XFsFNLXtUj7BgjqbEwxHai2k34MXBIkGX/bpGHEnRP47JZaWPcjyVC3kF8d8/VWxYJ0nzMPO6Bv7kU2gAwQO/IthFe+Mfs98ZI2ub7P2D/S/Vhf5cqaMjkcflL529fIopNvcG/xohpoGT8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V7yG1Iln; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q9dBYtY7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BK6kDW866618
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CA7nGr21+KK5XIbbIwykumIJPEvosonoVez
	2sxFOQ4Q=; b=V7yG1IlnyHUE1IAEIjbNBjk5XuWRO2SiWny1+ncLdSX7gOTn1c0
	7GoQORyC9x+/m0lc+AKL6yL6QJX4w/MOruzmqKKj+1Q/zlfT21pwBHA3aLzLXIMs
	9a5c8bFOP+MJY9IZjYXGmduYqtseZ5JtHafrLaIFi+xj8Flu/nl+CXCjPdZ2RLWV
	XP5kRRDRBCED6Z/1ojDRlsHqd7JmK36irGIQDISdl9mS5x+ltHvnpRDeIPmVil2C
	8B0wCz7pvZnsNGyBvDym3urZdXr/3RPoLfpuU19ncHXUU3qpQH7u38ZPEm4AB4Dc
	pNp2IF9tQ+w4CLBfTZVS9KWkGLB+0c9CYyA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv28urf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 02:11:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso54341005ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 19:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778551878; x=1779156678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CA7nGr21+KK5XIbbIwykumIJPEvosonoVez2sxFOQ4Q=;
        b=Q9dBYtY7hYX+B70pIU5FQRG9ztPOctn7g+YgNQOxgCQCuxgMUvQV7zvTpO1juQ/6g8
         qVUkjIQPb76BisfOqOl0jKNAPWCIQn2kUdZ/CRYlbtM/DlFhObDZmes97oCt5GD41rpE
         dYeoqXXVOLJ6z/r2/VO6rjyxl4OAOdT1QtDKjWKDJVThkcjDsYnwQxynIyovcCw9LPX7
         t35NNkUg7XOfGkA7K2oHo7YlTYfp87ionP5UyJs2fhG2TMVgtIsdoDPsETMI+Tqt/d/v
         aunrjirC+OORa2y2sxykdiBHRIW9ly4dbdPf1jh1Pdu3RSyKiyKYwLa0gvG5jn+SFgoW
         GAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551878; x=1779156678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA7nGr21+KK5XIbbIwykumIJPEvosonoVez2sxFOQ4Q=;
        b=HmuKeo98PWcyBTNHgX5BDKy7AvgHNBfQT6Ty0pI3uwDcAjQd9IxzlX4aSDCGfjkOy8
         ezkSC7hXBxYdg2XTOfe2TO7G4K9rdJD5fTZ6JOQMDDtHFpQU2zwch+J3uRxFb/nO/P77
         UVLYtT7f7SOXHqYyNk4UrWKhB5S2cjkZEovq/bMgtHIALjv1Db+xHEuSnBsGd6bOR/2q
         jCW2gvHaoEZRhwg2WH/0Emy5NDYEqWTx1ZfTzWxxjgs3ly+z7PIWNvbMR5T843jCQTjR
         8a3nwl68NmJQgFCcrbvfDBhvZF4YZEqImehnlJiUW6jJGJfQSxym+nXnsGX5QGv6a3J7
         3n/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+euDoUoWACbQWLAgdeeR476t0MvMDLdI03TN9qHMmmTgoxigIT4SteoZRXTHcaYs3/HFmBm02RVwLBK5XTsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvXiUZNvaayZ1OBG0IfvilGe/Ch+/LQTrxTddhPeVUL9qX3b1p
	xhGHP8JSXDICvkkN/Loj1847ep6BieFSDfokZru1ISjinO58YCKzpQU7Rgu+MmSSyZLOrzEN1fM
	mC8WvASt4dOloHZMcv2hCZUHnAlmI4jr2lSOcS8EEEq3F+Y8qpBKZqurp3MNoDAfKSJ9c1w==
X-Gm-Gg: Acq92OHztbOvITW08M6n912VwqpjqLtej12h8ZQG1GN2TwDVhhn+LTV7J1myOpOhE4v
	+5bMXdcxqy0HpFvPQs7HTkD9+29cDwWHQp1pDyx2j/wy492OVYaJsDIbDOSj8haGS7RlzM62fxU
	K+CriGc2HQP5oV6UldKBvKxvBj5gIMI6oXY8NicnzwyX/l7Eb4APotVh/FaikPOm4pdf5xJzyQc
	CfixwaVGTp8at7Uk7vknHHT7UKlHVvMWd2IfSKo7uHFXM1/sBBSqJRvtJkNroLrsPV/LTwRbADk
	CojA5gTGHtvAdiY1ip5kGTqaTZbvLINkzZCxpGQLxcZDKMkvraSvNy3NH+TmJxa2VKOpHCrgCsz
	VZ4YWuzWxi5eIQE2HqhHv+in+6l+v9OprVaCVl9Ve0BPN/kzkxXhJsNAjPajixu/aXUwmB0v3co
	HMnZAe
X-Received: by 2002:a17:902:f78d:b0:2ba:ba5c:2524 with SMTP id d9443c01a7336-2baba5c26d4mr203478695ad.11.1778551878296;
        Mon, 11 May 2026 19:11:18 -0700 (PDT)
X-Received: by 2002:a17:902:f78d:b0:2ba:ba5c:2524 with SMTP id d9443c01a7336-2baba5c26d4mr203478355ad.11.1778551877748;
        Mon, 11 May 2026 19:11:17 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d26973sm121564825ad.12.2026.05.11.19.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 19:11:17 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath12k: fix memory leak in ath12k_wifi7_dp_rx_h_verify_tkip_mic()
Date: Tue, 12 May 2026 10:11:08 +0800
Message-Id: <20260512021108.2031651-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _4IV1tsRgAseIzUmQqD1U5SRXGsvsE7k
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a028c47 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=c7r0Upnc4xhSCq5Kx9sA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: _4IV1tsRgAseIzUmQqD1U5SRXGsvsE7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDAxOSBTYWx0ZWRfX57A+p/PBJhzy
 9HWLgFz63BhTYq3hxROFvHq9k2jTDGwq2PlfDUKJqLZ2z+X9mbuhCeVMhLg+j4JbaF/xoP+CD8Q
 VLlL1SSESWMeS8+CZoSbht0K+Qd54KbHBhBu6kugm0Cn4Tm5DkI/y1Wx1NLeUFXxoaa7VH7CGoU
 FHY0eyaLDco16Ze2jsnCyDQpxsPM5StjocbNwSnr9ukarPDvFO86TzbRqcEdLX1mSIpG72OjIdb
 6/zUSqhNgv66nRiISiCckmlfu54hPZKG69jX6XDaSmwqI0zW1y1ITrIQASlNt8RH4Yvo3VuUd5E
 UsPnlA1wI+T8jML0FpmEwoQZkGU5VAsqiC1ASzFQTZFCr9lx/3bt9iP9Vyr5NDISCpgpBX80ePi
 MTLQYsZzLP5FEUq4oB0if+acW7VrWYG+xippgSIrQNPDDWplEjL2wJ3ysKtXxqbHBcD9fz8GjC8
 zGBKsOuKt8YDdyuajmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120019
X-Rspamd-Queue-Id: 70B29518BC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36278-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

In ath12k_wifi7_dp_rx_h_verify_tkip_mic(), the call to
ath12k_dp_rx_check_nwifi_hdr_len_valid() may return false when the
NWIFI header length is invalid, causing the function to abort early with
-EINVAL.

When this happens, the error propagates to
ath12k_wifi7_dp_rx_h_defrag(), which clears first_frag by setting it
to NULL. As a result, the corresponding MSDU is no longer referenced
by the defragmentation path and is never freed.

This leads to a memory leak for the affected MSDU on this error path.
Proper cleanup is required to ensure the MSDU is released when header
validation fails during TKIP MIC verification.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 9a0dddfb30f1 ("wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index 945680b3ebdf..a5e290edaa89 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -1028,8 +1028,10 @@ static int ath12k_wifi7_dp_rx_h_verify_tkip_mic(struct ath12k_pdev_dp *dp_pdev,
 	skb_pull(msdu, hal_rx_desc_sz);
 
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(dp, msdu,
-							     rx_info)))
+							     rx_info))) {
+		dev_kfree_skb_any(msdu);
 		return -EINVAL;
+	}
 
 	ath12k_dp_rx_h_ppdu(dp_pdev, rx_info);
 	ath12k_dp_rx_h_undecap(dp_pdev, msdu, HAL_ENCRYPT_TYPE_TKIP_MIC, true,
-- 
2.34.1


