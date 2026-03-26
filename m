Return-Path: <linux-wireless+bounces-33930-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA9MJ9f3xGmC5QQAu9opvQ
	(envelope-from <linux-wireless+bounces-33930-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:09:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624E331F65
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8509300D6B4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851D386C3D;
	Thu, 26 Mar 2026 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="erTIgXXz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M8eGSPVf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323A391839
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515713; cv=none; b=ADIbusRg68a0EHXyDbcB486YChaZxuTHPY3SwJ36xe0tkfB4+Q4cEoWFK1B4xhTPclp1VUu3DI8geFDi8XAXwrxmowbYWJo5an7JuH88AVaJiH+0Ve/gWVV39DNxWR2kxVF8mE4WW2aJX2NnNTSmT9QHJhf8WNJfN+AIcutDwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515713; c=relaxed/simple;
	bh=8BV78OzUJnjd8dgqkKXNuE5mAG2V/G6kGOC05Qcr1Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnLziMiJmE14qj+5R1vHhdWa6rMMr9Vswl7i+dAeDYoNzOyemjCkQO0WZdllP6r3zqYdqFRTKeflF3HYdawf8SKWeuqsqrWYJBVYXcZuXkOUq+pCdTc6n8nvMWnGhRCS0Adebe1UeAY3lKD2u2dMNkHoeEBz47rXYcdZkJvu3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=erTIgXXz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M8eGSPVf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q8U94H1432391
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 09:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVD833rXl679fejlc5rkodKNHNn4ydrIaFRAgsku4LM=; b=erTIgXXzaly5BC9y
	iUvSXFvd0hEhB1bD66c2CJbhVqLfIku9bGEzTdlpAWhuSkGSP7Bb7fdVK63c4/XC
	j3HGu3XZVdUATcIwh8rAdBn3yfc4VRS//mjUoEF7X2g71yoz4dCqkScXID/aE/8v
	P21na+psMCvAC/V85KS3ROjfPNz9n2jh09SOcm4ajvPJ7eCIBLCo5oFst/uecmsD
	0CGA0uRMPb7Pwkj91Eyfl+JCCqLX3+VAs3LyPynvRFfPxW+F/Fe7eUCGnlN8hPjV
	6rNHNH5I4xl8+mr+uqy8oMp+82RoHKs0sLoZl431ka2Zht897JNGk54+RTgr5cmn
	SwLlDg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4jc536yd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 09:01:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-89a01982dc5so3008226d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774515710; x=1775120510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVD833rXl679fejlc5rkodKNHNn4ydrIaFRAgsku4LM=;
        b=M8eGSPVftfik4v/fjStTmO/NAJ/mGY6O3QFWMu6D2v7NNZGl3VibsBI5BKZSqsSsRQ
         LWqiX22NYnnERg7Abg2sBoTC6NDmRRiR0P5kDjmwY3mpdWxqDoYKalp4o7QSVNwLQl/N
         7ZcT9Ci74t45tU7+hdf2Wo64f1SYAqROxcaorSs2VvPHkaeYg4HiDA/zjTTOjDUKDlz+
         3Pq/DN6uWpA8SZUhVc8Q6p07xFmOy3Xi9/xdusaUntLZMjAkavSJ7uSczow/ZTfosk6P
         4N3O0oUpWoONN4DnTluqmVEQeXj+LkhdIMMwcm6pnSwglDqU7xpLx8knsbij5knWTHGk
         YegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774515710; x=1775120510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JVD833rXl679fejlc5rkodKNHNn4ydrIaFRAgsku4LM=;
        b=AQKj5O0lfW/jKCewj/iSs4y0m4+qg58mLqFfmOPvCWjBbXRH0veAaTOpfh652RBaj+
         kyBqxaxbdACbEybwk2beHgkB7k3xQjPeXwXOscvt/ntlODxrPkmPlk6losirmNTUgzAE
         XJGNFcoOMJhquKSJeD0C/dOT0Z4rrohIKvfhOj/ydsbnKfIh+PcEWMhv3U1rHT33Jldb
         VXdg0mFgEnfqUZgYAZRMNs7zbpqswOdC/C7suqndXp5mcXiaMJy5TUUAi+ouY9D3xUrb
         x5/OW2mlEHnwAurlDHcHTwtiUCQGDGit/FiLCiE2zo1kDQ/HtVmF6SfG5VXRXyb7Xahb
         Ngtw==
X-Forwarded-Encrypted: i=1; AJvYcCUpz5Laos3xpj+dgTO5qGhZgkl+sfDPgPUqDz1Z3pvsZNP9QxbJrlIueEOT8fso333Lyu0SJURXK0PdTUFhDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynlgtab7DndjLD3NrmG42XIqbqSFO6+G8eXwYrHrj0w9It5HNc
	2+Pbe4g8lTdcGUjdLtICcdbLy6z6vH/EIvFDgzoAgNDtwTP5cQW5Ygktk3T3/f9AIzhlLoRWt0y
	6MtVSFEo87l0v+XTjnOrjP2Xr7JWaJtmEFos+yGowGGi3iFMTOueKXMk6PoWAbE5t3fki9g==
X-Gm-Gg: ATEYQzwMcWWfmPGhR6U/QD73LIIGFlu53EAhpoHI8iH0ZSzDU5g1q0cmIDzTRBP+DZ9
	uTu2im3D0LbfmyeBGRBT2Qjr5NBD00mMLFYawrj69qcpEKu0jnWMcX2xfVaq9Rk1S47wknq4Ib2
	0g+M4SZ5rUz8KJcsMXl1eOSUXeyp7bAojELNEumSZYDrNV5h7KS1AMWQhd9nXQS0Rze8wRUtoF1
	lJAbB4k13hbFJgP4GVGQN1BBFrmh4FOdSaPeR05w1uf2kNUwAUwXdlt2sYwBD9eilDZGIU34buP
	JPgifz8TiJGfJnTAujFMUwk2jt4cKu4y8ET1yR3Jx898VheLei8vGV9AUmipt0+QghCn8X9GWKN
	zP1bPXpcqw8Mn61wPjlOWm2Uu+O6MfINcik4620LcJnsEQbNCV6gx/6BN+ceKN+aQvncwsCK63j
	ly3Hc=
X-Received: by 2002:a05:6214:c67:b0:89a:6263:feae with SMTP id 6a1803df08f44-89cc496bdd8mr71021026d6.2.1774515709526;
        Thu, 26 Mar 2026 02:01:49 -0700 (PDT)
X-Received: by 2002:a05:6214:c67:b0:89a:6263:feae with SMTP id 6a1803df08f44-89cc496bdd8mr71020086d6.2.1774515708327;
        Thu, 26 Mar 2026 02:01:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b203ef95csm87469966b.52.2026.03.26.02.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 02:01:47 -0700 (PDT)
Message-ID: <b43c3e0e-33e1-4ddd-8415-2c11f6ecf9c0@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] arm64: dts: qcom: sdm845-db845c: describe WiFi/BT
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-wireless@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-7-948df19f5ec2@oss.qualcomm.com>
 <a75f80bc-d2fa-41f6-91aa-8252fbb415e6@ixit.cz>
 <CAO9ioeVLy_Uzn7L9MyET5wg8CMR132+Dda5JzjdAB=6vz2NEMg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAO9ioeVLy_Uzn7L9MyET5wg8CMR132+Dda5JzjdAB=6vz2NEMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PIB0D4oWDVgeNK7P-QFkdx8I1k4rAxrC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NSBTYWx0ZWRfXycXxr5kp3HuJ
 nVwXj+l5O47/B3Nr0VWyApliUtcxjw1OUpmk1gS+Y48M2NRm6nz2B1F2hDR2d5pJDljmrjo92Sn
 FyKj8mYs2d6deLMxmnMc1zK6upsBYe9KEjmfb4Ft4pCjJr+0RBeyEt7HZHM2LNggnS9ngV1TH+C
 teJvsubpBrYktsXSSYDlB0p9Om6Xarg8T2nfSALU8mFCz/KWNfiXTJMEvTOqClxd1MHfEevX9S5
 KzQrpXBDPteQ7nwNe3HojsfZ6u51GsFjptAGIWrPGTC0amtVSN3XS05K5VcdI11tw37AZvGWPbB
 b3tioE5O4Kzqcfn5WlXYxiFBhFLK6H9ddbSNg7GPvlKWVOwi1JZyzJ2dmlrPxqIBBoeBLC3TYpM
 XsMzjr/Mt22bEYeff0+XkyyjLRkKnnDviAuuVjmYFpkAuDL5oCPgWX14kSO4emKA5JG7yRVpWwi
 1f1Rfr/nUzJ5zp1OiVw==
