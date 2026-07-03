Return-Path: <linux-wireless+bounces-38592-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id naafApK/R2qbegAAu9opvQ
	(envelope-from <linux-wireless+bounces-38592-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 15:56:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B170323B
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 15:56:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="KRPhwA/o";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Rj70q6qs;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38592-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38592-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E08F330A4D9E
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 13:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280C3EDE6E;
	Fri,  3 Jul 2026 13:45:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585093DA7E3
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 13:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086347; cv=none; b=c9EDf4QeLVY4XjufZ31ZtgamLewWNKEY/c9PD/2sajdlGaWfx6T1rZj6QF97IxSR3SIXsZCl4TK3Wl3d4TQllhlER6Eo3Je4YzMdIjJnyY0VbLQaEjLQ2d1wzwVWRb/uYspQYdeQJELWdHIkLVizOlcnEPrOTxkSjd9viWQGOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086347; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cA/ZmFD2uMxFhHWB/hWXxjwEAk4XQ7q5DRPwbeVtKWU0jGRu93YKRy5iLAyzqTPT8zL8EqhhYqqvHSrKl/DaQYhMKNgpAy5oqgGWrMu6Kl2kJfQ84unMIniz88UhaDLdWxyn4YGW2OSl1VLJ2gHI9N7tfEiqOiuTU7UU90CiHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRPhwA/o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rj70q6qs; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663A35LW3773382
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 13:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=KRPhwA/oh9GV+uNe
	1MwR120BO+YSIq3ukMGeVBkcNZ5Kq3I5QOL0MKh6GD0UGJx4JioKC0KrZhqHprCX
	/upucVc46jPkUtqpoIH6svQnEQiN1ucR7xoGqS+6VUkQk/x4I6LXRFd2C7rngb35
	bdHPBxAI78RtRL+1+im0WisB2E+fI9770b9Gh+5O7PM4nIxpjTDS9eleXZVGc9kE
	cvk64B0goHWTRwLh9h+RBZZRpzoJHGAvT5zlKLBHvOqgJLfDQdAxd10A/CUMDXUl
	cEl2S5PfetXf8QNlHbKCosSTnlVM6DKsZaOdZZrKZk6CzVLKZHDpox4ONUWWS+Em
	cPOfJg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6b038u1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 13:45:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e61b38eddso111171485a.2
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086343; x=1783691143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=Rj70q6qsx+bZ6l+AswC7+k9Ht7zn215LQIncwfzfjFTWyP1tQIIp4L1fu6Ldrsb5ZC
         du6QjPOsYSn/inr0AcnrvxRaN3/udaRVic4j9APkre0fFQ7yaLnSCS74kO4LrUevlwqY
         pfwg0Tmkhix1kdF2dfBCZ49+oWOQf7qzW2utDUPPMLkaGev71LV+E+Ctsb7jmkjHHaCY
         FCcXqU4lTE1bLAKV/RN2SNRDcNYXajfdNf/KoR0VO5wJOI47Oeu636aZrlwOzVPQwRzk
         2e4Gf655Qx5PpAEUvB6MVhtpfp02qyXtTDGATWtd7fyC6bS9FVnnUZtzIE4nI4R+ayiG
         XLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086343; x=1783691143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=GchCGFIktG+xSJ+8Q2zkuWUC1QSo9USLIqB0+jn2L//9ISQWYA6qqPwzaIkXjmVtby
         XHMDscm32oYBNlRG1s/Rz9pu+WcMDChDDAZ01bB1orTLHefUH+S+7hk1gqRVS59sXoBG
         OyrKIeJgH2c5Ouk9Z/UHh9MQDXO4uGKl4sJNml6xk3qwWe3jTPPirCyJjjXtujTASmni
         f9WYvXZlQ2p3DZWcZHgcIIWEQsUQyGy3jGyBer+PqnPfHaKs7RobF3xHjeFcLHVGf4Pr
         sLYuOJLLwSXnKq2z4oxCZHRS1ZZc+Uke6xe5Urgt8XqApXK9ES0C7mcSb61rezNaRD5f
         sJTw==
X-Forwarded-Encrypted: i=1; AFNElJ9fTJpmOck9ThY1Amouwiczr+psOA3xDa6xtDS/xtUjrvPXaQcmdl03dxUvhgsHLLRRlt1EJQZCkmCW4cRCFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCsCLBmZse0t160vc+T3hWj3D+zPGxIQZX4YCVfdpTVF/4Tmd
	iwjMloGu+rneFSQGah/ksRjHQkCMxHbhO7P+d/sAVJEbgkomgIUPmn+MA8paEeX0e2MDxyFiqhD
	0KBK5YOHXLYHlTWj194tfqnkFEflSP3SLpAel+QQ+ejTg3IL83Ae+NZgqV/ZxwnZGoauUrw==
X-Gm-Gg: AfdE7clP3ggA7LJcQPkSxx32W9+HB6wsnaQL+risxl80XpfgVQh8xbh6Q0YrSh7+rMM
	zTB3ZpLA8w7YwRoHe/GfxmBb/k6vge/JomlvYQI9X3bwf8jhV4DCE8zdAq2jvwq9NJtywqJpRxO
	mGZDk6Q+Dm8J7vMQyH6oaleYf7j9bwGv4BwjuJ4SlaLYm46GUS++WKqt+1qzmXrdtv+JtobkQgP
	tneENVpj0JKr0AZLivIKsEnMIVKE3W6FPyN8eeZDafeKfkd9t4Od8EYz72toiBxTFXA6v+G5KJd
	UNFBwBAddGED3h/6k4zIDQdd7Lb3xbuHzuZEBhTd5YshKxLZS4CeVH8YyScsB5lRCKp0ovZmDX/
	8q7KwxgdAFPkX1e5zjZXBS/i29No5A5E8fQCnw6TsyU8hZyB+CXoPZs3elzooXbP32OKzy2aJ7n
	Nj/AxbsXbKsVkBZotxwpn4Idyw03/ASthmq3sdWjfJVq1gjyMoxN13BSoV8uFV8j4=
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401572585a.57.1783086343111;
        Fri, 03 Jul 2026 06:45:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2847:b0:92e:64a8:2305 with SMTP id af79cd13be357-92e7850c4e8mr1401564185a.57.1783086342473;
        Fri, 03 Jul 2026 06:45:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:21 +0200
Subject: [PATCH v8 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-8-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
In-Reply-To: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfXwi9UakgG/Vrl
 fHsC6EKrJO0v6XaZO1HRKeDhDHfWn2oO+r9/Ltl4Avk7DFR39/CYtqqhSp/gJZn2E6LVK48NCiW
 NZFQvY0YCVZNr6ZMl2VTRIK12bjt9io=
X-Proofpoint-GUID: fAjIA-XoBtIGHjWWVCQ2ODNLT3ZV0BAd
X-Authority-Analysis: v=2.4 cv=FoY1OWrq c=1 sm=1 tr=0 ts=6a47bd07 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX4mn3w/6VfHKj
 irJLLxDilF+Wq3jp5RfEc+KViXGhJzs31WqeG53lqNXHfVBLEuAln7Ny2eEi71WYnNhR9MJ3aqN
 FBm7rdwfhMnB7P2xKitx38g4UY0kRyR789VObge4q13rInhozZfdVmTpELtclPJ9vKrylN4Jebg
 565XL4xumPvj+95Ty2tLIVyR5bcMnEfM2iacMG1lH7u4J2KbhfXM62FqQKFVjB58cALPKlH0UMb
 gO6gyuYoE0vc51vtNQkYDXNKIGWKJsTzpoz2aY8JWhydGEi2X8R/hGlgyDm4EUxVnNsE+htrhtY
 Dc0tgjx/asWsF0oDQb+22t8yztEgiWwcvCh9TjlHcE4i6Xb8nkrsDnmBDQgfRTEoKdGhRVIC5eX
 rx+b8MCHKkf+FExpVlGLqjhWD7/u2dblqDtXU1za0E2qdRiqFlDOSOeJ13lvr8/tP+AHlm553oI
 EkPrzZO3HN3L3ENHBsQ==
X-Proofpoint-ORIG-GUID: fAjIA-XoBtIGHjWWVCQ2ODNLT3ZV0BAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38592-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B05B170323B

When the controller BD address is invalid (zero or default),
set the NVMEM quirks to allow retrieving the address from a
'local-bd-address' NVMEM cell. The BD address is often stored
alongside the WiFi MAC address in big-endian format, so also
set the big-endian quirk.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index dda76365726f0bfe0e80e05fe04859fa4f0592e1..df33eacfd29fa680f393f90215150743e6001d5b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -721,8 +721,11 @@ static int qca_check_bdaddr(struct hci_dev *hdev, const struct qca_fw_config *co
 	}
 
 	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (!bacmp(&bda->bdaddr, &config->bdaddr))
+	if (!bacmp(&bda->bdaddr, &config->bdaddr)) {
 		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
+		hci_set_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE);
+	}
 
 	kfree_skb(skb);
 

-- 
2.34.1


