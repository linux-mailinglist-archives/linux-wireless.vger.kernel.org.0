Return-Path: <linux-wireless+bounces-23843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9046EAD18CC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 09:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28756188BC95
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC7280A27;
	Mon,  9 Jun 2025 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EhcOd3Sm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7F25A353
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452612; cv=none; b=c3anRz3DBGYy3XDtH9EdTdqFYBNwHHufRZw/sxFn2/OW4uouDmg8U6IOKt+qyGbI0kBSksafPRrb5t1XhcOM4/hiqJbPB5OoUysTlVnSkDIrqc5cxIEsFpZ1/iqzvCx+wPfa/RxM+GrYPldmoinY2Ikchg6WptwEbAuGzq5hI+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452612; c=relaxed/simple;
	bh=jrnCc9cpiTvrd2Ton5RdCme0F/XHAl52DoZxzWYFKqI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YwVIOVh8a++H1/ChVSZwbqxdV9kO+A12Oue94xL52SRGfKwPKcCLdF8w5+lDFLT5XQP6kr3ERn60UzJZuPHenu3zdjVsuNRnsQHIlKOjrqGMebOqSP5TcBtXb4btqpfRw2dcMHXOW2YjdJTC6Un0lFEC7EK40/UHp/rQWD0GXOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EhcOd3Sm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558MPL4g019298
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 07:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=8Ra1wqWIphFs
	ovwh3ZTXgZ95jQKsEPMChBMJvAgd+nM=; b=EhcOd3Smi/4/D0SaEGV2wJSztiiD
	4l9TTcO23pN3F08khPPvVs93sOiy6CNtauMM2Uc4E/Ez09sOmDvBNPnKCWxF/iSh
	r3ti1NkLbKy2nhLuG5GibzXj4sXZyoupLwRUi197wC/DY149xD4GiTldsPsLK8ah
	g+41SDmc9PKtU0bSoajxzR3N17FkhVkPmuEEABCxThjWKHzZmDKeah8xo6SSpopG
	G3mZ6pe0aA6NESJG0a7xkdrETenOl4yYCI4xYEzkxyAsTkzZPgiSnOLZLeEHvBPk
	gYQ0sGyX5anYTmk3s4PR2SmeLITsKSX7HKrweRQqaMCVg+rrNH4eF1MPxw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dt9n4ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 07:03:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-311cc665661so3369854a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 00:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749452608; x=1750057408;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ra1wqWIphFsovwh3ZTXgZ95jQKsEPMChBMJvAgd+nM=;
        b=J29HQFWM7CHapPqyuZjqDTQE+S1yMtwN3Mm7c658gUKkOPyrCtokRRXaBG6miW7XSI
         JGx7zohYAuraLZWGAmU3mYMEwktZIHZo3evkNbs9/gQNDCToyu6ZCz6MmFhrGwOntm5v
         KH7wJ6vsQRS3F9B3aiWrQKL4vgI6pnBmXUdt5+N6TnHsL99T5vMJJ+3ARierpyMsCqEG
         A8eMq0M4x+it/zrqT+LgSg7ewB3qREfRlfdYu+g/vbk3hajMZFdNkraMyQXr+DdWFcIc
         OE3uzwA1ttLNmKuwsmRsliNqzW3pYv9trZcAvp7su+Pvm33XYsjD53xUvo0DXeEh4CZg
         M/9w==
X-Gm-Message-State: AOJu0Yw5Pk4ANNSSPAh6do/YufjLcqvtnQ8cE9kKuZJOPGLiHNqR4gKk
	gsKRpcGBiQ4m7O1hb22HB59gXfhUCNzw2ziDgyhtrspgkb5wJc6aqePWw8zcDo7I87CZo9OCkns
	PDz6CzMDI/txwgr6xKGLgJ8Mep30KVynap7uJ7z/U9MCO5bvXyADa3llA79brHUj7/n7O6ojRxd
	UJhA==
X-Gm-Gg: ASbGncuBjbKqY9gMDisGl3U99Ei0RtBVmMFMRwFfV9P7JYVCqoi7gCY1Sveh0Cmthlj
	hyB3EtgbjxXuDAjZ6MoxtCjU6jxBMOQW/GpQ8RC+VtjKL4ZbUw0tFzY+iEAZwo5OSRd5jzsHFk9
	aAfdisWfcUCWab3MBcnC2Z6rmNUimCNDyNSqMSHBYhRVHXKVy0Hpp1tMZ2UhoxB4me+fK+cYtv3
	wudss95exdj51Vv8m3/iifZ1EDayPvwwN0V41Gjr1WYKe4Ux3KO/eUz838ixIB1fTPfLXt7LWxr
	KHj/nvnNFp0rjO3eM4hh+Jq5m2GPvmLpQau+UUJh3MGZnwtvgVURkrM3SLrR4k+ULZQVErAp/i0
	30LtiGz30CqXQmDY/jXAmzh2qPNay4gZs4BIHXX/qcsQcUULzS9/7p3Hh
