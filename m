Return-Path: <linux-wireless+bounces-38452-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uXQWIAsfRWqB7QoAu9opvQ
	(envelope-from <linux-wireless+bounces-38452-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 16:07:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0656EE828
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 16:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=D0TYYJLh;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="J/Hzkdi7";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38452-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38452-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99F023234FBC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 13:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2648C3FB;
	Wed,  1 Jul 2026 13:36:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0248BD32
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 13:36:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912968; cv=pass; b=dJkMYE7fE7On7BX88qZ4OxZOKJ5766XN0GC/9+SzH98NFUEYKTp0wwIMn9JuAgKGlZUstkMogGlK6DHg5a4vdqKiE44XIOS8+rATyZrMu/PIe8opTNG9l36cY4KeaSkC7l67IPtRaTkrDKdCkOoFvgR8PlSMiSIAlQsedXn/8vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912968; c=relaxed/simple;
	bh=N+n/R/mlFs2wkRiMkBtopMW3wGbtfZ47UIAhPinzCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoPyDn3tt96EuqcjMGTMObkOD3aK7ZjpTDUbgqAW+3W5c7dyhMFAxoHIp0tCMB2e3kLXGcpgZUCPuw8C0ewdaGSUP3s4SLRKlyaCW/+NHxRjPwCnvrVsetcO9SOD0CC03Ti6Xb2aw26Fi2kx0y5M3+UTY+Eq7YelRav8K2/fnVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0TYYJLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/Hzkdi7; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8hSX683260
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 13:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=; b=D0TYYJLhf1Zwu2jk
	spVTvuXD1DtrAeoeC2o9zHuxnGi5L2oNStqdVlMFzAka42qve3FCqsZ0imRiSjGS
	wY7ttgiTuQozDBsloMvMWMZ7rH/qOR9G1lDsmLiF7+3AQRgTZm29mCqmNwGw2zKN
	vUeqWlghwM2RkTREn3uRhASvg6bSZRMNTxyjChtRcJbcOyj43Bn47PrPRgooNtem
	izYRe/87MwRcAlgJr+M4KcqpvbGLoJprSrbUKhtWlVLLmIPX48qaTHAE596YlbJv
	Qs74Yv6HObEi99FocjmPI1rDGZPAdejjSZRzvLFUsQfNCiXq1CiD5iYcCYaKTrC8
	PAdhXw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqmgt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 13:36:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e6ed4fe99so125681485a.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 06:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782912964; cv=none;
        d=google.com; s=arc-20260327;
        b=LMe+CcMHUX8nIABhlyMH2sjfdl+QaZP+9+3Fyb7b0/ndv56ZOmP1aCYA9Ro8qfv/5U
         qErbNXmz8/UtifvwbEHhAG8FRHAU5eMy9ZldGcs+DifmVH2IsqtUsayyIIyh5gvYrRiI
         8umRygDdSagLH5Q8N+zw0HzrsvF8Jpu0xNWVvafNpxLmrztvfupQjh1yY8Q8t9obUlUu
         EXSl/+7d4J/Q5U9Ll6J/gh4/DmJXvCQLA///g561P94R8FblnrE0bX2fZt7fHddkIR9F
         Z614vgpJK9kjzZUvAtck9a3atso8MIMRdDuGRIBbW10hbZTVOYlAqmaMEPaoIyp1kgmY
         l4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        fh=9nPYmQbIdJpfQjuK0uxp3oYkn6gNufQvSkqtZobvQ+0=;
        b=HpJ0V/EUei8m+935AtPZirYh5pA+oImhws/A2uzt1HmjzvcgD3cmBii1n6mt5IhRG4
         MDCi4ZtnDnT8731eHprQxYjN6eARgdta8xgLP4T4WOrUSFoSM4X+fKT2ZvWzClXIG8+Z
         ldhJQ0h9F0qTQgzjIPm7+Om79MDUrkSLeXeoPrKVYfpSglNOOIOqyrvZUq0I71rI/LAi
         SWl8MKpGEARD0187abTaMLZFONm6OK3hEUyy2a3O0BJA1rDPouaoq0VlkAWOREetBSuW
         LvlbT09BLgoxs63m+GombM3kkZeXUGDBknuWORh3WCTPt3Dl5MOFwvlTZbApLbnZR7iV
         CTFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782912964; x=1783517764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=J/Hzkdi7UAfkvQ3JS+pBNsS3Qmx4/AV7Wjuw2Oh8ju62IMD4QCIsi8DVpTbiouooBM
         Rcm2GJbEmdUbxy+Tc3ChOTTQm7hJOvM938TBwM5bFgA4o2C2AO2+lMAO5TMybnLRSHmF
         QLShWKLlcjvI5yKmQ6Mwu4jxcPhKVXtkg+uo2PRdBGokaoUPmnFlQQW49W+GI91P/mM8
         737P8Heu+Qg3/8bZhhpaNqZxmFsxiIS3IqmrucpJR22QrEYxEOYX4bOgxfGLNUTycXxA
         1HWSCdbIzTxZKs7dwvsBdnBCIeB2WMujN8Wii1CvgsQCQmMwEdU3daGY5Pwffj5LsOHs
         hBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912964; x=1783517764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=sSCwphCpIXau1zDweaioeIJL+nGKcWcFPjHzfxuy6VR088eWirJcMM89FQveUQvpoj
         gUNPL8ISZsC86UwymPstAZ+RXyb9cLl6btG4V33FqvlnfGQHnAxUYIzDuDmAi3091E6p
         QQbSppVnJcs9lmckuEbC/1KwqoypGk5+DjJH0nsRphMtNuUgNhjBOt/A8rgQj9oDJdw7
         1YyJi+KSDhxnwXUjWv25Ut+Eo8/PWEIzob8eIo8Sb77AKqhMh1/+KreF7j6ERdjj5pjL
         VCPlZR6YCFiV+2CE/iv09wiX+KQ6PfFK+GRWIW5b1Hd8MW5VHWmYvSfBbrOXs6Za7Nfj
         Ohjw==
X-Forwarded-Encrypted: i=1; AFNElJ9s2Zz/t6/pp8Giw4ljXCZdh8WapxXVjfZGbITrJZjDgQgKdiaBIp4HzgzTgcXJvvAdf6Zq8WRkc69KRiuUuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3gqNy8l+h8ev7vcME4u7LsGMPJu0Bd9FWOJ1ElV5y3l3aWnI
	Bkk2hRsV/vnHsR34ladgBFUlSiW49xBdKcIWU+2t1GBJyIKIjtuiJtxvt04KBbKrgdetwS/moV2
	9uhP9CZbCbN072EOcfuX5HeeYNZ1cKl8i/86pd9Gq5vDvLnugNxqbLiYkk37IGPlHsUgSIh9Cto
	0hBpgCWHYOVk/s8eUWFsYZ8qZly6HhM4B43MB6zNX6A18P
X-Gm-Gg: AfdE7clB7ZI75fkVnpghdqVCfUA6Co5CmLIfhhyXxegyAeUZrku6KVTKolchjvT07sS
	0w9mgDaPC8/kCD8gT5/yWsUvfqhiOspQSVI5ii/uzpV9q3YihA2n8hPdcGe3Ltzwri4PQ7WR3uX
	FKfGJkBJp1UrrdDcqwRFwyS99EwcRQO9b04Aza3mn1DwElGfO8ECgAUZeFV/gyymv3SLxFU3fgi
	9v5BwV0D2iLpzoImQHBHuuSdMI23sMKCAWCcVy58zmAux1YGf1oksAYMhl++xLDwe/fVJtWN3tz
	pDNHO/99Jg==
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id af79cd13be357-92e7853d109mr199454385a.70.1782912946578;
        Wed, 01 Jul 2026 06:35:46 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id
 af79cd13be357-92e7853d109mr199161785a.70.1782912918609; Wed, 01 Jul 2026
 06:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
 <20260630180219.GA4139943-robh@kernel.org> <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
 <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:35:07 +0200
X-Gm-Features: AVVi8CfNT2AJJTgPBXfFVJQmZjW_-a9Isbc3rycVEtJcwbZkpqGBU1gJZohgDaU
Message-ID: <CAFEp6-20FXTOKQ6EPuR8OUDkqE4JXcUbXaFy7kRFt4fzszPQCA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: jqWqwLyHew-cdmAg9Q0uDW0o05biNwsG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfX1c3jpwPwClEJ
 1VMEBPuG+fCJvKAQc5VYsffTybKjfa42A4Yo34vHHN3yajkl8KMPWiQPyWcKCsAYHRJefQLm3No
 /hRITo0UNIP6BKKyNw7MdTpVJqnNs5WcamRlJStHcpMSq1hEDJ6l5PShCaZNatiHvny6AxuZxrb
 gOH7FrISOxrL3NXvkXNm7XwGnV+uGi5HXk9udj4BA8TS97ZmBrGS2CSjlkTVe5uDSnjEp/nLUKW
 euauXB03/WbRQPwSACmXE1gFnWu78GWs3dWph7hfmS2fZdVUvDUQHYg1YfScGAA8gPLdF7dfLFr
 xpX7coxRtrc0gFcSqluSeVPLIUmn6VV/maBpOqcV42th+wPfZbBuQGDUi68LrbhH5tSw6m2g4ak
 wkmwrlBr8XLLtddg89GTuNiy2kFpMgUvGysb5wmNHq79sHr1h0IcR4jXJGZVikLDRmFPvwBNcAV
 gmI+9bss12xNKlHsvNw==
X-Proofpoint-GUID: jqWqwLyHew-cdmAg9Q0uDW0o05biNwsG
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a4517c4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bM2Xkg4KEcMkddnjsM8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfX8l8ef6/VQr6Z
 YS7AzkYZQ1+Yi4HV2CM70fER5KfxGKxOJpNiSoSBnOOli1otQeK6vQR+cAH4roii36CNpGgXAYS
 qIWE1BPJVjE2WE570a1FBYY49vTjoyI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010142
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38452-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:ulfh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:stable@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.
 de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E0656EE828

On Tue, Jun 30, 2026 at 11:46=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Jun 30, 2026 at 2:59=E2=80=AFPM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
> >
> > Hi Rob,
> >
> > On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > > > Child nodes of a fixed-partitions node are not necessarily partitio=
n
> > > > entries, for example an nvmem-layout node has no reg property. The
> > > > current code passes a NULL reg pointer and uninitialized len to the
> > > > length check, which can result in a kernel panic or silent failure =
to
> > > > register any partitions.
> > >
> > > That does not sound right to me. A fixed-partitions node should only =
be
> > > defining partitions with address ranges. I would expect a partition n=
ode
> > > could be nvmem-layout, but not the whole address range. If you wanted
> > > the latter, then just do:
> > >
> > > partitions {
> > >   ...
> > > };
> > >
> > > nvmem-layout {
> > >   ...
> > > };
> >
> > In our case, the nvmem-layout needs to be associated with a specific
> > eMMC hardware partition, nvmem cells can be a simple sub-range within
> > the global eMMC, each hardware partition (boot0, boot1, user...)
> > having its own address spaces.
> >
> > That said, your point about not abusing fixed-partitions is valid. I
> > initially dropped the compatible =3D "fixed-partitions" from the
> > partitions-boot1 node when it only carries an nvmem-layout and no
> > actual partition entries, making it a plain named container node. But
> > it's a bit fragile if we want to support both nvmem-layout and
> > fixed-partitions.
> >
> > Regarding your expectation of a partition node being a nvmem-layout,
> > do you mean that the nvmem-layout should live under a fixed-partitions
> > node? Something along these lines:
> >
> > partitions-boot1 {
> >       compatible =3D "fixed-partitions";
> >       #address-cells =3D <1>;
> >       #size-cells =3D <1>;
> >
> >       nvmem@4400 {
>
> partition@4400
>
> >           reg =3D <0x4400 0x1000>;
> >
> >           nvmem-layout {
> >               compatible =3D "fixed-layout";
> >               #address-cells =3D <1>;
> >               #size-cells =3D <1>;
> >
> >               wifi_mac_addr: mac-addr@0 {
> >                   compatible =3D "mac-base";
> >                   reg =3D <0x0 0x6>;
> >                   #nvmem-cell-cells =3D <1>;
> >               };
> >       [...]
>
> Either this or replacing "fixed-partitions" with "fixed-layout" if you
> want to make the whole boot1 partition nvmem-layout looks like the
> right way to me.

Well, now I think both approaches make sense. We should support a
fixed-layout on the entire hw-part/block, while also allowing it
within individual logical partitions.
Support for the former would only require a small rework/addition in
this series (to have the hw boot partition a fixed-layout) . The
latter could come in a follow-up series, as it would require some
additional fwnode logic.

>
> > That makes some sense, this would require extra work for the
> > emmc/block layer to also associate fwnodes with logical partitions,
> > not just the whole disk/hw (hw part), Is that the direction you'd like
> > us to go?
>
> Yes.
>
> > Also, Note that regardless of which approach we settle on, this
> > specific fix/patch remains necessary to validate the partition node
> > and prevent NULL-deref.
>
> Fair enough, though the reasoning for it would be different and
> perhaps should give a warning.

Sure.

Thanks,
Loic

