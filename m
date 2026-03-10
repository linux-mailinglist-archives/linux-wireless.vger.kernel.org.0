Return-Path: <linux-wireless+bounces-32914-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IYjHxg8sGmohQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32914-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:43:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DBE253CFC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B2131DE31A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2026 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A6E3242B3;
	Tue, 10 Mar 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjPwGaI0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="elQzmi+u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38B221FDE
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156714; cv=none; b=LzSdhGiOiNqczIXI3AaZwmzTSCKDPwXs7nc5YAvvVfl4IhIVtsao8s5bff++jboy+kW59U+/Vq8Cw+QcsYJB0AIEAISs+bwpEG3fhpzhfnnge6pHi0OyUvBXze3E/Mxhp7YJefkg+DcSZLbOVoaiSZPYQsCHwCvRfvGqgF27GPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156714; c=relaxed/simple;
	bh=qn6HdgY6LJZeGoBsJBzzPcVWsBF+6hjY8yf5l/xUIm8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vr3ikFwTiNgKFMPG1hktuOBtl5pWUuRD7MBBf/QeYa19NQJ+tIZjksM4yuLxb+2eibl6e9j1rmVeaod6QiCk64VAPHT9AVFn+fu7OfjvSWZwfzxd8cTDrmLWaOFwfBbH7CvL+Ea/2BZ4ABPxI/UY6jqv5e4VNQsJS9rSESC4zgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pjPwGaI0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=elQzmi+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ACaV18024132
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e9uubr04jiUFICf4LMX78AT3iF1sDLQ0hs3+3JTs4tM=; b=pjPwGaI0xwt7H1tw
	EVcvPBUlVxrVH8BQknV3/2BEdybHIh+f+RvOC9QDyu+ycd8XAZwn9atqn4exOvIN
	LQJYPVanlcW6g1IFg/wAl2RK0lZ8LbOKpIJQJ17IDsak/r15Biu0raB7ILB6gGyN
	9f2CoSdWsdFAIjo/5Y6xkbFVEnW8P/DYh8jzpSWvSSbYSQ1qMUbsjiswSdXdopMA
	hjxkGO/KRHmB7KVtZsN+7te3HRsGjOnhqtkSScA6fxdihn58KGQZukR+IsdUp3fP
	DL0Nl84JvDiEkSKIUvm2fWbBoUg87Qhq2YaOgi1HkG0y866kcSZWPzZNijnVfVHW
	6EgOZA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctg5nhhfd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 15:31:51 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d7455d63e4so18932531a34.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Mar 2026 08:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773156711; x=1773761511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9uubr04jiUFICf4LMX78AT3iF1sDLQ0hs3+3JTs4tM=;
        b=elQzmi+uRLVteRBYb9DdMBqNOsdE6f/8QnHSERJUEbJbXlBJBnleRUIZvEU+p3O92f
         o5+tA8KedEl2RWCmPstRuV58pH34eJXgQv1VJ8cQ60V4+X8UUE2VVOF4k3MXviFZVeI0
         Ms2RF8AAs/QJ7STNQzrwNmTI0W6DnOwjtfmGzyWnCix74/rtl2FOx1QmZmJJkm0TC5Pl
         x3PNK7tP1raHy5JBKrs2Mioa7D5orWWM53gYli9u6ioXlwge4+0gK7wZUWXfu+OeC81O
         HlURvBzPD3iDJ8Zb0dNz4H7sWXiCurv4Js7S9J0/yFXKd+Qd+TuM+fdhnW+eP8vg0/u0
         kH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773156711; x=1773761511;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e9uubr04jiUFICf4LMX78AT3iF1sDLQ0hs3+3JTs4tM=;
        b=Z2Xqez7m8hKD+HJ4uv8Q4JkDoEVCObMwCITLDNKnIN6qB/vSUm7DeEXcASc9eJVKwR
         afYzIx3WXtiubQ2ESVrWq2LKZq/G7d4TKosK+KyksaxhuhMz5k6wISxNmu/Zty4u2dcJ
         MqRsh3GChBCr3Wsi/OvuQ3uy5OGzZfu2tY+YogeqiuL1aAwGy9pgzwFY8QjhYuWRV/ED
         Qi3rXmbj5pTCFdw0KpaIdbT9OtNOL00Nw+yMlKB28uAoVgrNuELAng1noRy/A/UbP6e6
         uL7Bazeew5jK1NrJfkQTUs0o6NVt8jWeHeqp4+b3wBnSmwWaWAmNEPHpIvDtv9uXu2Sf
         VSSQ==
X-Gm-Message-State: AOJu0Yxo5VJuoy9t/O7QJibcnA5Ra4vJ/2yOXYG2u+1Xk4UaqxWwuoed
	Beg6Nsev3EywUG2koa3E6J3Akpu+9GSyA9H87yFvtclqCBrCcWMcfBUSmBYEWrFesOpAurKHUEv
	4YM9OCLJLtMgeDGjmwJO6c86U8rvcNkxpP3zSShRFZBgKpr1uIZzxxoEvLIYoATCJd9Apkw==
