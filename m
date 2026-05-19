Return-Path: <linux-wireless+bounces-36667-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PqDFfq2DGqmlQUAu9opvQ
	(envelope-from <linux-wireless+bounces-36667-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:16:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B71584128
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 21:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A2DE304D9EA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B883A873D;
	Tue, 19 May 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oWGmroFR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JXkZ2y6H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954383A719B
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218165; cv=none; b=TvdsXS0SIwlgNyB6YxQ/EPJpkGzbqwPIwYRHSj5X/K6navWsXwiZZV9ZRarFWC6CzBB92nPU6k7awnrzQtr3m10kUXHZ8Lpq1og/TTemKPrAwRiWI/DphqImC3z97PUw/7gg7KC6j2h0+5wH5CyYI8FD00T+nF6PmLbEA9ul6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218165; c=relaxed/simple;
	bh=kITAZBv85mdlvIN2W5xTDC05twe0JNhHxKRT3g8aUvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eZZut1Lslol9kNgqF0tIBAJSUkCGoVL6yeARddmEhETdv4UxaKKDuXKphsGbZba/h1mw1n4xQYCz31qd6fHM6ETw1R4HbmLYI1ceSTzxaqbLLyxkyhbNDxxF5APgDgz+Kf8PywlVkhhBMG66DL5XgfRfV0X2V7zCvPA4WHtGLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oWGmroFR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JXkZ2y6H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JExK5k1237947
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ktk1Kw/2lKXymr7q0r8FC8lBygPFZMuhBa1Igu7Okfs=; b=oWGmroFR1J4jsEh8
	gOJHoUJiiSN02ZcizJr7a5Cu5CSYMZtIKKI4BPI7M4wpNdm5ZHdjaDUpIg2P3rXO
	e9clLxXMaUqIhUe/9uetEe7OLwQkll4sqj/w4ELO/Hnfr5J/ZbFm7pPeZspaO+6L
	wvl4lvL72+pj6I923B79QTA4HJ0+FNt5GjEs29JLt7bQTzG4RMaCKjCbvqbldBOS
	seFM2O7AzIGtCU18zCgmCcyR0ewtJCK9DZnFeaWLXq/OukW+n3e8J41jSmOkasCP
	GY2C2CzliCOuzqNQGT6seYsr973wXjpgnHbGsGi5kBNKjGs39Ye6+nrY9bpOx6I1
	ktTVqg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3ss44f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 19:16:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so753361eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2026 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779218160; x=1779822960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktk1Kw/2lKXymr7q0r8FC8lBygPFZMuhBa1Igu7Okfs=;
        b=JXkZ2y6HvCp+O4ccoDuj2mfNKHy6RBQmJIva08D+K/1zUDdMF1OsFlpoOCQDGBlHBt
         5vS32p8AWe3rieNTcguvOxmDSIMs2fGqRgcPKelinLV/Cc2Q3czlhBfr/n7hMItvhB0X
         P2ijTA+6sTsRC9b7lSnsbMH+9bHyLuW6kxxVmAt8eHNyQtjxqjA2qnecjWFHAcUJH5z5
         K509vSb5ig7fQTe7k2hKB9SIkGgKVQzY8pLsdwlaK1+Hwf1NTeEycBSzhXE/w8DoeYDA
         bpzGqCZjlM4bff2CK2ku8PnevDJF2fEBJKJ/GJXR7GHs3kg8E1GB634sLONp5gjRKYuT
         jO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218160; x=1779822960;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ktk1Kw/2lKXymr7q0r8FC8lBygPFZMuhBa1Igu7Okfs=;
        b=UmglTwkO58uCrncluyTEtwjga1aAIujspRZVPbNdJnRPJXY1ToC+mus5nFtVp+tKMY
         +I3tegYx7zb95YRnfKgQsxp/l7ZkK6ymN6aGtBM3FnZogZsvAiYnA3i6DARK3MNn9BF9
         zy2aMIi0Mn+iSIVJ60zIwkoJd6vsJ4uTE5bMoamBKbtN9sH2to87padgpesvSo99aQNm
         1N1hL86n+aJA+LRq2Nib4f2w6PSpR0p8SER5GD/QaxkE1SzB+l/0PfGQr18DDUKZ/wTt
         qHF8W5dE1n4qr5M96XztVMcYWLcX6a2+CP5KujbaRm0feZ5Buu6a6N3DtQWv3KPwuupi
         OkMQ==
X-Gm-Message-State: AOJu0YxX3CJ4rVwppEFnmYsv4VJERo0YddOFn2IRbm10tgGEjFFzImtg
	Y1So6brbFPF+G4bparngZbVi7Ua/Fgm/7DfYxYJPQWZgmAjhkP+qaYJPtSIfAp80E705z+fMZk5
	BnthckhEDcZvFLbxyPDBFg9ZOAzhFRrH+hBsPMfdo4jOmRCCJN8l4H4/+hcd2fxhN03gICw==
X-Gm-Gg: Acq92OE6ItGHeGBBZYVilz1rWo/sGA26o6rk0y3SZn5256LGFGVqQ6u7i8ic6it3yb1
	NgsIw5Mhp3PckZOmtNaYzM7yt1JgaOJ53wRnRpDDBWwT7M1/IN0//e30zKAoFJ5+dKpfuIgmG2s
	HMtbCw88wx8dMDwEIUQPVZVP9TS7S3/m0VHP8d7r0VMDHCJf5mbmqjZEpYjcp77S+aKUX/+jdaI
	N9gialA++z2shW7/uFpNTSXYu+jW8dyxYTFeXrA86MCDcrdmuZOcU19p++u4SXUeieQ15QN1Dw4
	pQXzPMiMjT4GpwXCErSI4hYSkzwcCx+AtGj5GGlSO3E4SOIYIt2E70MNnD6IfJHZ+66f2ogThSx
	DkIFupcS9iqe1P29ABIOlDZegJBMB9jt4N145KcY2Vgic4fiFl3o2TNJOyqKJS/ahO5H0HCpGXF
	al
X-Received: by 2002:a05:7300:7490:b0:2f2:1b3c:d832 with SMTP id 5a478bee46e88-30398191413mr10668173eec.5.1779218159820;
        Tue, 19 May 2026 12:15:59 -0700 (PDT)
X-Received: by 2002:a05:7300:7490:b0:2f2:1b3c:d832 with SMTP id 5a478bee46e88-30398191413mr10668153eec.5.1779218159328;
        Tue, 19 May 2026 12:15:59 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6adsm19282532eec.15.2026.05.19.12.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:15:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Amith A <amith.a@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
References: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: Add support for handling
 incumbent signal interference in 6 GHz
Message-Id: <177921815834.82778.2748075347158280924.b4-ty@oss.qualcomm.com>
Date: Tue, 19 May 2026 12:15:58 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: GiKSj2HMTGWSY7Bs89a7eIM0LJhBwVh-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5MSBTYWx0ZWRfX4+/JR7H7XlKI
 pQp4vU7NNQI3t5n8qX1Ayn+l8Z9G+HrdB7IaYNgkTCuqo4TDp5jN7NWO+B8S5nV6OSb8fq1kmyo
 zYnLkDxiWhZgZprHshLqJ6Ksio/VaHiJAiEsL2wwkyBOy9ddq3lxXddzQOlN0h9nchakIccUXh8
 HbaAMvZTYRnl1zop0+Gox5HCcCKdpGAh7SQFlHxyTf5LWQGBE47e7HgOlA9Xc9OTKSyrnbgZR58
 56AeQ4JXBLawepNXNbfFUW/kBcfpq/jVf1sho0WySP7SDA/gL0cZC0oXIoePucRFKonHx0TkpHA
 8mMl01bKpMFBaDAmRhlBK2puFwAB/tYefu3gTWuG7o4yOlsSrCigydTk8bxGN3VrYQw1u4nsoJd
 dHuZzzft2lhjkZ1jRHciOcU2WH5cQV3A0VFTPSQbaDXTBmWNGqS9dB+y06mhjDDzV3JDvlD7ESs
 YL8V7zEbKsRG0m1Bbkg==
X-Proofpoint-ORIG-GUID: GiKSj2HMTGWSY7Bs89a7eIM0LJhBwVh-
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0cb6f0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RB24T4HKk-RwX4x9OpgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190191
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
	TAGGED_FROM(0.00)[bounces-36667-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: E7B71584128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 11 May 2026 09:32:40 +0530, Amith A wrote:
> This patch series adds the implementation of handling of interferences
> due to incumbent signals in 6 GHz channels. When an interference is
> detected, the firmware indicates it to the host using the
> WMI_DCS_INTERFERENCE_EVENT.
> 
> The driver is expected to parse the new WMI event to retrieve the
> interference information, validate the interference detected channel and
> bitmap, and indicate the interference to mac80211, which then notifies
> this interference to the userspace.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz
      commit: e7f9be2c7bfff07b5aba1e6eac3452cd729ad214
[2/2] wifi: ath12k: Add debugfs support to simulate incumbent signal interference
      commit: afa1bd86eddd9f395bfa3d5cb3c7b5158e1383e0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


