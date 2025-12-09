Return-Path: <linux-wireless+bounces-29614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BA0CAEC3D
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 03:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82373300F1A6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 02:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E4728312F;
	Tue,  9 Dec 2025 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MUkBLtN6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HaxlE3qs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B402EC569
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765249062; cv=none; b=f5FabkkLBvRTFQKMHbu6gdEkILkTcU6R8W1oXJ9XIhs3VE1YWacOvuyv9mh5Amk/45qcvA0zWWpaZ+Ip2gtb5Yyj0KSDunssPYsWTMf8BDbXGl6ty7IOEa3QkhTO09wo4nqg69ZvvEiGVYK1hrPjuTB5Mxc/p6cjhshJIkAbPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765249062; c=relaxed/simple;
	bh=gITDj53A9Ea6abzfyp7avI/LRlwZMKbgtUWLfboszxM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dluDgB86hrOaT6sH3oZPFrvYcG/1Pr+YYm4et7D3C8speMlF1reArAVNfpbDO1lHtuh371NjhTOfpTPOrQ1UgWKfmLRIDJ9uoPZZ3Z+s3V2REb4JxqFhpGGDahwnKda/EvsXd71HtcdxS+rKbYKtN2GQ4WTOINqYo9fZer1g5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MUkBLtN6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HaxlE3qs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NXIS41499482
	for <linux-wireless@vger.kernel.org>; Tue, 9 Dec 2025 02:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kvUorzQNZqE2tZuCFGvVVW
	SVzOWGRL1vLL1LEK0A1o0=; b=MUkBLtN6kN5fgkjd6SaI9EUbto1FKnEiGkiLce
	4aKTtrfRQiZ9/UhouyRZjEr/kacVPEQUCFK2pBuVVFGmtRSuP/5ltq65Qnuz6VhK
	OtlD2lRV854OvMAnW1PRlzYu6eZSMIcz3MMIgLTnq3Huuj56nqWrl9kHi9rZ2IFe
	2RI1DKU3sbgmzjqwVpTatnGnHxvZH7Ao79yOzdcA3W3eAvGCLCibJoQT8bHRAvXs
	x2JSE+444DSuHKK9tvpjdMjigMfq9cBwthGH6kjp+Dnf7//IxhUW2J+4VtzdbRT9
	+YKWw7u6cJLSWJOfs/9Mq+YVVC1bxfaCXLEqjZMCwlgLAWXg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax57r8yrv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 02:57:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bddf9ce4935so4572742a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Dec 2025 18:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765249058; x=1765853858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kvUorzQNZqE2tZuCFGvVVWSVzOWGRL1vLL1LEK0A1o0=;
        b=HaxlE3qsJLAtsQvKH6mzEwcc//5I3uC2Jnk84wHiLSwFmENTx5ssVqbsD72olruCXe
         PV8uCstVs4vkMVxX4w3j0+r1vwnt3QUJl0dD7sdozXWn+W2oYeft+ePZumQUHz2P3r8E
         MUT9UO1jYlV6Oqxe3YDU5GrgxyIyTQPI32rk3IZBL6OyQthSt0BoxxFoDnQubGhC4EYY
         GE9xeUKRjL15uKE1cY8PNT4e3ZH0XqF7Z4tCAkb8+nEotLWY2CMM1y8e5ScDR5pT/aNF
         pVzR4sDFmVIi1v3Dgy+XbaNDM8vbJKApKoRRLQoC8fXQ8ZvJ+uZXM5EaN0Uhv9vnASmP
         WScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765249058; x=1765853858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvUorzQNZqE2tZuCFGvVVWSVzOWGRL1vLL1LEK0A1o0=;
        b=afHaFbIdW+v+owGAB4qJiBXhpVZgejZiRe6GmJeBZiDShQbtN71Uf4PtJMQWsbUQSN
         RkwE99LU0R0uRyMcuqsh1PnLqQ/tJZ0Cg1FdoOdgexY8HqcihF4iW+TNbxsqwjVsLRZF
         ZWiqMkjop+tWk1LiXh5prq9Jsx7sEzw4jkmizTPdSeyt9gYUIXcJMuGXBPLWZE6ADImh
         ykeeUbAL+BR5CDp0v5q/wYjxzEf+YNyYobOfK0GmEt9H07A9VRDpV5RN5HsfPQc4Yich
         1YLdD9xQJ7gKxWMk5rUQt4TuDD9YfDcPAlc/qBLoWs6y9lpOst+CAdtdOfLZEpQ650aM
         rbIg==
X-Gm-Message-State: AOJu0Yx0mNgztQ3ot53xy7cUgPLM2tvOdNHQukt4EquuVm71v4xGSUo1
	0POUeWE5GgOVxr5Ix1fW35sS6j8X/N2UR16/1MKsKMLCI91g7UyMDRnkMm4isx4/ajX4PGCr4ao
	3CP+1xVVo2xgm+z5212LCboWGD/Dy4IzQniSeo4lmSEVegO/J7khU6Z5a5JnSVamNY1s340zNZ1
	fAleio
