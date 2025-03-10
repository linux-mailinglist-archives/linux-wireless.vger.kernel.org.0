Return-Path: <linux-wireless+bounces-20125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC9BA5A7DB
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 23:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E53E18936E9
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 22:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296271DE2C7;
	Mon, 10 Mar 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ht8gxgfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5539040BF5
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646136; cv=none; b=thsUmK5L11EgpO4imsVsKYCmbFiU2LBvtCy0ZYdvgs4BMM12DtU9UKylDQoLbMqJakBZn7sTgDGs2blBO9DDZAMrj3Iwbl6i52WWA72Ad+jcfxEgCmcvdp78lYzUtxK4aT9Ram1qAVx9Q3kSPfE9IMK/gM2CHNywt9pU6ZI9pBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646136; c=relaxed/simple;
	bh=HO9Jm50+TpUA8w2MgoFAbvPpnHT31TvQPc8GwIFMtP8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FLqDU5vHomvIlqAIVam82hX8L7uy76ZJWlL5l84Wsfo3NoYJao0nm9Rr6SUmscIurLBONW35863lseS6RZhOfPxg7J6xOeZJ28L5LjAxmYFny1/S2YgfahakUAiycgc3bdHhukhtK8NoaI8XoNW3gSQxhf45GcCky31EE2DVAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ht8gxgfB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJkxMf002013
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CrGzTk9nMd9Bv/fY7rwJgSD1XEzoN6Bd/By
	GHGQXqdU=; b=ht8gxgfBykghndHpYA1Hu6nM9zSSGExbppoXa/ct9xkEByfjcZS
	FzBn/YLHj2T1UWrqQFnbAMcBoRdLopySaIeADXqJL+dkhgl6yKUES0bhCqx23ice
	3u/UuPVRzZwf81zal+2vSNc5zB2TQOBSiCg5LDDuB8+WByPYd6T52EY31UihJ/dR
	kJRG/7Nq1dMLsPaY1svbMwHgUh3rHhdKKiCKSpyGefx6zqfe1s/9ClX8XB6xklbR
	uSXgRrt0NjDw6s4KS7jS/7tXCXd3IgXzNKM3z/ctiJEq1Azueiz9hGoKxK/+EhJY
	+uKII5GiU204mF4QbdBCnkhR66c4cfNoeEg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyt691n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 22:35:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242ca2a4a5so43406345ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Mar 2025 15:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741646131; x=1742250931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrGzTk9nMd9Bv/fY7rwJgSD1XEzoN6Bd/ByGHGQXqdU=;
        b=UC1/wsnWEaxHVUJQLGRQjOgvqow2jA0XgWsncpsgzWrjT9QdFSIuxddd3u5HjQrnAz
         t981F2njh+FQilw9ktkEVnrwVCee9zTXUkOfR0BYBya+7EvK3SaZMzdDLDMYJPpR1Jjh
         n8o/AUoVNq3/ep5qqyIWA5NVXMHnUBMhTQ5kO33Xl2MPugmTuHHDQjvLdKQHpw3iCvcc
         GjOGc9seypn2rvJP/WJR7jHstsvXxRAtPi0Z8lK6UcbHEMqeDG+GBJxU7BkoCyDtIiVd
         3oBwAWd02obh4nkY3wqyXroycCqlyfGRfmn2x29pHK9f7RQjqWr1Max/CDs7Y3CY6kS0
         HR2w==
X-Gm-Message-State: AOJu0YwMHQlsF5HD5NGGhQC5FuTl/U8pVqA9+y2y7oq2OcmtSjnxXs62
	Obo+2sJXCa3jYR7AFmWBfo+WedwVLsgecgreZfEPukKqKWHQd/ikrIkzSq+CCCiNYUyjU3D1rri
	EDAZZRhgJeyc+KxG1Wqm/cpgOW2VSoqa41UFfYoUiQU0LPwPAtvWPEPTuIww0lmdKpQ==
X-Gm-Gg: ASbGncvCKRzyFZfM8IX5MUXhBtKWCRTtsBd5KoxyLmfKmJghal5hCOFv34jXvAzmq+y
	XfKsLEb5JXIFNArzDYJhZK5mKESSN4VJjX2r+LgHghqpI4sP7f3u6ft6QQYTMlrbykL0f8v96tq
	SD5yQ4w2h5z5zowD38iqKxISr+3lHFySpyMfMgmI7bd/zjdOaPGB+hbyB9DE7AdgaeWrHa64kzv
	t/diPRMVH1XE4j2CciIea3McYbpnqEo59jT2DgGoegHZ9wvD+gCeeV1lYOdwuaWk2yF94FXVEnf
	pngo4cPJC9AefCLyDhrelYQV5bA/d1tUQHF0R/6YU+uqo01Xpdqs10/sj+4H4Da/jLbh5ZVg
X-Received: by 2002:a17:902:e750:b0:223:4bd6:3863 with SMTP id d9443c01a7336-2242887eda6mr245024485ad.10.1741646131516;
        Mon, 10 Mar 2025 15:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnmeuKujuIFoDOjnOOzi26QsayrUncCLXxy9lk0lLEat0slGiOifupI35QaZRJEnwy/zxZzw==
X-Received: by 2002:a17:902:e750:b0:223:4bd6:3863 with SMTP id d9443c01a7336-2242887eda6mr245024255ad.10.1741646131117;
        Mon, 10 Mar 2025 15:35:31 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109eba53sm83675825ad.53.2025.03.10.15.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 15:35:30 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [wireless-next v3 0/2] wifi: mac80211: MLO handling for Dynamic VLAN
Date: Mon, 10 Mar 2025 15:35:26 -0700
Message-Id: <20250310223528.3528897-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cXSScdGvQWFkABi5OJCu9rP25ZutRgLc
X-Authority-Analysis: v=2.4 cv=CupFcm4D c=1 sm=1 tr=0 ts=67cf6934 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=tC2w3n1Uh1GYHlSDkNEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: cXSScdGvQWFkABi5OJCu9rP25ZutRgLc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=592 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100171

Currently for AP_VLAN interfaces that are a part of a MLD master AP,
links are not created for the interface. Additionally, mac80211
handles duplicating multicast traffic on each link when a driver/hw
is not handling such action.

With the introduction of MLO, there are two areas where additional
handling is needed to enable Dynamic VLAN traffic: creating separate
links for AP_VLAN interface and enabling mac80211 to send multicast
Dynamic VLAN traffic on each link.

4addr mode + MLO is not currently supported.

v3:
 - rebase to cleanly apply to wireless-next

v2:
 - update Author signoff to new email

Muna Sinada (2):
  wifi: mac80211: Create separate links for VLAN interfaces
  wifi: mac80211: VLAN traffic in multicast path

 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h |  3 ++
 net/mac80211/iface.c       | 22 +++++++++-
 net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/tx.c          |  6 ++-
 5 files changed, 116 insertions(+), 8 deletions(-)

-- 
2.34.1


