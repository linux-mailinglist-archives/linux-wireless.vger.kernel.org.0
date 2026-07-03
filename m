Return-Path: <linux-wireless+bounces-38593-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NlmNIzDCR2pYewAAu9opvQ
	(envelope-from <linux-wireless+bounces-38593-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:07:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A6063703400
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 16:07:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=m3ZeXph0;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MfzaYzDX;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38593-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38593-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 149213090EC9
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE693F2113;
	Fri,  3 Jul 2026 13:45:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC53D9DAD
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 13:45:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086349; cv=none; b=O2BbfUrl+thcw0nSLNRPxoTKVV549+QjOZ/wMKhW528lCY+jLjaMlviv1Gx/UxZyrGBpc01YSMpssnzl5cu94AgW1P2zFA8HOqRcPN2E6IsPI6fO0kUYwzQIu2Dbpu1pSOhPC8mTJZ+gF4q0IpllGeOQLI6QvB5Iqid5mEdI3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086349; c=relaxed/simple;
	bh=WoEsQQXEHcp3Z4NugaMqCjtqYrDzpmWHIggHogkIi2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LyD7QCQfmZcMEC0+V6ozi3+oXO2jscagMDRcb7d7880OGBIOSwbDuTiA3vKQAOKZKydk1kioRc5PanJ/TbN9l+m38eGjd3gvTaQxVEZcZRNgE6cPj+Aj8oeLwzXy+G/I4t9eMKyydgTi18Ct2qoVGMv5KS38W6x/lGZXI8qMk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m3ZeXph0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MfzaYzDX; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BPHF63135212
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 13:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=; b=m3ZeXph0qWHngde4
	cyKZge+jjCK5fC4rR9gZXCNMwv//46MvW0g5T3GTreKkoX81ZKjiGv2oAyBuI3J8
	AWDZ7yFrfxrLeyTltJ6MAyeFz1owlPAK3WMFy1/csjR+M6n+ZtfDY620VL38nM2h
	dJzUsWvGIC8BIEz8vc5uDQBGjV449EYxd1mORNaVVPAgD7kyEmii7WOT6T9SJhFF
	Iqhv18Qe4JGzwPqYT5En9tvzwEm++OlruahreWLUcXWodo6IduWS6YXkoMYvuwbf
	uX59OIdL1VpqYEIRfNysL+zWXfKlJDhp6F4c49B1EP5NfVFsPBai7e+vDDgF4gD9
	qOUvdw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjb50-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 13:45:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e52306621so43942185a.1
        for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783086346; x=1783691146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=MfzaYzDXh/mKrdEJnjOkXdyXxAVCSWQr34fv6GSTJAx3m1PEV+q9LDmM3roX9QEO+r
         Wr21a4BGCMajbUdW2UCj6gSvDlyh+T5vkoAsIOtIZ1sGLmT1PsYIlPt5WYZIZwj/e11D
         DdxSxo2J4PMotXmvXEDSV8O6XESSsHyTnX5oLNOsTHe0bx4UrUTjShLNwyHwPa78a3++
         pXOWRxdXtYawCHYswASLApm7Km39Onblk9K60wKcGRj5Ft1FWKis7UDQfZWbGYaMs7/X
         rSGuv/0pwWvia8dn1Q/MRwQcfAg+Xg79Z3acLyzdd2FlYzmZyXwSgjYAwQoQM0iQK63H
         dhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086346; x=1783691146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc77KXcNF3bATkg/J0Hcy+3fqulP+axrKTzQn99rjZ0=;
        b=bSXQW250MOCpcfFX3n0l3JlLqABpuiuwtwSQ4Wlf/mLKl5IEkubVLx16h0wx7RwPLR
         C42zHkC/tbBLokq6I5hzXqRN01zSUxpQTqoYVtkMxmdRwCmveZvALpIFqFaFwjuLI/rQ
         vPUSPZ1dJZZFTy4KgkYkgnh8MEYRWpQaO5qkz7uTeKmqNPSxYM09xGVEy8q3+7DzEqEW
         y9Z6oHiicGt+/D5miMKiSrbOHX4xD8y8tzcmP94sM4weq2RdC7/oDY1bwh5r5EiXKt3/
         o2EopwqGla7x6rt66Lm108YNaQOYly2gHTIepkUj4pWlOPar+AcZgZj9wZkZlr4yvO5q
         7W8w==
X-Forwarded-Encrypted: i=1; AFNElJ85dW8azlz418BMIksKjjwREvXvvlA5VythoM9ggHgW8TJqCs4IO0pq+js3UOP93XIu2d1n1DEEZ3emvHDUeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFlz+kFA9yOAKwVPHa72Rg2TFH+fuA8uQQZHZQXCdAYRhwl7o
	OKsvEY8o/6L2FXyAn+uTTLrdd3hoF7n//OjkIYcyORuJuFh86DpO8bwDnWDNoNSls2czG+QL2eK
	YQ6/6G7yGE+bLIkF4bmrTstQrMu3mnz/k2opxgtB3V5hbfMn1NAPSvLi3Denu4ad6wvda5g==
X-Gm-Gg: AfdE7ckESNwuXyPOjuNRRij8uFhsk9Aimo3btrsm+Jr7GNRO2Fj9o0psn8JEn3Fm2mU
	5tRHIrrEncB/fjP2TvLSnjLugf2WH6KditKigDytT2z7PmXRof319KfQtZq7jOJ1EFLI7NQAJcr
	xVoiaoqvhm3N6Ko08tH0GPFx38SprC57c6OsZiNn6X40XC2agx81R5YNbG4lNCWFUe16wk7Tfce
	1cZgPHOyMarrnRtZpd+86P58DVkEbc++iZNpBktzZK0Q03ByvougnX1c23PRuC2ce1JODGy2ciJ
	ouLnr2Tjn/wRflIQp0C59F4LgS3+5DpZPgqkdgDB9erN4JzsHGe9Rmtvkw2VhedLJcXKy9+4qoq
	GcMIDFBOzm16dywfS0pYNHRdFxk1AmpnrcHPRehXGmNAN67ntEyoXod1OCeSN8lsoDXRRD9bFiJ
	nlPFBxLZ6j8nF2gPjBWcg7PuVlivsYvDXvBlGiI7z6j4WIXsKhT9U7QeP0NiGXxrw=
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407958485a.12.1783086345662;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:914:d093:abbe with SMTP id af79cd13be357-92e781d3eb5mr1407952085a.12.1783086345170;
        Fri, 03 Jul 2026 06:45:45 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6059e4csm286135466b.1.2026.07.03.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 06:45:44 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 15:45:22 +0200
Subject: [PATCH v8 9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM
 layout for WiFi/BT addresses
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-block-as-nvmem-v8-9-98ae32bfc49a@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: lCMeszjXBZvrcVWb6FcyqB3FiTwlACdo
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47bd0a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: lCMeszjXBZvrcVWb6FcyqB3FiTwlACdo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX+XAeljJ1p3Ng
 HTlzJF+kEuVLNh1Rc+wLaYvUI74T47tT3iPTqWnheatRpWMxE3Gwj2HooOhI6d+PbYfzp67WR8A
 PTzBDHe9WR384Td6c+8QHYEBnqqi30fX8+p9+xnYd9Ns1zdTiuePjFM5z+5Lb/zgV3/AZfYelxb
 dvyOSA80bQzVjpY+oV74FR3vUkIdVMeLLhCDoJ+Dz3r/RVmyljta2K0x4QDxBuimSns0+qTQLrS
 AYFT8WJFww7pM4XSO6TbgBVFEhOxVPN0/XR8KcNebPIdQChKalCmHJ/80tFVIPuLtTftv8mB6jt
 2/ds3Obt46MAKxWXpkvL1Pza+bf3zQzPZYvLgbiXIXb7ahRg3zeC2t6+X9Ai/HY4NVddcKQ6WmZ
 +TPVsiT1tqPUXiKRv/Zybn60W/yOAprEB9eng6v73kYIx7+u1l5o6YLCemIu5QS9BKRGVrNJklM
 ZeoToIa7l0nvUo/x4qw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNSBTYWx0ZWRfX6AZeCifcN3jY
 5ter3M6ZFbTKa2lAMnYnbNgpyIZHo79J8nQWd9GK6qs7FIZKQRPB+r1LXhfgDzBc7iSoa9ONIly
 r029BqoUuAF4xMtHa02h3xtYFkj1UAQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38593-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel
 .org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: A6063703400

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are relatively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and Bluetooth
addresses, and point the WiFi and Bluetooth nodes to the appropriate
NVMEM cells to retrieve them.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..38839b8a361e76f6c1989924b16095b9d8815f66 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,33 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wifi_mac_addr: mac-addr@4400 {
+				compatible = "mac-base";
+				reg = <0x4400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			bd_addr: bd-addr@5400 {
+				compatible = "mac-base";
+				reg = <0x5400 0x6>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
+	};
 };
 
 &spi5 {
@@ -512,6 +538,9 @@ bluetooth {
 		vddch0-supply = <&pm4125_l22>;
 		enable-gpios = <&tlmm 87 GPIO_ACTIVE_HIGH>;
 		max-speed = <3000000>;
+
+		nvmem-cells = <&bd_addr 0>;
+		nvmem-cell-names = "local-bd-address";
 	};
 };
 
@@ -557,6 +586,9 @@ &wifi {
 	qcom,ath10k-calibration-variant = "ArduinoImola";
 	firmware-name = "qcm2290";
 
+	nvmem-cells = <&wifi_mac_addr 0>;
+	nvmem-cell-names = "mac-address";
+
 	status = "okay";
 };
 

-- 
2.34.1


