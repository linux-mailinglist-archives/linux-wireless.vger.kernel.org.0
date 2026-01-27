Return-Path: <linux-wireless+bounces-31241-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOu2IUX+eGmOuQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31241-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:04:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A00798C19
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 402FD3008313
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0C32471E;
	Tue, 27 Jan 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wu2Caxlw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AynnaCbn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D22EAD15
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537091; cv=none; b=RsCVNJagruOM+cgOKeUItlDNuszTy6i7ku6X9zev6gwnVjpxx2A55ERYde8SAs+Tgp9X95mXtjHCJ72HhN1UC0a79g3MGiSPND7RrKJ9AKtHVPWJRDCEsKQTMUazj6vadtxsByAc/CPMmjpEEEf10Ci5sqhEHJOXxBJxKuVPT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537091; c=relaxed/simple;
	bh=G7koS9LYYaJ6CuoQIWWcCcYtxC5jIukD7/1G3poTyy8=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Nz8Ql8a4uB/+NXAtmgR4BX7ilDG63967YR58PV6QiHnMRRU0QcvldyspTXvEZeAMR2Sk9VEFyxfDSC2aM3y0Py0mroJoFoWuUKhEvZtkQn4qjTkhBOgbQwvtorXdTUVs7NvGyJuz7pY51PqtIp3deNTFURTnK6pHtdoHXof5lbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wu2Caxlw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AynnaCbn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RHhSkK2476732
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QVFvCbYDWuc9Uy4/cu59fE
	gOGvV+V4q1pRgPW41gc6c=; b=Wu2CaxlwPtwGU7jx4LETTa2xbPFQclY2GPd9OF
	oPy2bKq1wr46WVkA3VWYyt+o2Xg+3ggEUZiBl70EeORuGgFq5x3VqYd1VFCdEt82
	4O6RYZXtlr0GBM26TFs4oAwi81VPJhO8w1sCLJv6VevBqOYxaWPoCwMZbGjkLFf6
	gCzMgkFjAHPpEMKL76TzGoRzHIphz3oJ3zAOqrp0snxKuQwBvdiFVtxuGO3IjPjg
	lGBU76nldCzqxlckP8OgcXhm96w2BS91sraKzukOGVyF5oPLVq6IHGUxOTuEyjtj
	ghW4JoRux9nukEc6sDzdQhJrQiZsV7Xc9dnHlPFQn7SAjqCg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by20y02fd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 18:04:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b799f7a603so952263eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769537088; x=1770141888; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVFvCbYDWuc9Uy4/cu59fEgOGvV+V4q1pRgPW41gc6c=;
        b=AynnaCbnp7RApG0iVMU6lBBOXw9gRIoQPHvNbyfxvkRg0v+xOyFsBI1J/GN4Lor8IR
         0NTcKQBl3gdl6dNjC/ahCyAgQgmHw8oBTrOV8SdKZG3RW2embprc2y6GUKo2tncRPvwc
         XorhiHdkZsr6EqJ5jni41Qis6y1cckut3vjfZMvM8gVBnWSSpont1mfpqNEN6CsNn5iL
         Mug2N4VNyk5bssu8Hv5nEkvAFddowODBzS/hsNVw4ggMYVx6FVPDh1axPtTMt3UqEQJq
         BotoYUUq2OEioIONspQhxWOFktjyswnm2VBmW8VpKv4u/IQXq/jpC+MBBmRh/quIRjtV
         s1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537088; x=1770141888;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QVFvCbYDWuc9Uy4/cu59fEgOGvV+V4q1pRgPW41gc6c=;
        b=D5nFGclOab/DFWrrFZpRSxjaKM915K5mfXTDmrl/AVWseZKwJY/TA0FBTeGWxvlJjM
         B/mzrTk8YOP6B34cpKKjol2dI+bEUTbqe9AesSWDjbWShFBCgdentzAbIf5ivo+8wQ7X
         QMJ+8S/DMTr22g3hxsV2tfUHxekaOG3aFIgUu53EXS2SLLcRMVDpnTUZbGenbIL1VCXK
         OovH7E9Kfb5ieCv4v+F5uKyeYtjFi3zBbNPYmDc0xWsQc6OEi35uS181jUbCFCi/oEU+
         ZxS35GDhj0AqULPZM3VKXgSY+RHwj+AuLvu2RLxTOfVjE7M+TM9fJrMqpZq+6d2HEi+n
         OlAQ==
X-Gm-Message-State: AOJu0YxpvNmBey2cBy5OQJhZPtSq7pjmdt0YixN98b3hEeaH0yPZVzTk
	mnGW1p6pMYgzHuZq+m7G0khmpyTI8tltYnmgsRyKTMEumz0aWj9+MLsNgiHcpaTRoB/NjToJ80f
	Dxy1V9S2cJYrs1r6iHAtzr8p68C2IZo5hAhPk/1rUraBpdtA2ZAPjWIatzLH5xBoB9xmujQ==
