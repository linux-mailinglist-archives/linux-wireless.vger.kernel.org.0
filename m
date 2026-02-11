Return-Path: <linux-wireless+bounces-31745-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MShOcjZjGlIuAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31745-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 20:34:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 562AA1272F1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 20:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B93330136BE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE83734EF06;
	Wed, 11 Feb 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIOVvLuY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UocYVMNd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868E1FE47C
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770838446; cv=none; b=hASMM8ojxzBomhSPliOJ2sEF5E9uimAktORFax0z0WnFLBXIi+m5Vokpbv4lHy7iyOe96Us0Hl8bEFFErDFHV+7wrehs/N9PVj5A5UYKCholN5qFovqfoVuW3dJB8nmCe3ovMEGPISS+4vkKCY09Bbi8X0mGiUGkC+78Y1jw8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770838446; c=relaxed/simple;
	bh=huOFIXU6zQU6K5mbVUvfMzbrKsNGSd0H/00vfDLVndQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9rqdw5UeBdTY+mVIvKPMFYu4EhvhQGF9u3RvpcOzcbPtCcJ/7Q8XCTvp9pWGsq/pA32cQVtL8czL6APCb6YmecoMvZ5Mgc9OC4uB9F8KFYxExgY+cujEc0svUg89p9IPcasQguL8kLR4PnzFKvydkRWWkf5a7tGTnZyuCLZJfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BIOVvLuY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UocYVMNd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61BGVKAA1951199
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 19:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vErCvmmmW9UrSea05kC0aSzanX1bdBIHDS+Pbt9WrNc=; b=BIOVvLuY3UUOOgBa
	vnyX+1v0vgXhs6m0DjcrcsRExEeLmP2OUTlrtMkCcnEmLxeMmHvE+aHvspHLrLAp
	5CNa71KHM9SPISnjVXU8HPNUBSyoua5LfQk2Li1+Lcud5sC7ox0s3zC93bIXQZJH
	e+R9dXrpSGezl6jLmUqBvYrS7ioavk4UG874QfgBPVq/1HcSCRRIvQLjByeL+c+m
	Pj3H6ttQjvWvs3JKIdigXDpLfSI7CLuw7YZm08Z5fYTtwjGS9vvX8PV6ruZOMX8a
	CTbOECE7leZWScmFrSk3wIzig+TcYwudP2tqVmlExun4Utj0ZKrh3QOExWU3yMiV
	ylUf6Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8wc4rkmf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 19:34:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ba9a159437so1540457eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 11:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770838443; x=1771443243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vErCvmmmW9UrSea05kC0aSzanX1bdBIHDS+Pbt9WrNc=;
        b=UocYVMNd5kfAU3pAE9t/7Ef4rZ8s63Ne5duCQq0hGgNL1ZyDrIcQC/nL3xicplvMQj
         w1nXobw2zGsxMPvYUtvrrDR15hMqspFwEuOMd8d2Oa5Zo5zEyWrx45AxjobO4pjm35DO
         yyxq20S8UXhRZ82MjyQPNqm/zXyDwgt9E0FGaX1PhGArPt/UdXigckFsZF2bnG7D577g
         8QlzQzjvdDxVQxumXItOv9FwkHtK7m6vDka6d+EYCPlRfg/sKuLUhlGSm8lBk8ngven1
         nXHRj4tb5aF0ZoRoWGhyT531Ij2yxzlSdfmocXfEJuCexqL25Ef6WXicj8QznATGH8PJ
         vAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770838443; x=1771443243;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vErCvmmmW9UrSea05kC0aSzanX1bdBIHDS+Pbt9WrNc=;
        b=i7k50REfWF+q9c3y2nSzsyNiopsxEOChuTdNDZibZyXltSPnHQxCS2e+3Qmspx1kvC
         MzFJVA7VM+b3+3o/MfNjWN7pjVkVBiQTEz9lWIiSeDVPu//c05NvmeY1r9/Gekok+fk9
         xopdmeqc/I9szTnam/kbir2mE8gzLEKZeyRFGIOuOh1WMU65gqB7dp7PnAeN4+SN0wi2
         rih8zDLwesBP6lo1ePQk/pNDhXFVwMacwCWNL/d+nDlSVEA8Q4b6UW6GFcC9c86/BXuS
         miiBMo4uP2Ax+cJyTdJK+9e9+CDkMGlIgcY7YWi/Gc1kiySyEyPqAoAAveh5p4lIsY+g
         rhYA==
X-Forwarded-Encrypted: i=1; AJvYcCVfTJ3Z6kL2AGeeGI20gFlPHMf/0Z5l362EgoMMZ7xVLJ1Y7Q0t7dUZebDJnKcPF3wNfcQ7CwyKw+oCn2nMLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOrZYLL8FewO5I/WRiOmkVQxrGx264S3RnpI/sZckuvZnvtI9B
	gQbODYpD1iw8//MS5I8gGhruM7ldZx3H+ODaV0ycxrsikpVkIl+nEMfuTdCI/ieune5PuN31WeT
	0lW9L3w3xYRA/h7CGoqYaZ0zXPXRt3OSCuwoQcEPrtohxCKtGWiCpMc2qUI5OytL2Lb0E7A==
