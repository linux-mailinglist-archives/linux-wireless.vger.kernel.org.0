Return-Path: <linux-wireless+bounces-38259-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UVnHHKYbQmpn0QkAu9opvQ
	(envelope-from <linux-wireless+bounces-38259-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:15:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7284B6D6DC9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:15:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RjSdaxMl;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="PS/uSsXV";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38259-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38259-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 073C03055766
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171243B42FE;
	Mon, 29 Jun 2026 07:01:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC393B42D1
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716494; cv=none; b=cApqLnsacHcw1dH2Hb8QCGc8E3jHYO8LvBnbKZ3zXOLTLA2WdaG/D5MrZtPR5EEqqHGoPEM6jDzJdjJdTE77fb0JZ3d7JhFtlQstKWpzFbyNkLTYBp7EZGQtTVIg93DcVxbT7zn32/WLTG8l3Es/86c7Mr25f/krt9a0pHOwM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716494; c=relaxed/simple;
	bh=lLzUZq/LBN05YYsPAaQ1nrRTaJ1fXps4c8mp7hzMtrc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=klg1GGFIA76INULOsj6JeBadpc9ZtgndHWnMRIure9mIIjgb7HexYop6senTSd87Oca8ectToDmraMsQEkIGfk8gU80c0ID/2jj1YlC6IXR4xe0EtdQIZgWV1IacmWA3uyXVn0SP/Klo63xdRtRH0fYcfBPrbZ++m3aekTCQEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RjSdaxMl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PS/uSsXV; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6rD2Y2135783
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kdnraEcqhLa2+TgqxQBmlP
	FqUeeVxn9EJRV+IdmVZhQ=; b=RjSdaxMlVfEhs2QPAqED7dy6a22Id4K4/uE3RF
	qFtmrt0GtfuSwBdfVhHo/bGnGfIjOKdc+c5dxVGj8yHSRMYBPDG/UFlMG9JS3MjR
	BgHdZmFHGyHm45fVou8vZojVW3s/3Tz7VJIhSwGaBjyqNLLZ6pBZxzUuO7lN4KHg
	lZP3nbCHA8ALN9AJsEB9b58q8mnQ+7sgUvd+h6oFbwJq692+pIyNRxg+ZTfXpRBS
	Ma+JomBzHO6KAaTpGxFODOgg73QBUeX9QT449Y5RG5BuwWAkxWUWr6NAmWvyuJfU
	Z8BweGK3LkLhvvgjgluq+PR1fKHxfqlXoqWb+ASpRztHp7tg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tun1tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:01:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso2187023a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 00:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782716491; x=1783321291; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdnraEcqhLa2+TgqxQBmlPFqUeeVxn9EJRV+IdmVZhQ=;
        b=PS/uSsXVVL3XokkAJ2OKJJQihYYY2rMFIh8Xc1tniMqY5Si2dFgbhs5juOFXTV9Eya
         nq5qAXJXxGhci80Y0fu7vWFIWhOOpGmKo9s4X24VCjDyj/FFVM05VuIZiGuaFugvLnHN
         s+N9fGSqwRlTp5na59JafqOJbmWjiVciKD1RDSmBsFcxZyNAd0FV/32wEWq3ycUA/v+o
         zhIfq/iOXoM4RfRSmKQ/Gv1qiR3f2+R4KOSvM2ZzYoILN0U0GQksypyIgDDryeNhBPCU
         KgZv8XfVAm7otdcynvFRSgM4Ihy/flEmWVOO3YEsxowCEWDPLPSU9NtMtOi8rWLkPk8y
         nWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716491; x=1783321291;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdnraEcqhLa2+TgqxQBmlPFqUeeVxn9EJRV+IdmVZhQ=;
        b=gJD0MzM/0powvubNAb/fVmo2dWsMxzZo182+NMzb36soxE65lb/FfTqAjw++9dha7R
         EIth2a5yyxlBd/hVGqtQkCVtCaeUCehpOC2LSrW9/Bboy4jfhKesJO14YoG8ZBC2E0cx
         dcovc+4MiMY+u7HZPxWN6i1aEBtah0gpaajH+nlkGLlExnWLFO/ixI5KZrJMj5Dgv7l8
         dVw0Gn9SG2Fx1/600ewMNh2Z3d+qrgXpH544mhWMdfD+DrHlZogkWsE9qdbyEKexU617
         LcYRdetztMrkzcW3NHYk8whV84FQ0OOnqrnLsZW/mii/BKDrydEgVN+QCvN+DUQSnhGG
         7zvQ==
X-Gm-Message-State: AOJu0YylQV1cXwaY1ijkr+KtXX5QcjxE7/nHBu7X5JrtWjM0wUgBvgFF
	NtOPtQ0mNLuSq0AXJnHo7Zlnc3Bhhd5B5jCyXRd9tB6neBw4p2vMucTZMQjz50b3sRsiD1kNzCu
	GDuJVC3pt5w9g1qihdTfdvgQD19z2o2zeMKwMIuSOK3lpFhnwk5WOZF6skAg6gmzQDHSgmg==
X-Gm-Gg: AfdE7cnO6m4M49tCU65TDi0YAz4UWvfUn7If4tIzC/rar+v4n0KGWxyJua4x30lYhpp
	/Ynlb9a2sDw/HqcQ8z+EnJcnLiQZ9qq5wkAzoPmhDZDDavwMr9CVfxVx2tdd0HaPHivSku/dOt7
	ouMnlq03vzAYa4fPq+BxSIKAf+CSSLFl/qWs4k/S6Ys1GM03dAslUoIpU9qlMmoj/nrpqfvNd73
	PYOJY4wSBqahoRIJzTkkzLrnXywgCqA0ucNn/xtwQiJkO2ivJao+JmRzrZwrrHkcDYyxwBU7cZO
	UolY7W4/A+H6BvrsIbpdMs1JXvEdT0cLlZshBpjl3eXmpaUj426pQKQLCc5Sq8zDtGSUbsiAowT
	3YtZxq1AA3QhWWl58QnflLi3fYQEAWfMdY6aIwsxxFxhF+QOfAe4alf0aJZAuMwzC
X-Received: by 2002:a17:90b:3f10:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-37fdb062e8amr4667870a91.21.1782716491123;
        Mon, 29 Jun 2026 00:01:31 -0700 (PDT)
X-Received: by 2002:a17:90b:3f10:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-37fdb062e8amr4667841a91.21.1782716490657;
        Mon, 29 Jun 2026 00:01:30 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e2048ffdbsm5276706a91.17.2026.06.29.00.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:01:30 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/2] wifi: ath12k: fix peer delete race in MLO
 scenario
