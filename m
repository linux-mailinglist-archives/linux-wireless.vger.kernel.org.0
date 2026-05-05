Return-Path: <linux-wireless+bounces-35914-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLONI0sC+mmBHQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35914-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:44:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 015054CFA5A
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D756306CB05
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40734677D;
	Tue,  5 May 2026 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VkJxyHVH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fzzlnwqN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035E36CE02
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991942; cv=none; b=PrTqKxvahuK/jdnjv/TvQ37BrzhOp8H2soXEwIx2C02wGs7GCHS3i+TkBVk17+j9+ZAM0C8ryY57esSij5UHkQ53FTTN2PK+7oF7uvz/reNC4kPWRHrUSvQtwAUkBgBpSqYk+ddMsugf8kvqGPJRfoq/fJGce9QiKQuhFZYrtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991942; c=relaxed/simple;
	bh=OvcVk2FP1mnfOSSJBqfZAHQM+P9wPN8CYASMBIgIe3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tEd2Wqbh+9gG8Io0gp5jemYdmX98DHSoQRm2BM0U7KW+08NqSzkCfK/NsLaxtUfbDljCcihA4s35/xL72xNcI2dNh96cOkDrWkj6Fp+g/6DrG4nihr8wskLvaxE0YTSfBq+4T6v+TmODru2LSxnsKEiMfRuU/Z4rynC/PfwGxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VkJxyHVH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fzzlnwqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645DQX8e3187538
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 14:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5bPePzNucDjdPMychNM1WStY4oN0F7dq2lK
	TbjPXGpQ=; b=VkJxyHVHahpwW7RsyfD231UhPTzJ+FRXfqvRTfOn7wse0GlkB/D
	xxsPlTXSixaLSEMoJKS/yh7fnzoNvsJyuS8JCAolANLKCH34/eUXgv9Ld8YQoJO1
	3VVJTPbgt4I50u8vc6np03NRdc6Kl58m5GpUTht3CouiGwP5uVPjNoRT9W7S/tUK
	bIhBukoptMk9QbHlcu6h6oRnFqm3qhAJ55FwauBr9onRND0m50Hdd/g4+Xshaed4
	4/j/NKoPWYmK5LgTH6oD0N1GqE0aD16+PAIPO6rnek5LgjaGl6BVfGTPElddvxzD
	xPyfmI+Yio8T2K9jBkfjD89M0A3gcQvyTWQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkk9ss9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 14:38:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3653638874cso2714962a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777991937; x=1778596737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5bPePzNucDjdPMychNM1WStY4oN0F7dq2lKTbjPXGpQ=;
        b=fzzlnwqNg+stHBXV663pYdsVpTiAN1lip8IJMrKG/dMFU8uo7M3SAqMoc8EG2oiKIR
         IpJncS2TOjNM2+5n9bf3egtcqVLYEBPkIWBFfB0j0PWwp3JEYjRFCbtqdPS9rHv9I3et
         bKdvfose/njBtGhhi7t3hkQj1E8r82IP5eXH4TGbXc+k7klIAwRchGgHlHapBw2JO5tg
         g/XLKPIIKvZT82ZdRm6LHSG+7xqwwdzkv9QcXb73StnqFncwIjwU0nlrE4RATwql6clv
         V46B3eknBY+bzbkiZZ3V/lhSjDBiV0lwPSiEvsZY8ib9GLNEFXNStEOHtnSZCCsmbXdr
         dpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777991937; x=1778596737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bPePzNucDjdPMychNM1WStY4oN0F7dq2lKTbjPXGpQ=;
        b=rCkX+H6ZegnBzncMWlCP78VDPXDoJ0SbRCE8P+5DicWoIj4C8MxEDQtFzXIxCEdZzL
         u9ZRu8YHmTsgEbqqnLE29dlnUr4df1fYzvyuDO7hB7kxRe8eT6Ay8/HPOhu1Kboi2ij7
         BxnMFjUx6Su+hl8Q+x6nInsAG9nuwmgazN2ICiMXvG7VEdQQjUaaCxaJkPDl2/6vQbZL
         UCiYRu05UBp3A4IaD2NGy5qqH2mbkfWaqbjuu060tqZWDtxKSIftrSTTxpN4/+XcYzqt
         9Y0L8d2ggFSDpGNBOFOmioNqdzc4L53evre66C+R0wLdeNaWAYJfdmsBhCXb27sNeSij
         8UxQ==
X-Gm-Message-State: AOJu0YytWsHkisF48gfJ2mL8BY0C8HZCYQPdAaPvQfhDYRFKOmVpJHZJ
	troxGbMdiVditwSDRHHAUJhFLW1yU6XXsm/nNTuwYzAqHOoJCmuEFh2eGOqYUCFThOLDjIky1g8
	jDPNX/4kdhcwtK6a7zSKrnzykCWGhiY/QTeXTjO7424H3y8heuaHpESXcfA03JXXbhgUL8g==
