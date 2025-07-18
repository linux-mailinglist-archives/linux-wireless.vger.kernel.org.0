Return-Path: <linux-wireless+bounces-25671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680BB0A93F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 19:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F828174C67
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 17:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4519066D;
	Fri, 18 Jul 2025 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBhSQX8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F04503B
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859022; cv=none; b=JlYIB39U05WbH6sPFbLb03qa6uSIWYox4HgzjxVqJuZw9yXpPwAzoWjaOX2lfwH5vGPM84/KBBFZjzkuypU9+bo4RQmLInk6atoPNB/3oraHYT3PxuiZqZ+ZYCRAsEkzpYQTHw1zrbK6yqzGvjYv7oRlRcUPG4eJqnHpTHWTo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859022; c=relaxed/simple;
	bh=AznNe3B4cSI6FxNefl6+IPT2MLjSeMi2pipB9ggXjaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJdJg2LokgGjccSUy3UUyQ4f+8MAUrjTkO2uEze41h/FZomGJLP10AdLmu1Vnr2CLx6MGukE1KYmCwAwb/rDNvPLSOEZRtGT3BZNeoSyBfT1twDguXqsTgDCOkrr6AtF3NdJZZH+vqUKzyJkp3ToDwbTCJV1g2loVZsbFH6tdAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBhSQX8n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IGY6dG000552
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 17:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4y93XaW6JaQ9ODvB/R/LVNhQrngjeK+yDygDAvgQbyQ=; b=FBhSQX8nAJ84PyaH
	Du7Gq9dvJuc5iAoif0gQLyU+gt88MeFLJh3bwxaHlLML0cBruLk0TgfFQInuPEjV
	uciqXuJ70XWrhxitnbsDt6aOQ0kA15hvhktcwv2AU3Pqz7ew8F9Bz029rA4oLj4m
	KLX5ktsUE/hYW3PQelqI1VYmKBgAUMuErxaCSmZ9t3WfOd0j879wq9xsCIrxM2xJ
	byE7fUQ9Ex6D6IwjjzYSWKhW7LZ0UPpif18sbKnOR0ety5jIA4ZCuUqQX+yU1W2D
	W7mjKYoslgFtBiT1KHyePy+T2VK+PZzxPRHeOBaftju9RDwOazaJQ84aDS2+yCu7
	1p9GaA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dryeup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 17:17:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso2380390a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 10:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752859019; x=1753463819;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4y93XaW6JaQ9ODvB/R/LVNhQrngjeK+yDygDAvgQbyQ=;
        b=QJ1rcN6+DcYvKneDIfXlOlEzJsZePkdmAoZe6XPhzZ2GZb3v7LRick7sfdW0fUKR1W
         jQudmU3Y/nOKpUgFzAvnMtGN6JIxb+llUMfeIH35ZqWIiZZ4m/NG8KCEFAozUQisLU/x
         Zgm6vUAYVyN1MyUCJTnS0+6urIUp1jtwnT3iI8YYEHz49a7TcrOEps5holXuN1PZTbkU
         VDLxHMAZU+P6AJww7waKOgN9MVDb5ozjF5ftKEjc/0NLRpW3hXYCDMBW2JmJ2vEEUdML
         txBnbhjsUWBdsooE7iPZdnNomB4Jl6Z4r0ix3Gr0cTAqRdmP9fraCL8YaVOTfFmjpv9y
         zTiA==
X-Gm-Message-State: AOJu0YwlDh7OiYORetk+radPyTDPPI2uO2KCLKxBHuKAOg4qm+AjlxL5
	nNQtRb8xGgnEfKwWvZoe3z58n7hhIMy7y6lJJ5n57Nac6ET1zm9eys1SUzQQAwmxnCGSF88k9Fu
	A1mVooPqe7GMwbf2tQo4XbWGJh+aHYCpaxb7g3/iq+1BMmO5iWJdK5kWFv083niA7JixqBA==
