Return-Path: <linux-wireless+bounces-35734-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPWKD17L82mL7AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35734-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:36:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B314A8451
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 23:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8C523023370
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A853CF684;
	Thu, 30 Apr 2026 21:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNy6/D91";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LoM5lqOH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261A3BE172
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584657; cv=none; b=Dv7vY+NW6X5FLjhj8s2HzW7G+lH+Vy7STYbKadG2FZyE6SkIFXNWANg46GCdu/VnBdAgViZQlpiq4bXQUFB7ghS4YLS1407+OxWZnU67dbVk9MVEiCDTqFrwGMoF+76ERZVCEwuh9yeLODNVAYmWWr3rZzC27oakwTdybYZ2UV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584657; c=relaxed/simple;
	bh=DRdpZx0Uab50BZ0cXSSvQxZDsWsW6asC8g1Mw5P/EL4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=euC9d+nkZBytPV8MNGRONG+92fRwMh/rIk/3H53M8sMRZUqN+ghUMzqzBno6D+Bev6ER/B9uye/5NobH1Rvyhz+tPU9IbKwRVMf4h0w5/KVhHrcW13mVfldE4wPzJq35YLH9iWMyKRMEPiRyxm5Ni7ew4qK4YR+sskGpFcboJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNy6/D91; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LoM5lqOH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UIbwSS2480914
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JA35kG8zZYw0eGflbjSV5/3DiP55GPnTfmEzbk3/pd8=; b=KNy6/D91egg6H23S
	5xtep9RhB5T2HVeXMWlrSbCzYnMIasW+ulcLEd6MsVe0f283LhKl2DwpwkbkHHUg
	eX/Fn1GVhxH2L0mAnOwh+Xq+9bV4Qio4eef+iOSPctaNdTE0vLU4E8SfU+HKsJlY
	IXQCnBIIpJhxvieqItXOD/rV252q2v4ZGqVOBgrKNulu9v3nNk330KuBOq7znE82
	mLSWA+dFYw77K1LQNFhyk0pI3f192dI607GItSzdCCBYSEg+0NAMTgSEk7pKGIrB
	v0K6M3Jr+sj12mxzPNZXMiZiGK7/bS2iqIyPBZb2MXcDv5B5YYgd19P/R1PxLEWn
	iPAxSw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7x6j833-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 21:30:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2de07c12745so8903469eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777584654; x=1778189454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA35kG8zZYw0eGflbjSV5/3DiP55GPnTfmEzbk3/pd8=;
        b=LoM5lqOH7oifP1kYupitUVOrEz8o8/ypr90ly6+Dv9IeQad9k036fpHEpA118uD6x7
         Equ1vdAlrgrCnpPuVQcnEilc1Ja0PJrsc8S2SGbBtJDl+nLSfRiDhEAPIz+w8T5OMGcy
         CD+bKGxnzrqo+y881nGG4yvqAWIJECzkIOKt3xZX3vGHHdjzPre64hjRblkJbiMYUc+S
         lfuh/TF6tDmlCc0srEXbyoLaaURDOB7sn/4ayYvFkZJbHUgDccoKr12o3USdIgFk/7l3
         v77xx1AmQeqZlWd/bfX042iqqYHbxUKOeNTqasU63FEznJERbKjVVsMnQbf+mhfesohc
         dyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777584654; x=1778189454;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JA35kG8zZYw0eGflbjSV5/3DiP55GPnTfmEzbk3/pd8=;
        b=HDA4xqVwNmhuSLej8+A59W+K3yca8WGnYSK1w2rGEMUMzOA/uIUeANlq+q0h8Z19l7
         XGbsH4WJcjKePhse9cAfblMJmW+Jnhsf7DO3R+QTIJ4e000y6BwLBF7a3Gq1ik7FXpSY
         p6eJdZMsK2zTM8a/UOXu3vS2/RzdoBZPndd8y7Z4mGmyti67m3DSqrnDAh/xh9R5rA+c
         m3dgS30FbnCoEHs6Hw+wv7orAGZ8QYyTO2dLCwVzgbDs0YRee8Nc8wVKGmU9GnlaUcB+
         E00S6mpkvqtjqoOE89h1LIm1vdSUmegqTV9pBcLPHsnASKz3VErM31jINQAwv1UFbf3h
         2MhQ==
X-Gm-Message-State: AOJu0YzmOITgshQsiKg+18TifRCMcGN1QaIBJYz+ybVLZHo1xckd9zxZ
	O1R3wS3NOJxHAFV6zKTvR8MDXR+nq3fvL7TYH8QCN/VQYkcnvv5UywrAXR1Ju4wDHz5/82lYl6P
	ojIWFn0Bj+s4FGnE06s5CzUHypFRXSBt8W+P4AXsO0ptqBB6ozvrNDo7LaGGWcEMW0AzDcZlxAm
	K4Qw==
