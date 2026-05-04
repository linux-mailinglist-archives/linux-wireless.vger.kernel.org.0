Return-Path: <linux-wireless+bounces-35825-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCoWC2hl+GlDuAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35825-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:22:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFDD4BAE69
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 11:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83630301AA79
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E4377575;
	Mon,  4 May 2026 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jT8UcqmQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cDcGtUpn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1A737649E
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886562; cv=none; b=pfRRxLwEKib47rvKKSHkEFCu4ZgtTDDOHZ38ou0hDrl15n8pXjxs3WI2kw0UCkmR9YR3bNmD9q90trHL8D6su8AYVD1CarSrTnDCE2+jNWoX98ZanR/Xvqe6iEMqfqpABbl8f0GfvL+dy6wWpLvOlsmCoTpyHhqF/DEKtO3guTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886562; c=relaxed/simple;
	bh=0MgFvCSDTuHg4QDgFxl4BQsxVp8Ywh+kfF5DDfLCKJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jq1JoelgnZkEI/9nwk/rXg1GF7xrpC4jonoW2wzRY4I8JDhsLkJGVvo+Ey6sKO6Mn8SmFYD/jHkYdYAQwnbhQ1rCSJrpllb082Usmn4PZnL0i3uVlXEFKqQOQZQI3lwCtFk0/wm/XugQZofVZoJK5z6gcHrCjHWcNFDlUJB8M5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jT8UcqmQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cDcGtUpn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fP5j459384
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 09:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=; b=jT8UcqmQQ7n8kYzv
	d916VXBnBVQAm78wuEtAHyF33nuIfU7O9muUTVQLHdQqRCsxCnXUQgbmZ0fXA0qg
	VmH+gx1lXTg64WQaDkXccTDHvTbf9NCeimH7F3QvzoHpBClvIZjBqcRFZDiaKgiv
	5qcakwNqNRUSy/wv2UxnUomasVoiBjozKqMsvBe0/7eJysYubnJaFJGtT+FNI9ux
	OgE/dxTSRubj28Ew83LknbElbkH3kqwyMivwUvQUpW/TCMdouKIirLws0rS6Mw3M
	Qt8JuiFnIajoHlvcRdHSE5t+L63sURsDNn0q2ML7g9KvopCF3sLVwS/98cB8bEpv
	u27RAA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejn19d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 09:22:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8375e2df478so255384b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777886560; x=1778491360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=;
        b=cDcGtUpnY6BZf4S7MEsYNlhw/H4RIOuySsW+tNqhyGUx1new1R7U6UQwAXYS2eBjXA
         zkv1xaEC5r211JGvtyaVyBZe9l2I+g0jM/DFFSbTGwSq0o706E4jLjMb01B7vHkNnlKq
         6PwRjtIjgEZXd5AufLVKkzR+V60OyTFMobWXcXxGH/n64a71rwOiYC5FmisKwh+rrVpB
         mFxu5CF+ETOOHkfi7HN4ojFhgTj6mzbMRR/rIVNzKUESFXq2SUq4QQxcla6BkqHK3Bc5
         fN2Yr2PLIKH+g8ahTdn91CFXhrfrBssZAVA68+o6KTTjYrsdCt/C3e2lWSkWkxBdWqsE
         zhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886560; x=1778491360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=;
        b=Xb915qvdGX9UDJ1JWkDWC0VJqtFFk3PIY4p+7efEzFTWn9vj1e85eN70IEqIDmP0Vu
         nvJB9tLnXzBvYcvpbiIZousr4trCQW4+aG6jueKpjMjhwcLR5lNsUrZibqu1qqiSRims
         0j/2ZIEobLpyx84VufwxI8+TryYTayoMnVAKhDoLPTDz8jwYrcMDSDAIu9S4UBhXt6yE
         XdSc1/pSheB8YiU/TbYQ8XlMYOHCcrIWMrCNXI7ZuJd+BasIrput/IdJylKC+N01HdNK
         az7YI5lYO5dZ/7bd59A6XrpOSwa94lsIZ7Ur0TGYTnEhJoVv82MphXkuNk2PLMQ1vU9w
         54AQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JXcwYNQcK4Zfhs+YFugWLXw+mpO6BluoW6MIjsuncZB0s1GjcgvFQ/AzzBIKU27kF47SdENvaOMS61g1/uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhFBTqe9D/oABtfrGhG8dyb0HgtRHwSK+zhGY2rgGoMSzwJ8CM
	T0jkuHweRjPqudv551wbMp/oBz+E4vVdHabDS2Hk6LAy6qlDMcmAogcctaBpOIeVirBAC4dBViK
	H2pYfCUCw/M9zHXVAT+koDcdygXyyw0sY8Hls8pOs6ElyE7FMNGatjDkFB5Qn6t1apaCxfQ==
