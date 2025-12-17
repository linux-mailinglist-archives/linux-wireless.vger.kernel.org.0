Return-Path: <linux-wireless+bounces-29840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA658CC8962
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DFBD33031302
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E733F38B;
	Wed, 17 Dec 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgBpYQ1X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aUAteGZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939531064A
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985885; cv=none; b=aPjUMjlKnjFouwktcKD0VANAkfsIKRb0CojRhXiH2OBwhLDSi86pFVSW4H85qNhZgP45HSJiEqCcX1UOfiSkCOq5Y6viYlbOaKEF4GzorP9yPMY8vgpeqxUbT/5fDNPuPvwRkeS1SrYQmsVOSNxsN7W3Ah/pBdeQDXH5yQfbPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985885; c=relaxed/simple;
	bh=UvBuPBraSuScNykRm41cie8KTLLTw5EcbxldAifHsNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI7SMCVoAq0K4ZCqPLdh5SrOz41X1b/3uz9wri7af2mHsUsBqMT9NvBi4CMZK08dmkL05gOz8LsnJkv3SpYwyQHrzbNYh5YA0U+IDIIuMb1i68s05yeES5VXW0/sweU+XNzy8TaJBLrUUBi1rrCnM+Iqf0Zqb5/9BwQnHmSCeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgBpYQ1X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aUAteGZP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHCKqdi330694
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 15:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LSGrrMOZDftVyShltOugtueXWriebHKj74tTN0kr5LY=; b=mgBpYQ1XiiZopXy8
	kiipgdIK+0akT+g+CVOwDxLiWK84Jt1lHt/sPGkwuJwaHcX6TfzqjluDd7QCVdKu
	LSR3MbtZoBOByVzg30z1+7x3ucO6gcKdVkQyO6fv0p3ea7omdrwYBt6AKF8lwt1o
	NJqR4pXkASkwBGnl9i3vMsTfdPh7pyJdMk6b3it2G2H6IAr+ZM2Hps8D/b9ofqlC
	2ZMb2ZFVF31CcntujWm9GJ9NTE7og267Hk+SuQ3VKpbfgJvWxuV2I74x1NB4akZs
	PWyAMCc7ACCBTNM0Dh23Qk7J/DXiryP9ELPpbmFkmI09iByTCI1+8iJUFLCB7ilt
	ocjh1A==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3t8e119y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 15:38:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bddf9ce4935so5463289a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 07:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765985883; x=1766590683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSGrrMOZDftVyShltOugtueXWriebHKj74tTN0kr5LY=;
        b=aUAteGZPU2OaNZLzQpNvIo5xcp0m/oE3bVV1KQGwhbRDHhovzkgZJWp1phEjE774/W
         0sqpME4ITs+lb1Qq9Y5QnWxaKH/Iw4cWegfXnM8yPOi3oeLsQj54k41f58K0vHWxwCd4
         ynUqFBp8Bc6Ly+TKKszIGKThOG+DY6l1FnrTprEgqg+S9Ehu/rLDl0rs1toOZyxYcLY5
         QzuBKDe9TtsjkXMzcVO40EiC8ewz0CMQke+Er+3wIzDuZHekU4AXQi0ZP2zBz4RDkvck
         AXYTp03VSlglrmzfoEgK5mN+5rsJcP1Ho2pr40VUN/FvYeQp4Nw0axMTLCajCeKh/YQQ
         JMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765985883; x=1766590683;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LSGrrMOZDftVyShltOugtueXWriebHKj74tTN0kr5LY=;
        b=qXAESo8GGkQIQdpIPHaiV+6j5feaMLI4FeHoTIg51vnE8PXFpSqPYwXa8Dr/woo/9A
         nyTrwzZ9U+bOimHQLKAHTg/oUbOt1B+o3Zesc3MUS1FyuDF3aV1kCwhugYhSCjYDdQp5
         oSzSgwp9n7Wew+qTUJn0+3gxSGNf+rXKg4D2QZHCJz8hMMzFBurGLHMe0lT6SgQar2Km
         xmOJus9XRVSE+Qu6WFQVOYa5JssA/hH/EimA5R3/gPo3mhNRcY7mGegmSOnsZz/mF2Sc
         m7iGQiWw5/0O9xAaWu4Az1DgraLVi+j+T24BRz5rFc/HQZXFWxmX9LqeNOpublNR9mRD
         HYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkHDDW6XNsyowfekKLgW9KT7iXie0FmWxJ7oBVhjaGF5P6eUOTACg3Nz50xlDIhmWLdCaoKB9x6bq9lABEIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUsGHzflCc2CTy0M3W1Sb9oYBHPmpEZDKFVNiZisAN1/jmQy2
	PtLnSoLMJur/t+gVmlkvdd3SpkCXR3CvpVoD1mEeLrhTZBCxkeu3Pzj8U8nFeQH6U0OFHIsy8kZ
	kKXRzq/hqHTnmjvnZ7Y4tAYjcpkM7yaJ/PxXqPdMDGjwpubCx4UhbcdUtOJYwWZ8TQVe17Q==
