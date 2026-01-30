Return-Path: <linux-wireless+bounces-31373-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMZ/OCDLfGnaOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31373-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:15:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70ABBEB2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC98C300D5C2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3AD1E98EF;
	Fri, 30 Jan 2026 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XEnPMAAh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OtUaZ61w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A922DEA7A
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786140; cv=none; b=Hrv/bN4Kks0DS/Q2JwTGw15U6n4AmSRnrmqKyVX9fZ8RNaFEy8zV1LGxkam4H71c7ccZb2SLlI9CAi/YVr6p4DCGYGhx6dCl83w41MeAhgoTzDEa2D2qyUoC5ob4KTLIsZH4SkPR9IZtKGch4Qvz6QGBPa0mdjjseo/hEL3nkVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786140; c=relaxed/simple;
	bh=xq8N5rkWJosi1QCZTkRqp4ARpm4m9Vn7+on7SBNNI9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y4azzyS0Pnq8Ya1eZwWDNjX2otNcEVnKeToTMCjbhNKC5kFDd7QRjY3xwrxv4H4UNm263br9Faaig+p54gxWRT+x+559U77sQPUe4OjsBYkFm91AV//a5Osu2yJ4EAN28/RNwxAFeIVx0i5Ux1P4+UX4ocBZL/VeDQMqEhtMW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XEnPMAAh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OtUaZ61w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UC56I21485285
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AvR+veMNXUN9kD5s1VOKjCZx6VF0YVbXKpl5oiQlJqU=; b=XEnPMAAhFkGB9oau
	aRnjV3x10vn2TpqZ7rJHykFaWXzSDf+1h6QZfeFSbVhZiVwbdAnr95f2NGlX9rpm
	8rUVMU+vFqYKyOK35fCBIwgu+dm+NWyoxuNEFbHfca14i9bXMS04Mabef8dD89sk
	4qYJ3f5d8Bf65KIIgUf5lAh5/HqBpxGr8Me0cDVBUfPIj3UhgyRUsFb98ZkdoXap
	sXr2Lk+T/APvmbFGIofq3JNMLFW7siUJnr+9gc0Y+zgENee2UsfRrVtsSLXaS3Ci
	TlZv7NJwUG5HWyrYIV+c4CnzYHdsRsPf/tyQknP4Se+BL3i0zcI8eD+4SwLKp/8m
	hEdMJg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0nsf9u6d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 15:15:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b7c12b62f8so1053284eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769786137; x=1770390937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvR+veMNXUN9kD5s1VOKjCZx6VF0YVbXKpl5oiQlJqU=;
        b=OtUaZ61wkQT7wT8UHAnFQ7MgHixC3VPzZMUpRkYqE7qpfG7HMCXWPA808VquAg9F1x
         CZ/QPxBrTTU+xKoO3Oa5ravPpozFnEzpGWy+ySh8AEOi5y31iMn07x7pGObqYI8U3LiA
         cdxFaNrfGSIK9jb7+E0tknUDRzCW2njSnYYFskE6A87B8+dF+lP3xr7saKp1ttDFUkZY
         /hDM4Oo433Xl1aVjxA54opD0VU28nyDDGWRSrY79SEof+dFUKO8SoReHgsR55g8s7Udt
         IcRe46kbBPdK++FFt9I8S5RtyYoO+cRdSccqPONQrVZ1zCMFTyJRprVxir/bFr2YjjQ1
         J1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786137; x=1770390937;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AvR+veMNXUN9kD5s1VOKjCZx6VF0YVbXKpl5oiQlJqU=;
        b=tzGoM9XX1HIOcS4WDAI6oDXq5T8fWBRor1cy6biHr2+6lGBsYnz3adyJNnLACmzqD3
         S4uLMZ2RMLmYWq/bAnPR2LNzKciNXSVAByF2twVDsqaY9Fb2i3f5WTMjVy6EVRbo3dmH
         1ZQoQI2Zd4M6UiHDuwgIL70taMUXrf3Qqd89rEXxYkXXuXESWcW7mHkCRYKLJFhC1kZa
         cybYuiRH/HswD+kAvWXJ8zLWyjbkwXXC0yYk+q0VraXMWauk+S82dYEJ8il+MVZt4PkZ
         G+Ejc6uvYArpaUOl8mJZnuTO6dvLVlPVHvQtAgGi+Rh1QqtswT3PvoN6ZH0BZhtgDc0Z
         0n3Q==
