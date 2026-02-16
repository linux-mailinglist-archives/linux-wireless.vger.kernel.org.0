Return-Path: <linux-wireless+bounces-31876-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fi1AQeNkmkFuwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31876-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 04:20:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DE7140BB3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 04:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99305300231A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 03:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34C62AE77;
	Mon, 16 Feb 2026 03:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R7sQ5XlN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ibtW+5NP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805A21FF47
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771212034; cv=none; b=b13Bpn2rgOq8A1feGpfcVqqRNFPtFgsP/bSMtxDucndgySMP32raRXpsR4BeMDrtO1ubiI+uzzHpMpgDA55fQwxWFhXDEVnZAanwDc2fwOOjUQydzwjnupBN+fijiBIx82HAOVzauf/yTIZxpTUUMLGTqbctzkoJFvjeTm7U44I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771212034; c=relaxed/simple;
	bh=JHpi0oeltdEqEMhOjcWVVeqm7mneLN5erhczaQlxkHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ISS2K4+uX1E4DE8YbpryDW8u/2aMdLXLeNbgUIEGx/dDoEpSJNA59L9CM6HxCTgGwNhJ/ibB8DnDVIvmFLRQsbLF7aiFHjvon7FEFNC2TjFBwXSSEsRA0er/Oxt0sT1fb/qNsvfzoZ98cAN5Zv3JKImqj30P3AlWN/9jORZiMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R7sQ5XlN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ibtW+5NP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FKtEwW3272627
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Mh/Mhrg0ZfUu/DdHxcHttw
	h5SAG6bG9e4k1iEZB0zhU=; b=R7sQ5XlNUEI9TcgUVJS5VUn8ooVRS+xhNFnS6M
	ffu+BMJUYYdvoroRQwzCGQ5l2V8/puJBkZ2a539sCvK7i/YnE/K6oCILWd3tGS+/
	nW6OQfe7Hlz0WcITNWVnTCe6EESYvE2v/wflgbLUHlhvgkNEkOorW4vT+rkqXqRr
	hXU2pQ8aOX1LicDWMunyeqyVIjBvk6jcCXGkAWvsiFH/nRiyFZWYG4kwfEWgJOfZ
	4zZAISXcYznq6lycrl69dvrlxmawk3kaiHbYrr+G5rEVIXck2qvLdLNGShqMLoHT
	7cl0pVLbgy5L77FEaqURgr9kfV6ZLgivGvz3ehAV4dcsy1TA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4caj7jb4gm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a76f2d7744so30111485ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 15 Feb 2026 19:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771212032; x=1771816832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh/Mhrg0ZfUu/DdHxcHttwh5SAG6bG9e4k1iEZB0zhU=;
        b=ibtW+5NPe2roNDsy0RVGlBd4RPkcMzHTGjWyuVUVUS8FPoqtcDlzDFQUkv42YIRD/7
         gTDshwPdpiK3GnL2xKuGc0BRaTX6kOPXGNN8oHV9D7HG9dy0Hj3WY+f3+4re+Y8OCQB9
         j8WWKmiMCudfeU8veMECESBXXj4gmTXuGUiUPBMj/MxoI8OYDrH7nKioauZ7J9gYatZk
         /HGz6wRWGjFGuzZxYeWCszEkJITE5mQ2ysemjEehztRj47NaWL0AE6g8j+0oz010SLVR
         nt81bCd+Jkys8iuMOU+RZDx1IeUObARPmSy3JZhkH1O1IggeFWAAV6O/NqpaWRBZw8ld
         H8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771212032; x=1771816832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh/Mhrg0ZfUu/DdHxcHttwh5SAG6bG9e4k1iEZB0zhU=;
        b=POzbT6cgKUOXeWYAVsaUMtN5v7+a0me5Uj9asxU5vmLJS0ovEyQA2AMSrZoChKNBDb
         QY1IuZCOjzsvoLn7+03Z0Py0HgS3/lhLVhltPX5Tgc97hwmcOnDbAK6INRVi8oq/u+fx
         Ylr1vvAeJmUUQsjdpHO34eqaSIYRfgpLsEZFb5oQCHEBhqAFFG98Sqfi+lV2iYvVE6dj
         tyZhr7oeh8UBmybJvFGzkhHx+PRgXEijecPiz6E2aj1BMkCNEhHL4Yf4Rky0LEtjMSrw
         AafKMI/Y3iZLww7/0Ua77A4Kygo58trqrY84bq86WM6TK2QQ2Y3LC3RWFM0n7lIRat1c
         0+JA==
X-Gm-Message-State: AOJu0Yx9rSWsRZk5UcNkveShN+NsQXDRGoeBetezMLPKmPhyaOQpPbCa
	d3LBRMZqn6DsmDtKqpDemc/YnwBBRYhVcZ6Da4idleSAMd5Smul/RcJ8ZHkX1Egs8d/vmt9cU2A
	fSgsNHfg51zJirH6Ptt8tS/Kl+zw8g+QJbghST+H5G7NY29rzEAl1052TRGEu5XLyTw3YBOwkz+
	BNQA==
