Return-Path: <linux-wireless+bounces-38016-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bVeVMniVOmoXAwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38016-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:17:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7A96B7CC1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 16:17:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NI6UlMhY;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ilzmXqT8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38016-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38016-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D184301938B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F923845C4;
	Tue, 23 Jun 2026 14:17:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F113630B7
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:17:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224244; cv=none; b=auw9e+X4knnUg0foPU5rVRCW4GRi2YziaTYMI5hamOZYce3dbYTueVXkTyipFi7qPEWcG9iy2IuMZP0xFkzC8yBMltBkS0aCmnnLnPGE1ACeusrqDn4vfPXUZRfz4K8DEhm9OSQDPPEDpMZ9ii0WAB6+p8FzvA7QHRmBkL2jlW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224244; c=relaxed/simple;
	bh=Haee/I2j+V+lqHeOTa5BgOL8A5fOULgb8A2WnCK+moA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX1pke9krO5xgFnfrM8opxr4eW/jvIOgHIJk7dy/reRmpjkzdqWyWbi0e/Rk0+VATb5AtkVrHRtAtqRqWFwl8tRPAK/GC6Uu9x4kBJYu4C54OBdGPtoOr70sgYN3yYJjaMVwXNxF+xp+dY6uIjSGRRFaSgk0EK9+Ildwp8iISs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NI6UlMhY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ilzmXqT8; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBXtTX1156015
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=75+N8+hZitS
	36OKrOB6WJXTvRoUzlca4qnJ2MjmZj4Y=; b=NI6UlMhYO2vlZa8COION6cWKPYF
	YzND76e8fT9vvlFLvIslzSDTowuc2xyIxxv8UNnjeCVN6/lsmTeoZjzttnHxokip
	9Q/MXddwWAkJTpd0i4IvlaWw327uYyJjIzFB3l5rCVQ9xrj73IpkaWNGOSZxyeno
	v1POtVz8xY4E0cPteWHc6HeDA1t5L8DG1h8FQSHtK5mXyFOHfB6YV5ivP/B3WvD9
	/ceCODHN3ERGJh43ViUIOQrd3cqq3IytJyb+5rG/WzHGvfmoTZL/BVpBKd0pA6fr
	lHszzdelcEgdCJRx26M9/xvHTZODoSBDqV9yEmUP1y04D4oqxGWpxVL2siQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr28ry33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 14:17:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37c5dfb676fso3671818a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 07:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782224242; x=1782829042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75+N8+hZitS36OKrOB6WJXTvRoUzlca4qnJ2MjmZj4Y=;
        b=ilzmXqT8Wtxf0gCAON9CYKTx9F1vB6BEJuy/WsR9/zI2uFGEoml7TXASfH6ri208iB
         1y7xL8tJOJxiyJXsaXP5PkI+Qk5p5JYvZcwIqxDQGfuZPRVWHqUlZY6HAx/KeP7mRS8K
         ZOovHxrj0uBM8Ic1UyNqwNrb0P8u+kyUo9qEse3gJwu48FwrPBtxWOarpGHVYfU+4owf
         1AMRAgTNwIVRd3xgF3VC+NtxydBIPithC2v9eFCsraSCI+MBrLTD7iVK2okcOSrH6yhb
         hU+4EDzv0qLyPgUYtVC8HWqKq8vqZh75ovQsu4vvELoRDT++lKjARLoblDy7Isd5hBKk
         cTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782224242; x=1782829042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75+N8+hZitS36OKrOB6WJXTvRoUzlca4qnJ2MjmZj4Y=;
        b=RPojc8Lw85ubOmZkBtH2PpUGpg5lhgT1Jfv1yqgz7a59JoqVnj1cSvg2GEDN6AAoJA
         g6hg4+BYz0spOlJEstBuUp38ZYkXVIQS0EdDvSTMyTAYhtjGmYE8R+zVku8KpnFnzipL
         tKjhBL/304Hgo0Q4QkGDFAfQleeeWvtI+Hz8CvppmA44tY8NhCcxU8sLhrW7xo6+kmoT
         iJKWl08uDDkqqZ7qi2uyQ4P5spUILgOotFYVRX4j6yKhj1B77+gORNAtDdfezrJxJWL2
         fD0x/0iX4Lxq6u6s6KIe16dspHmrCn0xllHJTLFsJRqgetz/B4JZMeS49IbzYd/BnVZ1
         EekQ==
X-Gm-Message-State: AOJu0YyYmGwur7bZYfOSQuDUpQeclxv49gO96HCkB91n+p6Tqe+WedX9
	D0sK1oGeaXvcyg6T0eGmNImToAhbzxA3cof1sAh44tpLREb8wnFAET5nnfaic/7XWz+91O4gxr2
	ioDFxEOVmE5F0mdiapYWXota4CjxDtJpGf8TV2F0cTk5BG5pfLXYcF4b5M5vfgNL3FgGdYA==