X-Gm-Gg: ASbGncsgkf3tp+CcJCrQSQTOq3JlTiPUpKzHSpoxIG6uMY5qvUN3CLyGDnML8Cq3qfL
	uP+XSnuSDMIi+avKKUxeGDA75Nh53QfcBrcgz52eVlTt4onINGkC+D9+kCfqw4ctkd3aZ13VbwS
	sEkDcWHtrdenBq5mtCbwBHa+ssKh7KTSp3Yf9uhN4/dpfmxk0JKpIaQHBqfyFX0P46kZtkNhT5U
	4+p5xZsuFrnZ97s1467gYTq1LaFxYp2XngRHAeAM5lMUaSoePWUKwIrcnSbfAPUnDdl4x4W3eMn
	k9mCMQ0lQWF5cKh+hliyUk2pRMDcRnOVwXRtC338VuO3b156mWhO/K6by4/X9lgVyqs5a28/vjK
	Mg8obyF6XXao68eGll1TPAWp4XVta/kj+krwqbgpLDro=
X-Received: by 2002:a05:7023:c013:b0:11b:8f3a:3e07 with SMTP id a92af1059eb24-11e03169056mr5666069c88.11.1765249058345;
        Mon, 08 Dec 2025 18:57:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfp2qiABZ4KTd8Q9HJBk4oKpCI1N3JSCIkpeW0ftNfYzKA/J1KWZu984ogAQOTNBIE576SWw==
X-Received: by 2002:a05:7023:c013:b0:11b:8f3a:3e07 with SMTP id a92af1059eb24-11e03169056mr5666054c88.11.1765249057756;
        Mon, 08 Dec 2025 18:57:37 -0800 (PST)
Received: from hu-chenhuan-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm61329406c88.5.2025.12.08.18.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:57:37 -0800 (PST)
From: Huang Chenming <chenming.huang@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next] wifi: cfg80211: Fix use_for flag update on BSS refresh
Date: Tue,  9 Dec 2025 08:27:33 +0530
Message-Id: <20251209025733.2098456-1-chenming.huang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OPQqHCaB c=1 sm=1 tr=0 ts=69379023 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cfL90H1ECgxfe_afT18A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDAyMCBTYWx0ZWRfXx3kZgAxQYm9Z
 JTNm2rxFqZNqzC1SrqlNS9BMu3ipVPfk6gIK0LZgw1IihV10RS54pzyCbeFE3GtYAhOax8ERUgx
 B0ZSoxKVWHsLu9cBiwWZuRXwBpLL+FPV/QpYF9UBlrGCy6jq2lDxAXTJdNro7KzlLrv9RveFoyF
 4YRvf810O8Cl8/+5Akv85i6XdYTLKNGILX8/5SfHHJjF0nd4954raEshrQsYP98wRLvrEMPM1HF
 JfDqlz1ZboPAgEaS95bYFJlX+WK5T9nBR6uIyi/Wibx5xg7LdtDVo4k04+1oU0/Rsm6EWsR8nSi
 WC7HX00kAV+E5/HdkG3fEuq1nok9l+rbYiIEV2ohLI61rRhtHzR69xWFPyyA4Dd6Cw3BNXKAuR3
 xRs4bJpkVzvQhliF+GpwYEonWeBQUw==
X-Proofpoint-ORIG-GUID: Qnpb_yX2uUd7c70A9_iChOODublzcA36
X-Proofpoint-GUID: Qnpb_yX2uUd7c70A9_iChOODublzcA36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-08_07,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090020

Userspace may fail to connect to certain BSS that were initially
marked as unusable due to regulatory restrictions (use_for = 0,
e.g., 6 GHz power type mismatch). Even after these restrictions
are removed and the BSS becomes usable, connection attempts still
fail.

The issue occurs in cfg80211_update_known_bss() where the use_for
flag is updated using bitwise AND (&=) instead of direct assignment.
Once a BSS is marked with use_for = 0, the AND operation masks out
any subsequent non-zero values, permanently keeping the flag at 0.
This causes __cfg80211_get_bss(), invoked by nl80211_assoc_bss(), to
fail the check "(bss->pub.use_for & use_for) != use_for", thereby
blocking association.

Replace the bitwise AND operation with direct assignment so the use_for
flag accurately reflects the current BSS state.

Fixes: d02a12b8e4bb ("wifi: cfg80211: add BSS usage reporting")
Signed-off-by: Huang Chenming <chenming.huang@oss.qualcomm.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 7546647752fd..eb0e77813d46 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1959,7 +1959,7 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 	ether_addr_copy(known->parent_bssid, new->parent_bssid);
 	known->pub.max_bssid_indicator = new->pub.max_bssid_indicator;
 	known->pub.bssid_index = new->pub.bssid_index;
-	known->pub.use_for &= new->pub.use_for;
+	known->pub.use_for = new->pub.use_for;
 	known->pub.cannot_use_reasons = new->pub.cannot_use_reasons;
 	known->bss_source = new->bss_source;
 
-- 
2.34.1


