Return-Path: <linux-wireless+bounces-34192-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPSVI9DSymmsAQYAu9opvQ
	(envelope-from <linux-wireless+bounces-34192-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 21:45:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A533609AD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 21:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0913A3031CD6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 19:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D7639A7EA;
	Mon, 30 Mar 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I9Rs1njb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KUrWMDg6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89C399354
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899522; cv=none; b=uGEPk6oq5u/USpwPF8x03u7xGwVQ2uvIQLsXLBXW3SR9YB/gzMaHFiie+xxai//GuChy82BuI1ynlGZtkCN0Phg4fLdEBD+2P9alRclne5DDIXoo/XbdA9zJrVDP/KS9d/MhHKvi0PNCp1gO2D91VJnEgSSOXS5EW4+sEwWUNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899522; c=relaxed/simple;
	bh=zoDazKR4am3Qud2rzuiXX6B7CUykUfYjPLvMCjP39wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOW9y1EFfMqFkpUiYO577UQzPRHtQuiXdGTQEDYqoyV59x4+KUMzZKAYZVfaWC5IsNUlsOju3pHn0s2jdyg15deULcLX6CjKfgHRkqRjH7Bq8coomgHFDlXLevqTXE4BmlUi7Jc0kKQ5IGkNCq3pfYa9BlJ8pPBiWUTJfPMVed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I9Rs1njb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KUrWMDg6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UIwUF64053792
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 19:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gjZmNNPHmNuHOeGribBaDwRd
	i9Pdnrfn8eSrbuTd2d4=; b=I9Rs1njbL10R7SJ9bmaOSCSD9AX0zxFyjrsIUezs
	zIntxRO1qyFeHJo+FPmmHYDta050M1G8gkn6Sgp6ylVvuDRzyRmnh064TQXN1idP
	dgTW997pr5RqlJ98xzZ1Aoeg9bAL192jM+td6Wgz7bgd09ac6c1kuyfiAyeorxp2
	WMtfbmSxklx7vX4EHPYowZVn4WCt7KBbYKgOQASfy3Xs1JEmo5LbAkukLGgG8Sy1
	lkOXDVMeTJydV0wKpsdcRx0RwD/tpQ0+e7ldypunXffosvJ7PYxDCDkbi7hIoJzT
	Yw5lY84tTw6edpBZw6jDClU6DgQKKTMlro1OKy/dO/Lnkg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7xx384kr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 19:38:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b31cff27fso47413531cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774899519; x=1775504319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjZmNNPHmNuHOeGribBaDwRdi9Pdnrfn8eSrbuTd2d4=;
        b=KUrWMDg6nyIL6Lfp+u9imbRqmBJu2SWjjcaAA8pW1ynvLqMcV1vJen+veL60Z3YK2k
         5iHkxVqTnpzCa1kPPT7MSdSyeGvKXocvoKu8vYXRyM/yx4/EYyj6SBS65/nJ3/T3p/Ya
         GU7LH/AbP2fTxu00s5rzm5gv3BEnRwzCcuLmJndb3NBHGbdG8QlWsiFr3WwWrD71z63B
         xkggL5RcDnnGBdQfbQh5m7yPWa10B1FOrQdv2wiZNgoUI/Vy0P0TKJLHgPYJ/m064mKV
         LGHkW/arSgriOmONfQb6CRKIVtNlInPH4LWdkSyQu+wIUotjGV9U/E7k+tO8a8YG0ek5
         6Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774899519; x=1775504319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjZmNNPHmNuHOeGribBaDwRdi9Pdnrfn8eSrbuTd2d4=;
        b=ndHwvCsUuC4RuY7bDZwGakKqg1evwfUdk8wSjQ7LNN8j5YJihaHn9EhKLxl9YpNmk6
         TrPe4fYYiFmu46NSQYEL3Zkpfw1NAD8tornVwHhr9iraM6+Xjo9zVXRuIa/+/cZNIcP1
         Nzs14MzSp+sEtmiwF4Kv0prkEh2CgwKfoc/PUzDbXA9COIo99g09BrWZMYTNNBjdr4+a
         MHrqc5gr0ooIYbct/t6WB3se5PYhS4KLrY3zt7H8F6P2luWvQkGqDkuGzE355tyQOltl
         2Uj1LSwbYXwclAe08FYjA4YMjwbXQKLkQRVStCxDrp4hFAaabHI2aIi1dCl09Fy7CGcQ
         LArg==
X-Forwarded-Encrypted: i=1; AJvYcCWDOUONrlKi1TosL7XGN/Ohy3dia2HdQH8oHN3bdCKYaVXthRktauRgjXtDxPwbAwiVc4LB7Hw70DoW7gUjOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPZwmupsURZKfxv0h29wGkqtp6gdCoi67sy0kcg35L8tnk8lJ
	5N2fiEPTGoVCOOgngYl0367SN0VEmDNogQHKQB0+d7W6yXsHYiqeBvGqiyGm8F090iWUSi3BQbG
	xKnWX5ZQ7KBvZd0JaIrEKEZI8B/HqbiLajpn5r3119lachpHe8vaHb05LBD4rwTxvETB3+w==
X-Gm-Gg: ATEYQzyLRrVyBgm+vRuH/T2GODol1WnwUTa4kpTXbsF/cWlPQnZS7Ovz32JGhbZsEPn
	HuKngHMRrZzam+dKltyfelcMo2S7299x7Za6CWIbqTER2LtCGGhtoz+eAuyI82gCS8IDxHQtkHc
	lGB3xuiRLRTYraIMd8BQ8KznphF+L1F/nHYaQBrLHlHUF9cL38Mt2xB8DZpWOv/s3HeGWtVnl/o
	AtquF1Ei+3b5NO5OSeMTt3Gi4un32UfTn7HdI5lRsq4ewl8g0pFA4GJKacAq7rh/unt10KNaJtP
	lkQIrJN56zeK1depAuYYwMZphhJNJ9B1MKLQHthXOZOscZp6V5x4qEWNJyUPHjKM8CI1pP/hIEr
	sln5/4eN1yi6HPMJbpNiDk/xcV00sGL5U1F9BTtmYfC6ry+qYzbzyaSCPHJjVY+YhIcUu3JLf/a
	lGnQI66zOHD9BrX+Pog+1vU91ve85yDlf4B6s=
X-Received: by 2002:a05:622a:1386:b0:50b:1e5d:992b with SMTP id d75a77b69052e-50ba3960fa2mr187520861cf.54.1774899518861;
        Mon, 30 Mar 2026 12:38:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1386:b0:50b:1e5d:992b with SMTP id d75a77b69052e-50ba3960fa2mr187520461cf.54.1774899518260;
        Mon, 30 Mar 2026 12:38:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2b13f435bsm1845067e87.9.2026.03.30.12.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 12:38:37 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:38:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: david@ixit.cz, Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Paul Sajna <sajattack@postmarketos.org>,
        Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ath10k: Add device-tree quirk to skip host cap
 QMI requests
Message-ID: <zk4b5fq6qlduj4sthdealnfwsb7iphq5wform3mhaij7pcin3a@2dpx4yp3qxyj>
References: <20260325-skip-host-cam-qmi-req-v4-0-bc08538487aa@ixit.cz>
 <20260325-skip-host-cam-qmi-req-v4-2-bc08538487aa@ixit.cz>
 <c5tdbllqrxxsviv7m2i3xzweyjhetv6wbpgioddaitig3tm6or@a22uaizux6nq>
 <fd33e4fe-8450-4076-b0cb-f09a7bb9cb11@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd33e4fe-8450-4076-b0cb-f09a7bb9cb11@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=ErbfbCcA c=1 sm=1 tr=0 ts=69cad13f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=RREYq0h8bjQH8LoFo6AA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: A52261ncYKY_RSRAUoISElGmTqOszuLG
X-Proofpoint-GUID: A52261ncYKY_RSRAUoISElGmTqOszuLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE2MyBTYWx0ZWRfX9SQGHfzMpn4G
 lC/g+HJbBE7F6OADf0keFDMeWI+2ST0qq1QEX1c+YOyE9ygm/pUp8lj6M4nHVVMorDhDp1ZspSK
 StppaSMbG452pMXu950lUH1RF0+RhjjWxeCmkEFgGZgctfXu4oYdzQdi6dY3xmDrUqCrWyz+1g5
 iLRatwDwplVs6U84kCZmrx3ywEj+Lf2/H/9GG0M2TxrixvIG/jI3OUk1GjeL0JLvWk8oJheswDD
 7vVesExZuhY3HdxnE3bHduejnjkK8F1y6Y69ZV8noN4Vf+MmuTo9OAydLMiZm23o1aBmYBk8H5e
 grvQjAaXuRp/AjZmJnJKZEfMemyWD5KG1/9ytjOO+9CSWzMm18L2y+/0KzdGzqOWypS/nAOAV8b
 qYRuGTj6C2+UV1LGid4LX9liLVqt+ug6todA32E5bdnSxmTqm0JTkpMy+bZAEZ60WUZoU7e29HD
 ise3fK3dnS7IejacO2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300163
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34192-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3A533609AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:56:16AM -0700, Jeff Johnson wrote:
> On 3/29/2026 9:26 AM, Dmitry Baryshkov wrote:
> > On Wed, Mar 25, 2026 at 06:57:16PM +0100, David Heidelberg via B4 Relay wrote:
> >> From: Amit Pundir <amit.pundir@linaro.org>
> >>
> >> Some firmware versions do not support the host capability QMI request.
> >> Since this request occurs before firmware-N.bin and board-M.bin are
> >> loaded, the quirk cannot be expressed in the firmware itself.
> > 
> > 
> > Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > 
> > Jeff, to my knowledge this is the best approach that we have to solve
> > the issue on those devices.
> 
> I'm ok with this approach.
> 
> I need DT Review or ACK on the 1/3 patch in order to bring the first 2 patches
> through my ath tree.

Yes, of course.

-- 
With best wishes
Dmitry

