Return-Path: <linux-wireless+bounces-38026-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sc92FuAZO2prQggAu9opvQ
	(envelope-from <linux-wireless+bounces-38026-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 01:42:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CBC6BA9BF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 01:42:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=aH1Nl1wr;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bhrhxssN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38026-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38026-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9C1C3099E25
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAC26ED25;
	Tue, 23 Jun 2026 23:42:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8537206E
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 23:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782258142; cv=none; b=IvquJAh2Ba2x59Hjv2LK8HCgXrD7vBVnvwbAU7+i8myWg7Urcx7NXkGnm0UXPJrcGuoKnKKINTxchNdodptXpOd6zKmqmy8+yk4PcBRsD6NmNcmICmlARphk1cmj39kMqkVIYsuOkbIOHmQ330xinbEi+r4FsO0qwZEhCVnRogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782258142; c=relaxed/simple;
	bh=Tkgs6uLtp6SM6Kvhf95hHrkgIRvO8G5n1IhTbV+wxA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMNumZCiuzQDfqMfKiqaXkFd2xCXF4eQHPw2FSZF/StjfQ8u7s91cou1F8WI1gFrpYwBKInpMIXfGzcr61pG3Dqeqe3vmBDPXLZyYBvv50P3KRYmD0K91ozpzsZVROo6CI+dr13wBov/22QE6cXwAO2FwMHLg9KcYOEkl8zHXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aH1Nl1wr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bhrhxssN; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NJwlfO706642
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 23:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UnUrOm0jOF2HVTeAUGtjnEXVGqZWWgWnDQ6liGwYCcc=; b=aH1Nl1wreECVIsbD
	4HnwSz1xHQqvBD9qMvR5uTwoXzPdu1dnzjR764RGxKLZ2qjMq0f/G4/BI6TLHuDS
	QvjQzBUvoyDoDMZDKjOofVi/K72Mq9MIfI9NunR1EzdV5DxEQkIuuqu3T1dbKsTC
	Hfkadh9yIbA4tYfxOtEIyXjLLiRfLG9AWGwUCLM5lzPJ8dkr1E5ZhX1mdG0PrDTT
	+gGNXN8usud1F1fFLjQsDb/7fRe65p0csqEAdF9d4qjh7Hivy9IMm5/3/YNyZAt3
	2M1BZta4esWq75jaspEkJvvui/d+yydT2vMpa7P3+oQxR1NCQ7lICNg6fsQ5CPG+
	uO/DKQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyp29krfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 23:42:20 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-137fc6f8e9fso793801c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782258139; x=1782862939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnUrOm0jOF2HVTeAUGtjnEXVGqZWWgWnDQ6liGwYCcc=;
        b=bhrhxssN8ZH5sX9K3Ht7FUnhnwRSi5o0N45kofsAqzpnmk7/G+3RjdXik+IvK6ANoW
         GdeWV63Zw/zJGQHY3X6kHAcJo1DQqDGFQ8Us+uygFN2A8IHsKrAEfNViXRL1Jv+CzwV7
         3q6+n2vblhib8D/U+b2YmGVzQJoN2r9+1ajqHEShPptIMY3Jwjq3G7Cfb6KWRFW8pWqG
         HapK6H+IRttEb7XpFxWyd/5GbRnU4g7+/Paq1+/4B2Y7lpVE9N8kDd2JhbbMfjGT0J3F
         weoehQe3ujI/loNTcYJlKbjxZKkJefIoe2QB6dihte0cIIW7oJCZfqYIWVN8IRCbeOwL
         nVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782258139; x=1782862939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnUrOm0jOF2HVTeAUGtjnEXVGqZWWgWnDQ6liGwYCcc=;
        b=TZsNOrBKU/dqWX39ht+rKX/O5DytavfTVDizwf+a0LP9i6dVqtK3dxLeqo3mbn5va6
         6A0SDkBloo7cs0CFrDFCktJDKafZ3Cp8N7PMRDZpGF0wfCuj/hRICUTzQW94I0hEUf/s
         7qMuSDcRRbW+WF/7V78Y/WCcOQfzlewB6YCIRgX+ycRVjiYUgotEABmdbVB+JH4hNwRc
         rcG+BOpOjXxiEVQZKQCen1PmHehm9NIWC+nWw8eE+P0gtw3wN6pIlJaSS9bDiCbPOh93
         DjqtmxrwvanpdHTjYocR7Bh4POyK3k9k41M77VAHWn8kWWrHL6+OFF/GuVGSk7dhvgdG
         DeEw==
X-Gm-Message-State: AOJu0Yz62RhuUrU5/pilymaCmoeMQPWVX0XY0Qz1xb+vPJdXyVbyR4nN
	KT811XKVy5bhtCGGjRVT1hp+2QLEPWxVN+da9fosGmjzx0170TXiNgQCnVHJvjQgkQaJdhcFrf0
	xyt9mvEls5pEl0UVJUOtxVyq1xut8kSAf/XDFCsGGbq3Hj11oEf5MdjkAmtr32kHJGfr2lOpNA/
	wc3A==
X-Gm-Gg: AfdE7clnHlC3E2ZpWF+xoppyOnkU4edgkuBndqtBflxBscfHoguJWJBnjI7iG671pMu
	Le8e0XIWDmHIwErXmUmjHl9BgUTQN150Dnpn3UEW/2dpk90tr0nyVfUET38O/VsmyKaec+HLuat
	pgynNlOcOatBIUXgqQLZj/MqF943EYGUqKiCo8735Axndzc1xLGRMLcOx0+mR52pTq5S8qtgVNx
	854NpgKkOJSd1uLvse/k0JP6xhQb3c3/Y+hV8ydDl8poxKqgEe6yNDcRYRdUrF6dPZCYfG2IQTp
	p3WYOrqzT38MMyl+SqI7euXAZOaUGaxzbbPN1zVrj4VBMhkumf6mi1pSfs9Km1kMRZFnm0L1bS6
	jAfe1fPxO0Ovxc7xea5UZ8jvAHkt0LUsZFilL/4d3hjqeDvgYYlmiTRTLTvFzDqfAUudK0UA=
X-Received: by 2002:a05:7022:305:b0:137:f532:e360 with SMTP id a92af1059eb24-139d0c0bd49mr696659c88.3.1782258139243;
        Tue, 23 Jun 2026 16:42:19 -0700 (PDT)
X-Received: by 2002:a05:7022:305:b0:137:f532:e360 with SMTP id a92af1059eb24-139d0c0bd49mr696641c88.3.1782258138653;
        Tue, 23 Jun 2026 16:42:18 -0700 (PDT)
Received: from [192.168.1.11] (124.sub-75-218-227.myvzw.com. [75.218.227.124])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add5bd68sm18298383c88.11.2026.06.23.16.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 16:42:17 -0700 (PDT)
Message-ID: <44d9944c-3760-4ef5-8830-265eb2e9b896@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 16:42:05 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdAMLDfi c=1 sm=1 tr=0 ts=6a3b19dc cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=xlPm5vGA3/o/kwQtH2yPVA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1wjBKfE2vB2PEQuW5ksA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: gcNnImDZq8nH9oELiaLG6972Wh4mvxMF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5NSBTYWx0ZWRfXwSkla8UB6iFB
 rlPTcBF0GPAEBnPp5BajAc2PaCHjIRhHQnTmIdbi707Kdkcw/y1Dc+ohGJOCe4k6y4tbvpNwBDd
 o4MTrv39Z7Ibhrle0e7GaPI8J6Z47mo=
X-Proofpoint-ORIG-GUID: gcNnImDZq8nH9oELiaLG6972Wh4mvxMF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5NSBTYWx0ZWRfX3bkTSEwFEY54
 OYn9bo5I7MGXQujuGv1S4p4UD70MxpnFDAhwPRzPs7f1SCjP8p+tlZCk4YSXOsKHvRWXoNvj34L
 ETjcNqfzpOGvcLlCP4FP4y/jbFLlv0fDNkaJb4F4A8XHYlxz8NY2G2nzwC7KoJXoUW4fEyd3DM2
 6i9lnnsId+j3e1faRZ6aY5iKY2n4TYjNluDTMp3i9OsEdd4StZZvJC/UAORTHpUccJBwktiqW4q
 afMqTY6lguS7M/U+uYmrqdZl7uMWbKsc5lm+w4fWLK7sU/ATCQefQgpMsE+mf2kmHheY/bNpMkQ
 vbQN86kUNbikp3xPIV/ibevhmaKFdoTzUgrV1OOLvqgL8GD5P6t4W56ZcEiVsGgmQocK4xg+BDj
 yZDqE4uCJK8Ey+KN6qapwdjGo0FxCtqmUm8uyZHGnNqOn3cCEKBu7urf3woame9pEwGuochxERG
 IbBPtlTxbmFXzW0ZEHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230195
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38026-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C0CBC6BA9BF

On 6/18/2026 11:58 PM, Aaradhana Sahu wrote:
> On AHB platforms, firmware operates in two modes: fixed-memory mode where
> firmware uses hardcoded addresses for memory regions such as BDF and does
> not request HOST_DDR memory from the host, and dynamic-memory mode where
> firmware expects the host to provide memory addresses including HOST_DDR
> after the Q6 read-only region and relies on host allocation for all memory
> types.
> 
> Introduce QMI capability negotiation to support both modes. Add a new QMI
> PHY capability flag dynamic_ddr_support which is advertised by firmware to
> indicate it supports dynamic memory mode. When the host detects this
> capability, set the dynamic_mem_support flag in the host capability message
> to signal the host is ready to provide dynamic memory allocation. This
> triggers firmware to send the HOST_DDR memory request and use the
> host-provided address.
> 
> For backward compatibility, if firmware doesn't advertise
> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
> where firmware uses predefined addresses.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
> v2:
>   -Dropped QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN and QMI_WLANFW_PHY_CAP_RESP_MSG_V01_MAX_LEN changes.

I think you needed to keep the REQ_MSG MAX_LEN change.
My prior comment that the REQ_MSG MAX_LEN macros are a layering violation was
constrained with the observation "that is a preexisting issue with the QMI
interface" so we must continue to pass valid MAX_LEN values unless the QMI
interface itself is changed such QMI determines the MAX_LEN

>   -Used %u instead of %d in the debug log.
> ---
>  drivers/net/wireless/ath/ath12k/qmi.c | 50 +++++++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/qmi.h |  6 +++-
>  2 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index fd762b5d7bb5..e15a0c0120d3 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -506,6 +506,24 @@ static const struct qmi_elem_info qmi_wlanfw_host_cap_req_msg_v01_ei[] = {
>  		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
>  					   feature_list),
>  	},
> +	{
> +		.data_type	= QMI_OPT_FLAG,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(u8),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x33,
> +		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
> +					   dynamic_mem_support_valid),
> +	},
> +	{
> +		.data_type	= QMI_UNSIGNED_1_BYTE,
> +		.elem_len	= 1,
> +		.elem_size	= sizeof(u8),
> +		.array_type	= NO_ARRAY,
> +		.tlv_type	= 0x33,
> +		.offset		= offsetof(struct qmi_wlanfw_host_cap_req_msg_v01,
> +					   dynamic_mem_support),
> +	},

Does QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN need to be updated to account for
the new TLVs?

>  	{
>  		.data_type	= QMI_EOTI,
>  		.array_type	= NO_ARRAY,

