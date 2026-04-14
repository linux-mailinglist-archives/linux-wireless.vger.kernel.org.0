Return-Path: <linux-wireless+bounces-34734-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBAjM6vi3WnrkgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34734-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:46:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD553F6330
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A60553013A5F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 06:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B183736EAB9;
	Tue, 14 Apr 2026 06:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mpVvfKuh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gBZO+ndt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD336E483
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149002; cv=none; b=guqawvodZPaSV0sUsVbFvZGHnNi9Ba7s4J+9RUcIv/g1XKzCLkYHTwZelxvLQfIjByHCymb1ViyeOhnJiUsJD+Y5AOokC8pG1B9zllztz6WXVlT1nj47OqyY7byg3RlDb8oFd9hE25W/8PiLyUfK3aL17hezHqy3MGZ7bKesZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149002; c=relaxed/simple;
	bh=qGYM0IN/IE6gIXEcNZAdzWaCFRZ9g7FY1bYZKtfP26w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adYtz2uqh7A83kClHc8WHfwGojuIYnwmrJCs1Q9/vgLx39jqRj2IJniexSYAInY0rJ6Ow2qtrcnd36gk7s+1fdIEmFZt4hPyIieFzhnvsNFAQ59fM4r/XqFifJzVQFaunHFuSXM3FgYhdFnQNExXXvQbcIh7PYtVvYFWgDs6vnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mpVvfKuh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gBZO+ndt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E6Rp4X2509956
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ooS24x9VLICMx3FC4zHZJS9uTNKsD8j0SzaYRsjwM84=; b=mpVvfKuhiMoV1xr+
	gyS2yoqIG5S8QlXYoSHSQPuKMSieUydQ3HMx6rZe3j86+4wxHNKjK7MYGkr2VuKg
	JImjLBEVO2vdJP3WlvOhp+QLQcJmegAyBasWFUsCnoupY/xSBr6YSGnRKba9QwSM
	AMra+lGsYunteNB3/SeN+g9PseX2u79cV1ZcXq79zLfTbBrQL3it6rKqbTwUzPUD
	nC71v7qzg1rBg9B+ZxOK9vqFRTQ1m+VDQXHXt/T2NMq3mzLkkDLkWAxTkEEg97wG
	eHi41YrOcBZBj6ZDXX52fwwFUhfihnO7XHl7gcRrl7kUuW6B6Vj3qTBqLOHI51wG
	ULqnSg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh867scgq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 06:43:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76b69fb9d6so3108509a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776148998; x=1776753798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ooS24x9VLICMx3FC4zHZJS9uTNKsD8j0SzaYRsjwM84=;
        b=gBZO+ndtUgIab1shgPCi0DlY/gzJLz/ikA0V/ih6zT8W8f2recxHaLh1wKry32u5FK
         4Am9vGEGJLSL7JCbUuzOWW6AhNppT/s2z9jklIROVmGC8ysOBCB38Oj7VGrc7LU9yIYY
         SKvNX8ZTZwgRJTR6LaD97YFLcjNYB18q3o9ULei5QM4Z3x2Bs9bQGkVTRBwG8tTXObEA
         gVu3d8K6VBp+Qd1ocTXXiRYlZkKhSpKFsNdgdJUt9Qc3n0RWagjiUn75IOJO0IUBsHnm
         CrZ48+MGw+KVcmaW4dft9hZD9P61M+OOKAmmnGo4EeZZrPBmKuIcvgFhkMfe1jEfZApf
         0dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148998; x=1776753798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooS24x9VLICMx3FC4zHZJS9uTNKsD8j0SzaYRsjwM84=;
        b=JJAfpO9z8FDVlNThqMTLp+ReUDumUW3Wg9D4P5a8V+6jV6SanulIuy9b17zOihSom2
         DfoATingfzU6qu4NWuALR1lMG8go5DlM+VrGVr8RNTC6K1C5AywLCMPnEaTjt98aDx/L
         7JlH0hKT+bBOUw+NP6xmOMRiuUisb6cGK3NjYuFFoQIuVA/cSvZOTCseCHgp0AxkqDP2
         CqZC4hJl0bwOETTWondHKS+YIKLlzpS9pc3OLDREZPpcbHagaRrRwzFnWarq5PFQd+sf
         RGygiiDJFpJta+lFdnMCESh/+zkcIKs0LZaqX9l+/339SkZwvz9NWj7VXXGJu4Q1Bno0
         8BYg==
