Return-Path: <linux-wireless+bounces-37519-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G/XhOYa9JmpgcAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37519-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:03:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBC656660
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 15:03:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=j+rUH7yN;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=eHrfoKNi;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37519-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37519-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A587E3008D0A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 13:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C329992B;
	Mon,  8 Jun 2026 13:02:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CDC2874F8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 13:02:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923755; cv=pass; b=PjBP6Gtrbuf3hJ+s/XZb7FOksftuSK0ZfEj0sjhlbU83sw0hJMcn6VPk37F4Gy0OzaD+6Ob/YYo9ZDJ3IEVvmgtgh/5KhHb/6reGUIPOL96XTn4P7mM/9YB/ZBr7PuFe8egNzRvlTQIUfNmiz1TroD9PvNaBKw2d38bn0HplR+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923755; c=relaxed/simple;
	bh=vVjU3pwVlqs1eGL3LgvYGVSpYqf3o7An1hUHG7tFne0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+SfMlc/agzakAjxbOwuQ5ZpN7H1aOUkNBCEdS9hkvfTIt27oLdZI5+H+IXm6RVfnGeqUVOuSfAAxWeLgZkHElioN0gFKvU0Y5NteY9VzOAXwd+uWYGv/q8CFfBy08KE4gODWC84PcSbfdWFYfucwTnqKnp54d44y8eWTaj8bfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+rUH7yN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eHrfoKNi; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9Mkf3038129
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 13:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=; b=j+rUH7yNKShbdNZr
	MqPeI10vwdoPUpfzUXM9yE67URwfG9f0JDVVLUsjGLRvD/v/a5wWvZlAOk53MIGY
	LjIAmHuiq0Y7nQzBPMV/sLmmLpmTz4Z2Fhhe/9VKFllEevVNCvaKfs8Deh5mgVbP
	XZUGYjS4x+joNYUOgYpqmjey1ARbnX7M9WqpEK2EfdQcRxxz5b4N181GIbqfv7uu
	AHI36YCPoIxY5nEoCxDPPjX9+bOXKPxuxWB9fJL6ElDeMVwZj8kFrxTqi+vtPS6B
	0U4A2fZclkQlc0vqe0jegAp6NKsUhWozFi7CmVerYMI7Q+oOXk65aSmTgo/iXTPD
	nmpo6g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj8h40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 13:02:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9159bc52211so145661585a.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923747; cv=none;
        d=google.com; s=arc-20240605;
        b=c32vJmd7ByKjPQHqRs30NYSRSbY11XcvJH5vOAmG1TTr2il7WNTOLVG929x7c0kyaz
         lWS3DTppsv92LbEC66UixfIwZrDesZ/UPa2pWCPBv/YTkme1hC+7iOBlM3qbegIwHaGS
         UdbvoHi75B506TlHLNHpYfmPyMlVNOPgO1I3llGuxwNnw80cgecGh+pI6iRU5elOrMUB
         EYcYdLg9xMWbajcWxXcGVux3ht0vTCTZLIcEvUwcN6KIZZSpnstYx9R07VNnrtcu0WGA
         ifYWCvtDEnuUHc2WeGLwWMQ2+eYWdqpae6/omJllla6fbkCuE//61ka/PHhwjol8ZsHQ
         0lQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        fh=Km8/65C4D8yxWXz5mEkJZIY2p6ShfC7VRYarb5bAGuw=;
        b=IjsMapCFVP2CyVWGJ2UsTSVksj1HzFXWfmA4fmWR0a0iwHIuizMOtqa73GCPrHfj4Y
         ysa1tGZzoBjt8W5I2FtVNs4XUlislOuZ3vuPEG/OtAxI32k8VGujnyrJsHyWZU9zEAGq
         8fMimkMOJOGWx7MD6Z/VIoojsSD7UfBU+os9uoW2iO/nqRRcLDnhdvDF16w6JHs+ycBy
         HDR9YmATHAXaFtaY3coDVQA5BlHhfKsgSECPM8/YWPA7cA4I1qwU+ikU7bpNlZRZ0kC7
         U0UdfHV+oTJ6nQYkIHHuz7liiIvjKRWFUuC4RmGUAUtgwCtUzbmko1RgM1gBPW28wN4u
         a35w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923747; x=1781528547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=eHrfoKNi+yTAM0+zjzxQHeoCu6L4Fdtl5ScKIrbEItNNS5RvFQkbsztP8WCH5vMsQE
         ushLE9I8n8O40Lu/ut55SaR2Ht2xOVcbc1uZHNdP/NYvHUUGmSXs7cTeQXNNcwrbfkBS
         5H5PPGgMIdUi5clNH+BSX+kMszuvslD8z4RS725mqCoh/C6ojJKBxvrpAuwmHUSz6s86
         GpWh6vPEcNLZ6lo8rDp0+VndBBu7U8GLgboPj2ZFCpkyok9pnuH+BD9Iz0i/Dc2K+6ed
         P77QJEDdy79W6sSlpJPln58rD/4lXLVC36JCbYaqLlbslgm3uxncgryG3uh7anMT8CoK
         6OOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923747; x=1781528547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=qxTmCg6UnkltRfGDGorVDlQVvE6AO3ScVaSibvIEMNWTxckE75UiUMSX6xbRQVcX/J
         KElSqtJ824cVMqClN6sjwRH/J0Hlr7r6IYt1gINfb5BYVr8fOB784uugcfhY/Qry3jr+
         wqAGh+SmxkW2dIoZUdVC++R2HRtIDfbiUve+S98SzsbOUG/ZYtjyzvB7x9EWz1qOECF+
         iXIIPzDTZ9aqSF1VxvvE5mI3Njb6vqdhuX1jaCs76luncTP5BO9qCzFyQfO1CUwNvlZu
         H64MdG9CcrjwXjIN43sbs7lza96TSTmMc57U+KaPN2eRl214z8ToeLuF/PRrF1QXPh6Y
         L7UQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aFK4umN/VwxOVbvdH8JNgZTQ/5IXqAGkFQctQ5K8YFA5dxzEsNeMMR+uV1rmVQePFwr8yMGZ1inBZSDihyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHfYxdnSr15lBmDt2MXRHRavrmowFKTpxdIxXPU5wHLfA6+Lu
	1mIX/At+gwiePOL3Vlzp17lzn6QjXtbrbNougo9Jjyg6xRHE/rLZwWG6eA8oC8OiG8PZWFLnnu1
	H+Fhf26D7ZCNLUbTa7QAsfVKMBCp8/2CS/el7lMld6baB6qqQqIofPjSNsE6hUYUGdGnrIZ8+tZ
	mL3v2W/vk2/2XE6v9k1rpEIepDNVV72GFteefAaT+/4+Ed
