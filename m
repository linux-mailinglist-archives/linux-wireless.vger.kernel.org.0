Return-Path: <linux-wireless+bounces-32658-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL3gGcpEq2nJbgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32658-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF88A227E12
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 22:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47C39302C37C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 21:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC829D273;
	Fri,  6 Mar 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N50iH4yX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kTvLxrcW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DD33A9CB
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831940; cv=none; b=T+CCPlHMsVF+rm1crSdwCO00W0K/qWdI8PrEZwCtcJQDlD5CfMrgTTEj5A/HcgPsa3M90R5X8PtCJRW9YW7GuBGttCv5ttuITd2t5xwmX9k/vT22QYU4G8RXICIjpAMKDX5CQp9elEAev3VQ+GajPOdtSY5Dd2NwfgoRhpSi2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831940; c=relaxed/simple;
	bh=nMSWWDUzCgXNBpyC7l/iLsnHg4WIn82nPX1C2GXZAnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sY34fR3eNjkDzeSwmIp1iB07ZnAsAKMj70Xyi2EDSyOD4IL0WbxwXkODHmPjpWUz51/d1fwOfwK1cp0QgPJ10za3AmdZ95IP16nsR+hVrIDAgyBIkGseryG5RhEiEWuf92rJ2Io6kNw/meoBRvcSfSwOeGz3oLoKfL8M2sVJugY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N50iH4yX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kTvLxrcW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626KWpS2699678
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 21:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2GcTdIxIpJDK9NTAz8XntgZ8/jzN3x4gZvAopkBgHn4=; b=N50iH4yX6NCIPjmf
	QysHhXJPLtFDxXmwL0OM8QBXyn7ACGiUC/1V0cDfwDNEW4jFVuCxey6FaPJZH+Zo
	9W3sfpy+QFJKmHSrjW51vbLZT59stEU8pIODZ2seniFm/f3LTHfyZBj0/W+yby9o
	vEKuGEDmKkY+OwgcHd/aaYCXYGBpu7uuwHaRC5imFIur+O3NArHRRWATlUyBiFPW
	pYndcou9PzQWA5hUve36LOhejyHoY/SEpNCRmfEOGJ+T6ZUQrm1RTAxcGPw+Nagn
	Md8KcfAVnelU4ivM9OaubTRXxyOYCdTJQ5EIz2nCCoUKpc275L23Yse+zAeWilsR
	dG4nNw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqv98j73e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 21:18:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2be232ef3d3so6022521eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 13:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772831936; x=1773436736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GcTdIxIpJDK9NTAz8XntgZ8/jzN3x4gZvAopkBgHn4=;
        b=kTvLxrcWUCMtz1jj3OxXcDQpOCStZozwOKW1M6d7pG5yNfDGtDjrBROm4uThd6gMwG
         zZ++OQOwEoBYgXYwDgZ3XhaGNFNY/7XPTAAK7koU+4fZxAyFKLAsuI8XXXYzv2iaBKza
         msaliCGKjW3CUZj7Hs8u0QM4BIeQzROPaeeCSFfPneCe0Q3TgxfCfWX/v2RmBFg6Xnh7
         3XC3VgkW1g8Y1CFVeC5KCaaJi50Xhe6oKiKGuC1YQu+qrLxyWRERkNkZhUmBCXHE9zek
         9AU3myDQzmnUBfGVeHQYOxFlAmTPXVTwHqhjCbOMheJHkKbJMNp4LlttytrMBN80UFv+
         VE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772831936; x=1773436736;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2GcTdIxIpJDK9NTAz8XntgZ8/jzN3x4gZvAopkBgHn4=;
        b=KqpwKYvpcUe1U1+LRXhQ1hKNo27CT5VI4fZEqgJqPlG3Fr/IN+16i0yTU9zZBHOiVS
         3IlvJvVUOFkKANLjjTJMGyuuW7duJmBdAh7p3sfKewwdzFQOU03mBd4SK3KZcokjQH5v
         KlEnr/D+UcThneUgm0XniA8MPBncNNf+MmwVIgyI0HHowXRjQiMlhDMjg3I/bAB2M6Uj
         aF5tLJ+KQFXBym+Yt+wL86PNZrSJBXtRmMYGSPA7BsnHgOpu0cuL98F521cTVsWZMAk5
         Exaiq34mok+/i+NHHsVUPCybilUnv0+0UQ/hfndrGKtPN5LFNIjG7z+C16hDMdeCj7/x
         MS+w==
