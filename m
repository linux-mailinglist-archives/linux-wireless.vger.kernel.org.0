Return-Path: <linux-wireless+bounces-38470-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iy0wNpU7RWro8woAu9opvQ
	(envelope-from <linux-wireless+bounces-38470-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:08:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9E6EF849
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:08:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="Pq5NS/nq";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NWqf3BAv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38470-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38470-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B05130D182B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 16:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA09E4C8FE0;
	Wed,  1 Jul 2026 16:01:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A734C77AB
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 16:01:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921675; cv=none; b=YwKCkIn2bD9mWwXEUYIhukGPTRAlcmdCIX+uzayjzRXsjH5NqEoXzUn/fjpl2Scqzq0s93YoHGE4soI7bkTfqS1kZRHcHp3WH0yT8ceQLzbWB69z91z3SNGXExHMBvh+JzapPmlmv2q53AKalzK/HkuaPWTY3N7TIlsaFvxORjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921675; c=relaxed/simple;
	bh=OKx/GH7ZUq9+Mjfs4xDvFsGX2/Vn8N7/Q0k8/BzXAPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eR4wzcm/Rex7eEOlwkcxTjeYR1s8A6QAwV9kXYhhAdyaS69Ok3pxKcuaLL0E9pWpGwnPDL0SIk7leJMZo9z6dOi4ZBCOEbrcliAiKBwJ6Cm9FebieO7pX4tb91oiQgmrW0LC6s+OxhCsplTN+LGRAZ5KqRPVvYNFUOk9ZrNTdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pq5NS/nq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NWqf3BAv; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo94Y1457657
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 16:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=; b=Pq5NS/nqw8AXlglr
	RFqPdkUwA1KGVsv7K+LRZtwF9K3E1Wcxk47eHkwTdnaldY7gZWQ6ibH3fP9dqRJi
	pbpa0Qh1kylkdNRlU2sHby03bKMc9gW7pcNAAmkJH48C+M/Ba4cjddY6cJ0FheyI
	pukFFt6cPC+ejY5Em3EZrEzYJJdnGgLy86amxW0eQyglo/R93w/eir4Ttv5Ov7+Y
	yhKQsOPbFm8P4KFGopv9y5LXIN9IvvMNq/SSvDowpVFLYJnc8VbvOA01OWsX/Xsg
	ntzgGP680b8EXEOjhjOtVLulFLNmnvCv5G829Z5Isn7bEB+naQI+CzXe5Y1Hhl7D
	7scrIQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f502usqh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 16:01:07 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-737f663b020so313533137.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921667; x=1783526467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=NWqf3BAv9qRIWzZf8h/mF6PFN0IHK/ncjXBxW8NgbMyYw+f0eBh2Mg2gXdz5oza65F
         BlcInuMu6y1BBBMY8w32ode/GwVbWEOx2SmcIql3QNmQixjIOxWA4B2hN86Gk9sFXAqn
         foSXOqlcD6+oiClwlxds03ii2JL79CZ72LiHBboeDEkY5D14D1ypIJjhbZi35U80V7fd
         sMd5aOGb4zNVEKV1Rh31uKmKrHaHJOTYj+EQNoD8rnygQdH1ABk+zxdfjVS75R8NGxXc
         BKzAwWEU17ioMtOP6lfYVaPoW3gxX9lLom2gL4xJIU9ibrXvd+I/o0XFYP/rMWuHA2np
         y3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921667; x=1783526467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=89sO1OgYR++yYy+u1B0OefM5OwzCUQ56NpmR1VFchJw=;
        b=XrOJykLHMzbX0CWD7JBJaGRtdssio0DeN7i2rvwoVlxyCjrKr43a3Cl+3TQy6+K+h5
         teGX0gioQ4yj63Rdr/LBlhLhRH/wisa7ee0rLAIg1OawExYtzHWpDb4i6/tFyodCiq/Q
         HQERANRxn5dvEUdN/dcVnCGiZj+YZmxJXKth410yBOlMcULyrBWY+bLCoHLcMRI9nK4W
         z/dX3E8MmegYEnpzolPvXz6wxE8MDSzfrq4ZMbhQ/37M+w6xtfDaj47Hkptd/KDjMTT6
         2RbxZgkOUnlCo1YvGFWchOUWcNcyLeUOxEzID7HUVzBWdiFNA7BcXNFpBBn0O/CqAoii
         If+Q==
X-Forwarded-Encrypted: i=1; AHgh+RryP1PfGnzwoDBgEGzYtuNW4CoT2h69vyRMbA7bi/3tYheNq75r8wUYnstm3x+P6EGSmVD0KPtN0SUsqdS+XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hbG63e3PJuBrvOfHFuuASpStWDeJP6vxgZCgc66WIZbakMx+
	kTzXXhEb7WZLaJpl/ovB9VwI+Cadk3OTgpE4sOsaZcBYlp/nnJxMIsubBKzreFl1AlDM29Jf0lL
	ZleY/qlz3+hgjNCIAh3OYBxN5jjJ8o0IaWbk6E9y+j72wz3apucifTwVz3tO9MzPCMvJEvQ==
X-Gm-Gg: AfdE7cnOvUD3a9bjSXOnVaWDjRujFC/1GT+yPR7z7jEk40/Fmbo+SUVn1TIQIbYMYH7
	YWaqFFj7T0ZHv4EBDqZZUg4r3NZ/9M+LBfdZU23NO40GSzfqzerfN7NkdDXJAtq46hp4rGdISnl
	elLLli4rE9a2dev4ZwOtrHklDFJqdZJTMR+uoFn5CCR9G28kZzO65dtgHI88Crji2xUEJ/Uokyb
	k4PMjduye2FQ2PF/V/15hCjx1zpOWK0QRloYnWExOJ7xtL603swPqKT3JVIfbBFqlI8SFP+XGoN
	UfFF715vlDY0uIb0MOMVC0CkC0mCGRMBnOuDkOReU/g+0eGc9seUhG7gar6LaqO3avUIefyvnVM
	WCdE5KckBIMG70/OR5+pA3Ay/rsu8LxIEN6lC6D1q6muBozNUIuyBcR0/+vhtFhIDBv7cB2CRyU
	kY8sQHv1OcF7RuKNJVEX5HgckLE1bpZkC3rmDoIoQPaYLiK/QcIaTs37qAEXxm+LQ=
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1034966137.17.1782921666868;
        Wed, 01 Jul 2026 09:01:06 -0700 (PDT)
X-Received: by 2002:a05:6102:38cf:b0:739:d787:be9 with SMTP id ada2fe7eead31-73daa349057mr1034801137.17.1782921665861;
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:01:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:32 +0200
Subject: [PATCH v7 8/9] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-8-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX208oEPulexmw
 66NM5ebOi9p3925NwROx1Do+Z/9uPeUajKvdICs/+yS2KJnRhsg1o2Ds7jXyZmSlc9D4e1c4nsS
 rRHEjhHF8zrhGaQYkxqjdKCnNcVTyxU=
X-Proofpoint-GUID: BvU5lfbHhx-Wohedfh40dpaH0Xn7l-hc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX8gOH6uLaplSC
 w8ehQWkaKrpTH/p8YJ9r1wc9f7/oOnHeM4G7OtvmzXPhFH+o+Ld8E7MMRTLKZK+ssp2TMXGxbXy
 7Z0C+NbNRikZ86GUQngKQcP76LGKXu+KcGMrRSwTD85ZYLVrdfS9fRlOGp1a+U3a/o/QWOTMZMO
 wcQHIr+uktWT6iUQqyufnt6za6Zx3XJagP75l33BL9VVJqnZQ8lX2i3ZOXDKk+j6ALGlkfZxQM+
 hjZ5bv4v1Jvsr9xB5aCrSFWMBu+W0L5ZdAYWgXDsO+roLrYIEJWxyhivduf1CyvR8fS2EhRjTKx
 gD9CLEpvXn6bTf+L42dWOBpRI65wAW+xQm53D0yMMa3W7nY+g4pl3RdRpPeXZftyNDcXsaOwm5u
 mAtrRpoMsqmwhPn0WCPKrcdCZaY1t6PHCMQ6elnQhGQnFRuQfDzBgAloj+gjZPX1KiX2+KgFfwG
 1Bj+fqqURC8SuHbjKzg==
X-Proofpoint-ORIG-GUID: BvU5lfbHhx-Wohedfh40dpaH0Xn7l-hc
X-Authority-Analysis: v=2.4 cv=PbLPQChd c=1 sm=1 tr=0 ts=6a4539c3 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=99fXo_IpyjsNTNVBUdkA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38470-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:list
 s@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: BFD9E6EF849

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


