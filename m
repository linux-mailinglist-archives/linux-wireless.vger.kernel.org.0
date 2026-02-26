Return-Path: <linux-wireless+bounces-32217-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MfqJ5OaoGlVlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32217-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:10:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F40621AE35E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 585BB313A783
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA842980D;
	Thu, 26 Feb 2026 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2FfBmcJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AjWBe785"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BF31BCAE
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132178; cv=none; b=PERoDtGfIC6wepg02RiKl1urTKXAd9iA3HpwrLZcPliJWHYJtpmqJIumdELJi+1Pu3PoIu2fP2xO2HLugGYBJ0sycZH/KSe1YAjQJeEWFg6Kw0TDyEKNkwng1FClJllp2y/5xjlyMqf/bYIrKsA/IUEAIDeGCOhnGhV1R+Fxev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132178; c=relaxed/simple;
	bh=s1LL53BjpC9IrRfG9dml/y7AkT+KlCLPFVr3/ROSb5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHPlQtHLFdsb/Dwpd2WQz8ra0WfjTTzM0ci2dE7L/mkkOA25pUhCE7Xe+KQSsnk8HGotFVJBeycIJxCRvCM10BoFetm7Vou7tJ5vlFLmIkMrudo3BErHpThsZb+0ETDfZ57yLx5TFV8aSwpjlrsfA6ozdtFXp1FMzJSoQOruKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2FfBmcJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AjWBe785; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHEhPl1258253
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fKj/CcICp9PDeLvvomjj8kyw75w0symi7HX
	/c9sMMVI=; b=W2FfBmcJxIw6KI1qmSoj5GMuO7NKZx+qr9zrw4cnGTJr0Xve0iX
	HDZJv0fGJ/DQ8+ffpxcyHwfP1MBqMiVZVHiaRCWEao8SNmKmWUtKvwMEqtNL7XqO
	/TbY3C4eZaLm3tJHwByRLXd4fzK2W5XP0sfnqhCHALyLR5pnOGMen9FmMX8ffvuQ
	HyVb0NyVlTygH63xMl6Mz/rEzozQb1W4GJ44iY/wyZjZnxEly/ADJ6RXVjR4qmy4
	2wpfjjhLYO8pmMcMUUqVO0pbG9gGIGIHe/fEwhiZD96nUQARE819S95Nr02brmn6
	vTZnyA0MGg5dQAcyh4C+IctWO2bJ0RKCAtw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjc0gbd9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358dc09b43eso1037395a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772132175; x=1772736975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKj/CcICp9PDeLvvomjj8kyw75w0symi7HX/c9sMMVI=;
        b=AjWBe785nv/uOiBAKWKNtWlhuvtCuoJfTnjmjfyO4Mj2tSmZewE8/jfcZNN8MNOizN
         3oiuqBHygHq6Zm3iABdYyFozwjuoQGP4xoBjcMaj+ViUbJX4qBkG3O1xQC+HuZpTnQAN
         nOuDE6RU4FUvEV5GEElc6B8/590uvMwK/hEdola0zjwxYm42rKczfd+P6thbZ3Q5XRHc
         tsScBtsIzaF5L3c4J7nqSYvCZtgWSHg/Mrn0s8YzOg+40rnC9VjIxHbCCdk9ncMsT5hc
         wTXJauP/xXIxHbni2lULfbFn/sosSkc9Okw82GcsCR1HAIUXUUigzVUm1PIntFORiJ8G
         8F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132175; x=1772736975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKj/CcICp9PDeLvvomjj8kyw75w0symi7HX/c9sMMVI=;
        b=mgmQAgx7F/j+wOvVb+Np7fOKNtXw4LYSj7+jRSld2B/YPhf+5iowhE0hEh/Cm9V9uL
         XH58xMbqBlI3M7lEzvTq6vt0vifZ7GW/pkOkAfca/6j88iCCZrO5hq/cGLnUav4W5v/J
         2LnfFkAeXw2jcbCaMrFTR3JYCx+kEb19SppHKi5DTEOTQQMlkMRYOe/ejsSgErpDIo5R
         5jiFwxroW+qRAUT7n1UWbk98R4ztZcRqRTjfU1qzrNhkXwqdM097hltFoH6fjVdID2Kb
         bEgLw1LrYIDoHYCWtBNIsw0JSMFPd7cDyHE8ijqVOBIBdjLiDekMKOcfW2Y2HubVreSl
         rP3A==
X-Gm-Message-State: AOJu0Yxw2z9ikXrqBZ3SCoQ0Jdyz0iJK942ihtKn1w7bRjmphObKdkOb
	QY0cA+VdqOqeTAD5v1g8vuydaXW3IDv7gY6lnjxNdlcsKX0mJfbRB/AIXIkAId1t1dDYXi58/zv
	XhbBCmX1ibT8Q46O3jcSE+oaPWRGV8OEYDx/xFc5MseOSI9Ym18M9u98zaEHwyJGwutzZng==