X-Proofpoint-ORIG-GUID: PIB0D4oWDVgeNK7P-QFkdx8I1k4rAxrC
X-Authority-Analysis: v=2.4 cv=KaLfcAYD c=1 sm=1 tr=0 ts=69c4f5fe cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Mao_WS8moKRl95PynMsA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260065
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,quicinc.com,chromium.org,lists.infradead.org,oss.qualcomm.com,holtmann.org];
	TAGGED_FROM(0.00)[bounces-33930-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ixit.cz:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1624E331F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 2:59 AM, Dmitry Baryshkov wrote:
> On Thu, 26 Mar 2026 at 02:02, David Heidelberg <david@ixit.cz> wrote:
>>
>> On 19/01/2026 18:08, Dmitry Baryshkov wrote:
>>
>> [...]
>>
>>> +     wcn3990-pmu {
>>> +             compatible = "qcom,wcn3990-pmu";
>>> +
>>> +             pinctrl-0 = <&sw_ctrl_default>;
>>> +             pinctrl-names = "default";
>>> +
>>> +             vddio-supply = <&vreg_s4a_1p8>;
>>> +             vddxo-supply = <&vreg_l7a_1p8>;
>>> +             vddrf-supply = <&vreg_l17a_1p3>;
>>> +             vddch0-supply = <&vreg_l25a_3p3>;
>>> +             vddch1-supply = <&vreg_l23a_3p3>;
>>> +
>>> +             swctrl-gpios = <&pm8998_gpios 3 GPIO_ACTIVE_HIGH>;
>>
>> Do you know if the GPIO is common for whole sdm845, or it's only recommended as
>> reference design, or nothing?
>>
>> I did test defaulting to GPIO 3 on Pixel 3 and WiFi works as before, but since
>> previous downstream kernel didn't touched GPIO 3 at all, I'm worried about
>> toggling unrelated GPIO.
> 
> It is an input-only GPIO, but nevertheless, if you are not sure, just skip it.

I think you should be able to observe its state and deduce based on that

On a sidenote, 99.5% of reference design choices seem to hold true on at
least 90% of devices

Konrad