X-Gm-Gg: AY/fxX7b1IspVI98paVHhMxpKLLAYUshiLmYv7VMJ/VN/2YGWOqQ5So/AYI+THA3EsH
	BBEoMJFFIQF7l149gpv0qanBA0sVhaOH0HPFAZGZwmbkXUiu2SotCWelCT3eYoNQCBnOy9m1jvL
	lA6eE882BflLCqcTxG+Zul/+bRrnsP6MhLGpkU7rNGffAo/hnP4F8yG+yKci8R6nzvPStMIwd28
	yOVELCl/+1drk3DnI23ptqk1L9ElYNqBCk9MqVVb+N3KAGlxKeLK5laW760LOW8Unxjz4XKjfN0
	2vT/irevwK99g09TrnBUbg+KOrkmAXO9T79S2zRM0OBooDaM/gQRgz2xEs5lBYwWjpXtxnR2X7y
	1wUdXlLaz4OlEuhOrMvLfArtsCWsYFN4MBbiHZkGGHocLL92od60xspnxDYcwaUsc8hhUrA==
X-Received: by 2002:a05:701a:ca0d:b0:119:e55a:9bff with SMTP id a92af1059eb24-11f34c4ef22mr12350776c88.27.1765985882612;
        Wed, 17 Dec 2025 07:38:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuYhQhTKxvcnoRTBpYREH3wuizCXsyRtb+/Rc7v++l/oc6Rv3Gfgj3rgD5AsJzw2v+k2058A==
X-Received: by 2002:a05:701a:ca0d:b0:119:e55a:9bff with SMTP id a92af1059eb24-11f34c4ef22mr12350751c88.27.1765985882084;
        Wed, 17 Dec 2025 07:38:02 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb3b4sm62197815c88.4.2025.12.17.07.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 07:38:01 -0800 (PST)
Message-ID: <3fe689f9-c434-4c3c-a8cf-0b8ab65153c2@oss.qualcomm.com>
Date: Wed, 17 Dec 2025 07:38:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtl8723bs: Add kernel-doc comment for
 rtw_reset_continual_io_error in rtw_io.c
To: cjz <guagua210311@qq.com>, linux-staging@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <tencent_BAB546E9C29DF17A0E3BCE8EAE1428D88206@qq.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_BAB546E9C29DF17A0E3BCE8EAE1428D88206@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyMyBTYWx0ZWRfX18Sc/0XNNSUn
 huO+FQKOzt48aLdoGpWXeyVBw2IbPLc5lT4fDik9fqU29G+oDUdejNpUTyFmYruNum7HW5KYD2L
 LWlEcUjG57WdPjDa7QfEG4i6zCNZAVgMzJMAFkP4vCK9kJmDktES20sY05NyjLOR29NQZ6LTci8
 xgJ4hLFvjKTpY1lmk7Yqa2hvX6KwMASZaDKYdO/EkHlGVzrWMXawG3r8AHg+Jg2vQA7DMDU0kwS
 mfflzCI/a9DPIFZtUTYRmRZFoLgbdUjT1ElhGGNj/p7AGXWXGA+yiulvheHUUofXvcCXxRV/LXV
 p7HqkqKNsKBBeDhWxWVV1iuZkdEbglj0OOhQsHqlx+x42slDU4q+y050WIAjIYovXLGXriTVImv
 nWqVYZ8fzJIvasZ//MrF/WsLFXOeFw==
X-Proofpoint-GUID: x8FGZKfQPrkbxo6m175Ez-9JAK3fogPb
X-Proofpoint-ORIG-GUID: x8FGZKfQPrkbxo6m175Ez-9JAK3fogPb
X-Authority-Analysis: v=2.4 cv=EsHfbCcA c=1 sm=1 tr=0 ts=6942ce5b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=dZbOZ2KzAAAA:8
 a=o4_jF1gwsiqNhuO3VYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=D0TqAXdIGyEA:10 a=xa8LZTUigIcA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170123

On 12/13/2025 10:16 PM, cjz wrote:
> From: changjunzheng <guagua210311@qq.com>
> 
> rtw_reset_continual_io_error lacks a standard kernel-doc comment and has an incorrect
> parameter name (dvobjprive vs dvobj) in the existing comment, which causes gcc W=1
> warning and reduces code readability.
> 
> This change replaces the non-standard comment with a complete English kernel-doc comment,
> fixes the parameter name error, and keeps all functional logic unchanged.

In addition to Greg's comment, please also review:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

In particular:
Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
if you are giving orders to the codebase to change its behaviour.



