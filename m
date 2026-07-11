Return-Path: <linux-wireless+bounces-38883-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V2ObN/qFUmp3QgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38883-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 20:05:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA6A742725
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 20:05:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=GTiQ2hZ4;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=C5UjXLqn;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38883-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38883-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34A623007B22
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB943CF020;
	Sat, 11 Jul 2026 18:04:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E723CF1F4
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 18:04:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783793089; cv=none; b=mtPbsdIOr1JTwBO3KD0g0eMkVZgjWk1S8U2Z+9P84tu/y6QSzc5FSDSQRnDoFIvX7u9YKFmEowI04BTaq8NHjjKM8hAOUEBewQjz336wAXwcNSwsADJGRmNs0bAijE9YJZe2UnF5pjO9Z8NMGgdJMqeQzI2roRfeekbK5C8k8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783793089; c=relaxed/simple;
	bh=lnV+nloHza+v8f9syCJ1CbdtDAqHJvzPBWtocjoGLYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J7CqQTMJE28l3A8EJ4vNLPOC6W7yciMJi2z6eET8ZGyr8H9m1IsnVeDaj8RGTh7/aB1TZx67d3iioRFHRALBtCutu36RhVWNMuLjH3xhCmDGxrjS4A2L/pZNHqQIK5ALhMLBX5gYg0zK+MyqzbJLr3AOzwMTQiOX/YiRbSg484M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GTiQ2hZ4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C5UjXLqn; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BHnQo9324920
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 18:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cKcR8KK5pzOF3eOQ5hGM8/
	rS27j/PhdD/hP4RutQW8A=; b=GTiQ2hZ4s3rZ0Zmf96eFHJsONi8TZx0BVI0y7r
	ljawJQ3J6hQLfhN3GmXbZ1QCrfSqa8QVsJGruTe8vzvifnAwqwZqHuiLn0JobMhk
	KQQVWAlTXkPKih63eT26oI+tE4vgMGGI07r4wQQb6GVJAByVHDyxzR4KN05OXkMn
	OgOtuuh4E5+UHm0Zfqlo0Pt/5okS3fL+QnltZfK3njp21S55x2ykqkt3g7xAPP1W
	nY3K7u6PiqZOn68mgESfR1U+OCzmZhkkQ6U7drv3XQ/ThVDPgx/qOZBY1m/xDeky
	7SNQQZq84LYtZ54bz0ygDzz/3j+KGYP78xDBFcuIpfdAqXfQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbebr1abv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 18:04:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9151bf6ce7so2278283a12.3
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783793087; x=1784397887; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cKcR8KK5pzOF3eOQ5hGM8/rS27j/PhdD/hP4RutQW8A=;
        b=C5UjXLqnfZRd+e4/5jXlzvTiGDw/lZ4FoavJFooEwbXufsTpaC201YBK4yD8K4idKD
         Cu3K0akF6Map/m1WytuY6ZMB7eZknfy0c+MZHCLnUP8C8OSE6RW/ZXpPBzPEEkbg/w6/
         jPkNzI47YvN0IZLayLnK74jjJ2kZU9dDHbeP+tIkEDJMSbp7cDaF5cu8yeZG+HFD/q8K
         wUioCsuEqw3ZZZyFJjm/i53OF6M8zWy2LpKfNtMi7MPtqDPTsJQMgEMBj74AND+1QwSB
         kTWIFO05g/SiZJvsGisASJr3/BQIyGJSRotsHy2BpPTaBa83UmMP7HO0MCWHGKqmvjUE
         V9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783793087; x=1784397887;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cKcR8KK5pzOF3eOQ5hGM8/rS27j/PhdD/hP4RutQW8A=;
        b=NknUllLUKAwicahq8QXFwe0AzhX3d6TU/X58ciUfAvy+qnGS0Q/77vkHxwGiVGcNxX
         YKmnSwUVAZl7qtHMPxZb4+ASA59s/N2lbRRV3DzRpuL+SkgIks3go3RHiq3mre+Q29N3
         zY1hXFvXX0nBGyDGr960slAC/no1VWMU/8KRJKLeHt4gFg/HbVrFZqCzfVGV7oEF9c6A
         kBt9DWX+qpTm1wlbw5dX14NnRxlcmMzDMHH9LqbYhA+IsabtHmDcb4l7diKK2K8aQKGe
         9q7zbBHxkM4H5hNvxHFfJAwBqJXtF+zIB4zVS8Uz3vAohrMD9T+LQCoxzp89OE4YB29i
         vW0w==
