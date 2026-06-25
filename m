Return-Path: <linux-wireless+bounces-38072-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XB/eDLm2PGqMqwgAu9opvQ
	(envelope-from <linux-wireless+bounces-38072-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 07:03:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FAA6C2B67
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 07:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NeXfj7ZI;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=kZLofnRG;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38072-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38072-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F190F302977F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 05:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864D29A32D;
	Thu, 25 Jun 2026 05:03:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28A150997
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 05:03:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782363829; cv=none; b=SEGAsRe0r3Mdnl6bBjU6o3VewwNe3b7v7TPsQA6BJM6gJQVwjl74ZDz9mnGOvn5RP6UMEn0ACq1og/3R330kHndAi0ozTipSB8Rc9iRLDz+2CWuZoyOh1oa8ztaiZMKihRD75nXQRDsqz9tq60xN5xkYv/fYFgeZf0lM00tFwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782363829; c=relaxed/simple;
	bh=d4B8InuU5AHateWC5hTZrMnrwwexQIXTTMyPCKnpeNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m/5hg4yAhhKTIFz1zd+X2kR+tuRMedF5WaTPL1y8Xdw4YXpen1WVvRDspYnHb/vokS59gHIe1KuoyzxpODZPFth8xbvVJzkvAXdIGSShcfEAzMOiQW6WQBME76qROL3VIC8iATpdCu9UQT8/LVoIoijzQ9isPOHK/aF0ounJWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NeXfj7ZI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kZLofnRG; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3eZXL1131910
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 05:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FIPwpJrdlN+RhaFH+uw0Ed
	AXcTDgZgdTYte4eQcoRyU=; b=NeXfj7ZIlchaZQrq1ZsGdfcRp887RXWj7iHOQB
	gRamjHwcBk0l0fSJXqjPuoQasXDTS6BiKN5qQlIyP5zj820YoKUNujSsRYi9loEm
	xIlWLXsk0OQO2wJqQ8Qyo+uGDMyXkPkdH5ursUqwyfTbl8b7KK6JVpRrAPRdus+I
	HDWIjc2iAandDZ494iyxOWmvQfg17ePeOwfkSM2rk3y8AMOBBgnFM+ab94Bx7sSp
	isIOJvJVxcluO/odjKIKgO9H+iSBqT/FLOYhltzO+NehgO6OTkZpaknBe2F8/5/q
	VzhBMgn7AOWOmARhloZLdqulEmhyywsTO+4Ip2csedIVI06g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0d5g3xhn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 05:03:46 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139553dd8acso4703944c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 22:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782363825; x=1782968625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FIPwpJrdlN+RhaFH+uw0EdAXcTDgZgdTYte4eQcoRyU=;
        b=kZLofnRGjAXInV26oEDW9HgyDlkdjdZS34pejIWJYO+AKJfuT02K3/0cVe1cUrhcqL
         Mp7b05f5mit1e0MZk98nNWu3A0Zi2O70VTLES+r2EaaooOuzECA+lT8H5PSiHijbkvwS
         /3HBkkndSYpfxkkrGt20CXnbqMQqjA5nrh3VSZhPJDnRJiBpeFJBS96ODCLjuiiqoutV
         VQF27nORG7HogFXkkW+WlHhUeH9dlB9bVy/BYXRMnkjJ1I15rWte9avyK6VUqWguQOX0
         YQIupGEbL9+lj8uo+2S1vm/6PK39mHfmpy11/7PimUGzgPYx7PcrHthDLAj+82Iufj7t
         VWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782363825; x=1782968625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIPwpJrdlN+RhaFH+uw0EdAXcTDgZgdTYte4eQcoRyU=;
        b=KI2KF5YlOd5kxsUmJXFABJ9tjJ36fNsxdTX8M87fg4iCeIJ4hUkDMhBvG+vmuQAUmV
         jz8p/1keVaa84LMmuvlzmwDFZ7TNI95Q7GHC5nSIrf+UVMcMTqAZIyugg3ZC5kMPKYbx
         StrWqo+X4/Ar56rENbwGyBMFpXAtPNRmnCfI+pnMA0wYT1GXLnNZe/UnLXJDKF9SuCx6
         RIYo/XjOp7KctYZSvt92f2cMidTxVw9ZjaYPt0Tpom0uQjXUAcc8ReIBb8sv9w81BY+5
         9AGaMWqOTBsERLTQAVoxyfjwB6pR+awTiXVoM9Vb9NBifAQenfIyRPwFEKPk1x43wGJ5
         6rKw==
X-Gm-Message-State: AOJu0YwoFt7Dyp9nC2qGs0lDbY6mH+TNPUkS5dlYjE5PIwn6JyiUyBjF
	ghvBqAICWMk0Pbto2RmEl/+SnSIjF+irzZImqANE36kOmfqId4AJpOtFBky9IezQxCU+fZvOtcU
	nJ8rlZLDeK1sIPCvjWLiGWH+bYDnSFrQJNKrODkzYxy+3WnsRGBsLc8eGazR4GHXZ5OyACbIxhs
	GrXA==
X-Gm-Gg: AfdE7cnWsP3Th7ePtuDvhsgT+y4dpJ3X0JUAl5R78T5yDSQISappoVoBZNy1+AgVPeq
	kxvOcMDaMJugLTppw6ZtNCpEVaJDP7iiUpOBbjmOaSK4+Khn+goFjABqRSM+e1D5XVfRPqQv7LV
	FZlnvgvlwWVD6HrrIXWWIz/qaEuYr5PqFDf/yCx3W93UoZNF1287tmT+vRzwYAoyGPWDC4hVwNC
	WbnkME5vIvvgbr4L6HJBnFZwZ8ShxtG5At57juNpkl61VoYzIYQLZxUYAbKhAD61e2BWNaxyNgF
	jSdLPFp368F03bzopjdg1/8GuAxHSRXlMVmHlS1HkIdXS/Vm+rvFHpABQW0oVFcTTP1ZAzhwcbS
	zCzWMOo5GxKKltATBi/Fi2tr4etw/eKVHrjnlo/TQnTKMQ9Wo2uyOjWcRb9pnQu9O6/fGpmD6E0
	jT7WNttaK3UsANyvlVXDyoDPUg1uH3+pd0wlBLd2DhBGE=
X-Received: by 2002:a05:7022:2591:b0:134:feba:3fd with SMTP id a92af1059eb24-139dbb05756mr1113476c88.37.1782363824924;
        Wed, 24 Jun 2026 22:03:44 -0700 (PDT)
X-Received: by 2002:a05:7022:2591:b0:134:feba:3fd with SMTP id a92af1059eb24-139dbb05756mr1113423c88.37.1782363824046;
        Wed, 24 Jun 2026 22:03:44 -0700 (PDT)
Received: from hu-mdharane-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e940asm3843910c88.9.2026.06.24.22.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 22:03:43 -0700 (PDT)
From: Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Subject: [DESIGN RFC] EHT/UHR Critical update handling 
Date: Thu, 25 Jun 2026 10:33:26 +0530
Message-Id: <20260625050326.2946848-1-manish.dharanenthiran@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LdMMLDfi c=1 sm=1 tr=0 ts=6a3cb6b2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=scPDJlhu6FDLwkfH4lQA:9 a=QCYKY_g3eM_dVD-k:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=pIW3pCRaVxJDc-hWtpF8:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WEkaTK6MaZz3Wr_NnsEz-_S5rDtQtNbw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0MSBTYWx0ZWRfXxsTaT7NZ1IfK
 FJkRkm9RyD3jMXezI598LBriH1H4NPc916HO8RSIN6sb0/IGO0muotUiWLh9rYprxDbnEwY8b6C
 XbL0L5SA7qOEkguIZX3Z7NG2b3YGh27iuqeUL1E6dHnMmlbw9k2bD4ltN2Ih9nXUyZtinsDdDIm
 wHlh4sukH/N7Z1mQwV0gQpWqc4RldVARisIFmkhaM4htEjrIoswUCTMZLhcYFEydVC+BHYcqWc9
 gO72Loavyk2yODmhFplrPoPonsmBePPUFRDlUOhUNQPV1RjRRzfsr5JdzUI++YdqRQbnyZ+AkfZ
 +kLKN6K/1AfkUHZ6uARXKuFjZcfL4PV0WBwNQ7Vby0aZBR6iE/NgDjFaZN9aDCk9u2vHZ9119kC
 AVLKy8BpVd8fhqnEZc2lEev4GuSvbfRqQq2B6nt36dIlNU/iNPUmp8oRO2Z+dQ3WdsxIzE9xEFC
 nvSyrPI+/buYCklZLRQ==
X-Proofpoint-GUID: WEkaTK6MaZz3Wr_NnsEz-_S5rDtQtNbw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0MSBTYWx0ZWRfX9AXyAYjRYYE3
 6UMG9zw2Jy95wGi4ODtH7ww+FFpV9E6EKM69cAj9fK2HAkDYFc4ytwNv71rO+T6LNCNvjmxpld4
 yOt2h9NYCqJvbr8uSRyqPopcaXNaSmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250041
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_SPACES(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38072-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:manish.dharanenthiran@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manish.dharanenthiran@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68FAA6C2B67

Hi,

This RFC outlines a proposed approach for handling EHT/UHR Critical Update (CU)
procedures across different driver models. The focus is on ensuring correct and
consistent behavior of beacon and management frames, while addressing timing
constraints and scalability challenges observed in the previously discussed
approaches.

================================================================
               Background and Motivation
================================================================
For handling EHT/UHR Critical Updates (CU) across both beacon offload and
non-offload drivers, Johannes previously proposed a design in [1], where the
responsibility for managing CU-related updates resides entirely in
user space (hostapd). In this approach, the kernel/driver provides timing
information (e.g., TSF and TBTT), which hostapd uses to compute and update
beacon contents. As part of the CU procedure, hostapd is expected to update
beacon contents at every beacon interval until the CU session completes.

While this approach is functionally applicable to both offloaded (where
firmware handles beacon transmission) and non-offloaded drivers, but it
introduces scalability concerns. Specifically, in real-time scenarios involving
low-power chipsets operating at high load (e.g., supporting up to 256 clients
with multiple virtual interfaces), repeatedly processing CU updates in user space
at every beacon interval can incur significant overhead. This may impact system
efficiency and responsiveness, particularly under constrained resources.

[1] https://lore.kernel.org/all/1cf0ae795b0e3e95b38cb7abf84ffad34c187fdf.camel@sipsolutions.net/

==================================================================
                Prior Alternative and Limitations
==================================================================
An alternative approach was proposed in [2], where mac80211 would take
responsibility for stitching or updating beacon contents during CU. This design
aimed to address timing constraints by moving the processing closer to the
driver, thereby reducing reliance on user space scheduling and latency.

However, this proposal was not accepted, primarily due to concerns about
increasing complexity and processing overhead within mac80211. The consensus was
that such logic is better suited for user space, keeping mac80211 lightweight
and focused on its core responsibilities.

[2] https://lore.kernel.org/all/20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com/

Problem Statement:
===================
Given the above, there remains a gap between:

 - Meeting strict timing requirements for CU operations, and
 - Avoiding excessive overhead in either user space (hostapd) or
   kernel(mac80211).

Additionally, any solution must work seamlessly across both:

 * Beacon offload drivers (firmware-driven beaconing), and
 * Non-offload drivers (e.g., hwsim and similar mac80211-based drivers).

Proposed Direction:
===================
To address these challenges, a new design is proposed that strikes a balance
between timing accuracy, scalability, and implementation complexity.

The objective is to:

 - Minimize per-beacon processing overhead in user space,
 - Avoid adding significant processing burden to mac80211, and
 - Ensure compatibility across both offloaded and non-offloaded driver models.

This approach is designed to meet CU timing requirements efficiently, while
remaining scalable for high-density and resource-constrained deployments.

======================================================================
                        ATH12K Design
======================================================================

Currently in the ath12k driver [3], beacon updates during an ongoing CU session
are handled entirely by firmware. The firmware is responsible for
composing (“stitching”) the beacon contents based on inputs provided by
userspace.

For example, consider a Multi-Link (ML) reconfiguration scenario where Link A
initiates a link removal. In this case:

  - Link A includes the Multi-Link Reconfiguration element in its beacon.
  - At the same time, Link B also incorporates the same element in its beacon
  and updates the BPCC value within the Reduced Neighbor Report (RNR)
  corresponding to Link A.

Link A and Link B (part of MLD) originally beaconing just fine:

┌──────────────────────────────┐ ┌───────────────────────────────┐
│         Link A's beacon      │ │         Link B's beacon       │
│                              │ │                               │
│......                        │ │......                         │
│┌────────────────────────────┐│ │┌─────────────────────────────┐│
││RNR Element:                ││ ││RNR Element:                 ││
││  TBTT INFO:                ││ ││  TBTT INFO:                 ││
││    MLD INFO:               ││ ││    MLD INFO:                ││
││       LINK ID: B           ││ ││       LINK ID: A            ││
││       BPCC: 1              ││ ││       BPCC: 1               ││
│└────────────────────────────┘│ │└─────────────────────────────┘│
│......                        │ │......                         │
│┌────────────────────────────┐│ │┌─────────────────────────────┐│
││MULTI LINK Element:         ││ ││MULTI LINK Element:          ││
││  COMMON INFO:              ││ ││  COMMON INFO:               ││
││     LINK ID: A             ││ ││     LINK ID: B              ││
││     BPCC: 1                ││ ││     BPCC: 1                 ││
││                            ││ ││                             ││
││  Basic STA profile count: 0││ ││  Basic STA profile count: 0 ││
│└────────────────────────────┘│ │└─────────────────────────────┘│
└──────────────────────────────┘ └───────────────────────────────┘

Link A started link removal, during link removal, the beacon would look like

┌──────────────────────────────┐ ┌──────────────────────────────┐
│       Link A's beacon        │ │       Link B's beacon        │
│                              │ │                              │
│┌────────────────────────────┐│ │┌────────────────────────────┐│
││Capabilities Info:          ││ ││Capabilities Info:          ││
││   BIT 6: CU Bit: True      ││ ││   BIT 6: CU Bit: True      ││
│└────────────────────────────┘│ │└────────────────────────────┘│
│                              │ │                              │
│┌────────────────────────────┐│ │┌────────────────────────────┐│
││RNR Element:                ││ ││RNR Element:                ││
││  TBTT INFO:                ││ ││  TBTT INFO:                ││
││    MLD INFO:               ││ ││    MLD INFO:               ││
││       LINK ID: B           ││ ││       LINK ID: A           ││
││       BPCC: 1              ││ ││       BPCC: 2              ││
│└────────────────────────────┘│ │└────────────────────────────┘│
│                              │ │                              │
│┌────────────────────────────┐│ │┌────────────────────────────┐│
││MULTI LINK Element:         ││ ││MULTI LINK Element:         ││
││  COMMON INFO:              ││ ││  COMMON INFO:              ││
││     LINK ID: A             ││ ││     LINK ID: B             ││
││     BPCC: 2                ││ ││     BPCC: 1                ││
││                            ││ ││                            ││
││  Basic STA profile count: 0││ ││  Basic STA profile count: 0││
│└────────────────────────────┘│ │└────────────────────────────┘│
│┌────────────────────────────┐│ │┌────────────────────────────┐│
││MULTI LINK Element:         ││ ││MULTI LINK Element:         ││
││  Type: Reconfiguration (2) ││ ││  Type: Reconfiguration (2) ││
││  Per-STA Profile 1         ││ ││  Per-STA Profile 1         ││
││    Link ID: <Link A's ID>  ││ ││    Link ID: <Link A's ID>  ││
││    STA Info:               ││ ││    STA Info:               ││
││      Length:               ││ ││      Length:               ││
││      AP Removal timer:     ││ ││      AP Removal timer:     ││
│└────────────────────────────┘│ │└────────────────────────────┘│
└──────────────────────────────┘ └──────────────────────────────┘

From the user space perspective, hostapd constructs the Multi-Link
Reconfiguration element and conveys only the relevant element to the firmware.
The firmware then integrates this element into the corresponding beacon frames
for all affiliated links and continues transmitting updated beacons within the
configured TBTT window for the CU session.

Firmware Notifications:
=====================
During the CU lifecycle, the firmware provides explicit notifications to both
kernel and user space to ensure proper synchronization:

STARTED:
--------
Indicates the initiation of the link reconfiguration process. This notification
allows both kernel and user space to transition into the CU handling state.

COMPLETED:
----------
Triggered after the final beacon corresponding to TBTT = 1 is transmitted. At
this point, the firmware removes the Multi-Link Reconfiguration element from
all affiliated AP MLD links and signals completion to kernel and user space.

RX MGMT Event:
-------------
While a CU session is in progress, if a Probe Request or (Re)Association
Request is received on the AP MLD, the firmware forwards an RX management
event to userspace. This event includes the current TBTT and BPCC values,
which hostapd uses to construct appropriate Probe or (Re)Association Response
frames.

[3] https://lore.kernel.org/all/20240807034521.2091751-1-quic_mdharane@quicinc.com/

======================================================================
                        DESIGN PROPOSAL
======================================================================

Introduction:
=============
The design proposal ensures that during an ongoing Critical Update (CU) session,
beacon frames are dynamically updated by the driver or firmware to include the
required CU elements and indication bits. It establishes coordination between
kernel, driver, and user space to track CU state, handle lifecycle notifications
(start/completion), and maintain consistency. Additionally, management responses
such as Probe and (Re)Assoc are updated with accurate CU parameters
(e.g., TBTT), ensuring synchronized signaling without requiring full state
re-transmission from user space.

Beacon Update Handling:
=============================
For non-offload drivers (e.g., hwsim), beacon updates during a CU session are
handled in a manner analogous to firmware-assisted designs. The driver is
responsible for stitching the required EHT/UHR CU elements into the beacon
prior to transmission.

Assumptions:
===========
 - A mechanism can be added to notify the driver when a CU session is active.
 - A common interface can be added to retrieve the required Critical Update
   elements from mac80211.

Compiling Beacon frame:
======================

Upon receiving the reconfiguration element from hostapd, the driver retrieves
the beacon template using ieee80211_beacon_get(). If a CU session is in
progress, the beacon is updated as follows:

1) Retrieve the base beacon using ieee80211_beacon_get()..

2) Compute the updated length: size_t new_len = skb->len + ie_len;