X-Gm-Gg: AeBDietglfv2aRcMcPxCDUDnwhqmWVZWvUgea0ZVBVQ74rlvZOeN4dDxww2OL22Gj4Q
	Ha8SEU42faLTxeOLu/Y9tbX96EX5ljy6XswLk8ycN4mblhV/whtWkfbRgoulXG9qvRABLd3tRKx
	Iy9DCNbPFPZkdX4uPAb2y1ggdHeom7ggfwJinYZ9HObgiMoMSqeO4RCOChEK3JrLoCBrCN26GVl
	Jydz4hnncU2qkky+zSbtPnWyJP4Rbw/WhpvTB8Uk4zb8J0FM/BSaG+XediKKAfE6wE62AQBdYBy
	1iZtvivJNI+f1DpPaDLmhsQHmnEzPUFCiKRvbgZ742RYbw2kVuufRGGRc54JA2pr9OtPKssf8Ob
	Utm2aMjRRZkA6CkR0a3RRT1CbDcu+HDJWY+VZ9yVWFak0zSD6EmhKfFpN7jxthJ1K/bMq2N+2cJ
	TQSOQZAyit7LBLQqMvQBjjYuW9ShDOKF+1M80AnEZmgLYNHw==
X-Received: by 2002:a17:90b:3b4f:b0:35e:3e86:e2d1 with SMTP id 98e67ed59e1d1-3650cdbaa39mr14417115a91.7.1777991937409;
        Tue, 05 May 2026 07:38:57 -0700 (PDT)
X-Received: by 2002:a17:90b:3b4f:b0:35e:3e86:e2d1 with SMTP id 98e67ed59e1d1-3650cdbaa39mr14417081a91.7.1777991936845;
        Tue, 05 May 2026 07:38:56 -0700 (PDT)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36578259e7fsm2831030a91.2.2026.05.05.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 07:38:56 -0700 (PDT)
From: Amith A <amith.a@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com
Subject: [PATCH ath-next 0/2] wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz 
Date: Tue,  5 May 2026 20:08:51 +0530
Message-Id: <20260505143853.295368-1-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0MCBTYWx0ZWRfX5/aEK8KCxLC3
 LDGFXwCXF17WKzH1k5lcWB/KbRPU/4cZDBIHn5YCzMtzyj2mIqFFGyVTp7eVxbm8yF+Nu5EwVpF
 lJ/FtzVJj5SmUfpcLDI9Yk8/FIIyH7Y2uoZeL7H238goIu7IvOgQ2WcxmofwhYgzFtTqE4XvOFX
 MCAbkyZyDf+JVlElnm9urYnoFD3MNbMpP8GE4UsQtzAfahMZ5mw7vSRbtHoa+lq8b31k3gwDhKk
 NmVMTo5itHkpob9FAguSHUTFkpyIW1dM2W8Q+qTXx3XfpJYoJM65EsYKuDxCGBMh8P3Prjp0FH7
 p8RhKYmtemMH9h4k2obOp1mXnSdXtqkvePOoE/1unnw5PofYNyFLigD0TuxgVSPOAJBcYeBvidO
 YP2QXyOW1id9+gxdeilTv7Uld/xpeuRDWInZtlDKWHVYrAYYoKYM9c7mzyCUTV3vwUXCQXKA92q
 y3UNcjXrAh2Se6KBLOA==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa0102 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=Qv-E1znO2Y0tXsqnBgEA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 7HYhhs19WQ5TMTYUbF7JCgP0RAfBZvKd
X-Proofpoint-ORIG-GUID: 7HYhhs19WQ5TMTYUbF7JCgP0RAfBZvKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050140
X-Rspamd-Queue-Id: 015054CFA5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35914-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

This patch series adds the implementation of handling of interferences
due to incumbent signals in 6 GHz channels. When an interference is
detected, the firmware indicates it to the host using the
WMI_DCS_INTERFERENCE_EVENT.

The driver is expected to parse the new WMI event to retrieve the
interference information, validate the interference detected channel and
bitmap, and indicate the interference to mac80211, which then notifies
this interference to the userspace.

Aishwarya R (2):
  wifi: ath12k: Add support for handling incumbent signal interference
    in 6 GHz
  wifi: ath12k: Add debugfs support to simulate incumbent signal
    interference

 drivers/net/wireless/ath/ath12k/core.h    |   8 +
 drivers/net/wireless/ath/ath12k/debugfs.c |  46 +++
 drivers/net/wireless/ath/ath12k/mac.c     |  46 +++
 drivers/net/wireless/ath/ath12k/wmi.c     | 418 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  72 +++-
 5 files changed, 589 insertions(+), 1 deletion(-)


base-commit: e12d2d3983acb150fd987d19ec6a2a530da110df
-- 
2.34.1


