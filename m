Return-Path: <linux-wireless+bounces-31644-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIZ8NP9LiWl46AQAu9opvQ
	(envelope-from <linux-wireless+bounces-31644-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 03:52:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3372910B3C4
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 03:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB67930056C6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 02:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1995D29B78D;
	Mon,  9 Feb 2026 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q0fqixNe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNRFC+Oa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C821DE3DB
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 02:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770605565; cv=none; b=Og36G8YuEVScnD1u+iQFznaOIbwJ+G9/w5OxftfT26iK4/Ww23pzsiHw3jbIE9B97pUhFYdunKXGTkhEgApjlEjFwz/71caJt/S4pp6zgtcYrmNAzZ6sbT2pnTCl76pEK06wypMLTOn7CWI8uuj0GPj2VSFTH1BUx4SoyxJPNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770605565; c=relaxed/simple;
	bh=5Sr412QftFqCfQXgLjDGJJ2rm3KqaBFQy2lVwaulOvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UXVJt587FvYEGKHmcbK7Fdkh89Z9O8N2MtwinU07x3ozNfR17+wHKwJ0+Lqvaw3Zrsk8cTZSN9Ix358geXVnsbKGWcsVzQdVxfKmN/rYqkTFg8ZvGCHB/J4jEiIzE3nAd4Jymh6PnW3CuzPI9W97PMjPB59gzQOdRsFok84Vfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q0fqixNe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNRFC+Oa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618LEpCw3032791
	for <linux-wireless@vger.kernel.org>; Mon, 9 Feb 2026 02:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=205OA5oxq0O7kM0cmJSQ6t
	22RiwN3B+sfSfh3ytC27M=; b=Q0fqixNememtMIj56HlQ2kDRGjCG5iaYjUhLMY
	JSU6o5QPJjNX1gfU/rJoQcKF3yg321CxeAIR9yYKcvpKz4gtJ+nOwMBsXxQH5ozt
	cXugQ0d62RNRhjTLnZO+Qbx1S92czvWSGUM4R/PIK9CoAHdGoIBHYW7H4Cd67Eyw
	8JbX6WsnO5lI21S8W4dRy1qJCyVmlzhXvBIXmZ1tG8vXDVRDf8MUyPIREGPVTHGs
	amOsRbz9xIMh7BJ3QuRmprkQO3d3nbeavYR6fATeIM1/EQWeLWgVi/Tt8NUnk6Um
	tufxFEN4V3o4NzzuH9wFYh+1UsPwTR/ihZxeccQv6430dsvQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c64hnjuts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 02:52:44 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aaf2f3bef6so4267605ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 08 Feb 2026 18:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770605563; x=1771210363; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=205OA5oxq0O7kM0cmJSQ6t22RiwN3B+sfSfh3ytC27M=;
        b=UNRFC+Oa+J5s5mrS/WeTr1jD6qlE1bpNE8rXYQo8YXQdw9ZmxjapToEkHLwJrSu6aP
         uMANoEIk/lZMuhaVE2AL6z2pgve7n+NfZzAfv5Ee6ZTuoeHZYHl0up+TCPVxCdMhJp2Q
         rfap58JJPSF0MfKxR8yonmlmcLBmTzKb+CY1Tg65G1IEcuu1J/Dx//goYjX3zKNckP6r
         S0XIojwzS/ph/mIortYKVMyDn+z/EbNhvSy3Otjk+dnfo4uPVIxdVRDWYGIWOfxDWutC
         F4a2GC+sd+RDXHGSdNO0aeTFrbGNho+85gLoYLAfR2UeFddKDRKLckiKzjprWKs9y9UY
         WH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770605563; x=1771210363;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=205OA5oxq0O7kM0cmJSQ6t22RiwN3B+sfSfh3ytC27M=;
        b=pW78XvijD9OP8qePIroQpsKzB4Ptqyn2pQnJH3AQ5IjRnqp1RLf08ItSLhlVvDb44h
         I2++PJxFswqD68B8viNASMc7wsOLLvs1l8kXwXllFjSxFihkKvdMLnnqK84EgzFbvCYj
         F+jZtxvuByq1s7Gp0pHZfbtwxF8qOsnUxVMKWDd110p01FgWkRPr70Xch1HZdRp0Gc9y
         hDfsOGwKVAl7b8yCSMqMXPrr23g5YjjyVmO7Zf0N6djl6QYzS/MK0amVYm63cKGjVzPL
         dWv4l1dBH55huemgoR5e1v7RGIgR4HxY+Q3yhxcyVCpA316xUhdrd8U5Pv4ukwZn5Ysa
         8sTQ==
X-Gm-Message-State: AOJu0YxJ3vgrvXsMCJL8bth5YQIDuXvyRxLrWMYwtvlo307ouvnQSvj4
	VLjxDcgbG+KUZgCfbzNboAaQT285IxNWTEWB2lqIwkQjZyPp/ujEl/wnZkNrB5OFgGi7egXH8p3
	ZMXh+SBdojsth57uyImwXbt6L0+qACjh4gOETAvMqTba/BWteRoCRhoI+s9Q6VkvQoxCtW1jAxG
	TDe8sR
X-Gm-Gg: AZuq6aJykZ13yeRuapbZzrlVStqwtr/1wvj2Jr4+3Kf8mHiNcXnjBE/KqFSMEo5N3T9
	7aeLDR8s3j5xiFwcdR2wTMUI9raCCv+6RXJPn4hhJHaqyE7LWwQI+nwV9CMJuNpXuT90+iBIsij
	XOlQHvhZ0G1YxG+xOGRLN2csPRTIn5SLPwqnTws0Gx4/yyB6RZQOr/PdMUa3kRoNjDGoFebJKw0
	Tkf1r3tVZho3qG0savWsUCBKhJaATjK/pXYo1XgL/+FvosiBKslVBc0g2vcr1wgnFJUKbk4ZGlB
	bLBv6NGWpKy8D0Iv14sZ6sMPnyun5H31021aenxZVvuRliAtyLQ2BuOBhJe/rqCiC678qgvenMl
	0AN3Nw3IpgYQw/Tz8uZF3/bSk6krVpOTpr359rAgZlZnnFExDsitmtU4SnzknTtY=
X-Received: by 2002:a17:902:db03:b0:2aa:e843:ab11 with SMTP id d9443c01a7336-2aae843c243mr21123675ad.28.1770605563321;
        Sun, 08 Feb 2026 18:52:43 -0800 (PST)
X-Received: by 2002:a17:902:db03:b0:2aa:e843:ab11 with SMTP id d9443c01a7336-2aae843c243mr21123505ad.28.1770605562437;
        Sun, 08 Feb 2026 18:52:42 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c4d8dcsm93211185ad.9.2026.02.08.18.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 18:52:42 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 09 Feb 2026 10:52:19 +0800
Subject: [PATCH ath-next] wifi: ath12k: fix indentation in
 ath12k_qmi_aux_uc_load()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-ath12k-fix-indention-v1-1-6b87ae99745e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOJLiWkC/42NQQ7CIBBFr9KwlgamDTWuvIdxQWGwRAsKSGqa3
 l1kbYybSX7+f29WEjFYjOTQrCRgttF6VwLfNURN0l2QWl0yAQaCARNUponDlRq7UOs0ulQAOhq
 UUvQjG0CRgt4DlkHVnkghqMMlkXNpJhuTD6/6L/Pa/1ZnTjlVo4Fuz4zuhT76GNvHU96Un+e2n
 OrN8I8LPq7OoNA4aAP4xbVt2xtZL4Y1FQEAAA==
X-Change-ID: 20260206-ath12k-fix-indention-bfeaa64b072c
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: aEys5_cX3XVylem2jlDIbEOnG7nN3qnd
X-Proofpoint-ORIG-GUID: aEys5_cX3XVylem2jlDIbEOnG7nN3qnd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMyBTYWx0ZWRfX0DOxdFKTIu75
 3eNhwo2FO6fCvSHPTPlPN20hEU01qHeLDw4Mkr6RFKymIh3GRmhk+2ZHoXD/h/TphwjODNxuLuy
 QqShOlzqEO74asXvHbtGj3urnqjqHZQUZqg9LTIjIEzMlZLT/4c9UB+OZDZRAppptPQxVECYtBD
 K/ng42PPIi3I52ww63BoQGdnRj9kii08ppRePmOYaFBWFgdsKxLoCDG5MJm6I8YguDvYFQNPd97
 mYs/IZHxl+6udgqBSIZUEg5IvMapOY+4BxsoL/EO+EjS+gA33lKx0RBrp3+w7yg4ZKw1bW2ooMr
 KclYKk+5PFHNdvesdy92PKTr7lNf5QEp5JciIcDTzRJojpWL4dbGuVEs8wKdTXSnl0f94V1VKTb
 jxf1aPq0If7/9EHFzZh8Xc8NcqNQDmLjj/7FeshSXuF1xHtXGcOibYPAnSvWVfZ/K6RZxzMuqIq
 FsBjtOxulaKSrCVJHlg==
X-Authority-Analysis: v=2.4 cv=SNlPlevH c=1 sm=1 tr=0 ts=69894bfc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=VpXjoHvSS6b8BrFo14wA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090023
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31644-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,intel.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3372910B3C4
X-Rspamd-Action: no action

Smatch complains:

drivers/net/wireless/ath/ath12k/qmi.c:3342 ath12k_qmi_aux_uc_load() warn: inconsistent indenting

Fix it.

Compile tested only.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602061221.5SCuwKhy-lkp@intel.com/
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index cfde4147c8fc..41f53d34d33e 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3339,7 +3339,7 @@ static int ath12k_qmi_aux_uc_load(struct ath12k_base *ab)
 		goto out;
 	}
 
-	 aux_uc_mem->total_size = aux_uc_len;
+	aux_uc_mem->total_size = aux_uc_len;
 
 copy:
 	memcpy(aux_uc_mem->vaddr, aux_uc_data, aux_uc_len);

---
base-commit: d9a2be2d72d4f9035f0334e0ff49180fe9df6e52
change-id: 20260206-ath12k-fix-indention-bfeaa64b072c

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


