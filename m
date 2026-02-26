Return-Path: <linux-wireless+bounces-32199-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLErEKTun2kyfAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32199-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:56:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5B1A17F7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 07:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 042ED3089551
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBA38BF75;
	Thu, 26 Feb 2026 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aoYnUg4r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f0osqNWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E138BF67
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088920; cv=none; b=XFweyQd2L5o98NMW+cUebJ8xRD1ZtmlPBIUPDAzFLUOYtWADbHdbzYqXngMub67xRhGcDM5hG1oqo0p36ujPvt1tzN+3shZ2oB9u65sM1lvzls8W/8EIu18uMkzgXhg+2zW0MjopnOQzJ4IjjNnqxMcl3z6WYiIbMf+MAGP23xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088920; c=relaxed/simple;
	bh=gF97I75rsEDTmAHAd+Z42hkon01vOlo5EIj3IJLdQN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VTLvLOlMdtGAc+ZWDdQolbZp/2tCx+i5LeRxMXX95um1TWDChSql+Yyx+hTCsQ6RfObqL7RNERCM0c/Dw+05cFTvwkafs4I4dpW8w5/9yE2Ddp8ypBtLgtNUt6IGe5N89Ylh0AiWfLHijUoaYGXTRR05/yhvgvkmSNVSz6dkK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aoYnUg4r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f0osqNWv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V40O2996569
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=q0hzYU3q02GrRjJcu/Pyj5b2Z5EuQS4SjPz
	jTKMKlus=; b=aoYnUg4rvMenPzrnpuAvJwMlEtUQHdBs1P/zicDo7b4c56JhHnh
	73ZsUWgAG8Vd3PR/JoJaEWXDvZyh2+VPGotWeAi8Wmr8eUWPcTrXEPyIZmaD/pa8
	NVUDqHoyHCo/Z907MFbGt5US7xgfoCZ8TkiXlQUMUWwO6BqPRwxHiU29hhMktMSt
	cnrmj30g6r6+f5U8/Ssck1l8S7X5yqyAKf3y9jScY+k7CncNpLGc5UChCiNtuEMa
	kyr3Qsm/sey+kAKWDhH2Ciguwh4oAWDlckPWMhdWiQCyEfzM+cAHyMhke05fYQcE
	upG0FLqH1hjPKYkFMF9l97QxV6CxFY47JiA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chyv9k72c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 06:55:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3562370038dso394054a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 22:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772088916; x=1772693716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q0hzYU3q02GrRjJcu/Pyj5b2Z5EuQS4SjPzjTKMKlus=;
        b=f0osqNWvA/9ARujVviz0zq+btEw7GfRC9KaoOQj1oqT0EUk4ru3pdB7fdhJlBDH8ll
         0xBmx5xa6uWqRVsSKg9dKgTtJV3egtVNDs0P/xPbOBpkg4N/Z3LavrxhY2fFoONvgBVH
         e+Cz0rNMffkQuLlo/s0rMbzEMc314hGpqLVysfkFRaIWWHTkekvui0YgoN83Tz1ZM2Mz
         D0GGiwOFXqpuxJcVZb1r7PgR5v804JLMWzmxPBEz+mloRIDqsVTPgPDs9lhCdt3G9pSk
         9wPbKwI8Vv5kkFDHewk5W3MZSR4KSAgURPluOU03j4X61V44S2jMR9LjWcfI8r0lF9o0
         N+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772088916; x=1772693716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0hzYU3q02GrRjJcu/Pyj5b2Z5EuQS4SjPzjTKMKlus=;
        b=O7fPq9RQpMnQApDZgqtAyUiF9yUcqXHVgouEabEcJAR6W+FAwGSZQ2XLOQ5+1tfc6e
         kc5Ec0ohJbeEMPKsgMk4G1RW/fvHtI3bwtK02ZJmkMo7uK7Uj3+Gw++fvDTsYkHWV6bk
         6TMkmQRsvDo6u07JjcHUhbt2mVZUxeFZzuY6N539nNmTS0TVjE5oasl3rXinn+yPcMcd
         qFDHmDrVzXOHxARn7ic2Q3gVTHFyUutqf0Xp3BF3gyz6uLcQoDbsmLXJ/93H8owNPgru
         XS+m0QzShmGAha+fP1pm1KFTWDvUdHcP4t8jYuC+M63VysayqEq1uef7PP5AfpA+jTwA
         sFsw==
X-Gm-Message-State: AOJu0YzyCRq3Xib4aPtJ+D7KywyYTFRBB7XrUpsjsrV+eQJYQSEYeIwa
	8gopso7MwoG0p96SP7iz4r2p6l/yPDa0EuF4fRT1lLe0G50dHPUvIkHArVaX1YIJWM+YBlZFOPO
	dRZxYOC5/8BZvdjEnQV7qKBXelxRdVtWokI+bT3Hidh2Ux4tNG8/vZa1+N0e5ImXkWcdS4w==
