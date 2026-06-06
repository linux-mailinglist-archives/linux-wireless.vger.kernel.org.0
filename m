Return-Path: <linux-wireless+bounces-37456-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DwMLDDlDJGpw4gEAu9opvQ
	(envelope-from <linux-wireless+bounces-37456-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:56:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFB64DE09
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Jun 2026 17:56:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=A1XR76rP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="SVoi8P/F";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37456-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37456-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 718AA302C788
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jun 2026 15:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6023B52EA;
	Sat,  6 Jun 2026 15:54:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE03B42D8
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jun 2026 15:54:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761254; cv=none; b=BsBjlibwrp+0PJ2P6gqQ5tXlhuhfL82wo6AqSX31jy92QqyfrNZvmvEVOf77yOz15s+SmIogiFAeFDzZUXwEQDlQc6ahFbiw1VcXxBShp+/jMVFq8CckrPMQcHBv1CZGl/KwL7VCUCPWyQbElFEv2VgmjZ1QLobFPka7E/wc3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761254; c=relaxed/simple;
	bh=NbF3rcEJemDw7Hi5yxDY1n8TSHJ+3bFZSSeE6IMy92k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BsgyCzqTDs9WQljup1NKQhm+wSUcv0WcmUmErwG9w91rILDV3MVh6LXWEe9liGgIVIEHS13yj2Fby3C5hzAV/aLcmyjogSgAESX+TglyE9JsgtHZD041MWs+lmmy073qIL4oCjlyWJVWfugKwi+wFgHIPMDbmjJ5JnJ5zCtUNcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A1XR76rP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SVoi8P/F; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656EupVA2123935
	for <linux-wireless@vger.kernel.org>; Sat, 6 Jun 2026 15:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GLC/RGjpD9LSi8N6tuMHAo+BGTstmtohgYKdPgdVVf8=; b=A1XR76rP2ZqVnlGG
	zHOUfcrNZEc7jB32V1BNqGIDQ5gy5fFazGJvzesA1BhtIvZznEUCmMnUZ97McviF
	YRUDoKBXcbGfEwo0NTiqEzw6KsaUiXbqc4q+X6LKy/IqPOEh5UBxcxMDYJjq4a0z
	VVQ9kgBaGTn1cLRiy492EHWoYJniiTLdhxLDHhNpi5m65eveCT74Rmgg4JNOlfet
	PLDJEdaCgxneff/qb6SE1IXz645uhYLlpHC5ZNActC6CPXMqfDIC/DA+tdqfqJM2
	njJ/MBvg1Z2oSodwcyKQtP/4lDjB6HQjXmDPziTHOpsZxPesAp6Ufwc0MUwBF/6S
	CgcaYw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf1ts6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 15:54:12 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30761ab3483so2834881eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jun 2026 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780761251; x=1781366051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLC/RGjpD9LSi8N6tuMHAo+BGTstmtohgYKdPgdVVf8=;
        b=SVoi8P/FL5kgb6vN6Ko9btvlLDjdlfOQZxFF0zh4VMtPCKtmOzro8uJn+QUVcjHpmZ
         Zn/E6EdZVgU3eqX6k7GBgsOw7aQzl0/WxEIcqBC3KtWroNjOx4ELzhlPBgPFKYKTn4m3
         syNTCvD4ZMIP6TVkcP24Porcmu8ag76Bm0hNY4EBE4v+4+celVq4me1YozxmReHeDpi+
         8K0umEjyVx74pBn+ypoopwgWbNBi0OxQn0SBVmjNLuSUAjz/e30BeZUOKDONKPcnaFbX
         TReq91xItZHVDUFuPMU4z50mY+vBPraXgNm8swPEN3Ptv5NkJVxgFJcSjCkyF0ydfpon
         PLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761251; x=1781366051;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLC/RGjpD9LSi8N6tuMHAo+BGTstmtohgYKdPgdVVf8=;
        b=XaPzZKztGpcYUS0Z/AM3+bf5x7Za2/+wllM8wFZUGuPAxdiptqhU7lB7Cd3PlJ2jKH
         7Iiuz3ZDhqdgSDJB4xk2lAYRt4TLbrpVVJjvjeKIcl4OeCkkLjCbiOLdtSM6tuSCjs9a
         UXBCEWvbU7Pb7I4X5sPkNK0EBY+R3aZbRHpWLVAL360EODk0pz3o8jjll9vtPKB/ub21
         BkbA8oG7OwQwgAbyosWEddSwmv4tttK67GJ9dpfGx3Pqwj0BjZZlAbKHS99LDDPKKrrn
         0n6awShFjh4uW6VFMatgLz7lTfVLF3PAFSme5I99k8lgnnrJpXIK9LYOlMaIsnT7+LB8
         Ongw==
X-Gm-Message-State: AOJu0YwlXUTFPZk0wStRpyDBHc0+a//PJlJ7QCseXfg6IDmQclTXIqBL
	scOzRv6HRflij7stLLN8MMAu4hBKiCPzpR4ePPtYctap0cJmMQh5C5nPCIEaTnLmP9ytQtcHWrd
	rxBPlAbU6RfpbJaI0FDpO/Cf0Eo4X+zxMtcCXQl8dPjc8DXrC1xpRhbsslOt4QvSQ1BehvshLWE
	SnoA==
X-Gm-Gg: Acq92OEjHVgeWiRgoFjQV1TFC0syL57AzslozuHI+nTk0gszLCxl31jHm0xCWfobYL3
	QnOQJ1hai6QV1pZcqDr4RRrhBgK2fjaHl6iX44N4I8w+4tdH9T5oHaCi+vo5kUuNezH/XDZD/0S
	ujaKTyq3AY1or2O4Z1B6i2TNXdg/gUOvUfKR3+9+baXG1ZCHpnGwEgQUt2ftzX1E8TvkY5uvRYi
	yVROFX3BU0bPqidjPLE7QZ/dZ59umRhX8TvjN4CuA+tzP67Ba2ZJWl7W9PumNlkHSsbFJZL3IoW
	9wtKprq6Jnjmh8YmBCcKfeVeDmzY946cnftjNGCqrbiXvkV0vyeZnT7jGgmD1zFblDT3vz5erB8
	kVeWK5+1bWRVi5ZJeti26wwIcKe0tlvaUUABsN5UojG40AJuNs3WuHHwFhjcneb+vZeZddDNFW4
	VENMfWuJdYbMc=
X-Received: by 2002:a05:693c:2d82:b0:304:8366:7456 with SMTP id 5a478bee46e88-3077b26df09mr4854987eec.3.1780761251347;
        Sat, 06 Jun 2026 08:54:11 -0700 (PDT)
X-Received: by 2002:a05:693c:2d82:b0:304:8366:7456 with SMTP id 5a478bee46e88-3077b26df09mr4854983eec.3.1780761250885;
        Sat, 06 Jun 2026 08:54:10 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df48671sm11240392eec.24.2026.06.06.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:54:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260521231806.261220-1-rosenp@gmail.com>
References: <20260521231806.261220-1-rosenp@gmail.com>
Subject: Re: [PATCH ath-next] wifi: ath9k: remove disabling of bands
Message-Id: <178076124633.768205.6941095450019063385.b4-ty@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 08:54:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a2442a4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=UBp2G-mp8icqrp4ZN0AA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: zGNPYt1JTh-Yq3hs3xY-axsJQokC9-Gy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDE2MyBTYWx0ZWRfXzV+042O9FZ77
 AnHf69Y6BeA2YZRd/BF++Egn/tqVun0+OYOZjvwsbITtevX6zYTKZFBx+F8yOoR85FCL4fcOaBF
 e+FieYsnJ5RIXLB12KyMCWCzEMMpRSI5X+otreppDvoLRa5P5sr4PHOCyHPUnuXTmK11q4WjWRC
 C6iTR20cPXA5+sUrLQaLjaPNElUsWHatA8BbuZlmrpZMdKfS/Dj3UE67kAeRKJNnDHMuAw6lZfS
 +Wf/cGCMZtR1dK1goA4jRrNxns/AsquogR7LpsE1MI+ejR4TVwvW5sC0khi1Wdlun54tEQ+eXoG
 Pw4I/8ggiiIyQXkn3ihE2w9U3PV5erDElv4gNnkXBF+YUj6CotQgToGj/4ycD0c75SKAiQc6Bg0
 hHZw8CoPF9RdeYn61Af4b1WfBUk8HGqCPPgXLu/EF+P4JYLHQacFXS6h2Hec+wuRnClTXTY+sRj
 inu0m17RdMAk29NcL0A==
X-Proofpoint-GUID: zGNPYt1JTh-Yq3hs3xY-axsJQokC9-Gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37456-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:rosenp@gmail.com,m:toke@toke.dk,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4AFB64DE09


On Thu, 21 May 2026 16:18:06 -0700, Rosen Penev wrote:
> The old platform data code that used this is gone and this serves no
> purpose.
> 
> The modern way to disable bands is ieee80211-freq-limit, which is
> already implemented.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: remove disabling of bands
      commit: f0e5e8703fd61dacaa0c18016146e64cf32ddcb7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


