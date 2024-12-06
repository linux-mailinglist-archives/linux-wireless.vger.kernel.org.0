Return-Path: <linux-wireless+bounces-15989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C19E79D5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 21:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B422816C72F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37F1D95B3;
	Fri,  6 Dec 2024 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1h+AfyO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E91D90BD
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515617; cv=none; b=XpNVOpzwtCmtf4b8BILuhE79DPhqbUpUmYn0CCoG95zprlfuT3ERlmOL0NFW112wLcZaOA8gN4GT7oVb5xxxTEmsogFtJ17XYJ1JN715s8GJor3e6Zau4KvqFkqO28SfY2KHtNRuXP1oAFaJXjqyS8uPAG9ptPCYYGeLLrwqJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515617; c=relaxed/simple;
	bh=jeulAPGQM9UxEUcb4xuGL0GiG+vLrh0W2fMLyPffguk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC0jMUwdLPxaj6lAgiI3Ht7UHF6IQKUL5cxqDCEVYnq7qSTfXcLSrculqO6qyUk5tDgJTKcySfPcuGUFSQIcVYPphIJwdg8KqIxMNukLYqEnd4NsWC1iL57Txj9bE57fUkH22YQ4ZfWnA54LoYfS8bR0dgwCnjrCyBj6VB0w58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1h+AfyO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6I9gPm003807
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 20:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KKHquatXccdUE/8FhYJaY/jFJDVvrfnYD3Ug+2HTmy8=; b=S1h+AfyOjqMTTgJ/
	gr+qYBj2xjNG5oh1e2IfKszOwlRWkENgmKr+99r/VoWXnHVMnuzfx7ZDkiw8BdFg
	ydB21ySmgyf0NnVpz9ZCNCFphUNiLBoKRzUvx7h4pfJSqdxyENO8NFgqf/g9wsCj
	4BqVfo8+9ChWx8sDwx7Fa/ItophUj+N6hy9DyEBLvbAermapTb5b4ZEh6p9TS212
	j3ysGxPMUn25LE+ZSC3m0/8+rudAZR89N5z6cfasdgNtMhcVZVhcexN1WhgpCnFZ
	ptcwNvGic89qIDMGo4srVuKOwO9hIv7t8ignhA13kKZcj1lqnZzbFaOd1S7oQobU
	srWnKQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbqm4ns1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 20:06:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2158e335544so18277285ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 12:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515613; x=1734120413;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKHquatXccdUE/8FhYJaY/jFJDVvrfnYD3Ug+2HTmy8=;
        b=wqFlFNjRr7HchDyars+3vHMEMEUxgev9C+ttOZp0NxGnN7J7KGgvfGnlLHDtJH+mS3
         tyE3cWTi/AMwx2uRxMznw8qSpMXuODD0LC57tXdk7ZXgbEH5TeiGHkgLlL1d1DUlrDCl
         p8VjFopO+ENAOpCa+5MScWozeXw2ByfoNM2oTKiwN5I3wW0skOmzv9q7OIclvmpdKXne
         JCwMSBEVXKWTdHct2B5W050+MRTT8qww5EiG58AE6Ol2XK2SC5aENZn6JQ7Y7dLRzBdA
         nlgCLcQtIMEHr02Y+UkS7bopTqioEj7EQ3amG0eYBZnNUUK0gDlFkfBZ1KVDZ38UeZkB
         3GOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSWrW5TMEhW9VR9QDUh2aZzwz1mXgJ/affhy06f7zwTFoNTAW0zov5oQXdJ1JyQmK0Xp4C7hK+61MweYNuEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6x8KtWNzsMfqoaD/XePOQMrTuWoGWLp3YVj4b2FbgSOFPxxt
	x+i6KHE4McsiKa9NmQw7p56rceWDQz6AX8NkW+yRYlRNlmTbV48plYgov7m3hk9m0tzgcDnX+NU
	zg4fKQbtrO+Fl4u9hGF0Elvvf0x+GCHuN1eR+Zt05yHPW1l5Fhf2oHM2D7q0V8kkwhg==