X-Gm-Gg: Acq92OH89URjrphaHFPkK5RFXyAPqCehGY0DVy31ROgBJ8JPmi7GgCLQ2hBRgGE8ggE
	w4mLuyPT+iwwdr2Rv1vkAXfmIYvUfHtqL9BWdE/R5Tzu8Aa5xW+bNGWLSnR8LFoB+YYQZoMZUXv
	0TP7HKbX4xNDVFlnygj7gd4S6ijlZ/HAI4jxe+WJXSWXbAaO4UC33n6qMW+3Wc6VNVWgVDCn0s0
	+6xakm6jw1zMzs5deOslt+ZwEIlcLqYTshYWfwLzuYpvC+eRtpqIjLPoKe7H71GmdRCdYynFmXQ
	NOEgukh/J1e2tG0JYtP8bsY2o+bP+ln9
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id af79cd13be357-915a9c35852mr2536192985a.9.1780923724540;
        Mon, 08 Jun 2026 06:02:04 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id
 af79cd13be357-915a9c35852mr2535551485a.9.1780923662522; Mon, 08 Jun 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-4-82681f50aa35@oss.qualcomm.com> <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
In-Reply-To: <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 15:00:51 +0200
X-Gm-Features: AVVi8Cc-wgzw5gsLbwZHUHPYEgpxejd9uRTmITt11-0eb6tOd2NzMwDpPGAFaCc
Message-ID: <CAFEp6-0JaOd8PpqMY_21BEDyDyYx1kDfskOS4VSd8nxP4KBXZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] block: implement NVMEM provider
To: Bartosz Golaszewski <brgl@kernel.org>, daniel@makrotopia.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26bd64 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VT4XjZGOAAAA:8
 a=IjnKPMcg25KrRLxKrC4A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-GUID: D1wcrH6PqsEUyRJcywODg8AE3JABe2ra
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyMyBTYWx0ZWRfXzhh6WnZOVuBh
 1VLCl+vUKa6DU5aST3d1VBLg9WSrda33STcpB2M3JPRjXBbVfRoLZw3xrv3yiJFn10ExebaIFG1
 ijJuF9MLhAzSfzzmt1SIx/hw0PN8EUgzoqZHvL67DbVZ0qh3wl0SXelfgmbzyd+GkgLOaYM2rVs
 4++zGHwfLrBBlKZpeuRU9bRY6pJiznwyHCRdPmuZgtjeL3NtYYE188rPHVE3pV+zIoy+54Bery7
 h3cqiUSGiilW+7lvRNQFk3yetWb0A8izHTURlGIFw8ZgD7iVcWsHtqfSuwMAgrIoyXsvRVwurY3
 8nv9xRLc7zplE6pmVdgQHe9I5lzjA+kL0gFLYjrif2CSKNfhAY6hCVdtLOopxTjvj+Fd4LmPsBg
 3CRANUhPvrm0It3IWTSlCruVtg9LJA==
