Return-Path: <linux-wireless+bounces-36234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MqwLbHvAWpHmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:03:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B085D510C66
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F170300669A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DEA2609C5;
	Mon, 11 May 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bTKOj4Ng";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mzfunq9G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE2426E6F8
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511788; cv=none; b=iUv5M4vyHC2ncE1vP0yot9ylW0o0YoVM5p5gW18+1ODYzz7HWjRwNNKAr5P+/x111xrhiN4k5WYozvQ4Ipx0xirPHOATZnvS5juFGz1fRVVZKve8zCD57KYPQTxoKKDCTLIby421pbrVZeW1UFDqqblJLqNDzywy912yjLJ64hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511788; c=relaxed/simple;
	bh=0O8CI662ImQKucOp61s9GkYQVAtl+MfCYdGCr50LgkA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZH/PyovnlogaSkWB3wSw3GjgaMgVp36AKRbppkvmTSpeIeDBXq++QUNu4pWKKj7mbnFGCGrfM8aj+AG7lZUHa8+2WeUDIV/L7H6/N0PPgP6gHUdSXLMz++YNHVq3QrdQO7P5tA3OG3mOONaGGDrgzgmFAvJtHan0KXTaKpJQO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bTKOj4Ng; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mzfunq9G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BEpmIE1513264
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hRxhJ5mTvCjFZIndOfyaO6dCRCdhiBeWG0xde26mWWI=; b=bTKOj4Ng8ISC+D5F
	TNtWN0Ca/5+g/9qeCO6wHZXf6d8B+3ywdFz+dJpNP6zYCaBeb2Di5y0xg49aruxN
	aTeXDYyuIM2EMScvRlkYf8lHQ4OE2umRWEHEYB49oIA8Joo0pNTrTMwLmhcW+Dce
	E8x853nQlAWOsV4lHHpjxwBXX6f13YbCIee9oRhrtW3WZaPhRPZpm5EFbLl0FFzx
	9aZP+Vhxl76ZkF4ztclb/eIZcOwANiVEvOD4Hwk5NH7nTgeqh8j92WIY/FcDdgDD
	WbeERdeeSfnbU6l4eNY/+98CAw27UhdFLHhEP/WF5QbqmyYg+YAjLhym2yA8NzMz
	z6ppNA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3h8g81t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 15:03:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f525565b33so5514755eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778511786; x=1779116586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRxhJ5mTvCjFZIndOfyaO6dCRCdhiBeWG0xde26mWWI=;
        b=Mzfunq9GZFdET5X5KUggHq35Svm2QGGR8GIV195fo9Ddw/45yDl9a3eOIsqDKFWwD/
         bgRtsLEKwEx6h2wKxYBAggLAifO4o1CrxP3JOPr04Iy1BGpdLIh2IFi/yJNRlt68KNDC
         GBCRMf2uw5cMzauCEHYSmdezYVm1noDTc3uBMcRD/3oG42NL1Ly9xhZ8qdoDwAyeShv+
         M6LCsXSxfyA8U4nefMl4d8opxn3nZutOgoR8b4T6Oo4UHiQtwjQxA5FqxOaZHMtCCKeS
         CM/1TmkKJwzjHQ69+FYdh9pKcNjCNVrra2IgCQTNR+IuXCYxU2AkseZ3OYrz/NbjsiLU
         3RnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511786; x=1779116586;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRxhJ5mTvCjFZIndOfyaO6dCRCdhiBeWG0xde26mWWI=;
        b=dDSXs0REGuLEiqXyF5a4wJJ7+gbkN+d1U452fPTB8mX8VN+FWfaKZi33Rd3PrIJgnQ
         KhrjFYDSrQAlX0yvWTLeXiFnRK42xO4H3ja0kelMsRszzhj4F2Rv6NCzKGrS7/ho6l2n
         JGbULNqfnDhkwr9/tX1dU3/Dhx93AaxWbSDpBBOGHO5ahBtxboIe6E7/6MMRJPCNE6TU
         5UjjEyr8UDgmFLPqFqWU2dhTcfSxh8n1ADh/bWR7n+F+e3s73VOMvwGxaZXEG0slyuwG
         V/uFnqtcpgWJmMfbR0n9cDT58xF3PFH/5w5QEe90tILxL/P//SBH7GaCIB+1jkmXrlHu
         6ejg==
X-Gm-Message-State: AOJu0YwjUGRYnvP3Yz1CPubpVv5+yDaFg7HOb6oxzFCqIFQ2ExAvGBv6
	nJHE+60Jr6+dm20IWittzqoy/zZaM6w3GGXghnjlYtBGB45CXxg0nCVpz18xrqKBn61N4jzNiUT
	sWoQByWUWJMuwbUcqAKDjBJcLVOerLydkWtu/smWCHSgIZBWiNlQKnMElyFF54+LBQ5fIMQ==
