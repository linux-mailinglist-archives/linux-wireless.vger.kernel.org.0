Return-Path: <linux-wireless+bounces-31109-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHyFCccfc2ngsQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31109-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:14:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377971809
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 08:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19D503005146
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2866366838;
	Fri, 23 Jan 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQ9W5NuK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ds8xMopl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076C3612E4
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152411; cv=none; b=cuxTzCG6K7pgTOoMwIUA6FP4PwT4hkJvQtOGs19lltmQaljEkuAEL60CT4RPadHKPhx6nJvJ2hCbEdYRGiVIfQzDuCfxsHsBua7iBK9OzmjugbI0PcEhynlzOcHvRvzTMAWGlYlSnR9qnEsz1GEYeXibNG0mliZsCMfwMrC3RM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152411; c=relaxed/simple;
	bh=EN4HQEpalpfHo/tYjg12gADrmTkGeO2CwotGaFyQiII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZKEWqfmMvKU+a88MugiZXZX5utWywXH4AbFtFwQOHaDId0KV9Qht4xw/uaZdh62HTbj2vyZBaU1g+GtdE0qBq6fezU6fkToMlSvIuTvLAjCf1+9ja/it7gw9as0Vnhf0PKmPg3m/LmAOH1plcD/utUn+Rwjpuent7nzEgYSAPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQ9W5NuK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ds8xMopl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N5gbtS1117264
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6PnQLq9PaS7ZKq7XGf5qtmHF2xrsJ7aabMt
	m9juP8oA=; b=nQ9W5NuKQO8Txp+39KBQMEcCf3apDL+OnQsybESdWfjOxZJG4Wx
	2Kk7ezZvJbb0DVgGhi4tk/thmIKjIImP0dL+lciEJBd40wkRKHWoBOCYhHBK1JQA
	zJUcUofYPuASPXyGqwtOKbKq7AxIPHUaAsqW3KMfgjyJb/6ZHp579t7myLYB1H4D
	naX7gl7Fb8lnRSeG6U1ExcE3D6B8ICzRpyx0SQueY+obuMacHNWVuRmSecY+glCb
	wz460yRSfgObDLozzVW4Kf9CrGSSGbT0c6VqRrC5aETCk7RsaTmvIB7/gybYYixR
	WtUuvXdF2L0VPsOhiTyFc+SJJX8EMsFMFlQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bur1cah26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:13:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f2b45ecffso28087915ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 23:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769152384; x=1769757184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PnQLq9PaS7ZKq7XGf5qtmHF2xrsJ7aabMtm9juP8oA=;
        b=ds8xMopl6vI68OIXJgE5werSwWhXN9dxAloD3LLlyqx/9U51Z0YE0A4hnKNtiEyFZY
         4HGuRV463TWyvypT+t0js06RuflSEB7CB+rKKT3meF7ObS5XDG1qn/8d5CTI0ughH5rt
         9AVwwbaodMC+bjxR2QZfsR8POlnLBPRlVEqrBwSxxEux50wTRbiGjYI7E8jFFwf0QBTK
         609cv61R8ptweOIpRF5WzWGVYQZ9tF4Tz9EDYXWJ3RttJKhAZoMt42s+hmRrbk5o4RHu
         NMjSkh8jUQGj6feJnhCu3TsKsFcAOvHqqBtRzAHfAEZskAaNKrNRrWwU0FaRRQqIjYWN
         pVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769152384; x=1769757184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PnQLq9PaS7ZKq7XGf5qtmHF2xrsJ7aabMtm9juP8oA=;
        b=twqYJhlEa2U4Jik+o/RjvNE4lXuRHx0LvsUNfvQKXPJ4GIL+AZBrAbkL4maQm7uHvR
         GafKvEEejuTUD7Ie65zoHxz2WZymgqhfenjCW7M59EW+wPcwnAw0GJhkXof9cJjYlOxi
         Ejbhuipmql28eoMs55MYJIfUxmefcPmW4G69bd/ny6XfGToJ3H6KeYzpHJIvCqlMptBz
         noQFuRi+29qd7Il3GWb5fiOvEtHZU5EAyUM4Gtv+Myz8w09iSIDC77P5KC/YxbekIal9
         uF9JDdi1OrYc18qNvNQlVsXYs78SOmrQfmpzvvzHxZNHsN/0nv9u3aP+Tw8XvpXdzPLt
         FINA==
