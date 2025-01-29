Return-Path: <linux-wireless+bounces-18163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF9A2228B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBA3A711C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D922E40B;
	Wed, 29 Jan 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="an8cMbNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E511FC8
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170720; cv=none; b=q2JT3Nj7jJ+GVK6YPrjobKotmQ/fl1osSJOHkms7mlBoNx7ohGDvu7mPg/9lCPEzERlrb7aLYhMv3M+vzWm/wQcMo9nKm8B+43q9X+/M8qYs8DIoc/bXJ8OObqeAobLgiziFL71HMFcUy6YbXaxRXC4YdwxUIWX+nvBJkmjNsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170720; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=r1epBv0EJAYKf/J7XteDNGlkjPp75R/fZmMSwkRViZnvlpAI0AottDHYr7fs1apgfaidT+L00UOSkNw8ibOb5b0oWMyuuvq1ce197e/cNuMvHrzH8WtgxvXIkJV3mR6AddrpfiALN5PvZOnPY2c/1wiDtnxj6JSHA870vXd9wgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=an8cMbNV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TAbvDp019029
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=47DEQpj8HBSa+/TImW+5JC
	euQeRkm5NMpJWZG3hSuFU=; b=an8cMbNV5snDHM06sWCzE2zJ61UJXaEmLSndNz
	pkUEjLnTTZ1p5Kh9O7kWN/81qBV2B1cHRSjFOg6aysGzj3IBKA7+J2YatnapO0dO
	ZF1YDZ6gBsP1jJMprtv0HPKv+ZDSC8DqBBb+hCC90bLkgVsbCb9cuCY0JmLgyQW5
	xNO7TzoTg3WX/5ASPSsPV//1ozgpm7d/NLFoRUOozdUCZXt1slWZVk5JoCGniLcu
	fV1ujZYN8SUo30RKtNKhQYRWPOcgkyrq20QvCLxcH0lzYU15KdOGL1PKqsdrmhLs
	YYZBSCNo4tWUIYd5YMKBiXtQNV9tvQVow6FZwGctLW5K58cg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fjr90t4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:11:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso14033260a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170717; x=1738775517;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=CAEdG9aJEjixfdi1y5TOVyN7qD5GlF7DKEd3ikTD6gfFi/el5DzEx9WPGsnKaJe1dK
         0lcL2m822MoK8mPQsSIXT4PrjAJd/7zDNbAkezKkBAzSncmQVhN3ooglf7krCx8StZA9
         4HgFW5VII+2kjyNJRp1U77yuDGHhAbG5/haBZUP94ahuOJX8tEPuOEicA7sDgIijUU+Z
         IwpvvzCy34D9qrQoZy7RXdG/25HoAk+toQJ0frs9oe/0r0Mj8awzu+41u5YpvAegZpnb
         7/MSQchB07f5HcK3xiF2hk2orsL22yPKQ0AdwULNTYaagfFRIpkpdNotTZtaQ7cx3qA4
         8x0Q==
X-Gm-Message-State: AOJu0YxcHkuGW3F8EczSEF6TZAxPOXl6bS4R0zKFTpsKuQ6ALq8aBiM7
	bOq88QP55K+kq0gSQLraCxjsiVNQ2funSFjujRDJOzjuC+PQPsR5BL5K6CJXqqUwQ7GRiYmIhb3
	x/TtcrkDQYRQ5qGpQ7LQYZ+k+e4HLM3ahTRp57jqD8JpANct5NWHATZ532vaLxe1FgbIrl5SRZg
	==
X-Gm-Gg: ASbGncuTBbUO/JVhriTn5oqjFq7aGRUDiRhSB+boxNwxp3G97e3iED2foXYx7yZmUvv
	v7urwMiA6z0t8HzUiF83NjKzOUkF8V0YzLmguadZvnl6RaHhdSOHgDPHkERRu+JcH9MSgRQeDBu
	patSR+achsZ3Deis9JJynzksHoz41bMbrdW905mpY7s0TZWUFutwV+Fjo5bKRM3V+5e4P7xvcgi
	ftalLq9CE1xZeEPHrI6gGPoKiwsx5+HDxpxWAN3AqwQswT9LCGsyfKpIse0vEtF8tfraom9Dpu0
	+qn1tHRt5BDBQcIKcXsufljWJbEpTepMREtPC7uWeBNCok/XgvBufQ==
X-Received: by 2002:a17:90b:4ecb:b0:2f6:dc00:3af with SMTP id 98e67ed59e1d1-2f83ac8adedmr4573476a91.34.1738170717287;
        Wed, 29 Jan 2025 09:11:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNqWaxeIbNHci9IBOESBwDeJ8IgZCAw+Cioh/fdWK7B2fJSjD6e4ryflGoqNYhOA4F37rFsA==
X-Received: by 2002:a17:90b:4ecb:b0:2f6:dc00:3af with SMTP id 98e67ed59e1d1-2f83ac8adedmr4573447a91.34.1738170716864;
        Wed, 29 Jan 2025 09:11:56 -0800 (PST)
Received: from [192.168.225.142] ([157.51.187.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83be1bafdsm1988475a91.35.2025.01.29.09.11.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 09:11:56 -0800 (PST)
Message-ID: <43afcf55-2deb-445c-d4a1-61e5132c02cb@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 22:41:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: "linux-wireless+subscribe@vger.kernel.org"
 <linux-wireless@vger.kernel.org>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: join request
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nvFDDL1zSu1kZHWNlG-2gUFAqvpyHNhQ
X-Proofpoint-GUID: nvFDDL1zSu1kZHWNlG-2gUFAqvpyHNhQ
X-Proofpoint-Virus-Version: 
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=473 clxscore=1011 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501290136


