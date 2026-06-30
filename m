Return-Path: <linux-wireless+bounces-38373-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4AqHHAi3Q2qufgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38373-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:31:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC806E42FD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:31:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kEQp0xcl;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=O7VKq9mj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38373-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38373-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61FA330B165F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF040B6D4;
	Tue, 30 Jun 2026 12:26:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4040B389
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:26:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822394; cv=none; b=A1mZebf7s2NkuiqaYotD/JpsUrzYDJUCf0/2z0EEInWRhFI9OnOIOue92jE7Gkv8b6HrW8DDRXeKJSAoAkv1Wd5SJRO4xoLyPTXZVTtSDCnf5j7qAYkuV4IHMxRgc3ZaVVoQMEca8bE8lrUQTkWDlsySJKAK8M58gqllhrgjGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822394; c=relaxed/simple;
	bh=NoqTc953wGUfCirDeH3SqH5nOnq9U+JWJtIMrbyMGAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILkDkxSV/98I9PtuIk756mHy60ky+yE5NyXliNaTjBxH8jpqBOapppTDFqYh2mC7ciGe65AQMVEx+BVYsCwV5ngjQFWv2+2DhPcrsdD3PYW+q2xvHkNdGmOBDD7o3JpZvKDMoHmYSH+TIJqwHJU5iWKvK8de5PUoNWPgkJnHAMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kEQp0xcl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O7VKq9mj; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mxFo1613472
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=; b=kEQp0xcloYmwQX4c
	kvEzpYrN1l5EVudiD7/Ekt1BdyifNskaaBNsuAayUDPXO09VfiZH3G9rkoNG/8nF
	W4/BwOAxCCgx3DbwpAchJG4MMTgpLsVPEbFPIPRLs2Cd0Rnf6XipGK9EutlPEc6V
	JIHMdAD8LSjmwjJfDtDtObrtEv2erqSfEgSdt0e7alfCGwS+PKE35UXxWJRKTloH
	pPJCM0IvNj4byRf/eUq5bFvN9q4FlvKbOO7lvX2ExBviaM+TU1onx7PIrbIURsdZ
	8/7ws8eoOAKm+tTQvmWPQoxGjl8N+jV0zu4N7hNqI8EQbch0h2TQuauam303UYl5
	ZjQcig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1cutx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:26:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e661ce1dcso15868885a.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822391; x=1783427191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=;
        b=O7VKq9mjwAbhh8yxUfTxeJ8m/w+t22DsNy6X5A0luIr2gpm8nu70e+BNsur5RBMKj/
         C/r6rTTNqAzGRGwvzkpwDU8okBqFWnySSNUnxO+VG46iqPNxl1olhxzm7T66NR4gVo4A
         KoTprlHcIRggnTTEHkeStrUkSGKAGUxCtGdnAvB+1QbowB5/9Kb6OVNK41DzNFcRqVQ4
         cBmEMvXic1fKYoFEJnGDYnpbO0aAW5ggBqK6l/WqcTgyv/uLLru1F+VLvPyv90lA0LOw
         N7BA9KGZ7u8dgJLUiRsxy1HC5I3aBin1XGN2BJrGu4LHPtJxwDlzh2EcMaLrx7wq5PMe
         r9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822391; x=1783427191;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Em4j1rjfTFXHEN5Lun83H7ijLdbaGF+xPI/HxI4Nw7k=;
        b=YHbnonN0N0Irv+4g0I94Xdwj51SLsVn/6uoHnAuo+3fYwMoT7ueqLDDGHjXotTK5nD
         vDZjNuzGe++yPl5NWHeGdUpj5khXp/qu/UgfnCjjEXDE7DA74QLYLxqI3z3UHgAWhtyD
         V9OcJ9Z0spKywYtqjBwffWt6Yy8CVVvWdGkvCkzb3UuP109YM+gaAIYRiR0XdROIla7N
         HHwYqnreylL0HBD6twlz08S83wNl2mBGWLG6a25KnRfbgxkuI/YWCKggbYt4Ukeze+sG
         PF04xbTU2nDLP5HVY1gQrAfRI7yjAXfbyQJSIrXpUWXOZgZMQHh6nqIrS9g4BNH884XU
         GbGg==
X-Forwarded-Encrypted: i=1; AFNElJ9amhcCnBrBANUJwDXHlb3AeE0R1W/qa3uABBAe/Y/hTKzQoHWBngZypvav5FivwM8a/ZzQ4KeASjEZ+5rf1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MIK3+MSrrmTxxgZP8MVv78TH7DtO/EOJMFiemu5zyNu6P9Pn
	h5xjIWoDt1WUnhTNChV7a+Iv/hWSTmHcjHgHkvjOkPVNCKb8PZWLA8a69jAZboavonapmZdezhr
	tUvoKdCizw1OdtIrOKBOvausdDTvx6DsCu14mth1MrIV6EpPrdwjPqcR3cgJLprEmsFcZEg==