X-Gm-Gg: AeBDietegqexpdZliYggeIS+YyydkSrx/+SvWbCfCdcaIdfPIwUTXhLGb28erbA/GPe
	jdO3XNsBuqvYwvKFIy+71DXS53fbpgY5tai89XKyGWcXTVqVsElQWVVehv5RWLh8BJQhmcJ7219
	4qnmuV45MKwBMN7TROdyPdz4fFTuG87RprwyycENLd4HzLsituDi511/400FC9QRe6n09m2rTww
	iX2saY/8mIHsPrEf3XZwnPYt121Gzvijh7uiqmYVWgaEYtbzz1DUKPnIPkpscyXGxF5vvIueexd
	ffkTaZMzzTQ/P0oVy5wWyGjI24Zp37/Wp4e7qjuAdV3sQDiNZxlXaPG6oAOZ+o21u7f0OTUaLMN
	jSUn5TXiyb7xEdsPjQ8a6JQDpFkcE9l9ukLG8As5xQMWPnID7QuGFgqMkScHCKQobs88tcHTnZ0
	BkFs6f9+OWMaQ=
X-Received: by 2002:a05:7300:7fa3:b0:2be:2953:fd74 with SMTP id 5a478bee46e88-2ee86bceea7mr191382eec.14.1777584653953;
        Thu, 30 Apr 2026 14:30:53 -0700 (PDT)
X-Received: by 2002:a05:7300:7fa3:b0:2be:2953:fd74 with SMTP id 5a478bee46e88-2ee86bceea7mr191368eec.14.1777584653418;
        Thu, 30 Apr 2026 14:30:53 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm2504861eec.8.2026.04.30.14.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:30:52 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/5] wifi: ath12k: thermal throttling and
 cooling device support
Message-Id: <177758465261.1848985.8700721719961133563.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:30:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: s3WC2r7ES1t_L7QwmoZM8FCnB-YHdfZD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMiBTYWx0ZWRfX7CUrw9K97Jjg
 RaGgydH/RZumnQItnuVJ8CzJ8QgoVbfdIsastqPreBK6KwV35sHikMPcFMSxtvHKviDPKkrjGby
 1mJTif2AX+fISYiApMhq6s91OHKHDU9f6N8mDcORjQv7WyD9cRsbdiOJoti2Bmz+pqW9JPoZDQP
 aNXK6JqLBJEc3CCsE48BQuwOM244Ip2eP5HyI+aUuDYiM35Ka5cfPETEQGZVvwUELkmhMJ1T9cr
 lSahsrtTb/OJ0K5hHLRzeusWeOPKKKpiGJhu0Gy4BcdOJPf2dsLr6FOKDn+dMNIvAfBda1uuDmt
 AD5TffuLKMOzDB4Qu36urQxUMrlJIeuIPhAGsITB5qM/TdHAGRDwJKz9ksYjDm0dTKXLju8+PlZ
 0MpJfRjXYmNbfJtFqYrQEbGUhE6XdRb+VcokZtOKgpdudxci9mTLhuDkIg4qR5tR9LS3cMbxV8x
 iGckE8WfpBubqAYt3wA==
X-Authority-Analysis: v=2.4 cv=XoTK/1F9 c=1 sm=1 tr=0 ts=69f3ca0e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ge_05e0WECY6XzHol0gA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: s3WC2r7ES1t_L7QwmoZM8FCnB-YHdfZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300222
X-Rspamd-Queue-Id: 99B314A8451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35734-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]


On Mon, 13 Apr 2026 21:08:35 +0530, Maharaja Kennadyrajan wrote:
> Patch 1 handles the firmware stats event so we can track the current
> temperature and throttle level per pdev without spamming logs.
> 
> Patch 2 enables thermal throttling at bring-up and programs default level
> tables to firmware via WMI_THERM_THROT_SET_CONF_CMDID; the driver picks
> IPA/XFEM defaults based on the firmware WMI service bitmap, supports 4 or 5
> levels as advertised, and only fills optional fields (pout reduction,
> tx chain mask) when the corresponding WMI service bits are present.
> 
> [...]

Applied, thanks!

[1/5] wifi: ath12k: handle thermal throttle stats WMI event
      commit: 845b613b57c626ac85fdefd47196acfb3172fd49
[2/5] wifi: ath12k: configure firmware thermal throttling via WMI
      commit: 612556eb774f19f0ad64b5f72e890943b95a1339
[3/5] wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
      commit: cd93e8c23ebbd72e9aa799199b14c8433585f747
[4/5] wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
      commit: 0ab4dc09b7819ddea698fe5a0cc711a64186f12d
[5/5] wifi: ath12k: add thermal cooling device support
      commit: e12d2d3983acb150fd987d19ec6a2a530da110df

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


