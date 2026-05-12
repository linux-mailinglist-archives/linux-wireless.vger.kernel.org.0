Return-Path: <linux-wireless+bounces-36324-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLIRJkk6A2r81wEAu9opvQ
	(envelope-from <linux-wireless+bounces-36324-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 16:33:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 940E65229B3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD3433185A97
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 14:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF973A59A5;
	Tue, 12 May 2026 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nlhcX+IW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kijG2hYO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C63A9866
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594561; cv=none; b=miXvIbFuukAt2IsbPNZGkMZ0qjK3+2Tkqw9pBrrc0ifsnwJu6rN3ZBxapqbRS3p/NyhNidpaKIDbe95ploFoTSWc3e5lh2ZtVnsiB+Jh18S5nM85A5KE5ktZriXbiEfiH0uZBR8mAtXc1cMWTxEsqSDgB8CV+MB4xV1PvPGugSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594561; c=relaxed/simple;
	bh=nUVQaa27vbkuNL9Eq2U9m+Zc54HBcFkivOSMTJ7Pd0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dWOEZiVVAiy2pEbdP8s18IuAptYnO7BGPOWMfpCZnK0h3eEeuAVLuTyKtDgE978/x7QBTd1pA4hCSw5oFyDYG6LECbdoiKQ6pGrCQYK50omEhOZNlKyc0BsvMLB5kIrAcHLcFNfPI+UHbZW8Yg5IEFTMUvcWBhDDqugQGzdLFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nlhcX+IW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kijG2hYO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCA3Zd144553
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E8JuAd+lFmieGVk4Jn6ABqC9bS1odojhWBHO5QEXKy4=; b=nlhcX+IWUXi91hHt
	zhKHELLOwZ+l9PKYMk5Sdr2fMsHeCB1KlF0dDYBdHqeTyzm0Fb7lRYCKeX88DqjW
	6+yMB8gq1Qc+OhwndmZb5Z/y9Tw6gT8asHzQRe1aZ6ukhTajCiQr2b42vt9NVW4Z
	g7g1kRK3RkfQX5xOcV4rxfudZKPDas8zVbQunb6ZRo6KV0VHs68wZR1KYfdIy/K/
	ZqX5tpZuWkaWukWE3BNMqEcC0OUBJY92FEww9hl3V/Tt9ljDxcij4UqdMQJ40fGk
	uF2lgy858PsTWmPl1x45S2cZyMC9bBt/mOstyR5As5Cg6vuxLxU3Ms0P413kZZ2A
	YyMA+Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43yp8cdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 14:02:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdd327d970so3197537eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778594558; x=1779199358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8JuAd+lFmieGVk4Jn6ABqC9bS1odojhWBHO5QEXKy4=;
        b=kijG2hYOq5lTqBJwYUj92MgL577F1W6rzVDiEVeLPcImlsKuaAc96yqxeT7cTxM/rW
         7BAA7ooj5VLjf6oa3mxJQ6DzGgR0mkQtIm17Ucv084JiEB0fRxR7A6DN6l7D3UJxu3bY
         P46z1ztJYBKES7b4KLKAzXibkY90KAufPAbc4kNGhHgYJsQotx9UQCHxsxtOk6K2zIUT
         wQjsB3pQ4OzaHGllIkDrHG7d+XJ/VJTqVVpNWIJY5EZLS9SgSq+EVH45ULuIfAFtUf2h
         OM42EXX4sXqoYfMrr7mKZM1AOfOfpSssYdH9tdte8a9eez7ZCeAmb7zm1Fu6Ex86PmxO
         Aj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594558; x=1779199358;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8JuAd+lFmieGVk4Jn6ABqC9bS1odojhWBHO5QEXKy4=;
        b=Qi6neQJb6n/OU/bL557x7l9tZulC0MgjQJCsaAUkd1TOuPElvMWEAHhTaYWsdsBKFE
         N8hOlLgcHRBEzRpLEUDE5Tw2K84qi4OO8bKXHcRHpmq35ySiTJhu/F/9nGIa59d5yEGY
         mZbmi38MiU6Xsgdxz60xrtfhA7k0bY7IECKgpNFE5gjDnDHFnrrPgoges4XthGasOGAt
         xdOmx/xmnuf+CUQGNTW26AKqtXI7uGaMlRPB1dum5eeDluWbYt7re4xEAOCheVbgw/eP
         KYW4qiBiq1VTcVFKu8K8aX6OE/N0ozgCzx9vxg2cNuFv3Pq5SDA2/33f4g9WgY21DSaR
         d3Lw==
X-Gm-Message-State: AOJu0YwVgMoII7yDAhTgU/8lLdPFqKlKCpM6/8KM3a7SQiU4SS7MPaQM
	lRjLklt+PUHwiLIJzs9nyw6hEhOAVNEl4U6fH41R8THZ1fHO0ycbh19qURIVecOVuk7EVFoRkQA
	jDBa00lq3gX8pVpO5gNnbHiQHrnfmP8ysyB/TpMW6uw/xr5w5fiFJTMw57xE7V2+6k8cSFQ==
X-Gm-Gg: Acq92OG6M2BHFrm2m0fwOn6UQvwmt/LCLWY6BVlXROn8bmYb2oV/3OYVLHSWCre046v
	qWRzryZXb5VNZd43xAUfLZcLKj6eowaDBuZib/Zua1g7txGDPnDW1u6wDuPBGBMf5kWYm1oGHCl
	17ELNrCwkmsdoJdmOrnSD8h2+uTKAPCNtP6NYZ/CUvH6Cda9QbCjUouthT9W/w/ZMzroXuuEFzj
	sP9MHCLS7cjFhyxoRN3gZatCbVpzgGIAcjbyjsY1XnVkZl69of6HA/CE1KxSgmgChZfteQPqvEx
	WrbRNU0ORjbUiTY+sBMHH53YdIVJjoS7CH5RzZobo8FCK+2dFzP2YkaHVul5zKbB+PcPpdwaxso
	Nq3MfC14KswCDByXeV3vMIOFM94zQiXwVJXNRiRc5URtlBy8kUqMt+5p2ImPvfpL4fnNQgUBJee
	TO
X-Received: by 2002:a05:7301:6089:b0:2f1:1fe8:cf5c with SMTP id 5a478bee46e88-2ff93f07f7bmr2147825eec.11.1778594557852;
        Tue, 12 May 2026 07:02:37 -0700 (PDT)
X-Received: by 2002:a05:7301:6089:b0:2f1:1fe8:cf5c with SMTP id 5a478bee46e88-2ff93f07f7bmr2147546eec.11.1778594555359;
        Tue, 12 May 2026 07:02:35 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8864c37basm17657298eec.13.2026.05.12.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:02:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath10k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260428061737.37-1-kang.yang@oss.qualcomm.com>
References: <20260428061737.37-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath10k: skip WMI and beacon
 transmission when device is wedged
Message-Id: <177859455444.3185911.133872677008230423.b4-ty@oss.qualcomm.com>
Date: Tue, 12 May 2026 07:02:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 4EYxBZUhmz3HAeZIWTBddwUoWxggBjJB
X-Authority-Analysis: v=2.4 cv=R5kz39RX c=1 sm=1 tr=0 ts=6a0332ff cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=qWhBkdlSneVv4oJQ51kA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE0NyBTYWx0ZWRfX2eu5i/AaGZv/
 CqKrmuqfcYguRdY2244uP/DWQOc4q56N/vr5wV+cseSIagATn3/z9SnXRpea4Xu0XJmmTn3bVwk
 5xd4PS44Fq89JammdnYYwBqRC1xbAIP3JlLJBm9mxPCj0c+7Bto+ESGnWD+Qk3qBZ9eYVP/+qS1
 C7xeWNE0JgDgERK4jI2C1uhyH4rqzM+nvj+Bc5oAYwxceKFTmVgfDBKq09QY+IQ+Xgu3o+ssr6d
 EiY+M6AZqaGgZeLi2KHRDdPATpZu7Jtlb9eWrZPSuZOXlnWTInWYGNMiTWuZ0wSZTBxCrF84gXL
 /gf4IRikx0ay98tLFDUJXWd1hD3JS5T0EYQhFgRQNF7pIy4FYaw3PbhMr06KGLhITWsCseArDax
 YU2lnotXrs4AVWkv6OaRmx5Cf5YomN+8pSLc49rkyB9YsDShIcAtCWs48QPnISXgC5X/s/OIhkV
 fHlm2F+wX0fD4HDp0Ow==
X-Proofpoint-GUID: 4EYxBZUhmz3HAeZIWTBddwUoWxggBjJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120147
X-Rspamd-Queue-Id: 940E65229B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36324-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Tue, 28 Apr 2026 14:17:37 +0800, Kang Yang wrote:
> In ath10k_wmi_cmd_send(), the current code detects ATH10K_STATE_WEDGED
> and sets ret to -ESHUTDOWN, but still proceeds to transmit pending
> beacons and calls ath10k_wmi_cmd_send_nowait().
> 
> This can lead to incorrect behavior, as WMI commands and beacons are
> still sent after the device has been marked as wedged, and the original
> -ESHUTDOWN return value may be overwritten by the result of the send
> path.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: skip WMI and beacon transmission when device is wedged
      commit: 54a5b38e4396530e5b2f12b54d3844e860ab6784

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


