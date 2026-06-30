Return-Path: <linux-wireless+bounces-38381-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YG8BOWi7Q2osgAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38381-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:49:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C96E46F0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 14:49:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=F3n0sFhN;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=UedqZOc+;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38381-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38381-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7922430DBE43
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB940B373;
	Tue, 30 Jun 2026 12:43:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5440DFBD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:43:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782823424; cv=none; b=Dj9MC83qlxBWTrf7s5q95InugnE51VWgV9w7+NYSUzXANKV/qOX+8IzQXfoNDa5uTdEcglEjgtc6xCO3FtS8dky2Higr1IFY6fS6HoDPlZu0fqTSNIyQJZj359YrT1QiRocvxrdqafE1/OMhLYTP4QDO+nDElg8ZwGhM7PP7+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782823424; c=relaxed/simple;
	bh=BgY00mBvxWkHejgPkucyLWTBpsCWCY5fK1NqMPCqd+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC9EQ7xyw8V8emMdaFExC/3e/TyNhb0L3HPGEl5DNmx/zzy4g5cehLtNYtbesmjhDpHHJzrFR9LOHCAUVvpb7au4GblmozDgHtY5JV5txfrMneQyKaWQvDYtIwddigQ6QwRulzSrrb2Wvl61wsAqcShM7bubCFn694W3tCNzcYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F3n0sFhN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UedqZOc+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mumW1604818
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=; b=F3n0sFhNv4vOtoPY
	BXpZieU5OTwgT+HxAP0Ui+awldHBAbEr4vblIJ9IdeTx7g2gtRrx1GseILh+9/Zz
	aUmOUzW30aW1DfxX0b6aivoylCA8dyu5nTTHJxTXKFcXYQeJpUqRYcH+cRLQPY2L
	mgBawKtvZMT/4MLeuXXScRU9UDEzx2vtpgQNU524wiU4QVKVdS2TJuOs1bU1B4gY
	PP3d9nugzR1z9WpP3ZipFIsVzxeM8o5ivIptJ8TRF5ogVjGNk69Bk7kkhKrB4KZH
	SX87UJJTfzONkxOeiEhrA3XT5VKplB3UT3HP8JIyDOMh/eDIuUKMKAkX4IkMSFbr
	Mib4eA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f43vfjprx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 12:43:42 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5bd933e15a8so173597e0c.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 05:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782823421; x=1783428221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
        b=UedqZOc+rqU/MtSH03B7AJY779it/pTkJP4J5i28GgIC0o8ho1o3hdu4M12l3vyfjN
         kbplrwRR4jfH0cFYyJzfnokej6LAbjM6XJQ3iRiaorwK271KhRx313fiiDeJo7iCRz8g
         VIZPshhB1UvppaFlaV2hZi5NF2mjdfCVxJqd2ZagYf/sjh/SIZZ50IZ7jIvogIqfZSX9
         sMCQQRJMpzeUwgcDy3NZ1OIdWSgb/8a7JlIC1kQht9dQIVSEzXt0B/R3wo5fFUn0fgxr
         tUVDb+oBKfz81nK0FtNw/e66791FhD5e/BrMVGI5lxzBOZlJJ0kviYWKk0V374K5Ja06
         SZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782823421; x=1783428221;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=40HebzjMVnQxUW0qFO0coiRdTK0hbU3rpwuRRVO0fek=;
        b=L+9P7oGbB7bcX1YAoXLQNzIELlwXKmPrJipWKfx9C8LR4k/zZeDNtw68ten7fcezVy
         ABK75LW6jTb2SeB0t/TtgP0T3WfAvp1XfFz2qWi+HffT5E1KFuQxKLBZfBuKx+rgJJTl
         IxNCTQB9R/KMSH+Zn2EckVK8rt9y4fVS/PB0/a/uaAEGglFZxX0yD+cmBGpFeKDJR8No
         ELfbfxUctkFxXEkaFm2KWXJO9bdZtitMkjHTtFYL4pby4ug2ynwWWIC+l5wk345qgGoB
         k2w2Pjb0M5GfQSz+1yM2mEWgh67INC0Z2vtI5udAu3NIethhCTRF3AXPcfaKXeb7qWka
         um1A==
X-Forwarded-Encrypted: i=1; AHgh+RqSorz3ESpXYoj4TfERGtM0AmwvRc5g16jega1Bb+G0F1ttNetbGMyjsw6ZrXVRcabxHEgxP+NuDxriEGCVqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS5dOAjpJnkf00Lqzkwg8SCV7nqmHtiEtxVFrlKqEZIcOEA6J
	62HDHA4YD1rtx5Ez1A/UZ3s8xni6MqUKYSV7kdXnAMcZW6POLs7iXTnkAxe89B1Rh//1QGMX2/Q
	VC9HXqxYWiNBoKAzfybxnBEx9NDxqJjVnlMJOVnkLwFlODZzYnLD3dZzE21n1bHJEhOkHKg==