X-Gm-Message-State: AOJu0YxoEb3su+2Kond4cVra1nHSJXNEPEmQCrRxdTVKX6YGmMq6yHEp
	rHqAQM/gdoS6Z6xUXUceq5jtyio/2ds67oEb1yyXda1pkF/vF4DZF+wyFkZQuoX5qDIFWclJ6JS
	iA4sq6BJua+DmcjeIKc1jP8kYn8zbSqaltgXQZyXiJJXCJx9G3kQ69P78TGBLTAif8IYOT1fXP2
	Nw3A==
X-Gm-Gg: AfdE7cmj4tPX/eMslbmQ6FJ9muV6lM0gOwDVT1HUPSEX9HPEYzl+zcwfhREUSta6R/I
	bDMKOcqtx3ZkYtyXFcKKNs1554DfNvOXd6wertovO2O9ySsbB1/dgvu3SPWV9gRhCnyBIPm8b45
	er71hn/1tUDlhAdMqsdpisbpwP6wOfofWqaUte3szwZ+WhdZK+/hfu9pl0W8IzONpSio44kHJ5c
	6g/b9uJ5mdZ5CLTWObH23lH/C4hVrkmGV8Bv0YZBRIuZYowhrrFEZlfT0F8ip6qoNCVdeg9lJWO
	TBMxnAkEOkEST+dvm88dbGj6c29rHARp2DMSYFmEpfFwEqVtqsDKK9GxZkD/+EcATvyds0579vN
	YcSQiRUqxwFip7TXmWg+tD1p3vcoRB9bjukiLFtCYCD4gZ7ht2AyggR9sXihjiH72Cw==
X-Received: by 2002:a17:90b:2685:b0:380:9d0d:7af8 with SMTP id 98e67ed59e1d1-38dc7758d62mr3376770a91.20.1783793086640;
        Sat, 11 Jul 2026 11:04:46 -0700 (PDT)
X-Received: by 2002:a17:90b:2685:b0:380:9d0d:7af8 with SMTP id 98e67ed59e1d1-38dc7758d62mr3376742a91.20.1783793086169;
        Sat, 11 Jul 2026 11:04:46 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm34895356eec.24.2026.07.11.11.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 11:04:45 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 11:04:43 -0700
Subject: [PATCH ath-current v2] wifi: ath6kl: avoid buffer overreads in WMI
 event handlers
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-ath6kl_wmi_scan_complete_rx-v2-1-22dc0f7f45e7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALqFUmoC/42NQQ6CMBREr0L+2hI+RmpdeQ9DmlI+0ggttgUxh
 LvbcAI3k0zmzcwGgbyhALdsA0+LCcbZZMpTBrpX9knMtMlDWZRVwRGZin31GuRnNDJoZaV24zR
 QJOlXpgTXQjdn0SoOaWHy1Jn1WH9AKjI9e082Qp3C3oTo/Pd4XvBA/jpZkCHjDSJdumsjKn13I
 eTvWQ2JGvMkUO/7/gPdAcC42gAAAA==
X-Change-ID: 20260711-ath6kl_wmi_scan_complete_rx-a97c9cb39da7
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE4MyBTYWx0ZWRfX6FjBSfqBh5gS
 lF+Gf3LdoI4xgoMIG5Yp6YB/HiPmX7BeYFjlPaCjR6UWE4wdaIBwVmO+zV8edFlnqnk1vluwFzd
 NY3iBrnMDAt9z+6nvEwIn5Qv79UCjBI=