3) Allocate new_skb:
   struct sk_buff *new_skb = dev_alloc_skb(hw->extra_tx_headroom + new_len);

4) Insert the new element in the respective position.

5) Set the CU indication and transmit the updated beacon for the duration of
   the TBTT window.

6) Remove the CU flag after the DTIM beacon is sent out.

Notifying user-space:
=====================
Since user space (hostapd) primarily initiates the CU procedure, the kernel is
expected to provide explicit notifications for CU lifecycle events:

 * STARTED — Indicates that the CU session has begun.
 * COMPLETED — Indicates that the CU session has ended.

For instance, in ML reconfigure, hostapd can trigger a BTM frame to let the
associated stations know that this link will be removed after a period
indicated by TSF offset.

Thus, adding a notification framework for indicating started/completed will be
helpful for user-space to take necessary actions like sending BTM broadcast
frame with link removal imminent bit set after link reconfiguration removal is
started.

Example design flow for link reconfigure in the proposed model:

 *           (Initiate ML reconfigure)
 *
 * [*] = New NL command/attribute
 *
 *    +---------+      +---------------------------+      +-------+
 *    | hostapd |      | nl80211/cfg80211/mac80211 |      | hwsim |
 *    +----+----+      +-------------+-------------+      +---+---+
 *        |                         |                      |
 *        |--.                      |                      |
 *        | Initiate ML reconfigure |                      |
 *        | + build ML Reconfig     |                      |
 *        |   element               |                      |
 *        |<--'                     |                      |
 *        |                         |                      |
 *        +-------------------------+                      |
 *        | [*]                     |                      |
 *        | NL80211_CMD_CRITICAL_UPDATE                    |
 *        | attrs:                  |                      |
 *        | NL80211_ATTR_MLO_LINK_ID,                      |
 *        | NL80211_ATTR_AP_REMOVAL_COUNT,                 |
 *        | NL80211_ATTR_IE,        |                      |
 *        | NL80211_ATTR_CU_TYPE (e.g                      |
 *        | reconfig/TTLM/UHR)      |                      |
 *        +-------------------------+                      |
 *        |                         |                      |
 *        NL80211_CMD_CRITICAL_UPDATE                      |
 *        |------------------------->                      |
 *        |                         |                      |
 *        |                         |--.                   |
 *        |                         |   Based on CU_TYPE   |
 *        |                         |   (EHT [Reconfigure/ |
 *        |                         |    TTLM etc.]/UHR    |
 *        |                         |    params), choose   |
 *        |                         |   nl80211_remove_    |
 *        |                         |    link() for link   |
 *        |                         |    reconfigure       |
 *        |                         |<--'                  |
 *        |                         |--------------------->|
 *        |        +--------------------------------+      |
 *        |        | [NEW] Send element to hwsim    |      |
 *        |        | driver via ops                 |      |
 *        |        +--------------------------------+      |
 *        |                         |--------------------->|
 *        |                         |                      |--.
 *        |                         |                      |   Compile
 *        |                         |                      |   beacon
 *        |                         |                      |   with new
 *        |                         |                      |   element
 *        |                         |                      |   and CU
 *        |                         |                      |   bit set
 *        |                         |                      |<--'
 *        |                         |                      |
 *        +-----------------------------------------------+|
 *        | [*] NL80211_CMD_CRITICAL_UPDATE_NOTIFY         |
 *        +-----------------------------------------------+|
 *        |                         |                      |
 *        |                         |<---------------------|
 *        |                         |   notify started with|
 *        |                         |   tbtt set to > 0    |
 *        |<------------------------|                      |
 *        |                         |                      |
 *        | EVENT_LINK_REMOVE_STARTED                      |
 *        | <start BTM and other respective actions        |
 *        |  that need to be completed before TBTT window  |
 *        |  ends>                                         |
 *        |                         |                      |
 *        |                         |                      |
 *        |                         |                      |--.
 *        |                         |                      |   Remove CU
 *        |                         |                      |   bit after
 *        |                         |                      |   DTIM
 *        |                         |                      |   period
 *        |                         |                      |<--'
 *        |                         |                      |
 *        |                         |<---------------------|
 *        |                         |   notify completed   |
 *        |                         |   after beacon with  |
 *        |                         |   tbtt=1 is sent     |
 *        |                         |   <completed will be |
 *        |                         |    denoted by setting|
 *        |                         |    tbtt=0 while      |
 *        |                         |    sending to user-  |
 *        |                         |    space>            |
 *        |                         |                      |
 *        |                         |                      |--.
 *        |                         |                      | Remove
 *        |                         |                      | reconfigure
 *        |                         |                      | element
 *        |                         |                      | from
 *        |                         |                      | partner
 *        |                         |                      | profile
 *        |                         |                      |<--'
 *        |<------------------------|                      |
 *        |                         |                      |
 *        | EVENT_LINK_REMOVE_COMPLETED                    |
 *        |                         |                      |
 *        |--.                      |                      |
 *        |   (cleanup/disable/     |                      |
 *        |    remove link)         |                      |
 *        |<--'                     |                      |
 *        |                         |                      |
 *        |------------------------>|                      |
 *        |   Set beacon for all    |                      |
 *        |   enabled BSSs          |                      |
 *        |                         |                      |