X-Gm-Gg: AfdE7ckjEQwWvwHiKSAKuigNWcwYE8QnE6U8fXVrCHGLPkdMZOzs1n0PlBsdbNvFvOI
	HaB1GCX8pxZfSCpHStceo0VSNjjQu3Amb03pT/mP/AWPqe3J125IrWBpPfhMl2xELGbdtE9Hve/
	TDxa3IhmaznWIrbpQYR0G8es/boNVfHG+78Qa9bol7wYUThuDRTezwdohlDN0X+79M3Rv1Vf7r2
	trn2EDi0DVpvcC436I7fjs/6m11riNDD9cyzkCVRJK0AcyyN/KH16DmVDwJ9M/LnV2fZz+OJEXM
	DpRYScYZBTJvq3TU0Ike8U0eD7BTD9gB7K7hNBk4qJ6mwv/7Y/pnwLN3yy8pIcutT04szVGsuBD
	GiW9FNVAkXkiPZxQeuER4YHziyICul5ywFlI=
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5bdbe9a7662mr493248e0c.0.1782823421013;
        Tue, 30 Jun 2026 05:43:41 -0700 (PDT)
X-Received: by 2002:a05:6122:860e:b0:5bd:9cbc:93c6 with SMTP id 71dfb90a1353d-5bdbe9a7662mr493224e0c.0.1782823420597;
        Tue, 30 Jun 2026 05:43:40 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6987c968400sm1127666a12.25.2026.06.30.05.43.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:43:39 -0700 (PDT)
Message-ID: <e05fdb45-0ebf-4dee-8d25-05dfc65042fd@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:43:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/14] net: ipa: Switch to generic PAS TZ APIs
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
        Alex Elder <elder@riscstar.com>
References: <20260626133440.692849-1-sumit.garg@kernel.org>
 <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260626133440.692849-12-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Rk_mTUppCHWQKdBta4InwO5KcN3L0xRu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX6Zj1ZQeC8GMm
 /I12a5WFUE8XIYxnFEiN3in0b9lH4ydw6Ax0ejsMnrEXc3SNIGv88BpNINHLsIlTbTZWX5HXe8H
 gzH9AUq/wngh6mH4uo5oDzap4WtXlAvS1YpKplCWH5FGrcvJS6LJynGPvd+trGgmr/FtsbQ52Z4
 qODCrnRr8QvAGLnIkUnFmh50pRZgPyK9mQmbef3y6bFV+MMDxklkERm5AObSr7dX9791HPbKY/o
 CYfMf4zIPAY0brw/rOkWcoN/57B3sK6VUK5gWmNjqPSokVqUq5rOhd8zmwpSmlWnl1fTW79flQE
 72GX/d1f+7LpeTS13Ix/FYpAt9b2iGQ+PjoaqqBwY5RdG097WDylnzAJQK1gIpum2vXV2+Z1hXd
 Iez6VknIi3xIDQdeu6X/owQE67qS8cFSLZwL2yN8+nsP3CTdABN/Y0fuUJy4ZT5JRAHdGB0wQX3
 AQRWGCQpkuEKyRZWZng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExOCBTYWx0ZWRfX/kyW642bi4wx
 IK+pUCSNBp4tn/avHi3+9Lmi8t0eqTLWcgTUcp+sCfXdyIEQGZQyy7InoyzWOhp3c3j94B7SRAa
 Skn8wTOK130wuJgDRp+q+Tt9l/Ok52I=
X-Proofpoint-GUID: Rk_mTUppCHWQKdBta4InwO5KcN3L0xRu
X-Authority-Analysis: v=2.4 cv=PcXPQChd c=1 sm=1 tr=0 ts=6a43b9fe cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ee_2aqc6AAAA:8 a=smRyAmGWe8i0dDVrb1gA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300118
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
	TAGGED_FROM(0.00)[bounces-38381-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:konradybcio@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm.com,m:jorge.ramirez@oss.qual
 comm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:elder@riscstar.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,riscstar.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,riscstar.com:email];
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
X-Rspamd-Queue-Id: 490C96E46F0

On 6/26/26 3:34 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ipa client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/net/ipa/Kconfig    |  2 +-
>  drivers/net/ipa/ipa_main.c | 13 ++++++++-----
>  2 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 01d219d3760c..a9aff1b7977d 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -6,7 +6,7 @@ config QCOM_IPA
>  	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>  	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select QCOM_MDT_LOADER
> -	select QCOM_SCM
> +	select QCOM_PAS

"meh" for the reasons stated on rproc patches

otherwise

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


