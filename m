Return-Path: <linux-wireless+bounces-38522-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L6h0EI5ZRmqGRQsAu9opvQ
	(envelope-from <linux-wireless+bounces-38522-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:29:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CAF6F7958
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:29:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=I4DFLHXV;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=e31IKTis;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38522-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38522-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC9A33019448
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 12:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5124047DF8F;
	Thu,  2 Jul 2026 12:23:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F847DD51
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 12:23:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994999; cv=none; b=C58RB37jeUOS3TXuSR4MZgFSpj9Y8OrMmFgs7rGlxSMiwR+kcaA05VwiAVGAqBQtOn9mNKeZ2g821CPEzbrXvLF/E1OvxzqdBLyS8VtDvB7oqeEfSryIeRrADds6BqEbiEhUGiUWpxr9lfxQThd1hctBVaaHZ4M1hARRm4qz7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994999; c=relaxed/simple;
	bh=saOYySi17G8WfVNXpXK5Fq1yaGVSJ/vCXyaSR4hV5T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtYbWv8cRTFvJTY8RdRuBQbCBZsxx33JVMvi+ZUnUWPmk231NQcTSZFQiwlSnEbCSgVnlsgQNseBymYtVloXh6cM3qRvojS2WYZzfmpdnqGfcWuDA6SjQunME1Bs/hv2A/HmAYOGjfPB5O8x48/730AvTHuxjU97V5P4GxRkLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4DFLHXV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e31IKTis; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629LI4L4117784
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 12:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=; b=I4DFLHXVXlt0GoIW
	dfrRzLqyw6s67krAgqYSt6uR+IDOUqir3lJqb8cjfvc+WfrR06mPcdrVYhASsGpX
	LDWlAIsxrv6nUMWL7UFHqiKKddhfMNNcBJBnT2vbhL1lO1bmKk4ToK3uezaJLgfb
	vL/DWrGi/mTNnY+cPoI8dtbXSokmFzVNVuswHkJ25BRq2wpCA7pwiPvVjqAzsNuX
	FMcUjrXlY84iazu1GnGFSWFmCuDzcq4Psx1TfYpo+zOw7aAYkS173PQq47+nZpsb
	A+bVUvqbOno3MHvb6oI6bCLcJHH5JYvBxquO0tf15x74MISA0/9SUv10GZob+np+
	n23xWQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgp2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 12:23:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c2d2dd52eso1535481cf.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994996; x=1783599796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=;
        b=e31IKTis+pyR0Uv+MnSLJ+Tezc3zIYrf6QuUMUxm1jCReG5senjIARjdc4vXbHJMjg
         ivE0r0HLFxIyA/2frK6a0KyTZQ6mfluCvf/VgjsZ9m0DMNVs+px0hov6aYvarN9J3rsf
         rY9+am5JD83ya0fY9Whg8IAsIgS3RMgneFQmEhFwwiXXJxHcRFcgSCI8ybN1doo7NRQO
         C2CJ8apv/gQ/SXWRpZ9u69NnKmjmtc2dQUgg0kN6coqAEJn5bamqn1ZzSIVrmv5YvaCL
         zO+NNwxJuPRSnrPKzPrZPc9nzvQtuLmHzitnpOjCsOTuiDm8wHCrjx/GTAiMKcq/PGyi
         EWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994996; x=1783599796;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3yAMBOi6v9eV+nAc7eVAGvVNWiyX5n7k7tofn0XxxI=;
        b=kXC6ttYNZQsy7e1/HyLWJ4q/BV8vYWhmH/d8AbObArVIKdoPHW2ReHoxXNZt5zRI0D
         J1wS2tba2hr9fIgufBkoY6OTi9+wuUHrgmh4jyqd1DcTjLNxHCu8lAtH8Jh8efG+Yd90
         HSSNcZcBkx7d/UVuuo70X68gqur1YbR1OdONEI8WfYmGOuGXVyXTm4UdpdpCIhHckiyb
         PgPWaYLST5ed1RiPRgE+Z64lPx5pTbkos+7ZUejxl23MK0AvKwGD0L696Yz5e6g7XwI4
         ioo4nzg+r4RbAR9fJQNn5gvjau9LHzQ+LfTEj4OGXaDRfpsKTatwDA8LmKc2g813EEv1
         vrLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+vWkAlAIQdpVxfY8tEfRcXh1pZg9OkBAHSE3B79E4AsXT4d75aqcf/NzIZr2eugMHZVgY6/eiHcuBb9Uz3mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3dcWicuP7WLqb0qP1Xcj3yyzJ5PAsr/g6mB0xB9uO4jBT4cZF
	qt8HJOF9bGTaiVVydeBBRiowDYyR+ZXMNwNb+WqemYVdDovcThKDRk/QNuFYz/6G6gtYR4cSs6T
	ovexmHnjfvLXs2U7UeXpBvC+xA1SVx6RimQB7HG88ZGucK+aeel1pj8ijNlU21YghGwFUcg==
X-Gm-Gg: AfdE7cnYHTFxTPE2Y1w5a9VWw4HOHNBaPNaF3glZeEIEAttW8GWzX+Xxu7CcCjpRnG4
	XtvJsh98mC0ZUZi4/6d85tX3OYvsQ6zjKUXs1NLmmToGfYL/zsb1GATZZYeoGi2kFNtqoLiryK6
	GOzSkaYCzGAjX8buf/7dpdwtLpCbYtfKfHT704guUhUL8WeewvPgRCurx6neppmWK/g3pZ182E6
	bKUNFHpYpUVthw15hT2oXbtWbQYnKVJQ64lxEUJFR9/gBvE+M1T71ftr3uv0Xm/+sGIwkYuK5k1
	t6V/TDJCiqu+plVNq482WSaMgYRn0LjAUtopi3dn72BOPdj73FccDm81mqKITwRnj9DeReI/i7B
	lJa84DTwVYW9c+oryYgBXV1EZXFkeI1ZeXyk=
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id d75a77b69052e-51c26b3920dmr46801261cf.8.1782994996291;
        Thu, 02 Jul 2026 05:23:16 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:50b:3489:5495 with SMTP id d75a77b69052e-51c26b3920dmr46800541cf.8.1782994995674;
        Thu, 02 Jul 2026 05:23:15 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60545dcsm122833966b.3.2026.07.02.05.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 05:23:14 -0700 (PDT)
Message-ID: <a2e5d6bf-e2d7-4252-8e91-1355c481d35a@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:23:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/14] media: qcom: Pass proper PAS ID to
 set_remote_state API
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
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
        amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org,
        op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com,
        skare@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-11-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-11-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wtJts4tujgVeZgTFyvXo83cNR6rrBDz_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfXwerN59CsLif/
 XvEmm2wL8s5tYISx2s8+0tX3zhTfeUws+Z5msEFiVtSgy8xddwBhcTGWpT8KK/sb2vbv2Wa/x89
 taXFicgHLQ3AG//XdmcnglBC7rwcUzM=