X-Proofpoint-ORIG-GUID: D1wcrH6PqsEUyRJcywODg8AE3JABe2ra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606080123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37519-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brgl@kernel.org,m:daniel@makrotopia.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,config.id:url,config.dev:url,mail.gmail.com:mid,makrotopia.org:email,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,config.name:url,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EDBC656660

On Mon, Jun 8, 2026 at 1:17=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Mon, 8 Jun 2026 12:50:41 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > From: Daniel Golle <daniel@makrotopia.org>
> >
> > On embedded devices using an eMMC it is common that one or more partiti=
ons
> > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPRO=
M
> > data. Allow referencing the partition in device tree for the kernel and
> > Wi-Fi drivers accessing it via the NVMEM layer.
> >
> > To safely defer the freeing of the provider private data until all
> > consumers have released their cells, a nvmem_dev() accessor is added to
> > the NVMEM core to expose the struct device embedded in struct nvmem_dev=
ice.
> > This allows registering a devm action on the nvmem device itself, ensur=
ing
> > the private data outlives any active cell references.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  block/Kconfig                  |   9 +++
> >  block/Makefile                 |   1 +
> >  block/blk-nvmem.c              | 171 +++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/nvmem/core.c           |  13 ++++
> >  include/linux/nvmem-consumer.h |   6 ++
> >  5 files changed, 200 insertions(+)
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706=
f75c92bdf8b648f7c 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
> >         by falling back to the kernel crypto API when inline
> >         encryption hardware is not present.
> >
> > +config BLK_NVMEM
> > +     bool "Block device NVMEM provider"
> > +     depends on OF
> > +     depends on NVMEM
> > +     help
> > +       Allow block devices (or partitions) to act as NVMEM providers,
> > +       typically used with eMMC to store MAC addresses or Wi-Fi
> > +       calibration data on embedded devices.
> > +
> >  source "block/partitions/Kconfig"
> >
> >  config BLK_PM
> > diff --git a/block/Makefile b/block/Makefile
> > index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800=
ea266190a43b3e63d 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION) +=3D blk-crypto.o=
 blk-crypto-profile.o \