X-Authority-Analysis: v=2.4 cv=OK8XGyaB c=1 sm=1 tr=0 ts=6a5285bf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=2r72hCCS2uxvEu3KRW0A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: JZZYb8axNNgNQwUH7TPrFWqgZjrP5zkD
X-Proofpoint-ORIG-GUID: JZZYb8axNNgNQwUH7TPrFWqgZjrP5zkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE4MyBTYWx0ZWRfX9ShXlaWr+eM/
 JEQPAaAVh4JHuhFAgXReVvdA5e8oj0jWyWJHiFYpDzWnwk4Of1HORoa0w5sghnCz5BZixpcCCVR
 v4aEuy8rOrWTGJhz+M5RWf1sKDy67mGm7TATVd5p/rKt24iftNVibwFk80F//TelOJ65ii2hitZ
 mkmIYnRuRbA/KjDIYvk6U0i0xjjpEjauQVIeCT72bi8cHWHZ2EY/MAUL5r2YVqmzMt3H4YX0IA0
 VmnAOwlYUJau5cbSxFCyAmUbBM6sk55agLc5jBFNCY/Hkg5KDWSjHK4h6fmvVQA0ksKR0jGEdZ5
 66fzU4u+7c97HUMo0bhYrBik0h171QcGPaJHPzu2/3RnzASedVHyaelatgDKqug47hsbIs1nHWK
 7z+7dxlGdDoH3munvTyZtUdgFbTwlVZCGrfMMBlOLxfSGJLOcXbgl7z5GFHbUtsKtCgSgUScjIW
 IPqxJlpFbZviF4lmBhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110183
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38883-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCA6A742725

The following WMI event handlers currently read from the event buffer
without first verifying that the message was large enough to hold the
expected event:
ath6kl_wmi_scan_complete_rx()
ath6kl_wmi_addba_req_event_rx()
ath6kl_wmi_delba_req_event_rx()

Add length checks to prevent overread.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
Changes in v2:
- Added fixes for two more functions: ath6kl_wmi_addba_req_event_rx and ath6kl_wmi_delba_req_event_rx
- v1 subject: [PATCH ath-current] wifi: ath6kl: avoid buffer overread in ath6kl_wmi_scan_complete_rx()
- Link to v1: https://patch.msgid.link/20260711-ath6kl_wmi_scan_complete_rx-v1-1-7b11e5f8b96c@oss.qualcomm.com
---
 drivers/net/wireless/ath/ath6kl/wmi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 72611a2ceb9d..08030d88c7d3 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -1276,6 +1276,9 @@ static int ath6kl_wmi_scan_complete_rx(struct wmi *wmi, u8 *datap, int len,
 {
 	struct wmi_scan_complete_event *ev;
 
+	if (len < sizeof(*ev))
+		return -EINVAL;
+
 	ev = (struct wmi_scan_complete_event *) datap;
 
 	ath6kl_scan_complete_evt(vif, a_sle32_to_cpu(ev->status));
@@ -3352,7 +3355,12 @@ static int ath6kl_wmi_get_pmkid_list_event_rx(struct wmi *wmi, u8 *datap,
 static int ath6kl_wmi_addba_req_event_rx(struct wmi *wmi, u8 *datap, int len,
 					 struct ath6kl_vif *vif)
 {
-	struct wmi_addba_req_event *cmd = (struct wmi_addba_req_event *) datap;
+	struct wmi_addba_req_event *cmd;
+
+	if (len < sizeof(*cmd))
+		return -EINVAL;
+
+	cmd = (struct wmi_addba_req_event *) datap;
 
 	aggr_recv_addba_req_evt(vif, cmd->tid,
 				le16_to_cpu(cmd->st_seq_no), cmd->win_sz);
@@ -3363,7 +3371,12 @@ static int ath6kl_wmi_addba_req_event_rx(struct wmi *wmi, u8 *datap, int len,
 static int ath6kl_wmi_delba_req_event_rx(struct wmi *wmi, u8 *datap, int len,
 					 struct ath6kl_vif *vif)
 {
-	struct wmi_delba_event *cmd = (struct wmi_delba_event *) datap;
+	struct wmi_delba_event *cmd;
+
+	if (len < sizeof(*cmd))
+		return -EINVAL;
+
+	cmd = (struct wmi_delba_event *) datap;
 
 	aggr_recv_delba_req_evt(vif, cmd->tid);
 

---
base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
change-id: 20260711-ath6kl_wmi_scan_complete_rx-a97c9cb39da7


