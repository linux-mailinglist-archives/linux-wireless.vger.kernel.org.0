Return-Path: <linux-wireless+bounces-37723-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mGxJMw7aK2qmGQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37723-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 12:06:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3398B67896D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 12:06:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IgFMujEY;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jrXXpDCj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37723-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37723-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E75B311CA40
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 10:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6079636F8E6;
	Fri, 12 Jun 2026 10:06:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2733AD8C
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 10:06:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258764; cv=pass; b=P2G1LRUndsBeYN3nSpjuKgDP1dnJjjNtGlpRv2qU4MN5fAWPMKiRS+fr3dAZBgBX7+XYaERraXCyZEA1p1eN1lSjYEkKDDX5NTZnSez4y2Dw/I83Sb0kMwEcjLvBkzRNB+jazI9J5MspKqlHomGG2PFuaAPeCmSlCq+lyXsYIWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258764; c=relaxed/simple;
	bh=cHw3EhfIxeFggCpzm6CPqEcKG4hAZv5HGwcoAKqnwaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSFtVkkblzIzmXE1Tl1CyynabNYsUnwI/wZ7iyWPHJnE44BG0kJ46jv/9qO1j8NBkNc9Ol4d13HYt5mxQ1SUEmBzYen/tqc7pAyPX/6G49a3lialk3L3LeZItxPK16B6ND77KxxjuCZFb105EvOSjJMxNZqyIM3a/Wu9nX9Gi+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgFMujEY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jrXXpDCj; arc=pass smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3CQsx2452721
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 10:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=; b=IgFMujEYL7nMZWpd
	KLt4YyRgH50+k1NpU1LggBs55SiDEHrC2/PN+/ZHCO7nPlyoEzT+W2Q6BK8LBbmR
	yCFP6p6SX0zKBq5OLLfmZp1tpnnRXVuRO1slxq2z4FMsarT+TYAMGo2sUFtuDXpA
	drZVZb4R+8gJtgY6prfUwMyHi47ZNvlK15W3OkA7E9sECp+s0r8FBguCM6giwm7b
	cc3j4TnyGUf3YiDyV6hYMrMW5MolB0YP+vKbEQ05H/yq7f3IzUnkHzadp4N788ug
	Z32fgVOfw+kG9QHI1EZIkUCeJWo5e77pNo7NA0LP7ntclwZLFH32bN4HLE8YiNn+
	b5HnOg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1xcjrhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 10:06:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517a00fbac6so17441171cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 03:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781258761; cv=none;
        d=google.com; s=arc-20240605;
        b=UlePdDwGDZlN/2dLGY1rcFCWfiNg7O6JbzQBg2T4ZTiFQ8u7IawIPed9KSgVxTPQMZ
         8J26nau6lOPJQI4LtGPiotRQcgJxw86inY/9bp6iT3NjXhVRqdqTrNC+cNlrQ2avFbyI
         WEM+rG219Scxah7HGqveGOUFLMyy7Hm13iaDajnfFzACEPT921RYuMd0QFMK6xYSOAeu
         xI47KrJggehbxNb8+u0zRSAkJEfMhVvuTTO0QGAg83yQD/RCGEbnPPrGQeqppWwYxodY
         tPRpR/m96EI4JlEg0vU1J9q7Zb0lOcRUMDdzx2KPfUteBHOjt5qHhoJJNMdwJc3im1CO
         36hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        fh=byp5C/QuCxi2hLsIovS/878C8cQu4X67zpFtwlGv4lA=;
        b=a/3ucZKk/f2fiT6RP8mi3aZfiIXyocZFgYznp6TN+XsNYm7z0Iwj6FSA0ykyFjqgB1
         0AzBQebQsL7jn+LNV2kwxTnTVLA+sRS8Qxt4o2XJetsIxMyECoCSF9WiK9ZMIu+FPYRc
         Y+NCCjkg1EBxpLUPQuzizvSu1DZLMBd+wSYKfplH7LM397UzIZnrT60LTuEuJogol39l
         fgYKYiITmZXXM0ZAxFc/Xm0vUniCnJ+MAlnVrAHBZmCVOK0v6GqtOm5UBQj4towXRHt3
         IaIuMeEU3ETg/iM8vIWVR19HIKC2zS6lOZyMIok+KyGWV/TLk1UyCTD2hhObEVENbSvJ
         9LWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781258761; x=1781863561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=jrXXpDCjYlmR/QE/APSQ/owWhNoYTZLrMvOFlPQQrCvY8ExSBYsLO6HlqrHZOIOmY4
         0YJCrtSM0irczXc+Yahi1gITEuxyEy42mWeWx9vPDCvVKWWv5dqAf5x7L32+/oF0/IIw
         i1zTsi5J/LTv4xOjU095w89gb1pwsyqGNDjzMMH/nUIyDiVoBOOxL7Ja3EyTdgudbx4n
         +pi5H3wXZr4uV+3gS9HJXIxlYSfpyJpAn3itp66LhwcJTkCGlU+/9rj12vnz+iJPgdjO
         6v+5L46NPty13Pt7IHnjf6TuBVRKTxxxMM4XbkIl6WGi4WUTdI3BxN1LH2/HiAOQiDAo
         lS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781258761; x=1781863561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=GIsRiQCDZl5SRtR02Taq8tzdXXK8X/SC4z41omOGfolSsjevvPu8jjh8CKD58OCA+U
         V6+9KSxsyvXIeSwWG4O4c/yzAxSjoHdhwiMhjg/NE5TW2jdpw2d7C7JMSZfubtwY19/X
         csALXCJi86lQRy3KBtdypj05QgVtj1OXWzyNPpgNyZif+6MgWS+X1s2/HZ1UUZ+QMtwv
         n/K4mA80Xn4QfRx7+WjMteHXkX9TgvJxJeqdvI94AKFHfgRiDoe3ZlLfmDAVInPRkySo
         A8+xXnQIKTja5gYab+wQ0sr/GX/3C4ompAWlEhVviJ5CvfEDmDjvQIq6jVaueWgYz84r
         3kiw==
