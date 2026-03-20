Return-Path: <linux-wireless+bounces-33598-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMMELnWLvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33598-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:01:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 686842DF10C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 609B4301868F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFD131079B;
	Fri, 20 Mar 2026 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+flFtkG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jom4I9Mh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE8318EDC
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029639; cv=none; b=A+/t1wBFqbjx2LKUcPVJKHdF/APXFtSXcNA9kNkAGmHLD5FKOnBpELA1Bc/o1naUmLVXeuP6linU7Y02F1OqppPCmMeI/ZnNJjCIDDhpK+6O+EgT2E0K2eP1tiVw79168vgxhqiWjy2EHr+3vjGQagjh7u5bnJW/g9qE5aNXLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029639; c=relaxed/simple;
	bh=nuqkJ9N/ZhkqH6UFRkEwvKa4zseTxhvY/NkOe1gl31A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuRQUv7BC35CtougwDOxxokMgsgTbx+Fmjqsu7mXPXVKm3usMprBX9oBCnuHkI+P9n4ihsE5SGxAch7G8uW/WSo/h9dsC7/6PxmGeK1phUgBA82q1rhD2AlKBwS8lPTww3feqaQN1fn/z/04N4w+oQdWNi7kfAhB5yk0NW3hzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+flFtkG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jom4I9Mh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEDt71990678
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6o5qIGlKbsO
	JSFOLbHsh+wlG6LM3bmAXDKVm2oMYANw=; b=I+flFtkGBcIL2lPSwGoVk3FefNh
	XlqPl60dm177vvj7HXrRcnD6o653pVrTSEnlbluEyBKmwG7Ct5+7dIpB0MzXajZY
	aDGJFvNMKD+zFyhRz0EFOjKdejrXyFv91QQIi3GbrqrtNn4p3jFB2NOMjpnXOQQF
	6k6ZjltAK8ilBypYUczKibmr1jWTScsuedlfoPymr4+RtOL42qWqgAWfSbL8bGPs
	S6SxxloT+YonhdZ1QxRxXuWkPhFCf4sK0H+vvS2ctqsVDzcM8fDG8HqIMCLlGBqX
	iW7SdKX5Mq8OJu/YiDUyorNvIjol+8xbMzqIP7M88V+HJSSdbm9n2juvncA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0vc6cf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b05d170cadso13081465ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029636; x=1774634436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o5qIGlKbsOJSFOLbHsh+wlG6LM3bmAXDKVm2oMYANw=;
        b=jom4I9Mh1URdNw//WBRyPEXr+FheeiIi9wjv4YGpYVXrZPcdZTsBckrjbYSkLELq+u
         KWzXPOHn8Eed9Lxf5uVVsy6ens8JUI0wcSA+Sp+XsyRVbPdGYbDA3YercTUpkbLej0TY
         55LqWt8YBVQ8LwTV/y2XJ8eOedJj/3OjjqTh+17R9rF4legsEsMLDyB0SQtu2rV2VZ8K
         kmnuD4b2FQtgwXJB7xFtVFiYVpk6yHf1vTUTVj7knv5+eU81Vp0cBIlQpLLqDECPL6Tq
         dSTjbR4QIkTDBbqC/Sl10q2npJolemyjYzOSWMlMw2k+LsZ/9QTXisJMb8GcgrTAkj7s
         8ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029636; x=1774634436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6o5qIGlKbsOJSFOLbHsh+wlG6LM3bmAXDKVm2oMYANw=;
        b=EBef52vl/zjcYJGKXBruIZFSD1oO4EPkuwh2tgSTpJyOX68cElHpEyjdx5Zf++pIl0
         iN7QhHV59TFW9S8LjDxKgoA0qyuUCdGNE1X2fCvxBuROttMjkI2siZFOZCRA79i2EOBd
         ee5lSPJTtKU47/3zVH1QohgrirGKfnGlsHw1SlC9jP4hXhUFsaDoZAaqjWjOH/w5l9Bc
         BCLmYS/a6v4+Xu8tTQyJEOGeV7L+1ocMy3CyrFqusUA9lxiyiqJsBlrnkVHBeSg+mtvm
         EnxNXFJYsF2u1Do1BCagkDOM2kVTMJgc2V1iCDaAl0q+zSmzhbDEhM2N0mxDkJDI8sxq
         Z4tQ==
