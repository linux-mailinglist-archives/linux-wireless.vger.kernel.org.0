Return-Path: <linux-wireless+bounces-24558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902DAAEA333
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 18:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17361C44CBE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E81F0E26;
	Thu, 26 Jun 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAPGfaRG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834228632C
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954078; cv=none; b=AjuVkKQ6p6nJHNQTBTAHnP9jMTDn9TT7HDZCuJY6/C4dsQNkR75kVPW87REH5EqOfyH0XUQZzrx1+v9jqWu7aa0qGGXJfU9rriJRl1pfeT596sbPkSfiADdu5XiJ66hA2SjcTsnS0URB5pGOtB7lwQm0evYASIva5Y+qbLLlIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954078; c=relaxed/simple;
	bh=ztH7UfZNY1B5uTlt3zCjjEKaH8DWesMfYATw49S49So=;
	h=From:To:Cc:Subject:Date:Message-Id; b=s2/G/QZ4bG/TP+QxP1bYgC3RDQgQvqzdr4JjGeYTl4glwzScuEkwPbHMpa1Vi/uPhaIpLDAKZshwHV3EETwjN1FUFQwurHzKIP9fNZPPFZU2UjoNekrnRqxpC19po4WFkohEAbR0gzz/Qxh2xL06dlaSobcZqVy+XRCDnim4Hb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAPGfaRG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9AIgo026616
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=ic4uTVG5p6gm
	U+2+chEEhKmuuzbIwjd+b5McGPr7cwk=; b=UAPGfaRG+B0tr7BtSx5yEE1FJ+3F
	dg/0esIkbUyL/gsBIRJ7pQGCPxYhDLbAP12ZKtIQ9UaeUT5221QCNgymejnJNksz
	ztg/AcFwGN/zo7kxrgMI7YlhjJ6C2ZWMYgyvQ/xTQUg7LFXu80lJTsaAmae67yGD
	TNmrIq5TRe2Iz37jHyt1hru4JIVaRnsnZiNV7s9dmtORm4L2dr+18sALGRlptEBP
	fk6in2+o6PYRkV9EuzLxemL8uyryYwqVplb1hVk9Ijj19UUlmZbhalpnO6/idnSb
	Z2gBaXlfObQ+6Bf5GocoUR8sPvdgmwEZrnrE44xpGkYEfmYykSI/ecNiZw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5w3v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:07:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235f77f86f6so10652325ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 09:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750954073; x=1751558873;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ic4uTVG5p6gmU+2+chEEhKmuuzbIwjd+b5McGPr7cwk=;
        b=GugXNWbjXQguPy25NjkFufb0+We/02WVvm65sf1VmL6uxpIP8NDhTbmc+EErFjxjsP
         vL5N+Kyhrgy1i9OH/0i/z0B8wC6YxtU085VJ+RQezUiT+XmjBYTsThJEuJUzT7rl+Gbs
         w6XPGIyObjd+bvasMLYBeNMHwZJVqzBAMj5cZIbYo1AOitYozPOOqb+MOZ/3HzL5P+/s
         5euVoraKpriFuC3lWd1SzkVHp744gi1ujN6qlcKUHNWJVFqBTdQDEvzqMwWMx5kII2iN
         ffPXBCjUaOzHRzFEOap/AG1tIY/QIuqujmxg7LSiCwg+PnrG0Kg7VvOwdcnp7w6Gp4UK
         xgNg==
X-Gm-Message-State: AOJu0Yx8H+GdTrpW3ApfpfRMbvIbCLOzeQgx1MGAZ/KwvWSLxEv6ovIj
	xuL/dPnVMvZlYoC7+hfNe1CteXSsvJ5cpqKd0y4JJgQ4Jz6/fFWb+HDA0IY3G6cjfA8gKbU88zl
	v4JlxvrUXIlUnarCTAO9w9y/h7ZE4L9QiSK6BjR35ZMut80eKygT/RLOgF/7ZtQ1QnxcoUsBwVG
	XyIg==
