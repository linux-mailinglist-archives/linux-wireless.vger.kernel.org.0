Return-Path: <linux-wireless+bounces-31113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NdhLaJfc2l3vAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 12:46:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47275554
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C489030C0239
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345B36EAB4;
	Fri, 23 Jan 2026 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MkFFqzxq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DiI3N4w3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B03446A6
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168385; cv=none; b=TJA6i7FViTlNFnRsAtUa3Fh9Hnu3PdfZHOL2aNppBe9qMsE3f1d3v2trZzWlJ36ThPEH6rHdyPZ4Fz/9bEqIZzd2CweIBUGQ3AgqOESULGER9wXyoOLVc5KeP/PHovPgRofusw/n0nQ5zNLO7D8pTt84OhKcAkVk450UF/onDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168385; c=relaxed/simple;
	bh=J8pZ+ClusBGsRK+1ntie2Ynm5vfPef1pFOykEq3rn9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMuKoX+nMZPP3p5AFvn+GIxTXOcovYcSnzQwMB9cZrUQsEpkeXrzEITmYfDgvshX8R/QamBHFLBSi5ZkdZp2cli2MYWs/W0VzVZcZKvufycARity5jmG8MLMe89Ehp0KawqJtg0ApU48yRRzZIdMiQ3BDKkKYqLALZkBbxSLtWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MkFFqzxq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DiI3N4w3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60N6rjcL1327308
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 11:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kjPFUtx39Ba+K/bbVp5woEFBUQwLmQgG9crjOGxsSVw=; b=MkFFqzxqTFdn58vM
	Vvu0JJEJBA1un17aDZnkt/955Etg/U8OFsERG3Gpagq8muALuExZ+R8xg77+5RQg
	ng+3TbF4ZEAmBJYIcZuwaxN8yth+LkMCbRzKIcDJ0SC7iHBO77CGr1WIArIvooxX
	9FU1MeOJB/8/aGWNOeLYevPqrL1ZvdjHJrMBy5ohnwznNJAPJCx1KZFt6PTXsa4z
	/iaYlrPc3tirD++dOlts7uk5O1+T921GEcJzL1DdJnZGBDANmkYyMripLDvYyDx0
	0WulaKy67EAy62w52OsfGK0nLvdy1cwXxjviDmWXrMXccLCd8z8anIJJwieUQqDn
	zNGy4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv44c94tt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 11:39:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a08cbeb87eso22279935ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 03:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769168376; x=1769773176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kjPFUtx39Ba+K/bbVp5woEFBUQwLmQgG9crjOGxsSVw=;
        b=DiI3N4w3xby2/3R1KKqeFi/oMHrJyFxqiE8Jkv41o0B+aGwlGS6oaxZ7CxOWBD4N0B
         bLRmK46qepDfI3Cwrf+X73eJX3tH3KI0nG8x0h90+6I5Gkm1FZhdY9wJ+GmSCeIUb123
         XaVprcyS7UdykS6rU597NLmCtSoEVp/t3dW7nVOXF2OP9D+Lkh3gpBGy4aH6s5wR+e/O
         P7aSHtCM1SGN/AV/pJQiJ/DuPXgSpX8dvayIQ5n8lnwULHymOgcxrAYQmf7423SdrkbT
         ZOBF5wtsOHhPDuGwe7uQOIXf9g1VnSajPgfQCdd2So3H5IxLslMmWZpU7zPz4XFq/ejm
         RD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769168376; x=1769773176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjPFUtx39Ba+K/bbVp5woEFBUQwLmQgG9crjOGxsSVw=;
        b=ABxpfi0Jj1dyEC6tIdXr/0nd5iUNp/uvCF2Zy7ogv5GpyU/v9u6I24zWkIWHPgShJb
         PRvBZkAOgduvNfY5QNijh47kFuQ1RyK3ssUxA1g+H0Bm12F7BXxxPAXxYVHgTZa5ybhP
         CyBr/8KnFFe8bSCNldNUTO2qIxojUQWh+nhPXBipvtjcc1+pBgZpyciVSpLZjfMijUJO
         Idyu4uJ0SiViCUOh+BREQnjRmJdF4xpDA4hqFoaCXQPD1dVYkwuUm5lJrjjphpqCEwXs
         nXjeFSmVzbJ0Vpp9eq0aw+A5HJHNVehsGekLigTWfNCoNr6cnH6xrA3ukY291yb+CZK8
         iYkQ==