X-Gm-Gg: AZuq6aLjq22Db/Y6PKqHjCMY2RzEPMu+q4Mkre7q0QGSdkM3JWjkyr53R1U/3QssX1l
	KYqMIbSVh8zwnTNwsjaRd7razHom9R/FcSiS/ailtWSLUzWpQa3EQ6+f75Sj8E1W+l9e4FxaQ5v
	i4uRToa1+0ZiMXg7e3dMS5V5PvOnoOOnrMkls9G+t9wqZcKYLBHnjzlsCiRbP1SRQnmKWHLCUVN
	2LU/MkZ2lCsb/0ILmq8pVHSUo10UKjZmwzY1+6HAfiSlcQ7Lz7Ur2zv86Zr1UIo5FbiyuZWiBnt
	X0hq4KjzlknJlMGpdZ//iKfnTbEkf/TS7+eQHA8ybOcoHChy4GCLebntbF+hqrhH0nAqMmb/SZi
	7Ev9oEgsVx9Qsb6UWTncDZEb0cur3HuVroIqCmDgWZqVAHidPfTzzPgPUwlkdUpGbT0kinYSDnc
	Ph6aFpIzHi0FhEuesbUopLDj87+N4xVeBBs+w=
X-Received: by 2002:a17:903:240f:b0:2a9:5e0a:519 with SMTP id d9443c01a7336-2ab5064a24dmr113877815ad.61.1771212031749;
        Sun, 15 Feb 2026 19:20:31 -0800 (PST)
X-Received: by 2002:a17:903:240f:b0:2a9:5e0a:519 with SMTP id d9443c01a7336-2ab5064a24dmr113877605ad.61.1771212031237;
        Sun, 15 Feb 2026 19:20:31 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5e1asm54637485ad.92.2026.02.15.19.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 19:20:30 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com
Subject: [PATCH wireless-next v5 0/2] wifi: cfg80211/mac80211: add support to handle incumbent signal detected event
Date: Mon, 16 Feb 2026 08:50:25 +0530
Message-Id: <20260216032027.2310956-1-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dIurWeZb c=1 sm=1 tr=0 ts=69928d00 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=1P1qi0jZ29cQl9APfZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDAyNSBTYWx0ZWRfXw1r8ykktVczQ
 pRhB+r0aTpTWA2npvhI4JBEJQcU9xnVRy2C6gAPFvOvINV+kj4Vhi0M/QF1LX2xAmqLBh77pK/4
 3EsemYa2KApylNeCIc7HpdD2iJArnfKHljSMZ1viU30gGigR+xB48DJuDPOrZ+j9VSrGUnD0fxl
 UYhqqHdElWoj1SQBc7YJJMg+5l72oXGCJdcBPW9bW+GqCRBOOQULdfBbNu2KKpIvEwoLdzd+Xb5
 S9goW3cCuoCdz0Wz6VdaxL0w6DJIrY/5BCyjOnsGgtVjrhW9qaZVde8q6IMWPXe8A0rSV9jaMzF
 +UiOGW3X25ZmqK/oukS00M0jQFoGQGJXpr7BBaWkBfl2fyR2TK1W7yfxm4iuDpXfgRJ2ZvSKBkx
 fPhaE1NDCWCwu0BVHCSQFVwj3KSAFdatXJxcG9mnICLvG4ISPyYOM5W89ffeNr4DiTjCz4drImL
 7P0DmOD+r8r/QY61DOQ==
X-Proofpoint-GUID: Yd3M5r1VtaXlSvQXPW6hm3mdrS0v5HJ5
X-Proofpoint-ORIG-GUID: Yd3M5r1VtaXlSvQXPW6hm3mdrS0v5HJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_01,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160025
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-31876-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 84DE7140BB3
X-Rspamd-Action: no action

This patch series adds support to handle incumbent signal interference
detected event in 6 GHz band. When an incumbent signal is detected by an
AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
vacate the channels affected by it.

Driver is expected to call the newly introduced API with required
information to notify the interference detection. This information will be
ultimately sent to user space via NL802111 command. User space is expected
to process it and take further action - vacate the channel, or reduce the
bandwidth.

Aditya Kumar Singh (1):
  wifi: mac80211_hwsim: add incumbent signal interference detection
    support

Hari Chandrakanthan (1):
  wifi: cfg80211: add support to handle incumbent signal detected event
    from mac80211/driver
---
Changes in v5:
 - Made chandef const in cfg80211_incumbent_signal_notify()
 - Removed mac80211 wrapper ieee80211_incumbent_signal_detected(). 
   Driver/hwsim calls cfg80211 notify directly.
 - In mac80211_hwsim, switched debugfs to custom fops with .write that
   accepts “freq_mhz bitmap”. Now 6 GHz chanctx is selected by primary
   20 MHz center.

Changes in v4:
 - Restored gfp_t in cfg80211_incumbent_signal_notify().
 - Dropped incumbt_sig_intf_bmap from ieee80211_chanctx_conf and passed
   bitmap directly.
 - Updated trace/call path: api_incumbent_signal_detected() to take bitmap
 - Simplified hwsim: removed helper struct.

Changes in v3:
 - Removed the workqueue mechanism in ieee80211_incumbent_signal_detected(),
   exported the cfg80211_ function that sends the NL80211 command and called
   it from ieee80211_incumbent_signal_detected() directly.
 - Renamed nl80211_incumbent_signal_notify() to
   cfg80211_incumbent_signal_notify() and removed the gfp argument from it.

Changes in v2:
 - Updated the kernel doc of NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP
   to include details of how it interacts with puncturing.
 - Rebased on ToT
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 80 +++++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  2 +
 include/net/cfg80211.h                        | 23 ++++++
 include/uapi/linux/nl80211.h                  | 19 +++++
 net/wireless/nl80211.c                        | 40 ++++++++++
 net/wireless/trace.h                          | 19 +++++
 6 files changed, 183 insertions(+)


base-commit: 333225e1e9ead7b06e5363389403bdac72ba3046
-- 
2.34.1


