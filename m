Return-Path: <linux-wireless+bounces-38524-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 97gTBZRdRmpFRwsAu9opvQ
	(envelope-from <linux-wireless+bounces-38524-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:46:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BE6F7D62
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 14:46:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PfvBRkZj;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=SP6pYnP1;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38524-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38524-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93F82311E0E3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 12:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9040448034D;
	Thu,  2 Jul 2026 12:35:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6C2E8DEA
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 12:35:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995704; cv=none; b=mVZmcX0eybknI+BExpk0FGUM1fO5yU+3PjeOp+u3t/eEo/56zImdoyciCoV0sKvuHV24QDMi1z9w+1CG1Cl+kDl46Q6F0JaXkf+prbl6nEkoXqsH0LU8ltBOC3RwF+1Gi3j0sbr9LgWPv9l70wUDQImuwdLofrP8kcVIbm6XKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995704; c=relaxed/simple;
	bh=WSd0pp4dLViWUrVNvqX/zEMET0G6qSs6EPp7Yqwc1hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONJfsnSGhgTg+SrqkfNaUsC+g+8zLv+HmfPkqvJEUB3riejjfXvDwq9BQAu/XR176OrduODl7jFhyr0ikoHFfKm7PdKyfyi3Z4w5cLJI8phgDBg6iLOPVP8aVhwV52MEnoW+BzPHK6bzDmwY0YeZbCQohwZHTlusBEVcdRMkUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PfvBRkZj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SP6pYnP1; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628SEMk3049491
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 12:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=; b=PfvBRkZjmzECsBBG
	l/C6ulvrOWW4bO5T1i668/9LoIoIo2Ot+p7CPfZm512Yi2E36QZsz7lY8yGaehna
	LRfeXadKYb+gb6eYOF8BiIUQJ0KAdwl9pBVviZn8WLgczw+4oNwnpFa8J34gtGqi
	3vGn3Vf9jKgZ1GgmG9fyB7AeynvUjvAslZT8Nc1Jdd435VXma6rl3XHXShg4aGn5
	WkgGtwXY9nJRza2Pd6UHqASdWQ9JU6zt0cJqiccbZm6zVd8EjPuoGOfivPfBUfvM
	K+TSJEBYu+SKlIEfYHEpZUKipLVSiQXbKLND9kl0mBASZneU1Ai4Ivq4SxZVPhVu
	wV16OQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541vqar-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 12:35:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f21e4e8b66so5465686d6.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782995701; x=1783600501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=;
        b=SP6pYnP18iMiU9Y1n51fTR3U/5o2/Fi+B+wXOdSOcSr22XdumuVdSxa1JEQ43j7QS6
         06kB7WgNdVg7UIWaicWEQ4j6Fr/gShp7HzVTnaFP8pNwTdwB/a8t2pEPMUfNoiamFPQU
         Uu0NYK89vxsoJZuBSTUA7nqhPAc96/5Oc/QF8mIKzMLjyFYD70YMePF3qClnhqaiIEjN
         Jy0zgnPXZhfwA6aIUNuc9bDOTgfwEIhF4I6a0MbgV6pQAsCwgh+Es6ISNaSB6/2M2WLj
         eNb066sk6Bpb3Kou8T91rBMM02ynWlje2ULRZ4eXn18siVTp7Av66SwdhRLQwhd50r/v
         EFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995701; x=1783600501;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=;
        b=jbJyyvcnUWub8iasTCN3BBscEFVBbbuPXA2c7pLxVeGYnCcXp1DfN4876K1KH6TEU9
         NKWJGI4aE2Ij5d3jw5scuQYZNyw1FiQZWGOvoC3Isx6SS8T5aPX+H36Gn9/Fw5CVFnAj
         1Uqc3NakKrmHob1dXhG7wdHNgbn09rXhHJorsBQq7q5SYv0IlVYCxyPhethOzo/xp90L
         GSa7sOTZdteAm3stK4etRSyMbvIckIxvoy7IadNMm3PVpy07luefVFyIypfUFjKynNrb
         kJyaKa0WjYrnkNIzHyujqtTxz3WzaNGfPEne7gOdftz3I7rglGdRSkOEDiabtJnzfKEg
         9kEA==
X-Forwarded-Encrypted: i=1; AHgh+RqwEdn72EmskHYk2vYjzJxBKj0zA+iOJpIQeRl9XdefS0rFFvVVaPHncOYwyJEdOSSUPSCUkL1vaU3CWatTsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykyAE4utUPshvyEd+gSNpt8MEpSeQabBreKd1LFVkpwh308/Xd
	XU3s8Fvgoe6KCKiJHA15b0Ks0B1PtQK2MRSqZ+yZqyr00z1l5D6B9MnIMV3naKH6Z4HWm7qMiL6
	U7c/mPCjxAFrP21Esdgak8iu9P/Gta2iB0WspTeEqWjEBkuoXks9vbJrKjV2ecImwSVGZ1Q==
X-Gm-Gg: AfdE7cnB2Lkmr/Xktnjgy679ekgfxqI1G9ALJDDvksP8whjuMJqOKIFNJBq2nfXX0hQ
	tM5+zLl5ifj2SgTvaa3QmjtcrRUnlvnV1K7A+TdLtIvmCThjhf9y8fsWKxBruOSoMZMGsnh2nGh
	a+xQ7C6TujhcAaFW4atvPVjqGelzcAY9vCtt7hEikNm3SIYyMu0xRq0FG1D1E8sthrgdHso25fy
	YmC+74hhndrZbrU3BjdP4mD1RFP21DWQJGnCMV/v9T1iH20ltR9tfo3GnGFmM1NEACknfzUoLfz
	aXqyPq9ff+A/q8GRDR8WzI4O0AZaerggpyRDeC8n1EuemIiir9uPsdLz24RHYSjOnB4FPMEKhlh
	xNkVGRWlr7bFT4tcXVImKl/keOd49UEdr4TI=
X-Received: by 2002:a05:6214:428e:b0:8e9:f5de:d5fd with SMTP id 6a1803df08f44-8f3c8ff79abmr50486426d6.10.1782995700696;
        Thu, 02 Jul 2026 05:35:00 -0700 (PDT)
X-Received: by 2002:a05:6214:428e:b0:8e9:f5de:d5fd with SMTP id 6a1803df08f44-8f3c8ff79abmr50486116d6.10.1782995700253;
        Thu, 02 Jul 2026 05:35:00 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad13426fsm895805a12.26.2026.07.02.05.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 05:34:58 -0700 (PDT)
Message-ID: <46ab1a2f-45b2-4580-afea-a55073fd29b6@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:34:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
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
 <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RPsAFoaB7o-hm4eUFGcw1ii5KWVVa7S3
X-Proofpoint-ORIG-GUID: RPsAFoaB7o-hm4eUFGcw1ii5KWVVa7S3
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a465af5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=5GrnyDZj1TGYcITIosYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX9TCJIr84AA8Z
 oUw4IxFmjHcea5mQ7iZ14Ttog6h391g/NPbQIDEMs2w7w3v1QzDIjyzDIV+mSZnWmdoe23zMw3D
 sFL3Og0QaZ9fvwsMy7xaFiHTyhsghFUGkPZ28D56S5mdK+o5e8My0KR4lotF98doFDly7f4y/OT
 rl3wrp0SHJnoDbIZ16kgT9h6aGS/AMlvflA4VlKIOyXZ2Ui6sbt8LFyHhX5JbJaOeaWJwNzhdMw
 AL+u1/4Kap9nGJO7+4xqDx4ZXuqom7UTZu2eQSptbuV05SCZKpUKJ1DaftQPi0h8RFymoC3qEct
 Ou9FUJ3NdaleQQPj5p1nRd7jCa/30yA0qPzsk5NuvIdA4HQZFJnlNzvU9alp5VsCOi7f0Atiyl1
 tjYcwSjhP8XgPUOo+u7Ki3i6klj5dqKE3qdQ7cT4FkdEUF/dwFQYdVys4DPDY5CMZch0ChPjL3p
 VAdcHgO4qvBVTrEpLlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX6BfL079H7X9h
 quqkawctrj4y51T8qGKgK58zNlOKfpwdbb80zl2MFxXB+kK636MZdUc922vGydJHM5+JNVucAfm
 Lhb/QoD/VEchWTNIxN0szzAuhBSi0rc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020132
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
	TAGGED_FROM(0.00)[bounces-38524-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sumit.garg@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:devicetree@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:freedreno@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-remoteproc@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robin.clark@oss.qualcomm.com,m:sean@poorly.run,m:akhilpo@oss.qualcomm.com,m:lumag@kernel.org,m:abhinav.kumar@linux.dev,m:jesszhan0024@gmail.com,m:marijn.suijten@somainline.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:vikash.garodia@oss.qualcomm.com,m:bod@kernel.org,m:mchehab@kernel.org,m:elder@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjohnson@kernel.org,m:mathieu.poirier@linaro.org,m:trilokkumar.soni@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:pavan.kondeti@oss.qualcomm
 .com,m:jorge.ramirez@oss.qualcomm.com,m:tonyh@qti.qualcomm.com,m:vignesh.viswanathan@oss.qualcomm.com,m:srinivas.kandagatla@oss.qualcomm.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jenswi@kernel.org,m:op-tee@lists.trustedfirmware.org,m:apurupa@qti.qualcomm.com,m:skare@qti.qualcomm.com,m:linux-kernel@vger.kernel.org,m:sumit.garg@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 582BE6F7D62

On 7/2/26 1:58 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Jeff Johnson <jjohnson@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