X-Gm-Message-State: AOJu0YwK+F1Qh9A2/5D1o8M+v8aaxgaKMxh8QXcC6ZNlErZvSXiNh2w0
	JdGPtixqQrBqtByqPXqyVaNGwXlyiIvVms6o3HUfCHXXTjmRZ3AnKXrMYGuZ50uHrTAnO6JSEtQ
	WZh20KgZC0FhQWbyvn6LFTk1TfkHKwwdM7ncCNkgmWSuLMg8rEh4hAFlJeshny82dXEtA4w==
X-Gm-Gg: AZuq6aJHXPKvKLdPTdOE4JIvH0IuXnLQNa90NsS7vBYWpwu24XkBBmR+UgXmSfiYGMl
	3Y8qEKGF8otpVizzFtwoZOGVbyIjbiumCAre9JQ47EsjO3phg+b0E0X8OpY54PicLEQA75wNdwc
	ahsGmItVSsmchisqZlzzr45pqhT/aOJerbjvhQXBMrVpgt/mrCPrCeqCu0YYa5J4nykF86hiQ6/
	V4d68P4GDgHUWFIx3w3kQ8lDn352wiB+7m9H0iyWx+Jc6JIG47Cno0nACxTaVGfiTWctQUa+81F
	7ZK84gY3MFenqlQBaeVVTW5hkU2WTAvykOi+HKUwvQ0LUdCczQyul6frpA0bdAxzfO6U7ZjXpsH
	bNDI1ClhGLW2pDpCqDEYh7xRUZ6MoCYMvROEW6wG7R91oPUg49GbJYiic+8Co/7T1AOZStNSOXC
	QDEGBrvBK/n5ShT9ZpbTt/r1hE0VxsV01G
X-Received: by 2002:a17:902:ce92:b0:2a7:5751:5b30 with SMTP id d9443c01a7336-2a7fe441e0cmr19341595ad.12.1769152384375;
        Thu, 22 Jan 2026 23:13:04 -0800 (PST)
X-Received: by 2002:a17:902:ce92:b0:2a7:5751:5b30 with SMTP id d9443c01a7336-2a7fe441e0cmr19341405ad.12.1769152383914;
        Thu, 22 Jan 2026 23:13:03 -0800 (PST)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa654sm11319165ad.11.2026.01.22.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:13:03 -0800 (PST)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath12k: Add support for RX pdev TX hardware queue stats via HTT debugfs
Date: Fri, 23 Jan 2026 12:42:50 +0530
Message-Id: <20260123071253.2202644-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FswIPmrq c=1 sm=1 tr=0 ts=69731f81 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mjs7rqhY_IP6agJ2i2UA:9 a=zZCYzV9kfG8A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Z-ToFO9q_UIAB1iB7RJCiNzA1ZmBS4rQ
X-Proofpoint-GUID: Z-ToFO9q_UIAB1iB7RJCiNzA1ZmBS4rQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NCBTYWx0ZWRfXxNhfJtUUbY9P
 hS4shNeyfUsx6cWQvBKq2+PdG+VH9dsToLdGN0XAjh7BvE9ak3bOksDHRXPXLlBQp0L4JfiMqz/
 2cnba+n/eFm5lvXSAe1KNJdgpBDdYHZWH8L4VNZjdILEBiybAS3imEuUviKQHP2RrDze6OBebU2
 GHYUG3PN3+TM//n7dqcDm/yJjnyDbRxDKxJmN57AT51bvb4qiPw6rKbZJLUJ0h8HYHAUnrQX5vA
 /VnMEQY5Asvu5aOK8H7hE5dS/suQGJIRvhG3TqUy/gkh3M21xt/4blzSAaChh+cA/CnA86ql61i
 EQGaUL4w3/AgaTuRDUDfXnAyGE8QuejHSjYo36dWejblC9wBRAiammGaOpxR+7D2HkiFsGVtW9T
 ArAnz//7Kh+vhyfCrzb8TKdmw/nZOHlwsovSE+WeU+DekqxD4+oiVyn/x5QPqnDYvrujvJfjCjB
 SxfkHqwpZ3OOd4cN6og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230054
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31109-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6377971809
X-Rspamd-Action: no action

Add support for HTT stats type 2 to report RX pdev firmware and HTT stats
type 3 to report TX hardware queue stats. Also fix invalid buffer access.

Aaradhana Sahu (3):
  wifi: ath12k: Fix index decrement when array_len is zero
  wifi: ath12k: Add support RX PDEV stats
  wifi: ath12k: Add support TX hardware queue stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 197 +++++++++++++++++-
 .../wireless/ath/ath12k/debugfs_htt_stats.h   |  81 +++++++
 2 files changed, 275 insertions(+), 3 deletions(-)


base-commit: 758064145fe77e06d07661b27dfa9c24fe0309a3
-- 
2.34.1