X-Gm-Gg: ASbGnctMHPw1NI74BvFZY1r7kJ5fjRx5rMUk2g5cJclNa5yFtAk+kWVMpNirYlfReSq
	IczvoyPrcbIuDmuF1VNq7teqfzdKOjIr9Jm55J25bgDqPPo3pnxXoOxNRR4csC11esNaBGcLS9a
	OycU56Atd5Ggu6rZhQghg8ej9QclFd5NpZK0SIW9Kv+jSb8on39IFYQYqC8jmUlySAHldpskm9v
	adpDXqDHEgb5xOFPg6kKpkWR3QAFBx4ENeE26NfeqM45fPk+HLa27c3HfaeplrQszRnotneBI+u
	4xna1RPIf6zztYr5sMjczZwvOLzDVWshBLk94wwwn6w=
X-Received: by 2002:a17:902:ea11:b0:216:282d:c69e with SMTP id d9443c01a7336-216282dd891mr11067695ad.23.1733515613499;
        Fri, 06 Dec 2024 12:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH09o+jP8XVNXDbXOcJarG/czPCA5tRwQQW5YRkwI50Z0sDJXkcLgUikTDd6q1KEnYVPVQ8cg==
X-Received: by 2002:a17:902:ea11:b0:216:282d:c69e with SMTP id d9443c01a7336-216282dd891mr11067315ad.23.1733515613088;
        Fri, 06 Dec 2024 12:06:53 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3f0b5sm32531665ad.20.2024.12.06.12.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 12:06:52 -0800 (PST)
Message-ID: <8c019176-6bb5-467c-bcea-10517675de7d@oss.qualcomm.com>
Date: Fri, 6 Dec 2024 12:06:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: ath12k: Fix out-of-bounds read
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, kvalo@kernel.org,
        ath12k@lists.infradead.org
Cc: jjohnson@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241206073542.315095-1-dheeraj.linuxdev@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241206073542.315095-1-dheeraj.linuxdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lL8A0Slysz6V4mm4W3wsdw6lO8n2Beqp
X-Proofpoint-ORIG-GUID: lL8A0Slysz6V4mm4W3wsdw6lO8n2Beqp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060151

On 12/5/2024 11:35 PM, Dheeraj Reddy Jonnalagadda wrote:

The subject should be as specific as possible while still fitting on one line.
Ideally the subject should be unique. So at a minimum I'd add "in
ath12k_mac_vdev_create()"

> This patch addresses the Out-of-bounds read issue detected by
> Coverity (CID 1602214). The function ath12k_mac_vdev_create() accesses
> the vif->link_conf array using link_id, which is derived from
> arvif->link_id. In cases where arvif->link_id equals 15, the index

How can arvif->link_id equal 15? Does Coverity actually identify a code path
where this can occur?

> exceeds the bounds of the array, which contains only 15 elements.This

nit: space after .

> results in an out-of-bounds read.
> 
> This issue occurs in the following branch of the code:
> 
>     if (arvif->link_id == ATH12K_DEFAULT_SCAN_LINK && vif->valid_links)
>         link_id = ffs(vif->valid_links) - 1;
>     else
>         link_id = arvif->link_id;
> 
> When arvif->link_id equals 15 and the else branch is taken, link_id is
> set to 15.
> 
> This patch adds a bounds check to ensure that link_id does not exceed

See
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes>
and specifically:
<quote>
Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
if you are giving orders to the codebase to change its behaviour.
</quote>

So this should start: "Add a bounds check...

> the valid range of the vif->link_conf array. If the check fails, a
> warning is logged, and the function returns an error code (-EINVAL).

again use imperative mood (log a warning, return an error)

> 

Prior to the SOB you should at least have two other tags:
Fixes: <refer to the patch that introduced the bug>
Closes: <the public url of the coverity report>

> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 129607ac6c1a..c19b10e66f4a 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7725,6 +7725,12 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>  	else
>  		link_id = arvif->link_id;
>  
> +	if (link_id >= ARRAY_SIZE(vif->link_conf)) {
> +		ath12k_warn(ar->ab, "link_id %u exceeds max valid links for vif %pM\n",
> +			    link_id, vif->addr);
> +		return -EINVAL;
> +	}
> +
>  	link_conf = wiphy_dereference(hw->wiphy, vif->link_conf[link_id]);
>  	if (!link_conf) {
>  		ath12k_warn(ar->ab, "unable to access bss link conf in vdev create for vif %pM link %u\n",


