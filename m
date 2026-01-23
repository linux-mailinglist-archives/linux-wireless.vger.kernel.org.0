Return-Path: <linux-wireless+bounces-31104-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLXuDsAZc2mwsAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31104-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:48:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B927124A
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 07:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C853D3003BD3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE72E1D5AD4;
	Fri, 23 Jan 2026 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+VqoB/E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kSxEwSrE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814A61EA84
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150907; cv=none; b=G5hjYk3W5w4mQfQib/yOmVGuV/4R9MwUT4ahOYovFTzoH41hUPyvUTTBlBq9IdNLKGjz9bYN1pj1cZDVn1MVmqqD1CHz6QT1hGtuaHUQxSJz7biyD878zcNKl1ZlBF+dyVmguwh83/707nJLZinzUxSB8ygIQyc4aKPQVHn7BzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150907; c=relaxed/simple;
	bh=Fxa8Zgq8JCzG3cfbotu1Yi2IsXJIYKg4hSlc7sjxzsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nz+/Ap2RvPVtXb/6ocDqWSiXFiFNkU8H9lZ818NTpv9rCWdaQ18kRxR1zlVF/6mn73uTWEO0rXd4PJSlWRpwNHPcq9jyCzNzOJyn7B8FwMpRw3xztGOre6iqqO61SE5VOM5SJ7XnJNWhLbrMci+ygk/qmyNhHatPk3BJqqdvSpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B+VqoB/E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kSxEwSrE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N65gv43504014
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/54UclkpqOwxDHYahcS9J1UHOq2QTEmzbvl
	JzYpgHaU=; b=B+VqoB/EAmTTAdLOc4UkMdAx/0avu58LVIOEQqZR88LwfQsA1pb
	iWFqo0xmeuI61Dnvlj5uc68Rm3dw43s1UlDoMbE8Ebw7JtrGJMx1oQunaooBiInD
	Fq024GP+dCGcih0KYdC/6YmCrFAtY7AYO1GPf0D11wt4gxN9KGcVaUHLeCeUmOoE
	STSf+aRdz+Z1YDi823kYJ/e0IOa15TANPe3ysCs7x5viIrY3w2HeIbEQT+ltZ0SI
	32KsloQc9PFNl27GjV90n82cKFMQ4uUmRn2JoQYnycOlVCqHuq8SkXWRw4vemBM/
	E8DdnDM1OP/arrDLntwXq6wVKA49xlLP6PA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bus9821kp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 06:48:25 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-12338d13f2cso2278597c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 22:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769150905; x=1769755705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/54UclkpqOwxDHYahcS9J1UHOq2QTEmzbvlJzYpgHaU=;
        b=kSxEwSrEoRPlni0qrtxY56MdBVPN8M3WzaxOqIuUSRMG8uZhl8uzTuciEbGCE/Y/kq
         WnS6hESflEYisd3VQug/e08CnAApJZjUczIEdqHKLnx0tnJB7fhD+0TE/81zmKiVxtc3
         WF+8DgaEvRIAPt0Wwb0xry27LtHWreq+Juej9PwWhrbdj0LNAi+T4h+wiHNu6vdV5UIQ
         VCs1s9do6zANMYwbwU4BmLoEhQCkL4tEp2/HJOg333t+ZR2RDPNxvxyboMknZJz7rM7T
         v4+Z8ufr+afoq/4lb+dXURx1dO+32jU9D3ltu02luA6RLNcW07BV5T+Hynllh7Rhkvsb
         FLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769150905; x=1769755705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/54UclkpqOwxDHYahcS9J1UHOq2QTEmzbvlJzYpgHaU=;
        b=IwDkI2uEPvm15NAzbXaO1bdy+pzUJS6lSgu/+w/a5W5qyrHLzK+wdiC2vztbZfKsbT
         hij3hkzL/KCckH94VN292XWcPIAlgQb3nf9xhdWhsguSoULvK1iajF5dyrMRd0FMKvEZ
         zsySInX3YJ0M/aUJhoUmmDh+4BSnIeINzl91689ToWp6Fm3e3KrOzelA9dEVSwtNvnxF
         5silXjxzlBOKozy6DFDJVO5JTJXqUPWU1t8EG8m3dHQ5YqC+PMvyZtnjCYvdLZOSY1rL
         f6a0fKvmPNT4u1ocS9wAj0DiGh2Rl9djK9aUqMLIb9eM2Zcs9L5aA/fnVdx09K+5oLgw
         sHlA==
X-Forwarded-Encrypted: i=1; AJvYcCXPfovUXN5gAbj9vO5tzlIWnCrh88O2yXKZSsZXJGLmVIkFIRid1dz5ikXRB+NiukfXef9QoGaLSf3q3eir4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkYuq5i6A4GhwhHoz6OKCTLeqsZERSFyYlngKAcWo5VkRpVnSb
	Zq9JCTnwCd9W6hPJhrb7iZLvLwsshjNMxeL9vBrf5hbdK283h/4p1bRBRONCO9f89fh4XjVo/2K
	/oBdly8PJEdnb95LQ/0tgHcrbTWetmr0Yu1oj0DZV43J1Yaw+kzOVnIDROeFuFiEJkMcTvIb+2v
	9wiK1N
