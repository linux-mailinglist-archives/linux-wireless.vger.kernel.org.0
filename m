Return-Path: <linux-wireless+bounces-35119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEhABUwp52mo4wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 09:37:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207D437B2E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 09:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E27E0300C343
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3523845A7;
	Tue, 21 Apr 2026 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJS8Plrx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RiE6q68r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E034CFC2
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756484; cv=none; b=jg0KHJlXn8SlIY/YJAQgjSXXqHXWEY0OIL14E0QDRwquNiYkXmQmizjoH6jFck7/vlqM/sAktBaTlTD8qKX9cAGLcDR+dbo5dT+SwfhdJ1ZCyrLaYyYNoro5osXkCAlHAeTY2m6YH1kjfNhGgwhcjerI4qJuQWYkwPlM2bOHLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756484; c=relaxed/simple;
	bh=O7q5fXr0V7/bGYJbsoGVEcvkd/XnIyDF32etzYwJIuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQOP5XVydSepITgq9MDGOuuHnCPfDiU3zpwBWsIfMDR+x7o/k1FfiCtCaIr7YySi9N5XOPRtYpOXXAo+eZR/AAoCrPk9onfEhutz/4od76DTYZ0VkfTbkj07QUxe7j43dgNk2qHis26sOhpU9BHHvG6V5ICOiaNS2AZRD1fDWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJS8Plrx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RiE6q68r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L6eb5p3574522
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 07:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPqpfOWqyDYIF6DBaSd1/JPEZbu/kYvM6kZKGAp3xwY=; b=dJS8Plrxau9v1LtM
	TED6JlR9l2dmEmicOOl+M6v+HIidrrXIoCMz3/1Hu4646wxfL/Gb88/r5DVhvJ2w
	S0g5IJBcbZV/vU8Mk6TuxtaJLkEB96PZISIQbqYd8NwKQI3yjV6NVnfQFPIDVtX8
	0blZcPA9CdiMrSwvBj+s96jTefISiDmwRC6OzH5RTehA5z+mFLpUMMYZOGrQjGba
	F2x3RyZOmF10cqPSeU7PtrmbeJKdOZzAySZGX8XOkildEN1iNU0GUFDszs/K8lLE
	hma4aVAIGwB4EmRF/KAKH49AEJNBl0RVLZwjvJBDjHIfowPKjIs/K4prlXi74tan
	+wijGg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp465g6cs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 07:28:02 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358e425c261so4515701a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776756481; x=1777361281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPqpfOWqyDYIF6DBaSd1/JPEZbu/kYvM6kZKGAp3xwY=;
        b=RiE6q68rhvZSqrF/605gZBBBz0IjUxPifVH2el7tRm+XMrdzT06HRM22u3MFLvh++b
         qkywfNLvjxcYQBiIPufBai+GJCa1YifYFsmxfti36D1JKxPGgI++BpD2c0Ozq22Knp1W
         ro72W3c44BE6NMu+9GbqydRB37oxi0yOHCP110w4El67avemjLNHeosBPM55UDzH8IN/
         z6K3j94lO1tyYXPRnq24lBM7UKKqt1LQZnwpvK4JAv80y7k46W18OyYdaf0yEHui9p75
         xQXqcFmgaS/myGhVK9pXmLG7sINMb7iBUUkBbGceC7Hf9qX+XiMe1Kk8+rCUYHQNBgj0
         ntKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756481; x=1777361281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPqpfOWqyDYIF6DBaSd1/JPEZbu/kYvM6kZKGAp3xwY=;
        b=nI4ZhXBdcLmFNvTXqAUr5mLoDFtpzAurFu+LzZUzHuEzSTzLvY4Ofj+tE7hX8VlM/G
         knt+N4t+3zMRPyjtwKVuusbHpWA8Dxra+cVgPNweuZUntk8pTRs/m/5f5X3zLFika0u7
         +G0Q1Q8Iscd7Wur/DCw7pnkJi9n0oan5zEMy7Hh4VDmJdDk5/zHwroES3rM4VX9Y/C4M
         84IFJlhUaC51jPjktwFSi3ALLPfVm5bU1mV3UmtP3wzc5Ynv0vYSmHdZGqnt9uyjB1gq
         shHG5wrN05/n+aeISosP52eRDJVlY6jIGV0yjKtPdRTea9rHDqqx6syKgJHG0ckDvaZ6
         msZA==
