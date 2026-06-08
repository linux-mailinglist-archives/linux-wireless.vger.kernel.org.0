Return-Path: <linux-wireless+bounces-37524-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rGMTKDbDJmqzkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37524-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:27:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74777656A03
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:27:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=aSlj52Nl;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bu59XmWk;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37524-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37524-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23974300C389
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AFB31327D;
	Mon,  8 Jun 2026 13:21:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D24C2D0603
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:21:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924914; cv=none; b=TJMFxkFc4ElmO0ZPRdxSuqL+sesCat3Wva3iaFt+j1ky2s1IWCq0or/lAPUHkVoEBpsiHP+5JDVj7u5dNN88j+Ja8FTYsBGL8Z5gjWq/krGwNe0HPlJ3z+P/4F4L9SNPd/QoSVbhw30VVDX6MFjAwp/RjW+k47EzGlYX4/ZzwL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924914; c=relaxed/simple;
	bh=DtKgviKFchBNN7WwwvrgAUaX/NWo6PcLaRRQI4qJcsk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ly26Vp5YYEFomLk12N1RAKZM8dSgZEw89UwBH8zZfcZDKDYxcKRMuif5vabAEuuARaTDITKKrkIPjT1U0hneZIeLZPRMAwwGH2P8tHqcVKqJC9GsD93aQOTZrAToKaKKfd/iGnSWxWdMH5pDmclwd8rxlUaqjM32RcqHQl0dZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSlj52Nl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bu59XmWk; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9jWI2919995
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 13:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fEqmHXkDhVrdf0VTdQTKHL
	TZEqeQsjBP5qTz2xfevEQ=; b=aSlj52Nljtsf3Ff+u/32sjZxks7a4hYM+fP6x1
	3HEKdC49WzPVEwwgKyPWYwfiq1LTNlM3RPA1bgXZOcDyf0I4L82YrNMc/DPOgry1
	pRj6eDyONFEIgh0Amw5yVUpN+7tYzcuNCCSxZoWhOZ4/cS6NAaBirkCuwHhPt3mz
	nIm2LyXFz54ubNJW+F3h4V1or/6rRyZBRdsW0XwpaWSWDATO+EorIj3AA7tOV0Xb
	qKJ9Ya0kEQlI3JDzThzc9bZIQMDHhKjYhLw2GZcjkBcsCX4A2DwsKbGsQP7PrlUu
	QOntLc+f2oXR7k14vZdmAv7XdyEQNCpaQsAb/f2C5Ksm5gxQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgysc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 13:21:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30761ab3483so9520124eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924912; x=1781529712; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEqmHXkDhVrdf0VTdQTKHLTZEqeQsjBP5qTz2xfevEQ=;
        b=bu59XmWkMQGtZZSD4TyJKdAoJoSEui+Yk5Gls696t6piSTffmZas8y6/uL9EW/ZD0v
         h0A9UArt/zh8Dat8qol2ccL8MG9r+Mc/gV04GsYYKrkIttJMKeZOfZURrGZsErTjMwhN
         lEW1J7ztVEyt83os0ckKPjQpeOT/HS7imGPSHDXLndu9HO3G2id7hU+O/mjW1r6C1ZQp
         8L7htnJ56MdtcuYNJg8njIfuFxjwTMpRz/Dy1fk14NoTP9xo7lnxDThHRmJF9EdgFkMs
         1Byfn3g8KoIcf79kMlb7cLQnEGAmCprk0b6GDx2wQdumSd4C3WRrdz0IpPBEhfyOghQ2
         rgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924912; x=1781529712;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEqmHXkDhVrdf0VTdQTKHLTZEqeQsjBP5qTz2xfevEQ=;
        b=qFp3PCoh/Z3N0Z4QWnvdiiIJ4+4S+Eh7sE9Kfq/59xT9/SSX79abnWZnCa/4yXCAo9
         beokMKTcYNlaz7+cZfHebvxpoZ0IZx4WuHIHY2ywX6M7udW812SJ71qz9XABtvDDRmZD
         1Oim1hMh1iRZr8tQXAJOuvBol/IVWWtXUUXfyzP2V3DJvIM36NF9yX4KCNUW8D8hS76W
         DSHl43ET9J0lNDsf4jR/Ith9RK2cy0Jlt0IrH5gv99VrfaoO7Ui224qo4adlRe+0G+h5
         x2OsmBo+mT1E681G+nJhEewHAZBm88Q0KmDtX4i5ABCmj/BQd95ANUi2VgvA3S8VPjm7
         rS0A==
X-Gm-Message-State: AOJu0YxTSwhfzPGSe7xyMbFGV9Pg8bnWi3f7916uRnEagsdBsRyGSlkI
	+YfAFU7ZJiS2Gh65BpO6wOZDNHidRI2qVnlKuEZXGgzGDxXhturA/iwgb0UviKIigpKKdKlGJgF
	T7Sq1guIcPzDPAsnGm2+lUlTT5hbJGEi9pojzBBlPpgj5NG3JuO6ZIOmczXSla22drENDG8L+Kv
	XtTw==
