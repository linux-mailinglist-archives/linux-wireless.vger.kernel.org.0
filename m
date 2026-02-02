Return-Path: <linux-wireless+bounces-31460-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCQNGq66gGl3AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31460-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 15:54:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6321CDAB6
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 15:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25A7305EC38
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1974E55A;
	Mon,  2 Feb 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FYrm22Tw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ViQpIbFD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBB35E53C
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770043588; cv=none; b=NK7T5Ej2hRT7w7kyTHCF4ZzaQve1UyDIJwn77LD2NPfdvlEww/KyvlU+t2lSk+OgSPDCDSHaIfFTybDKT1MFVlpDQXF99gc2KGoJHgRJEzAAw3f/0C1ctUSTx982YWoXHi8LakS19Vaia3HeJG4h9D2fT31P00dWh5XAAHblzOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770043588; c=relaxed/simple;
	bh=8/+ySLPJ29WRASALectHdbUxfIyGT/kd2C6ota1kGDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIPjwAondxUgpxA5ubQCAtaYIuH/aHuobgCc3EUngWVlS0z5RW9V8x6HLPE28yL29ODGSFjLX7Cqqb4JxIOVZkrNAQYPwZ+6qmgQhwZSir5JeAAsmAzav7vhXa0vwcVyeXIL7cyTA+FMhmcYnAabeOZYmOU/cW7OluCtddDO/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FYrm22Tw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ViQpIbFD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CoXZo1033417
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 14:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3VCG7tgdR/MS2RUKOVyv4v+b2d1lEw8IVopwhKELH70=; b=FYrm22TwPalF3RzK
	cTPRqh3DHd1kmKTpdx4gKijGd5wKX+s+I79q7UOEAKvV5VDqnms3rSVJdtbpGjW0
	BjBAnlwHwZMh0HMEbfKJy62fRxHS+i4p/lvSNOaMQEQ6+/burVdUr0/Iz6p/lAsB
	mXTL9WCi3rCBmhTJ76wI+WGd0ydzCV0MOE3xpWf92Hnjy5DU+kjiyCr+kVsAaea6
	O8FEwkwzwvZKB7vNQM0z8E9hA+sSwvgxQu1zYpb3fJVMypr32LudX7/2sWgUFHHZ
	6NrAizku17JI97nGUkNuyPRtwvbHHXE1d7X3Vrgq2PT9AxF8eye+PWRd1XEJj/f8
	0cpfEQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c23h1kfwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 14:46:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b7eddde359so1866773eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 06:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770043586; x=1770648386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VCG7tgdR/MS2RUKOVyv4v+b2d1lEw8IVopwhKELH70=;
        b=ViQpIbFD1HQ9CX1pptbXp1x31YnGdx18SsGX/2JLGn1R+8iN5TUzgWUR5OI98FxxDd
         c/f5exMlnZiQYH8hfkfVnayY0tQ2OoDGIuevTU8/EANT/KcTz6MCrWyWlSDEUtWiCzT0
         0NtxS1baF2LVZDF9ByLMqJnCbBnZ9YQ9XFEuBCYkzPoDy4bB9zCzMPn89qcZXgGEsWR2
         8nllJd8HdQFUxL4RVEUXAgsSIG6zTsGPw8mncDn8gTG7dOrW/KiYnKcBPxgbHJPytrKS
         gY2WMlxjPL+bo/2NY1WsBReqfxJXf8fhQAxdzysQmKWmx1OzqxuX++7cQAcqgStwOAzE
         1XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770043586; x=1770648386;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VCG7tgdR/MS2RUKOVyv4v+b2d1lEw8IVopwhKELH70=;
        b=Fr+r0Rreh/0T6gWA+dEx2VY+IyGO13n4ZZ5KHPjbeEquivwBYi8h6MQCKsO3FvwzMh
         F9q4wK7V1CIqeg76+vgXryNR9fP8MsQSOhynamXw7tq8rw7yVgNhKVkG1hUrx7kj5HuH
         UsrGzzFpWarZaZx6hwkWn0571tVPvEzrBaaD8upci5dpYMjNc9UI4e7r6x/tmpH9f9PU
         hg/2wCXAhnUaCy/Xp9Bn9vxmoRbK+b9XNE6iwrguF16e+xuKm08uSY4g9ALycemeicdi
         3WtO/4o9WB2AEqcFKW5UY59aRMkhx0jhjr5/knW6ZiMxr9Hum/5TfFe6jdn1rSUBzKaL
         /fAQ==