Note: If a new CU update is triggered while an existing CU session is ongoing,
hostapd only provides the delta (i.e., the new element). The driver (or firmware,
where applicable) is responsible for combining this with the existing state when
generating subsequent beacons. Re-sending previously applied CU parameters from
user space is not required. Also, it would internally handle the MBSSID
cases as well.

Adding current TBTT in Probe/(Re)Assoc response:
================================================

In the proposed model, the driver/firmware is responsible for maintaining the
current TBTT state while updating beacon frames during an ongoing CU session.
Consequently, any Probe Response or (Re)Association Response transmitted during
this period must also carry the corresponding CU element with the correct and
up-to-date TBTT value.

Two approaches are considered:

1) Updating TBTT in Probe/(Re)Assoc response in mac80211:
=========================================================
In this approach, mac80211 updates the TBTT value before transmitting management
responses:

When hostapd queues a Probe/(Re)Assoc Response via NL80211_CMD_FRAME, mac80211
checks if a CU session is active. If active, mac80211 retrieves the latest TBTT
from the driver/hwsim. The TBTT value in the response frame is then updated
before passing the frame to the driver for transmission.

To support this, NL80211_CMD_FRAME is extended to include an array of offset
attributes indicating where TBTT values must be updated within the frame. This
is required to handle:

 Multiple concurrent CU contexts (e.g., EHT ML reconfiguration and UHR CU), and
 Updates within per-STA profiles (e.g., partner link CU scenarios).

