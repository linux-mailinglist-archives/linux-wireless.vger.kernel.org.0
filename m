Return-Path: <linux-wireless+bounces-34498-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABRnEV6m1WnE8QcAu9opvQ
	(envelope-from <linux-wireless+bounces-34498-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A41EB3B5C4F
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05ADF30263D8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 00:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C420F10F1;
	Wed,  8 Apr 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ozn7WthP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jbSrNElu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABEF26158B
	for <linux-wireless@vger.kernel.org>; Wed,  8 Apr 2026 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609432; cv=none; b=PYaBVPDvNdrQerNe6vfhNn8wm3PFJTnRlbo64GJOrfzPD5V2gspRxM80M84MPX92SphbLCt/K2O21uvZBr88Id952udeYVgf/3QxoFJAh3ZzIjfsWBJxf6WKtrrfPq73EpwG8Xu/5pQevgOOKWNllkZ+A5qNwb4vmq0ImOkZALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609432; c=relaxed/simple;
	bh=JadK1G6SodnytN13CyWj16Y2EAUuVbkt3LroQE6qaHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BZyrrg4RQEwOa0ulUIx5g+hHGCxqcaajLxQ55DbwyTfCRNG2phyzWEMtnxMHy+pVxaMuxF6a5C1rx4ogd94cy5lxwedPWTMgbf28gBALhaB5IRsQYcHX4Vd6YRUPB2fcTVP/oXlGL122U9jhB1fNFMhcmgg8cfDxoEg/ypXgV5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ozn7WthP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jbSrNElu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Nfl651259505
	for <linux-wireless@vger.kernel.org>; Wed, 8 Apr 2026 00:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vZTNOOdtudOY8XMCR7pZ8ZR6sfE8wSEZmRjAYzSYcJU=; b=Ozn7WthPBRVuJnAn
	R8cRKP/NfkUaYVvtFNTo1lVFDm3WaMeomXH8IzMMPeCCXVqvTILnC54DqscGLayq
	1mgp2AeSRjSl7p9Icr9j6ldT04UQ0r3+te3LVnZyynLEw85H8VmvVwpXm6yjj81E
	g3vqrIJ9LpWooIcgpuIHQCHYxUA3rzKw0dyhQ8uurSBmBi4xiPmaIIKIrebhFuIp
	zZj+LTxzvbm9CR6+IRZSxrby/CoLXcCemdy47Q/Ogeu8aI+OaqWlh0qqf2MNThjy
	wG9chVW2HraYFmntj1cV09+/XZlPFtM/pwRbC0A7+3PzUVRqsBfbNul9iBCHpL9G
	xLkN/Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddbttr54t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2026 00:50:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12711ec96fbso22109584c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 17:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775609429; x=1776214229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZTNOOdtudOY8XMCR7pZ8ZR6sfE8wSEZmRjAYzSYcJU=;
        b=jbSrNEluipPZlMWBjaY0Z+83sl/jcXMhcfpX2S1PWpGJgbS33v6YsI04vtsdoHUwLS
         EBVlNMpa0tVoY93HpCR/GassmEMyiIxfX4y02WzkoSu3C6OEabcSa3jX9eDbI8E5oQMp
         jBPS2yytJZ0Dq3HmToz1UyviB/nIq3UkxEURHDrdIPl7bTkcZLViGgkUSvYMy6BuChXz
         FN+Am/zQ1h7DgpPlkYgPbRYTAJhTP0DHwhqaYURyZSJxS5Cl7oRpb3l2gXTyX29rwFRo
         iCokqlsf2rYYB1SYumPmGW4DY/rcnaMwbYWxfWdAmE+2K75JdLgjbrBTukKc+z4FOFsh
         OJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609429; x=1776214229;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vZTNOOdtudOY8XMCR7pZ8ZR6sfE8wSEZmRjAYzSYcJU=;
        b=YtYn/CChH7OJTBeNLarIvHn0AXiC5ODebuUtk9a/M380R+k8d1xzzHbg67ajqaedqv
         APFUMQzOJ7B3tkUSyF5Fkw5LCnQfjd47Y3cl99m9hV0vGmfkL9j/+k5QSZkTIYuyBuIV
         raZt97MejO9gqp9nubkjE6pI5hymru90IM5q4r2rlTEl1c93+wzCd2NNlW9SnrQz2UnQ
         Mn8uYqUDXg9qcDnJSyDDRLYY0tPCUnLrG+Vvo28wFoWLVljw7yVjQeIilbjQorf2j7/Z
         JboJPL+swYR9nULsCVHKrHV9wo0cux5aHImJ+TP9fp5bY8el2Z/3okmMOfuNr5JmuYYU
         AW6A==
X-Gm-Message-State: AOJu0YwERb7SD6ml5h8+6511Xkx4LAQbHkp3o1Cgj7sw7tRMAmJVLhQG
	2+EljiBB3L+SJVCBPN3NILL51OtTibXWntwZUsMa2q/EXQKp72cL1Gf39dzh5MSH58sMMNGdgdB
	ciV5ayvqI7fJCbeVqzm4IcP+xkqchyNw/04csQEFdHRssEuCunKKgVDAt9T0mWjeLC8sr4A==
X-Gm-Gg: AeBDieup4QhJ0d8HOqA6XNsunOo9qlc+xI7F1VZb2MQEVH5cfcl2vbOBa7BdyO4A1qf
	4KjHzlCyD5c23uccnzfxDM7R55O8whrZiWG+Ye1iUJ7J14RgJMDudlh1e7MgWd3ZCvcx33jRHVO
	fPizJwTmRGIjHw/Huq1JaSwWquO7X4pyM6ag382maUiyDn6Jd1pT7K2BzrVG602NG5AgkYYnG0q
	kbLsavogeFZsIAIZa6yO3nlwRIuuw/qBY7QznkHJh9mI78knDyIIIzn5XR9OLMiEmJyZnZGsK9S
	zsJzflPGHUooDlcAWZ578YC/sUy6kIeFn1P9Pq0NUpXwY9MyEokKWirIXAvpDKjRkRHklWM9Ix9
	euY8R0Vz54E/Q7qGLz/HNAgTxGngaNkQbQPoGZVYw/qUXLqkq1/AXPP1hZI+vFsHaWCUIf5HrIb
	xu
X-Received: by 2002:a05:7022:4396:b0:128:d2a5:709c with SMTP id a92af1059eb24-12bfb76f887mr9822355c88.33.1775609429123;
        Tue, 07 Apr 2026 17:50:29 -0700 (PDT)
X-Received: by 2002:a05:7022:4396:b0:128:d2a5:709c with SMTP id a92af1059eb24-12bfb76f887mr9822319c88.33.1775609428543;
        Tue, 07 Apr 2026 17:50:28 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d2d5409fd1sm1257301eec.13.2026.04.07.17.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:50:27 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Roopni Devanathan <roopni.devanathan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
        Harshitha Prem <harshitha.prem@oss.qualcomm.com>
In-Reply-To: <20260402051402.3903795-1-roopni.devanathan@oss.qualcomm.com>
References: <20260402051402.3903795-1-roopni.devanathan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Create symlink for each radio
 in a wiphy
Message-Id: <177560942713.2878209.5525143192959928768.b4-ty@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 17:50:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: HqnWMwrMn2hSmxp8xURSIZBGlG9CTPM4
X-Proofpoint-GUID: HqnWMwrMn2hSmxp8xURSIZBGlG9CTPM4
X-Authority-Analysis: v=2.4 cv=TOt1jVla c=1 sm=1 tr=0 ts=69d5a656 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=mDO2wJrryWFW5kN2vdwA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAwMyBTYWx0ZWRfX1u/Bxs0mkutL
 sJIhfTRfURLDAyQqKbL6weiS+41ik+4T+Sw68ydfJ2DkSoWKn/6VkzNGbDIClDjvAnHJV+Tt2Pd
 nSeQF3ugGeaYlFtvglY27ok9PZNNI7CyGu2ycxDNkiRmfAx5tHE6dCzvD7bLKBv2Acs4I8IqcYn
 kqy9C9GNLvDuryEYdOeM9OtXCRvXQFR/p5RGXOI0Rhw4LWqFuQFm3MLqFpZrgD7FCnfNaurcND6
 ksoR7fKh+mwxyr2pvSmthXew7/DhiO/i5wHnvkBX6DeeQKz/0n7z+e14uLsGazPgQGKvyieoRqI
 KzO26zLT/vAllPsFOLdNTMYvENwgWaZGlRlj0QOXTzB78RyTXlazT+rIMxnxlhQitL7gIS9hp7T
 iiiy09bIjG2n1E0foBvGT3QmNPtVHstxxPhPAEyobdxfmfvh6WC+nR8EIvGX1KopP4Uox2td3vf
 /9QtZFa1e1zGBuOkQIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_05,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080003
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34498-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A41EB3B5C4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 02 Apr 2026 10:44:02 +0530, Roopni Devanathan wrote:
> In single-wiphy design, when more than one radio is registered as a
> single-wiphy in the mac80211 layer, the following warnings are seen:
> 
> 1. debugfs: File 'ath12k' in directory 'phy0' already present!
> 2. debugfs: File 'simulate_fw_crash' in directory 'pci-0000:57:00.0' already present!
>    debugfs: File 'device_dp_stats' in directory 'pci-01777777777777777777777:57:00.0' already present!
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Create symlink for each radio in a wiphy
      commit: 0ec4b904be72f78ba6ce6bb9a8aaf2eb6b9b1004

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


