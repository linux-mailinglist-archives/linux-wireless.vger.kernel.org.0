Return-Path: <linux-wireless+bounces-37517-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iIwuGkyrJmqAawIAu9opvQ
	(envelope-from <linux-wireless+bounces-37517-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 13:45:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D277D655CFF
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 13:45:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gyjq1X81;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RcO5O9lG;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37517-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37517-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97EA4301C6F5
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2E36DA0C;
	Mon,  8 Jun 2026 11:45:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770343644DE
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 11:45:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919107; cv=pass; b=UFMXvLm1iDZb7Z0/STLVFV89gSj0CYqnTEa7HJ5dQCB0LKBoVk4nQmmfaJ7jNx5RNL8WjrS6w1cwIM7JMF1hg8r524EcTajWmoH9zfpLrZIi0K9DelKfWLxSj4CnzxnmelAQoGUmdEQW/e03l4V1z9ADwdfQIH8LdScBmr2WXu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919107; c=relaxed/simple;
	bh=hhj8Vip6KRSgrU2uE5rO79Ldiak2Rlsg6Hs6C+XmYIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snwLzJE9GWJGyKVg7pdWLOl83e08BH5vaRLn9iwROmqiM3R69xKN8/RvKA4xbbMRp1tm0TcTEbV+Z95LqkKsPxzdlstBGbbYGUqT1tKIBlVDW+/MWnidB5ijngdufJaw4FcDjzgV1MFqQ26ebKh85heW71t1lMmvfJEcZO6gi74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyjq1X81; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcO5O9lG; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9YQq3038281
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 11:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=; b=gyjq1X81lQIRnvcO
	G1um2E6TV7hqmLL1Crrjwm5U2JX9LsLsEKMoBAB5r9dv+Re6mmmqF2N4BlWwnJWe
	WipwNPhnPDyTaQA1648cU+hTlv0M50/vvS6qQKzliDV+B0P+UasYAt4nGWww+/2V
	Jt2hVfesaJfjYeEx6LLpZB3Zd7kugW563Aw8AhYGU9FXuGT9sI2lmrgrxr4ipjYE
	RyrKH1rZFL3kTTJ+uQ3sF56wCseXRx5Ce/219eLO3wNRU5YKKduHHRQ7HWqC5dUT
	x7K2ybfU3hPnmKnk9GZzZSnL5s9fuvmjIHV2Ao63T44wc4jwbv7XlGhlcM4VQxJB
	Ow6dcA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj86yx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 11:45:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9156cb14b1cso126901585a.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 04:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919105; cv=none;
        d=google.com; s=arc-20240605;
        b=hLzHnT8XoPBslyqFpI7fXvNWh96CVFERXoJSu/VwX3D8/hRsvDNlJsFoOc5PV77/13
         dmUuXk013Bsu8TVmfmE7pygzoAKq/YUmgBpgL29/3OaktEo1NAcvTBJD1HO5PMQUXtbP
         jasMY7QGCyQ9GKclUF5YxR0Q+dp5akNtaNr6pLdzc8g790jjhIgA/HeCLAIJPVnwwlJl
         2f37PqLj/iUOz4ArFsea2oMUk/vlVOtv6mr3PyyluJDLqdnwesqM3ZqKtl/5bEZz9jL6
         TYfDese7a1Li8gkc8xvmvNBYlDAnRByWdoLflRZzzC+G93K4IOD/j6P4qDdXytJuJPEB
         l95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        fh=Em4wsyb7rym8l8vBW6LJm+8cznnmV8wLsF5OM2Na850=;
        b=NIFkgsvknF1aNAaBWhoeFOBL5uGHV1piXSjAgC0OlXOmlhCn1u4UXvdbMynlmdr2ZX
         mZh5/OI8R9IwvmRI2VpRkIlb4d4sNKL1Ur7ZWloYLvrAWK+b6ql4SYOuhqLMk9JJKO9g
         8UnbSDlNJP3npub0Sgyjgoval24A8ysyA0VSbyRCb8RFWbtAyvjaZQkFKOIqDJZj/DFM
         vBfhURQTg0pYSJyh8DsG6RsbXjrGVm4PJydC1WcG/ZyXb5FsiH73+lOsgha3pdY2xua0
         WISpVVnQdXnNw3li7wmxjBqGPYeDAdFlvm/K0lHbYdqDxJmZdt4b8lSnd2XH/FeDW7md
         pvZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780919105; x=1781523905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=RcO5O9lGigUkcWBwngH5Wfra4pY3AIg683iEjDPu8iUitQvGL7OQVoChTSxOluDdJe
         +hSAORC1TWMgyB8XsS3ZAQFY7KgTWS5iYMxlK62hFqYhjc0ndnX9EaRRkcQijTqkY1r0
         YV1xsL0aKD023FfuillwZ3qcB9MvSonhseaSsiLWkScBlOaCA2s3mdI2kBvKree7hBwS
         zTCuF66jImfhEkiGIUv8P1cjypl2ziR+x80fXyxoz0Zm/Up+no+yC+OJn8FmtDHjGTql
         H6yt7tI8DTvpoPd8hNE1eRpZEjButzMMQak0CD/iP05MOo3AbN8OlKXglp+S8XyTSvw4
         wztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919105; x=1781523905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=smxc5X6h7ducMnE2fgso877/BW+i1H2syE3hdrO3yha6gaBx2+bJqTTage2AeHgQ6+
         tmMpbriw9Dds6GvpWFIqojRrQg44qitWbhmYmPGmpvjHw8aLGswU2B1XBDNHwA5Ol4D4
         Wgisy+2fDPXFtamJfWVmsOMyEiKTeV06P8g0m+6++P/396HARJaYVgPIsvi6qK+w6qAg
         /3uD5mFFCgbXHQCXHi1Q+COzJwKQqS4ovf1U9kXCQv29RNLpsqd0bK9g1xwgDGyW30P0
         rOhurC6pVkMFdpFvSjwPUswlDjUHBJqBQp+tfi1+i1Ctb8csNQ1fs78yrdUDeq+59RUW
         3FcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JRT3XUe0DQ9SEfTvfvnN8yeewllR4Q+uoz+xw49IfslirUkq5VigZ/3lkrKzsoSJwe8vh61sEFxm0/iZkAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHS/z6QPpSkrjxr/yk0OcfwWOPtBFGAz2SQuf/d9D3LykRcIR
	e3Vx/w9bCu6nQEE+SXtI5doMzvjNwMyYooGhlGWGkeUOAYhlk97BQSdW7s6SN7mXmp6J62B6mQU
	yULP4hhnsDYdnVQNIWqQQgXQiHkHy3bUaV9xAPDubsWK4wnwKN5Cc7X34MjCIfLLmhd/PyjpuDV
	4jvXGmB0Osx81+j19lM3b+qOVeLuin8eibBIsCQ+SWlM+S
X-Gm-Gg: Acq92OEa8cld3yqEXvAf/UOJpuNB7scYpgbn+KJROJ1yHRAppiKTtxIueTqo+WV/Bup
	MaKocv9PROcxwUzW1Jg2xORsfQjm4ArS72EZ9nepbI0DIM1IqDkvgnCSpQlEdyIch+RsLaEzE8p
	OX0Cx+qTB+2Fwx/GixHF9mZcnj9zlN2lNDEn7IMIPt2MZo0XWoZe+F3675x7KAwqeWryyX4JShn
	jpBmNORDHTYYoAnDlLEs8x8eI+jOU6C8FdSvpc9zVLYb0p9sIDtTDhg7STi2ffZ1DGKqnPOGclB
	p3Hptkc10fKtRXXA958Gvc0HN7sRE5FV
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id af79cd13be357-915a9dc9a4emr2367274985a.47.1780919104825;
        Mon, 08 Jun 2026 04:45:04 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id
 af79cd13be357-915a9dc9a4emr2367267185a.47.1780919104401; Mon, 08 Jun 2026
 04:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com> <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
In-Reply-To: <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 13:44:53 +0200
X-Gm-Features: AVVi8CcIivK2P5dE8YRtSTP_9u8m9dGK-3gXU3su59C5FvR4dQPnW2soKiKG5MQ
Message-ID: <CAFEp6-0u1DBhXo9DCie5HCGTjcduWcHAiifVo88vFJwjYcjCog@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: AROxFv2t3ahr9N05YlWuuxNfMxBHdju0
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26ab41 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=4LeufcCx7mgyzPUJGOcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: AROxFv2t3ahr9N05YlWuuxNfMxBHdju0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExMCBTYWx0ZWRfX/SNdMbawKche
 SHFAss5PIuaIKUqfjGeKIlvMGCpKdnrkg5rC3uhfhRqryoqsjgI7Xw4erJO3fhjfcpJG2KH1ij+
 YLddD6qPedsPPlHyx0MMZoRC0n6pxqOAxkYOWU4flpSy/O0yPEO/CR2+D6qPoZ5h2WmalA87Xsl
 G68l8aiwa/rsnPjXa9e7iHwCebhQ+L5qvKYmnH3t0B6wC+OgcT2CsnT68RbWz0xfnMJw5mm3nnA
 SUDlXPP8S19WRiy1FyqMs0JRpSUX7xkknxaRM16hDLA7BTrP1n5uiaDjZlXIGLP+C6R4P3tnTpb
 wWWAStkIfKrtcIsFkLPN5ebhTpyyS24kmlyni8egtcn90n4ahIuVn7E1UFSZ8TmCJYOl47jW/HZ
 upNVXYiLEpfHqrq6RkwNmatRaUaS7tSKsfi4CLL5oum3b3cXWYxvZPX9He4k/m+r+M/Y5xoDG5n
 NYVF8MtQg1nq9vv3m2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080110
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37517-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D277D655CFF

On Mon, Jun 8, 2026 at 1:29=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/8/26 12:50 PM, Loic Poulain wrote:
> > When the controller BD address is invalid (zero or default),
> > set the NVMEM quirks to allow retrieving the address from a
> > 'local-bd-address' NVMEM cell. The BD address is often stored
> > alongside the WiFi MAC address in big-endian format, so also
> > set the big-endian quirk.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++=
++++++++
> >  drivers/bluetooth/btqca.c                          |  5 ++-
>
> Squash mistake?

Indeed, thanks Konrad.

