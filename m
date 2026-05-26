Return-Path: <linux-wireless+bounces-36894-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CuYBsP9FGqESAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36894-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 03:56:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6924E5CF96E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 03:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCBD73002B7A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 01:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF72765E2;
	Tue, 26 May 2026 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GuwtwK6g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="celCc1FX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40302C0323
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760274; cv=none; b=lrLBXS3/0BSr3ycAdCQOZ8XhsdOarkFjQok2KWDEsmKi+84y0qdABmUfAf5borQXh77C9xXbybgauRMuyTD50L33ZpzOTqHe58cxFqPceQ9iVoy7zTGhHTnNAYoM/ALvtFz0Sszf2Whnm5mrNTxmNGrGY7vJGIwt8f7kHpZIw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760274; c=relaxed/simple;
	bh=g9Q0ucxTWfgCUtGuOCXL3s3fKB5kNfiRMHpHAky2zJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q3iP3+vIEuax0Jw8MBOzyMh/qnjj3jsBYr1lwR3wjKqFB1zoDUpBofxfI6HsViqDVezRtAJ9wafh0I0AJKo+x/aNqxZAbBwO0/ym0uJgQKhlFUA/rqBIlpqqj+/gIG7t/5Z8YffZFd+CRheZZDFX7NoWyef/fA+qtAcs+gWR8mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GuwtwK6g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=celCc1FX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PD3S1p3603922
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 01:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Fh0xI/akadKdHGqjpzwLwoqTYEfvzgu7R3F3IHIVXQ=; b=GuwtwK6gC7qBfHLb
	XAqsYWOGewW89Ywik3IDaQ6XxyiuJacK2Wu0w/+N7rsiBQ+U2gLXXThuQqmqJWKG
	CeW24pBzi6UNW7mUX+bNV7+ekXg9HjkJguhYbIQ8e6bJX8nG9ex4KyBc/G1taiky
	QPQI/Oqg5pgfSo5IN7YEG1ivcp6EGiSsMAi9b6csPfwSpBkEZm9mWnc7HXHfH4zD
	42XSh2STcvD0a4bLo+Ls8YK4a5nab07tPyOyiWLzeqlM91++sxsILumJEA8uqoH2
	PyPLYNOmDBvU7WS39FuTpHZTaWDmdNEYvQpGasJhlgFSQNst0o7rzRpmOXZAxkkX
	TFfqog==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqhspr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 01:51:11 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8525f0807aso4165783a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 18:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779760271; x=1780365071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Fh0xI/akadKdHGqjpzwLwoqTYEfvzgu7R3F3IHIVXQ=;
        b=celCc1FXGuxq27lGA3oWJn5qKc/QroCN9jofLLX96gmYTOx02CTdc6Ktm2CoK5E56Z
         m5ZebMT4TPYM1IbApU2GHW198J/uR2gvbn/Fr8RdmoIq0nPBvvT8IeyaQEAyD05zJmXe
         oC6iDVW49xqiPtpZhF6v9nsfY6P/Pur37DwyO0TF0qH9t2VfUsOXWSUCckMVannTX6nP
         beVjF0UQnEh2cCnYTGfjtMzCZA7lQqLJB0D1PV6kxw3k8SBcA0WN6RY0nMe1ctXZD4DG
         BKmdOXiNn+6AHHhzVpXN9ObHROybnHz3iz5+TjJsjmrolCIFryjz+caIHL5J/sA4TdNY
         7dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779760271; x=1780365071;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Fh0xI/akadKdHGqjpzwLwoqTYEfvzgu7R3F3IHIVXQ=;
        b=cdoAs0gum2jBkBVd7Ih9Nz8IduTKYxcwzqQd9vfzXHYmkJFoDY8K2m5nGC5JKMuLfO
         /enwW55Y6L1oFy1rWeDgmNWYrGXZ3tCrnfTwhEPSPCcnNIeEo6OKPqxPoUuGqfjXyLIp
         VnuDSdoNAgBig9Rnix0Rqu0065OXc4fPbGeY3IZMo+B0duLcWaKDMrbB+PWNwn7P1x46
         sgvLx/9ZZxXuNkKUJEy/b1uzTu1Lpbn9v1zTk3+yQejdhAMztoask74i+l5X2sL4kExK
         pbSSOEo5Ua6biMpcC9xtVNDw9FLdiF0M7FjFx4+k4PkwfCuhlK2MRDoNvkgtF791OB+3
         /QuA==
