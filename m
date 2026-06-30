Return-Path: <linux-wireless+bounces-38378-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KPjfMFW5Q2pZfwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38378-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:40:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C38DF6E4498
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:40:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=AhXU0K1N;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UGfXt+lO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38378-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38378-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADD913001A58
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A91D40B373;
	Tue, 30 Jun 2026 12:39:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365B3CC31F
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:39:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823158; cv=none; b=QRJjomKfSe+DmRbZ+MwygPkpGLFCAvcBMArdbp6XVM3zzu716O7KWA62Zy1inP9YdMiovtjYXMalLcnjbmvXSCmvlP60Pg2mCIbCxK6SL6wc9jixineUWKebzf/wfcPRAp+WH9yKLuQggjsJTyXV/eN+bJSGy02zgtkNOMBXSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823158; c=relaxed/simple;
	bh=FxpES4QjZ5UOZ0ZDankh5pA1Tqn7LCiS68nn+rCzouA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cvn7F4OKzU1G/1ZaegNk+bTFLsCHV1Njxzv8bOyUE6q3zFLKY9WvKYj7PjppLr+6GJwD5P/Nd++R3i17szbE/UwEy5kcNLM2BzRWE0Ucrf6ZVdPKc6SLhHJifcrD38XzIzTCJKyuBkBuhX7olBgsutig0C6cH8hEOA+J0YEx38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AhXU0K1N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UGfXt+lO; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nLSd1590866
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=; b=AhXU0K1Nf3o7hIe+
	5inixK4SQz3a7GOF0doOZ3d6lGTX1peoFk/Aw/reVBsilnEOhcwnvUjGsNKN6LVW
	9/lg2AKYC/dxUOAWlYYde2OXi/nx8t2gZTtwdSPUjxTdf1ss+aoz1+zTdS9KFAVl
	15opLDPFxXbGqx5SoxixFqiXBaDN9ybNSUZRGvAhhYGwA1A6bnDz3ZIaH87H52s+
	iRBjEBUyl4nR5vfV1EvLwnokHifuTBtoeCohE+9HHBHXRBfy/KlvGBbUUkv2co+h
	madwEOSh2PZidgsAnJFI3cjXgtH9DhRdrOUy2IDykIFTaePdIf21edNObcStvN3E
	mAYgmA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k3j7j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:39:16 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5bd94ea83c6so105581e0c.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823156; x=1783427956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=;
        b=UGfXt+lO3djs/5wrGbtB3mImTLAWY9VSf0HFaEdBSl9c71LQGnFgcGTAdFMirHBmxF
         YAq8yHyag5RSfLLmgKm2h81nc1MIJwifbuJhBlSF69NLWCjMCZ+8e75qZF6ugVL6mJo2
         f3KhnqXKeJ63zJtQxBfP94kah3ge2rofAnq8+iC6QEOSiyBZZky192hE/j5F1x6FsfGw
         ku5r7bTEtQR/tfwk5lmHeNCEAP3rKM8Rtp0CWc2gK3fJODnvwf3l/cCz4u/JB1vog3gu
         wMnekHSU+97hY3doEdrlpEacDBBOy3+xLOtIVnof/jGPhXsFFfzuR9jWaX+qHhHBBw2w
         jTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823156; x=1783427956;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j+0Tx25hFjaHzRNkLyNtbTDFfSp/eulHhiy7NQz4/zY=;
        b=lpfRRFXt1c5Kksuormxqj/0spxLguY8rDNAIZTD50LUvUmjn0vY7K3GORUgYRte5MU
         KAuwx3ccd+G97VEVI5IDoOv9veT074OzjZ+qnkpalARHq85rWhQ/hOUHgk2Jxi3vjfbD
         YOO9SfFzvnHp2bl5a0WjJRLljMkec3OXDlqzpMuDRhh15tig4TrSWOZyl5fbco1pu+Ws
         rGkwSJEJNwm0U6p/ULawuomrw8a3PGXABqUrySZk8PjrUcytB9aNvuiOI2nXk/K2Ivir
         HdDJBk9yzkbHgg4FOqjgjxaqyuatpaR1oqTz3YjcNtq5XScTyCrC308PqbxooCjzPB1Y
         W8Zg==
X-Forwarded-Encrypted: i=1; AHgh+RrknFOj9PyAoh8es/ir6Sm+oSBYTBe3xPTvcN96X5OErR9xwt7PMON5xu9/zSwPrXRM9w9U6FhzOFO+dOy4VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKV9o2Q6xFCum5CFI01ypEy9zFwBKF4jKD4UxrSAPVvZpDEuSV
	R4YjTsUkOJJDQLYkRbd9WxdC2ghrW1N/mVX40n/nM9vI2AoKnc5Z88TlhOWSNOuWn9HKF5Qy74b
	YCWIDIX5aIbapwwLd+HKdP7oxtnD8kGElLaWE4H70VdCeIchq1IPwn9lne6UE3Q3S4eAHVA==