For updating associated counters two options exist:

 1) Fetch the latest value from the driver at the time of transmission, or
 2) Pass the value from lower layers along with the frame.

The former is preferred, as it ensures the most accurate state at transmission
time.

      +-----------+               +------------+    +----------------+
      |  hostapd  |               |  mac80211  |    | firmware/hwsim |
      +-----------+               +------------+    +----------------+
           |                              |                  |
           |                              |                  |
           |<-----------------------------|                  |
           |     NL80211_CMD_FRAME        |                  |
     +---->|     Probe/(Re)Assoc request  |                  |
     |     |                              |                  |
 Compile   |                              |                  |
 response  |                              |                  |
     -     |                              |                  |
     +---->|----------------------------->|                  |
           |    NL80211_CMD_FRAME         |                  |
           |    Probe/(Re)Assoc response  |                  |
           |                              |                  |
           +------------------------------+                  |
           |*NL80211_ATTR_CU_TBTT_OFFSET  |                  |
           |                              |                  |
           | Array of offset attributes   |                  |
           | to denote the TBTT           |                  |
           | placeholder for updating the |                  |
           | latest count                 |                  |
           +------------------------------+                  |
           |                              |----+             |
           |                              |    v             |
           |                              |Update            |
           |                              |response frame    |
           |                              |    ^             |
           |                              |----+             |
           |                              |                  |
           |                              |----------------->|
           |                              | Queue response   |
           |                              | frame            |
           |                              |                  |