X-Forwarded-Encrypted: i=1; AFNElJ8V2qxeomFINqYsqFq08GVEPC8B8q9Ev0R6dVLFLN8LYKyLGy6gmzfpi58atuZTJIdTACL68HF3qJJKKhwnrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+X3eG9/Ac4W5TozjGUzQU4uAq0x6fKDrQhC0eKTZ/ecIbgpn
	xuZYQo84x7HeA36Q8qAHCjRdebGnX6dM/D3JlN6afbicB/79TLwAVepMTFXZx3Ltz2jSp+PQtbl
	1/t5Ku+9DAvQFc8XkG9xgC0HeSFyFOPOs8MUXR1N02Y9nIp+ES/5nrA2tkvqRVLTp++pv1S6D+J
	RXRQ==
X-Gm-Gg: Acq92OGm6j25KTRDYikwUxACQDfNesMvr+vYlQdpeTypiragLSTgad27Pi/nMfaMw1M
	OLhARYrF9v+yclRAkDOLGkvL7+gCl+ByelnBdmoM3oBNmubvPpGxFykK3rhh13fqGOtfMtSLEt3
	1VLIyffRPkHi26KpSzLjTzJ8AzllNaXFf3TDxiftV0jGalr/VsLrF31MKR09v9IOop+fuhfQIln
	rsVLhxATLZu+R3mdRczoe0nYzDFCMRUkmnbYYeuA5M3PwVAxmsyve79fc48cuZJhfCyhn0aOjdH
	VVkDJeAJ12EHn53xva1E1DkNyM1XPMc14N+q4V7Il5y3lMiMhiszuqoB6FWMH5/6ahLhj4BsTOX
	LAWGmGBEeRRrpBR7opyY62yEYs05oknL4/+62ToUzlet6xsvuqqvxLW9k7cgm6yJq5SZ79UyPIW
	4xxvgs02Bm35bYVzdiHfY=
X-Received: by 2002:a05:6a00:882:b0:82f:425b:4c27 with SMTP id d2e1a72fcca58-8415f1591edmr15754985b3a.14.1779760271227;
        Mon, 25 May 2026 18:51:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:882:b0:82f:425b:4c27 with SMTP id d2e1a72fcca58-8415f1591edmr15754969b3a.14.1779760270718;
        Mon, 25 May 2026 18:51:10 -0700 (PDT)
Received: from [10.133.33.194] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164afe338sm10980936b3a.18.2026.05.25.18.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 18:51:10 -0700 (PDT)
Message-ID: <9e71acb7-38dc-4207-aff5-618abb7b92f3@oss.qualcomm.com>
Date: Tue, 26 May 2026 09:51:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_ath11k=3A_WCN6855_WoWLAN_resume_leaves_RX_in_unreco?=
 =?UTF-8?Q?verable_reorder_state_=E2=86=92_TCP_collapses?=