X-Gm-Message-State: AOJu0YzMGGzQtj+mbIePkgjJGjLhlP5/XfzBUO1zxgoPy9KReLn80UZR
	LAs5/8HB1nqI208aEtXP2z/cs7av3PPAHlbzfxWerHX7nMALNPOMnHYqrHav/XjGHlFFTRq1bC0
	qDqB6MIOicoW4v80C9UnUBg59uONSItIYKHOBKUD9QJdw3/6oyJ0j6j+O4qPE0UAyNwvdABWzIa
	Uukw==
X-Gm-Gg: AZuq6aILxh2NyVzHLmIi8EBsc3BO59R94ATs0GEYRAAzsv2xgRZ9PeSjUjcTykNBMsG
	kOfUnE+INpVD9q4Not03kJt8/hqShDldm1w5ARjLy3QaiFE6jcGKqM/naWM1CXOibK2WTEtu2Cx
	5Y5GV4qqdZd3ERIYXtVzKCT+MSg1wZrtwVMCmdNQZU8nVNMbZS96stL/QrEyV7swe+vUt52GgDO
	eYX1VBXTeDEr+1ZSlZmkRc9OC8hJIx312Szt7XILTLRg0lIqgzkvxhKpeNoI9lc2w9bQKQBZpyO
	S1z0ftLAC4l3DgpyfBbuTO0lMR34ghgL265ONgNTqa896btaPGt+seJQD3lsM7lH6796M6YjLtu
	3lKdFS0sZ3wDh8AkrVwmTwmdH1oPWeYtzQLk=
X-Received: by 2002:a17:903:41cb:b0:2a7:aa9e:fb40 with SMTP id d9443c01a7336-2a7fe73fcfamr24029045ad.45.1769168376467;
        Fri, 23 Jan 2026 03:39:36 -0800 (PST)
X-Received: by 2002:a17:903:41cb:b0:2a7:aa9e:fb40 with SMTP id d9443c01a7336-2a7fe73fcfamr24028925ad.45.1769168375997;
        Fri, 23 Jan 2026 03:39:35 -0800 (PST)
Received: from [10.151.40.229] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcd776sm18122495ad.26.2026.01.23.03.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 03:39:35 -0800 (PST)
Message-ID: <215985b3-e951-415e-b091-3306fa08036c@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 17:08:30 +0530
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
Content-Language: en-US
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
In-Reply-To: <d0798e0f62405687c57eff59767ac77b25c1f330.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TLdIilla c=1 sm=1 tr=0 ts=69735df9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=stkexhm8AAAA:8 a=aFT3MlpeULJ1tTDsbxUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: bXjX_tW07DXCTTPmJd_kNecnjXXpzgAi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA5NCBTYWx0ZWRfXzCkWdyL7yKRU
 uVX4vdEEoRJujn74lHBBLyUhuRqmJnfVfbkxANxZxIJSBiH9kc3RvHl1XL81uDCO+lNtG5yjOTd
 aLYApquPMmcAVWuYEmvep0kqUMu/dRtgTIrBvXSyHvvBb6BbCD8Is8N4/ZqrtWXRP878oVm24cQ
 RgKJcp/BmQ1Ic0pP6/R9FtY/XiSkeIev9s4gl4CLHBtfW4xB6C7dcBgOcHaTdALxE+TXBO6pJ+q
 EbS4GYNajRgnfwVKg1m8BLiUBsRtA9ibpqT+XQ6het3UGKwmGy9/hbI+6tZubSrLjxm9UUMc5nV
 oIqK7STF0zT/N+HVQCtgHyHK//FHpHgZ0NY3nLHv7tuOxi94OUeSQJ+p1bAUitvutbc0z2tFoUS
 D5YE8VbNh+Pr8py/qjwAHUReKkXI10PpafxhMkA7uiJUkA8BTxDFDmqMvL6y2ZUerGQJe5uU7EX
 epa/aMWlTllNXzj7C4A==