X-Gm-Message-State: AOJu0Yzh3oz5XCpqvTlAJnPgHq2yZnVqT6ioSFaTTdjd/2ynbGdeE7gc
	/6E3/xhcH5fx3R7hgSpOVtElK08RE3bubrA3OV9nj385kRIAY4SrNpUq/FxYfSaZKRjpMibeFdd
	IOG3WrteJjJI3O8nqipqtFbYPFbjb/FTt2p36PPg8C+1RoLBmOHNqMgeJ6KRqYk940YSijg==
X-Gm-Gg: ATEYQzwfM+pudUFWF2h+IA3XPzP3qPvxbf1NrZ0JOX1wZoEYWQ3Hg8YcrNwYoEi7pQD
	lKamNg9OD9u3j0Ui9fLMycGNBGGKBFxecBg2/pnv3j7X4nytX0vPlatTS5KDAE+cb6f3+xRqpLG
	VgwzU4lT9Y+TfxufIfjQNCBG2KkSrtrFIG5DKRARMHIbY0dGlHdaFGknhQl9oNGbpuoATNBZFvy
	/eKhT6pAw5BopAOGOk3oHlsLxThTzCdsAXjJV4cb8HJTmuYkxKBvG2n2G/Mj3kc9Z4f+EiyqIfp
	tYqdEbx4NAnNOV468Fw0dyES1uuEcQHJg0brXba8Fny/cn690ghe8Kb5rUVhMtBD2Iw+iIwcivx
	31GUDrXvY/YNJ5Z2YbPAOUm+g0bNcgOAk8tYz0JAg5cUhdB7OVCArXwJnw/Bf7yCQ1mtiP+1ZXo
	7e
X-Received: by 2002:a05:7300:818c:b0:2be:22b0:8be7 with SMTP id 5a478bee46e88-2be4e08b14emr1610772eec.35.1772831935966;
        Fri, 06 Mar 2026 13:18:55 -0800 (PST)
X-Received: by 2002:a05:7300:818c:b0:2be:22b0:8be7 with SMTP id 5a478bee46e88-2be4e08b14emr1610763eec.35.1772831935421;
        Fri, 06 Mar 2026 13:18:55 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm2325124eec.17.2026.03.06.13.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 13:18:54 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <sarika.sharma@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260226051947.1379716-1-sarika.sharma@oss.qualcomm.com>
References: <20260226051947.1379716-1-sarika.sharma@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: account TX stats only when
 ACK/BA status is present
Message-Id: <177283193475.1373939.16510537269470657650.b4-ty@oss.qualcomm.com>
Date: Fri, 06 Mar 2026 13:18:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ir0lDSm8UG8PlsaATWFfMrBq2n2AQ7p_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE5OSBTYWx0ZWRfXxf7Fcl2YwD7a
 buDnvLZote44Jo9WM+E3E2N/93IrIebHK0Ot4/nOvcFexyPe6bFcmHfmADbjxuR139fKYdLlnbQ
 aYgWze1BGtVsW9FMDEAVNfP/K8TbnHFjPYjY0UkiexAzi6d6R/Xl7n/ZQuGpMVy9YIcYM4IkSCB
 zMFVKJk70pMhyhf2yC/sUVgYjVhRyX8zlXuwvcxJT6EWQu2mC0byvgxNnQRa0ZLSl20d1ZV2Pyq
 v7fnATXT+aLkJQfEsI7yDFfqTNR8WCa0ialIu4V6sBiRdD8v5n4zebNZK8rhbhWvHV6j1WHKyrq
 JFgc3AUv+iLVTYum88PMKpOAy+OtwCwx+JKHzrek2SchV/XjuM4f+Z/+2E6tNovl2WvmyKImYyR
 y4yyIVdRz0QyLQUUIeNREQYlGrM+9mG7TKBzCvIaUwyHKSEeuooQYH0kNAkAYGDNcNEdCdWgEAB
 UwfJnCGeYngCP4t01Dw==
X-Authority-Analysis: v=2.4 cv=LbcxKzfi c=1 sm=1 tr=0 ts=69ab44c1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=oadX85OKd24toRC9XggA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: ir0lDSm8UG8PlsaATWFfMrBq2n2AQ7p_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060199
X-Rspamd-Queue-Id: BF88A227E12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32658-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 10:49:47 +0530, Sarika Sharma wrote:
> The fields tx_retry_failed, tx_retry_count, and tx_duration are
> currently updated outside the HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS
> flag check. In certain scenarios, firmware delivers multiple PPDU
> statistics for the same PPDU, first without BA/ACK information, and
> later with BA/ACK status once it becomes available. As the same PPDU
> is processed again, these counters are updated a second time,
> resulting in duplicate TX statistics.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: account TX stats only when ACK/BA status is present
      commit: 1635ecc61a24597f893d057d004051a535c1c643

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