X-Forwarded-Encrypted: i=1; AFNElJ+m7B2tkj7GtfEL/SNCbGEY0onkfCG21WvRcPTN3+wq0dOMmLSQ/6FquZlVf59DU7zptpwdxcKmJL92VtLuSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEnwR9EsDonFQ6XomXNgeXP6guCypbe7zf2DkiLSDIK2WoZf71
	Lk1XkjfoRITMPYQB+UiG6V+wMD85eQfOowk7JAR2Vy79CrI5uUAzkuKG6ymnnI5GcGRX7Ezn+W2
	6U/hZlo6Gp7+j92CFXwDYSv3XDSbUG5o4gO2jN02S7mmtUA9BeHiRAizPumzFkTPxiYZ0Yg==
X-Gm-Gg: AeBDiesmD8Tpo5dmtPIUnsikeW9ZP5U0UkDKTSk8gpsPpdMFJsnp7Cd/AhkSA3WFTJ3
	Bw0t81RHrndsH59g4UtJbDeAvYTU177sfY5dwN1jtB/nv074otShX6EjlfOjO8AkY9JEn1sQ03k
	XQwGR+Hhx8W3ZJhSO/7RRPVA+SojRW+2N8sl+5+KE2dE5TKJnynF7XrINYOyjZh5AJd2bhtqMGC
	GkAhmVQ2300CpP6D4cwxQO8vb7YOItrAXIsMWmSpgpQzQMg/yme4b5qorr0lIF46mMrrtyf73Fw
	0oGAq9oZh7d/7MjsLSwhZlJ7ljJuay5XGRnqOzFtgVZZP5J10ra3qDad8SEWooNeatTQSVORpid
	lOgedlH9vrqYROY7LHs3AS7HX1TpFNnFDdbOaS9jC2Kdy/4F4ZirqcduzaEeCzyQI1VLQL9dE
X-Received: by 2002:a05:6a21:998e:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3a190ef81c2mr9209467637.33.1776756481556;
        Tue, 21 Apr 2026 00:28:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:998e:b0:3a1:90ef:7e46 with SMTP id adf61e73a8af0-3a190ef81c2mr9209438637.33.1776756481128;
        Tue, 21 Apr 2026 00:28:01 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa40b2sm9026838a12.13.2026.04.21.00.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 00:28:00 -0700 (PDT)
Message-ID: <7c89f639-fbb7-43a3-9bc4-668c16631ef5@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 12:57:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: snoc: select POWER_SEQUENCING
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3MSBTYWx0ZWRfXwbOOewWdgZPV
 DxCWSBJ/Yygr8UoBsKAAXAtQgSfGE6j12RFnVZ27mDeusnJg2Y3wTiHVyhB4JfRi+LS3Je1ltlS
 i6jXLQGHi8TUby8J7AjblO8Ubpfz2xaov+N1SFxdDg6ZxRj4ZgyGHSxqFPqxqtqE3rggOySIt9n
 nRag7nmyFBYJ4dFZKcqjzowfse7Qywu1QMi8K1gA1/dkQyolwxKTSVmWPN7rJ14o+XY2cgezWDi
 dxzN4pauSWuGDg2ch+FvjZBzmY5jiu05XebUbtfMnricnjZyU5z9x3aE9FrTyr/q7R6VU4WkdHI
 2b2+xbId2jk4B3+qJQeyTVyJ80SVpVv9EunmJcUAiVsLE6RvR+hQTBX3J8zBLFq88ZLx4lzG8kz
 LZRWpH7QZkygp5R5KWvcmdIPUAYxOutawOk86WBpOXl/KebfiNQpJlG2pivYj15Jv1JNTucfW+z
 PAEuYspCfnxwVQLi9yA==
X-Proofpoint-ORIG-GUID: fZkXlALxaz_RUOfsLcnTGhBUn_-IYWla
X-Authority-Analysis: v=2.4 cv=YOSvDxGx c=1 sm=1 tr=0 ts=69e72702 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=zpRtp0WXrNfT6zHCYYoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: fZkXlALxaz_RUOfsLcnTGhBUn_-IYWla
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210071
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,fairphone.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35119-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1207D437B2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/2026 1:07 AM, Dmitry Baryshkov wrote:
> The commit afcf3ec615c9 ("wifi: ath10k: snoc: support powering on the
> device via pwrseq") made ath10k SNOC driver use devm_pwrseq_get().
> Select the corresponding Kconfig symbol to make sure that API call is
> always available and doesn't return an error per se.

  “doesn't return an error per se” would be clearer as “doesn't fail 
with -ENOSYS merely because CONFIG_POWER_SEQUENCING is disabled.”


> 
> Fixes: afcf3ec615c9 ("wifi: ath10k: snoc: support powering on the device via pwrseq")
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Closes: https://lore.kernel.org/r/DHUHU7UIT487.139L3KIVRVREU@fairphone.com
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


