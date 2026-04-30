Return-Path: <linux-wireless+bounces-35712-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJx1OahV82mLzgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35712-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:14:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A891C4A3404
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25CBE30347A9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAD41C2FF;
	Thu, 30 Apr 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wv4+57bH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LHP9ueOo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955841B35D
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554810; cv=pass; b=EzVNOnBkn2HmwRAI8SPYpLznVCjpQk0hCJ8ujGbEhZd6CjCtt0In6M2cgPzYSwHyFH4zjztnzsBRkClUQHCvcIRkxfPXyzLvN6yA8sS0wV95nly+VVQzUqqzNlrYEs5EsL5MI7H6pzMXhHFVbhpbNVzpauau6I68MnNg0j0CN5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554810; c=relaxed/simple;
	bh=uOBwc+Vl17MdUv77w9tKQsD4/qPdD6T614WQexS4A50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ny5mZHmrFv09t7UlGQVdIDz0m8my2SQrLvCe3SzKZdMMaJNPONM6H4DlvlZ7COjF8AyNsB32awv/2CLL/mL/Q/6jbqfk46MUtMmcqm5C5iVHDZBSNTedWJjeEpsx5PLVZIH7T2G/nOOKP8/sPtOkuWgLlZNeEmLetJ6k1PYzCQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wv4+57bH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LHP9ueOo; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UAN31d142745
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=; b=Wv4+57bHKS59t2pn
	l788D+Bh3SNVywmZLGOHfFpV5gix7UmN+Hbdo/rkaV907faoB34D6MoaRtws6I/F
	v30P+s1u0dEaN27jtCCPCVVP+r7L4EEy0FvbN7cRN35CSHU9XxqTb32ZATl5T86t
	UrmjKIcb1J8hNdRzni/k+tZLpRqGXhoJRr92bkpFOWRdgTmqxOYvkyjH1cO6GXnx
	iRe4KV/oP4i6FXY0oe260zuknkGUSwIURJlJbrNK3gxPYKc7iPfxfqQqhZFkUzNG
	0yB8b1v+rCFij5Gpwopcwf+oxHOaJvlbverrXg4+0dPQ0rN+GBwkFpQ3zascOloc
	t7rLFA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dupe93wtr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 13:13:27 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd5c42192aso4964907b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 06:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777554806; cv=none;
        d=google.com; s=arc-20240605;
        b=aA77QVHeujO6QFjIMK95pkU1sHJnBVAAh2etGp4YSFPIppo1M1rdLk6wdmYKy8iVCa
         e57z44GGwfFrC7qrPhgaC7oHRzhwdHbINvE48LaKnH4Pd7lzqy4ZvgphzYsCUk6QjhjO
         33yN9LNXGoRBloLmG+ZUV467TmMJwHHsc++XjuQWEfU0QMw3kiXM6iSAzU5P5cKvpgBs
         MrvihmE2YIHS6t9qyCIHTdNGjQ2Bwu4NGEyDOeptGv5O2nwyR34onl423pZ1ZVRC0e4r
         2q+0qS53gJ4vyMZHQx5vBZy5Tj9M44w7o7irQJn6IPVGlvI10rVvD5UO9ouuVQBnlXRd
         SuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        fh=9ty+4u89ZmYuXsYbWiGVa9d9AN3yXYLI7RR6kU4FPhg=;
        b=h2izW39JhCqVx8YKjw0rNIx9u3zVLyI6lPDeC9ZxtSbiIqL3GApMn5Jhe1NCViitZu
         H5o2CNkQKDT+Z6t3YZw/sgzc+xR84GqG5469VR9D+Ng6g9d1ghCEXFZRaYPsGyVGyXkX
         PTyqTcJLhRxoI7A90jUTMjhLYCHDAK3WiW+TJJ8eBx44+STzK/44WOcZOIVfngiOjbqT
         KZpbWJDsAfaMVu0JDiTt9ri4PuwF8fk+dJok/+nSUs2gCzNayGVZnUu3JAS3jnsGQzgp
         808+bQd1bNE0NVsLACSbsPDDDz4YQYTHXP2xx9zPf9Brv6Ro4eFdi/bGDMOeIo1mdmvA
         GLTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777554806; x=1778159606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=LHP9ueOo3qidJ3OGymx4dHtfklBphqyzE6G40+goDEPKXkGj1RXh0McPXSnVp+gL0Z
         N0tj+v3CJlSCjERetGDN7mTkffcxwtObrTjFUqpUUdb6DZgrdykEbRe1SVWiiBCTjz7w
         dXRA2gkZcH609pSYrX0bzEBZPo/xTEvAC3669nLgOTCaYQymmQ5kK/KZCwGWFkY2on48
         9MEcBsdW+1kzvMZFzpESCP9lZBrRv27ciqFusE1qt8XUcihnCTx+O+8hAOxeryoub08q
         WWYTXc3j9IoLo4ELrljhwZcCNjcx21ed0a/Q4VDBQqnBStTcwambybeqvemsnyKSWwKm
         FWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777554806; x=1778159606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TouSduUFbw2zfEHACuqETKI0j08FgYQyPnYjBVsGXhs=;
        b=TX6WlHvqD/UvaOndGSUwfVp3zsL/dakCm5cRCLztkuEEEv4+DZvVFw74xKAyMW43gD
         4RQYWaM37TwF5fnbOc7iVIPDX5wY7kJcBzcYEmH2Jyj5e2K3Ex9kTizO5nXHTuKLsO3m
         qUkHOhN76lxHBYS8Dj306QuInkgiPp8KOfrumYan/Tf7AbJqeid8yYo1bJThqg9n4Xy3
         AXtH2dYMcitzPSi96BJPbL3Kx5idrf0yww27RLuvAXd4aZQGBdT3wQhV+rarRN3EcmqU
         MzH6s32fGq9uqs4WQkqQOrIL83BxO5pGDRgl0kLyPxWaiZEZ3B+k2RGa/KZrzikpdGI9
         yeag==
