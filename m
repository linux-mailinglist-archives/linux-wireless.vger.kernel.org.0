Return-Path: <linux-wireless+bounces-31436-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NWuJSU5gGlX4wIAu9opvQ
	(envelope-from <linux-wireless+bounces-31436-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 06:41:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E3C8586
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 06:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BAF53012C8D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C3B27B33B;
	Mon,  2 Feb 2026 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sa7vbtZ6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RlCb5OoJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EE23FC41
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770010890; cv=none; b=D8yGQgRLMBUUptoJDLL0SUMJpUDURkS72EdL5kkEc7djqH8xd0kd8Ec7iyVAJrdNvy5rmMBMEh0Ds4d/Wxf/krTgHUBbbQsaxjTUdUVKHwxpfxyCixTfOPvElPDjyIbGC4hO07VivuEejqnhB/FHS8iNqiyaiVe5tHaJNKsMzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770010890; c=relaxed/simple;
	bh=7li1w60YDu8fBhFKnosn7vRh6X5Z8Zxp8vZZacMvEco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vC8Zrb46CBwi10kLd38fplJ6ViYHZvofLGS5pz6qh0NgpMNTJM3dfcpeWBBO834IAUJx6thyWVu54DJZsYdtNfa2ItQsuQewpkDMYhdAe9cLICXerFCZzQJx8f0qIJ8Avms1PLTxDgDM5A7EHHiqGpXhWlOcWt8c0Ny8hXseuXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sa7vbtZ6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RlCb5OoJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 611LU2c21107334
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 05:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mtLFJYcrjCiMJd98Lwr0yiKdc1nXe4JABQ+Z06ifBU8=; b=Sa7vbtZ6nQIGUAHq
	3EJABAWzE1TTVnt1AVkiEvc4Q4xZV9hEesojC//EUynIeVqFsdN8FrnPYhJOrcxn
	V+lYrjrGukVQ94Q9i+ao/DO3dLL8W3PNShmBxamWUIR8RSflAqkuoqharaaQulp1
	iv7d1+r+R4QU2OrQBzVpp1A8kuP9zle/VXXumWjk9VusCEMmZr6bYbiRPnkf79sC
	Ob6OoEtGSRNSdwH157MJgjil7BJWfEh+mo/y5Pg3kwGQP+Y3gCiLaQZTBdxZ8sYA
	82ZVU/wwWf7SWKlC5ZrhPVUz4XimAUfDpHMOVg5NcAeA9gN9Kp//OzC49lJMW84N
	f2ng0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1as0v2bt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 05:41:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-352de7a89e1so3362767a91.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 21:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770010887; x=1770615687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtLFJYcrjCiMJd98Lwr0yiKdc1nXe4JABQ+Z06ifBU8=;
        b=RlCb5OoJviQv67ag45j5exRKTdoY/UiYlR2ntJm9/1QSQ3zXgfEEET6qjMMov9VTlP
         h4tgHm7YD2XvOHvJ+PRjs0fXZTPQJVL6cypCJOztf0zKZSsbiqDm10ysGKE0a97TI3Y+
         19aAS3BS6xArEV2dD3gbbZ3h8ID0/jqOUxpNhBnA/V3ypao7d6bLhBvmq1XD/6TxjNFF
         eo0ditU0FLtQMFCu+kjf9tkIMzgjcH7W18HgBuRyupIZSH7tZqw8u3yqtsbyVlIqoJRi
         nnnNzv4nv21aafGnVUZM1PkxL1/OVv2TVXlZNVi5KIYzE9x4pNdW1PVSpI8RY6GNth+C
         7O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770010887; x=1770615687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtLFJYcrjCiMJd98Lwr0yiKdc1nXe4JABQ+Z06ifBU8=;
        b=XKP9hQVNu22tI7XWCWHc54AjQoPXqYcn00ETfwlJLZUEUXJJzY17NqqacfjeULIkcP
         ykv1CV3i825XJLA7Kz7ESylSuSoMNu58KjbubhaNpw15+5/PfnT57A/SPQnx28xpKX2W
         Ktk0xd5tibtjWGyFYfk9zQE7dtKT+HfvlY/W45C2ctlVD5V7W/cIQiyo19YdbghG/SmW
         A2Dlv87ol2zxsQLxNjTuZ8djICTshrOO/gAgoUe9iGyOkOOxNZkNOi+WPNUNozUukHH1
         tiwlWvaP7OTKM/Wz+USVYjTam0FZtFr6Hpmk+ix0637LA+8t8HiFbQZtgEdQszOZgNwg
         iG8w==
X-Gm-Message-State: AOJu0Yyp04dnrYt8leT0u5KsMZQ+h8w4oJAmRMfeaZ9jKTdQV9AdtWAf
	Op5PMjErkShktqYnD0KmHiy9EF4XyJgMJBhXTX8cTZMPzhTk7MeISW9VZ/+QnLaOd6gx6dQr3+w
	0P7yEH7yW/Ogvp7MVw/XJT8UuiIcxyinMdo2ldh7eDjszd9XfgZ51K2wTnI5Te/dKpobA7H0Xks
	ymFg==
X-Gm-Gg: AZuq6aLlOMqCWOeoa/pvuCRyDzVKj5nL/goPwY9dIKxQwS9iNsBlF0A5yrRrrHQXYl4
	Pwf+OsN00Z1VNYA7aT1sG3fFQgF+CS2MWGjK/nV8JqfGqk8nMgekPqnHmAk43akfm8IojfmWtyn
	zC0byl96A8l3NMuVH5l+epoV3PyJXUH85jYtTKsxvxXqe9RruoQx8RVmxS5pKw7Xc/ddFPO16hv
	j+TorSirez9DQQK7sLuOuYWSnkXmDfHyJWk6nyqxEnwhwj/fRC1vS8GOXQ0rrVaLDC/+jdKdjAF
	UbbXxmR7qdBkcGm2Sn/LTHLefr3rGbeTf2m5LjVJ595YAlVeiF1Tqdwzdm53zyMmYwq0Hiutg76
	cBIO/LgeA6MeF0lhGWswDf2m8H/xc47Xw3WQ=
X-Received: by 2002:a17:902:c412:b0:2a5:8e98:1b44 with SMTP id d9443c01a7336-2a8d8150429mr111261895ad.31.1770010887054;
        Sun, 01 Feb 2026 21:41:27 -0800 (PST)
X-Received: by 2002:a17:902:c412:b0:2a5:8e98:1b44 with SMTP id d9443c01a7336-2a8d8150429mr111261695ad.31.1770010886538;
        Sun, 01 Feb 2026 21:41:26 -0800 (PST)
Received: from [10.152.200.28] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b426e3csm140851375ad.44.2026.02.01.21.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 21:41:26 -0800 (PST)
Message-ID: <7dc9c37f-1c8c-4ef1-818f-e8d494f2d269@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 11:10:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix AAD/Nonce computation
 for management frames with MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Rohan Dutta <quic_drohan@quicinc.com>
References: <20251211123612.2470117-1-sai.magam@oss.qualcomm.com>
 <5ff51b07b69284ca9b477dfcbe08890167c7ed14.camel@sipsolutions.net>
 <0847363a-055a-4d6f-a9ac-b62f275e02ec@oss.qualcomm.com>
 <d0798e0f62405687c57eff59767ac77b25c1f330.camel@sipsolutions.net>
 <215985b3-e951-415e-b091-3306fa08036c@oss.qualcomm.com>
 <6fbfb8b4f4a4a745b81cc8f81e01429ca90aa547.camel@sipsolutions.net>
Content-Language: en-US
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
In-Reply-To: <6fbfb8b4f4a4a745b81cc8f81e01429ca90aa547.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA0NyBTYWx0ZWRfXxGdUwDHXfK/J
 5U76Y2K8ZyoJXDmzAV1nrQwgopt4lBtQ2aP1S7Sv2FJFNnAbqL3brn+bAZ7TQPrQD7cHtenW640
 g9DE8iNfcVqQdXB2fe3fjAdudzQo5iulxZlsXh7LA16tdoaVy6E4uF4iZDaSmukVjFBGDcX5U9N
 8goAbeUyE0urVJ/ZUPgaWK1i7rh49Nb49ebulfEHajHMx9UdF0jbuEy2T/egVqsdQ8l1LlwjJfC
 a7PRX7CA3n1J47mwxggpjAIBN5y8poudtiKC1cTFUfBf6TGChSiO+WY5VK4iYgE59H/bEk7PDQK
 AZyhvYUQ0NSoEq1pv77Aeq3uV8HkPhhKpTMwT1U9GgpAQb7WJiwwZNriTBjNnNHOmle61EQiEYF
 8nQHOEDvf0WQqQjb6AxM1/hm/BaxWa9/LsH/2Cjn6aqCWLtVhX7HoRxkHC2NiEX5vxw6xFkDlzJ
 CzASfFDUyLlzb/x1l6A==
X-Proofpoint-ORIG-GUID: yju2Eoqb5TE6cmyFLS7if_Josqt4gFTU
X-Proofpoint-GUID: yju2Eoqb5TE6cmyFLS7if_Josqt4gFTU
X-Authority-Analysis: v=2.4 cv=MYthep/f c=1 sm=1 tr=0 ts=69803908 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=L0msaxlLO5fdjjvlaekA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020047
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31436-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sai.magam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D9E3C8586
X-Rspamd-Action: no action

Hi Johannes, Thanks for the elaborate response. I have been working
on your suggestions and will send out the next version with the changes
incorporated soon.

On 1/23/2026 6:04 PM, Johannes Berg wrote:
> Hi Sai,
> 
> So I'll preface this saying (maybe again) I'm mostly thinking out loud,
> because adding 150+ lines of complex address munging code that reaches
> into a lot of different data structures for what's effectively a hwsim-
> only special case doesn't seem like a good trade-off right now... If we
> can avoid this in mac80211 and push something into hwsim, it seems like
> a win even if it were more complex there.
> 
>>> Obviously we still want to have hwsim, but if this really is only for
>>> that then I feel we can still fairly easily implement TX encryption
>>> "offload"? After all, in RX we make decryption optional for every single
>>> frame - so if the device/driver didn't decrypt/validate the frame then
>>> mac80211 will. We also pass the key to the driver for each individual
>>> packet (struct ieee80211_tx_info::control::key). So doing the encryption
>>> in hwsim would be really simple if we export a function akin to
>>> ieee80211_tx_h_encrypt() that works on a single skb (which has the key
>>> pointer), sets up a single-frame struct ieee80211_tx_data and returns
>>> the skb from that [2].
>>>
>> "Implement TX encryption offload" - As I understand, your guidance is
>> towards implementing the Tx encryption in the mac80211_hwsim driver
>> Can you please kindly clarify if the understanding is correct?
> 
> Not sure I'd say "guidance", but yes, that's what I was thinking of.
> Note that this is fairly limited, I'll elaborate below.
> 
>> In order to let mac80211_hwsim driver do the Tx encryption:
>> (1)Add support for key install to hwsim driver, i.e,
>> mac80211_hwsim_ops::add_key, so mac80211 knows that the driver is going
>> to do the encryption.
> 
> Yes. Note that due to the mac80211 SW crypto design, it doesn't really
> need to do _anything_, because:
>   - on TX, mac80211 gives the key in the tx_info of every skb
>   - on RX, mac80211 will happily do SW decryption if RX_FLAG_DECRYPTED
>     isn't set on the skb
> 
>> (2)A function similar to ieee80211_tx_h_encrypt() in the hwsim driver
>> that can do the actual encryption.
> 
> Actually, the function I posted in my other mail was going to live in
> mac80211, but exported to be (only) called by hwsim. That way we can
> reuse all the existing mac80211 code without making it more complex.
> (We could even put it under a hwsim ifdef or hwsim-only export
> namespace, but not sure that has much value.)
> 
>> Since mgmt frames need to use link
>> addresses for crypto computations, possibly I could call
>> ieee80211_encrypt_tx_skb() [2] after address translation to link
>> addresses in mac80211_hwsim_tx() and since data frames need to use the
>> MLD addresses, ieee80211_encrypt_tx_skb() can be called before the
>> address translation to link addresses.
> 
> Right.
> 
> Given the function I posted wasn't even 30 lines, and the key install
> function in hwsim can be basically "return 0", the RX part likely won't
> be _that_ much either, I'd tend to think that overall it could end up
> with even fewer lines of code than this solution, never mind the fact
> that it won't have to reach into all the vif/link/sta/link_sta data
> structures.
> 
> Now I haven't actually written it, so I don't know for sure it'll be
> that simple, but at this point I'm fairly confident it should be? Do you
> see any holes in this?
> 
> johannes


