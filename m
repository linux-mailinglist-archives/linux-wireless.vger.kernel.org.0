Return-Path: <linux-wireless+bounces-38926-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V/AnBDFIVGq2kAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38926-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 04:06:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A8F74687D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 04:06:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=IHiuE1u6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hcpZoY26;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38926-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38926-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66363009CC4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 02:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7C29ACDD;
	Mon, 13 Jul 2026 02:06:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AB1DED5B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:06:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908398; cv=none; b=C7gfe+EvC9oqc1NS/t2k2FNLpjypA9DLu5R1aXyXW3LWSTjXtaROD7J78dMz8NAq0OCtwWQ7f/nUPOfEB2thyFWZIAp/6U2PcnpDFHtlnSkM4GuVmxjXDkG7Wyda+eLXJPqC3EWldr1WpqvLpCNsQ3/xZU1FyQdRCU7PCKPROTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908398; c=relaxed/simple;
	bh=97Cs5eSgf7/zzptvwkKWN6KRkLp8ucyiDN4iCH+9ZRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUNk6BVUz47MO9AfoSOGFbFmRC1208RaQ0Sc4bgjSDVWxqZKAPFFH5XuEKFAt5CT1t80jX3qX6Uea+Rl4RYZw0bht8Ys+wDZGG92AQrTuB5DP0GqSIrmdFkW5J0jhzXmXQg537pGv+OpRNO7NjviStK+m5rbsvxq6GyrmfIi+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IHiuE1u6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hcpZoY26; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D0lQxZ4055414
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MLciHfmke9nWl9Pvf8WXpune9VTS2/9cKg/4HcTCcFE=; b=IHiuE1u6xlo9DQic
	ro3PvVtioWkiSrjDFXO8ICrLHO1ehyvtB4GlzSOk7KYJBuqz9wjDniW21Ylz2To2
	7XhCUxoKj/rJugSdCHDYsSD8tJK1sHzNiWkVKJnqRQDhIYjIY3NipKw5SB1THQbc
	The7ZlaHh79lrkM1zRI88svUiBSqCL4QPFlJZiK9ZTOr7qBMw+H+Gt1qCQ5AI6aG
	hkD7QGT55uFwR4VCHYJzLQ5yXjtEFpGiynhXTpvlUh8osU64rm74RrK5y1g2AmvF
	/vdFRDiUZ942EqhcyFVyXUOZQyEjWmRsL0/5/eEFiEZI4Pt0vEBEAFWfER6kh0Jb
	+iJXJg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeehm0ac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 02:06:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848551b54f5so5190155b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 19:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783908394; x=1784513194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MLciHfmke9nWl9Pvf8WXpune9VTS2/9cKg/4HcTCcFE=;
        b=hcpZoY26qtT6nIytfr+swe5v/eJIQTYiIEAzM7CMV1GuQYcHN2tzQsl/Ac7LjAaas7
         zSO//7a0y7Jce+mbW+fo2f6686Gi5wLhNJ04eOvL82K0Glsh181AdWGyxfBD8KryB7v1
         jlNVm/eIKWu3g2n7vs3elI5EKOs79SaiaCpv7NxOqryL0DoQ1y/KFaxBXJrINPQKkIri
         0xcekUteKD6i84McLDdmoDqNJ5ipTtUOnoE/24jsEK1WauJpgucs+kP9Y9sbLMs9UwoT
         dJ6l9g6HGyRBHrEpSF7P5ScYxGibyMgffN7MKWJKgqgCtbXUF99Ag55u3eOI2ubyVzhl
         CO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783908394; x=1784513194;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLciHfmke9nWl9Pvf8WXpune9VTS2/9cKg/4HcTCcFE=;
        b=H9seTtEFkcfsBJv+jE2vwdQnldNlISdrHEGORHSq0m+KMn8mjQhEVcXHftKnt7+Oo2
         kKzLvTjSIRJnvbWJrS3YdbumW8ompr6uLfpzRBDl8QdAsDjA/pqFuak+XLQklxuEc1Pj
         NLNoBcwMq9mLhjn9QvOs1JvCUJH/qA0XddGqezzIPtz1dVtBJ3Stbt6hOco/RoBVNnqJ
         s9skT06RiKWjWDiNKQxBSXUDxKb92JracKCKDRXL4TaWczeNRUkm5kqgJP7uTV7yog8l
         nzDE/dKVDXvSHsqkeg4Veq3DEeY8PhcP45t1cGW4WIHPQC7x6kpC1vLhGWPIMZ5E12IN
         8qTA==