X-Forwarded-Encrypted: i=1; AFNElJ/DbRzybOTEeqJ7dhUlU9DFLICyzjaxlBXoKNT9ipvYxHoMdyArEx/Cfw4sscaorsEm4IeZhosRzQcQRQ5gfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUgxbgoE0857c2/C47t5mBcicKY3cnUZhwY8r4khYw8/yK2vi
	/EPk8nQuwWmQCwJK2HT6iHIazTJrrS4I3kAULkaMP9s1Ei5ZQj0MK6Ndd+kdCqtvDOOlfwauZYy
	04udXIdycrH+My1FXTy8zs00LEMmOKjPvY4JMtHlG3MMierfotPvWusqxqnUqy5C+URICEQ==
X-Gm-Gg: AeBDieuRYBfGr5JuC/wd+Feql3vev4epdP9UpG+6VQ/g3EpN/2dXSzEUxswwPoBqwLh
	JXSZgjjFFDxXcj31aZM+x5pbkRoiDZlA/fBimnNge6kd9hVtWhjyXmQUsRprdtAy89lPzeFeSHg
	NXVDnqalY30YufEqPdkuvS99Wg/L9ckNw+lZRPl1nrF2FD6BuH7zvREkvEbfcr+fmbo2aNR1khC
	DtB1R9FcpGSXuMegiSfOD4S0pPr04SLBxxj80SF7yFj5X589O1WZsRJk4PsjkwGtSbIuECltx9+
	d2NuWfTD+iBbfJNhKTONuY5kgyIXMJJD3RCIOmhVbRqAu9sDZCY1Xa6M8U40zeDItXXcF8WjXMB
	mi/tRaUmhPyftefj18++kp4+1wRpv6wzYAJUJgSZSVr/sK1D8WGoBZZ02R8yV1uN4QVQ4UNyCgN
	ZJZM7sKiqcf0BohHvzPUezTchZHtdiXQ==
X-Received: by 2002:a05:6a21:328e:b0:39b:897c:6f84 with SMTP id adf61e73a8af0-39fe440ebb3mr15043052637.2.1776148998330;
        Mon, 13 Apr 2026 23:43:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:328e:b0:39b:897c:6f84 with SMTP id adf61e73a8af0-39fe440ebb3mr15043028637.2.1776148997793;
        Mon, 13 Apr 2026 23:43:17 -0700 (PDT)
Received: from [10.133.33.118] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a1d0d2sm10359483a12.27.2026.04.13.23.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 23:43:17 -0700 (PDT)
Message-ID: <ba4d194b-6d31-4d8a-a6a6-da116f9f56ac@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 14:43:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: Kyle Farnung <kfarnung@gmail.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330-p14s-pm-quirk-v2-1-ef18ce07996b@gmail.com>
 <082b3d13-6fb1-4041-a187-fddec3b013e4@oss.qualcomm.com>
 <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAOPSVF0VHR4BQsmfWFeFnANsQYBw-x7fHxH2JFNO=oWjgeS66Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Apratvo7MAwCg6VwGhqsePCIdhByGt1p
X-Proofpoint-GUID: Apratvo7MAwCg6VwGhqsePCIdhByGt1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA2MSBTYWx0ZWRfX6FbnwyDgGjZq
 rPTJlAgq7pQSQTixuBxO+yf3gUTixIQ7+xg//fzej6VVKIruVFPGXfwaFk8S3+hJ+bB5ulT8YBj
 jNkUIVWaS1OUaxU+0BI+60zMT9swYiweFa58PmIhlNZN8obxp7Uh6KVA70wPi6MIwaqnYMThIOC
 WMqRM2MVMdPHsPh3kSC5NPjwvGTi27+LHG2IGzF2F3gwkTTsz/eH4Yc3lsouRFU8m2iHbj0Zk6h
 JkBDHu5nG7z1fitDeEd4+Bu+zBaYxfFNSGc1voN9hkBiMfTCgN5ytcztX/C5SypCeoXSei76tkv
 d14ag7zS/evYolQFpDWFW9QrqbmeEsiZ0LZBUxF98fR8lZIPoqlh2l8J5TfefIBV3mfiDFq7yP9
 4g3lMLzscgGLw8dvt8wwfvN6ajX2Ez/kKWvsKumUCuUy4S+fp9zfVeuWOb6D9rbWslRVrwFLdpZ
 lIe8dguG0pTd+JU2Ybw==