X-Gm-Gg: Acq92OETn1qLXJdSCy3OdBqUWBRosLgM/J7ZuZaDJypIbFCjIkRxTe94jtKDIIv7c5q
	BqSZ6WJTzinTjePttzg31Oxx9uK6XFPFJxr8vE5m+GteYaGiZ1HwdGgV2AKFkkh8kPWe91QEUyz
	FfX1U4AwcvtKQvVdmF3jUhQdqJ1/982jUp7wphrKJKMRSG/7kwWfaZOXwWuhipxQ4/Kt3tVlE/L
	afO3c6jBd9iCYLFZy2y5bqjUQjy3T0F+zH8pnoojwqy6BHrCT6JuxUcjiSRhug/CoX15Ry9Wj/w
	3NVzfDW0jQM3cYIY+EPdj1WiFB3uUKV3ySsYl3H07PoTr1o+vbfCNdHc1d6trnaOlViIsB2TLnO
	gX6r/VFyVPe4Ow1ppYQKGeybr+uQdpDyO6cf4c/u2AAECZiHVK0+3s6op7xMCUc04SBJ+ZhSvVi
	hk
X-Received: by 2002:a05:7300:a2ca:b0:2e2:d94d:6175 with SMTP id 5a478bee46e88-2f54dc8ef26mr11350434eec.12.1778511785479;
        Mon, 11 May 2026 08:03:05 -0700 (PDT)
X-Received: by 2002:a05:7300:a2ca:b0:2e2:d94d:6175 with SMTP id 5a478bee46e88-2f54dc8ef26mr11350334eec.12.1778511784591;
        Mon, 11 May 2026 08:03:04 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm17330453eec.6.2026.05.11.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:03:03 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Yingying Tang <yintang@qti.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, yingying.tang@oss.qualcomm.com
In-Reply-To: <20260415063857.2462256-1-yintang@qti.qualcomm.com>
References: <20260415063857.2462256-1-yintang@qti.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: add channel 177 to the 5 GHz
 channel list
Message-Id: <177851178375.1372190.10510636976243066301.b4-ty@oss.qualcomm.com>
Date: Mon, 11 May 2026 08:03:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2NSBTYWx0ZWRfXx/qU+P7Uq5x0
 8TzXDwgg99fny8RlJf4g3Yt8oZy/60ls23M4sCViRAmT0vEJXLuiJPjxvk1kBz2L9v+AOLQzt7h
 aQIJ11AhA5r7GDhJ8Vk0MFZLhUBeFtgC7k4DmzDfzgATfyXU+ZFOK2VJIKcH0ZM1zcaA+sb3Xog
 2O3sQJBtUc55QL1NqdmwtjPmmUZLvisrPkI1cRMoCF7UUOcJnU2U+7CsbMnBwmjZUdSgg54eLsi
 Z01BvPVb1KRsZFHShoyTaIXbJ5s9Fg/T9QhnPuYL7MGwvxvSFP0x24z5CZJLVK8x9mUuSjJt0ir
 9ql7zJqLML/DJTyAtYw72qx97cwwTvyzrhJj9EtjvkEoVO/gPC5OA03HO3tGvqegDGf9rzSKG3Y
 BV8DqltReF7vZacXI5U0ZahrTvhYKm6Uku8YcjlVP19cLyFMRXbN4edZSnGC93FZ1XfJRop1MjL
 Ghck+Lr6DzqcG4WkB6g==
X-Proofpoint-GUID: 0O1cYC73EM4XZQtvOLmXA8RLBCd1n6BQ
X-Proofpoint-ORIG-GUID: 0O1cYC73EM4XZQtvOLmXA8RLBCd1n6BQ
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=6a01efaa cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=dGk-cjk1AREVnTvJvk0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110165
X-Rspamd-Queue-Id: B085D510C66
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36234-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Wed, 15 Apr 2026 12:08:57 +0530, Yingying Tang wrote:
> Add support for 5 GHz channel 177 with a center frequency of 5885 MHz and
> Operating Class 125 per IEEE Std 802.11-2024 Table E-4.
> 
> Channels 169, 173, and 177 are in the 5.9 GHz band and must be disabled
> when 5.9 GHz service bit is not supported. The 5.9 GHz band is only permitted
> for WLAN operation under FCC regulations.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: add channel 177 to the 5 GHz channel list
      commit: 1e8ab2e2e9622d7fa31810a4d7031614e2945f45

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