X-Proofpoint-ORIG-GUID: bXjX_tW07DXCTTPmJd_kNecnjXXpzgAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230094
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
	TAGGED_FROM(0.00)[bounces-31113-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sipsolutions.net:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sai.magam@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F47275554
X-Rspamd-Action: no action



On 1/14/2026 10:34 PM, Johannes Berg wrote:
> On Fri, 2026-01-09 at 15:33 +0530, Sai Pratyusha Magam wrote:
>>
>> Hi Johannes, I agree that by maintaining a local storage of the A1/A2/A3
>> link addresses before mac80211 translates them to the MLD addresses
>> would make things easy, i.e, they can directly be used for the
>> computations in the SW crypto. While this works well for the receive
>> path, on the Transmit path, mac80211 would still receive management
>> frames from hostapd with the MLD addresses, which again cannot be used
>> directly for the AAD/Nonce computations.
> 
> Fair point.
> 
> Thinking out loud: First, I think we can afford to separate TX and RX
> discussions.
> 
> For RX, I think we agree that it could be done much simpler by
> (conditionally, when we do translation in mac80211) keeping the pre-
> translation addresses, and passing them into the SW crypto. If not set,
> use the frame itself.
Agree that on the RX, crypto computations can use the copy of 
untranslated storage of addresses

> 
> Secondly, this all seems only relevant to hwsim. Do you think otherwise?
> Few drivers seem to use IEEE80211_KEY_FLAG_SW_MGMT_TX, so I think
> especially with MLO we can say that you simply _have_ to support TX
> encryption offload for EPPKE [1].
>
True, all of this is for the hwsim use case that uses the mac80211 based 
software crypto.


> Obviously we still want to have hwsim, but if this really is only for
> that then I feel we can still fairly easily implement TX encryption
> "offload"? After all, in RX we make decryption optional for every single
> frame - so if the device/driver didn't decrypt/validate the frame then
> mac80211 will. We also pass the key to the driver for each individual
> packet (struct ieee80211_tx_info::control::key). So doing the encryption
> in hwsim would be really simple if we export a function akin to
> ieee80211_tx_h_encrypt() that works on a single skb (which has the key
> pointer), sets up a single-frame struct ieee80211_tx_data and returns
> the skb from that [2].
>
"Implement TX encryption offload" - As I understand, your guidance is
towards implementing the Tx encryption in the mac80211_hwsim driver
Can you please kindly clarify if the understanding is correct?
In order to let mac80211_hwsim driver do the Tx encryption:
(1)Add support for key install to hwsim driver, i.e, 
mac80211_hwsim_ops::add_key, so mac80211 knows that the driver is going 
to do the encryption.
(2)A function similar to ieee80211_tx_h_encrypt() in the hwsim driver
that can do the actual encryption. Since mgmt frames need to use link 
addresses for crypto computations, possibly I could call 
ieee80211_encrypt_tx_skb() [2] after address translation to link 
addresses in mac80211_hwsim_tx() and since data frames need to use the 
MLD addresses, ieee80211_encrypt_tx_skb() can be called before the 
address translation to link addresses.


> While this may sound like a bit more work overall, I'm not even
> convinced that it's _that_ much more, and I it would also align hwsim
> more with how modern hardware works today anyway.
> 
> Any thoughts?
> 
> johannes
> 
> [1] and, it seems, correct unicast action frame encryption?
> [2] https://p.sipsolutions.net/154c5c86af7765fd.txt