X-Gm-Gg: AZuq6aJUZ8pSoA+QyD52/JCCt+jSRtUMVbzc1sLWSGtbQo3TL56tDUb9Z7u5YYFrDGJ
	Em/3t9O4JOhfbK/kPxJFKMwqbMHjLxYeqcIvhPCiwCzLc269kiu8RUOwTzOxyMKPCaM5EyJgI95
	xK3TWVrsyPAE1bNG6aN5+QP1F3nGijFy+mwgeZd45nCvCo3l2LRJQjcNtOA/u6vIIpZO7F3zY9P
	2d2NqCrbWWf4dxG1hm48GIzGoW5Hromts8T7I2PNpheEG0IaRwRxoTyw1JLrz2n2c8fjd6fgQTt
	lTeKo8mCZ5TNNf1HWRMzXJg7Dc86pB0BGg3gy9Kgb16n9U4il9dwBorvO3TfwM9lHuWw9OBbrft
	6dJ1BhWpb3kv5rPxt1+xe8Ba2AGJsfXFtRBlfZsFjR0YugQ==
X-Received: by 2002:a05:7300:e607:b0:2b7:3955:f51f with SMTP id 5a478bee46e88-2b78da13aecmr1907843eec.38.1769537088034;
        Tue, 27 Jan 2026 10:04:48 -0800 (PST)
X-Received: by 2002:a05:7300:e607:b0:2b7:3955:f51f with SMTP id 5a478bee46e88-2b78da13aecmr1907809eec.38.1769537087460;
        Tue, 27 Jan 2026 10:04:47 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b79c386590sm235612eec.3.2026.01.27.10.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 10:04:47 -0800 (PST)
Message-ID: <6f1fa3be-e28e-4653-bbf6-b0b64b7e65b2@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 10:04:46 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        jjohnson@kernel.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware ath-20260127
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: y8khGv_poD00vwp2-OeFDAxDPguHrt3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE0NyBTYWx0ZWRfX0a7wQTK+5BNN
 OdsOTyrIdWsWgFyIuSGN+FBRJfDikqHeoO5eJ8V3xGWZ68EZSPh1OwB/ueqOPleG7LuP+rw+9oE
 i801fPZw48dsXJNJdeE6g4xpAtrvJc9NBr3FC4PetrfWlGQvPGUN/vW2YvRg4LBUN92X10OFrJc
 aqm6s2g25q4C/x793ISYRIoa7ciL/rzCBmtnEF93r5AKPCQ7Unf4mjdOlK6FSb+V5keZOoI9lF2
 kPP8BF4pdaHfTBzj/7WzxgDtfVTMqTZz51Bd7ulBR6nhXPzcTmaOm5w+DoeE5R8T2A4Jl55CxRL
 /r6xkJETZN25DNOyIc3iyx0bwQ3gN6uBbTvexmMj8AifLgyhBttjS9U3TczqEPG+TIWOz7D8z7Z
 sWjyUQj2qGBxH+1OrJXuXBN5+nN4HSAGZuE36+usI5p6PfXWezHKMm9NU0xRvfro5hMmdA+66Gt
 FGxuUM6id1xfGihDZjw==
X-Proofpoint-GUID: y8khGv_poD00vwp2-OeFDAxDPguHrt3G
X-Authority-Analysis: v=2.4 cv=IKgPywvG c=1 sm=1 tr=0 ts=6978fe40 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=lktd8AmUIn0x_5DxP60A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270147
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31241-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2A00798C19
X-Rspamd-Action: no action

Hi,
Here's a new pull request for ath10k, ath11k and ath12k.

No updates for ath10k.

For ath11k update board files for QCA6698AQ/hw2.1 and WCN6855/hw2.0 to support:
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=255
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268
bus=pci,vendor=17cb,device=1103,subsystem-vendor=105b,subsystem-device=e105,qmi-chip-id=2,qmi-board-id=268,variant=QC_Hamoa_IOT_EVK
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=2,qmi-board-id=34618,variant=QC_QCS615_Ride

For ath12k update firmware for QCN9274/hw2.0.

Please let me know if there are any problems.

Thanks,
/jeff
---

The following changes since commit 0882248d05045565bfefe1f07cbfc22276c9f058:

  Merge branch 'lenovo-ish-uspstream-clean' into 'main' (2026-01-23 19:26:31 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/linux-firmware.git ath-20260127

for you to fetch changes up to 6bbca7605494e4a72b219c2d85a8026e8de3eef2:

  ath12k: QCN9274 hw2.0: update to WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1 (2026-01-27 09:50:03 -0800)

----------------------------------------------------------------
Jeff Johnson (3):
      ath11k: QCA6698AQ hw2.1: update board-2.bin
      ath11k: WCN6855 hw2.0: update board-2.bin
      ath12k: QCN9274 hw2.0: update to WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

 WHENCE                              |   2 +-
 ath11k/QCA6698AQ/hw2.1/board-2.bin  | Bin 986384 -> 1046764 bytes
 ath11k/WCN6855/hw2.0/board-2.bin    | Bin 7056532 -> 7116936 bytes
 ath12k/QCN9274/hw2.0/firmware-2.bin | Bin 15183928 -> 16035896 bytes
 4 files changed, 1 insertion(+), 1 deletion(-)

