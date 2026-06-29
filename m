Return-Path: <linux-wireless+bounces-38263-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vlLSH7keQmpB0gkAu9opvQ
	(envelope-from <linux-wireless+bounces-38263-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:28:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D116D6D7014
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 09:28:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=RYRY6Jaa;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MERKUd4y;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38263-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38263-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6104C3045017
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 07:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C93D6663;
	Mon, 29 Jun 2026 07:25:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AE13D34A0
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:25:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717909; cv=none; b=bWQhys2Ar/1C9IiLrmU03wOeJETB1fP3K2aOHiS1DGU+3dis9ZfgOAOUUl0UWSBR81XToQ5R8NAgSDpcYRvYyJQ6NyWZLp4x4g4PohVGYGs/5DkoE8eHu1kCK9hIk3RgxsSZfK9vX075zW9RFiGWVpOpY01/9hiiJ7dWLDI8KjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717909; c=relaxed/simple;
	bh=NwRH5a6C6vWzlV5URq0GTWE1yYHIWwzO9FIsPcogDak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEygqRUb14ugFlsN8ugKiZQlp1kseovnUm2qB31rpcHj9L+OfHjgq/nB8tONqbM8n+ztVt/XHD66iDXlYlTZWMS/tTp5DvYay13e5bcGTjEnPYgv5hxoTPygiOzPEDtoSFBILbCdzDxULWoQbHIRny8Ogp3gooTF8usx6H/tpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYRY6Jaa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MERKUd4y; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6qx4r2076278
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qUsK7bpTixn+YbKeaafKtp2BKCKuSVgAGS2fazklOqA=; b=RYRY6JaaA7uQFR+H
	14qxXVbyWvc0MSgVSVUXT699fC1OAZDEK39NeGeR2VuKO4EASn0oSTzjTF26byLO
	kL1Sk79Etuzg0VZ1s45MiVKQDk5w0PeM0GYMz9rSE6blM9om3pr+HKzgzGTSUYZc
	g6DoLNApixgsWVCAk9I19dAU0WVjb7gpJx7U09PvftiHt4yy6U2/TdgCx9D4IKdk
	4mWIzagYj9HDDXK0D0ouhji6GC0wi+lOIG9KB6LtzHWGjTJomBWb5DKH5p98nDVN
	YZpBFqs8P8BmEsStA9grStK+GM5odnfXXrk1KEL2ZXCycITdjX4wSvVojWLabMt5
	jtQTeA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7g5d0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 07:25:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37fe90ee192so984675a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782717905; x=1783322705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qUsK7bpTixn+YbKeaafKtp2BKCKuSVgAGS2fazklOqA=;
        b=MERKUd4ylNj3rb5nso4lAfxCXoyd2+FKmSaSQd3g0nfgcXsWtjvSP0ruhJEw5849uA
         2RJQTUujvWwI0+7rrbt+B4ZElx4ne2EFMMPQy+RUHlFu3IqLqI/L26JlPaqYY0EO9pGM
         ZEtcNznHG5wk5gFOb+q1LZApG3RbEGOD0C+Zs7w0t4ndZmUaRLtUELmYfmlphajAhjdx
         cYK58ldiZTbcjce4GkgJ7mDm5u+doPN/H+C5zd01GPPrX6akiBEIig5DTWj2s7hyVGlG
         MRFLDzdqaPcgarHYD79O3dt1ZsP+/+nCLILDtOSSs2kIuMISd3KRNFeszlvQecTCuuE4
         MjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717905; x=1783322705;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUsK7bpTixn+YbKeaafKtp2BKCKuSVgAGS2fazklOqA=;
        b=d79x9uA6od+bhOr9LDaXUs3VuVM+qHPdEuaVorpgF2YuvO+m2L8ka7HC0oo5Ym+Lqb
         XO3cm2J2XdaBfXCKoUKfPzWx9eJsN/tLqecWiTKBvnCTei4gTtiSjFjYX+c2ZKQ5y/H3
         22lu39dYcDD79HOe5qiAD4bJ8sF6XZI7HVtlFJln6QHMEW9xjaSuk0hnOet3FrtvNhVW
         vxVjShDn291Lp7CUq6OAXz3EtxYNO5+QEcEkN3hrYQ7U0aarYJzVVaC2fInkWDZkwdU4
         86WbB3iVchz4DX0/DqA6/YV5/AKdsj0x9z8VozztEPqZQN8yXCDso3z4kdg+Kq/nU4rc
         rF0w==
X-Gm-Message-State: AOJu0Yyt8dcOs6Utg6EYoHZBQzaQW0u5ojPP+9Dsn7ff0EYg+nxyB7kv
	r7caJ5qrIyGBG5Q6acqOpM6YdQzzaHGd8Fo1sPGGNjecvjuVknsxWZHaQ6EqD5eCrGfdSVOXr/C
	qPqnI2O7+HVJ0xS/30HrhGWHl7YrvgbEfA2mSh6zr6eMyd2xbRi64sBGGUhfNoD77TM4zIbviqM
	yBEi8t
X-Gm-Gg: AfdE7cnm5x5wkBwU3cEtTtK2ndPVtZCC3ZrWOQxRBL2gKVN3k/QDTxtadbIJa+QVEgF
	vdO4B3dtAoqnLD/DjBUVQS9dYZrQwdCtgBAUhulfEh9F2WrfSo2jn1P+/WZOQteZQf9pTBxOyYC
	o0H7BnasRuLzzzYSPPCqpWJGQQoW1AbKh7rrxcxJNHx7wMKEbGnY4rAXg9PeU6ldRyfjZ3FAO9y
	eRlyJqz2zbzUk0TO7fhvKcv3ykcpoktFIqSWajZtED0cSig/aYCXw8MLL1FaVQTD7Kcm+YuSnmh
	Yl4fP8l51dDWh1mzTupK5B3rLIZOt34DchIm8iFybd75DqIztjIu/d9GsCyJxrf7mt7tnS2wi/X
	/zy4sX2srDUrPqaB5pnYVoDDzUGC5p0xA3OCkBImFWM5N42An8HE6Vo8sTLwtN3AYoJCqzaOuQt
	BsKJz86Q==
X-Received: by 2002:a05:6a20:4321:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3bd4b2b611dmr14094223637.41.1782717904932;
        Mon, 29 Jun 2026 00:25:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:4321:b0:3b4:71a9:cd8f with SMTP id adf61e73a8af0-3bd4b2b611dmr14094205637.41.1782717904529;
        Mon, 29 Jun 2026 00:25:04 -0700 (PDT)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0eadsm7221679a12.20.2026.06.29.00.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 00:25:04 -0700 (PDT)
Message-ID: <b68d4aa6-b4ba-49b6-91b7-ff8c4dceb11f@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 15:25:01 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 0/3] wifi: ath12k: Improve dp stats
To: Sreeramya Soratkal <sreeramya.soratkal@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626085253.3927269-1-sreeramya.soratkal@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2MCBTYWx0ZWRfXy7m/V8QTf0Kv
 kGWqWU2t7cav7v4V+k9rLXSAkwXv66r3Wqj6JKhzQitcfC3C+klcep1O6uLVxog4sxyV98e+S/n
 Q57nL4LfVLeg4vVfD8/iNHnYI/Gwqvw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2MCBTYWx0ZWRfX6NxgL0siarRJ
 lJtI/8rGp+SLR3JUR8sQkh7sHNzwlTfOoHHf0AVMKnUc0ng4f2Xg26MOm0HmvyFClmwyUUjCF8z
 Y8X3B6T0qcl49L7h9nrupH/7hBEkPLwpGJnRKl5yqYrk+CbKYGtW1wOADd1cLsXdKkrtbr9WPA+
 jMFJPikOHdlqZbywK0iAyPJHi2A+nU04BHFIE+v2pG2RYqCceugBr2pXHA9BQlssBDowXUmSDs0
 METtMrwPwVe4XexFpzQqOEPDwbiEEYZrSbA9q1G+VOsgjKphEkr1QVrLfT0xyZB3w626ISFKFYw
 Z+hsme+KCqBo+ZsZ+TUjHiT2oqoQyDT8FCBWQy1htR3giToQPTfwLbW2Effs5frwiLyLtEBpJUo
 1bhOTbG0qmcJqayzPpKW8FDw84WriTYLvEnLbcwCkhHDWC7V0FzFP7f811R4VTlYni1dsXQW5hn
 g8omMTCR9/jzD0BJJ4Q==
