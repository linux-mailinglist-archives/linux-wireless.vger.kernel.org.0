Return-Path: <linux-wireless+bounces-32438-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFodC0jcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32438-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A01FB755
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA721303D108
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E9330CDAF;
	Wed,  4 Mar 2026 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VPE3BkN1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NpB3HFP+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C323346FC3
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608578; cv=none; b=o1A59AYTbroo1H16mDKr0RJWT8yQ363F/JrKKOsjoUQK3j4Zd/BN1pj84DDTrxhZXLvZPKcrXZNn2VPZTlfxno4pQ8kQLgZRvpNt2w//9ft+/E4if4hia5Ov3hQUASCac6n1g/bo2G3zWCAm+ue1Ln0OJJFlQCajotiyLAMWlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608578; c=relaxed/simple;
	bh=xVSlKlE3W/E151tTGKNBnl/Z19jAOr0BCk0PE+TbHxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MAjLce+PtRQaeq3kmSvGwN7q0k4d5jlorK43ly+4mP3y0PAgtD2yGiJqv3+jZP8qhCTihDR5ok9QuMbozhv/wN0OdfzcPlSPo7yQuIGvFpidEBqUAoMTir+A+ZulF88iwwSXMJAS/w3x8Hcgh+1a8lwbQ6kSYIQWcW7YFrGZAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VPE3BkN1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NpB3HFP+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SQ051677919
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CnctMvwlzm/
	o7EipdXW/ZjnlTfwOenuPFkUAEeIBpNI=; b=VPE3BkN1Zw5ne9Mx7hKHfWO3MQ8
	6h9fSNEZqst23itbhRJwta00fPCiXZ7K5XuJSUk6FlNoRs+jhX0EiF2PfvqYtYQY
	9v67U5taMQOo4Q1lAtjWOgFzE4ImMM/6w7cbTZ4vw50L/1eKi7ogHlcgEIL0vrRf
	u79EYWXNL2J27yvfcyaGQBUU/kHRqo28wC9AKcFbU+Ip+WTHehhMojfbR/HYfIHt
	MDwTTJcxb22vY5VSr5TMUEauEwfWPAX8fObgMmWx9VD5I/B0lj4QgEViG/6lv6hU
	/U3MmfS/mAIyFSDy/JKgQFNYXLSWigaEIPmQt8XKGPFbUfcmwPNiO6ZYsbw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73h9rsk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b62da7602a0so4047886a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608576; x=1773213376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnctMvwlzm/o7EipdXW/ZjnlTfwOenuPFkUAEeIBpNI=;
        b=NpB3HFP+/Ph62MKtjNyXnby7rIN0tCKJSfwHdwG6zEoSq6MgoqUtoFEN+eco8i6kfC
         7oX4u+vNd8HfZL4INjDHXFXpz5aqTe4a6WyhpwS4+QfkGk9cUrF/wmmSDq6gwZMklbMI
         HndRnNvD6N4JXFvxnA73G74WKgST6fY+QsxGNCg8KNu4rEl2mz+7D5Ni6Zlt2AHwFO14
         HZShQAjf0IId4BlSTZmBzalIFshklVjiaBW8QVKJFhZB13cQHHFxUAwOpiGnkvQ+9ru7
         6wWBMgiqpxTFRpwFy1oP0A9nS06gs/3Fc4p4MbeBF2NnBU6eOP8aa9sHBcg4Wt8p1g+6
         U3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608576; x=1773213376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnctMvwlzm/o7EipdXW/ZjnlTfwOenuPFkUAEeIBpNI=;
        b=OjESg2WbKxdhSgDJdpHtzT6mNIx2UFMnIxlyaaM4+fn5GwNtYQtWyi7E2TwAgavIuG
         azQ4O6IviUfi/n7UNz6tcrw+u5z5c0DBqQHyZdtFljjgyv09J5UVHhJj7eKuxL9UCvh3
         7m8oJj851E0xSYqydGtKcKTbfG67wOuHK0iZnWhJ61ntEFYrMoP1pbiTs/tDvT6aRReu
         1knRoKOxNaDwVgulLGqwtp/EeihFO4g6p4djtJfRDWNmVugQmicdoqhh0RvEjIcl7syf
         YSwYyObP9jf5zF14cLHG9tkvCVQ305ctvSV+x63NICa/+Ac1qbkGq1EeVbYfHJ4wXT1+
         GTiA==
X-Gm-Message-State: AOJu0Ywe3CmWqw23obiwC1GUhv6srDLh7o6HOxsnebGZI1k6wgmQ0I5Q
	988himTT+hauX/t91DiyIeVu0IL1jkFTAmJUNgqItRNqVojrxAc8gRe13b6OTJvcWJ469U4UIqZ
	c4ky834HWVklL/jr1ZG6V7Guf9c58SjCCrMwFire9BLpWSPwU9sDuWAkpBXAP/ixBPt86
