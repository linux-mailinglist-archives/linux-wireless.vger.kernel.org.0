Return-Path: <linux-wireless+bounces-37719-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kN4/AIu8K2oqEAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37719-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 10:00:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5567792E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 10:00:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Be5VGx4g;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=POCygWzX;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37719-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37719-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4920C301C189
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F473E3145;
	Fri, 12 Jun 2026 07:58:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BEB3DD862
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:58:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251088; cv=pass; b=IvnkQCen6zclj/ZmQujOZKq8ECjlJ4kKop3SpY74JnZtCHBFgFoL847d5P0cS+HekMBGWjfq0U6QhgFtAl3LPZaD9wMP8PD70/kv1r1hQAAKFsTWO2ZvYIpxGKBuz8Fhxm4DYmtCbt/HVFVJ8sX5f0Nk3FhjUDQptkw44oGQDso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251088; c=relaxed/simple;
	bh=qE9FqkhndnGAaai2XsKnxnIlLJwWvj+Km/dAKpVTNrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDTdFwFZXeCxTg1sDRse4SVQK75pGVAhKxjuehopRXZ0nnfe/cIG/HMpA1oFJpdGuQFz9emHSh25EFg+Y8imdluSFCHpNHSs47Phaz/1JxKoF7Fv6DV6tFZHIfqNbDABKpMV7byhYOlm8moLv3sqjp+zCpvQVMWeH9SOj/UTMpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Be5VGx4g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=POCygWzX; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39Ko52495628
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=; b=Be5VGx4gTUql8Vgx
	MQd5cd2DNjjeytK/wVvLvtoz/4GCK43dIUZNL2r5LzQm64n2OSWrhgsu+S17nxAi
	biRk5OxZn7ZLEuhzG1n7N1H1hG/Hvyl2ZjPusePOMwVKv9m/jpnfo1fPGG08gdKR
	qjpflDb4jHHwjQa8Hms9E7dNyqZ39kDJ6WjummOJ8TE1sUe+W1gQWbbpKqallgw2
	orSXB+5jHzb3rVakigr3LCMzzfgBUFMlcjyakZw0BgPrmAKnvLwwQHbUHdJKNklW
	3TPJmVF/kb7CIXaZBB5jiYLL1964zpfhv1RNhb8810SNEDTCKV+lesMe5jgvamy9
	2ZUL6A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er0x7jq9c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:58:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915c364ae3bso143886885a.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781251084; cv=none;
        d=google.com; s=arc-20240605;
        b=iR3snMzHKtIo4gMbDq/MFw+qGAgzgChvkjFdwFkWp9RAs5FWwS85RP2ts9TvJg+ytS
         k5h1EGPaMYYhlcrogsK3elrqVFAfdfJP/8fWRu5kEMShaZ8YLq0S5XrXKWdMhA/sG/v/
         uDXn/U5bkHEFMAr7N3qrhFFQmCthzX38tluJV8b/bw1ppitj8yh4iF8nla+V9eBaiz5+
         maw3104fKIYPa5yPkKnilgSgeybrwU+wgtPrqOF4xxFl5tP7Abim6pgVRNQnqBW6SxcX
         YXcnwRpmcN1AjrAHD8Y/eq/ig7dKxC4M7DnmSveCSuNtv1+DWkbOaBxwFl7zhUhEFxME
         R2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        fh=VBOnvrA1zJJzYS9yTdOBOBXCW/8ABdlJbRhpglZrdIA=;
        b=Fl0ujsA36kr8RS0q2MKA00bUFR9AAeUvF8ZL/Q+vPolrkOtRDcxl0+8uhAhhadyNwE
         1ho3q8u+2MXjnst1/qOkyejiox0/jzJmbETTdluGY0AkGQ0xe8kvrBBJ7fIwBHyTkGLv
         JCMG6iCGZZpvYlkF9YWlrZpdOQaXpLAtIq+HvOA6btWF0VGdP74KE3nSDAYu5dLU1S5D
         PoSy4W3qgb6nEfpesOgu1/l3Z0xfH5SRQ4F8pQ41ae7ZGZIOY7KRkwutjfdGR7ztQj1J
         ZHIoWi9dxueJVgK52dy8Mb1FWRpQVHhs81+jVA1Au5jvyyytKJIX44cU5kCRY5IW8KUA
         OCqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781251084; x=1781855884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=POCygWzXRhSGiDVOhcRBLv6GKKii028tspR9dtQ09i0fzdtpSdNHuDevaXhLi6vHss
         ygGYWvQZbhMAC81YgzG4ky6au+Aua6+am2FqMiJhu3Y3LaJ4FGkhOEDPcjsrG6m1KBQQ
         yNBwDK9HoxMy+koaGykJHN6A2niBDo0j5ZUzA8DHNa59qy0PB3Avr7UeTSut7kbfmLGo
         twkUgFRDoX/IYqaGw5P6zSSpiraKk+7uAdgurVbxgLX4MiLriUXStmObAM6S8a8BcDSC
         DgcbBvyIHfUbBW3qxP98JRx1PPzmyY1kgcRfeq9GqcxrtlQqokXWNRSyrn+Yxc6WtzJr
         aTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781251084; x=1781855884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17iUDF7mL5ise0USHzQNeOsFGrHXhTmPVnwtg7/+gNE=;
        b=DIv8HOKXhqeYqvmlUeMeVFyoyT/4GJALCl46xwvmCtZ9uUDIKTck/fpWDTvy0gvxUi
         x7ZUdGBKXOhzcwq3oDehf8oKiiwclAwb3JBCGMIkHUDkVXQAwaKI/Q2LkNtDR+Yo1v1f
         52oP3SNCJmrWhuF+++/NJYcCM9mZhJKgtkCcANVI3TebBRt+Gy+GYeq6kuBJ2PxOMc/z
         5rMNuAtpj7TlhL6ylTWBdt86FaMoVz2oeW3c7oUcWC/RqbTbqF2xBrvd9/N/y/Qe2y7u
         xgV5eaHeetHuQC+Qc+ndx5pV9icSo6HxRDJ8QHbs1pJpRjP0s0s+PSXVc1LF7raYakKc
         wE/w==
