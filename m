Return-Path: <linux-wireless+bounces-36131-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB7SMcmj/ml9uQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36131-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:02:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F6C4FDCCB
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D6D301D6AE
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 02:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C472337BE6E;
	Sat,  9 May 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jeFLZMvo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S+Mz8Ebg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D837CD2D
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295573; cv=none; b=ogXOmPys9iWCHT1z+EiNaq9+rcmUQA/pamCTj3EN8VtRR+iyknWSu/vnA0A9FiE4Y5H8m7YRZuERuy5Hs5GisArDVn+rfMv/XNNqqhqV9Rkhtuawm8vAG0+8W8s468nM24z3cyq+GUfXLkFtCkhQi+vogs2xeugVxCJtQsJS6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295573; c=relaxed/simple;
	bh=5HuJkt7QZUt61V+AOH+qcrZ/T1KhKZ34I2bVa5rdHak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jRc6xem0pGqozRNEYAjHIEn9q1B/bWPaU6MkfHYt27RnI/cx2bH7EQ9xLhmbN2AWoB4FjqlPJWDC15rmaCzOyxU2ORiV/JF/6jFX1FJL/fWU2UpCLpXVfQos/QbLisCrO1jODvKdR61F3h9umXKShWCnoAbGBr3ktxNI7oUL0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jeFLZMvo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S+Mz8Ebg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648HdqZv874117
	for <linux-wireless@vger.kernel.org>; Sat, 9 May 2026 02:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rV/ieMDnbXj
	j5KK/swB/oQaY+V1P3A2uOWUDsQmGtmU=; b=jeFLZMvoY5L+SN5melJ7Pofcw7l
	PDFns0BRSpMkAMKm55YT6lv5R9PbjoYUW0CSIaaoz0WMuC92cRNfj2D1fhfzmKDy
	qS0l/4TKpzYpUc+G3CKBDvej51jKTFamVAib7J9ITNvuNJfkSC3kccbbjoQ1s33I
	3VhgnQVVuLnnk+3onnc06cbRPFKD2zdiotyVD8yhwWSPBdWem25sT+Nsvn6l4wNo
	97vjaKjqeq5vv3n3EYk2XCrTRafGf8LD1v7HvCnyYilpch9jDUQo0jcXgAax9RlB
	MrriXWXrlK5X3el4p/FokOGnmDNMFOZVbVPe9F1nphQv5esFQgCSVYv8tqA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1me81bkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 02:59:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36629e48023so2818671a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 19:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778295564; x=1778900364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV/ieMDnbXjj5KK/swB/oQaY+V1P3A2uOWUDsQmGtmU=;
        b=S+Mz8EbgFxZGZDZoGYUIf4QF+XMSDPmvF80Mh1sL7ThlM7vK0XrT+nVhyQQr5b4QVA
         Ni1gHm5/srm2E03x+R96gf4K2F4edxI4CQPUoPNp5boxf+li4qTyBMzAXKUWH3pjh4fT
         YhUhff4vGs012pKoYaWrUmxPVtWSJ8soWEAGD1oUVPHmF4LABNrN0CYDgTI5jVwlCD19
         63NcZxuGSlQ0zlQ7ARjdbu23XZu6ky0+m3vv8Z4lmStvJaOAESkxYCqpCNmEih68vMGe
         TDhY/DqN1Q/zVH4batm6Ktn664m/PbuDprj6kfvbGSJI0Sa4MGwnsum1ykNsjUL0Gl4T
         QI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295564; x=1778900364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rV/ieMDnbXjj5KK/swB/oQaY+V1P3A2uOWUDsQmGtmU=;
        b=ZaSQBSNIUE/G70Kdut5U+PXU/fennctZ9Ukee7RBGWxJVmcpI5X7l/KIs6lguQcV3K
         jrSuJbm+9b3BuCcu/1pEJFoBZYyZSjUFO63tHWXaAtaoh6z4OFalyqboeUSze6Qfy7Xn
         Bi/ntfw8hnlIut2/SQPin0o0DGAD+Ajnhcr0JX8tYQNlHSTesXMmu+vfoNd4+6rj+TW8
         B3FQLLm0/JY7lhWWIlj1zN0MIK9cMKLcNU7LDkNd7Zeov0rlZclZBf0pSDYYVeixoThI
         x/y02MmziwLzYN40kRJRu+Q2VoIRxAuj5BxlRfkOU3vwLEjAzwcLo4X8w6NOB2pHhFhb
         SgPw==
X-Forwarded-Encrypted: i=1; AFNElJ+7C5h44/oli69HzNPjIQTbxFLwjZt8ZmNYxlA59hUCKHDqZn5FgpOTwA8CkQiANqlJQY0awSGWzq5p8Z48/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDTQW88PJK3pt5h+Zwou2R0/ALOJZvkZHpFfodRBZx+bQeC/3P
	0lEqk4ot6O7rS1nBk64gexxrRRo0NyoBogi2MuRvJ4QxZv0MijnCBaMms1FpKLlsvK1vGHaTDJD
	Gq3MsQYvQ+Q5GQPwVLkS8cLeKQNuDpkRHX74Ky2sHhx9kyFBIgu3HzRRLzNqg8WpWl+2w0A==
