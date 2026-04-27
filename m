Return-Path: <linux-wireless+bounces-35336-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CLCE3r57mnK2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-35336-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:51:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E32446D58E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10EDB3002B4C
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 05:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923CE364E81;
	Mon, 27 Apr 2026 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hiJoCfaP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EFiRHzdz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577E352C5C
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269108; cv=none; b=FCtSiEUhmQabIR168WXpfGR6dnwHI28mlMS3V8vNx4xK9C9VB0jhAeV/4iSSLezg+PqHWJkBFRWH3czXcnQfL8VEuyslDDicEoFdMfz4SpaHhW0qzVrp2RxLrXaZLad2yAEtpJZawSva5s34pFuGhGMuiKEeeNBsjY9ZCGuGKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269108; c=relaxed/simple;
	bh=aVYzllYsSYxWN7G0diW87IUqW1WtEYCfBs6jJm4+814=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dECvwcuww5UUf+i1pKESRBXy4tOJKN5Fuv/L5m1mzuwqitV1hsxENSe/axlb5P8YgBU3F154S5pHKJIa9lsZwnDLRVS3OQotG5kNPGVi9RaDCoXErSNRgaO4JxrLDYammylfq7JhLxfnLeIRbaFAGcq3wdi+Cm4aae6e524cySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hiJoCfaP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EFiRHzdz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QMoKfw1642712
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 05:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uEueTBFLq/dmQ7/anu9wgC
	NL7Oyi7zZL9qClmu03C5Q=; b=hiJoCfaPwc3RqAtNVE+iOzOTX5Wx9HHgIxgoHH
	565qErREU8jULHHUiLzyUxQmewbU/h/+LGPVO+x6gnO6CATzAXuf0WhXb/lzv2/z
	ITwJ4FGp5FO8gdYViSOwQrQvGAHaywXPwW+C0/elGVLbbh+hy/yJoPVwNVBMtYGd
	80mkEEHIFfCP0MAdZnYtDcJ8BsJA9QmtVHkqxxyeLwL34klTEJYWrWwWy3srEcEG
	UJGHVmDGwFrYGYdbqgyPfTZvWD6FwaaS/McHgGDkMmMkmpFEACUtFWghRD1nx6SU
	Jt/JarFteW5UsYhuJh4Kc1WHAlPHps/iWIy4oaNisVLRUhHw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnu2vj7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 05:51:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82fa860e71eso4598049b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777269106; x=1777873906; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEueTBFLq/dmQ7/anu9wgCNL7Oyi7zZL9qClmu03C5Q=;
        b=EFiRHzdzUXRCulAiD61f2A0MdkxsfsC3QtELwG4tl+1NcoSwe0+Wg2AQdV/ZKmgx3q
         lFWvvcXBLr9tFeagn067baPtVexxOSAz7qJk9MaQi7AXw5gvKMxpo9zWVEa+P1RlSdlz
         vYi0wasLPC/z8Xiy1EBs6EWVesL1QTQ/Rh1/jR0WbqYe6gd03ES1akjp9uWbhEdkRBYO
         SaRg9Q35pGElny2S5k7Lnc0pS7owJ//ZhbODO6BrpDgLTLg6b2TTeqh1jTGe6vQRgdyo
         Ff0NjMURAJfXyL1CHAxFA/XERR9pax3ihtlwQ6HT/1OjAiWizHCULCa4om87oJ8kFnFM
         Qwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777269106; x=1777873906;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEueTBFLq/dmQ7/anu9wgCNL7Oyi7zZL9qClmu03C5Q=;
        b=VMNhTZOnBAVVpJ/sW2vqIVykf3+kg5xyJaC7Socz5tPWoEvL1HwyuW4VIb8VPl2ZeN
         SmBGVFjpcp80ENIm4hqRRSOWSwg5kCEqrBBV+OwpVpZANaB+W1OW1Vl0prhFs2Ub1g8b
         OvqqtYuvNf8dnuxO8ordhTZBGJ+btMej5NrOXtL0PE754dqkF2r2rFv4L4o3FpKJDmch
         W2q7SKNDftLCyvwkpESud95F/HJq198agBTzhbhTi6UY19KfU0TE4wPH1kEbdi3RL3zU
         A4M9DFvKEm6eXzv1zOYC1H9SJYPtpCxEd8fz39m2qTEDtGZ/ECHiVwlBRpIm7NYPO5Kh
         VNsw==
X-Gm-Message-State: AOJu0Yyuqhf9mTO46zIQWPMl+KRt04Rd8PISkZGCk4OW/U6BUPoAN9jB
	AwBhXibVDJ+lYPYuiFcM8kWG0ZXtrhoiG1DWd52rDqlw8R4GiYCp4lqQqUO3wzva/f7AHGTp9jP
	A7ml8tn8jV9mjqMHm+zNetoxrrY/+A2RfqoMmyTxPZ6H9KqxMCyhA9Kns1/YnqSWvrJ4qrnDKHK
	XyQRaL
X-Gm-Gg: AeBDieulAHg/nFA6v/djm3KTiFrrSp6Hy21w7wsXDH5fRoyCNH9smZb863xtGZUcA9j
	7pMIg0Qe/PQIM5hydk4lF1bl4sLoU8aL1grISgdPldr2gyqGRK57BM6sgVG5qsuv1evbnrW4PqV
	BPgH0nCe2PedWZyBY+iXK+PZ87bWr3il+64DMlkSuQ3ZCuzqRFBmTHhj+pkFwyL1hz+Tt1xplCC
	67ggg2sk9Y6c1X7LS2rXWOquECIUFKZ05DKRUwLIKSA/r6mxpMPd2e2fYSlLHUtKmCSZBisM1mv
	3OPmRS92rQIi1Jjvws9QkSQCAqP8Wn7yJ/FW1ECAr9QO2RkV0UgdwUZG/cjg5kcSqAnyE+TfcpZ
	miLPTlvQXKGJAVEWaDC4SQyt9yNeyh3gedUlJyjfcWId4XvBW1V7ZaOXlNm8zJQV6hbU2ZKPRz9
	8UHqJXGUT4NA==
