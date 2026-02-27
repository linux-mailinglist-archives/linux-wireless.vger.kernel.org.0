Return-Path: <linux-wireless+bounces-32303-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIQmJO7aoWlcwgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32303-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 18:57:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069C21BBB1B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 18:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73C1A3104BBB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB49362136;
	Fri, 27 Feb 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d8Xh04m/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FrL7Sa/C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB36363C47
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214811; cv=none; b=W2Zzr9i0YEnS6GNCzfT9yJMY83M47aw88q0tVs1VpTw7WRBBAeoFDIE8ZYFr8iaBMus42pyYlB3bEEdHpayo9DnAqsoGbeV9MwmxQLwYjB/AtzXkESDE45DgwkLC7Hs9SpVOKRTrT/AjPkd7/nIA6tU/3PzBw6RV6cpeRkH5Avw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214811; c=relaxed/simple;
	bh=w7Y+KccbKwQHTeIuU771LWriqakRmwxGuvvtAHY0EX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czbXZ3Ul1EsnnjymW4XkpbaUpt1oXBoir444IxaaPbsWH1kSlwcgqBbqLoDVFHZ+QlWUZdnwpry3ov/R8hG70+obOnQDT540ydzBiTCKAwhyILWWHaB2GX6mhyfGfDuuSimIeT3hbALrFdRAto0gZyIdqWnV7HBo8Jgp3GPeuMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d8Xh04m/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FrL7Sa/C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RH0JxF131873
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oMrPipa8HvJb3/9lpgE2nmap6xaDNkVZJrzrCWhAdos=; b=d8Xh04m/ZBDFheJ+
	aOlPak+XFlBM6mx7qWCnhhpCtTsQizZilzWLJRGvCi5SLHIl/mCObobbZs9/r02O
	yjJWttAzfnEQHgBlZP5JB2m2Sn3nIpI3ZQ/vl071YqgGPW/owGCdgE3aSUWYDlG+
	9k80+ZyvcVGXNze1mNrnKsh1c5li62NVI5t8P4xYgzgTJ4WY88AmxRpT0WBuC/Hg
	v9otYS1LoRMAoiGOHSSpN/xWvJ2fKRm3vVzygEQSWNoKeoWbVX48+EilPKbdQbzB
	2atJjSk0jtYkEfOQGgTDzk96dRO3re+mbSY5nRaw7L84EVOkfEPZ9d15WDrycsT4
	L6i2hg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ck43rajf6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 17:53:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ab4de9580dso129975375ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772214808; x=1772819608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMrPipa8HvJb3/9lpgE2nmap6xaDNkVZJrzrCWhAdos=;
        b=FrL7Sa/CG7+j0Fu5MOVdhSiGv6N4etmatIdjld02rdrOxL4XcO4etEAfSjHsNLIvET
         a9+cLQmZOPwufHcuOIIcE8KpyLAm85djMLEgL9G0L4emYbb2MjyaS/AEjuvAVe9ZvZ8M
         WgA50zrJWkCEA5W9fjdHY/OEAm9vdR4uVK5AUAm43rQO7GZ+Q4quDZ8Ds5FlYaCzJBs2
         TqNWjqTQZbFr0nhUNPgObL4NP3jdjfnRTRcanzoNmdXa5lxK/7eKCF2n6nSFX9DMgqAn
         7oOW0gW/gj3ra3s+bbrTex+vOA/p2GCOXt7agSspUvgdDSnBGuR4Mg5athXplG7YbIrZ
         R8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772214808; x=1772819608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMrPipa8HvJb3/9lpgE2nmap6xaDNkVZJrzrCWhAdos=;
        b=ruPwzUkjEwjg/+P7JFpFH9FTavxYTopNv34znwJ0m4DlszDgZNAVcDHzCssFNvUCFd
         d0628wHg0hzfz/d2THL/ge6rlHkW9bjaB9e99R4EgsA1DLfMSXbRzSyHjfwJq5TDPnC/
         f4MVMt+cBqbXOvj4j/HFeU3NQFyxzR4/OSX0CwISrHwiibxUN3eHA0N+qrrmdWkF1qn1
         fyKp0ZwLuigf0mB2bmKwEbvXcK35eau8EMvPvGaJacBd7vHBuzHZ7xF6+x/hSLt7QRjS
         RF6N9U0pL6roG+RbUeETpyf0U+wRePU1bd5RbEHtH0LbwYi0JPIpKRQvWfUXq5kBj17d
         91ow==
X-Gm-Message-State: AOJu0YzYfaYuBNgjjOZ1C01pmrO9txDvpYB4nZajxJFgTLnt6EeLZNws
	jHT/TVTytF4VHyxcN45DF/5KkxUfFbZSpDJdvR9wpBcsSghdbci8yn282dvNG6gZOPPaob1OwPL
	Wv4b8gf0MPgBBNp0rPTPeNS44G6dqqNZPi0CB0rAxlqylLtbxbtP+p0ZGxy0BazO3YxfFBmEg4F
	vsHw==
