Return-Path: <linux-wireless+bounces-26173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150A2B1C4BA
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD97A4B81
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D18723B605;
	Wed,  6 Aug 2025 11:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NKWxYMr3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CE424293B
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479092; cv=none; b=ueLqZgOMzqOai+78ikzSGJfrETj1BaZ0MChoH46gkUn4Wb2uktt1C4u5CLCzBG3RCN6ehulfLVrCiFj0C6b3YeROcxmp64CyolZRDhBBGC3u2UOteNy91PW9k7r6elAQ6zHi0uruUUgOy16Fnzmr6pPpZsMwoeJjb3WQQC/Cg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479092; c=relaxed/simple;
	bh=rrRHcRgchjh628nwbkyYulSyMRJeOkBbY+GO4c+oe9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=M8E1dLnje46OO5bNIY9HmDkap4JwoFLj4gWZsJNPomrlwsLUimtIAetBDNvoUpGo5IYltsLstCW7kYtQaH78+ngKGt7XNZ8mWq7DpjOgwOrPGQzNVf/ZSpiAV4tdsNE5U9PHrsTBDsC6jE1hlG5cuBGJgEA9JplVmqKAyoDxRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NKWxYMr3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5769enXk032281
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=tsVxbWsi9yU5onJFXklKXvkbsfDAqBzddlTUDZvYW/w=; b=NK
	WxYMr3rkoqJiGNmJEkdapZDXCk7R8RK8R6oectnTGDTrjinBnYb0/xNl3xNVSvLX
	HWDJmVmcHbXdjbUxRTW2fGAuIex9WsKZHpf2n9T9Tf5WDL8g/OFhZvGq81C3l+vo
	PaqCRxacKhi+9w2qeBIbo6pMaBpvMGDmXFT3F5ILeSGfHbF0MiHKnHvavmmPDswF
	t2CgcjTaUER+QAUZJ2xGTMee6wAM9M12NgX8zofYEq8pYImGh7609FSUna06P2Fa
	hrYyQ9ci+Pj8KbN0fGyFlTBudbrH9i97HE8XhrdRI8gD6KEoLMwguu8MrSWNJz8m
	aXhhCvoAjlGLXvVVDmFA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpw2tjxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:18:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31366819969so8034567a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479088; x=1755083888;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsVxbWsi9yU5onJFXklKXvkbsfDAqBzddlTUDZvYW/w=;
        b=UrCB3BXu3e+bRzGclfcUQt0Xm/N8bzUJrtF35gAmkyYduSFOovMGnITvjkEVaJlQPK
         zzAyxjJpCJ6ewkdsYz9KH51VO+TMmCUscGeu6PIHCmTsqnTqdHGFROmCdX2EOufV423C
         vp91ho61g1awvuA+KjF07tWHujs148HCOfHAUQjQb52Q2wXjXt8ukx8OICGAqzSAbXOP
         hLOve9DKjBoH6CY/0o7rHRFoiaytP5r/z8gfingfA/4QFzT+KQb7i5vF31XF5JM2RzPg
         BYo4l40Kf5ji91WS5++eHQqbb1KK6tRWUYTlKzeAfhKGRXSKrkfEJ6t8kjbRMP/qRDnv
         tLAA==
X-Gm-Message-State: AOJu0YwZJ2VzVDCK80ZPJoi5wr3uSjscJTSnXD+TPL6ZUvDEHkC+ccdY
	zuzEDi2IP1U+nCx5qdMzA5McfsLlWMgfcdahMXf0z4pln3ajO/1U4j34IJo1bhVKQtjBV0g7jDj
	XlSwCK9o5zPuH8KR+S7kyEZfNOEYuyqb6ek51VbYArVndLJsG7pR+nBRfTp0o4tZDTmB+gQ==
X-Gm-Gg: ASbGncvX8WNZ7mLWFbOWm5vl062a84sa3d+Z4e51vxMW30nicTDrBJhH/tdIg4lWOKs
	y6hvmeSIoD2sqt7I+4VJmuWREp9NcuUHuB0sILi1LITDZP6OA68rhN6+UaKVAnX1NuAts/lbVGl
	Iu0Mw0W6lsKt8OWvnfW0/rYV7X41zspM8Dpypbi51wqGL3sWIfwfQkGLNWqfKqmPjf5JDK9bo1O
	8fBRP86xuGhm+k4cqTYATfbzuW/xXONXCFzf8qE336L09ajMpBdwOfNQxWlwy3tSvWmZ3WhHdKN
	yqcFslSMKh1TjXzOvA8XI+pObfYllDFjayoGttU/X5nLEes08xAjPr7nFmc6HMMle+NoCHcIh9v
	EPZH0o8+XWMLsMY5vDT0g5ywXdRFj+Qj+PsDNRN0tKw+IBIPCPOlJaj0/OyE9RDBq/noDnNCs4w
	==
X-Received: by 2002:a17:90b:4c92:b0:31e:beae:2934 with SMTP id 98e67ed59e1d1-32166cb7261mr3490738a91.18.1754479088283;
        Wed, 06 Aug 2025 04:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw6Eec6QRCfhfi3aEeaCBICThkBWIxtHVaW7RSdSxCqBa3CbMIuxk0q1NVn0GASHQLX9jSSA==
X-Received: by 2002:a17:90b:4c92:b0:31e:beae:2934 with SMTP id 98e67ed59e1d1-32166cb7261mr3490708a91.18.1754479087874;
        Wed, 06 Aug 2025 04:18:07 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:18:07 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 6/7] wifi: ath12k: Fix flush cache failure during RX queue update
Date: Wed,  6 Aug 2025 16:47:49 +0530
Message-Id: <20250806111750.3214584-7-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Vbz3PEp9 c=1 sm=1 tr=0 ts=689339f1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=iJxYE32BEC57r-YmU5AA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: ZNFpHdJu7tfVdDNl3blSndW3bfriizq0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX3d02Oa0Syr1c
 DitM6/gW205OjA0UlxR42xein5I+fHBQXejliMZFU4ZEEB7fzp5Waz/XW+HFlFLmypWRk3Ut7Rm
 J7mgFnU6NgW7+WKOO5mKyBPJnt0m72jtvbAKmDrpPYstpn+4OZrRKWhBxRnVkO+Uvvyf+8N6NOX
 5wjr5MpCEWxcyB34lAy+zbCiv/dU0Tr6G43lWFfr6eK+kSe8BqScTNqfCeO+MRJtuzZhEAHN4kr
 +MMTooet8HBlDQKA21qIbVJgn4BYJAUmzkqSA3XyO0UUZP7Ki4Temw1AB35/0ccm9CXRsgZPsn7
 yNWgqwgwHxE3aa7m9V2uk1ImI3xlz4jj2sAsqsjFkVONimHiOvgh9WZfdRp+2nojYg4U5WPb/1X
 TXW6Fk3G
X-Proofpoint-GUID: ZNFpHdJu7tfVdDNl3blSndW3bfriizq0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Flush cache failures were observed after RX queue update for TID
delete. This occurred because the queue was invalid during flush.
Set the VLD bit in the RX queue update command for TID delete.
This ensures the queue remains valid during the flush cache process.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 9a62ef52cd6d..9cdb7cb03e23 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -850,6 +850,8 @@ static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
 	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
 	cmd.upd0 |= HAL_REO_CMD_UPD0_VLD;
+	/* Observed flush cache failure, to avoid that set vld bit during delete */
+	cmd.upd1 |= HAL_REO_CMD_UPD1_VLD;
 
 	return ath12k_dp_reo_cmd_send(ab, rx_tid,
 				      HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
-- 
2.17.1


