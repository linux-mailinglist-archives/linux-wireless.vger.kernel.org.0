Return-Path: <linux-wireless+bounces-31643-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FM3HBxKiWmg5wQAu9opvQ
	(envelope-from <linux-wireless+bounces-31643-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 03:44:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C953110B3AA
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 03:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10EC30078DF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C492D8391;
	Mon,  9 Feb 2026 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtJIPmOf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzemMA4H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC771A724C
	for <linux-wireless@vger.kernel.org>; Mon,  9 Feb 2026 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770605070; cv=none; b=J+SuHsIU1SAqQ53qIGpXLVd0tYt6KjzXzffDcyuGf2NRhfJE+m59SCtzk3j8KYB9eCEaOe/SGogcXEHazLcdC+EeOKvMPu+Ytjf5FLlIDQIZZiPXWEJSL/FSZ33SRSRTPrw5KX4saiuKP1z4+ZG4z3D5qrWLbb7WwZ6JoFjOZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770605070; c=relaxed/simple;
	bh=wMAzNBsLIzh8AdBwwAfwfOuVnKHjTtCFOa1IlD1Iu98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8DD+DV+u8kk32LUgcGT/Gp5iISPmAImMJGQMVS+Gx7Iz4CBtixnxtVxiLr6U5o+wOqyOohas1VlYZXcQyvvppBZRjQh++tFMY/mnu3EyOK3nEBwo1mBqV3ui1K44nYw1xh5t1JHIQi+AAjZHc2gN712VJ17ZkvVwqovUqGRwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtJIPmOf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzemMA4H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618MlQX41143825
	for <linux-wireless@vger.kernel.org>; Mon, 9 Feb 2026 02:44:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jtPBPWTA3XhB43g46fBcIikn2YEjSoXjfsxQdVazN0o=; b=mtJIPmOfY0ihPILH
	CcNKTCBXcjLho4W6CspKPIKiEUfP1HUtfuJUBTF0auy2Zi9DrpJfvcwHBSFMOJge
	bt30O3DjDnCfOljWWXlQklH8JPauKx0FjIbrLQDhvbLV4bksdDFyrceZZL1Y4TBW
	ES74y6EJG1+GeuPA2E7QCk6j61sc9sztXDA9Zqc+pqB42ojNpqZ6pRinljfRfpGc
	/UtfTn1iOza4SfCj5rI2zRwyAWCLVzZC5OgTCXwshpqs45Mkrlh1tnxomkV25B/u
	O59Weg25LNA3RHxSYWsNLw0cFn3L34vrPpGexQuZwQE6gxcEA66ulw8SNQmQ9P5C
	Lk9zfw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c5xdd3cg0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 02:44:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aaf2ce5d81so6182055ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 08 Feb 2026 18:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770605068; x=1771209868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtPBPWTA3XhB43g46fBcIikn2YEjSoXjfsxQdVazN0o=;
        b=TzemMA4Ht4cffaJ2mCyaRazZ2wpneixkS5QSJIixQ57+z+Uv8PUhxXCN89NdXylf0W
         sGbav+VEFLC1EqJOyF8sh+pO2p10H1A/y8mzUxIQxt3WoEPLpIiC4MDlgwzTnYYdLWu9
         ekzHZHl0wn1mnS9m077B5qsO/EQ+I1NCpYkcre8V/BEx846mOpFM27Qr/r/QsYmnQer8
         dtZiQKXBmMBW8jhvlWlyhhfXctyfJXO718OsikWTmOAe49IP9WOKohl6CsUZFybIFfdS
         wsDOzuVFxHCXdGjh/rzF/TDszVAz6I585Y8Gi46P/RX3NxUpe2d9O8lEz8bs6AeZoY9+
         heJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770605068; x=1771209868;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtPBPWTA3XhB43g46fBcIikn2YEjSoXjfsxQdVazN0o=;
        b=N4d9OMY58tqllJSZPKZIptXBi0QK3IkfbmXHaCK1JdiX9dje+GkrjW9+krKp2o4rFm
         CkjMw5RyC+4eBE+NBtGEwFiLBHXsuQZYU54yyBgueojZyvo4ZwQ2BMkwwp3HuelNuSHi
         s0G3VA3ppuzKQUzkaN6+gfQ/ciGjs7T07lPMDScKaeY6aomF0uMKsvm+gyhx/RRKGmWy
         HOh2Yl95X+B96RcfMN7t2uE6CKvlMc/Ny7J4wzvEfEgpw2wKA5q1U5v4b6PSGqVWrKJa
         q+f1xcT2hZR7i+h187jJuksPcTUnjMG6Pbh7eCtFu4WJC1kn8ZPVNKc4cSNPfzGu5hNL
         HVFg==
X-Gm-Message-State: AOJu0Yz+moayAx7kNNFZSCcJydGsGqF4uwHuFz1AZkCJiklp2ENxLrR9
	/kNqDbi26/3Tn+8IOWsRuGFtVHf268MAO5o01amsUDm2MppgDKXMBmVTCbK0nNx9Gmu6MRBXHeJ
	8jNFNRi+SQAap3BELK4Io7sXO4bvOxi1+zH2z0VX3T7wDrMyH1FSQqOt94DeJ3ctF0HGOPA==
X-Gm-Gg: AZuq6aIF7eLC1jjKMdPGMTxXRMm5jwkRTYW9VgWQT6cyJgaMZeANWMhmi9lK0R9w0T2
	nJz9kXRSRAAgiIO38RtTD75bHKyLB0G08ZVCK6hQEsfyQZbk7LRfChmG59ImkvRPKlNR8iSD7CD
	3Y/7VFu8CvsD4nf7pbP9dVCzWE3AMF5AN5OL3+iiNGNNWHaTOJ7j1GKn0P5OUWoBn2ky5UfnmO6
	8oIAfJI1sOf8QLXLzmoBvopm7XLLlGBnGcw4RK4v4H/uNkX3nedKsBpPWhLU0kvuB8e+pyasZzJ
	WbMgvb/a2zVq8ZgXJ+dQMoxAIc9nto6aBdvTy1DLyBPbecjO6LRLZN4/iAbws6lWuUBw7JMR4YG
	Krp7pUTifOmjiNXTDUTE8GREJs1tybYJJrgXVn0c=
X-Received: by 2002:a17:903:40d2:b0:2a3:e6fa:4a06 with SMTP id d9443c01a7336-2a9516f5730mr112529445ad.39.1770605067899;
        Sun, 08 Feb 2026 18:44:27 -0800 (PST)
X-Received: by 2002:a17:903:40d2:b0:2a3:e6fa:4a06 with SMTP id d9443c01a7336-2a9516f5730mr112529245ad.39.1770605067387;
        Sun, 08 Feb 2026 18:44:27 -0800 (PST)
Received: from [10.231.195.112] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9522287d1sm84336715ad.91.2026.02.08.18.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 18:44:27 -0800 (PST)
Message-ID: <5c152304-853d-4142-8553-55cd8907f271@oss.qualcomm.com>
Date: Mon, 9 Feb 2026 10:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: New warning `ath10k_pci 0000:3a:00.0: not found station for peer
 stats`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de>
 <6a83fd12-edd8-4559-b7ba-75b074fa889f@molgen.mpg.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6a83fd12-edd8-4559-b7ba-75b074fa889f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1A_Gk6E7G1Yb8kYp1FvoNUXfCCunaXtR
X-Proofpoint-ORIG-GUID: 1A_Gk6E7G1Yb8kYp1FvoNUXfCCunaXtR
X-Authority-Analysis: v=2.4 cv=Rdadyltv c=1 sm=1 tr=0 ts=69894a0c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=N1rzNnEruoIo7urGDNAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAyMSBTYWx0ZWRfX17731QsKSa2h
 6MuCP9FoA9OKk2oW/6w6YggzcdnFxv/ixL/youxAEyXVMoX2VvFuJCkdZtANTXNkQE5MXkmLJHN
 6P/pOEtzaARgqpukshJNcwSyzw5yukeJ2cSkJLe9kOCvby0YOnMT/4K8Ma1Dr6DkGFGXZZoJP4K
 p/910OupUNRBivsJUW9GRM0li1Ow6JKzDDxU0n5X12iNJ688sp6Ixw3pX0dq0Ifd6K9rHSzMCih
 ANxZLZAroCDD/x9IP6tHz60eC24Jc/wEju/XXNVCFTFU5+mjX3yAccNTL79qXSc6t4czVUZTWp0
 BCUwjo0ScJmHL9c366CEoNy8tdwhm9p60xBZka1eMw4ylvKOrv/jO72IbePJ4gC3gXZERPKu0J8
 purPGNUg1rr8ZaH7xuqWcMSPLYnHdRbxqvdMIGEvQt0W4vcbqwutZVP2BCWGa9x74E7STMsE+pl
 WvWDz/Z9vnPwDhkzUmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090021
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31643-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C953110B3AA
X-Rspamd-Action: no action



On 2/7/2026 1:55 PM, Paul Menzel wrote:
> [Cc: +Baochen]
> 
> Dear Linux folks,
> 
> 
> Am 19.01.26 um 17:41 schrieb Paul Menzel:
> 
>> Since January 10th, I have started seeing the warning below in my Linux logs, that reach
>> back to September 24th, 2025:
>>
>>      [   37.108902] ath10k_pci 0000:3a:00.0: not found station for peer stats
>>      [   37.108906] ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
>>
>> It started appearing with 6.19.0-rc4-00282-gb6151c4e60e5, the version running before is
>> 6.19.0-rc4-00003-g3609fa95fb0f, but I do not see anything related in the commit list:
>>
>>      git log --oneline 3609fa95fb0f...b6151c4e60e5
>>
>> The warning log from `drivers/net/wireless/ath/ath10k/wmi-tlv.c` has also been there
>> since 2021.
>>
>> Do you have an idea? Please find the output of `dmesg` attached.
> 
> Looking through the commit list from above again, commit a203dbeeca15 (wifi: mac80211:
> collect station statistics earlier when disconnect) probably introduced the new behavior.
> 

is this error seen when disconnecting from AP? did you try with that commit reverted?

> 
> Kind regards,
> 
> Paul