X-Forwarded-Encrypted: i=1; AFNElJ9+6nKDB57tN07pCMV6U7WQ/7FvbYE0Ew0nhZvP9Hqf4KjHbF2zamL6SxfBnDbtCoRAd1U3CsvYSrBI8rnQsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCRFqp2+mPKnmUAphUR3rvl1AhuNNlO118erXXoGt8an3R6xoR
	49Ak8ca1Lr0wXpoh9ApvHMh1MlFd8rrfu4YmLi1rVvSlOMlQkj4MnIy01TKlwnRmE1ZWho/fZUh
	9izQInqZOYDOT+XvQTz4j8hRdi0UyaTq5mrx5Ue/l6HuTTKlOyV0ZvQwkysJedJzvm9bpjK0czW
	FaEB72ZBQy4jxyuPDCd85D+7UD/qvs8MIJM9kqtDM/9X6S
X-Gm-Gg: AeBDieu3oPj/vq45vmqfrkrPQrQ4bUXK4wykzvtcUUWofkwtCo77seZJxSXOQi3SGL9
	044maW29BMNzPKQI7dUCa7gaLnuERv9a/rl8f5vydxLetxs70I0FP2sffs9pq7MhVysOFzNWk3H
	7mxbChRKfUCH2i+Z5PjAgChzRDaIHcv0VQ9cBpQ/7DxfuvQWj+K1w6N4Cq8f3QzsqAB6ztp3yoe
	R81rwuH749yhNPwLB4g5PECwE7c+thDDl28s8BLZ+wLbLgWYKI=
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id 956f58d0204a3-65c1b0a4185mr1181517d50.27.1777554806655;
        Thu, 30 Apr 2026 06:13:26 -0700 (PDT)
X-Received: by 2002:a05:690e:4299:10b0:650:ece:89fd with SMTP id
 956f58d0204a3-65c1b0a4185mr1181471d50.27.1777554806063; Thu, 30 Apr 2026
 06:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-1-6ad23e75190a@oss.qualcomm.com> <20260430-bird-of-sheer-ampleness-744e7f@quoll>
In-Reply-To: <20260430-bird-of-sheer-ampleness-744e7f@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 15:13:15 +0200
X-Gm-Features: AVHnY4I6bR6fdSxJnXBrJdTY4FKOp8Nu9g27U_d0aw_5w0XdML8zMEtBVrvqIXA
Message-ID: <CAFEp6-25Xad_LT8L-HPpOpXf7j1S=Vew=iSgxEmAHd_on+jkcA@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: mmc: Document support for nvmem-layout
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jKCZmDcYY_Vd2kf31qknBChhalHwoPgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDEzNSBTYWx0ZWRfX33a6U40m1And
 5mM2K/ah65ll6/25vUmiiWbHQxO/eapj/PfyvgsTydWgPc2v8vrqjEB4ToEteyTYbRLMFHGOe/V
 oIH2e1XXNyEGDTT8E/XCSKQOC3olMeyLCGHkIsf6bKXoOTIEueQM8b+yWTlCYXnSkuGmC1L5kM4
 1FomWIUoVvt5OtNar3Wdejjttvg6DO+Ds4Nwdyj8X/io8XwPPTf4JzU3ZlZOrs0VJhNACmQLsH5
 sCGHKps4jGYrq3+U6ZB6au8ttwLHkKhFiuMlVPxxktgi2Un5hyujeqoOTESDk/ELI1pJp8SqKp3
 XKyreQqbRyN1wxgWF8F/h6KtNn2rtvbvCwuAp/488NKejKqaZZqQNfjnaa7oVbt5m+xcUuf4phj
 g3nuHKGP3z0WjN5BEfo3TeiRs4+u3oXEfg4NRzeqWhpxyQl0nHns9MgaZCzPw+oXfqtmOE4vasw
 g4mZ86iyTzwwAfUbFDg==
X-Proofpoint-ORIG-GUID: jKCZmDcYY_Vd2kf31qknBChhalHwoPgj
X-Authority-Analysis: v=2.4 cv=PvmjqQM3 c=1 sm=1 tr=0 ts=69f35577 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=Q8QnmAOcOvJ-T5SqZIoA:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300135
X-Rspamd-Queue-Id: A891C4A3404
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-35712-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.17.48:email,0.0.21.24:email];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Krzysztof,

On Thu, Apr 30, 2026 at 11:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Apr 28, 2026 at 04:23:06PM +0200, Loic Poulain wrote:
>
> > +                    compatible =3D "fixed-layout";
> > +
> > +                    #address-cells =3D <1>;
> > +                    #size-cells =3D <1>;
> > +
> > +                    mac-addr@4400 {
> > +                        reg =3D <0x4400 0x6>;
>
> This looks incomplete. Why isn't this mac-base type of entry? And how do
> you address it from NVMEM consumer?

This indeed falls under the fixed-cell/mac-base type, thanks for
pointing that out.
NVMEM consumers reference these entries using the nvmem-cells
property, via the corresponding label/phandle.

>
> > +                    };
> > +
> > +                    bd-addr@5400 {
> > +                        reg =3D <0x5400 0x6>;
> > +                    };
> > +                };
> > +            };
> >          };
> >      };
> >
> >
> > --
> > 2.34.1
> >