X-Forwarded-Encrypted: i=1; AFNElJ91giXSacTrccjjGiMlDsSYMLd38z7h7wUJxbj/q+rYa+hnFGD4haOb/bSGTf/GBjHm4QuKoN1MdpooAZLjZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwcVzh9b864SWFWzsk3NDTnNMt2T96q2yctf38HMGrlTqFcxU
	MTdcWi/MBfdVAPgUL8YLQsUsuaHz9U4+/WVLWQvQkjdI6yU4mGIIHzGxPRkw+bUiV32wUKszy+5
	zNry2e74etsCRE9sBtuxdFgNH2PUucBWM7EJl1qi4wYfipbUdS7EDrV0EBpshheZ8uq7oph8FnU
	Itz+pEQjdhKbYk/jgmh5y9czyAZPCfBmpxIp5ce8vo8yYO
X-Gm-Gg: Acq92OEH/r15G3N99qPbrJ0SCqKrUiZCoVv9FqldCVWDdKB82Cnb4r8KGYwJX39hIvc
	xbGMc+0YJFWqAWzT6eZoeG8ECIDrbGdBRHqj60YdlN1ay26ANO+B5eUsyd2iZhnmM1gXasUB3gX
	jddSA20xOdSzY34F2mBmaqY0A0/UfK5hIqsTek1LqJjLslFoEZdpbEzUYIRw6AVpzl6kFH3hbIb
	t0h+9tjz9Hb79xXxwPgO6/IG1THB+ww/+acrCz/8AKMfqCJsvhGAgCk5leW4SSWz0qCTAq4ZF7i
	/zQ2juUu6LA7mbJ0XjTl
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id af79cd13be357-9161bc5db30mr150537585a.20.1781251084078;
        Fri, 12 Jun 2026 00:58:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2406:10b0:911:1a2c:f953 with SMTP id
 af79cd13be357-9161bc5db30mr150534285a.20.1781251083533; Fri, 12 Jun 2026
 00:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-2-45712e6b22c6@oss.qualcomm.com> <20260610-funny-paper-warthog-25fa0a@quoll>