X-Received: by 2002:a05:6a00:2d87:b0:82a:ea3:c172 with SMTP id d2e1a72fcca58-82f8c9341f5mr42260558b3a.46.1777269105863;
        Sun, 26 Apr 2026 22:51:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d87:b0:82a:ea3:c172 with SMTP id d2e1a72fcca58-82f8c9341f5mr42260523b3a.46.1777269105335;
        Sun, 26 Apr 2026 22:51:45 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm38314765b3a.38.2026.04.26.22.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:51:44 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 13:51:41 +0800
Subject: [PATCH ath-current] wifi: ath12k: fix peer_id usage in normal RX
 path
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ath12k-fix-peer-id-source-v1-1-b5f701fb8e88@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGz57mkC/42NwQrCMBBEf6Xs2ZQkral48j/EQ5pubNA2NWmDU
 vrvLjl5EJGFhWFm3qwQMTiMcCxWCJhcdH4kIXYFmF6PV2SuIw2SS8VroZieeyFvzLonmxAD2Sz
 6JRhkouZGVlY03UED9aeAlMrsM1CNmSUEHGe4kNm7OPvwyrtJ5MgfE0kwOuIb3tSdVfzkYywfi
 74bPwwlvQxP8gMo+S+gJKDke6uaqhJta78At217AwGtTIsnAQAA
X-Change-ID: 20260416-ath12k-fix-peer-id-source-140c23f17d8a
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: z0xCil31wmuunzqkeKeloQbNDCvUspEU
X-Authority-Analysis: v=2.4 cv=cbriaHDM c=1 sm=1 tr=0 ts=69eef972 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Vb8Ow2E4jlE5h5wCsiUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: z0xCil31wmuunzqkeKeloQbNDCvUspEU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2MCBTYWx0ZWRfX98xYwag42/4D
 IJI3ZoGB5gdhBt8SsLbKXThe7no0zTeWMQYOmL4jYW45IIgpqAm4VEMO0fvXjuCaFfwOIbANDBK
 eQOdelYxwwPo78LssA+C3M21F7ljGcXB5vGjGokkdnyj/hbjFhLIcp9q8GOcnLbrBwpDYSCCO37
 Ia3etrY1FvGETissxr5z0zdKbt0tUHc1gMg2GRv7yyBIjJWiCdtzpJwwB6PAsXoRNnoF/AuazfR
 AHC/EtOT+dQ47+cA3/Y1DNtyfQrrd9EdvKWbs94tWYhZjV2p8NlUKPaQBR4k1zxuPFHjnyaoOc2
 P8r0UjO/aPP/qcY8peVGTNMvbPYMryXpOV8PyVXUCijdosunskK+spMCttcQOeMJ5LHRFvHbjHv
 zCdhk0xs5nNQulKDVKBvVQHzm6ZIHutyKleObstFoRo8JmYFTPMhGgVyYtvFdaNNVSNKCLXSrTl
 xV/0Gctylo6uRurB1gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270060
X-Rspamd-Queue-Id: 4E32446D58E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35336-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

ath12k_dp_rx_deliver_msdu() currently uses hal_rx_desc_data::peer_id
parsed from mpdu_start descriptor to do peer lookup. However In an A-MSDU
aggregation scenario, hardware only populates mpdu_start descriptor for
the first sub-msdu, but not the following ones. In that case peer_id could
be invalid, leading to peer lookup failure:

ath12k_wifi7_pci 0000:06:00.0: rx skb 00000000c391c041 len 1532 peer (null) 0 ucast sn 0 eht320 rate_idx 12 vht_nss 2 freq 6105 band 3 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0

As a result pubsta is NULL and parts of ieee80211_rx_status structure are
left uninitialized, which may cause unexpected behavior.

Fix it by switching the normal RX path to use ath12k_skb_rxcb::peer_id
which is parsed from REO ring's rx_mpdu_desc and is always valid.

hal_rx_desc_data::peer_id is still used in
ath12k_wifi7_dp_rx_frag_h_mpdu(), which is safe since A-MSDU
aggregation does not occur for fragmented frames. Similarly,
ath12k_skb_rxcb::peer_id may be overwritten by hal_rx_desc_data::peer_id
in ath12k_wifi7_dp_rx_h_mpdu(), which only handles non-aggregated
multicast/broadcast traffic.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 11157e0910fd ("wifi: ath12k: Use ath12k_dp_peer in per packet Tx & Rx paths")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 25557dea5826..b108ccd0f637 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1340,7 +1340,7 @@ void ath12k_dp_rx_deliver_msdu(struct ath12k_pdev_dp *dp_pdev, struct napi_struc
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol = rxcb->is_eapol;
 
-	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, rx_info->peer_id);
+	peer = ath12k_dp_peer_find_by_peerid(dp_pdev, rxcb->peer_id);
 
 	pubsta = peer ? peer->sta : NULL;
 

---
base-commit: 7aa24d964a04648b547197c22364e2b76aec096e
change-id: 20260416-ath12k-fix-peer-id-source-140c23f17d8a

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


