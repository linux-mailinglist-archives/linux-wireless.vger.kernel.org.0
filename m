Return-Path: <linux-wireless+bounces-34747-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICsmDPoC32nCNgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34747-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 05:16:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A63883FFEA4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 05:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B708300B5BA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 03:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C9318BA7;
	Wed, 15 Apr 2026 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TPgveN5k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iacqPlmJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC4A3164C3
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776222967; cv=none; b=aZP80d2rOAoxmJcvlZAl6xWtzVLRuYvbyVDiVwLjxiZBY14kzvui9qFIFLzrX9BBSKuFRwUL7jp7bUplfSPw9Zi6JJa9EvbtgoXhYgyKHRmqSJcfw/Md/q+v0K+Q3/0Ilgp+ITHwKaXG0PgCHLIkfNx+TddeFC8KACsTZBPYjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776222967; c=relaxed/simple;
	bh=ypT6dvJbVlTDEt1n6AY6fbHaty4dOtTSID2Kk1+7IKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ResBsaUVSaUvcGuyRx0qGmWtm7LSqcxcrwMnWvR5CfNKle2+k9fuQog+/5gLRDyzHL2TMym6h8SJ6kHxpUeR5VI8kgbdQZWGcFWVuCBEpjAC+vabWwa3fDZs8b5BQSE6FzeHvYk3k2VfjMCIJ+gdt9kcEt0ECyTHTVFHLPbuj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TPgveN5k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iacqPlmJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EHvqgi3059053
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 03:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yAotFAiqJiGXdaNX/JI+JOyH84jDiUIJy+533r0Cdeo=; b=TPgveN5kaPfd2c0S
	/fQsg6oUmfmg0McWRDIFM0cGbvmN9XS5Hh+ExrzHF+xkeuPdAWcbclRk4RtiEkfd
	yGicujRDwusINCGSmi2w26sveK8QJJwtuby7tLHcp/GSXECHNn8oD7C599QzoJU5
	nUOyaqavBnRdfWUxHP2kOoS0WO7mtfQkSwsJ8etq9oZp4QKJeoemHDBT5GobgTVm
	MXRKWE/4KsXdKqFH2ZDTCvaqjBpE90UVa8f59oNZziY1QTfAuFFSkVJIfqQyCXS2
	x5wDik6C2Q62uyriPuX6Ov0VWpRuoj2PvWJna5bjtDgJd+dGk2NMt1VMLjWZGOE1
	hHm3EA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhtepsdft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 03:16:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35da1c703d1so7231455a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776222964; x=1776827764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAotFAiqJiGXdaNX/JI+JOyH84jDiUIJy+533r0Cdeo=;
        b=iacqPlmJJ/ojJE7i8WlMvS/U7f69UD4GeN2w1toMdKQartNKoCpsuRKfpb7pb4OOvQ
         0W0CyJ9Q2UEhIXeDTxHoWEFaBLSHJaa7EVYSeq1jjKHwcwfFcdiTz3HiGKb96a5jzGR1
         BxHdLG/uz8hNT0ABthfbvhlhOQFYRPuRLeMzC5YU2R4MvX04VD474D5V5Yo2pLuA5mLG
         JbEEnDGEJofV4cJoKPLz4vOm3YWUHaQ6TCmCbuKclBTLuS0VeXL37bJc4bBG6qg1XYKL
         ruTPmaoGyC3A7lW3B2kf7GCCeN1ayRLgSqlJNJKi9t/1r7HeVjPcY29eNFu1lRVdIbh+
         Ay6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776222964; x=1776827764;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAotFAiqJiGXdaNX/JI+JOyH84jDiUIJy+533r0Cdeo=;
        b=Sjs0D044FtxDsoXBn1hanqC4gaHzEOSS0BPDVYtwKM44/U+2bzxafzlfdFd+Oe2juX
         1kFnd6v3GcAa077HHkuVSACbtoh1Hz9afTm4I2DIytYKVQLey25Z4z8dsVV76MGODxkw
         o+iworw3KJopiT7wXzTki7O2oS+meC+juh0mEn3mPhH5HJe3dS2a2DCq1wbIvQF+h/K/
         BPTuTOGozXB0LM+80Ae0HQpiq8/2y/+ECLH5BPl0uDMJXKUnnw+fe6PPNlqjbSlPAVi5
         3xOILo/RdzCcVN7ObXjLArpuhABKF91n9pmw+vlI3gVN/1fGQMvi+jmD9NnDpPP9fOMR
         G26g==
X-Forwarded-Encrypted: i=1; AFNElJ9rH1pBObnWZAHGmeAkjOK0qtx0bO+IcDm3DzUoxsCk+YiTQn4LyjnNBNq3xU8TZ8W+pDD66O9IAj97hTcaOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8j9TZsdeyklXrtqGKrA+n2Ht5VYy95y14Ju1ApxlhAj7dm+lH
	BL+kSJJdTaWIRAPox5wQe/kZVFZnZWxmJXnW42f8pe0q9KpxC7H9cAnZS6k1mwP3eOpcqPI21tP
	zoI/phsp+GFdGAvNAcsbsy1+pkaZ1TLGOO9FwfaXhXmCxT1LUp0BX6uoLh/EZuIQ8VwT5BLcdKA
	0JWg==
