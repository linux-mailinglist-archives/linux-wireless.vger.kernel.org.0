Return-Path: <linux-wireless+bounces-35637-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJSkHNIx8mkjowEAu9opvQ
	(envelope-from <linux-wireless+bounces-35637-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 18:29:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01180497BBB
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFB3E30C523A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB2440B6D2;
	Wed, 29 Apr 2026 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzRi40++";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GkK2GDLC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EE40F8DD
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479758; cv=pass; b=mcar+NWJqQ6uay3itWnbp5bV0o7RMOYPM5UlWVxfgL/cv6AsYWvCAeXfqxAZQ8HRuyyvcC7Kk6yLl8nRDEBihibv8srSgujW8RGLEHQ2gd4j2lTqaXY/Mp3SRwUra6BfMKqUdwersszos09Btr/5U3HuR/PgTmj0rH/Fu6A0n/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479758; c=relaxed/simple;
	bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jO6KWNjzLMbbG8/9mCJeWsC5uPz+9vAPZgUZlJbV+GaiEpjBPNRM9JUAO60G/1irl7dUs4E+eEdjs4jxezMVEK87hpmQQM75aEBFjakOghedkKEgXTa/sqPQW5kurdVp5hDmKu3ZmZkGPoK0GzIbYtAc9xPZoaPiBccYP74tyl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzRi40++; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GkK2GDLC; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF4awD3066948
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=; b=jzRi40++qm9IKV3W
	DFhl2OnAx5ljK0yTl5sdGb4NA1HEADBLS++TGqlMn+WPdwX2/6sEnm3lmv9ZYp99
	LlEcReCx/bYzwF9NLAtO7bcrJFlciMJRn4aPd4eD+Stm98eR/lZ9R/efJuSpDVl6
	p4AC2qFIxVW4C9vjed4kHsoulcpLPjlt7B+SFd8FKtUQRBzBx/9/HZp7wa0xKWjF
	8rM2KO4apJFk/+YVNR4yaMCdO560y5Z1GaPSB3DeLIl+du/7wdBMFdHNxChQbTN3
	j6zhYqIDgiwDKkVDo/UJGD/sin4FGYQlmLRq69LZ29Ly82bOVP73uBopj5ec+ouI
	5qGwVQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxbf6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6966f1f4490so1134731eaf.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 09:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479749; cv=none;
        d=google.com; s=arc-20240605;
        b=Hh/bJUllHGTLLT8mt3B7R46MVofgOcqqrwLWXlQ8i0mziRfCUL0sY60k0EJpRvnr6o
         goCr0/CrHdwTx+fbsYuwfDWtINYOsAoBCo4c0UrwSDhaREYqiKPJ5RVPseabrRd0XfZk
         FuDhxLk3zOM+q9NHi79nBS+gz7exJq4qoTX1ziZrpGJuhP6Jpc9Q+f1Iql+banXBFAZh
         91FpKLzqD5j8IDi5U1wOl1dAFUCG41jsPn/KPzl3ggwSXkF7Z4QS8FJLgvECTKOZpglz
         e0JXSpcRj1OR4mvdYHit/swLuqFrVpMFh/6rrstjjbyNHSCMlzHN5DM7Levsamj+GQbK
         Isxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        fh=yX3LeQwSrnv80IJZf28MQ8K+I+3kX+WhlMp55aFHDc8=;
        b=XW25K+PueGEG0azW/IpxUfteLs/dAZ1WxnTCx9GN3gZ0z86j+iPkaGTFFVFa77LTAp
         QZbPXvdOoLucuFY0yD6ZNI5KdfGWKco4QbgDVu3Dd49jtf3gVh5ToTf1iHEHQajP1YVl
         0Ki74z12xukbc2M6GQM5WXaVI/5fRMAG+24epC67rEBXhhyDbMwucRlRsmAFBlAG7Cja
         bkg4BkpdbdzOus6qi6XeIAWfshIYgvagykd2DBI4WiTu6ZK2w5jQ7Gp2qSzzMzzN7k4x
         +mBE75ZPUXafr74b+wf3caymlosCoGv7UBlmn8XFYmAo9oMV+iskhJyxgrrh76iy2yLQ
         pVAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479749; x=1778084549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=GkK2GDLCkQqfYx6JvKVq9FxU+hMrvsfGpUfPRavqDCLTUpLBKUdKe5rLsqys6FDmtP
         hIOvvEfK9Q6faBvDu4cyfg+UhizleVr7xWuPGM+/O/Smc7rzLbfFpORp6rQ6R9u9TB42
         YPliTBBJ/jTM060xEkWFeIHanPsz3QjsND1QRwNRc75XReEhwvQYDq/sOJ5sAZqqa09m
         mGS5XsOIV6arpJMMcEf7lnuj1cFn5E1nVJlL9a//ZJIk7eITAA7hTvndy26W2QBSoky3
         Dia8pdzWoCz5Ns+Xld2S5VTzXxMwdwCZB56H5G8oStRP0rifd4r3PNpyuomi6/FBTwRr
         emew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479749; x=1778084549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=YOL9fRVw/BXGPTILEUD0tK5PQvecI+H32UAIq5kLuf3ndNbLiUN9W+HX91dmWuorZg
         fHVW0GA60ZA64CKx1nf/oAIBYXS0Dw31sKuCFPI6BrPA1uHgSUvuMGiA21vswAgSrDFb
         VRwI+7LfcwX3iItpD7YLPMx1myrFCNCw1koLNjwpqv/C5cKtzUC10zFsmCi+/9m7xJgm
         vZQNDFQcWi3Qmon2IpG1a7DLQeAWiGMzLaUsgtg24klyQ+N35yBnMr3xDVvi0WRZwxhh
         ueG9/caD0bNj3yhcQiMfHzEF3XeQBiHqpUsZeSpL0X2iClX0eKv8C0vUouLo61wxFdSW
         B0mw==
X-Forwarded-Encrypted: i=1; AFNElJ/Giatj4/XPJp8NwMiAozx9wFETkWUN8P9kS5MQUuZZWquReYC1YJSVmmoyqxCzLZ8F1TOvQS2t6Rv6be7JEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LPb542gcBwGiD8WiKkVgTSAgGKX7ntJ7Or+nC7vu8CHnO8p3
	I/PionM+3j2y8s33cWlEuxolS/02jypINuSSOyXqiMZkHGV3slI4U0M96WT90TYKusGJyDpMM3e
	O+iH3yjYu8A3u0h0Mg8aAfNtq9T/Weuej8CcsggqnsB5Z6QSnfr86dPO/rncUj2O1naWhOMm/2s
	vLSamG5Mf9wuoiJdrzgRiwG4j/s5WHVXYw+LAdAGPGZ7UB
X-Gm-Gg: AeBDiesK4mv03sTrA7MENyondabMHwNX05f7PsQKnB/lMjpAc/Wjbu5k9DYodG0Sytb
	RPI9NOnnwPqFCMLiS6hdmeXUDD/+VegeS5LGLZN5PI4uLUNJ6JXj2vEejUu2FKNksPR9kcaKMeZ
	MyKRbwZeA7ca+P+MmaXWrfqo2mgyNeucjb5wgdv42Dg0Yat0JKEcIO+h6lgFgjHEZFFdwbUna1y
	8g0mTFKoV5AnpJ5BzDZLeSII3SoyCFnWqbGLW+eEh2EPsgb+g==
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id 006d021491bc7-6966e288f89mr732632eaf.20.1777479748850;
        Wed, 29 Apr 2026 09:22:28 -0700 (PDT)
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id
 006d021491bc7-6966e288f89mr732600eaf.20.1777479748427; Wed, 29 Apr 2026
 09:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
 <CAMRc=Me9G9vd06a39vi_UrXCTkUtJQRogm2MqgnwLS_r3Thyzg@mail.gmail.com> <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
In-Reply-To: <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 18:22:16 +0200
X-Gm-Features: AVHnY4IKbhM_HKhU56A0ru1z2waWryyeh9i-sfRAmlk4QJVuWsNhvXilz3QVxic
Message-ID: <CAFEp6-26sVj21JVECREORdq+UeFTB22MoqAm6Pd2fTosCQau9Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: ymXhhGrU3UaVZ0AONryQgt85Vj_1YRRF
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f23045 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=J1Chn9sQg74BwZjCRdUA:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2NSBTYWx0ZWRfX3qKWufnzYiYz
 FQnb2kAyPlaQ3eIjeerZ8a/Ov4IOGrgRoK/PDiRxP45jkxak9nRbNDeAgWGMBtqJvtK4cTfRiRf
 6d7FE2JYKNOrVIj/JvS7I8dB98DL4yBTzgwJuXEWqzkhGaq1l8ac+7nSICFfD1+3MD23GRHMDvA
 Cyhep8CcWUXz9pIYJA9kNlG/n+ONTdHQlPeeCV9z5VnJRcN4aqgBHSJwEfdTi3bl86Byafb3mkM
 KDSeKCdrsiWhcl2uP+dQHxQDFeEBl9sLYgJ6wTGrJN8sxMcX+aGhIPn9imORWD8qo+4+iaVICq0
 HaK/SRvhppG90RF4WRSmVMmqcaDkbPQVCr68nwyZTlKWEYY1TRa4lwTzu37C83GR8y3Tfs32UMG
 sp/YdYVkH/5NHnHLVXcQ8RCEXt/ZCezT2+Re+vkmoipBoIY3+hejPAdfXOhnwZv9T3jghwDD56C
 CUupYxjk+YI5eKZwtxQ==
X-Proofpoint-ORIG-GUID: ymXhhGrU3UaVZ0AONryQgt85Vj_1YRRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290165
X-Rspamd-Queue-Id: 01180497BBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35637-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim]