X-Gm-Gg: Acq92OEmwUxCK2Rnu6ceCiKhqHXBfDIZM+9hZ9b/x39hCMFU8HWv7H+yO88O1NlI0jW
	euRGZ28gpmbHquxL/DVKaN1mah/Y8bQhTQQvp88683wIYg+GhxyjYZwLgDLU6nk/2C18BVDUqCv
	dotwOh3BHoW1RbQbtc7dN+VwuAFYKyQkcdcnehuiqvhQHE79IehYT/tIDBysadewP8iM51qTjbC
	5ZZd/Ra1pgukuwBEXWLQbY96zBji0cBabK7NMIAOzzM6KnDgZKhEdaNbyvK4nmyUz1ypnIiUe82
	9q/IKfL9Go7mR5vPe7kboUDFb+OfCvDhKVkuQSi2DMcvoNluXKazP5vHsJaElGXWnXxMi1PCskQ
	F54zMOLoFxVBlbJVYuWtrQfbNzgAFYiwkSpwt11WQLDEuYVgtW9OOwgha0qZ2FG4VgGrbfzWcEE
	PZl9K7
X-Received: by 2002:a17:90b:224f:b0:35f:b714:e516 with SMTP id 98e67ed59e1d1-365abe8a2d4mr15400037a91.16.1778295563723;
        Fri, 08 May 2026 19:59:23 -0700 (PDT)
X-Received: by 2002:a17:90b:224f:b0:35f:b714:e516 with SMTP id 98e67ed59e1d1-365abe8a2d4mr15400005a91.16.1778295563184;
        Fri, 08 May 2026 19:59:23 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be8be938sm750899a91.4.2026.05.08.19.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:59:22 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 5/5] wifi: ath12k: tighten RX monitor TLV bounds check
Date: Sat,  9 May 2026 10:58:19 +0800
Message-Id: <20260509025819.1641630-6-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAyNyBTYWx0ZWRfX1pXCxGhByrOy
 D4NMfzFdj9ZK3mBGi4mgHDc0r2KS0aSsc1tQRHqnkM3MO5qK8PNUWts0v54lSuynFqrA2xehLNu
 UMxrazU7Afp7waYTs6cI3vkGl0H1icZOvAgIOpFbU2Yz8vA5+qsF8Kbh5t8RIjZSL8muS/qWfaA
 rUdTOiujQB1WGDrB2dRlFqYsKJiI34v6cfMOFLF2mlsShR9ciWFclWthjgbjIGy/8rPJmwQeG8o
 FePLCw7XBN5t72xddBM9aJK6MsfK6cWB77Rn3Mx8IUv2bmVZ3dJEN/gYFZQUUl9oDZq+lkZrJ/3
 qG6vbPI2ynWPoCwNAzKZV2sbs/iYMFlO3Nci4MKdO5hHlsINKtulpBFUTtWf601JQdsm4/sut+S
 SCRa5ucrD2jRiR84+x/AQD9N06PosvKVtmNAivxblrvCJV7moeTAfFsiEpkoSMdXpTbGoUsbuk8
 XyLmkhOzujLnkgUTqfQ==
X-Authority-Analysis: v=2.4 cv=BsKtB4X5 c=1 sm=1 tr=0 ts=69fea30c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=OJgDPCsnPsfhouAcpvQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: m_wpmVcTo9Bg1rmYHf29T8XBS3rOEMIa
X-Proofpoint-ORIG-GUID: m_wpmVcTo9Bg1rmYHf29T8XBS3rOEMIa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090027
X-Rspamd-Queue-Id: 24F6C4FDCCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36131-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Validate the pointer to the next RX monitor TLV more strictly by
ensuring that at least a full TLV header is available within the
status buffer before continuing TLV parsing.

Prevent potential out-of-bounds access when handling malformed
or truncated RX monitor status data.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index 4266bd1d0d3d..23ba0cc824a7 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -3006,9 +3006,9 @@ ath12k_wifi7_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev,
 
 		tlv = PTR_ALIGN(tlv + tlv_len + tlv_hdr_len, tlv_hdr_len);
 
-		if ((tlv - skb->data) > skb->len)
+		if (unlikely(tlv - skb->data > skb->len ||
+			     skb->len - (tlv - skb->data) < tlv_hdr_len))
 			break;
-
 	} while ((hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE) ||
 		 (hal_status == HAL_RX_MON_STATUS_BUF_ADDR) ||
 		 (hal_status == HAL_RX_MON_STATUS_MPDU_START) ||
-- 
2.34.1