X-Gm-Gg: ATEYQzzTkwZudBlvHn91VQ43svqWtXJNsHwPVMleEQLuWYZKGnYgX+oMiYdSzfF8EGH
	rvZ+5+xQPDdDKV1wbUcuPK2K2XHT2st0yPRdswsVkVNsJANlq3m5fChBopXQS9SRydwa8deQtxX
	SIrEhAMc5gdRF5g+a/vrYj0/XNnw2hUjWNvd04Vr8r8bjNrv4EC6F7xWe1wWAbL/zRDtHRexAQG
	aa4yVCrxW/GxL3nucAiMXCUBXqHe/0KrWo4kXcIFEwqCQLNeaAOprCe8BVjZ6BJ6QxipFjW2gdY
	2nlbA0zfkB20299Kb3YCFwicwMMcPliT70lfLsSfA6uqcmeivdFhDANvk1ckkmqRKPOpimCkkrF
	kzHRPgGEpxvln0j9ecNA4x0ky/82NhqMYvC//1HR/xt3OZEQvw0Ga1w==
X-Received: by 2002:a17:90a:fc4d:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-35965c2280bmr194203a91.3.1772132175454;
        Thu, 26 Feb 2026 10:56:15 -0800 (PST)
X-Received: by 2002:a17:90a:fc4d:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-35965c2280bmr194183a91.3.1772132174939;
        Thu, 26 Feb 2026 10:56:14 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm6375579a91.2.2026.02.26.10.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:56:14 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 0/5] wifi: cfg80211/mac80211: Add support for IEEE 802.1X Authentication Protocol 
Date: Fri, 27 Feb 2026 00:25:48 +0530
Message-Id: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XI49iAhE c=1 sm=1 tr=0 ts=69a09750 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=t8XZwY1FCuLPunNi3zIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3MyBTYWx0ZWRfX20aoYaKU2ne5
 4e7eXZVmySZkkAjm4Kgrl+SJ90Q9DQoGGqj5YyDpPppPhKTFtzYfMB9rQFXNcWSjSl9ih16fsW0
 jENyLNgvw5dVvLvcwQrXA45TJWx5wlgnBWRUj4P3DIoXPO48WKOPlI4xzQcivfI8dupUBuaSU8W
 nCe6MEPyAaebi/QHASkVHek0kX3UrAenNg2h6tqBWiABoKx2bGJXfcGtnM6pcQLHsnHqLBlI4/s
 3FmEYxwQ6FSzRqSHDKvLyDocV7aKM8quC/9x25RJqVQAITAve31RZNVueNs9WHgBx8or4bjKK2X
 9ccAei/hw7gn12a2qR6yDDukvmDjTJoiFq/s0zbOK3VqyVSxqEE21WAY8dex4XeenpvqHli4v2O
 lJwSSxMFaS867vR5p1zYVr8+zUgPkQg6qyaW8eSRBj6TlawNgCor6ixMXmgfc625bnDjzcDtnKV
 sr8pYpEdGcx8i3y1aFw==
X-Proofpoint-ORIG-GUID: 70auwOjNmn6a00mP_ZIYY--FSvr1QV0P
X-Proofpoint-GUID: 70auwOjNmn6a00mP_ZIYY--FSvr1QV0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32217-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F40621AE35E
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
on their own. However, IEEE 802.1X Authentication depends on the
below mentioned functional dependency. Without it, the feature will
not work correctly, even though the series itself builds independently.
                                                                                
Functional dependencies:                                                        
- [PATCH wireless-next v4] wifi: mac80211: Fix AAD/Nonce computation            
  for management frames with MLO                                                
  Link: https://lore.kernel.org/linux-wireless/20260226042959.3766157-1-sai.magam@oss.qualcomm.com/T/#u
                                                                                
The functional dependency is still under review, and until it is
merged, this series will not be fully functional.

---
Changes in v2:
	- Included two new patches for EPPKE/(Re)Association frame
	  encryption support, as requested.
	- Updated the existing IEEE 802.1X patch to advertise support
	  directly in mac80211 instead of mac80211_hwsim.
---

Kavita Kavita (5):
  wifi: mac80211_hwsim: Advertise support for (Re)Association frame
    encryption
  wifi: mac80211: Advertise EPPKE support based on driver capabilities
  wifi: cfg80211: add support for IEEE 802.1X Authentication Protocol
  wifi: mac80211: Add support for IEEE 802.1X authentication protocol in
    non-AP STA mode
  wifi: mac80211: Advertise IEEE 802.1X authentication support

 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +
 include/linux/ieee80211.h                     |  2 +
 include/uapi/linux/nl80211.h                  |  9 +++
 net/mac80211/main.c                           | 10 +++
 net/mac80211/mlme.c                           | 78 +++++++++++++++++--
 net/wireless/nl80211.c                        | 14 +++-
 6 files changed, 107 insertions(+), 8 deletions(-)


base-commit: 8bf22c33e7a172fbc72464f4cc484d23a6b412ba
-- 
2.34.1


