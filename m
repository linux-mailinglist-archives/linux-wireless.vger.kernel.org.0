Return-Path: <linux-wireless+bounces-35920-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGNoKSAP+mntIgMAu9opvQ
	(envelope-from <linux-wireless+bounces-35920-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 17:39:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 084A24D0527
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A5D301326D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432A361DCB;
	Tue,  5 May 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pRpd7f55";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMRCRQMa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF1156C6A
	for <linux-wireless@vger.kernel.org>; Tue,  5 May 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995503; cv=none; b=Z3WHiCRgGUYvI8L00H6UkYeyVoqHHLfA3WZTxUCHydTFXQcj95lEtUHdKg14epY+uNm+LmlGztK5qACETQx6tUneDg8c4dG2mkxQZF7QCh+6cDJCrn/ilG6Y6/Lmam0X2EzmElFXackM6JQjl4/UM75kcJwPpRLRcPSf/0H4afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995503; c=relaxed/simple;
	bh=y9J/KcTUfJ7bMOgP3SThH8ASCFbJdR4x59AS9uJCIHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJZrjAG0ZdPBdCGJMFSqKT2R7shg1nWL0wu7ZLuGxfMaW4VVN2LGV30KrqsR0z+KB7ydrg1prDhxzN64Gdojch4Nrn1xazqsa+N6tjeVHnhrZ+If7vsbH/9IAeEtByWtJq1AUwzBy7grd+jN1D1Vz3WTY1SjBvvM4mne9FMaPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pRpd7f55; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMRCRQMa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Djjrd3501672
	for <linux-wireless@vger.kernel.org>; Tue, 5 May 2026 15:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1rLBcVog39kWLCR+ZxmwRRD77wBGRu+MM0wrGw6qajs=; b=pRpd7f55OeqWMiHA
	robXspV00wdcYzB8AwEydLhJsoGZkVEYmduV4+VI/wI9Gbw7df59nOPLfuHiiWzU
	D/JZr85rfKISovSqTYsZsu8gPtac3qYKD2Ml9RT9/d4lm+V/ktEdLNIF0Dr+p0vZ
	T/7jBKIh9kuLglikAwqU3v8VyhyuSjWV5KCFbp1IJ7D6lIFACP/oXRrAqgEI0Edn
	9HItk/BX6IUFm2pg8y0Z9gMR/SsMqaVB9jFdFmDWuMzggl929UUdbxjuiXeqlQNb
	62YNQzLLSgmYK10p1LrJUieNc7ckorPZsbwc2km0ZCXQpDkNMuZ0fhhHuBjlc64q
	7pcw4g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqf8fax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 15:38:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so3998298eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777995500; x=1778600300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rLBcVog39kWLCR+ZxmwRRD77wBGRu+MM0wrGw6qajs=;
        b=kMRCRQMaQJoAfoRhJC2ObSBU668YU+aCPBRRRBQUuT0TgiNTMMtMlS8v1d8J3CPGM/
         NEpb5jlJJR1+77FSoPZW6kVHL6m5xHaDZqqlCydOb+2/4urbqCpJYjX8Q30yz+KSTO+r
         qErzER4kGfq3w7rXxpAGfpx6YoWVoW1t7mIzlVDKjEqnYf3xQYIcv2+oLu8W0u4ruKNj
         K4eiHrfKa7oJjn5XPbbphZTcXrEYsSnq50tgfowWEHvZbLIreqZCqL8y4DCUSqhhLBDY
         rIjdNMB7ZnvPBup+9+pLfCWpJK+xthn2DLwO1F+xfymgSDhbmTJdTMfKSNbrHXpJBvrZ
         onUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995500; x=1778600300;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rLBcVog39kWLCR+ZxmwRRD77wBGRu+MM0wrGw6qajs=;
        b=adZAUkB7tIowRL5Cx1w3IyuEPHAog8UYBsRyh9E5OiqofHlKs+qO3vgepzH4k2voQo
         1WpTS3mphrVg/rPeWua0NqYP/GnzYgklAcosqN9AEsR2ibVvCZRFrdlExqVVwDVY43vA
         49w+9I6KRVsnzGtz7uGPdVLHKk3XiMs3K3cGrade1drA4TpD7hnMs0pb0pl+ytEINRKA
         OcUojARp2CGpcDkcVM1b6Yh/qkuiE4+JSzGibukYC9Z7s9qRKw9r491wnHMWTme5Jl1+
         mxPvYZtH6OjBulmMK6iOX9PDRoU/JE00TlNYnq5XavvRs00kotC8bUSzg9IFVqTRsy6f
         76fg==
X-Gm-Message-State: AOJu0YwxDZWK/VcpU5I74vwVleFrmwrk6a47A1rWH6HLJVnbw3NtY/wS
	sz6iKJVNMEUQlY5bZb/4R6P+k5ZuLKkUFtkRIMlKLR58JK24R/3daWW4M81Uvm0ZixW031Os3Zj
	s352wzam3QNYcjbcFtC7BoY21Ai7WsIf/7e+RSR33b2GXtCCYkZPQZvB0awn5GiTI9w1A+Q==
X-Gm-Gg: AeBDiet15+Jnb+yuJ5fJanZx/ZoIwSRtDbjhxs1/fWQBC+X+fUDwMfvc3qC97bn+0vQ
	2ZxDDQ0/HYZdEOtOXL9AJ/XYjQKUIlJg18hhPJjawy3TtHcfkZMhXqAkEie/zPpok1muZk0d3rZ
	rMVrLjo50AsuoV8qz9t+/1nNbph/4L62zKXtuOzPwwbJJs42rOX/xQYryC2GrOPoXw404Yt5Cvi
	3yj55aQwNLDZjHIDKm79YZsddfNQwF4/fDYYSdvTcTFX8saNXc0nmoqigJS9IlSRoEo3KY1GCyV
	FtyKRzlSg4d+m++cwijxJapcZ32a2a0s8BM/E1KkAirp0Y45ijpvQiy4GeHfclO3rg5y2o5aEli
	iGmlhxp06UqVU+olwRAJtX9qS4iZewq7xk1R6aM95YjYM1WAeZ6ZAu5THXD/giQNR7yDkt1WF8I
	JxW4ruH4carnf0SSuI
X-Received: by 2002:a05:7300:324c:b0:2e5:8ec2:82c9 with SMTP id 5a478bee46e88-2f409ab8996mr1901185eec.26.1777995500385;
        Tue, 05 May 2026 08:38:20 -0700 (PDT)
X-Received: by 2002:a05:7300:324c:b0:2e5:8ec2:82c9 with SMTP id 5a478bee46e88-2f409ab8996mr1901151eec.26.1777995499652;
        Tue, 05 May 2026 08:38:19 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71cedsm24932550eec.9.2026.05.05.08.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 08:38:19 -0700 (PDT)
Message-ID: <74ea0491-38c6-4d7b-8250-b18dd744c130@oss.qualcomm.com>
Date: Tue, 5 May 2026 08:38:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix incorrect HT/VHT/HE/EHT MCS
 reporting in monitor mode
To: kwan1996 <laicheehou9@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260505040920.57521-1-laicheehou9@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260505040920.57521-1-laicheehou9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0OSBTYWx0ZWRfX+ZiztdcWLmGo
 YJGiEeAuH7gu6SVYIjjWNKADQ2f9gLImK4FhUlJBJjYvBhSqlxjT9Fysk5K9eZI0Hvf+jqHeViv
 kwdMAM2JxQGHCFxIq+O/NTn2iX30P6k9ybPjFa8mkFOgYF/32TgYIvCAEedF9ZPOCkAIzPvze/m
 EEYZHwscZTUl7kKGIVAKlmMTVgjtg8pnFZM4GLmqDCDRD3LQ+UsZZ3RJcefUwUt9UgAGKk1EMPg
 bqu6W7IadXKYs2lqMhFz6Ncfx+FI/pSZ9gtei00mD4l/AXKT1g1Dq15zKAwCxYatx9onqsWIGN+
 LkKdiEQ0Fa+q19AyTw5Pu7SWKkgqBFaxaKjxpT8SLZpLvCyVYnQ+X0JJTVqKFlV2dbfJc72+fbl
 CvJYInFk1WFl0BisQ7gVNe5fsDr4tRJzNcy6MVuqDieZq3u0qdc6C6nobZfWl5rhGPLDitBGlIu
 VbE7Qys4wtwIVAi3GSw==
X-Proofpoint-ORIG-GUID: VIWYKhrAf8MIjiqgeHIWmoYTO1al-amn
X-Proofpoint-GUID: VIWYKhrAf8MIjiqgeHIWmoYTO1al-amn
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fa0eed cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yOxJTiXU-Wkyv2yLSC4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050149
X-Rspamd-Queue-Id: 084A24D0527
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35920-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/4/2026 9:09 PM, kwan1996 wrote:
> In monitor mode, the driver incorrectly assigns the legacy rate
> to the rate_idx field of the radiotap header for HT/VHT/HE/EHT
> frames, ignoring the actual MCS value parsed from the hardware.
> 
> This causes packet analyzers (like Wireshark) to display incorrect
> MCS values (e.g., legacy base rates instead of the true MCS).
> 
> Fix this by assigning ppdu_info->mcs instead of ppdu_info->rate
> for HT/VHT/HE/EHT frame types in ath12k_dp_mon_fill_rx_rate()
> and ath12k_dp_mon_update_radiotap().
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220864
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ
> 
> Signed-off-by: kwan1996 <laicheehou9@gmail.com>

Is this your "known identity" as required by:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

/jeff