X-Forwarded-Encrypted: i=1; AHgh+Rp++ki9hIk8uLCiK6luK8M8UHIUWjNXbQfY47J0sfK0Wvf8Aa2YxfdkmLEoeULVEozibnlsBkXw7VriGB0WGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjpOJhCgUU7dcXr9w2JiN71uGhGboOk1NnaUSkEsmjNuN5NS7
	aFqSE9Sw0DwNogHxYVvryXhdKYW6BR+NJ6H/q61fppv6f2dg86QBsUFS5msM+wa64J4lhxNQSUj
	pmZk6/e4A9CraFWx+Lb4TUNiWzcvXlT4L5fVk99rCnyuiEo6SifFOVx6aTm+H/JocFW+TMIpjME
	uDham3
X-Gm-Gg: AfdE7cnDe3kpSM7K/YvGrjKyH4+piFmZL3FdqnSat3/x17D7E2w/fDs8HQdXSNQGg+w
	nshU4UFkncqVtAq3otxP14iRACOb5xsDM0NH0pWOFobE4EYSTLPobu/ucuizwUn1Vajjy7xXBVP
	oC6XW9yF0LuhGxRQp0XWW++BV74M3w94XkoYXPEMuks68JKZcTQD7SEmcHrrGIaH3zKzoLnWeaS
	AgRmNjPMiV1d4H/VbgmRMNVWh8pNUL5DspTHIpoqrBML+3Nu4m0BLEnhPVfjzGDff6FwyKM5L/d
	ID/Tkjg6OChnhzTJxmy1mpDtb+weGkvGdmOChbaXKsIn3LQeb1CJVpnHY/2DKBYdxo5GVJhPDN8
	goduyYsD6egfzW+sjdsXigkrDSKRtqRDFe7EJNt/i+KbrefnsqnNBIxOz4KM020nwPvif/LWNh0
	UP0AqZiEo=
X-Received: by 2002:a05:6a00:230b:b0:848:2f7a:2e57 with SMTP id d2e1a72fcca58-84889758373mr7028644b3a.70.1783908394396;
        Sun, 12 Jul 2026 19:06:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:230b:b0:848:2f7a:2e57 with SMTP id d2e1a72fcca58-84889758373mr7028619b3a.70.1783908393894;
        Sun, 12 Jul 2026 19:06:33 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm13247250b3a.14.2026.07.12.19.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 19:06:33 -0700 (PDT)
Message-ID: <44c01b93-5538-4a81-ab5e-b25d0d56980d@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:06:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v2] wifi: ath6kl: avoid buffer overreads in
 WMI event handlers
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260711-ath6kl_wmi_scan_complete_rx-v2-1-22dc0f7f45e7@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711-ath6kl_wmi_scan_complete_rx-v2-1-22dc0f7f45e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAxOSBTYWx0ZWRfX+ylx80+3vj0S
 BHTV81FP9k1XiPQtO2WVJ2HBkfRPr/iwG4/L+Q8hkwXOLXac24LAVDH8+JbUKj1/Xw5H9RzQrfG
 klE2FJK6Ty23qgcXQcEcnTHYU4YOP4o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAxOSBTYWx0ZWRfX3ICh6RTLLeZW
 CvjU9phcqSTh4C9mBVIkrvBFueiiVlICsccsvAW9ghtbpc3ygybI6WLaplvdHAn1UiN11UHGN21
 RKqwKtj5slwWGTa0VpVGNKCxZN4uZ4sFBzWbJFNmEZl0denKgcAOr5DC5zV1aAJSZgtfwI52kWW
 wVmbmHxb6cN4qPTr5Xh+spCbeoGZA7eMJKy03MRWs/K/rbiKzh6DpSDgdgbpGpc5yOiuaDPIUtY
 NS4yPIkTbek+wr+uBsW42MSs8mQKUvmDTljjNP3uN+N4SqHKJs8yoAtSnQryeND8Kzkeq+3E2zM
 hD1TPDaal4WoD5Bwz5LL7kmYukArOOX0v78HFBb4Vwy+MxoFT7hX4qNy843hYOhMtQd0jnK8sRf
 sMYpQXHGhga8MT8h8Z9t5XfpOIl594r+klPifKjwNFrDuKmOJUZPiG8fi/0X++4iDcTAbSMEpzk
 +rRbUnd8WN3m7m29pJA==
