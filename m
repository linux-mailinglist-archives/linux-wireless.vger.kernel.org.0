Return-Path: <linux-wireless+bounces-20809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016FA70C14
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 22:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDD47A7E8C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Mar 2025 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37851EFFBE;
	Tue, 25 Mar 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CnJQ8OaI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9E6269B0E
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938293; cv=none; b=g2cl0kipCFrT1d9G0W/bmlKEUw0m04zFOFThYq7l2qGenicHAPDW4Vs51t3fFw7x3M2adCkqA+gn9tb4aYYRZOlhV24k/g5JpmyvQhk3qqL4965HFQoaRFxdL8dLJvFLnO3S8orx/bIz0PwDby4m0ih/QWlcoCtB/9bLnm/itV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938293; c=relaxed/simple;
	bh=PnvMx8g87WQ64V3KvQg4C/R8SE2fIT9wB5boNhqMImQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ezJOJoHfeToMkbQm9YNCmtb9kktMAcGAIvTYPF+Zy/qwW2C9qqKiRpn9kamqvsVnSNjsv/Np9aaK6JiQaJ2KWTY6ZOQIFJYvZsLJR5XXwyRpp4h0wP0d3wnpYKXn/LMbIOwbukZ/1qLL4ugS1C6j+E9W16826DL2fTVLjGnvEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CnJQ8OaI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGb2GC010324
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oWFTXCvQu1Y6hkFTI6Ft3wbcV6Qa00JuIc2
	PM/P2UE0=; b=CnJQ8OaItAxLTFkAwo786SbJHGmkYOlY0gSz7ymavvAl/Vku5w5
	QgCNbERy17txI6lcmI3ot2z8PjpCqK23YjIVRABPpe/GA7ElF5lIWCs2iz0ur6Xb
	vYu4yNg1sfy83L5cNHJYFZvcnefvtyI0VHGbeHbfmTe1c/LCgauUt5wnE1CTkI9P
	D7joZBnlrU2LGjMWG6sIrrIWG9m9TahVxSTqKDahdK90ETxrFR6NjEWMUVYuAMRN
	0DRB/ZIHmAkabn+26Qmvq0svj5l9v1P4uEqSLfTX1axT0RblByjPq8uvW+ZK19Dw
	Kyk84Jr66B+wMqKsIKc47gahGUn87/z1OEA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79s7bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 21:31:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22412127fd7so76446985ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Mar 2025 14:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938289; x=1743543089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWFTXCvQu1Y6hkFTI6Ft3wbcV6Qa00JuIc2PM/P2UE0=;
        b=k6vVhQUmcZ/Vhfl5NZWruJDWaoH9FZZsCtJJq1DYV609I//RFD+zD1gASI4lLxwx+u
         uqnZxz2h7nkkZmKUza2KwE7HlALDEjdsxSwM97/W/ZWc6f5dg0DWySNR7Alh/6Exv/zX
         hq6jkyJyoR5hj4xsHZLjn6KY5yFaAj7Is+I/cEj/AfmsE68w1uvW3xsIqozh3OdJ4nED
         htXsl8OzQ75nDlyC/+0t7gUWN2D+rtbF+uUDXeA+zzYHERzmgqKWmJIenHvsOdWL0C74
         9kadHH1p08BCPzSykMoMP+ncV/Or2whrosKMKSibsWkLOp8J9aOl4lZeXtiO5CR2tJ4i
         HtAA==
X-Gm-Message-State: AOJu0Yy+tfYYKnBR8OpNtOqmWxvlCM1oaQ5CJ1P6ovHIizCloEUjfTrz
	/pCAIQswG67AoaaeZ++qw/48kRmsHZ84CM4rF9p/76XAqXenX8jHbOgdXTbOKZNT0brGiPX6On7
	glS8nAQLsXPhmEHrXrg/tNuZX1Pve4h4gYFnV/Uw3ZzauurBHf5MkvCpGDfYwsAKPjg==
X-Gm-Gg: ASbGncv8fuOyAuJPkqHI9oY0f3gzKVaoJNTTXHNK5VvDafOW8txERzG9WyHPmwHecFH
	32JTnQHwvaolUl6tECCtCe6Ljuh+2kR5erOE1f5uIytCfIHoBswcil5AtE49lawJnSbNNbbWXGZ
	neebUT+Xvpw9tFr4DgDG393BaH8LnfMhKwnmjSYlq1rGfgoXH7HfOn9LckmgmHe7XMDcM8ZL6Pm
	Do8uC1u0VGMyUIxaRP1K15FjaLQWQMZYDM54r28dUInGcuiI5EET0LzE+bp74yqvKnDkW1ebuSl
	f/YMjt4T/axOy3SBzqeoZUi8pJhxq1YMM4PaNShYD7hGlf1u/FImmAoQpDiYMPpmgNL2cu5r
X-Received: by 2002:a17:902:ea07:b0:224:1935:fb7e with SMTP id d9443c01a7336-22780d8351fmr273533035ad.24.1742938289034;
        Tue, 25 Mar 2025 14:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWPa9oUss5GAJMv/yYXFTm00HG0JDPWj2VYN5so4LBZC2+8CwNNm4bZp0OXGWmRuCpHL6zpA==
X-Received: by 2002:a17:902:ea07:b0:224:1935:fb7e with SMTP id d9443c01a7336-22780d8351fmr273532575ad.24.1742938288503;
        Tue, 25 Mar 2025 14:31:28 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2b5sm95599395ad.50.2025.03.25.14.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:28 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 0/3] wifi: mac80211: MLO handling for Dynamic VLAN
Date: Tue, 25 Mar 2025 14:31:22 -0700
Message-Id: <20250325213125.1509362-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IAEoY1qBOxOn-vhdas71KjpFeqpNCTll
X-Proofpoint-ORIG-GUID: IAEoY1qBOxOn-vhdas71KjpFeqpNCTll
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e320b2 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=tC2w3n1Uh1GYHlSDkNEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=820 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250143

Currently for AP_VLAN interfaces that are a part of a MLD master AP,
links are not created for the interface. Additionally, mac80211
handles duplicating multicast traffic on each link when a driver/hw
is not handling such action.

With the introduction of MLO, there are two areas where additional
handling is needed to enable Dynamic VLAN traffic: creating separate
links for AP_VLAN interface and enabling mac80211 to send multicast
Dynamic VLAN traffic on each link.

4addr mode + MLO is not currently supported.

v4:
 - Add link iteration macro and utilize it.

v3:
 - rebase to cleanly apply to wireless-next

v2:
 - update Author signoff to new email

Muna Sinada (3):
  wifi: mac80211: Add link iteration macro for link data
  wifi: mac80211: Create separate links for VLAN interfaces
  wifi: mac80211: VLAN traffic in multicast path

 net/mac80211/chan.c        |  3 ++
 net/mac80211/ieee80211_i.h | 12 +++++
 net/mac80211/iface.c       | 12 ++++-
 net/mac80211/link.c        | 90 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/tx.c          |  6 ++-
 5 files changed, 116 insertions(+), 7 deletions(-)


base-commit: 1794d7ab34d2221ac7eb921b171e75b856e10561
-- 
2.34.1