X-Gm-Gg: ATEYQzzHWnd8RwZdqK4oEc6f4zT1bOrghPw2WhUOsaVYQsSBGJOHUsQszAwn/3iX8gm
	mMGLOR1ksT0PGq78nkVPOiHXYdF8F/SZJrzKYpMx0w2AaH7BmYIDepXGOe5E1A7krZA6uoI7ojJ
	GEjSacCgn4FiLmRHYKdp601IMflLK6DMAuss0Y4rusFbu9NepkhD8cV5qE7ccIm6WvkYc8ctfHj
	LMpfYUwAS5ShVh+m6Yn0gjdQ9ysgpGRXufJB9h/JArqJfWKqlfK690eVrePFpe5Dn0Ru1/iVOcX
	1EMXE1KvJheYwivqOO8urziNGnVUem++K6J9CGeXowq8GyWJnnbErgnhFE6qKy0iOyG4hJWj2SB
	NurbToEIJ1Gi4pzexGOgPxd/NI4IeCSbGGL/vY2Ja93IHo82lD/4fhAc=
X-Received: by 2002:a05:6a20:3d89:b0:38d:ebdc:3546 with SMTP id adf61e73a8af0-3982dda6eb0mr1198393637.6.1772608575611;
        Tue, 03 Mar 2026 23:16:15 -0800 (PST)
X-Received: by 2002:a05:6a20:3d89:b0:38d:ebdc:3546 with SMTP id adf61e73a8af0-3982dda6eb0mr1198365637.6.1772608575097;
        Tue, 03 Mar 2026 23:16:15 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:14 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 02/16] wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down
Date: Wed,  4 Mar 2026 12:45:24 +0530
Message-Id: <20260304071538.3833062-3-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VeFeFsEF7H9CVe9hCTXHX72oVtow9FDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX0S48lnj61lA/
 3uuECf8pLQEz3vFp8PQJ3GmyXYkCBybqWyTUHkmxZRWEUJHqmu26HTtTQrZXRPNjEX7ou/fUigQ
 7XP+eX17OdJ9yZD7TQkdSweHm25mmGkJPyEjVCt0Tdqx+3aUFar2pX0364/K3KMfwjnEnpOzQUv
 13lhjAJAecx2hacTMzN8Iwt1hgbqzCQRVqeZqhWHFdjeGte14m96lqoOGa3oNaL/w9xfuGoXPG7
 NDcglTEaIanxem7XbLut85mYWZJL7l/TJP4DhPBTDBjqCloq080Gw2o9V3rRelPXuWcKW7Pzh7l
 2NUeSTS4OTWDiNdFeKNe7K40AJjdyDF/le0CdxKguKskEY2I80LzGBYUwX/6/ePKA9tTs/vNwWi
 vKpHM1qkWPr6y28tZoWxTb5wOFXLa+eIHWCag3HO1QsFP+Z4E7Shn3/ldUOa3nd3gUCI5jzJZyH
 uXhw4d/pftHKbIZhGAA==
X-Proofpoint-ORIG-GUID: VeFeFsEF7H9CVe9hCTXHX72oVtow9FDX
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7dc40 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=b3a8TREfGNtq1x0cxikA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: BA3A01FB755
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32438-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

When the nl80211 socket that originated a PMSR request is
closed, cfg80211_release_pmsr() sets the request's nl_portid
to zero and schedules pmsr_free_wk to process the abort
asynchronously. If the interface is concurrently torn down
before that work runs, cfg80211_pmsr_wdev_down() calls
cfg80211_pmsr_process_abort() directly. However, the already-
scheduled pmsr_free_wk work item remains pending and may run
after the interface has been removed from the driver. This
could cause the driver's abort_pmsr callback to operate on a
torn-down interface, leading to undefined behavior and
potential crashes.

Cancel pmsr_free_wk synchronously in cfg80211_pmsr_wdev_down()
before calling cfg80211_pmsr_process_abort(). This ensures any
pending or in-progress work is drained before interface teardown
proceeds, preventing the work from invoking the driver abort
callback after the interface is gone.

Fixes: 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM initiator API")
Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 net/wireless/pmsr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index b875b61c0b48..c2977a37add2 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -658,6 +658,7 @@ void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev)
 	}
 	spin_unlock_bh(&wdev->pmsr_lock);
 
+	cancel_work_sync(&wdev->pmsr_free_wk);
 	if (found)
 		cfg80211_pmsr_process_abort(wdev);
 
-- 
2.34.1