X-Gm-Gg: ASbGncsgtw6PCeO0aYyxiKOWcQE/ICZzuO45NoGxe3Y6W4Sm2FKibGbfvhxQREVuhiV
	wIxlI30iT9af1CnP+bNzp2xtaGShrSJqB7h4M0uh0OkeBfJACflpk9POgOyrxWweDXGuiwywv9i
	5rb9Ka2Baw8y14QD15SFHmR2GcWPUUhtT39AoAwFRWwj613PbUfgNhgOpfd0mWVpYUL8g9QdRKz
	Z60Y0LitYkndZCwIj+p1KA8/5p6cTSsx++WL1mn0sFNlPfXR0ABb9jUqpGPETyUTF5HdJjpaVld
	4BeiGU6gpLD0eiHOl7vGa76UBn+YO3AuMWj+FP5pI/21DRzin0OF/62CpxHaP0xOcIEZXhCVjQm
	0VQtuU0DakD4rfMIKQ7tfVW6383g7CNSp
X-Received: by 2002:a17:90b:3d0a:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31caeba85c4mr12419962a91.13.1752859019492;
        Fri, 18 Jul 2025 10:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOF+lVUcNSLOiWyxXFXA+cXwuxrUbxYsmwp7LemIwe7xNnYGs2CArSmGnMtoIDzBKVisqbBg==
X-Received: by 2002:a17:90b:3d0a:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31caeba85c4mr12419920a91.13.1752859019043;
        Fri, 18 Jul 2025 10:16:59 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb7742596sm3040325a91.27.2025.07.18.10.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:16:58 -0700 (PDT)
Message-ID: <991a3e75-9efd-47a3-9063-a064ca747e9a@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 10:16:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 1/3] wifi: ath12k: Fix the handling of TX
 packets in Ethernet mode
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250718025513.32982-1-nithyanantham.paramasivam@oss.qualcomm.com>
 <20250718025513.32982-2-nithyanantham.paramasivam@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250718025513.32982-2-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GaLdehlf0WfcWCnDoRd2ROYhDMeO8pDQ
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687a818c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=CTZ-dOqDz-Vyge5Vj4MA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: GaLdehlf0WfcWCnDoRd2ROYhDMeO8pDQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzNiBTYWx0ZWRfX9cFXKH748K6X
 WWSX1mS/Ka5NO1rk9L6xmLSxsJNYVifrQfCOFRXk2oqFlkVO+H0AxnRY/WuppZnEuLsk+y8FE3G
 KyaeTpbw6POl8W2RkFU7xZCianOhPPJok9sPB4L6QhmbqDI3AAznDEoHnyr8h9DOZao/bHr1oAG
 2qlGUcLOCCi8ikEqi5wFhTfmhfM1Wjk1awFUcuzB4Mobs3kW/ll32PR+Lf/LP0to7x1+I5a4v2U
 Ph1Da6tutjvjcPT0sspJnHvcwLW4Ye/CwS8evUZUgN47wWhWow/DRsDr+41MxPkttDc4k1X752P
 kAAvX5cJh7QV9+9xNIki3BMunZ5cJRWtx1h/P1LbcfgPABe/rvYA7yVSetdaBFf4TQo7IROh9c1
 b4ltpFCAcDH0LN4Eq6nrT96HfA2zOFAtg+Sy3afxes/l9zbUvqrjuyojlf0sE25GY9t7T00w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180136

On 7/17/2025 7:55 PM, Nithyanantham Paramasivam wrote:
...
> +	if ((!test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED, &ar->ab->dev_flags) &&
> +	     !(skb_cb->flags & ATH12K_SKB_HW_80211_ENCAP) &&
> +	     !(skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
> +	     ieee80211_has_protected(hdr->frame_control)) ||
> +	     is_diff_encap) {

nit: this last term is aligned on the wrong (

i'll fix this in pending, and since I'm touching the patches, i'll go ahead
and change the { 0 } => {} as well

/jeff

