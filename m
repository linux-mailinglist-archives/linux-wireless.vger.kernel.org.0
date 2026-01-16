Return-Path: <linux-wireless+bounces-30888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC0BD299A8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A49830C26A1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C428233507D;
	Fri, 16 Jan 2026 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dCCkReSp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMdIbE9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D833291C
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526825; cv=none; b=K4JxzigJJ+B7262iBkXn4fZQ6GbyXarOTLNY1PqcWsVPY8YykTDgtbFsqg/SrGzPfeF75GhPJs9MGcK+PcvOJvhCa9eXU2fstraO8EmfgthbhaQbem1bMMSH9DWyMxokialLKI5fWwvY60p4sE6rv7q4TZ+h7y0o0pmIG8T7qD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526825; c=relaxed/simple;
	bh=0EOwU5Q4a8tMOpQNCK3DeU9z9BGjLexXTRniDQ4lt+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=epuQ5BEcPCiD6GzvKd1mPwR4SWu0Mb3lBIVKvpXvZuJsADAvvVt+pLzCEsZi/K2EteYdYovj6PxiLHwQU4UB6jiOtyP2AZn799MByX/SDNQoD7VnRrnIcL5HnupUokGPIzpneBHUR+gqypCqOLnuhtdN2lX+0n9Ad7RoJ+UfIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dCCkReSp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eMdIbE9N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMbZou3596324
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r+6d39+s6dTYxyj0NTH3yTUuFC7R6VDaHgjfMbR85Ec=; b=dCCkReSpe39t6Eum
	xqUnD+YK3FfV96xw7NpVnl0RfpKsWLeYzqB2cVlcc8k0VKmJJFw6KEtwyqjEpR3j
	ANsPbUot63RrhPgiP8uiTz0GooCYh/TP2lRkWxIxoYKuopOlFB1JBVqis0AngiY6
	t8bzbvVF7WpQrADiptIMsFIEXxxtSV4BWwGEnXHbU22Xs98ixRPlt/qtHV8CgDM4
	q/Z3cYIGZXrhTRj+kSLCHRD5lhoXeIjfmmKSvtj5Ij1Hln+0+L/56JzOQvAWpU9t
	xVW4RK0mwXZHSsp7lNn5kPAUckvVtnnOj7efy2z3OnfDWaz8ge8YfHiq8fKcVuhq
	DRdcAw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq96rrb6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b21d136010so2548818eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526811; x=1769131611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+6d39+s6dTYxyj0NTH3yTUuFC7R6VDaHgjfMbR85Ec=;
        b=eMdIbE9N5WykZMcZp2P97kpjF+2Ruxi0XpJVlDMd8CtM2jwCQQQPLrksseP6Vxx/ir
         DIRB9gXNNTYknb+mplrPjsw/EPCRg5f5+s2EJTYLV2B8ZlVsCP6x9n8tMiNJCuwSvN2W
         e+Rh09g4iIVxvnGtvzh+51SYFqWt22x36A8ralcbAQDcg3iolXxQ9FNnerWV45dH1aiZ
         1ET5Z0vU0Iy777aY/kpFr8jTxkliPVWAWqvfk4e1TxP/ZY768jtm9/m8YGtz30ujYIMH
         uL16bi6VVE5bs5M1vh4kDCQbGYZW0ig715fTY3I/QGRsF4uRg2LUwh3SJcQJAnbZBGtd
         sn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526811; x=1769131611;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r+6d39+s6dTYxyj0NTH3yTUuFC7R6VDaHgjfMbR85Ec=;
        b=rLw9sHb+Xrhn5x6g6mxoTawSJFrPJ3mKlIH8WIF6DZwMkfcrjlvudHw3GhODqv7QHp
         Y2yTWYXtBKxKz/pFNCh8obBc2MarAYE6OkImx7odwyVAYpIqDNuXpuzzYS3XFzBTp+ON
         kdgH3AWd9z6VIDVV7dU3nQTjRQ0bBnF8ykRt24EbeKNmUwLWoQcFsrjBKI7YMXEbQtgV
         NB2IifkjpXrfisMFM6LQY91pJzcHV0XN7e1EdO3iiNinBUOxE/yQ+9A27cqOmIHjZEUP
         ph5LxQlvW+iWDZnVAHcYT+p3g5voIBHvkmojO1jrt6WuGkKw0k9qkrSpct8JcvSzV/db
         bVUQ==
