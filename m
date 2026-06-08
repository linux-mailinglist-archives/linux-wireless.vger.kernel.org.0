Return-Path: <linux-wireless+bounces-37520-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ov+5L62+JmrVcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37520-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:07:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBC8656724
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:07:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=AnhVfedM;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=V36mDYNo;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37520-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37520-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 446E4300F796
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADC2EDD78;
	Mon,  8 Jun 2026 13:06:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC19288C2F
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:06:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923973; cv=none; b=oGMhOTepB2qVg3ou9Lc1XVjFyGIfsIhtYkmYmBTnrJ+ZvnVWfjPcBTBKX0PRPKiNo/+1YYds8MFuSCrCDkkcvvqDvKG6TxL+6/sDjynMGTWqzOZLwtHXHDZp/pTFBGAxvVYYFtJydua90TgzVl3nJ+MTJim+watHYWq+pjBx2OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923973; c=relaxed/simple;
	bh=HF6y+Gp4hvfOcXImXyYo6de1jyfIsA9DdNvHfncmDUY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y3qkM3rfpOVcRmR2+a2/IHRTVmSSTC1xWx+oiohOfnFSGk/QElvArT0i8RrKvj12hWjz2n6tyFI8Z7sa+mIppjmB/xHoZl3eypGscqREyIlfiMu08EB0xku+tGazMVbL+kso94+hJ1P/XcqJU/IL+oQ5/WdGxkaxDw+UfQWXisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AnhVfedM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V36mDYNo; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9RVm2965384
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 13:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pwY6r9ceSIbFZ3Z3ZupRAz
	VFykfNoBkJzFy9SkXL1FE=; b=AnhVfedMGZ57F2W4ocK/VnoKmZPMLi10nB9YVg
	McZxqEFO++T6rMrBQ/W4DYyzWLqR//qXX/JD+Lki1u5BRAyhF1ddNCqbQCaCKnK4
	kHzS9MKAwLRLdXd5H3F20L7ttoZ9mD8LQDo76QWfW11MDSOJTCh/GxlFaNbP/W3v
	dd6QPfaKA1+yjpt/k2NUBxp4cX73+ITo4y/JwyHQBWQ2DI68g2asaO6kVINRJGyV
	qY11nYRhqGmGyZ+U6hUX98eHooF7oa2BVMBy/zvUTbUkX/RIuQRxd5RyLGGNIJ4J
	uLgUle5tPmpYM3iBR/Q5dsSlL8ePqqHUDpvG/3qIHPgP5A5w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrks1b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 13:06:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304e7fc90b1so4181929eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923971; x=1781528771; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwY6r9ceSIbFZ3Z3ZupRAzVFykfNoBkJzFy9SkXL1FE=;
        b=V36mDYNor0FUFHZGJ0JEf2mK4cCanlpbiKumwIer3eKBXJ2RkCTJ8gLErUCYOVpCLe
         IVQNUtYbjjHyqgpeJeICoWWI6RglEvWfigrOGC8n9TFQQu9EQwHbn2kagV/HSszu1l9c
         K+ri9yONSAwYezEu7ABGObXV78aXZJGvpSUC4jdqMHXJzMfmHXyPf340ZCS1BohO/58V
         Jhu/YT6BQNWxZC/qyX8d7b990YrfV/rwBoXzKoK+bvrX1fw/WlqIt3/ENvNoMmOPbHWQ
         Gu38H+DYbXPCBk8m8vpvI/NpIDmOObI1Lu/YwAgA4jYb3+l+Rt3KBaF36lPrLu+kaUgM
         TswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923971; x=1781528771;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwY6r9ceSIbFZ3Z3ZupRAzVFykfNoBkJzFy9SkXL1FE=;
        b=Oy825vqPCGEDJZUJOoNsFNMjEy2oeVJc4eGa4mg6SvLpj1vU0PM6OWYG7C+PZCrX3x
         k/SNUsDIZDiY8Ki2QpD8uFtndzXpFZZx73kPVjnYTBSwol+wQxbo+M5kMFh9SQATPIfS
         sa8Cg7d63PJl5sKqFSWI+5731aDvy6hpS86kqKVaA8eVwNJKeP/EQCK4f8zoxyaJEhSL
         R+EkKp51SlLjAzvNK75EbFjR6OH/MJr8v5+77A6UY5gwTXTsCesTr0KxQvP3R+IFmla1
         8O+a27tEs+Ajr3bKKWG2Hvt6+M2bRKI41mmdMXR7bYzMTiQ2lEqxLs0S0+Dey2mtnx/N
         bJQA==