X-Received: by 2002:a17:90b:4b86:b0:313:31ca:a74 with SMTP id 98e67ed59e1d1-3134730a07bmr19007435a91.16.1749452607517;
        Mon, 09 Jun 2025 00:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7V5f7E/XBzusn6PJBeVtyHnxhARL4aErHimnKCzdHiaiOTlAVSCn7WkCjtaBnIxCoRce5Sw==
X-Received: by 2002:a17:90b:4b86:b0:313:31ca:a74 with SMTP id 98e67ed59e1d1-3134730a07bmr19007400a91.16.1749452607042;
        Mon, 09 Jun 2025 00:03:27 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034050a1sm48592145ad.145.2025.06.09.00.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 00:03:26 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next 0/2] wifi: mac80211: extend beacon and connection monitoring for MLO
Date: Mon,  9 Jun 2025 12:33:17 +0530
Message-Id: <20250609070319.1033874-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=KpNN2XWN c=1 sm=1 tr=0 ts=68468741 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=i4tyqWzXtKAA1PsRbmIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: ZSwna34EIxaf6vKSGX3MttHiTiA3IVk5
X-Proofpoint-ORIG-GUID: ZSwna34EIxaf6vKSGX3MttHiTiA3IVk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA1MyBTYWx0ZWRfX4LUOlDA5jN1C
 j2Fw3OHBqtaUyO3CdIpl12ea4bVi6kw1cGkjvp8Kv09GOQoABUXii+3GBJpSgNxTIyOms6wPFS7
 6e6kQ900+zbFMXGlKXzDGH6th45JJuYANzzWFlz4cn3mwPNcMr9eAuGcthE4L9nVJIy9uRYi9tz
 nVnLE1cHFAgyZ67eYz9BcTH6sTeocQmKIz8Amp2YgR8lhGsfWBj1JCA8Jsnxz0x8Gb3nGue9aPY
 MaUJ9km4KzV9/fnFj3Q79FMfoRLJ6p2fSaDgZ+5jIuzLxb8mFmhrCDvuPq0F6p2hgRmBDGRBpkG
 1HgYnN6aOM1PsOK6KnYzIqG9E25dF28T+AwQhNGqM/zQ1qcU6iDyIoyV6xyR2DFIqGH3kJVYyai
 CQXEUp+8Me9KQEuk3A0VnvSpA+J0vqyJOs5KJNasqURDhf29JMSVWnZVdM5FZ8urfOwYKoB/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_02,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090053
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, reset beacon monitor (ieee80211_sta_reset_beacon_monitor()) and
reset connection monitor timers (ieee80211_sta_reset_conn_monitor()) are
handled only for non-AP non-MLD STA and do not support non-AP MLD STA.

When the beacon loss/connection loss occurs in non-AP MLD STA with the
current implementation, it is treated as a single link and the timers are
reset based on the timeout of the deflink, without checking all the links.

Check the CSA flags for all the links in the MLO and decide whether to
schedule the work queue for beacon loss. If any of the links has CSA
active, then beacon loss work is not scheduled in
ieee80211_sta_reset_beacon_monitor().

In ieee80211_sta_reset_conn_monitor(), the CSA flags of all links are
checked. The connection monitoring logic proceeds only if none of the links
have CSA active. The timeout is determined based on the link that will
expire last among all links. If at least one link has not timed out,
the timer is updated accordingly. The connection loss work is scheduled
only when all links have timed out.

Also, call the functions ieee80211_sta_reset_beacon_monitor() and
ieee80211_sta_reset_conn_monitor() from ieee80211_csa_switch_work() only
when all the links are CSA active.

Since the beacon and connection monitoring logic now supports MLO, remove
the MLO-related WARN_ON() checks in these paths.
Maharaja Kennadyrajan (2):
  wifi: mac80211: extend beacon monitoring for MLO
  wifi: mac80211: extend connection monitoring for MLO

 net/mac80211/mlme.c | 123 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 30 deletions(-)


base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
-- 
2.17.1