X-Forwarded-Encrypted: i=1; AFNElJ/plAf64ENP5ra17rdIqKpj7he0igwc+ppq88ELuqjKwFSBrkL5tMP20MkPKvijBqZ7siVw93FkO1LPz6o0og==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvqdqYUAJKlrNfLLeYJnPDZp/qofymiPacAhXu70VdVwMkH8+o
	s/BckDjcY798DHHbRMgg+IYR2/Kf1wBD+ZSgidytXl0kOyeRD0yxyhLkxSSXEChpqrd0Kdg1uwx
	rUc26aXdgySZFjAd13CuPDlJV8x5DgiZqWr0F8e85gbCiAoECp7kvAWwayvAl/QkydOaq8tulAC
	Vi2UkBMiFeKucDqFNBvfJkDht1BBBP17OdeolIy4z231ld+p7bci89
X-Gm-Gg: Acq92OG5q64+PO4IUeHKDDu2jkJ4ifgD9L2Bx76s7jKkC1hSdnkh2Q3z7Gqau3wb9PQ
	QMJSvEeAbBqO6jZXpzZp0fbTHAsChXK3NVFov8u0ahfKKFRKTf0h365MFvsyK5sGWN/joh3Nce6
	jkpFhFw//MSiSVrO8YxP1ZGLKBHvEY6DDwplQs58+WpvJ2j8vL0A7SNtxfo/cZYxG+/vCH+sED/
	INWt+5nY0dDl76kD8kSWToUDAkx1u59G70UvgQ89ORVRqyVWxsDFLS33rX14qJtsCRZmdeLbOBj
	XJr5/bO+Nxqnxum4qoJW
X-Received: by 2002:a05:622a:5507:b0:517:a9ef:ce30 with SMTP id d75a77b69052e-517fdf1a6cemr30902511cf.17.1781258760745;
        Fri, 12 Jun 2026 03:06:00 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:915:bac0:fc2d with SMTP id
 af79cd13be357-9161bc13cc7mr245131985a.7.1781258430139; Fri, 12 Jun 2026
 03:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com> <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