X-Gm-Gg: ATEYQzzVwHSuAEk2bCYI2kiSdC6b8zS8yBs9AEWlXR0MDo3r8T469itT+graOkk7Ob2
	psFaCljcotv/OcLTfGcIsUCSM8YLAgcEkY4MB06Fk3kVqblsuJLFHkbcUoT2ti3Jd6taa6/YMZZ
	mhBe718WUTuqYfwdolJUTB7oIDiBAyXR4hczCIw/9xlYXi1QvVHKAE2pjW3PEM4cNXGlH3HDhBA
	9p/LHJwVjybducdynmy+onSPMF4xC2qNvgwUaTVzRvpHAggiXUYEualLa7B3BbUphz8+effBM+n
	Iom00XH6mzhukhAhOlro/iaMfi27nIIMwSUhjKJOd/ouyayvNgmHS/fjFk4bMLz26vBGOvMhZJU
	/QWQ03bDC7L/jE2laXcn/CyU9FFcSgBlEVdcBZJe0iVmCeBUy28fgyw==
X-Received: by 2002:a17:90b:38cf:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-3593db8972amr1533432a91.23.1772088916386;
        Wed, 25 Feb 2026 22:55:16 -0800 (PST)
X-Received: by 2002:a17:90b:38cf:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-3593db8972amr1533416a91.23.1772088915905;
        Wed, 25 Feb 2026 22:55:15 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm4791066a91.0.2026.02.25.22.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:55:15 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next 0/3] wifi: cfg80211/mac80211: Add support for IEEE 802.1X Authentication Protocol 
Date: Thu, 26 Feb 2026 12:24:39 +0530
Message-Id: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p8MjQGNjQTXhKV2sDj5bdiNGaUyyVCPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA2MCBTYWx0ZWRfX5p5atuK2US6q
 n/qZBWldVPeX/7uPBpF7/sIuC8FaSz6617wfbb4yI7X5C1YkpSZNPMPz24+q8HSCeiEl5OC3MsR
 ADJyu/lyGhxcXrEEGBmpw9PY+4m4ohGJIVSTMOiC9Jfl2YI5Zui7D0d7Qs5+UerXE9OIzooOU26
 KzaP+r9bRbuRv9ENjze1apg0WDjkuX8CTlcuJ9szR/eTljfDUJFRc3rD55AV+oyWeELOavBNzct
 F93tvaipKF4OW6gTOzg99c3YeuxZMeiQcmtzuPdrKHE5AzRxtFXV+ghrm02ekGE7SSayWc2rOx7
 wtuBh/yioReyQPlORHggj6ddvxt8EObVJvkDN7iB6X8FfIkcHgFXXphG6p0DJmrAEVz6+6tbTV/
 DsfyHFd0UQ5vBBZf53tBIokkK100trLqTM7VoW70/ocs1i4TmCPbHanh5FRl6d8quIXe7sCbYbs
 RBRI7QWxw+15oJE37RQ==
X-Authority-Analysis: v=2.4 cv=GZwaXAXL c=1 sm=1 tr=0 ts=699fee55 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=t8XZwY1FCuLPunNi3zIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: p8MjQGNjQTXhKV2sDj5bdiNGaUyyVCPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32199-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 91B5B1A17F7
X-Rspamd-Action: no action

Add support for the new IEEE 802.1X authentication protocol using
Authentication frames, both without (Re)Association frame encryption
as specified in "IEEE P802.11bi/D4.0, 12.16.5" and with
(Re)Association frame encryption as specified in
"IEEE P802.11bi/D4.0, 12.16.8.2".

This patch series introduces the required changes for non-AP STA mode.
For the AP mode, no additional changes are required for this
functionality. These patches have been tested end-to-end using the
Hwsim test tool.

Note: The patches apply cleanly and do not introduce any build issues
on their own. However, the IEEE 802.1X Authentication protocol depends
on (Re)Association frame encryption support introduced during EPPKE
feature development. Without this encryption support, the IEEE 802.1X
authentication functionality will not work properly, even though the
series itself builds independently.

Functional dependencies:
- [PATCH wireless-next v4 9/9] wifi: mac80211_hwsim: Declare support
  for EPPKE authentication protocol
  Link: https://lore.kernel.org/linux-wireless/20260114111900.2196941-10-kavita.kavita@oss.qualcomm.com/T/#m69c7b20e0e9242b40bfa888082f87a8c9211d46e
- [PATCH wireless-next v4] wifi: mac80211: Fix AAD/Nonce computation
  for management frames with MLO
  Link: https://lore.kernel.org/linux-wireless/20260226042959.3766157-1-sai.magam@oss.qualcomm.com/T/#u

Both functional dependencies are under review, and until they are
merged, this series cannot be fully functional.

Kavita Kavita (3):
  wifi: cfg80211: add support for IEEE 802.1X Authentication Protocol
  wifi: mac80211: Add support for IEEE 802.1X authentication protocol in
    non-AP STA mode
  wifi: mac80211_hwsim: Advertise support for IEEE 802.1X authentication
    protocol

 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +
 include/linux/ieee80211.h                     |  2 +
 include/uapi/linux/nl80211.h                  |  9 +++
 net/mac80211/mlme.c                           | 78 +++++++++++++++++--
 net/wireless/nl80211.c                        | 14 +++-
 5 files changed, 97 insertions(+), 8 deletions(-)


base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.34.1