X-Gm-Gg: AZuq6aJqRnOprY+zVsIIjJd68as9G7bAMGWijOLzpIlBOFj9Cc74NBWPcWGpg2ktjFu
	uhp5g0PnoSLAMK4W5AvWsvkiECIxOs3EaegFnrTbO9ZOHCaQh2nOnpLQLiDnV0zQ3BrFy+rppmA
	1OZniNlFEwcpR/RCuO+ADFcNL/IJYNWMw80umJ4qyg+3k797q9SIHuKLg2C8SWStO6OmP833+jA
	BSeQr3W+aJV4HHH4Fr+ihlhxMfst65f7prtfmRwA6khTw7NFYv5ez/liCCg6Ju77hy/BqV2FdS9
	YjFrcdwSRPCroFQJ8Cij/+crtmSxTxXjqvXL3GVIAOYUw/Nv/zJeRDc6BWXjQE2QwQmpxPAI8lj
	nv6WZQIU9LmW41CoFR/gzbLIkpm3m5y09pMzbTbvCkYY/e7Fl6+i4zB18fh+4JSUZzg==
X-Received: by 2002:a05:7022:e0e:b0:119:e569:f622 with SMTP id a92af1059eb24-1247dbfdd9bmr772955c88.27.1769150904830;
        Thu, 22 Jan 2026 22:48:24 -0800 (PST)
X-Received: by 2002:a05:7022:e0e:b0:119:e569:f622 with SMTP id a92af1059eb24-1247dbfdd9bmr772948c88.27.1769150904317;
        Thu, 22 Jan 2026 22:48:24 -0800 (PST)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90d13esm2819484c88.2.2026.01.22.22.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 22:48:23 -0800 (PST)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next 0/2] wifi: ath12k: Add pdev-level OBSS PD configuration
Date: Thu, 22 Jan 2026 22:48:15 -0800
Message-ID: <20260123064817.364047-1-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1MCBTYWx0ZWRfX/x/sIUnwzrFj
 U8aG/yjqWIYK/m8qhLpVWe9VO64F44OOVZ3VB7UlnKjSqiEPhluKiwvRyFaDv3y+1p7eDyBD4MZ
 Sw5aIgbf5hMM134084esh6T3u72aes7/zwd7GqQfzb7oPYz5T/ozVrsDOgSXdma0wCIF+8s254X
 jyjEFU4epp5hbQDDEdyBMAxpPH16HOpOG2JX/jDS0raCxGKaYGAre+8/8aTA9YczZtXMebrrBRs
 7WYwU7TST2TDEmVdSf/BpQsfWlavi4t0DRKkNHV0zzRE34PdGu7jQEJY512Huz8jIyaPbmJphCF
 mA3dvXMTI1bEi4p5TyLQx7v64qDeOMfNW0IcaYnw5hJk4N2ZHpI/LUMA3T8H57iCtHLo79XPlwp
 Kwt/QEam295gtXe5uezjLTdJMTjc+5slEcKCnsxWw21veE5DJXAaGseatzVyNWjVMydEFe61sKy
 Sbqw8bUGGbN7oV136QQ==
X-Authority-Analysis: v=2.4 cv=JuX8bc4C c=1 sm=1 tr=0 ts=697319b9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gbK--YHSo8g9L1OSsNMA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 715qAq6ww8wmZsTKLpL0xqq23lXl64dY
X-Proofpoint-ORIG-GUID: 715qAq6ww8wmZsTKLpL0xqq23lXl64dY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230050
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31104-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 55B927124A
X-Rspamd-Action: no action

This series introduces WMI support and AP-mode handling for HE Spatial
Reuse in ath12k:

Patch 1 adds new WMI commands, TLV tags, and a service flag to configure
SRG/non-SRG OBSS PD bitmaps (BSS color and partial BSSID) at the pdev
level.
Patch 2 switches AP mode to use the new pdev-level configuration path,
programming OBSS PD thresholds, per-AC enablement, SR prohibit control,
and SRG/non-SRG bitmaps based on mac80211 HE SPR parameters.

These changes enable firmware-managed OBSS PD behavior for HE Spatial
Reuse.

Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Wei Zhang (2):
  wifi: ath12k: add WMI support for spatial reuse parameter
    configuration
  wifi: ath12k: support OBSS PD configuration for AP mode

 drivers/net/wireless/ath/ath12k/mac.c | 170 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c | 142 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h |  47 +++++++
 4 files changed, 359 insertions(+), 3 deletions(-)


base-commit: 758064145fe77e06d07661b27dfa9c24fe0309a3
-- 
2.34.1


