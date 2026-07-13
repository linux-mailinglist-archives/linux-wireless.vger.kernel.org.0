Return-Path: <linux-wireless+bounces-38977-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dnfeNlvzVGpyhwAAu9opvQ
	(envelope-from <linux-wireless+bounces-38977-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:16:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D274C429
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 16:16:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=b7ycXydv;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UUQJQghF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38977-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38977-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85183319BD57
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71DD43CEF6;
	Mon, 13 Jul 2026 14:05:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB83543B3F3
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951554; cv=none; b=jYKh0VC6/vGg0GjzBrV6YB2sbu1yarsDuPvLrzxHKIt0x91VN9nQxXaZ7QMITjAfkyChR60lPph9m6as0ioDFuyLAAKLBO48hVu513DyqZ/QveRzSb+cYxaJudTC+bjN+M47aIlcgOzByfroaIeGboOtLhgAPKL1cQtE8kNMfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951554; c=relaxed/simple;
	bh=ht9wTiMNixkrvO2hFKWoLvVxutMatGktb+GJwbzshBk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xzx58icFY64a3+eFzjMExnEJN9lg6AWU/vCFYOYiISZJoPw3QI9tOicLlV1sO8JuTdiMrSKnhSSPqRSAFT4i0ZGdOspVUCYB9RSikuBk68q5k1aIaGSnF9hn7laaPm4vFWrP6ABdvFuVNFUzK0jzdqEggCWvDpnNXAn6m09ct0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b7ycXydv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UUQJQghF; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCEMIQ1333558
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dzIRFT+iQ7BrYoJ4rXxVg76JrRf5NAnk/9cPjhxZs5I=; b=b7ycXydvhkmwR0Ld
	e0IaWXUrZ/A+tczabEep7Z3E7iX1YRpnxAoPPuXRjZipWVh/0D53UFV/P796lTS2
	8Y5Vf1WKF9fsHTFnmwnOGBByNexmMF0+TqasuyadIuxD6bG6tPInKjlkFohLpE1n
	ARRn/1XxX6YhcnrqANt8yLAJtiiVludwWCMYKcsG2r+V71henYo3SkjX67G/mqDV
	MA0t2za2+X6gcweXTXJ5MhSiHdKBG/6K90vEs2UhfdG/lWsFynfSrPWOvboNTNsn
	hKTTLlJY5Qx+67DTlyr5DU9OOG6jjpyoSqzpl4IHjtxvkNJoQTduDl6sZEk3A4Nb
	P05cGA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fctc8hvhr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:05:52 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-385d2703b64so4290468a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783951552; x=1784556352; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzIRFT+iQ7BrYoJ4rXxVg76JrRf5NAnk/9cPjhxZs5I=;
        b=UUQJQghFkDNb0F5ryEHBFklBwfuEZRIfQOWMgTGWz/GZ7Bvgwatd9PMrBV5o/Ju+jQ
         OmXzWYKnTr1gNDlvElhzLztgyWe4zSLLDiBhUwTuhLZgBlsQAbhenwKiKnuRzmtbbfjW
         aslGdbhMih9Gy2CM2NmqPWGNtcKfOCfHDcoQzJC5HwCxCIZfHoHUmhIwXpTvrwcmhj7n
         oiDxPOkF0AYw1UwV7J+GTbZ37JrpoUoT9M1l8tTKdodQagoPDmj8imsr3KSQ04zVLyLQ
         6W98GAstk7oQx4kEVPLzDHPZyxsECblrs20JMWZy7FuTKCcCpaT6nhq3F/7O7S6/o0LY
         0d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951552; x=1784556352;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzIRFT+iQ7BrYoJ4rXxVg76JrRf5NAnk/9cPjhxZs5I=;
        b=RsXUTohwYgaN43VXAKSKrkOUjEhPjskCMI/7PNleh715ED4K7rffws7AmpgQIyCmU7
         jXtUHf2rzsNr0OVRkljT00b7CcSZ20H6VhZbmgwWT1MJzplJUmVKqQb3ej6CEQmBmZkQ
         bk+2vt2kOVCPUA/UMduD/NkFuCGWlwpPc7VVxqL/6w36nLtpNanLJkr/EkSTgJJS2Ygk
         3pqKWUn38UrbYo2Xda3WGCT4Cj5Duy4rYyjQssGaZ4KHZBhS0WvA4w82ytZ+cpLgXVPb
         q/TxHHPEUVHkJcqZ0n4XX/iRU+bZNytFDiXkxtFwrM1LZwAw0IxlISvxeo6ED/iHSNrl
         WPhw==
X-Gm-Message-State: AOJu0Yy+oCGx5aV5soHAzW/ezw8UyokKa1Ax/HviUoynMzX5SMWapJ0w
	+Uc0o+mdxG8FInEyeX6YlAwBSwSoQWx2nZ4Z2TpmLm19OZCt2D0chr2JfYkKBI4U91mWbjcfvEH
	OIcJHIJgZlsDh3noniGTboidoT8tr4UUR+f1d7GEqIVmyzJ2LUEbCzHUW1K7nbznnG8LW5g==
X-Gm-Gg: AfdE7cmQ41r1aHUCEauOiG2VzVsUbglqqoOullqjPwLdZF98kNjjAi05aApPyzKMCKA
	1r1+ZQoWSPoZsokZKzyAHxH5Z8we6RL+Q2/x32NX+SoXcxVOcDICFU8eRNF8t3cZaqevDWJRKfc
	6PrwZeWBuxcDiWHAZCSzcncIxkvcfwIR6f5kYrzJTelOzyXvJ8CCWOlZ7B0xvoFo3dlFbESnBDP
	n89ugYRwlPPM32folTNvHI6MN+Gnpq0G3zMKB3htonjEqNkpcGqbfKJLGfAqne7ntYOLUak72Ca
	NBFdgEkCULw8zgu2cUvcB/IJctgHKXOtGoCJAUzVu3SenQLuiRiILTbVdi6vfM8dZOJQ2+0tl2e
	hRjgt4XoKCf8FzGOVeGyiie70v5eqKbDypRElKas/deWByQI37c256/J1WF+2PPQDcA==
X-Received: by 2002:a17:90b:38c8:b0:38d:ee5a:63 with SMTP id 98e67ed59e1d1-38dee5a0713mr5027612a91.7.1783951552197;
        Mon, 13 Jul 2026 07:05:52 -0700 (PDT)
X-Received: by 2002:a17:90b:38c8:b0:38d:ee5a:63 with SMTP id 98e67ed59e1d1-38dee5a0713mr5027593a91.7.1783951551758;
        Mon, 13 Jul 2026 07:05:51 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm77071424eec.0.2026.07.13.07.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 07:05:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Tristan Madani <tristmd@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tristan Madani <tristan@talencesecurity.com>
In-Reply-To: <20260421135009.348084-1-tristmd@gmail.com>
References: <20260421135009.348084-1-tristmd@gmail.com>
Subject: Re: (subset) [PATCH v3 0/3] wifi: ath6kl: firmware trust boundary
 hardening
Message-Id: <178395155012.877545.16061217346639945087.b4-ty@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 07:05:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: FoiPFFjFb17phEIoJsbAkRGYLqYSb0HO
X-Proofpoint-ORIG-GUID: FoiPFFjFb17phEIoJsbAkRGYLqYSb0HO
X-Authority-Analysis: v=2.4 cv=UtRT8ewB c=1 sm=1 tr=0 ts=6a54f0c0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=J_-Nd1mkAAAA:8 a=EUspDBNiAAAA:8 a=59yTilktV4VC3dRWLWcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=n8ForQn92ZFaZtFqRdMw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX7k/3HKKqQru/
 uJrUdbGdZQ6HD0XZYNXRZCANERIYfdX4mYGMbM4JztHk+OinbTOqatGNZbFHGmmuFKqvKvVNTO4
 A1dkWpuSQQW/x8+LTbDzjvmDX7rYg6Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE0NiBTYWx0ZWRfX/wQatHk/GW76
 YCv6eEaelD0qMSdtgoTBXB8ZuVqY6+E/IeqzLKUeIgsIFmvWv+yEqUJfRaorQHil2FVgZomJMr3
 1Wn8+hUEjlLBB1YSOx7oyidOGtQ+iQVy5qiWyCIulF9SSthIKxPvQL9bypq0gzB3g/7/wYDQSBN
 g3gld5IiatfbyIYDC93FvHebXwYbWHRRIxXEh3hUuNEjosD3dqCR1FAcrnSADnkZyEaRdFY+AK3
 42VJUZmoRUDqijrNF/FWO1rGIPoEweXXxXhWMk2mHlwWVHvGlos3pZLi+fvGIcptrV9mGnVkfWB
 o78IprgGNQUa4v2iomj/z+d3DmF4AZax1hoO3HWPRmEftyI7aLaIiVrQuq/YNuxjlennkFeQ98K
 tK6j71w/X5e5Dz+FX4DYrYoWJqXHc/xX0S0hDFJSA3OnfUkH4ujA8HsPO2OAVD6R5K6mmnTiZ0b
 ooUkKel7LQA33clTxkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38977-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:tristmd@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F6D274C429


On Tue, 21 Apr 2026 13:50:06 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> This series adds missing bounds checks for firmware-controlled fields
> in the Qualcomm ath6kl driver.
> 
> Patch 1 returns early on invalid ADDBA window size. Patch 2 validates
> connect event IE lengths. Patch 3 checks TX complete handler num_msg.
> 
> [...]

Applied, thanks!

[2/3] wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
      commit: 6b47b29730de3232b919d8362749f6814c5f2a33

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


