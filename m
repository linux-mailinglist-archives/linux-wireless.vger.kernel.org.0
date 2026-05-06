Return-Path: <linux-wireless+bounces-35981-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG+bHpu/+mmaSQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35981-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 06:12:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C980E4D6100
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 06:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5C3300F12B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815082DF152;
	Wed,  6 May 2026 04:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gAuw1tQY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMlwliv4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1424336D
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778040727; cv=none; b=bEM9OTJIiuhRLzIJ/G4yB0PpX6WsZD2Y1Z88IN3sySztGoAVoRMdJCnvmqPy7yhYOVTkC5PUe3EmNjODXU4nz8XPxeGuDYgpOY6KiQ47W9PG7CTJv5Dy+JiUmjuR8M3Ur8ltWN75IiMpla6d1w6Z6TNr8r34XoL3n20Z8ZWtL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778040727; c=relaxed/simple;
	bh=QUn6JRdzrDtlJWGM0Fbq1T1QdXiBYVdv4cFLsKZrIuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJfZyPs7+a3DS1spCwQcxP6rfeVawNg6fcMRmoyqJJudwQ8Ud4Hjo414rmVcMBrOmbJmIpt0BFzeT9MZWxyAu5qNdZdhG8jFlr7u63axV3yXcJ8LYq9HnDs3n+PD54/B5wA/qWonkQARd+RNqRUyhuMWZXkouhNNFtR6E4A8bHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gAuw1tQY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hMlwliv4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645LQmn33475717
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 04:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ApIhgmJhfKREvob8g8jJlOKGq0+fY73sRo3QUzHyn+c=; b=gAuw1tQYnvF2Ohb5
	YB98icsiAsuAr/ro9p0T/Fup5sArIJqGQkBJEyIMpCfqve1+QjmoYO3Z3CNAgbek
	CLXFnH0etSkcoat1aY8nWmxEJoF/04E4DQlQ95ytzSt2fDD+mVhGNzVixTmwwyeW
	4sjoKxRXYJsLtsEM+WHEHiaJ5pS7fjB4FzOQYGL0zd8SF9aRkCtvb2UNyE6g3PRZ
	sBlECmCwhiSiVCWfhluouMwFyoOH4/oPBWrArv6bdt9jvVvngkCevrCDmOlHbwKk
	fIZ+rWO/FKrDPYY51+9FJYnvjePq1DyDrfkhnExvF6CNkG86pZ2lBRZKpnyjvugZ
	gDPmwA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgu0q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 04:12:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fc22424d9so14236276a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 21:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778040725; x=1778645525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApIhgmJhfKREvob8g8jJlOKGq0+fY73sRo3QUzHyn+c=;
        b=hMlwliv42RflwmucRBONgtyZKp2ImdkotvpyL3wK+8TnIF/E1ENaUpWytnwv9odIWe
         o5CvIaa+BDrjzCiQ8Bq/aSLWr+VZPZsnDz/TMjOX1Vkqn5z75W/cpdQv4VZDlChn7dlH
         muYLftPrlYJuOWTD6JKp6aR+a4393nQJbMqDokUQS2Qpoy3a/E/6M5Z064UyV89n1vYI
         gTeFY4Y2Y1u3XqUCuXFAKJJPYyhHM3/yDgsVGs+c4CYYo9+swAQ35LHOR2eMn3Xye8Di
         UxR4DRRq0VX/8FeyzEU6iZU9mMmLjL/Q2gY61NUFcstW+oHOUOVOi8OQbuOw/khO4WUG
         CZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778040725; x=1778645525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApIhgmJhfKREvob8g8jJlOKGq0+fY73sRo3QUzHyn+c=;
        b=kr4VcRLwpVc7r5S8HJ0VUGEpavuEyLEdFRTIOggtvF9WmnBr/8DrAGp7Wyc119+K9Y
         1YzWl1LJDZcZ0B5jNj8nCJt+Mhyl3Z89L7rruAPiXj1ekCO+Rh49spJjpARZcXlMaFqi
         LZJDFeF1O/loW06XjuCAJ9cMm/9D7DreOKxoa7xS1AaqPxHH8liTjfDW//CWRmARk5fj
         QBGT5ZQWY0CN8amrf3sutg7SHegDO5M55T3sJaO9AT/3WF8Gd4Qz5R4oHdxueQuN+wCN
         DMYaLORDgoUsJRyFzg3LhbU0/EydaLOwtDmgWyYIIVqWUhPtDqn7vhKnm221Qs7SfMGw
         59eg==