Hi Bartosz, Andrew,

On Wed, Apr 29, 2026 at 3:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 29, 2026 at 10:53:13AM +0200, Bartosz Golaszewski wrote:
> > On Tue, Apr 28, 2026 at 4:23=E2=80=AFPM Loic Poulain
> > <loic.poulain@oss.qualcomm.com> wrote:
> > >
> > > Some devices store the Bluetooth BD address in non-volatile
> > > memory, which can be accessed through the NVMEM framework.
> > > Similar to Ethernet or WiFi MAC addresses, add support for
> > > reading the BD address from a 'local-bd-address' NVMEM cell.
> > >
> > > As with the device-tree provided BD address, add a quirk to
> > > indicate whether a device or platform should attempt to read
> > > the address from NVMEM when no valid in-chip address is present.
> > > Also add a quirk to indicate if the address is stored in
> > > big-endian byte order.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> >
> > Is there any reason why we can't extend the existing
> > of_get_mac_address() with another property name and use it here? It
> > already has support for mac addresses from nvmem.
>
> Does it even need to be a different property name? Is a bluetooth MAC
> address somehow different to an Ethernet MAC address? Isn't it just a
> EUI-48, independent of it being Ethernet, Bluetooth, wifi, fddi, token
> ring, homing pigeon?

In terms of naming, I followed the pattern of the existing DT
properties: for Ethernet/WiFi there is mac-address property, and for
Bluetooth a local-bd-address property. So it seems reasonable to reuse
the same naming for the NVMEM labelling. Also One thing to keep in
mind is that Bluetooth has historically handled addresses in
little-endian format, while Ethernet MAC addresses are typically
stored in big-endian format (as far as I know).

That said, a more generic EUI-48 identifier could also make sense if
we want to go in that direction, with expected property/nvmem-cell
name(s) as parameters?

Regards,
Loic