X-Gm-Gg: Acq92OEANI+Z9q/i6BCutIQfOKFYSX1k3fbisgkeGWfNOSVZztXQrM6We/Za/KAw8vH
	7XhsN4mmPcMlmN5pUz96umXIgpo0SYsgb7qfXSGbGfrP/AZTfIjVBiDrgibQ8z3IapdLn984d9H
	vGauXqMTfRM0aQV1q7iO/mDj0wqT/k5YwaiFoYeb/vcdNcbbG6/LrUzfZHCC1M4EvyM5p0e01vt
	j0sJlcFUx0mQ8E884/0aNHL63P8wDWxjkixylmUttgwJ+mMIAGwV9yQeOMcSZuMUARS/sxFUg0j
	sqC3GX+WeQM655Xb/7w4RePwaoENv6EbBkF2R+yXaq5h6dqQUygUU3GtPNY3mudUrvvRqPYj6Qr
	K9vInOXubwC5gxaftXIbIlA7+s0gBlIxcW2EnD0tHl9MaHvBkTJQDFHP+6ZO27q01nP3YUy460d
	TStqjRUw2Wrd8=
X-Received: by 2002:a05:7301:1e84:b0:304:c520:4e0c with SMTP id 5a478bee46e88-3077b2707b0mr8229731eec.6.1780924911970;
        Mon, 08 Jun 2026 06:21:51 -0700 (PDT)
X-Received: by 2002:a05:7301:1e84:b0:304:c520:4e0c with SMTP id 5a478bee46e88-3077b2707b0mr8229708eec.6.1780924911418;
        Mon, 08 Jun 2026 06:21:51 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcbe995sm21607280eec.13.2026.06.08.06.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:21:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/4] wifi: ath: Update copyrights
Date: Mon, 08 Jun 2026 06:21:31 -0700
Message-Id: <20260608-ath12k-copyright-v2-0-37504d70b03c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANvBJmoC/3WNyw6DIBBFf8WwLmbAd1f9j8YF5SGkVSxQozH+e
 6lxZ7qZ5ObOOXdFXjojPbomK3JyMt7YIQZ6SRDXbOgkNiJmRIGWUEKOWdCEPjG34+JMpwPOBCk
 oFNDUAChio5PKzLvyjuI3HuQcUBsbbXywbtm3JrL3h7Y4ayeCASvCH4w3SmSyvFnv0/eHvbjt+
 zSe39jB1394SVhFVENFnldnvt227QsOxZGZAQEAAA==
X-Change-ID: 20260604-ath12k-copyright-3d1520509800
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath10k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a26c1f0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=NZvTMgFr6E2f7DfL6gwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: e7UYDhjn8Piiiy5-bv4xPD7AGpPmf6YM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNiBTYWx0ZWRfXzdDsKFyBpeGX
 WprS91fmjBsU72YDk1bj+JxNw3iGW5MvuUu0c4udo+ZKZRmrSDlFHh1oNMFfBHnlzWf9jrBk1bC
 8VxjInKj3F+IwLD23Ot7K37r2AWLNSrVtuQ7Nd4s5zprmTbuWpkcqDSN/8AaGv1oW5+C4AmFlZC
 7j3Q1OAddGmbLT5bY+7oWhkZ429Y323YqDSzj5M6aGMiDrMWCdMYNz1WlSpm8ASyMAiRuBg+Kch
 gXm73LnQ7orlb6uAgcqWgKMvuHJYtvGa6Uv1ngsabncimsD0UVbxjIVKHzDL56lgoKrem9ZzbEL
 xxt357ARM0G9eA8ySekRCwniA6gW3+4/uevOq+BpX5I+4JQZuhTtCUNpL5Tb/IcmYPTZL0kt/pQ
 4vlvMokQGfaUkFno3/qAedXX1bKhPZQN61Adg0zrDc1ofa/D0WDOtu2oW1Qs8s9XNb8BvCQ9CMd
 NuZbRdz2qedmJdttXVQ==
X-Proofpoint-ORIG-GUID: e7UYDhjn8Piiiy5-bv4xPD7AGpPmf6YM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080126
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37524-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath10k@lists.infradead.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 74777656A03

Update the Qualcomm copyrights in the ath wireless drivers that were
substantially contributed by Qualcomm using the current guidance from
the legal team.

---
Changes in v2:
- Add new patch for drivers/net/wireless/ath (only one file affected)
- Link to v1: https://patch.msgid.link/20260608-ath12k-copyright-v1-0-e1a71f92d447@oss.qualcomm.com

---
Jeff Johnson (4):
      wifi: ath12k: Update Qualcomm copyrights
      wifi: ath11k: Update Qualcomm copyrights
      wifi: ath10k: Update Qualcomm copyrights
      wifi: ath: Update copyright in testmode_i.h

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
 drivers/net/wireless/ath/testmode_i.h               | 2 +-
 89 files changed, 69 insertions(+), 89 deletions(-)
---
base-commit: e1c8fcfd37f76b46a581b794e27765258c9a537d
change-id: 20260604-ath12k-copyright-3d1520509800