Date: Mon, 29 Jun 2026 15:01:16 +0800
Message-Id: <20260629-ath12k-mlo-peer-delete-race-v2-0-362b25590d19@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0YQmoC/43Rz0rEMBAG8FdZcjZLMvlbT76HeEiTiS122zWpZ
 WXpu5vWS0FbvQSGIb9v4LuTjKnFTB5Pd5JwanM79GWAhxPxjetfkbahzAQYaKYZUDc2HN7opRv
 oFTHRgB2OSJPzSI2MwUVrGeOGFOGaMLa3VX8m5SPt8TaSl7Jp2jwO6XONnfi6/1fCxCmjkoMNW
 EFtLTwNOZ/fP1znh8vlXJ4l95vi5m/K1cLLKJUKsf5JLZdOsL1OHpNQyIha+FrYynPYIcWG5Oy
 YFIW0xnFWhyArDDuk3JL8mJQLqSSGCpTzoHdItSXVMamWWkIpXkT0lY87pN6S+pjUhTTMMs9tN
 Mb9Vs88z1/qUnPzwQIAAA==
X-Change-ID: 20260602-ath12k-mlo-peer-delete-race-74fdaf880017
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: wAavC9ft8s1pNzcUrPJOfZsAIyLyV0TY
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a42184c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KYRmtTUs1ONzUHfUJuUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: wAavC9ft8s1pNzcUrPJOfZsAIyLyV0TY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfXw9btPt0o5vve
 +EGFcrt/yRhs8aRl6HIs1vle2A31Yoz96wzr4xVIuZmQW/obVSueOVdCPMQxTFMpHRYzahulajZ
 +Wc7tU8s9xsnQ1hijil0IqNEx6UCn9yHynVioNLW+cTvGR27rhD1oV/oAaDSKvDUboaTlqxcqnt
 P1tS9263XvNabbHthdUK0cXO42r3s701rfebEZ1KY469TvBTCnRAAKxsFUfSxF4XReYuIk61bUy
 YrbkMI5ynrShJDC8oP9yF+0wFDvjCCHBGEPlMJvAuxDd1OV6LDRrQhSxNAe4GPAPkX8Km+SqdmO
 PYYrA/k9CworZ4FhickswUFOBM5cOUwOD0FmXejGlS/fMhIFrhDsJab76spCHuHBiav+r/ibGfp
 VhuRe1dt2USLl1J110cylq85LW2yW0Avrb+3RCIJoTibI8YSz7VghH9NZ8G9/LBPIgKBLtNJtJA
 VTGHVg07dukw/+UJf2g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1OCBTYWx0ZWRfX1ttl/+7n1Sdr
 JYKXuhs/T4eb10WNJbg63EFlVZKpHavmzTLB3O2VJ7sHCNOdb9KWroXk0Ak6C5YPhszUgTRAtXe
 6juEGgKEpaphd4XRRlgLa1IwmyvSFlo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290058
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38259-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7284B6D6DC9

Patch 1 fixes a pre-existing UAF in ath12k_mac_vdev_create()'s
err_peer_del rollback path.

Patch 2 fixes "Timeout in receiving peer delete response" on MLO
disconnect, caused by a per-radio shared completion that gets
clobbered between back-to-back WMI peer_delete sends.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
Changes in v2:
- rebased on ToT
- patch 2/2: make ath12k_peer_delete_wait_register()
             and ath12k_peer_delete_wait_unregister() static to peer.c
- Link to v1: https://lore.kernel.org/r/20260617-ath12k-mlo-peer-delete-race-v1-0-ab3c4f455dfb@oss.qualcomm.com

---
Baochen Qiang (2):
      wifi: ath12k: fix dp_link_peer dangling references on AP vdev rollback
      wifi: ath12k: fix MLO peer delete race

 drivers/net/wireless/ath/ath12k/core.c |   2 +-
 drivers/net/wireless/ath/ath12k/core.h |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c  |  20 +----
 drivers/net/wireless/ath/ath12k/peer.c | 130 ++++++++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/peer.h |  14 +++-
 drivers/net/wireless/ath/ath12k/wmi.c  |  16 ++--
 6 files changed, 133 insertions(+), 54 deletions(-)
---
base-commit: 1547a99cd8d8c1ab3e04dbd92b72b3b5f7cb85a9
change-id: 20260602-ath12k-mlo-peer-delete-race-74fdaf880017

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