X-Gm-Gg: ATEYQzzpLguUPWzjvEqU/KXI5MW1Ks//bgxh904reIpK6Sk6FOnAyncc5X4AiGbZRwm
	013RSspe7hC7Uc4XYJiWor2lDmnjyoL8C+ZNWpJPID8SP5+bACEotQxLn0VnhR/XQqeyNUazDoC
	hBOh2L0UPl4tXpQnkkITMlXOuBPjobmx7FoOccjF0H0f0JF+axszBLvylMJCEk+S4HkgTcKi2XF
	dwBbFh11iMIqaBlAkAMz6WEc7mmdZxHNJjwme92byr9sQ13rdYfaPIiACpSolP4y6E9DC70mln/
	LCdE/6hlm1ATCx6j4WsT0UXg6RIGQZG+YbeKPeGL8B8PAWiizTcahNPunuszPiFb7BQCY4d/iiM
	Z5BraifAlI8hZPfS8rlvKQNFSG9Wvs8LZP4mt1wu4cDV2jQVGCcEqD7v0d0GRiaRjHDq3yhS4I8
	vW
X-Received: by 2002:a05:6808:c1e1:b0:467:3f4:907c with SMTP id 5614622812f47-46703f4f7e7mr4567080b6e.47.1773156710663;
        Tue, 10 Mar 2026 08:31:50 -0700 (PDT)
X-Received: by 2002:a05:6808:c1e1:b0:467:3f4:907c with SMTP id 5614622812f47-46703f4f7e7mr4567039b6e.47.1773156710140;
        Tue, 10 Mar 2026 08:31:50 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4671e48c8bdsm1924672b6e.4.2026.03.10.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:31:49 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Hin-Tak Leung <hintak.leung@gmail.com>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260306085144.12064-1-johan@kernel.org>
References: <20260306085144.12064-1-johan@kernel.org>
Subject: Re: (subset) [PATCH v2 00/18] wifi: drop redundant USB device
 references
Message-Id: <177315670844.4092534.9674720074666753206.b4-ty@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 08:31:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: FR8-HALl_5kRMeIeqn7CcG4Ib5K5Lh_0
X-Authority-Analysis: v=2.4 cv=ervSD4pX c=1 sm=1 tr=0 ts=69b03967 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=29jxsxU2LoHVj388i9AA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: FR8-HALl_5kRMeIeqn7CcG4Ib5K5Lh_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzNCBTYWx0ZWRfX+68kZ/rJRhpG
 K6lcnZxOUnY0WAmHPrg3ZcIk1DHHO3YvNwUPqt6cZaskPVHJ3+aBL7cg8hVQMOWeYaLxyr7cisC
 wiFweO7H7lvFb8Gx+6VKvEzBKTnbCleUGY3UZ65lnMc3l/5gt6ZhZzJg9+NgO1EOP0tIglrJLCo
 n6jSuGYYSv51LpA+1ab44nLilZVset8IMa6147BwswmxD5Km/4KclMXHcRVTfP5l2LLG9k11iQz
 Na22k0TCZ2ydUaTzccKG0dr7DOPy+FkLSbKkjuhINDB6K6J2BHQ7+wGnFm+vHQemj0/vY+UGDgT
 a6flVsfEHIDDRenQZM8sggibfPvq2PzM2rTaEJaBmWXCMKwsYfvXt1ASlm+NzWdkMtYycsZgQUN
 LPWWCkDOW2XCel0IbDNsichQfxJ95ek3L91K9unrRE/Wzk3+n8p6zg6bmU6NrwlUJzQ7tPn/B/i
 O+ZA/V3r5O3Y657f7+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100134
X-Rspamd-Queue-Id: 19DBE253CFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32914-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Fri, 06 Mar 2026 09:51:26 +0100, Johan Hovold wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop redundant device references to reduce cargo culting, make it easier
> to spot drivers where an extra reference is needed, and reduce the risk
> of memory leaks when drivers fail to release them.
> 
> [...]

Applied, thanks!

[01/18] wifi: ath6kl: drop redundant device reference
        commit: 86581adf05f526f53b90ebcbbc2fd4d9f9fd4c96
[02/18] wifi: ath6kl: rename disconnect callback
        commit: 0bc013d68a5d1943728d110d759c6587c2b81913
[03/18] wifi: ath9k: drop redundant device reference
        commit: 2ddbec82e1650d57ea0f63d284b5da01d2f21293
[04/18] wifi: ath10k: drop redundant device reference
        commit: c880c0794076f04b0058dd5cbc1f94c33d7bff44
[05/18] wifi: ath10k: rename disconnect callback
        commit: fcc3555fce3c35333891e904c3592375d5e63cf4

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