X-Gm-Message-State: AOJu0YweDacx12Ovr/7xGNn3oVQRYXr76MbNUifZMhNr3eVpwJrQ6v8o
	wdlfQgcJEVK9OFnYRJ4x2qPV29awFnvZ/oW14jkQ1fUDQiap22MbbJIvsFE8k9rBl1cjKd8kfDU
	izte3g+dfyY3PEK+Z08dRbXIjyYtgevgbyogPLv+Pko9WMxwGu8WwAhgNSb0y7ed+Ijzm0IEAox
	rGQQ==
X-Gm-Gg: AY/fxX6asBoNly6VSQOzKl4OvQWnVAaJBDliYOGzHT2B05XP9jj9+FfYJ9JhQelwmMQ
	ww5IPVTAXvxjnEYGDCeK5wUBLPDer/34vGjs8WDuyimH31aM9ohUIqMX3L/MhUqT+oElmAe/n2E
	SoD/g3XxDpQ6KH74+nhXJrp+fx3OGN+jzm9xigRjFigDTdJk7DpqAoFD85u59uT6qmoEdHmRgXS
	c5hX01KwG3OuQKN0ZPZEp3zt5IPO7/cF/enA21Vs2fiJTw3MRKeSlCHysWTkMFxBkcEoAskjlQ1
	M1CuyIfX4HoBHnuzS6xx9DTb5UOlPtfJpujD0aXdgSFxI3U1L9hR3g1Xj+Law9HRt0raODpgkzF
	d6qCH+ZyOTGp2wMyl+ignYJd3bkcEattR/QLATsv09qbdlL/Of/eMfJL+s5BeJkWL
X-Received: by 2002:a05:7300:d12:b0:2b0:4c71:6583 with SMTP id 5a478bee46e88-2b6b40f46b3mr1291259eec.34.1768526811151;
        Thu, 15 Jan 2026 17:26:51 -0800 (PST)
X-Received: by 2002:a05:7300:d12:b0:2b0:4c71:6583 with SMTP id 5a478bee46e88-2b6b40f46b3mr1291241eec.34.1768526810608;
        Thu, 15 Jan 2026 17:26:50 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:50 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20250802000432.3079550-1-rosenp@gmail.com>
References: <20250802000432.3079550-1-rosenp@gmail.com>
Subject: Re: [PATCHv3 wireless-next] wifi: ath9k: add OF dependency to AHB
Message-Id: <176852680989.1143034.4776567291414555856.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX7GRb6M+Uz4cJ
 yKkTcqy33Fckk9H874Q4Znlb1wQFHEraEFtjKVvhk8I9KeP4jk/A+RrD9WOPYZdmyA26v1KH6jj
 ve6vUERtPna4ZQFXOMfQ5pHBWHVEXvelJtUabb8DDHENd8SvzC0Upp85bjpkDmihGCFC6JWcPMI
 Xfdk4bPeN7xD6fvCVDQRDgrV0IPqE1Tl+7ZddYeDcw7lYYKaSZ/J2sdak7WCGgFa0wcef9VVWFE
 2pZY4IOMr42TW24jjAgbP/iJTcUXI0owmWMGROCYZb3cEKUpO2x9IQx9hXhJOLXQdjdzZDVbFy8
 QHR9zQOjXEi88S+P+PCZoUK5oZHMu5ql7D/hL9MudX3qooXJIo/MtFb/7RP9IipCqfdDfv8PkDg
 HQyff6dFzGis/bS2pKGgBC0hQIXnBGi9L71sy3wFmJVoI89hwLwXDfMGNJGbEy/F9lAjz0R6wLb
 VuS9gdECvI7Zx1R/QEQ==
X-Proofpoint-ORIG-GUID: 0ur9Fv_7kVeN5Oz7jAB_dYou4ZgPfbtK
X-Proofpoint-GUID: 0ur9Fv_7kVeN5Oz7jAB_dYou4ZgPfbtK
X-Authority-Analysis: v=2.4 cv=TsTrRTXh c=1 sm=1 tr=0 ts=696993dc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160010


On Fri, 01 Aug 2025 17:04:32 -0700, Rosen Penev wrote:
> The conversion to OF missed adding a Kconfig dependency.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k: add OF dependency to AHB
      commit: 125e7b31f041cc0a4ede1e42bef69915f0a63a35

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


