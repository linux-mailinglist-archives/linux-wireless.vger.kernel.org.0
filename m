Return-Path: <linux-wireless+bounces-32071-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJDsOgrwmGl1OQMAu9opvQ
	(envelope-from <linux-wireless+bounces-32071-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 00:36:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854416B678
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Feb 2026 00:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D716304CA6B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Feb 2026 23:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E593112D5;
	Fri, 20 Feb 2026 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdtxsZ/A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aAGynS+2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EA30B519
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771630577; cv=none; b=M6OTWWC0I2Re9kOi3dS5PmjO7IK9eJqWjSthRYfu/A/qk6X0Li0f3B4HPACxlgx+o3+/CV4fvxRdVi0o1HbsO5CjeN1W+37W+KVzNNkp84yVBxz8xYpwsIjH+68DKmpIwxczYFVI+zirnfhkH8s3jGfiJr8hZNuqX87BVSKTVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771630577; c=relaxed/simple;
	bh=Sy6oXzoaOmP445ImcelGg3uJV3WSYuEW5jJwrUXkC/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWqCXFpihJXCXTTTKSDqD5OiWwsEusgqJXx9riVruZznlGZfjOnrCI1Xzi1AmnZjJiukuu5oONF/hPctRal7kkPSoN2ow+uO47ysHqISXruLtsUqBybVQPyPRAXL6Wbe7DrZz98iVxh7nfz8HfbzlJdR2zuWkJ9dHzSbQVbeJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdtxsZ/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aAGynS+2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KG5gse3697617
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 23:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8tydhh+6EmL3dAFMyH+Z+MIJDast/WxcYSEgk1cAR6c=; b=JdtxsZ/AA3+mxTq1
	rX2PZW4K+OILbGabe22w1LvF5sY0Y84/YyonHdJtau5p6oyjzn2wYsZPFr7wN+ia
	5WTewdXs1oveaLVxzDg61kuyjjGrcd3QyKtaRTrYPnJsuoftxS3neyJS+zRGK2qz
	eVacvN9h3cmIL7wvI3lB00Rz/LPxFOqhmwRArNb/V6CsAA+gDKalLBelTpmrCNAg
	/nQ06wKx7+zqYpU+0uVXtbf9ZdQdlSwnKZ2mplchIDX3TpUMTyizX9cTlhFjZkBd
	KJKMuG+BTCP+lZN9pDgpb2+q05LPWYzQpH0mSa5rgTnLpVvK06j4KQve3T+gzPEq
	wVFGhQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ceh5jjnrs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 23:36:15 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba8a461dd9so47238732eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Feb 2026 15:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771630574; x=1772235374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tydhh+6EmL3dAFMyH+Z+MIJDast/WxcYSEgk1cAR6c=;
        b=aAGynS+2ox/xnKNluy4SQ24fvANxoJ77qqAiMcmjjM60EuAyOprnHi0NhvNe3Fp+kR
         fZawLaAZTZt9URUL2mjEfVnq6U7YmpF2BFP56AjO0mozRLxRjJrZnG5VL5tXtWuB5NUI
         TZYLNtIuNEiYsWJmYdXAn8jcVYtYvXKnm+53NqK47cjdnBvHpPHkEY6NsJVDK1r0bFDx
         y/SUv1Ex34N/sL8CXw7wt39gigmAG6+QEZWGQrTETy/E3az4EF3cuPczzCVfEcqoONCQ
         ETvaivybwJYnjoIHy3MKwEofAFQqCBo8BOzD0ujyIk2A/PjAJcu8dLaMN4bqW35DWyvR
         P3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771630574; x=1772235374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tydhh+6EmL3dAFMyH+Z+MIJDast/WxcYSEgk1cAR6c=;
        b=JPGP6ZeiYloYt3fqPu8Q46yPrL19/GJeyUxL/VEsAc0ByQe7Jc+wtJLSvPScL+iEgy
         ch5AN4f6rkgMry4nHPqyFAsCkN0F55EtvXuSXOTiR4WJX/jWvQGzEhCT75u5TMO5ik8m
         widW5BoB510kCO3EtW/PJhZFA+OtTLfOL2Qw7eEnV2x1LcKuYdrU01Ofw3SoKPuGVts4
         T2aolPRYVLoZrSfNYTfOgFe1FlIS0tHY+kpj9Z7SNj6anAlOZF6Kt1eyDm0pEoUdKL5+
         +o8ByzhlhwJ4Zn/3ot2PQ788rFKdPr46lUeIEhMuGfQqsF5qHdQ2XNBdDTrALrdDEaHO
         Jpqw==
X-Gm-Message-State: AOJu0YzVgvN6H4Cv6eqwwE+Ak0kqQFBHgvLSoEQByqwat3Q14tcCAh1i
	AX6ZqRyyVXvTuU7H0gQK+ikY3XwkqAIAmexd6krmcR0TKLak9d7wYAI/MaI27Z9bgDZSFkuRBNU
	XO13qCIM7HS5Y2wNk2dApWYzrI7LkKYW+SW1Q9gBF1xmexlfzzmZkHHkB9yRvnZaBszEaBEbu2+
	6QVA==
X-Gm-Gg: AZuq6aKsUA0EisqozYABmeLWKwj4oc2XzQj8CQooIM6iON+yPz3x5rxR5p7qVlqROj4
	YCw/hlmdOFnpQoJDUabdEg7DmWlhIbCs6T28dFt3o9AhSCFD9ZMDCsZTNkKVPTHfNH5NI6Kk0Gf
	Y9gosI2KLetQi8SR8iLc5v1MBcknd0U4Sqhv/KLVli2f4KLmi43SKV/olC/HY7iuly2xpAtttrG
	BWX1mMXtx4BzCWPhNW1EVoFc82gKuYTza0kgXe7Cp42QycVHm+7BjGAusTWgRRg0JfQSHNkaBSn
	k3FpRSEViIJrVesfHs1lNSaBaG4JwcRqpylM3X3sDTNmQKuXYdqfeAEKXOqJYBsoHpqE4PmdVI7
	AwhHCMC0oAsQipSAvhtRrA38JcVRktf8TAcKJMQnK73j8FwRe5larhjRQgHBc6gIpj6Owz/ddqj
	kH7odZkux/dys+1A==
X-Received: by 2002:a05:693c:2293:b0:2ba:8ae0:856f with SMTP id 5a478bee46e88-2bd7bb53936mr730847eec.15.1771630574129;
        Fri, 20 Feb 2026 15:36:14 -0800 (PST)
X-Received: by 2002:a05:693c:2293:b0:2ba:8ae0:856f with SMTP id 5a478bee46e88-2bd7bb53936mr730837eec.15.1771630573489;
        Fri, 20 Feb 2026 15:36:13 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af207d6sm964856c88.5.2026.02.20.15.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 15:36:12 -0800 (PST)
Message-ID: <c2060e50-0e36-422f-bfe3-44a81fb96c59@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 15:36:11 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <aZP4RI-uN2001cBh@kspp>
 <d2a02b4c-5f69-4f5e-bc0e-428b64e99d36@oss.qualcomm.com>
 <6305fbc7-8210-4f4d-b719-30ba038611af@embeddedor.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6305fbc7-8210-4f4d-b719-30ba038611af@embeddedor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Raedyltv c=1 sm=1 tr=0 ts=6998efef cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Qanu7G-BKPL3DVzRuT4A:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE5NSBTYWx0ZWRfX/UIJBK5IFfkc
 texdRtygCOhk+Twq/FGgxN1IiP94zPBQcqyVPyZRpXoRrxfqZ8/VDv+yGp2A50eTaj3oTrY1jTJ
 OWHzYlmnb7s3BPWhlNQ7f8CluCPpa9XgTMH8EvjgQ9HqD9SOYrWGaEGfGadrbB3KWlrL5zjZNZC
 /8p0uoIcP23YCW65I/Jbe0cBzdXDFYV5K358KfuW97lgP7B3dNic+n5LcJw7pDU1LOVVMxeFSzC
 Uaw7hQfx3fRyeGd1O22LZeS5RGqiO2EJExX2Qk8jcvWl4De8Bbv5VorBJjq0WtTiX2Hbh+NstlZ
 Rq1Naa569l6STCt+TqFZ6h8qgt2a2jQ5XKJPfY2Rh2fWam00+Q4b8MMWcr3RvthGlA3/tRGh9UY
 1HSjLYahQL3fyxDAsCryv3wc7/TNwnvK1GezxpbgIzdAEMAB0Xulw6TE9UNagbdwf4ur6SuHTnI
 N/R9WFrhWxgjx2WNRrA==
X-Proofpoint-GUID: bkpyIK4O50sYKr09J0Ic1pibA5fuA26Z
X-Proofpoint-ORIG-GUID: bkpyIK4O50sYKr09J0Ic1pibA5fuA26Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_04,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200195
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32071-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7854416B678
X-Rspamd-Action: no action

On 2/18/2026 1:38 AM, Gustavo A. R. Silva wrote:
> 
>>> @@ -1652,7 +1656,7 @@ struct roam_ctrl_cmd {
>>>   	union {
>>>   		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
>>>   		u8 roam_mode; /* WMI_SET_ROAM_MODE */
>>> -		struct bss_bias_info bss; /* WMI_SET_HOST_BIAS */
>>> +		struct bss_bias_info_hdr bss; /* WMI_SET_HOST_BIAS */
>>>   		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
>>>   						     */
>>>   	} __packed info;
>>
>> That bss member appears to be completely unused
>> (bssid, roam_mode, and params are used)
>>
>> So IMO the better solution is to remove bss from the union.
>> And I think struct bss_bias and struct bss_bias_info can also be removed.
> 
> Even if they're not used, are you sure they aren't there simply	
> to define the memory layout of struct roam_ctrl_cmd?
> 
> As Kees commented[1], struct roam_ctrl_cmd appears to be a
> hardware interface... See below:
> 
> drivers/net/wireless/ath/ath6kl/wmi.c:
>   755 /*
>   756  * Mechanism to modify the roaming behavior in the firmware. The lower rssi
>   757  * at which the station has to roam can be passed with
>   758  * WMI_SET_LRSSI_SCAN_PARAMS. Subtract 96 from RSSI to get the signal level
>   759  * in dBm.
>   760  */
>   761 int ath6kl_wmi_set_roam_lrssi_cmd(struct wmi *wmi, u8 lrssi)
>   762 {
>   763         struct sk_buff *skb;
>   764         struct roam_ctrl_cmd *cmd;
>   765
>   766         skb = ath6kl_wmi_get_new_buf(sizeof(*cmd));
>   767         if (!skb)
>   768                 return -ENOMEM;
>   769
>   770         cmd = (struct roam_ctrl_cmd *) skb->data;
> ...
> }

yes, it defines a hardware interface. But note the 'info' is a union, and each
member of the union is there to support a specific value of roam_ctrl. And
since the WMI_SET_HOST_BIAS roam_ctrl is not used, the only important thing to
consider with your patch is that the location of the roam_ctrl field must not
change, and hence the size of union info must not change.

pahole of the original:
struct roam_ctrl_cmd {
	union {
		u8                 bssid[6];             /*     0     6 */
		u8                 roam_mode;            /*     0     1 */
		struct bss_bias_info bss;                /*     0     1 */
		struct low_rssi_scan_params params;      /*     0     8 */
	} info;                                          /*     0     8 */
	u8                         roam_ctrl;            /*     8     1 */

	/* size: 9, cachelines: 1, members: 2 */
	/* last cacheline: 9 bytes */
} __attribute__((__packed__));

pahole with struct bss removed:
struct roam_ctrl_cmd {
	union {
		u8                 bssid[6];             /*     0     6 */
		u8                 roam_mode;            /*     0     1 */
		struct low_rssi_scan_params params;      /*     0     8 */
	} info;                                          /*     0     8 */
	u8                         roam_ctrl;            /*     8     1 */

	/* size: 9, cachelines: 1, members: 2 */
	/* last cacheline: 9 bytes */
} __attribute__((__packed__));

So the size of the message and the location of roam_ctrl is unchanged.

/jeff