X-Gm-Message-State: AOJu0YxcBRt/JrmkbXBZ6QK16ZaXZRXXftHN8BiZsbd8DoNaQmxnHT60
	8LUtE2mXr7ei4VA7cJ27Q1A2QGs98CjifCmrlOGJ/MOYyBCcftsjd/hnANRF0ks+3r9GA4wFzSr
	1DQNf7XwfKi9AjCDJzmQ7dFXD4k5qxisq9lcpVg90xwZ0Z5UX1/iALQHTGHGLO+CNuKWwun2z0b
	CJ8Q==
X-Gm-Gg: AZuq6aL0DYKYCZuGULDemJVqZmPIf8UGiBBFUoaYmebVRzw28voUMDbKqA+bGSZS42A
	aXLmN+eFZ84UXnzTHrsy9R/fd89g5VtQ7unEuwDvxyHiO2q1qkkpp7efX/GZh4zR6/W0Tf4WHYR
	Z5ZlWpxiF5I3x3O4U/Erf2zK9LjffgeJx/C/ihYinXK9GKuzVJz0gJbBX9cV22GJsgwX348eIJn
	vzpj2vFzp60z0vtSY1pPx7a/MgBVGosr3vaYEI/Y54OgvMSHdNoLEUdlZp17TG6FWZ9YLSumytF
	hiLsYYrrg27kY1hHkuezfaVNQRd69B9YPSa14tTW3/50rnD5Ha1XSpVob9k4I6yEJY7fBGL/AgL
	T+jdXk5PndE0rcE1juu2+Zzutt3OklJSd1V3nAc39pOb13NzSFOVvw9EjW81MLpGyJOvDBg==
X-Received: by 2002:a05:693c:228a:b0:2b0:507d:c2e5 with SMTP id 5a478bee46e88-2b7c88d6439mr5519347eec.22.1770043585553;
        Mon, 02 Feb 2026 06:46:25 -0800 (PST)
X-Received: by 2002:a05:693c:228a:b0:2b0:507d:c2e5 with SMTP id 5a478bee46e88-2b7c88d6439mr5519318eec.22.1770043584570;
        Mon, 02 Feb 2026 06:46:24 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add664sm20360406eec.26.2026.02.02.06.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:46:24 -0800 (PST)
Message-ID: <73b08128-c7a6-48f5-aa14-5f1991ab733f@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 06:46:23 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] wifi: nl80211/cfg80211: Allow RSTA role to be
 enabled without LMR request
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-2-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-2-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nJl7rVV8_tnA-4VXwbH0I9a3mS0b0Qgo
X-Proofpoint-ORIG-GUID: nJl7rVV8_tnA-4VXwbH0I9a3mS0b0Qgo
X-Authority-Analysis: v=2.4 cv=Fu8IPmrq c=1 sm=1 tr=0 ts=6980b8c2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=7a41k92D3haJMkWbbVQA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExNiBTYWx0ZWRfX4QJU0NxKnRnw
 kKAu7gTMlO3TGKP01Oqr1+DogK0Un0SrFYlHyQblBBPHAXX/EtFK/EO68r5l3Uan/9qft1vEPNp
 TA4oVxMWhW4BBHBvwROTDuhcXwIrc1dQ87/JU/nUKYBsqTNvW9E1A0WMoFlMHdGDwlOy0BUVCpQ
 P5KmFYWIPPC9XhHb/P+yOsJhFbjczi/Up4uJitsikcDZ3QKYdrq8GU+fbePbl2vo79QZ1XUvRKo
 KnocwVzm0M4SSEjE9EiaxlnqvTz6KFymOLuAjUSspvbxlM+La/7iELQ93xp5NmdU6zMBjwHuyCs
 nKV/jXWch3cGmoRpTHWcaSVmFq6DXDxmB8EzmziKz9Ye2AS7j59O96musHotoENJ5SxcdyAskeC
 HYmUqk3+FWIlDMylfI2fsLNsq6DqikiVvRyY4VzF61aF11ufTWQ1o8kwcIVEFyJwKDU2FM1jNtD
 A4vGRutfRH7eToOx/4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020116
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31460-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C6321CDAB6
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> The commit 853800c746d3 ("wifi: nl80211/cfg80211: support operating as
> RSTA in PMSR FTM request") adds a check which mandates LMR to be requested
> when the request is to enable RSTA, such check is incorrect in cases

this is a run-on sentence. s/, such/. Such/

> where we want the device to just to act as RSTA and not wakeup the
> host with measurement reports. This commit fixes this issue by removing

use imperative tense: Fix this issue...

> the mentioned check and also updating the corresponding documentation.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>