> >                                          blk-crypto-sysfs.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) +=3D blk-crypto-fallback.=
o
> >  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)        +=3D holder.o
> > +obj-$(CONFIG_BLK_NVMEM)                +=3D blk-nvmem.o
> > diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..99c7728fb7bccdc2216780a=
73a89a9210f925049
> > --- /dev/null
> > +++ b/block/blk-nvmem.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * block device NVMEM provider
> > + *
> > + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * Useful on devices using a partition on an eMMC for MAC addresses or
> > + * Wi-Fi calibration EEPROM data.
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/property.h>
> > +
> > +#include "blk.h"
> > +
> > +
>
> Stray newline?
>
> > +/* List of all NVMEM devices */
> > +static LIST_HEAD(nvmem_devices);
> > +static DEFINE_MUTEX(devices_mutex);
> > +
> > +struct blk_nvmem {
> > +     struct nvmem_device     *nvmem;
> > +     dev_t                   devt;
> > +     struct list_head        list;
> > +};
> > +
> > +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> > +                           void *val, size_t bytes)
> > +{
> > +     blk_mode_t mode =3D BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> > +     struct blk_nvmem *bnv =3D priv;
> > +     size_t bytes_left =3D bytes;
> > +     struct file *bdev_file;
> > +     loff_t pos =3D from;
> > +     int ret =3D 0;
> > +
> > +     bdev_file =3D bdev_file_open_by_dev(bnv->devt, mode, priv, NULL);
> > +     if (!bdev_file)
> > +             return -ENODEV;
> > +
> > +     if (IS_ERR(bdev_file))
> > +             return PTR_ERR(bdev_file);
> > +
> > +     while (bytes_left) {
> > +             pgoff_t f_index =3D pos >> PAGE_SHIFT;
> > +             struct folio *folio;
> > +             size_t folio_off;
> > +             size_t to_read;
> > +
> > +             folio =3D read_mapping_folio(bdev_file->f_mapping, f_inde=
x, NULL);
> > +             if (IS_ERR(folio)) {
> > +                     ret =3D PTR_ERR(folio);
> > +                     goto err_release_bdev;
> > +             }
> > +
> > +             folio_off =3D offset_in_folio(folio, pos);
> > +             to_read =3D min(bytes_left, folio_size(folio) - folio_off=
);
> > +             memcpy_from_folio(val, folio, folio_off, to_read);
> > +             pos +=3D to_read;
> > +             bytes_left -=3D to_read;
> > +             val +=3D to_read;
> > +             folio_put(folio);
> > +     }
> > +
> > +err_release_bdev:
> > +     fput(bdev_file);
>
> There's a __free() action defined in linux/file.h so you can use:
>
>         struct file *bdev_file __free(fput) =3D ...
>
> and avoid this label.

Ok, thanks, will use.

>
> > +
> > +     return ret;
> > +}
> > +
> > +static int blk_nvmem_register(struct device *dev)
> > +{
> > +     struct device_node *child, *np =3D dev_of_node(dev);
> > +     struct block_device *bdev =3D dev_to_bdev(dev);
> > +     struct nvmem_config config =3D {};
> > +     struct blk_nvmem *bnv;
> > +
> > +     /* skip devices which do not have a device tree node */
> > +     if (!np)
> > +             return 0;
> > +
> > +     /* skip devices without an nvmem layout defined */
> > +     child =3D of_get_child_by_name(np, "nvmem-layout");
> > +     if (!child)
> > +             return 0;
> > +     of_node_put(child);
>
> Same as above, can be:
>
>         struct device_node *child __free(device_node) =3D=3D ...

Ack.

>
> > +
> > +     /*
> > +      * skip block device too large to be represented as NVMEM devices=
,
> > +      * the NVMEM reg_read callback uses an unsigned int offset
> > +      */
> > +     if (bdev_nr_bytes(bdev) > UINT_MAX)
> > +             return -EFBIG;
>
> This will mean a failed probe. Wouldn't it be better to use -ENODEV?

That would indeed be an appropriate error.

>
> > +
> > +     bnv =3D kzalloc_obj(*bnv);
> > +     if (!bnv)
> > +             return -ENOMEM;
> > +
> > +     config.id =3D NVMEM_DEVID_NONE;
> > +     config.dev =3D &bdev->bd_device;
> > +     config.name =3D dev_name(&bdev->bd_device);
> > +     config.owner =3D THIS_MODULE;
> > +     config.priv =3D bnv;
> > +     config.reg_read =3D blk_nvmem_reg_read;
> > +     config.size =3D bdev_nr_bytes(bdev);
> > +     config.word_size =3D 1;
> > +     config.stride =3D 1;
> > +     config.read_only =3D true;
> > +     config.root_only =3D true;
> > +     config.ignore_wp =3D true;
> > +     config.of_node =3D to_of_node(dev->fwnode);
> > +
> > +     bnv->devt =3D bdev->bd_device.devt;
> > +     bnv->nvmem =3D nvmem_register(&config);
> > +     if (IS_ERR(bnv->nvmem)) {
> > +             dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
> > +                           "Failed to register NVMEM device\n");
> > +             kfree(bnv);
> > +             return PTR_ERR(bnv->nvmem);
> > +     }
> > +
> > +     scoped_guard(mutex, &devices_mutex)
> > +             list_add_tail(&bnv->list, &nvmem_devices);
>
> I'm not sure I understand the need to store these? Whatever you need to d=
o in
> remove() can be scheduled in a devres action here.