X-Gm-Gg: AfdE7cl146cKc4Ev5Wqfc/6MI61ViSkMS2JIyY2AWQq/RmhXm+CQg90FXWJkTuSHtJZ
	yBQdQW87OTG/q3VudVJ/GrvGMex4Usfc3/o2aooIHzRxJBBSVG0DWH3qXm+Y7cLP3Gqwi74k56W
	yrb9rHwSOy8b6TKhOrPRxdfEOmV1dzCYEqMQQAXU20jObuWT7kMAc1KRIba1UO0W5JTGSUMA6j8
	RnwFgv1hLGOHcA47/+pF6IlMphEt8IdFxN5/ijDoWgUPD/4bDzexZTIN7hzNQziJgNl7g/o67N2
	/OXK1xqRhyjooc2zzxJr5GY+/qedWISk4fJdNxjLw3SjeT6pJt2biW9e1Bb23u+4lZJIKGm60Vo
	APzGeOe7stSDfFjgiAps8GNtYzHUWicty1Yc=
X-Received: by 2002:a05:6102:6886:b0:631:b312:a2a6 with SMTP id ada2fe7eead31-73a333ba5c0mr489632137.0.1782823155822;
        Tue, 30 Jun 2026 05:39:15 -0700 (PDT)
X-Received: by 2002:a05:6102:6886:b0:631:b312:a2a6 with SMTP id ada2fe7eead31-73a333ba5c0mr489583137.0.1782823155407;
        Tue, 30 Jun 2026 05:39:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c3a3bc5sm1155708a12.5.2026.06.30.05.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:39:14 -0700 (PDT)
Message-ID: <f849f648-6891-4e51-89e6-dc803d07ee16@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/14] drm/msm: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-9-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-9-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXwTskom8ebjNg
 HMVuk2NaQsmwiIbTvY1jGIpXksFudOQRhRgWqFPEGD9wwzf+dT07DWAkbarxqxsC0plsvXY6O4F
 9ILU/FKEVwtM7KWpGyIjgsyU4Ge75XQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNiBTYWx0ZWRfXyUnlo3yswjiO
 3hncm+QGw9PF+/hwc5aS/MyBNfaO0EfYd82jXqsoEWEpuyyW4M1/pHTq4EdcIPK4xWWyr4LKekd
 nO8o7As2XZjHP0jVN9weJj4ESiVGlkfLJ7ita64/bKyH5XyMaUfybdl6WIoOZmHavZMDzfPtILa
 6IXy1adYg9Lw6g01+pH23JeNOGzqmwmHTuuRRYyHUF3KMK1aH/g2Ecv5dQrOWNCZwfAaLEYfeaN
 K/EPhQF3PYbAse0wq6eKqDEL3HZg8Ic26iDXlTfiANhqmZMg6LTj2FU2wEaV/JjpKkOr8Ve/kK8
 sYyncJtZ8tQvvnXkn+D/X+fVloeaTlfQHLsNm0B2J/4ZIa0qX19+w+cCLoTPPcfMqxIC/4alONK
 VxcQBNPViOewKafMEFlFnXMTqqAH1QZ6g3Ejo8nIezsoeQCX7bOrGmjBzIQPaJD3y5nQb5FUBSV
 pyAXrWidKfjyUK106JQ==
X-Proofpoint-ORIG-GUID: Wq3Lc3aU855ZSLL9RU0K0JeYUHXT_K1G
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a43b8f4 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=E6O5LMYzsyQa2pg2XTQA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: Wq3Lc3aU855ZSLL9RU0K0JeYUHXT_K1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-38378-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C38DF6E4498

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch drm/msm client drivers over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/Kconfig             |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 11 ++++++-----
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 250246f81ea9..09469d56513b 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -21,6 +21,7 @@ config DRM_MSM
>  	select SHMEM
>  	select TMPFS
>  	select QCOM_SCM
> +	select QCOM_PAS

NOP change

[...]

> -	/* We need SCM to be able to load the firmware */
> -	if (!qcom_scm_is_available()) {
> -		DRM_DEV_ERROR(&pdev->dev, "SCM is not available\n");
> +	/* We need PAS to be able to load the firmware */
> +	if (!qcom_pas_is_available()) {
> +		DRM_DEV_ERROR(&pdev->dev, "Qcom PAS is not available\n");

Just "PAS", drop the "Qcom"

Konrad