X-Gm-Message-State: AOJu0Yxl/jG6nU59UyEMLrdxiMOTvPFvQbbhISYmcRELDz3v1moBVIBd
	1Dx15aZ7BZRFUT+bSmDZ3ARaubkjdpb0ax8sRyeAHvCHgUS5JDxwJsIpfGFv3EOWI/A/xPr0DDw
	MgYWOjkJizpjfdwqsEnz0tvlcflLmR+SMGCQvVCaCL8TIIU3IsdorbfbgNY0snXH17xZaoWLsje
	mvcA==
X-Gm-Gg: AeBDies9WTWksLGihoW9FNvW20p8tnbc+0BQUgyHwkkWG1s6uU/myYks6hNyCSgeH14
	gjzp0PJ6c79uAOlpCg6Ns8nT+TPTcuAWT82r7cJhjMJ+bfvadHN+OU9Nw5m3rJynmrPTJBFzVh2
	OzyLRSaZ/92ngLbEpg9+nJSU2QWkU/5ZYPtfCCfyaATRLhyOm23HkK1Ris2Hl+LvoxhpBJw9U8a
	/wkF+uJSdJcQ4FooCNEoS5LvvSQRIzvz0lWaOe8Y0z5o9coLIwFZ8xp/UA0E8rkPtIlQfn+RxHt
	gMbDwOs8P8RqMixdWOBaiiQ78BI2dLKYK4B+0kpNTSQ8uyx8MplMCp64jhDlOhIiup1VJ0JxxfK
	qDvJvxlBv8ghnmKsRT0AbKoeVIka5+Dh4Trz9wYeWudHX6Y+zw+ClPw9B5BFOb36YeNd3VHi/
X-Received: by 2002:a17:90b:254d:b0:35e:57cf:c0ae with SMTP id 98e67ed59e1d1-365ab9c8160mr1749883a91.7.1778040724635;
        Tue, 05 May 2026 21:12:04 -0700 (PDT)
X-Received: by 2002:a17:90b:254d:b0:35e:57cf:c0ae with SMTP id 98e67ed59e1d1-365ab9c8160mr1749854a91.7.1778040724184;
        Tue, 05 May 2026 21:12:04 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7b77cd50sm8485405ad.0.2026.05.05.21.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 21:12:03 -0700 (PDT)
Message-ID: <fe058e9b-4d59-4bf1-9fea-32a3ff256a8f@oss.qualcomm.com>
Date: Wed, 6 May 2026 09:42:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix use after free in
 ath11k_dp_rx_msdu_coalesce.
To: Willmar Knikker <willmar@met-dubbel-l.nl>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260505171709.547274-1-willmar@met-dubbel-l.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: P3Mkmg9TaiOFsoESCyxSLz6RkVFTW9w4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzNyBTYWx0ZWRfX9ikDbDsxO6Nv
 EZdBxx/SgVRrGrJTWlKcXz+A5c4si0z6tnj/Acy34tWHlKfcU4Rb9RGnkSF+eybu4/OMzswEBaQ
 PuB7ygNLZVuJ6Q+iWxXeFit5kkSmpXk7dd0gtjs6f+knkpYlLRJsJJqsbjgfdiRxqSDvD3GZAMq
 hiwBRQq/792MWUej+yjHrpu2gAtb2Rx+aY/eowq2saokdMuTxF1NGznVgr0xTPGUrGYxZnbrp7M
 OVE/OTFoTb+LjHbfNz3OYfvVAhx9JDjoBJHdbUwdz9XztTjh43nBcXq+qaQ8nvgLvuEh7Qifg3r
 N+OmfuKBC3GIo0xXhtMX3FeOV07EwvcPY3MYUUAC0YudFdONH9869eQYNxT6nGNf44JYbM19KPX
 XjFtHslTjZsX/Q8LcgvpmUMivbpg6ZgTWcJ1jdMwoHEHyBgh55pmVdwdT6U1N36Dm+HpnnE/4BU
 hu8V6CosFTvWUHtq69A==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69fabf95 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=9B1uR9gGAAAA:8 a=EUspDBNiAAAA:8 a=ljBxYmjjx4en0H8xEuoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=8R3p93Tjo66ouot214C2:22
X-Proofpoint-GUID: P3Mkmg9TaiOFsoESCyxSLz6RkVFTW9w4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060037
X-Rspamd-Queue-Id: C980E4D6100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35981-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,met-dubbel-l.nl:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 5/5/2026 10:47 PM, Willmar Knikker wrote:
> In ath11k_dp_rx_msdu_coalesce the loop uses ->is_continuation after
> the dev_kfree_skb_any. This can cause a use after free kfence.
> 
> Use flag for caching is_continuation for use after the
> dev_kfree_skb_any.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Willmar Knikker <willmar@met-dubbel-l.nl>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

