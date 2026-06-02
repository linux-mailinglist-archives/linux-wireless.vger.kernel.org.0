Return-Path: <linux-wireless+bounces-37310-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dzOXEA0QH2q6ewAAu9opvQ
	(envelope-from <linux-wireless+bounces-37310-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 19:17:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FAA6309F0
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 19:17:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RvGqCcDN;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LxymQkXg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37310-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37310-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E91630E3151
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B499D380FC7;
	Tue,  2 Jun 2026 17:10:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AA3876D0
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 17:10:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420219; cv=none; b=lPmLbxBYW45bG/W4kLqna1VFcVZrXQ8r9zjePGYWnzC/2lqtMCK8xzrii6tJkHe51ly/QNPJOKBz+obgcFawHtXCahRmhVdnte2unUzwaadl7usiZVfvtR+uJ0+kM6y0cPKohogQ1Zy7M3MvabCdYqQ7VFiRh9zKWLIM0DCO7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420219; c=relaxed/simple;
	bh=EtD5/9vaC69fMoxqqSkuAD764a7iBGKyoM1iNno7R5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edRW9LhCTgJbd74teFf9Ne2+mYtQrRwWhEcza21gVYRk8p7XE0kR0nsbzRK1qvObEsxBlKrf8U529Z/8WHCth5JdC1ZndmXxPiGcD+jSIyNeaM502pyh5wj9CxNHpCClDkPc13yn8IE/p1cODnqymSJnG24kwHZ+wdA+Y6HW7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RvGqCcDN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LxymQkXg; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652D0Fb32767168
	for <linux-wireless@vger.kernel.org>; Tue, 2 Jun 2026 17:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WnpHurriknASg1CchB30qt7X0mCuqO6Pf6V96jiWis=; b=RvGqCcDNYtozPEiS
	CYLS/1v9wUP7ra0dhlJpkOOhOO9laDsk8pM9hPeXxK2WSDfiJHmrX7eFDeIFjW3R
	Vgw8CYBJaPcJFi2nEQU4j38RE6pFJj87Loajsn/11q7Ti2dR1likcCeJs92naRtY
	Q9lv2IuUqBxXxgwp9gDI3i2H/qdn7wzTWmWW3xr1EQ423C8Rhv+53dkRve0d+xBy
	Eph0XrYHFm+6BXqeZQAtX0KWK+FIA4NgaCjGLSZikyRuE6b9oDJ1jbk1D0Ec7M5C
	CcRXcOkAQDdJZe/GvFazntD3eFruKEWa6xGnpg/FtEAdzmtYkc9uy+3qxq4zvwAT
	RUqbOQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsus2q3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 17:10:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3074d4102a9so191846eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 02 Jun 2026 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780420217; x=1781025017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WnpHurriknASg1CchB30qt7X0mCuqO6Pf6V96jiWis=;
        b=LxymQkXgUN3ng8h+lrNQt/oU6PpyCSUqQkEkykM+fpUP9OgCkUwHtRFG85UqtpCvSD
         BNU+DLFNy6B+iqBl3E7sPYqCyjAoeOIGN5QwGm0P5IyF7Wk3Z5J93+j14gOVtdEEzR1F
         nv8OaWLaTOjKhfjV66DymZrnkNBrUra9c2zYTbCeaJthawCifvfwREe/zHfzeI6aIEGs
         aGqd7hQAlVuUEOLomlKkHGcvCGqSx8e/zRlj2fHEfx84zUQyr6c8Zb7wH/v1H6/ijRnW
         LyxjkMy5MOnffv6hjS0Qd3vOSMHOMt9dfx64X7rgWBIiX72rCebZWi+JjTInvKRxvqE4
         GfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420217; x=1781025017;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WnpHurriknASg1CchB30qt7X0mCuqO6Pf6V96jiWis=;
        b=Gco8o43h5VPUkMScwnTGzkrn7UVUDeSpcJtIN8eLv5XBFcwF2vouyYlJDvQjXTMNjf
         Gm0Js8MWGWeg1LVTZidPUFsc4m2L0wQkwIUwbVDFDM3PCs9pQOs4/LW46nJLU+W+9K8E
         Dwq2BMa2CDX/WAMNwvUVyExFYDZo1NG7lybYuJ7vvVqRk4DkkuMmS000g+Eov2HVNUeG
         MxJ9YMtjz75kWxBp396lddnqe7ek9wPZ17wXqvs42ZT3EEQdbNa3hoEY5NdbfbGhZl5V
         +3H+GkZmVB3TfsEYNVxF5ju145u12qv98HgWJx2z+QC/BAaSL3rtYEXHdByCbCwJZkjL
         K2RQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gOoy7Q+SwK5tivkqi6fTCGsfd++VqZfqtQ3QdRrHaRGU7CMsOobZWm4sdfIIviwBtJkDFr4ekhukT8L8uRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/mbjNsormOllO7UPrwYfVG8LqF7ipW3sQZYBZZgEHC1B82E3
	NT+qh4D4bLbR41O4K6/NJ8i1AtfyrwHy3j1CaPKvIMfgCMT6pDn/RjMp85lOatTga8chzARULJq
	1JI7fXdsEoUtONjEXlztpcipN2xynNpuqGMg3v+yISpWt4Rk1yFzErLvjzkfIfGikpZ/n7xrKwC
	gd6Q==
X-Gm-Gg: Acq92OFIX51pKSzLVPa0z+ppsh8tiRMFk2Ao6XqjqxBrgLkRJsssbX6NuLV4lf/W/M9
	5pAZTqX+camwafWOEW536SHr7mjrCbCrR69PBmuH0HGtbTg12lkj8C2ApamN2RxR7UV5ySyCyRM
	I3t3XCBDIUEe97iuExUd9oxFDMAM35xZl2u3Lk6dXKfGIsEIxZLfkyhV4hxYFSIQgJUOZisG5/j
	I3A5C699SnaGJCsLKS2Ryeg7lFZYwnlNpiWduTce1QkyDWd3Q3xtFli7gB3Y8Vpc9Op7sUYBfZ9
	pelXRKawZ5obP8hPgVa65qkfkipbahCTA3dbtme3AAbnEv2EdwjzuQu/F+Dt1EK8IC7DEQnxzJI
	mNvbp1ZQQhHgEtYRfGMXL9FDrxJMgOBb437/cdhkrP2Jxhe4fjl1mPy7OzBps1DDA6ixLNwYi9X
	QX8kBwMoHNBH8nhn/M5kmvNp0E
X-Received: by 2002:a05:7300:ef83:b0:304:ba84:a0cc with SMTP id 5a478bee46e88-304fa74682bmr8020147eec.33.1780420216455;
        Tue, 02 Jun 2026 10:10:16 -0700 (PDT)
X-Received: by 2002:a05:7300:ef83:b0:304:ba84:a0cc with SMTP id 5a478bee46e88-304fa74682bmr8020119eec.33.1780420215911;
        Tue, 02 Jun 2026 10:10:15 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f002sm12470560eec.18.2026.06.02.10.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:10:15 -0700 (PDT)
Message-ID: <dc836218-2f18-4465-882c-c41b5289c379@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 10:10:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] PCI: Add device-specific reset for Qualcomm
 devices
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, bhelgaas@google.com,
        alex@shazbot.org