2) Propagating TBTT to user-space:
==================================
To reduce per-frame processing in mac80211, this approach propagates the
current TBTT value to user space:

The kernel includes the current TBTT and CU type as part of
NL80211_CMD_CRITICAL_UPDATE notifications. Hostapd uses this information to
construct Probe/(Re)Assoc Responses with the appropriate TBTT values before
sending them via NL80211_CMD_FRAME.

While this avoids additional processing in mac80211, it introduces potential
latency issues. Specifically:

The response may be transmitted after the CU state has changed
(e.g., TBTT progressed or CU completed), resulting in stale parameters. The
driver/firmware must therefore handle such cases, including rejecting frames
containing outdated CU information if the CU session has already completed.

A similar user space–driven model was previously proposed in [4]. While it
requires refactoring to align with the current design, it provides a high-level
reference for propagating CU state to user space.

[4] https://lore.kernel.org/all/20240403162225.3096228-1-quic_rrchinan@quicinc.com/

With this design of stitching beacon in hwsim/firmware, we believe the proposed
design can effectively meet real-time requirements, including high client
density scenarios on low-power chipsets, while also enabling validation through
simulation-based test environments (e.g., hwsim) for various Critical Update
cases.

Please let us know your thoughts on the same.

[Note: EHT Link reconfiguration is used as an example to depict the
proposed design. The same will be used across other Critical Update
(EHT/UHR) handling.]