In-Reply-To: <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 12:00:19 +0200
X-Gm-Features: AVVi8CcCaLmOad_JBtnFjekoAUWHpnzgbbLT7l_V3SVx5j2zNp67A6Sx6we9iz0
Message-ID: <CAFEp6-3Z92KNVv6hbG_zrzan4+cP-TCkoc693orKwvQyvP_YHA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX/NarVwp4RWLM
 yeeuYSgjcE/EimSUTo4IfoJ+o5QqsrkTny2YFkKsg+L5mg+jXDmTivqkBO+ZrRdAoVOvOIGcYER
 S5hQ1ryMKJuUKDkg04h8l4wEaezySGDPUDJHKBYr+BqssYY84wEc1Gk6fXvF1zKeEPvw/iYCd9/
 cc85t8cxqC9uPK4aDBDw5CRrdvUkmNEd1HG9FBnozuPMYh+1LkSE4hjL1ToqXzkvblJwtFrG0Cp
 Pxl4FGDyO94akMezDVj9ON88ExCIOnG/KDA0Hap9I5AxucoEILKJQvRxzTJFO2Om57MuOi/mSlm
 fDB6MyxNI1uGp8EpTFMFpNSYz3gsQR/N+3KRbxkwQTGQYLXhUi8ZlXdIUbj8JYmWSOZxO1MgHHq
 S93+2Ug7n1xbfurqx6mTWRvgU8b+FeR+AOwv1t6In7iEvF9e1LXCVWAXVmqnOErHyofMBiO4gHh
 XfoFggK6O3mcc5JwgKA==
X-Proofpoint-GUID: PIBhH5HmfH1Y_p_WZ2hEzlpN8CsWKo3n
X-Proofpoint-ORIG-GUID: PIBhH5HmfH1Y_p_WZ2hEzlpN8CsWKo3n
X-Authority-Analysis: v=2.4 cv=NZPWEWD4 c=1 sm=1 tr=0 ts=6a2bda09 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=dtGr58D_ptlPQ1E9saEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX9KRzVa9n1jm5
 7aeph76cu6122Zli98GKMmTXL+ZNqXpwa9fBaTBEkjRRFYymEbi4/Z6GvC+fhwMvUBQOE4BuID2
 1LI5ZYmicJnb3U+kC41WPG3v/6gG7Yg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120091
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
	TAGGED_FROM(0.00)[bounces-37723-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3398B67896D

On Fri, Jun 12, 2026 at 11:11=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:31AM +0200, Loic Poulain wrote:
> > Some devices store the Bluetooth BD address in non-volatile
> > memory, which can be accessed through the NVMEM framework.
> > Similar to Ethernet or WiFi MAC addresses, add support for
> > reading the BD address from a 'local-bd-address' NVMEM cell.
> >
> > As with the device-tree provided BD address, add a quirk to
> > indicate whether a device or platform should attempt to read
> > the address from NVMEM when no valid in-chip address is present.
> > Also add a quirk to indicate if the address is stored in
> > big-endian byte order.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  include/net/bluetooth/hci.h | 18 ++++++++++++++++++
> >  net/bluetooth/hci_sync.c    | 39 +++++++++++++++++++++++++++++++++++++=
+-
> >  2 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75ede=
b5f6a99fb98ce4cc6 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -164,6 +164,24 @@ enum {
> >        */
> >       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> >
> > +     /* When this quirk is set, the public Bluetooth address
> > +      * initially reported by HCI Read BD Address command
> > +      * is considered invalid. The public BD Address can be
> > +      * retrieved via a 'local-bd-address' NVMEM cell.
>
> Why do we need a quirk here? Can't we always assume that if there is an
> NVMEM cell, it contains a correct address, even if HCI command returned
> a seemingly-sensible one?

The pattern follows HCI_QUIRK_USE_BDADDR_PROPERTY, the quirk indicates
that the address returned by the HCI Read BD Address command is
invalid and should be overridden using a fwnode property. Without this
quirk, even a valid fwnode-provided address is ignored. So here this
is primarily done to align with that established behavior, although
whether that design choice is ideal is a good question.

This also raises the question of why an explicit HCI_QUIRK_USE_* flag
is required to allow reading from NVMEM when the controller-provided
address is known to be invalid, rather than attempting to use any
available backend (fwnode-prop or NVMEM). but this remains
consistent with the behavior established by the fwnode-based quirk.

So, I think these aspects could be revisited in a Bluetooth follow-up
series if there is interest in reworking the overall addr fallback
design.

Regards,
Loic



>
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_USE_BDADDR_NVMEM,
> > +
> > +     /* When this quirk is set, the Bluetooth Device Address provided =
by
> > +      * the 'local-bd-address' NVMEM is stored in big-endian order.
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_BDADDR_NVMEM_BE,
>
> Also, is this necessary? Are the devices which store the address in the
> wrong format in the NVMEM?
>
> > +
> >       /* When this quirk is set, the duplicate filtering during
> >        * scanning is based on Bluetooth devices addresses. To allow
> >        * RSSI based updates, restart scanning if needed.
>
> --
> With best wishes
> Dmitry