X-Gm-Gg: ATEYQzzWC1WMFLLSG2Zn8Mw0I9iNSqV0TcnL0ILlyEFFhUd6hg4F89sXriA5rFLzz+M
	2uIa/tTPL/KvYhDx4vX/q46kYyfYImR9ovet1HDWKRZWgVQzMIgAZvxYMuWVm0ib/NR7nsZnjiL
	9hPY0cBjzEJxXN6z6jswZctvREDYF1Nff8UV5D50Cwy/QdPgeVywA91+wYvYWlyf1TGzPkxs+Ip
	iyr4GSXT2GZ/YFjtFX4XNMZwd1JpyRH5A7LfjZqiFaRKJDJLbng/UeUv/xNUnls2A01RFs01gHK
	Spi3rs0lbU3zMU/zg2+11hdTzzlxIzJlSiImpAGcKF0m5lYh5vgry0aUKiSTCt3zggeUAS//f5b
	Zng5y9fuSZAvplOFy4N3/IMEaN67btCNCJSCJGcI1B0dVTaKir4C5tcHfeRyXe8xWBdznZd6H/Q
	==
X-Received: by 2002:a05:6a20:9404:b0:394:f5a8:512b with SMTP id adf61e73a8af0-395c3ae6cd7mr4063936637.45.1772214808353;
        Fri, 27 Feb 2026 09:53:28 -0800 (PST)
X-Received: by 2002:a05:6a20:9404:b0:394:f5a8:512b with SMTP id adf61e73a8af0-395c3ae6cd7mr4063911637.45.1772214807801;
        Fri, 27 Feb 2026 09:53:27 -0800 (PST)
Received: from [192.168.225.142] ([157.49.228.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22e7sm63991695ad.3.2026.02.27.09.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 09:53:27 -0800 (PST)
Message-ID: <0b472b7b-0115-459c-8208-ea92cd7b1f0a@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 23:23:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: account TX stats only when ACK/BA
 status is present
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260226051947.1379716-1-sarika.sharma@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260226051947.1379716-1-sarika.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aaKYPLOUsgs0ad9FLtOwmjWmKlkkgrVk
X-Proofpoint-GUID: aaKYPLOUsgs0ad9FLtOwmjWmKlkkgrVk
X-Authority-Analysis: v=2.4 cv=DOqCIiNb c=1 sm=1 tr=0 ts=69a1da19 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=PtQaxW6Z2JPlFy30ps15hQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=MXFVrN99o-6Q6YR7G58A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE1OCBTYWx0ZWRfX6gF8duADLKey
 OQUQD8x4bHxLOhuZ0zCNHSOUX3nJ3vvOigeTYHPOW6SmF7+gY40+QbubR4UjDVV/SLYLUjuX1J9
 zc7cZb6tVDrjgLleRatX81r6zVa1vBrPuCEJ3jg24Uu5HaaPuHc05cyQtGhuL6vuGuOEhPI/5Ti
 sn3anoJS4SK8YDL03w3xDNxTJ7yZjiOocKVSqFi/poZMM1cbXgQjcRhuVwgT4uo15wPisZiT8Ey
 oYiPYZXihtMXai5h6Hus0ZoE6c+Li7gBeG6jrkublezDDaeyxPW8zVBGkCwTfKJmZnrI+fWA/PO
 7xUNf+vcOGQfy4YrajM8Z4Szq+YC9CyEIZEV0PGjbV3g5+pXXUOXarHFFhofYDudtSrK8NaoE97
 Pir6+VGYZ9AawyFcHGW1RlNVKPYsmiq4GKPniPWqta/tkHawP/mdUrmmaxOv0lqu3yr8pXnXvw+
 Wa16FlzZPekdLiGuPcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270158
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32303-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 069C21BBB1B
X-Rspamd-Action: no action



On 2/26/2026 10:49 AM, Sarika Sharma wrote:
> The fields tx_retry_failed, tx_retry_count, and tx_duration are
> currently updated outside the HTT_PPDU_STATS_TAG_USR_COMPLTN_ACK_BA_STATUS
> flag check. In certain scenarios, firmware delivers multiple PPDU
> statistics for the same PPDU, first without BA/ACK information, and
> later with BA/ACK status once it becomes available. As the same PPDU
> is processed again, these counters are updated a second time,
> resulting in duplicate TX statistics.
> 
> To address this, move the accounting of tx_retry_failed and
> tx_retry_count under the ACK/BA status flag check, and similarly gate
> tx_duration on the same path. This ensures that each PPDU contributes
> to these counters exactly once, avoids double counting, and provides
> consistent reporting in userspace tools such as station dump.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Fixes: a0b963e1da5b ("wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv")
> Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