X-Gm-Gg: ASbGncsqZeAXP+N9Gv6jTRuQ/GwrHKJg5uKYm1YxTCaII5maC+dReh9hi6sc3tUapUf
	IKYIYYSEyGB71Bn67qBcK31awzByeOWzRKO+pHZNsFjutp9mOAaLaI+/8a4Xho+HQVKaqQzFGPf
	EljYwdHQWgz4t7jD126YGFE7TBPZV/DDs0XDkHCaoXt/MnhmodwljHqXQL6D0ioVyTOt+wfM1ED
	ECFFkIrbUkPeKTsI0OB2lCqBD0al6fFyNMsKXA1sULfDI/kfJwsev5hSC9k8ay6DQrHm1S52hDC
	kFHLoB8XQBJQWbPpa7DQ9k0/HSvs2Wbc1hPm8fPFo3uRtzCmpGlA8hYAJoySD/zygI0AEPOCB+b
	2MYIgc2H/qHgkoM8DHzeGaGMqzVLZJNWb95PeZWHNr1xPO5P7Ud6c5twV
X-Received: by 2002:a17:903:2f10:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-23824044733mr131646685ad.29.1750954073265;
        Thu, 26 Jun 2025 09:07:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuKe6S23kOemAeOot2as/LM1Q0A38Hb36hnqTwSIaGO9+uOaFsDvS8yug8KUCECGpLvbhmaQ==
X-Received: by 2002:a17:903:2f10:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-23824044733mr131646125ad.29.1750954072667;
        Thu, 26 Jun 2025 09:07:52 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3fa0d9sm1410345ad.170.2025.06.26.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 09:07:52 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/2] wifi: mac80211: extend beacon and connection monitoring for MLO
Date: Thu, 26 Jun 2025 21:37:11 +0530
Message-Id: <20250626160713.2399707-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: tLHV2PWaNyfA45Dz6d87y8OQEdRjKp9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEzNSBTYWx0ZWRfX6KRWVDOWZwj/
 +Z4rkeMRc318X1W4/LP83HJJjko7dvgGh0wwwUF3ZFmUFnrVwaxLN2/xYdmOpb9dGrXp6UAQQvF
 21sl/dgdQPlsc4rKapR7Z7iVMu/AvG7hduhpoRL+Ytj1C5GuQuaxXmUsMQm11b2fv3JpEavI31f
 UG0r5vnMIKI2yRnWf93Nmht/cRj51EKrMqkBvEuD5MrpCRKMlTu7f/dgQnWuvnYiGBeJj1RqGA+
 ePnPFlSpAmlEHmxvPOu93ScLuYtIlbbfQ0qInhzM95nR+MR10phioE++9iYQhIfrZh2JcrYDOby
 bB0IbhVJHYj2xwPtlQ0aroZnS+cmC/YyWOqBfeu0ECn6b9cz4UIz2gJCw+eGQaK5HIU1zfmHFss
 mnZPng08ZFKMDcjCQvHUQA4dSD0Rj+0+mrhIgypKce6EqXGkXY3Vh9wld/RI8BDFCFUlGPmP
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685d705a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=i4tyqWzXtKAA1PsRbmIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: tLHV2PWaNyfA45Dz6d87y8OQEdRjKp9j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260135
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

v2: Addressed Johannes's comments.
    * Changed the comments special style.
    * Blank link after guard(rcu).
    * Changed the helper function name and return type in the 2nd patch.

Maharaja Kennadyrajan (2):
  wifi: mac80211: extend beacon monitoring for MLO
  wifi: mac80211: extend connection monitoring for MLO

 net/mac80211/mlme.c | 124 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 29 deletions(-)


base-commit: c73ebc0dbb6ed968cb58d04d82ede3b5fb95e8bf
-- 
2.17.1