X-Proofpoint-GUID: wtJts4tujgVeZgTFyvXo83cNR6rrBDz_
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a465835 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=d_vIauj3UwZ4nLxAXMoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMCBTYWx0ZWRfX1+ETUeJyzACr
 csIpFisYNBvFb9JYNzJSC0pYWemk4vcHdS5COrNRwsnVJ+Z4CJ1qdhcWR/lU0h39sz1j+rU0UKX
 aiEw6Ksn0ceYINQk4SmfNOQZsZYNaohYQwJcyzXsqCDUmv083HwbPtzENmdaNlXDOdFCijAOWq8
 YWDsl/WEnrZgs+S8LzraY0cL4APyjT9ndZicw1GpfBkglklQdbxa3HXt5J0ib7T4+MNUFSSH+Mu
 fcsm/8a1fPn2v8z1qeRFD8P55ATWwHMkQPdrrwjmXS5xbMBR2nAydGqdz8iDp7GsUK5+eGXJyq8
 uHjSA4LAestTRerW2krA0raA49vMNhIe64ALpfOP4noFegfD+z9yoX8RWFuXsgHPOQ0LxMwNIMN
 hHYCmTqvbSj9RKTBUv5ch0EAObRFT0hbQGxK+qcm4PvHhJb0CIezn3HNhpgNrez4p7FChdwB4cg
 dMIpnsktW+6gSMy/TIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020130
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38522-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm
 .com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99CAF6F7958

On 7/2/26 1:58 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.

It's apparently not ignored, but 0 is assumed to mean video for
historical reasons

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