X-Gm-Gg: AfdE7cnOTirTmqcaaegXs6yBPbwqrPFU4OIjPABZPEdyTXPA6gEl1m1kOen78QNs/QP
	Ju4BFUZmo8LC6tEeY/4r+2VUQoLtxeFukU7d0StcWX7sgkExEwBF/GOysgjj+A3328Qo8BkBMGs
	/8pyvCejvzIUay2kBzc8SauIXDQFA9NJP0x3A1IVlM6lFanD0NsO18h0iipd8bsoMWhNajQakeK
	lMLFq6v9IS03tNzGnWUqxJai8+1HaYaTVfQCLSZWP53Sl5R9q4GWQSIxstj3nB3l1AXP6ALjobZ
	hSGvy3+vs23nA4nLOF2/Jt1swLHlo2RI7ySKdnpyKIJLxIrPOMXP3msFDzZariGrdBh+owZvnSd
	Hhd9xGr6rhDdShgwRRlbTzRM+Z236sMIO4QE=
X-Received: by 2002:a05:620a:6018:b0:920:798b:e290 with SMTP id af79cd13be357-92e62873bb7mr367986685a.7.1782822391304;
        Tue, 30 Jun 2026 05:26:31 -0700 (PDT)
X-Received: by 2002:a05:620a:6018:b0:920:798b:e290 with SMTP id af79cd13be357-92e62873bb7mr367979785a.7.1782822390742;
        Tue, 30 Jun 2026 05:26:30 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4c19esm116380066b.51.2026.06.30.05.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:26:29 -0700 (PDT)
Message-ID: <e372e66d-7df6-49f2-9530-0c61ad43a18e@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/14] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        bod@kernel.org, mchehab@kernel.org, elder@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org,
        mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com,
        mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com,
        jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com,
        vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, jens.wiklander@linaro.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX1uPdU4p+H7rr
 qNIoaiVBmHOIzeKNcLVgsn1jIUD5JoL7JuRsx8id1O85JUQbsM4B4VJ8di+IPAFIWv+vFD8nWwb
 09iZQfbJO8A3PRk2CfWpTJNV436oLVSBccVMjHfDoEgeaEHeAYp4gEmYKBjsX5g7ysinHkc10pA
 ZYurjZzeuOR1k/uJax9D/UBnA/qr3WIDqZlgf4WNu5LZigCErnpkHOpkTxckNS/3vxkiqKQeOEe
 iX6PJaPUAyzFMS3bM5jULa6onJx1vpoWoeNj95Iv/M13LyORki3xr48a55bDS1c83bAnfi7SFCn
 ByOtGrjSHbo37Z8E0oNx9KuEmbP5oAUVtFXWYKbuqjwD+b1nHcFtTOwAziclXilL6QCkn4JESlC
 Q/bV9Rt3n2KVth5aAjIoK/w0oABSjvz8Dq3r5bt4ZYuWZ7/j8D1Iuxjq39WgpAujubDIFz2CRVl
 bSTZLdAu55QGpxhQ7hA==
X-Proofpoint-ORIG-GUID: V7QmEHrRmO5xGSZ_SiZohqOjvC-9-g3k
X-Proofpoint-GUID: V7QmEHrRmO5xGSZ_SiZohqOjvC-9-g3k
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a43b5f8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=TJYwRQMSshrBWr6rMVAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX2rO3VM+BlgSd
 XOrh5r8ywoWOmJwWLkKD/lzJDgdz54EW8MOVmd4flMwbRO23VqJ9q/nQKgnBaYYpN7wRvFwyVi6
 pDxKGbe4y2hi5+PocPdd7qG3gH9WSvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300115
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[49];
	TAGGED_FROM(0.00)[bounces-38373-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:harshal.dev@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFC806E42FD

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Tested-by: Vignesh Viswanathan <vignesh.viswanathan@oss.qualcomm.com> # IPQ9650
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

[...]

>  struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
>  							     u32 pas_id,
>  							     phys_addr_t mem_phys,
>  							     size_t mem_size)
>  {
> -	struct qcom_scm_pas_context *ctx;
> +	struct qcom_pas_context *ctx;
>  
>  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>  	if (!ctx)
> @@ -600,11 +569,12 @@ struct qcom_scm_pas_context *devm_qcom_scm_pas_context_alloc(struct device *dev,
>  	ctx->mem_phys = mem_phys;
>  	ctx->mem_size = mem_size;
>  
> -	return ctx;
> +	return (struct qcom_scm_pas_context *)ctx;

"please don't explode"

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