Cc: jjohnson@kernel.org, mani@kernel.org, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, mhi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260602160024.1171949-1-jtornosm@redhat.com>
 <20260602160024.1171949-3-jtornosm@redhat.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260602160024.1171949-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xLnNOjBu1EW7Eoyi63Nqfjqg0ujj2_8p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2NSBTYWx0ZWRfX1jgR+V89mvod
 FUU+ObAmuwBrRH+gqP83Jmf0rlNFpD4ZBBBWmqq3tyunrQQmQ0XEeiiFcI+JhjamLACgTQmbfu5
 qSbMzNj65xlBRgnGj+LJjV2GZoKuuiaFryKokzB4fizxTMOUvXsay9OOBPNrBxzjk4MIu8b+oWr
 YUa3Vw2sTBQtcbyp/QLgrN5FeudeV4idCXQoP9FonbsY4D1xh7BTkQniumnrSX5067OSvABeB2t
 ITE9p9xfgb2Pxq2Ik3i0RSXC6Xl+FuXBoPJgZvIO+FZi/k5rRmL+X2hu/YkdRTqiQvMW0l1H1Gy
 /2dUX/FSbGlWxOJDN7h8nEUGxbsRDm0xdsfUNeOzXsb7eIBzdPwof/K41C8yb00UNNyye6Em1Iy
 91lNc9vpRa73RfwYW3K4I0ZU2op9sk3JqWipkTxL8IKvCiE2LdusbtDUjn4VvzSpUme4mJ5+oRe
 3S96R+84acb76VLVCPg==
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a1f0e79 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=_dsfnS01iu48ROCZzqsA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: xLnNOjBu1EW7Eoyi63Nqfjqg0ujj2_8p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020165
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37310-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:bhelgaas@google.com,m:alex@shazbot.org,m:jjohnson@kernel.org,m:mani@kernel.org,m:linux-pci@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:mhi@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78FAA6309F0

On 6/2/2026 9:00 AM, Jose Ignacio Tornos Martinez wrote:
> Some Qualcomm PCIe devices (ath11k WiFi, ath12k WiFi, SDX62/SDX65 modems)

Throughout your series you refer to ath11k and ath12k as if they are devices.
They are not. They are device drivers, each of which supports a large number
of devices.

> lack working reset methods for VFIO passthrough scenarios. These devices
> have no FLR capability, advertise NoSoftRst+ (blocking PM reset), and have
> broken bus reset.
> 
> The problem manifests in VFIO passthrough scenarios:
> 
> - ath11k WiFi (17cb:1103): Normal VM operation works fine, including

17cb:1103 is WCN6855

>   clean shutdown/reboot. However, when the VM terminates uncleanly
>   (crash, force-off), VFIO attempts to reset the device before it can
>   be assigned to another VM. Without a working reset method, the device
>   remains in an undefined state, preventing reuse.
> 
> - ath12k WiFi (17cb:1107): Same behavior as ath11k.

17cb:1107 is WCN7850

> 
> - SDX62/SDX65 5G modems (17cb:0308): Never successfully initialize even
>   on first VM assignment without proper reset capability.
...

> @@ -4252,6 +4268,9 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
>  		reset_chelsio_generic_dev },
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_d3cold_d3hot },  /* ath11k */

s/ath11k/WCN6855/

> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_d3cold_d3hot },  /* ath12k */

s/ath12k/WCN7850/

> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_d3cold_d3hot },  /* SDX62/SDX65 */
>  	{ 0 }
>  };
>  

same guidance applies to the 3/3 patch

/jeff