X-Proofpoint-GUID: yevN8Ejd0Zi859YSfF3bdZ4yn1fPbNua
X-Proofpoint-ORIG-GUID: yevN8Ejd0Zi859YSfF3bdZ4yn1fPbNua
X-Authority-Analysis: v=2.4 cv=aPvAb79m c=1 sm=1 tr=0 ts=6a54482b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=KcS3GExwFv3QVkoieGQA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130019
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38926-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48A8F74687D



On 7/12/2026 2:04 AM, Jeff Johnson wrote:
> The following WMI event handlers currently read from the event buffer
> without first verifying that the message was large enough to hold the
> expected event:
> ath6kl_wmi_scan_complete_rx()
> ath6kl_wmi_addba_req_event_rx()
> ath6kl_wmi_delba_req_event_rx()
> 
> Add length checks to prevent overread.
> 
> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
> Assisted-by: Claude:claude-sonnet-4-6
> Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
> ---
> Changes in v2:
> - Added fixes for two more functions: ath6kl_wmi_addba_req_event_rx and ath6kl_wmi_delba_req_event_rx
> - v1 subject: [PATCH ath-current] wifi: ath6kl: avoid buffer overread in ath6kl_wmi_scan_complete_rx()
> - Link to v1: https://patch.msgid.link/20260711-ath6kl_wmi_scan_complete_rx-v1-1-7b11e5f8b96c@oss.qualcomm.com
> ---
>  drivers/net/wireless/ath/ath6kl/wmi.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
> index 72611a2ceb9d..08030d88c7d3 100644
> --- a/drivers/net/wireless/ath/ath6kl/wmi.c
> +++ b/drivers/net/wireless/ath/ath6kl/wmi.c
> @@ -1276,6 +1276,9 @@ static int ath6kl_wmi_scan_complete_rx(struct wmi *wmi, u8 *datap, int len,
>  {
>  	struct wmi_scan_complete_event *ev;
>  
> +	if (len < sizeof(*ev))
> +		return -EINVAL;
> +
>  	ev = (struct wmi_scan_complete_event *) datap;
>  
>  	ath6kl_scan_complete_evt(vif, a_sle32_to_cpu(ev->status));
> @@ -3352,7 +3355,12 @@ static int ath6kl_wmi_get_pmkid_list_event_rx(struct wmi *wmi, u8 *datap,
>  static int ath6kl_wmi_addba_req_event_rx(struct wmi *wmi, u8 *datap, int len,
>  					 struct ath6kl_vif *vif)
>  {
> -	struct wmi_addba_req_event *cmd = (struct wmi_addba_req_event *) datap;
> +	struct wmi_addba_req_event *cmd;
> +
> +	if (len < sizeof(*cmd))
> +		return -EINVAL;
> +
> +	cmd = (struct wmi_addba_req_event *) datap;

Nit: No space is necessary after a cast. This is a preexisting issue, since you are
touching, better to fix it together.

>  
>  	aggr_recv_addba_req_evt(vif, cmd->tid,
>  				le16_to_cpu(cmd->st_seq_no), cmd->win_sz);
> @@ -3363,7 +3371,12 @@ static int ath6kl_wmi_addba_req_event_rx(struct wmi *wmi, u8 *datap, int len,
>  static int ath6kl_wmi_delba_req_event_rx(struct wmi *wmi, u8 *datap, int len,
>  					 struct ath6kl_vif *vif)
>  {
> -	struct wmi_delba_event *cmd = (struct wmi_delba_event *) datap;
> +	struct wmi_delba_event *cmd;
> +
> +	if (len < sizeof(*cmd))
> +		return -EINVAL;
> +
> +	cmd = (struct wmi_delba_event *) datap;

same here

>  
>  	aggr_recv_delba_req_evt(vif, cmd->tid);
>  
> 
> ---
> base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
> change-id: 20260711-ath6kl_wmi_scan_complete_rx-a97c9cb39da7

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