I think the devm_ approach would work fine in practice. The only
difference is that NVMEM unregistration would be delayed from
device_del() to device_release(), but during that window any read
attempt would simply return -ENODEV, so there is no real race or
safety concern AFAIU. I guess the explicit list was initially kept to
mirror the add_dev/remove_dev symmetry of the class interface. But,
except if there is no strong technical argument against devm_, I will
switch to that simpler approach in the next version.

Daniel, feel free to nack or ask for authorship removal if needed.
This patch submitted in your name has accumulated enough changes since
the original submission that the current shape may no longer reflect
your intent.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static void blk_nvmem_unregister(struct device *dev)
> > +{
> > +     struct blk_nvmem *bnv_c, *bnv_t, *bnv =3D NULL;
> > +
> > +     scoped_guard(mutex, &devices_mutex) {
> > +             list_for_each_entry_safe(bnv_c, bnv_t, &nvmem_devices, li=
st) {
> > +                     if (bnv_c->devt =3D=3D dev_to_bdev(dev)->bd_devic=
e.devt) {
> > +                             bnv =3D bnv_c;
> > +                             list_del(&bnv->list);
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (!bnv)
> > +                     return;
> > +     }
> > +
> > +     nvmem_unregister(bnv->nvmem);
> > +     kfree(bnv);
> > +}
> > +
> > +static struct class_interface blk_nvmem_bus_interface __refdata =3D {
> > +     .class =3D &block_class,
> > +     .add_dev =3D &blk_nvmem_register,
> > +     .remove_dev =3D &blk_nvmem_unregister,
> > +};
> > +
> > +static int __init blk_nvmem_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D class_interface_register(&blk_nvmem_bus_interface);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +device_initcall(blk_nvmem_init);
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..ee3481229c20b3063c86d0d=
d66aabbf6b5e29169 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -2154,6 +2154,19 @@ const char *nvmem_dev_name(struct nvmem_device *=
nvmem)
> >  }
> >  EXPORT_SYMBOL_GPL(nvmem_dev_name);
> >
> > +/**
> > + * nvmem_dev() - Get the struct device of a given nvmem device.
> > + *
> > + * @nvmem: nvmem device.
> > + *
> > + * Return: pointer to the struct device of the nvmem device.
> > + */
> > +struct device *nvmem_dev(struct nvmem_device *nvmem)
> > +{
> > +     return &nvmem->dev;
> > +}
> > +EXPORT_SYMBOL_GPL(nvmem_dev);
>
> This should still be a separate patch.

Well yes, actually I should even remove this as this is no more needed.

Regards,
Loic