X-Gm-Message-State: AOJu0YzGv9zuOFBSeoowVViw4GB1yuw0n82SCMIpqPRk85yY7tUA0NQh
	pr2pXy72EZw7E2b9DjVAoV9JGKWeJnzkhoJccQWyHaGwoXQqu8UJPTWb6o+kB6JDvLpUCeuy/6W
	YhDRxMktMS8VGR3OB9YC6NTzhknkpnpXVjYoYE1OXhyKcK/me3smLQVNOrRpp6L/5lnOKZ+8ZPp
	4f
X-Gm-Gg: ATEYQzw+JoLG/nL/ZzDMBpbjp2Q/5zwZihoNP1jbFHEbjim6t+buyl8fO/Q8RzcWGM7
	1Zu88IGZ3aEo++7+lN1CdmlM4LLnuBEUWT1BjgRIxPJ71fLkJRCPcBFNnCz7BX9QHwEPsFaCxNl
	fu280L5y/n0xoX7RjH9O/kAiYJ0FyS8zVGw795nuo3o8JzcEsYCA//Jf5k3k4EJRh+Aefs8HCvT
	0pq3UWy/xoScMaTf4QMPFGkh2FBNjfo0+eLJty61qSefBPINoU/gW8zph9frPKb4I8aeA2b/j2p
	zDZ5hkvVbZss1fptRiLmePJDXg87kNwGGNxKCUB5JLR55dJa87Y+fDmEJ4NTNQIC7gWIkn5O+dQ
	7F1PMQoLF+N0wOy3vub8Tnx9slXi3VcLdITGOWe/ago/slFmxcLPTg6U=
X-Received: by 2002:a17:903:1b6b:b0:2ae:803e:6c12 with SMTP id d9443c01a7336-2b0826d8e62mr34448885ad.6.1774029635035;
        Fri, 20 Mar 2026 11:00:35 -0700 (PDT)
X-Received: by 2002:a17:903:1b6b:b0:2ae:803e:6c12 with SMTP id d9443c01a7336-2b0826d8e62mr34448345ad.6.1774029633903;
        Fri, 20 Mar 2026 11:00:33 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:33 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 02/14] wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down
Date: Fri, 20 Mar 2026 23:29:26 +0530
Message-Id: <20260320175938.2547288-3-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JKZzck2FPOMamN05luZEXOpL2AfbZ93c
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bd8b44 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=b3a8TREfGNtq1x0cxikA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: JKZzck2FPOMamN05luZEXOpL2AfbZ93c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX8nA+7i2BsDwH
 Om7pycxfgp0XIYz6rpblUOplB+f6rsZBrrSTUjSCzBkS+HJ+5HLEfjNyVgGWD445d6FJQIBftVL
 oPnPQwFL9sdYaxQYSz9692qMxKkz8/ZXJwqQgLdzQzCfGXZaBXhjK40u5LP+Vg5QEs7B2iS6v4G
 hxTYeKBe24Qp2/6Rh7pnvAJmV89t5uGHxjubnltAqZUK68CihWVvUB9sPxaS8PAX7KIfqo3Y92N
 RFBUP0oZ0NIHcT+ukIK+i69RsOFoQuydhotTt0CHPcIofWEystByBLqxvNik+U1dMpH5JObc20C
 ydyYyFeh+sx0t1tNYqOT/xVByVYXa3WiXAf/KNCa0n9dTXCJl0HVkcA8PNrz1J5N97XNwuMMiZV
 uQN/Ac1233VpnNFM0bLzUOcS/JARlbqWjwXtem6MhAPDVFln5X647OFDg1OtjUMdl0XWBQ0ukrU
 fn/nxv3Vt+t5mz8bLDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
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
	TAGGED_FROM(0.00)[bounces-33598-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 686842DF10C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 936c16d80cc9..afc0e3f931ec 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -667,6 +667,7 @@ void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev)
 	}
 	spin_unlock_bh(&wdev->pmsr_lock);
 
+	cancel_work_sync(&wdev->pmsr_free_wk);
 	if (found)
 		cfg80211_pmsr_process_abort(wdev);
 
-- 
2.34.1