X-Authority-Analysis: v=2.4 cv=etzvCIpX c=1 sm=1 tr=0 ts=69dde207 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=8k6WQxmsAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=4Wa1Ze30II_mXCYJOSIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140061
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-34734-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,lenovo.com:url,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8FD553F6330
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/2026 11:48 AM, Kyle Farnung wrote:
> On Tue, Mar 31, 2026 at 7:08 PM Baochen Qiang
> <baochen.qiang@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 3/31/2026 2:32 PM, Kyle Farnung via B4 Relay wrote:
>>> From: Kyle Farnung <kfarnung@gmail.com>
>>>
>>> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
>>> reliability issues similar to those reported in [1]. These platforms
>>
>> how similar it is? can you describe the issue in details?
> 
> The issue is that intermittently after suspend my WiFi adapter connects
> successfully for a few minutes and then drops. It will then keep trying to
> reconnect in a loop but never succeed. A reboot will fix it, but eventually
> I found that reloading the module also resolves the issue
> (modprobe -r ath11k_pci && modprobe ath11k_pci). Based on some searching, I
> did try adding "ath11k_pci.disable_idle_ps=1" to my kernel arguments. At
> first it looked like maybe it worked, but then I hit the same problem
> again. At that point I decided to try building a custom module with the
> ATH11K_PM_WOW override and so far I'm two days and 10 suspends in without
> issue.
> 
> Looking through kernel logs, the issue appears to have started with kernel
> version 6.17.4. It looks like my Fedora install jumped from 6.16.10 to
> 6.17.4 on October 22, 2025 and I started seeing the issue two days later.
> 
> Here are the logs from the most recent occurrence (filtered for brevity):
> 
> Mar 29 15:26:24 kjfp14sg5 kernel: PM: suspend exit
> Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: chip_id
> 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
> Mar 29 15:26:24 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: fw_version
> 0x11088c35 fw_build_timestamp 2024-04-17 08:34 fw_build_id
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=US
> Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=US
> Mar 29 15:26:30 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=US
> Mar 29 15:26:35 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-CONNECTED - Connection to 68:d7:9a:2a:94:f8 completed [id=0
> id_str=]
> Mar 29 15:26:49 kjfp14sg5 wpa_supplicant[2373]: wlp2s0: CTRL-EVENT-BEACON-LOSS

this is the reason to your disconnection

> Mar 29 15:26:55 kjfp14sg5 kernel: ath11k_pci 0000:02:00.0: failed to
> flush transmit queue, data pkts pending 9
> Mar 29 15:26:55 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=68:d7:9a:2a:94:f8 reason=4
> locally_generated=1
> Mar 29 15:27:00 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=80:2a:a8:98:26:3e reason=6
> Mar 29 15:27:05 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=74:ac:b9:df:54:36 reason=6
> Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-DISCONNECTED bssid=68:d7:9a:2a:94:f8 reason=2
> Mar 29 15:27:09 kjfp14sg5 wpa_supplicant[2373]: wlp2s0:
> CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Batman" auth_failures=1
> duration=10 reason=CONN_FAILED

and the bssid is disabled so association to this AP won't happen in a period.

Anyway, although it works, using the PM quirk seems not the right fix. As you mentioned it
seems like a regression starting to show in 6.17.4, can you do regression test to locate
the issue commit?

> 
>>
>>> were not previously included in the ath11k PM quirk table.
>>>
>>> Add DMI matches for product IDs 21ME and 21MF to apply the existing
>>> ATH11K_PM_WOW override, improving suspend/resume behavior on these
>>> systems.
>>>
>>> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
>>> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thinkpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
>>>
>>> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine model")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Fix missing mailing list recipients (linux-wireless, ath11k, linux-kernel)
>>> - Link to v1: https://lore.kernel.org/r/20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com
>>> ---
>>>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c93d9ef692d127fe 100644
>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>>>                       DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
>>>               },
>>>       },
>>> +     {
>>> +             .driver_data = (void *)ATH11K_PM_WOW,
>>> +             .matches = { /* P14s G5 AMD #1 */
>>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
>>> +             },
>>> +     },
>>> +     {
>>> +             .driver_data = (void *)ATH11K_PM_WOW,
>>> +             .matches = { /* P14s G5 AMD #2 */
>>> +                     DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
>>> +             },
>>> +     },
>>>       {}
>>>  };
>>>
>>>
>>> ---
>>> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
>>> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
>>>
>>> Best regards,
>>