X-Gm-Message-State: AOJu0YyjSBhUzMV+I6vYpdPk/vhtOnNTjx195e7o9VYpMkW/RBKSmASS
	1SALQDC8ITYUQ6BuSzMy3LooCVN1GfUEAfD0byNDnhr56PgB2U6+yVeiYETeZSuHmy2BarwOmhc
	xO7C62JOaYIMw6jJJqLnhS8RvTuRn8J+gHI4684zd424wueiytkCDP/dftNoHN6L9/bCVIA==
X-Gm-Gg: Acq92OHfDJCqQu7kQ8aL7Y1iLaCNAU2+0ZEXZmpAnB38ex2FY9dD/Bf+N18BBVMsNdA
	Bs8XIM3yr5ohQb33WSGWKhFZujvbkaobjFCrjk230Q5rgiLxfNIRFJpwi/zOdPuSLniDtNVf95z
	nok5bgIlTpYy7LL/yJNKcCx96CMmi4rHtuJq7ftPyoxujG6WOb1ye4n4Z3dcsg06uMci3wa6cBl
	D8u1oh8zXfPfcigmTPW5DoqeLYUqS5mNUGozbhRh8BE+QgAJwb2bhrX/mMPMqKBK40Ghxh/3xlY
	qrZu59Hf0I8fO+vcTmGL+p5We/l4SB2ROfD4LsYS1WGHeJZsxrsRkjdps3hnplUs3x7UOuYAmOi
	KsHXLVaEahNeaB1Y2x+xEY8WrGoJ2+MBe2X82E0EEYQWbLXuhUwT8A32vqIWYgq3vbBpg92nlT/
	92xTic7ak1OqA=
X-Received: by 2002:a05:7300:ec15:b0:304:d8e2:3c4d with SMTP id 5a478bee46e88-3077b2d9d1dmr7722206eec.25.1780923971104;
        Mon, 08 Jun 2026 06:06:11 -0700 (PDT)
X-Received: by 2002:a05:7300:ec15:b0:304:d8e2:3c4d with SMTP id 5a478bee46e88-3077b2d9d1dmr7722184eec.25.1780923970533;
        Mon, 08 Jun 2026 06:06:10 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba9d43sm15666701eec.10.2026.06.08.06.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:06:09 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH ath-next 0/3] wifi: ath: Update copyrights
Date: Mon, 08 Jun 2026 06:06:05 -0700
Message-Id: <20260608-ath12k-copyright-v1-0-e1a71f92d447@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2+JmoC/2WNwQ6CMBBEf4Xs2ZJtESKe/A/DoZaFbhSKbSUQw
 r/bEG9eJpnMzJsNAnmmANdsA08zB3ZjMvKUgbF67ElwmzwoVBVWeBY6Wqmewrhp9dzbKIpWlgp
 LrC+IkGaTp46XA3mH1BYjLRGalFgO0fn1+Jrlkf+w5T92lgJFJ81Dm7prC6puLoT8/dEv44YhT
 wLNvu9f3gVrdMEAAAA=