X-Gm-Gg: AfdE7clsdO7u9a7bzpfvIBzjsCu1HiGjR/psrrnuA7tL/9yP+H6qhU8uBuVV5xvkXmx
	OhjXWAYFiX1mImQ7E+Kch8pczQezPZM0J75lRVAfcVuffXv5VPZjjbHwAhwbOLwtS9bolLdNC65
	yo0411ZK4JJGD0kvINIKbmxKvpciDYRnuHYF/lrH32UcSh4Uo7UUmGEw506aZ8eJXEw99wZ583X
	6oNyTTi+TFIFZ/oy/andbmjXp3r+eGwXrPdqZEvDrhd5pIrbUtN3Nzo2Xbh/Rk7fot0bmfdGrEh
	YZbzPxuGsQ5DEaYX/69Abz2pN2hiIFCVyYpxK7S/ssJ9R1xsl/XyJHi6LOZPoG2zSAkBHiTTKwM
	MHxZf4vSxGB940cYumNmkCBwcBhVXALI+pDCZQ9vi+t6bqMyQxuNMQPFSZyps
X-Received: by 2002:a17:90b:4a42:b0:36d:f28a:c5ee with SMTP id 98e67ed59e1d1-37dd0e341abmr3292693a91.25.1782224241732;
        Tue, 23 Jun 2026 07:17:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4a42:b0:36d:f28a:c5ee with SMTP id 98e67ed59e1d1-37dd0e341abmr3292649a91.25.1782224241257;
        Tue, 23 Jun 2026 07:17:21 -0700 (PDT)
Received: from QCOM-IvKeorbwK5.na.qualcomm.com ([120.56.199.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f315842sm10094199a91.17.2026.06.23.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:17:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Alex Williamson <alex@shazbot.org>
Subject: [PATCH 2/2] wifi: ath12k: Flush the posted write after writing to PCIE_SOC_GLOBAL_RESET
Date: Tue, 23 Jun 2026 16:16:49 +0200
Message-ID: <20260623141649.41087-2-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260623141649.41087-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX2F2h4sJEFvQF
 J9YnKwDcZ2zu6u9DpC2fshO7BtZgszp4R73Wr+dzefk4Hj/mUksuzGSEfHwi43qTcdrRpBoLe4y
 Lmtnr2lvMyBQt2On5DJPYX+e59GnYS8=
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a3a9572 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Alb0JCXUjTgUeOUvUsHAUA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=EUspDBNiAAAA:8 a=b6JBSybIbF9IxaTxWo8A:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: ZE06x1KNjJfcMub7nmlThHu9w-Tz-mUy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX4Gr/F0WBCogD
 fbfwKD6mGGnNLpxxnlBKUyKJ9HReB4l0n/HKODOw3RWmFjc2iremlWpHOOVXuBVQfDR1/mcE73B
 PZx6jWEMtsOfzFsby399tqvvW5yTdQboOUILuigpIlcbnLU40o+zvahVHbme2qC89ObzSEfi42S
 2195YHBkK8NSx20MnuRKtc8zmHrXCqWb2mwz/vojeAsohtkjtofN7BdRnjFs5BxYv8hreTR0THX
 vqNeF+ys5FwJa5CuiZioHxtdgCFAb0/HD8Gjprin8+Bm5ZAwjA0Kkne8Ka6LOkA4L9puUFLv7ko
 wiHsI1S0WQNKlkML7r3Ft3O/hqjej8s36YEGc5WX785rH1kUsvhEUCO11R8IRgGXl49FQjpigaO
 3J4qq49GDf99Ri6icvsNk/kRRN7enztDZhX10sfoReDxhaAOVgjid82nJzWYpyPfiqCLzZ/YatE
 nV6Tjm+ZCXlTH3ersNg==
X-Proofpoint-ORIG-GUID: ZE06x1KNjJfcMub7nmlThHu9w-Tz-mUy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38016-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:ath11k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mani@kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,shazbot.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B7A96B7CC1

ath12k_pci_soc_global_reset() tries to reset the device by writing to the
PCIE_SOC_GLOBAL_RESET register. But it doesn't do a read-back to ensure
that the write gets flushed to the device before the delay.

This may lead to the delay on the host to be insufficient, if the posted
write doesn't reach the device before the delay.

So add a read-back after writing to the PCIE_SOC_GLOBAL_RESET register and
before the delay.

Compile tested only.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Reported-by: Alex Williamson <alex@shazbot.org>
Closes: https://lore.kernel.org/linux-pci/20260622160822.09350246@shazbot.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index d9a22d6afbb0..fee4129ea405 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -188,6 +188,8 @@ static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 	val |= PCIE_SOC_GLOBAL_RESET_V;
 
 	ath12k_pci_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
+	/* Flush the posted write to the device */
+	ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
 
 	/* TODO: exact time to sleep is uncertain */
 	delay = 10;
@@ -197,6 +199,8 @@ static void ath12k_pci_soc_global_reset(struct ath12k_base *ab)
 	val &= ~PCIE_SOC_GLOBAL_RESET_V;
 
 	ath12k_pci_write32(ab, PCIE_SOC_GLOBAL_RESET, val);
+	/* Flush the posted write to the device */
+	ath12k_pci_read32(ab, PCIE_SOC_GLOBAL_RESET);
 
 	mdelay(delay);
 
-- 
2.43.0