To: Hauke Mehrtens <hauke@hauke-m.de>, Jeff Johnson <jjohnson@kernel.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Baochen Qiang <quic_bqiang@quicinc.com>
References: <0fbb0b6e-c849-4e26-9c46-2ac4986f6b52@hauke-m.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0fbb0b6e-c849-4e26-9c46-2ac4986f6b52@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a14fc8f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=CAwv5vQtPF-BgKyaUxQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 0Qb-1hT7oGXxD7J_iMIT771hQ8sObJK7
X-Proofpoint-ORIG-GUID: 0Qb-1hT7oGXxD7J_iMIT771hQ8sObJK7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAxNSBTYWx0ZWRfX48p3799dL1UH
 ZoCGHac1pIl9HWX/8X4xyyjk0vqYzbu7mG2Q/76Zx42Mo/wxqIpSgEBwIs+AXWfzW2lXvfnlGmg
 E1pSskldwsLrgavODie1fbpiO3Xi2YIRop/bZuNQmos8EinArjNAgEzgVfbXkGUT35gv2x1Q3wW
 r3epwFP0GWdPxlTHmXNvox1zG8ls2OQL/ml5QJzewPjeq4EFzN0fiijp+TTm9eDKcTAz/Yqy1xC
 XO3EN9g9KgNK4gS3hJp74Q6/UvjPQg41g/L+ab5hJJ9c2BUUXXSbsUFSq+jLdNk+nYFsp5f4qHg
 Olp4A5KvSt85xumj431oxLsLdTKY0uFk8J0bxQaZ6Izetg77Vb28s+ev7W6kQch99W/blzgMAZO
 oAAozitKEtBqnM+yadbShMUWa2bj7V0Vaw8etXid81Imv40xLlBcWNiOsKrL8Z2IfLOmUwAFi35
 /UJs/jjHR+rwdZnevQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_07,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260015
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36894-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6924E5CF96E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/2026 9:24 PM, Hauke Mehrtens wrote:
> I used AI to help me debug this problem.
> 
> On Lenovo ThinkPad P14s G4 AMD (QCNFA765 / WCN6855 hw2.1), ~1 in 10
> suspend/resume cycles leaves the ath11k RX path delivering MSDUs out of
> order (~16% of TCP segments). TCP cwnd stays at 1-3 MSS and goodput
> collapses to ~3 Mbit/s; UDP on the same link in the same minute pushes
> 100+ Mbit/s.
> 
> This machine is in the DMI quirk list at
> `drivers/net/wireless/ath/ath11k/core.c` that forces `ATH11K_PM_WOW`.
> In WOW mode the firmware is kept alive across suspend; the WOW resume
> path does not re-initialise REO HW or per-TID BA state.
> The PM_WOW quirk was added as a workaround for unexpected-wakeup bug
> https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> ## Affected components
> 
> - **Driver:** ath11k_pci
> - **Chip:** WCN6855 hw2.1 (`17cb:1103`, QCNFA765)
> - **Firmware:** `WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41`
>   (fw_version `0x11088c35`, 2024-04-17)
> - **Kernel:** observed on 7.0.9-arch1-1; also present across many
>   earlier kernel versions over the past >1 year on this hardware
> - **Machine:** Lenovo ThinkPad P14s G4 AMD, DMI `21K5CTO1WW` (matches
>   quirk entry "P14s G4 AMD #1" at `core.c:961-966` via `"21K5"`
>   substring)
> 
> ## Reproduce
> 
> 1. Associate to an HE AP (characterised at 6 GHz, HE-MCS 5/6 NSS 2
>    160 MHz, -56 dBm, using MT7915 with OpenWrt 25.12).
> 2. Suspend, wake, test `iperf3` TCP. Repeat. On average within ~10
>    cycles, one resume leaves the link broken.
> 3. In the broken state: `iw dev wlpXsY link` still reports ~1.3 Gbit/s
>    "bitrate". Ping and UDP iperf3 look fine. TCP iperf3 collapses to
>    ~3 Mbit/s with cwnd stuck at 1-3 MSS.
> 
> ## Evidence
> 
> ### iperf3, same link same minute
> 
> ```
> AP -> STA, UDP -b 200M -l 1400 -t 15:
>   sender:   200 Mbit/s, 267876 datagrams
>   receiver: 102 Mbit/s, 137290 received, 130585 "lost"
>   (not real loss; iperf3 UDP counts out-of-window arrivals as lost)
> 
> AP -> STA, TCP -t 15:
>   3.43 Mbit/s, 521 retransmits, cwnd 1.41-5.66 KB throughout
> ```
> 
> ### UDP run: no real loss anywhere
> 
> - `ip -s link` delta: `+267,953 packets`, `0 errors`, `0 dropped`
>   (AP sent 267,876).
> - `/proc/net/snmp` Udp: `RcvbufErrors 0, InErrors 0`.
> - ath11k `pdev_stats` delta: `MSDUs delivered to HTT +267,985`.
> - `soc_dp_stats` entirely zero: no RXDMA / REO / HAL / TCL / backpressure
>   errors of any kind.
> - AP `iw station get`: ~1.3% retry rate, -65 dBm ACK signal,
>   `expected throughput 1049 Mbps`.
> 
> → Air link clean. Host data path clean. Firmware delivered every
> datagram. No drops anywhere.
> 
> ### TCP socket reorder (`ss -tin` once per second during TCP iperf3)
> 
> ```
>    t (s)    bytes_rx   segs_in   rcv_ooopack
>    0        1,291,653       895          158
>    1        1,717,365     1,189          210
>    2        2,060,541     1,426          274
>    3        2,519,557     1,743          335
>    4        3,050,973     2,110          397
>    5        3,446,277     2,383          450
>    6        3,906,741     2,701          513
> ```
> 
> ~60 ooo packets/s out of ~370 segs/s = **~16% out-of-order**, sustained.
> 
> ### Packet-level pattern (`tcpdump` on wlpXsY)
> 
> Seq normalised to 0 at flow start:
> 
> ```
> 22 ms     2896:4344
> 25 ms     4344:5792
> 27 ms     1448:2896           <-- late; fills gap from 5 ms earlier
> 28 ms     5792:7240
> 54 ms     8688:10136
> 55 ms     10136:11584
> 57 ms     7240:8688           <-- late
> 107 ms    26064:27512
> 107 ms    28960:30408
> 108 ms    30408:31856
> 109 ms    27512:28960         <-- late
> 156 ms    57920:59368
> 156 ms    59368:60816
> 157 ms    56472:57920         <-- late
> ```
> 
> Fingerprint: A-MPDU subframe lost on first transmission, retried, retry
> arrives 2-5 ms later. Working REO HW would buffer the continuation
> until the missing subframe arrived or the per-TID reorder timeout
> (`HAL_DEFAULT_REO_TIMEOUT_USEC`, 40 ms) expired. Here both continuation
> and retry pass through unordered.
> 
> ## Diagnosis
> 
> - Air link healthy; host data path clean; REO HW error counters all
>   zero — REO simply isn't enforcing order for this peer's TIDs.
> - dmesg across 3 days of suspend cycles shows zero ath11k re-init
>   activity (no `fw_version` reprint, no `wcn6855 hw2.1` reprint). The
>   firmware instance is the same one from the most recent `modprobe`.
>   `ath11k_core_suspend_wow` / `ath11k_core_resume_wow` neither power
>   down the device nor re-initialise REO.
> - `rmmod` triggers full `ath11k_hif_power_down` + chip re-init on next
>   `modprobe`, which re-runs `ath11k_hw_wcn6855_reo_setup`. This is the
>   only reliable recovery, so the corrupted state lives in firmware /
>   REO HW that the WOW resume path never touches.
> 
> The non-WOW path (`ath11k_core_suspend_default`) does power-down + full
> re-init on resume, re-running `ath11k_dp_srng_common_setup()` →
> `hw_ops->reo_setup()`. The WOW path does not.
> 
> ## Related
> 
> - Bug #219196 — unexpected wakeups; the WOW workaround was added to
>   mitigate this
> - `ce8669a27016` — introduced the WOW quirk table (2025-03-28, Baochen Qiang)
> - `0eb002c93c3b` — added `21K5` / `21K6` (this laptop) to the quirk
>   table (2025-09-29, Mark Pearson)
> - `4015b1972763` — adds Z13/Z16 Gen1 to WOW quirk (Nov 2025)
> 
> Hauke
> 

can you please try below fix ?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a2451a34afdf563b3102d36a4b6cf335cf813e2