X-Change-ID: 20260604-ath12k-copyright-3d1520509800
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: byS3NutWHQOHTkCfTOethp4auUj4b0zn
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a26be43 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=dk-9R-U10jJP_KFx_BcA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: byS3NutWHQOHTkCfTOethp4auUj4b0zn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfXz+byEMGii8gS
 2X8AViXcDYyJTLZDGEwmR6iOf8nGrleL7yQ/3X58SaazsbwaqMyL5cHFZHFxDGDno6sjQByhgME
 lZcpHRIZ1eNQWuSL/WBnXUA1jIUj6iA4SY8FD0mh/HmLxyPtf/mtigiFdwnjvdX0lltFNu40qb+
 rF1Za0+Bi84ydpHA5Qyy7DUFNes6HFz9CphsspoqG0TMG0+0wYSDYYF6FykHUAfSPvleEheiPvC
 PjcJuY9d3zq/SI5Fi4KmzNIUAEweXt0ZBR8nr/sWzvP3vmuDNqioCZoyMbZz0pPtgzEkKz6Er2m
 +l0xTsjoYGTbBzgRlSq2OncJVbnr/JyVsSSCsMzBPX5NDSRr9JJfbIOk9QzMKcEnis3d+TsKvR6
 aPxTQgUGfEBByBtZmlIHjMeIjsyJE26xxAAAyEAJ/W3piDAODdajvtecPAolsZKhxcn+lWBD8lL
 7bEMaQZ4upuL9dgFWLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37520-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DBC8656724

Update the Qualcomm copyrights in the ath wireless drivers that were
substantially contributed by Qualcomm using the current guidance from
the legal team.