X-Gm-Gg: AeBDiev05IVlePTtDuss0xztLbUqpZ4htDnBtUfIcX/HCECWUkfZml8rvZKHTsHWA2I
	y/Cg0W18vXwvM1Xo9G+/MN39wz92odcd/lUqScPpZ4+0wW2z03GWGt5BGEvcrboZ/P9hugeC/Lk
	qYz08tYbeDT7wph4FI8UlzJxQr2+dCeWR3VPopJia82K3sUpUyjdqKVhjwZhTdnaLsN6ZCiDSd1
	WPkudXndNZIA3Wg95fXxS23QXSM0kffQ9XTtQ0l/4TRUVwWRMGd0FOe3l86LJ4tK70f4pbCr8V2
	WlP76nkVdsw7MMVNa0EaJAnJFkzqQNoVDtmFFK44BWyltMUSIcK7eVLzxg1iU6eNvrAVTpnK3xY
	WBSzRwIHk5EDwBS/7QpQTBk52rRq2IN6bOi6iQrThM5D3Zwv/1YWW7lK7Cac60JUt91CTdzffzi
	5FL6brXoLRM5Xe1h+/1Gi3rt96+NabTQ==
X-Received: by 2002:a17:90b:4c4e:b0:35d:a2d3:5c31 with SMTP id 98e67ed59e1d1-35e42858252mr21452648a91.29.1776222964155;
        Tue, 14 Apr 2026 20:16:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4e:b0:35d:a2d3:5c31 with SMTP id 98e67ed59e1d1-35e42858252mr21452614a91.29.1776222963700;
        Tue, 14 Apr 2026 20:16:03 -0700 (PDT)
Received: from [10.133.33.118] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd3203a76sm357994a91.13.2026.04.14.20.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 20:16:03 -0700 (PDT)
Message-ID: <b71bca62-e467-4c88-a6e5-c44f13d48b4d@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:16:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: workaround firmware bug where peer_id=0
To: Matthew Leach <matthew.leach@collabora.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com>
 <87h5pxlpg4.fsf@collabora.com>
 <7dbc3836-c42c-4cbb-a50a-011d82a0ee81@oss.qualcomm.com>
 <87a4v54s88.fsf@collabora.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87a4v54s88.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7ciiUZ9AWCb8eyhQ9-quE3HETC_feBq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAyOCBTYWx0ZWRfXwMU7zZu1qj4l
 NdN+l7PMoYEbX2HRdUbffJFaKHxHEIGWGd93CdJLDBVKMvL73gdiyNBJYGR/H11c+l11ax1wS1r
 NSozbIpv9KwhvLeufGpkbTNhnMs6xuZhzRREq+QkvR7oOv1di1ebmzwvoVjCApbnaXmEsC/Etgj
 lNYJkc9mFOrtFV3/uc+38kmR0Eph28apDiCp5QetJF/a7kGLXBGOu171C7812Axr+44es7kNCcB
 ab9q8nQ9ACi1L2d9VR1DzAzgA1DQ8Pyhl/WxGTVngcM9CcmTFHI0RHKooLzbxRzaL7rM/9WzuAp
 NcGM3Nr2OAA2rQ/T6n5QKOsE7XM0YcS8ZWtfMbn8Nh6CusDqPVWb4iB1l44sosYJDoXI5XP39Lm
 duFLDZ3FqZo5QF2M4lDw3Un6bh6OksQdUiET+tr5LMGksZReA3Rk5Il9nrm9vNNzI0pfU9UE1wR
 oNrMjMTbPlCcIqhBTJA==
X-Authority-Analysis: v=2.4 cv=CoGPtH4D c=1 sm=1 tr=0 ts=69df02f5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=p6f2LkNNnSkKDXlKyPwA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: 7ciiUZ9AWCb8eyhQ9-quE3HETC_feBq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150028
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34747-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A63883FFEA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/14/2026 8:54 PM, Matthew Leach wrote:
> Hi Baochen,
> 
> Baochen Qiang <baochen.qiang@oss.qualcomm.com> writes:
> 
>> On 3/30/2026 3:57 PM, Matthew Leach wrote:
>>> Hello,
>>>
>>> Matthew Leach <matthew.leach@collabora.com> writes:
>>>
> 
> [...]
> 
>> for chips like QCA2066 and WCN6855 etc 0 is a valid value, however
>> this is not for chips like QCN9074 etc.
>>
>> so a possible fix would be to add hardware ops based on chips: for
>> QCN9074 we keep the existing validation on 0 in the ops, while for
>> QCA2066 the ops is a null func. Or even simper we can remove the
>> validation for all chips.
> 
> In that case, does it make sense to remove the condition check
> 
> if (rxcb->peer_id)
> 
> in ath11k_dp_rx_h_find_peer()? It looks like this has been used as a
> small optimisation, where if peer_id isn't valid it skips checking for
> it in the peer hash table. However, if on newer chips peer_id=0 is
> valid, we should remove this?

yeah, I think so. This check was also based on the non-zero peer id assumption.

> 
> Regards,