X-Gm-Message-State: AOJu0YyfqPGoKdWdW4K2ttxMdLRyKJQlcd0NcVTJ9f8noZuAwcudSS8U
	vrKcdyGaRIHM3+hwwyZ07eFoOshnP+cRPL7+YZ9MK9/pq/OHTKOmdluN3nDDmp8/t9H0wia8XUf
	DQWEzYgoRGamah3vB3MjRuMC3iQHSJSI8VvRMRitMezxC4lVA1wjjtb/aIYaEDPcpME4rJw==
X-Gm-Gg: AZuq6aLdcPEOUGniTmw7e9mM5rKUEJRrtPGmzO6b7o1+IDkC+8uIATSC7D5pU6I8sgf
	d2dQxzZJObKALWl1chAe51NAV/Br6cTA12lh4v+5sbq4XCrImaKrDmCFjMMtXNCF1ActF1CKLI5
	prmiSddyQCmM75lCj8p6OfuVmDls5+nynW7Qk3tsxLyU/lkgQjLaHfyviwru+MS3OfKhmCuGdx/
	RmZQTcnPlvLSWWlT6JJbmtn4nkeVNiWQ19raWQeFSiW4RSgrCZka8dUb/Bin7cRuARfHSUMu7Pk
	awKZSDTpY7Wf6Eg5hTL9iOsdEqSnoVVEMaCLQiCtmNWzOWPn6E/8GuwSxD5QMlVOb/OgLNu81To
	O9ezwPEzzdslTRRJjz4jyk6Sh+yEg076hX7oTCsTZiwaJQEWwvoQxRbvQVTv3+n/m
X-Received: by 2002:a05:7022:1285:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-125c19cd9fcmr1148391c88.12.1769786137205;
        Fri, 30 Jan 2026 07:15:37 -0800 (PST)
X-Received: by 2002:a05:7022:1285:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-125c19cd9fcmr1148376c88.12.1769786136559;
        Fri, 30 Jan 2026 07:15:36 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d7f95asm10252849c88.7.2026.01.30.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:15:36 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260123175611.767731-1-n7l8m4@u.northwestern.edu>
References: <20260123175611.767731-1-n7l8m4@u.northwestern.edu>
Subject: Re: [PATCH v2] wifi: ath10k: fix lock protection in
 ath10k_wmi_event_peer_sta_ps_state_chg()
Message-Id: <176978613592.3951544.9728416314683408699.b4-ty@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 07:15:35 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: nCuzhuG0X6E4G4IS3i1YJ_4W52Kp2ky-
X-Authority-Analysis: v=2.4 cv=EvjfbCcA c=1 sm=1 tr=0 ts=697ccb19 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=ng9WqdB7omV95QdvlpsA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: nCuzhuG0X6E4G4IS3i1YJ_4W52Kp2ky-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyNSBTYWx0ZWRfX/orCgRKNoR0s
 TUE2vwg0FsQhjRLF6vTEey1OEWuCNmANwCJ9uzdLKAq/MiyvYs5IZ/AeTyq2fTln1kSIn6fYoWR
 KDTbRf+8CFyJH67rq33awDudrPT3ukRnxT5mownnvllWbHwm7KjTtOBnGlQ3caMir9eXBiMUVjA
 rf8+us39gBkPaK54mb9KoeTIE68CwPR5Rlxh2lwivcmHl/s+Veb3Cwbu2O+yoOsvGmLuUJTAH5M
 C6Duv5zUC+uW9pBOv5rEtUgA3SPhreoVIfRVPym58RfXXk9B4lA8eeuqlTQd+t28s+Fxfn6tWBY
 qIFgQdoW5uBUwE158iKxXFXXFWu6FH6/XrV+yoMAlepDfssbACJ4eb5W9TcrgTakoGUc8ragvNQ
 O/byAWxy99gnNNKOLOtcT0GfNs91v+eOgW7C/6WfptmxcVklwPAGqrjhVPcokhud8F6jcPUSyt9
 hwZF/OsREgxJTGcnbtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300125
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31373-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8D70ABBEB2
X-Rspamd-Action: no action


On Fri, 23 Jan 2026 17:56:11 +0000, Ziyi Guo wrote:
> ath10k_wmi_event_peer_sta_ps_state_chg() uses lockdep_assert_held() to
> assert that ar->data_lock should be held by the caller, but neither
> ath10k_wmi_10_2_op_rx() nor ath10k_wmi_10_4_op_rx() acquire this lock
> before calling this function.
> 
> The field arsta->peer_ps_state is documented as protected by
> ar->data_lock in core.h, and other accessors (ath10k_peer_ps_state_disable,
> ath10k_dbg_sta_read_peer_ps_state) properly acquire this lock.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: fix lock protection in ath10k_wmi_event_peer_sta_ps_state_chg()
      commit: 820ba7dd6859ef8b1eaf6014897e7aa4756fc65d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