X-Gm-Gg: AZuq6aLsA44gbnK/OxBUo2RS3K8tXRPd0vqbkbchhb2zY+/fAtIY9i4MNWEozVArPiU
	EZZadIOMxOh8kj6pGxUskvbPD/Iucze1tGW+BEeV5SeAj1GNMILbv+0CanKIBjN0DjokV0FNnNi
	1/UsJ8V267RYdtGWv6e9J/+h8h03ZoG4gPcwlC7hE6PpXGmS4qExT4L/NESfxMB1Qd0ndJ2X3Zp
	xzNaQFv0/y6tCua9cNgTllvI5cvKP0c/y61BfpdwuiBU7a8asSCpO9yJqn0f97E3X2H7xhgBlst
	uCnaTyOW156U8I/5gwR3eA12tpNJgrJhOYZzHRix2oaHNa2Pcpc+sQ1fz3HfV9lXc4cyWzfYCrv
	ZLwwr34fslY1iLiX7AHscDqP2uxQwRc9UTtSoouZbRC3xaPAu/FpcaqCgWQ81FEnNwzWZt6kMNV
	CzW10WhA==
X-Received: by 2002:a05:7022:2507:b0:11b:1966:8732 with SMTP id a92af1059eb24-1272f77df86mr128008c88.25.1770838442713;
        Wed, 11 Feb 2026 11:34:02 -0800 (PST)
X-Received: by 2002:a05:7022:2507:b0:11b:1966:8732 with SMTP id a92af1059eb24-1272f77df86mr127993c88.25.1770838442064;
        Wed, 11 Feb 2026 11:34:02 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6e9966sm3057571c88.10.2026.02.11.11.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 11:34:01 -0800 (PST)
Message-ID: <cdf6bb67-7eb5-468a-b01c-22fe6ff05745@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 11:34:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k-firmware: WCN7850 hw2.0: update board-2.bin
To: Georg Gottleuber <ggo@tuxedocomputers.com>, linux-firmware@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Ettore Chimenti <ettore.chimenti@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Christoffer Sandberg <cs@tuxedocomputers.com>,
        Werner Sembach <wse@tuxedocomputers.com>
References: <59ed6306-28f8-478e-90fe-4a1b73ae3051@tuxedocomputers.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <59ed6306-28f8-478e-90fe-4a1b73ae3051@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: prYO5It4-iahaqXfxT72_MnDC9u_h9vx
X-Authority-Analysis: v=2.4 cv=NrLcssdJ c=1 sm=1 tr=0 ts=698cd9ab cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=qC_FGOx9AAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=S897yw-y8637oqSYNAMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=fsdK_YakeE02zTmptMdW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE1MSBTYWx0ZWRfX+PEjEyTgk6C7
 M0IZPgU/yq6uolc2+yuVFz9DaW6dNJnYHlvcr6f/BWgqLEjpRcfJIlnVBwL2W8MJndS00NGUDVQ
 e+G4NYBxnTxB0M7F6CzZ00J9upNfnMYcLkjVAGdliG/yIEtsAmQ8FEszes0rq0rT16itGaDDsrd
 5hsO/gUQHaNqQqjqj/HHsUMlFznX/g/nZ7iTGucry3EKtX19pQ8qJR0eYbD0y0GFHKQVZa7rhNO
 4dB+3g1RNSf5IFgD5kgzBiJDa8V3TPzr9i42kXEgob77WPrECsPKR8bj3ZYB6tiNmE7tvMAgcP/
 F9BS3M+1J+MySPRU5XPMjFjYwGZsbFwc8MOSxJwwqQHyvdo51Q5axnln6+f+xqrUy56Na5n2YIu
 UP1welTIM8njRbTJsFJtI8Ih+eZ046gV2Ci1C26BoxcMDaVJWlQZhLrMO4rGutyDY+TbZ889DyU
 TFYubWeQY3iKN44cHAg==
X-Proofpoint-GUID: prYO5It4-iahaqXfxT72_MnDC9u_h9vx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110151
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31745-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,msgid.link:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 562AA1272F1
X-Rspamd-Action: no action

On 3/27/2025 9:13 AM, Georg Gottleuber wrote:
> Hi,
> 
> here is a new version of the updates to board-2.bin for WCN7850 hw2.0.
> The content is identical. But this time according to the instructions.
> 
> * hardware description:
> 
>   - M.2 QCNCM865 WI-FI 7 BT Combo-Modul
>   - Qualcomm® FastConnect™ 7800 Mobile chipset
>   - PCI Vendor/Device ID: 17cb:1107
>   - PCI Subsystem: 1eac:8001
>   - radio is for 2.4 GHz, 5 GHz, 6 GHz
>   - Bluetooth
> 
> 
> * origin of the board file
> 
>   - extracted from board-2.bin from linux-firmware
>     ath12k/WCN7850/hw2.0/board-2.bin:
>     bus=pci,vendor=17cb,device=1107,subsystem-vendor=105b,subsystem-
>     device=e10d,qmi-chip-id=2,qmi-board-id=255.bin
> 
> 
> * ids to be used with the board file:
> 
>   - just add an additional board string for
> bus=pci,vendor=17cb,device=1107,subsystem-vendor=105b,subsystem-device=e10d,qmi-chip-id=2,qmi-board-id=255.bin
>     +
> bus=pci,vendor=17cb,device=1107,subsystem-vendor=1eac,subsystem-device=8001,qmi-chip-id=2,qmi-board-id=255
>       sha256sum:
>       3ee7d3291e4121431b79adc28dc06f28f0cb12d415e79244061c9349a1328dec
> 
> 
> * attached is the already present file (out of board-2.bin)
> 
> 
> Tested with 2.4GHz, 5GHz and 6GHz (iperf3 -t30 --bidir)
> 
> Best regards,
> Georg
> 

Just want to document that this was handled by:
https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware/-/commit/fd7ddeb46bb57736211092c426bf6cfb2e703281

With the associated linux-firmware pull request:
https://msgid.link/ecf412bd-7bd3-42ed-bea4-d7aa837ddcae@oss.qualcomm.com