X-Gm-Gg: AeBDiesAl+d1cUK7NZ7llYQOXkH5BJDnVuYq3L3mPdtEzegazDJB4MhODcPqefL0xsp
	ODRj2A2xQJ34HxCN/I/GA34kHrjYS4l9LmfUCL1EpFMj+yiBWvkw5d0w2z9STB7WPcaf9FKld0o
	CiGuzp/DN7KHLf1YQSQbSpLrdteyCAkDjBHX5PolFXm1hGb79Zpq9J/AkwN8zLYK4OuLWZH1cGY
	Mub/RPdYu8RHm/ora8Z9AbAVyiNpfzdXKgnbFUtTdYPYGQkRbHgdR5Exj4ud5ZAPKRE8LpYLZER
	yThXTfYGB+1kX34gBEYa/Q14xqDLjmLddhSkcYHms4Ae8T5c5ouRQY28rtIDjVa5sPwEFqwv21n
	s/fQhm80zHxCUD08wmnVjMfQPQ1OZ5htjsHOM1RgHbktnv54f7Ofvq3xZ3fqbww==
X-Received: by 2002:a05:6a00:3c8b:b0:82f:5dc3:b376 with SMTP id d2e1a72fcca58-8352d1fef20mr8936714b3a.25.1777886559724;
        Mon, 04 May 2026 02:22:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8b:b0:82f:5dc3:b376 with SMTP id d2e1a72fcca58-8352d1fef20mr8936668b3a.25.1777886559217;
        Mon, 04 May 2026 02:22:39 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83775b1eadesm3030462b3a.56.2026.05.04.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:22:38 -0700 (PDT)
Message-ID: <ba8c170a-eae7-418a-aacf-92b394c401b0@oss.qualcomm.com>
Date: Mon, 4 May 2026 14:52:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run,
        akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        jesszhan0024@gmail.com, marijn.suijten@somainline.org,
        airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com,
        dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org,
        elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jjohnson@kernel.org, mathieu.poirier@linaro.org,
        trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com,
        pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com,
        tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com,
        srinivas.kandagatla@oss.qualcomm.com,
        amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org,
        apurupa@qti.qualcomm.com, skare@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-4-sumit.garg@kernel.org>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
In-Reply-To: <20260427095603.1157963-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA5OSBTYWx0ZWRfXxIaY4+B/UyaF
 q2P+B7fP8nz5lEPZGoQXInoVMjz4Zqbu18aDyUUE1Z4NB644kM74RcQT4xLocyXBMtrkQcu0v3V
 rJHWSONUElsmIz2PX2qpiShPK9xQBZA/ylLKC3DeTHLs46vVXH45WQUmcng8EgkmlFbyfhs4h8b
 ro2fw29HjnNAAW52TFmPWAq1hoLXlEe850CWIBC/8iWgt9cEPGg7rgvGSLIv0tBqlJV0qsM+I/+
 JCSoJFXf/uVrWa8Jnaq9Oud/tHNzXY74xKHHgCmKH1uRyB0Ldsb76w/pZEp0FSukGhSaHneCbNy
 yk6PRrc1jzlfk+l9QCvlkpYu2/8wf/kfpSynO4Ua9QdoMPVyVyU2UgHNP6nnE6JohW0pzi0InBx
 wz5wuArBQ/ofpCMquOGEp/HafotPRW8WJ5RC0ieA1MtREAPQaWi5N4GSF2ljGGzGWQfZ8ztP7pL
 aX0vM51jlSiffTdePng==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f86560 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=58GAH2X6W2vqmnVK_tYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Z-8T9REYkBTVoJ1G98F5YkqVyOlaIizr
X-Proofpoint-GUID: Z-8T9REYkBTVoJ1G98F5YkqVyOlaIizr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040099
X-Rspamd-Queue-Id: 8FFDD4BAE69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	TAGGED_FROM(0.00)[bounces-35825-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshal.dev@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal


