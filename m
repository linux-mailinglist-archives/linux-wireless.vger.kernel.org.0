Return-Path: <linux-wireless+bounces-32768-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MUzJWbYrmlhJAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32768-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 15:25:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 201EE23A7AF
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4378300A4FF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BB3CF67F;
	Mon,  9 Mar 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIrd9jD8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PRSHI490"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CB3B4E96
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066339; cv=none; b=JTVbLuGRzxBY2NfC3wQzb4w2/9qvkXpTExy4fpmI4MiVF7/2qqLjWnroeQ9Ya3vRHCsMB9Oma0LIc2/0ef7us+Ny7TK6KtwGvEsaOJiK76DMu76bfWLd9CWZm7ew1UutagQvVGfGumStnkPDffqyfImdN8KmIK6Qy8g1fUn87KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066339; c=relaxed/simple;
	bh=azQSRLMessw6PfqehjRKxtwatJZVUYZIbjclNb7dUBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EA3ozrKPt/mn5XNZCdMcnj2Jn5y0ldjaNXrswABpA2/SFLRxSy/vSbc5e410tUDW93N56KZmGtHXun3lRIPIYS5JXei0iW/2ZmrI9FUvp1XdCUyoezWlYOX/wW8sSXTYfPuUOAfywNBBOBdAsvMduhwj0tp+ZPlzWvx5ZW+86sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIrd9jD8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PRSHI490; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629EBewL3051928
	for <linux-wireless@vger.kernel.org>; Mon, 9 Mar 2026 14:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sCy/7bNPumukp1dhkeDCTkTHaoRsiqnKlSErh36FKFE=; b=DIrd9jD8ILhi4Nsl
	xNXXJ1vWMhUVFYQnRnIT1faXlHrKKsh9CbK7RSql+sLptno72azBG8FsplTLNu9l
	7VL3SzVYSHjoI/auolOM4NY9J27fu9KXMZVHBDDmxO5MXtfPYJQ4RjkdP6vrVaaR
	PFozG330wPhBbf3SkA0kjuzt+68Hvab9b93eTTp0XZ1rMzJY83g3m6HgU7iaEFog
	8bvEuHhHhksbk3WL0Nihvt/aS5pDRCwSB4qiCYPva8KtkazNXAlv3PlWfdhQppZl
	CzS3g07Xv5kE6TkFCpnrIOqvhBPFaV4um1j0/OMk3YIp4zsITtJEbY2Zkq3HFZk1
	kLp9IA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cr9qex2ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 14:25:37 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-128d285d6c3so2269886c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773066336; x=1773671136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCy/7bNPumukp1dhkeDCTkTHaoRsiqnKlSErh36FKFE=;
        b=PRSHI490B+ilkuA1/y+TwRS8MrGgZdXnUjwSFL6SzlcopE9rAlAf6zowbvhZLq+Zpi
         pCYES6slHBuyrT1PQYYWl0dLX897QCmTmUeZU/w94iNGNaM9piNs8YbRPk3LMoaitBn3
         cL8ayBTNKRuZ/kyhcXtl2SHnNFT6NofskHqJDWRsBXQDHonAEHv8lP+88FYUCtQdg+si
         Nyth7lD5hG6mxK+Pnxg7UjNpZiABOje+eHiZbq/j9z92zpiaqLVaotl1rjMep03dhrSo
         1fG1k12nFUv7y1d5tnDpxFc8fB+YtIsbRtrY9c2pS59+/f8Bikw9NzYL8Qpr8nAccioG
         N/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066336; x=1773671136;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCy/7bNPumukp1dhkeDCTkTHaoRsiqnKlSErh36FKFE=;
        b=Ph128eBuH4rYzkhj5HhRnCIMphRUhl2Zb7FAoL2+22j18syV9I40RTJ2L2mgGaPhiy
         /CgPYJ8cJ/CFwC8cNtCvb9JSDBWxnQ4Wwpi0D0zjF5FmnrT62OnxBzflgYxknwlFMcP4
         3IRlGGbxKw3vztguVIhdNNXrIkltLKzlSEJ2FjTNWq9DYQhlEp3bNimVaTcodQlsw9ni
         dH61oBeIc2kdO7GMwMDLEs2bAJRqxbx1I753gDT+4zg0ITv5F9sH7wFmOWFJeCsWXB4o
         ZF8BG/OVifT9ZJJ2sh1QoHDBDHpAHgMs53iz/8HrxFSn+ECmQV2Uz8r0iwph9NBjDQN+
         4orQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFOoKokw167cjKGAg1tTrti1+to9XEdXLUtu1usFBlXy2KuFdNMruYyR+WoQ+uEm0CCBZaN9IJdoPBwP7mFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7OmwRUOVMjcnrV/TNEIgaqa6ACGMwWkQ8r7y6PyOy+3XbwOmI
	GA3dt8KRT8uj/+HM40tD+ab/MYwzWdbMO2bxisdrswUBjYMgM0/zcRPmM/pvf1GrhnDfDa5sNBJ
	WGK7wgLHE2LaYsAbjzwP2RhsNzxfh9Lf/KcmJbpgvrjJvCifUplqBmRalxdTcZ9yddIi25A==
X-Gm-Gg: ATEYQzzZ2ptPH4Z70DeOYqLgRRB8zQCF8OHorrTZvUFcFw0zxvB/HOxtg9aURiuI5YM
	sOXmQw+X78Rt3IusctHp+qdpDTDln4KqjffFJ3gs25Cp5TC6ItdLvVBM6usf15F/iRq9SFSR54b
	G3rXjtudvFn7CEGmcJHXcm2YfALMA1Ja67r96yc0Q4Z1ZrbyfFHEj5rc8efdsuVpxLTxGU9pewv
	2xe9ofp2amLKTdsVlIxTQO/cH2V5hkbtTbNV1NDxyDgGlcxy9p4Wkhzz8dRUJ6/8HG9++N0EZCH
	CO1eaH/Y/lTRVKin1NAfhhfGpBu3sr1Swz7+/KnxLawUgy6jy6D9o7qcSlimM7EwSIuc2uMuT92
	NbWceh/9e18NDIWud25nNxHLQF7nFpTQvDpyX28M1Gcse7ZiOJduXTqvApaVBUdmrDaoDa7N2Pm
	5T6uB+Vw==
X-Received: by 2002:a05:7022:521:b0:128:bae0:e044 with SMTP id a92af1059eb24-128c2ea1c4amr4480297c88.30.1773066336464;
        Mon, 09 Mar 2026 07:25:36 -0700 (PDT)
X-Received: by 2002:a05:7022:521:b0:128:bae0:e044 with SMTP id a92af1059eb24-128c2ea1c4amr4480265c88.30.1773066335624;
        Mon, 09 Mar 2026 07:25:35 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f433d2sm8885113c88.10.2026.03.09.07.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 07:25:35 -0700 (PDT)
Message-ID: <c144a9ce-ee32-4918-a21c-e06d3d450e93@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 07:25:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] wifi: drop redundant USB device references
To: Johannes Berg <johannes@sipsolutions.net>,
        Johan Hovold
 <johan@kernel.org>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hy?=
 =?UTF-8?Q?gensen?= <toke@toke.dk>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Jakub Kicinski <kuba@kernel.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Hin-Tak Leung <hintak.leung@gmail.com>,
        Jes Sorensen
 <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260306085144.12064-1-johan@kernel.org>
 <beaed1d8-6c51-4aef-9fd7-00d9646db948@oss.qualcomm.com>
 <14fc35deb48f21c38bf957afc05eef1664bf3e81.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <14fc35deb48f21c38bf957afc05eef1664bf3e81.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pUSdtLpZQ28He_fxVUU-kGU5npx_lhMj
X-Proofpoint-GUID: pUSdtLpZQ28He_fxVUU-kGU5npx_lhMj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMCBTYWx0ZWRfX0ls11b4gwLZj
 Eq2SAOmC2YelgJ0VjWk3o2XJnNaz9NeE1USSO7gH+MucNbOmnxim0lBkqnaJVJ68nqtv8W3+bwF
 s9a1xguM/r8QOYq36qE/TZFm7kFS//OPbr7cx+P6moDjbcL+rXm7xcQUF+SwOjb61aNjo8vRbpv
 xMJ8ZiB5MkCWvX1eBvF/tNTMT+tGwbSs0G45hf8Bdwk51YAYSdzaA+O0zx/fDsnFKl56IYqYmfs
 9eQKXHPL9oKNVlMbT9UBAk1yF3rN8dZQuovUJVxuYz889EwLINoJU+kgLNbKvm/pJCnvMvJKyCK
 PMOe3kwzA9v9M0J//C6kqrm7Y04+DJsWfwPh6qtSPYi9r+rYo+udCdOYZghJOos3hFPF2fmnaPI
 Np4UEt9EOOaUrppfq3Ee3GUpRUUSxrAaY8nfXG+6ObQZihCAsQ3edtxlPp2aKMuHLsiYcaf0Fj1
 Ux+K3Op1pCa1XxOeN+Q==
X-Authority-Analysis: v=2.4 cv=dcqNHHXe c=1 sm=1 tr=0 ts=69aed861 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=hlJU1X-t1t6aQb51OtoA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090130
X-Rspamd-Queue-Id: 201EE23A7AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,toke.dk,chromium.org,dolcini.it,nbd.name,mediatek.com,wp.pl,gmail.com,realtek.com,microchip.com,bootlin.com,tuxon.dev,collabora.com,linuxfoundation.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32768-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/8/2026 11:27 PM, Johannes Berg wrote:
> On Fri, 2026-03-06 at 13:39 -0800, Jeff Johnson wrote:
>>
>> Johannes, will you be taking the entire series via wireless-next?
>>
>> Or should the individual wireless driver maintainers take their patches
>> through their individual trees? I'm OK either way.
> 
> So far I took the ones patchwork had auto-assigned to me. I can take
> others though, no particular preference, but I guess I already pulled
> the series apart anyway.
> 
> Let's just say if you want me to take any, assign them to me in
> patchwork.

ok, then I'll go forward with the ones assigned to me...

/jeff