In-Reply-To: <20260610-funny-paper-warthog-25fa0a@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 09:57:52 +0200
X-Gm-Features: AVVi8Ce9FPbWU1H1fFzoHrS06e66vPYKJ71XBeMTddYgFQq0vpvNpz1VnR725W4
Message-ID: <CAFEp6-0Jqw4HqTu89QVOVtWEYMpNdnd0vYxRyZDgn6oMENCqTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
To: Krzysztof Kozlowski <krzk@kernel.org>
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
X-Proofpoint-GUID: 1AGLNzLV4v00zG4y9pn9HqniWHqh_vkH
X-Authority-Analysis: v=2.4 cv=c4abhx9l c=1 sm=1 tr=0 ts=6a2bbc0d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=HRdx1Oj2DPauqesJAvUA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX4srNoiSZrTn1
 3k2rcsLTvmJysRRjKa7qx1niwxhCYSykVoDTjeDlk9FMSGvuRbjS034IOmEL3y2ewbwR3+//9n/
 exd4+kz0D6JW/0NwS65QZ/d3UXiTXcSuAjtwqrx4jxztr5fxwSnMO7CC+62qbQ1SIjRsKLLz8Ny
 jcnEjlaTwsxhFXXLG5bn98JioexFYPzWbBB6c+xr1BkwVVlNWlLkekKxt4uGKfNgjTWK2Qb0+NS
 epNdjklyXIIKKujrxxBlz/gaAsh61DH1Hsr6TEt+umIbRxSUnUzTkSAO/f7cOQwTEd5seJ2Ut90
 U+eTrea1sSkYGFaw1+eLY+kgArk+nYW1Ua/Lp3pAbPZscii7c3kLifpt/xcHqpMcuXApcf6O2fJ
 6Mojs6Ku83jk7CxnQHuDvZuBlR1aGaYyYUiGpcoO0nNbS24HuwPZT1zeyI55co3P2UgOI8w/OMf
 G0W3mXFWxB+QHU0uFTA==
X-Proofpoint-ORIG-GUID: 1AGLNzLV4v00zG4y9pn9HqniWHqh_vkH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA3MSBTYWx0ZWRfX8KoUANDa8BYd
 1ILkpyhuh5YHeDbGteVfF5sVGHEU0GN4tZvz1Hj+wcTkjrxI9rnyfJpKxovk43TpHBbHkFY/499
 KngQfi1y/8B6zB9hX/i60PJ7IrJ6ENQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37719-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CEA5567792E

On Wed, Jun 10, 2026 at 9:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:27AM +0200, Loic Poulain wrote:
> > Document the NVMEM cells supported by the ath10k driver, the
> > mac-address, pre-calibration data, and calibration data.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++=
++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k=
.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > index c21d66c7cd558ab792524be9afec8b79272d1c87..7391df5e7071e626af4c64b=
9919d48c41ac09f1e 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
> > @@ -92,6 +92,22 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  nvmem-cells:
> > +    minItems: 1
> > +    maxItems: 3
> > +    description: |
>
> If there is going to be resend:
> Do not need '|' unless you need to preserve formatting.

Sure, thanks.

>
> > +      References to nvmem cells for MAC address and/or calibration dat=
a.
> > +      Supported cell names are mac-address, calibration, and pre-calib=
ration.
> > +
> > +  nvmem-cell-names:
> > +    minItems: 1
> > +    maxItems: 3
> > +    items:
> > +      enum:
> > +        - mac-address
> > +        - calibration
> > +        - pre-calibration
>
> This means you expect random order with variable number of items. Is
> that intentional? If yes, please provide short explanation in the commit
> msg.

Yes we may or may have any of those cells. Will document.

Thanks,
Loic