---
Jeff Johnson (3):
      wifi: ath12k: Update Qualcomm copyrights
      wifi: ath11k: Update Qualcomm copyrights
      wifi: ath10k: Update Qualcomm copyrights

 drivers/net/wireless/ath/ath10k/bmi.c               | 1 -
 drivers/net/wireless/ath/ath10k/ce.c                | 1 -
 drivers/net/wireless/ath/ath10k/coredump.c          | 1 -
 drivers/net/wireless/ath/ath10k/coredump.h          | 2 +-
 drivers/net/wireless/ath/ath10k/debug.c             | 1 -
 drivers/net/wireless/ath/ath10k/debugfs_sta.c       | 1 -
 drivers/net/wireless/ath/ath10k/htc.c               | 1 -
 drivers/net/wireless/ath/ath10k/htt.c               | 2 +-
 drivers/net/wireless/ath/ath10k/htt.h               | 2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c            | 1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c            | 1 -
 drivers/net/wireless/ath/ath10k/hw.c                | 2 +-
 drivers/net/wireless/ath/ath10k/hw.h                | 2 +-
 drivers/net/wireless/ath/ath10k/pci.c               | 1 -
 drivers/net/wireless/ath/ath10k/pci.h               | 2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c      | 2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h      | 2 +-
 drivers/net/wireless/ath/ath10k/rx_desc.h           | 2 +-
 drivers/net/wireless/ath/ath10k/sdio.c              | 2 +-
 drivers/net/wireless/ath/ath10k/thermal.c           | 2 +-
 drivers/net/wireless/ath/ath10k/usb.h               | 2 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h           | 2 +-
 drivers/net/wireless/ath/ath10k/wow.c               | 2 +-
 drivers/net/wireless/ath/ath11k/ahb.c               | 2 +-
 drivers/net/wireless/ath/ath11k/ahb.h               | 2 +-
 drivers/net/wireless/ath/ath11k/ce.c                | 1 -
 drivers/net/wireless/ath/ath11k/ce.h                | 2 +-
 drivers/net/wireless/ath/ath11k/coredump.c          | 1 -
 drivers/net/wireless/ath/ath11k/coredump.h          | 2 +-
 drivers/net/wireless/ath/ath11k/debug.c             | 1 -
 drivers/net/wireless/ath/ath11k/debugfs.c           | 1 -
 drivers/net/wireless/ath/ath11k/debugfs.h           | 2 +-
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c | 1 -
 drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h | 2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.h       | 2 +-
 drivers/net/wireless/ath/ath11k/dp.c                | 1 -
 drivers/net/wireless/ath/ath11k/dp.h                | 2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h             | 2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c             | 1 -
 drivers/net/wireless/ath/ath11k/dp_tx.h             | 2 +-
 drivers/net/wireless/ath/ath11k/fw.c                | 1 -
 drivers/net/wireless/ath/ath11k/fw.h                | 2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h          | 2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c            | 2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h            | 2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c            | 2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h            | 2 +-
 drivers/net/wireless/ath/ath11k/hif.h               | 2 +-
 drivers/net/wireless/ath/ath11k/htc.c               | 2 +-
 drivers/net/wireless/ath/ath11k/htc.h               | 2 +-
 drivers/net/wireless/ath/ath11k/hw.c                | 2 +-
 drivers/net/wireless/ath/ath11k/mac.h               | 2 +-
 drivers/net/wireless/ath/ath11k/mhi.h               | 2 +-
 drivers/net/wireless/ath/ath11k/p2p.c               | 2 +-
 drivers/net/wireless/ath/ath11k/p2p.h               | 2 +-
 drivers/net/wireless/ath/ath11k/pcic.c              | 1 -
 drivers/net/wireless/ath/ath11k/pcic.h              | 2 +-
 drivers/net/wireless/ath/ath11k/peer.c              | 2 +-
 drivers/net/wireless/ath/ath11k/peer.h              | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h               | 2 +-
 drivers/net/wireless/ath/ath11k/reg.h               | 2 +-
 drivers/net/wireless/ath/ath11k/rx_desc.h           | 2 +-
 drivers/net/wireless/ath/ath11k/spectral.c          | 1 -
 drivers/net/wireless/ath/ath11k/spectral.h          | 2 +-
 drivers/net/wireless/ath/ath11k/testmode.c          | 2 +-
 drivers/net/wireless/ath/ath11k/testmode.h          | 2 +-
 drivers/net/wireless/ath/ath11k/thermal.c           | 2 +-
 drivers/net/wireless/ath/ath11k/thermal.h           | 2 +-
 drivers/net/wireless/ath/ath11k/trace.h             | 2 +-
 drivers/net/wireless/ath/ath11k/wow.c               | 2 +-
 drivers/net/wireless/ath/ath11k/wow.h               | 2 +-
 drivers/net/wireless/ath/ath12k/acpi.c              | 2 +-
 drivers/net/wireless/ath/ath12k/acpi.h              | 2 +-
 drivers/net/wireless/ath/ath12k/coredump.c          | 2 +-
 drivers/net/wireless/ath/ath12k/coredump.h          | 2 +-
 drivers/net/wireless/ath/ath12k/dbring.h            | 2 +-
 drivers/net/wireless/ath/ath12k/debug.h             | 2 +-
 drivers/net/wireless/ath/ath12k/debugfs.h           | 2 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.h       | 2 +-
 drivers/net/wireless/ath/ath12k/hif.h               | 2 +-
 drivers/net/wireless/ath/ath12k/p2p.c               | 1 -
 drivers/net/wireless/ath/ath12k/p2p.h               | 2 +-
 drivers/net/wireless/ath/ath12k/reg.c               | 2 +-
 drivers/net/wireless/ath/ath12k/reg.h               | 2 +-
 drivers/net/wireless/ath/ath12k/testmode.h          | 2 +-
 drivers/net/wireless/ath/ath12k/trace.c             | 2 +-
 drivers/net/wireless/ath/ath12k/trace.h             | 2 +-
 drivers/net/wireless/ath/ath12k/wow.h               | 2 +-
 88 files changed, 68 insertions(+), 88 deletions(-)
---
base-commit: e1c8fcfd37f76b46a581b794e27765258c9a537d
change-id: 20260604-ath12k-copyright-3d1520509800


