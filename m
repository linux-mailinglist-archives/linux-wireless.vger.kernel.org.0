Return-Path: <linux-wireless+bounces-12450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89B96AF76
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 05:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550581F22E22
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77879A59;
	Wed,  4 Sep 2024 03:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TyeWXUCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A541C6D
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420811; cv=none; b=ZVliqZGl2KVqwAI4OBengxQmShcuh9ODbGDYnWNzC8deyfH0MNUt7JPkKABpMC5Fh5s67GtWwUUFysWgcC1/dcOkW3YeLuFtHOenX7AdvxdBIAEdHENpSm8wj5J5xT9cIcb/+H/1zd5Nu++pWEx4g+gqJJuQcQTm+G1p6vaiVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420811; c=relaxed/simple;
	bh=+Y+kFw3bctubb7fzs+OyPmwyf2sF1FA9ENTnmsllTUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NHvJzN5P8zFyouvZFZWQ6fsyLNS7JtSgb7gvvwKQhzqkSw3xBLYVy8fjg9OzbbYQ8iMfdD1tK9o44IsA+OktdzY9osCf8+SSZlbyT7Kur7CofazhA0Vhb3R/Kq98hMAAT7fct1pcPr52tsW3f/ZUz7DZA6cOXSLUW66v0DgR3pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TyeWXUCV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483L6t8j029764;
	Wed, 4 Sep 2024 03:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jbS0+ajT9uoX0LrcO4Eq8CbP8QlEYFeCamDDH/uwIQU=; b=TyeWXUCVYQ8fc1Fd
	CaCobFdEKjwQR2FRyn0VP92D38lBlbkfFezb3gCht766HkFQ3K15oY/jcYH50H4E
	1KUAovnOu0jKKP2Cytt+24R9Gc9bXqHStf0KyX6eMrbeFYGPvwN67xyyA54evnhw
	7S9rnLAsqCk1uOwGlC2Ico36RyvAvsZP48+5mXghk0M1vSyjubkzYc7HkI63TnbC
	PQhz4cqjab4OOMm7/6Aja2x9XoqjJa/t/RQvODVePvrbpKD0l4GsZv03pEQY8KfD
	3xezL8h053Dfok2VISM0Qavx3MJK3tyybWpONxZK6i4hx4JIA/0sfeiWlS5ea+bh
	run1Fg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt4rhfpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 03:33:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4843XE1Z011465
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 03:33:14 GMT
Received: from [10.216.31.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Sep 2024
 20:33:13 -0700
Message-ID: <56ebfcc3-d104-b09f-2164-230bd5234914@quicinc.com>
Date: Wed, 4 Sep 2024 09:03:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] wifi: cfg80211: fix per-STA profile BSS entry issues
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <1718009524-5579-1-git-send-email-quic_vjakkam@quicinc.com>
 <ef80a0b77fcab051e256deb310c725d4d8884fbd.camel@sipsolutions.net>
 <a0a6cfbf-4538-1be0-80a2-4aea8a656555@quicinc.com>
 <835984452bebf8d61e9f9e36c31f6cc408441506.camel@sipsolutions.net>
Content-Language: en-US
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <835984452bebf8d61e9f9e36c31f6cc408441506.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: joTTBBpiNjogqe-i0RbwfrBMdqP8nMQe
X-Proofpoint-ORIG-GUID: joTTBBpiNjogqe-i0RbwfrBMdqP8nMQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=595
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040024


On 8/19/2024 5:57 PM, Johannes Berg wrote:
> On Tue, 2024-08-13 at 10:19 +0530, Veerendranath Jakkam wrote:
>
> You want CONFIG_PROVE_RCU=y/CONFIG_PROVE_LOCKING=y I think? I don't
> think my config as is would be all that useful since I have UML patches
> too.
>
> johanness


Thanks a lot for the inputs. It helped me to identify the issue.

I submitted the fix for RCU warning with below patch

     - 
https://lore.kernel.org/linux-wireless/20240904015520.3571295-1-quic_vjakkam@quicinc.com/

Also, I submitted v2 for this patch set after some code changes. The 
above RCU warning not applicable to v2 patch set of this series hence I 
sent the RCU bug fix as separate fix.