X-Proofpoint-ORIG-GUID: t75oFtWb-dTPq8m0fh13D9Ccup7Zb3SS
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a421dd1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=w1hz04t2yJB1brSwPtAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: t75oFtWb-dTPq8m0fh13D9Ccup7Zb3SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290060
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38263-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sreeramya.soratkal@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D116D6D7014



On 6/26/2026 4:52 PM, Sreeramya Soratkal wrote:
> This short series improves the device_dp_stats debugfs interface in
> ath12k to produce more useful and accurate diagnostic output in MLO
> configurations.
> 
> Patch 1 fixes a latent correctness issue where the REO Rx and WBM
> release error tables were unconditionally printed for
> ATH12K_MAX_DEVICES columns showing zero-filled entries for device
> slots that have no hardware. Replacing the compile-time constant
> with the runtime device count keeps the output compact and correct.
> 
> Patch 2 prepends a ktime-based millisecond timestamp to the top of
> the dump. In MLO setups the per-device file is to be read
> independently for each ath12k instance, so without a common timestamp
> it is difficult to verify whether two snapshots are contemporaneous,
> making cross-device counter comparisons unreliable.
> 
> Patch 3 extends the existing per-radio section to report the center
> frequency on which each radio is currently operating.  This allows
> the reader to correlate throughput and error counters with the channel
> without having to cross-reference iw/nl80211 output separately.
> 
> ---
> Changes in v2:
> - Rebased the patch series on the latest tip of ath-next
> ---
> 
> Sreeramya Soratkal (3):
>   wifi: ath12k: Use runtime device count in dp stats display
>   wifi: ath12k: Add timestamp to dp stats display
>   wifi: ath12k: Show per-radio center freq in dp stats
> 
>  drivers/net/wireless/ath/ath12k/debugfs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> 
> base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


