Return-Path: <linux-wireless+bounces-38500-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4EQhKRkyRmpCLgsAu9opvQ
	(envelope-from <linux-wireless+bounces-38500-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:40:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A86F5610
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 11:40:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=XmxP3Mrd;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=PojEDEs3;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38500-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38500-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3EFF30D20E7
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0247DF88;
	Thu,  2 Jul 2026 09:32:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3E47ECCB
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 09:32:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984753; cv=none; b=Vsu8+vubeTcWgeiIA06r/leFVeQqMWowq57RtW8sF0kZdVk/AHtbhGEiLACJbkDbO1n57f/pyxZ3KTTQqeNDiP4oT3Om+vraoaXHYr13WUueFh/Ud5UkIDCxlfGe5k3MDRuj8hcJBMwLOc5IpPBUzqDC+zzJFgabMhkn/4hMtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984753; c=relaxed/simple;
	bh=x171MZA9tmoWMFsEZIltUkzuz6HwatXsPVOsCwvOgnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=StLxcTr+MjMimJPDE7Y0ZHJscwYaoOqtqScwYsEceOu7mfCxx9nHAGssV2ROtmeGDT3D8qOqVnspaZx+ztO3LUqrrQMrhJxcRFZbFSBZPKvFXvllhbcp4V6AW54RplU/3rQDu5PVFoDL82oHCEKvGF90/Dob9jVrhZ07iIr+ypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XmxP3Mrd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PojEDEs3; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628SEsM3049491
	for <linux-wireless@vger.kernel.org>; Thu, 2 Jul 2026 09:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ezVVq2U50VUNDTO74pfMslMnYi0egB4QQ7ic+2Doqcw=; b=XmxP3Mrd0lfibHS/
	6AA3jEyMX1ipSvtPD2Gh6XvzG5cPAwFp4qnqZZmh91WlNhs2dt4UwDz8bOn3WQjb
	W8cYZIwrYsPjqKlreA9VCKRHCHET7r9wv7Q2bTpwTpTGSuKIO0gctPPPNlk0MHmm
	tmWUxFDDVVfvdT6Pm8mC/kgYtVE3HHi5nTogSE7MIJ+Lpzhp2FWuKIfYCuj3LUzQ
	8fDh7aFnsN9ZHRlFF5kHSpdq4a+gtJS77gPMuUCun3l1IErSDA3mgLG3v1ubFeM4
	uEiWlXaevV7WDefPM7QfRMghA0T8KwEHjDrO2E8dMqBdgRJY0jyHJ2KXNFSxkOFX
	O5ylLQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5541v0q2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 09:32:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88cfe287e1so1451386a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 02:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782984750; x=1783589550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ezVVq2U50VUNDTO74pfMslMnYi0egB4QQ7ic+2Doqcw=;
        b=PojEDEs3WC1cR2mYKxALMgKEqeYcKhTayG2tzZ4eZ5ItRu62ANbZlxWGmgGYnZPkNt
         dZM1kMKXz3sF+TThe4Mq7yJ3LjuVlni+w0G/4jXglevWJ3WgM12YvHqfiJrg3vaShOes
         aTIC+R3125Xi0HbkdD787vU0qYwtcpY/MT94tN2wkZ+6mwK4hOLUtY1huwMOkTUsxkez
         pjecZsIwo9TAi54/3zsC7oZvhGJquRYMdPbHRE/9jbFezWSmdIAGtNLUCPDvgW/HzpEN
         FytxbzMwDR387uy2tD2C52JaFMo4R+6PVNwxssj8a8FReYb0aLwbvl9I2n0oxG8pBHQM
         kJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782984750; x=1783589550;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ezVVq2U50VUNDTO74pfMslMnYi0egB4QQ7ic+2Doqcw=;
        b=ROPEox2beE9LH6jOY9yURVCk7Df+s/ThsYCWzQZO1A1wAuik1Oj+M64xERv2Z2IFFv
         ZwU49N3vZeuoI7yuUbbLkCdu5e5/+CQv4i9r+DaOaeuOjLGU1e/9Hy7MuxHU10M+WN3z
         oi6B/leFonM2ZLM96yhsbxZOaf0JfUvMVdJ9wr0jL63UZFbOC99Vtrq92APezG6HnpcD
         am9aHvGGVsCgdMAkp4EOL+h+dAa62Nv8FAA9OBlfVjC8zg4sSP7IPRQC58XC1woaJYsh
         qIPIJq3Wm3hFAPG2Ka/B/easofInHVarTEOBlf2tcK5TqhIVdPf+12WwxtIfVcZWSvpv
         M2Ng==
X-Gm-Message-State: AOJu0YxUmHkSYXIQZw4emZm1R2XvPDsED3mK4ckFtwaLnBtp0IumbfgG
	rOANmIHrK2q/WqOGLKcFNuhW8bd5cb+L2D+G6omLZsXUN4oTi7dEQk1eyJTtoPBeNKuwHOUEaGn
	jb6PoCQ2BbO8IqSDWi5g/6Zl8WpRq+1y3WeypR0d8B+PowTDGQJdW30NT4mSPDLMtE30Bn7ThX+
	CLjxzB
X-Gm-Gg: AfdE7cnRH51nXNe4W/dhgZoLLS8tr9dYPN4O1KMM7s32B05QO7gmYc2IPpDok9a1ZoY
	dfOZPCeyPAVMZGbRhdCbx87nNrXHn5nPkolshFfTu6QuaB2pqpO6Yigtd3zPR9yJvZA4KmHOY/u
	ruCscFj/rfffyJDbdA9IpVUDYhvjFaslTMqgq1RKu+zsHEOlFTo/v7Qx9HaZ212sfa+eJkEpbTw
	3EJICige5YptKgseJvotXsUHs9anrrIiYnBk2CxgRzfrZ4pANJTE9pf0S8z/ECzyNMWY0liaABS
	JxT+q1DfSNA4OTlhVvagW0RAg2sKxHM+yJQjPyF0n3fJDRZky37O7THin4NpKKKBKeGLBA6OtKk
	meQsls99ngNYKccFSy0oaLvNCJVWgtcmiwhwFxj12he20X0WKMjNODJzc3ihnQVAYs5y1FbIhTZ
	8gDN0WgVuo
X-Received: by 2002:a05:6a20:d808:b0:3bf:b228:10ae with SMTP id adf61e73a8af0-3bff402bcd9mr5542811637.5.1782984749518;
        Thu, 02 Jul 2026 02:32:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:d808:b0:3bf:b228:10ae with SMTP id adf61e73a8af0-3bff402bcd9mr5542772637.5.1782984748824;
        Thu, 02 Jul 2026 02:32:28 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e92b81be9sm994089a12.30.2026.07.02.02.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 02:32:28 -0700 (PDT)
Message-ID: <8024a15f-bbab-47ba-bd18-f85eb1fe3dcd@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 17:32:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: ath12k: support calibration-variant from
 device tree
To: Andrew LaMarche <andrewjlamarche@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ernest Van Hoecke <ernestvanhoecke@gmail.com>
References: <20260630133001.1426824-1-andrewjlamarche@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260630133001.1426824-1-andrewjlamarche@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _VJKZ63AHlkEhMxOo9dQ6c0UJVuGaYJx
X-Proofpoint-ORIG-GUID: _VJKZ63AHlkEhMxOo9dQ6c0UJVuGaYJx
X-Authority-Analysis: v=2.4 cv=Xbm5Co55 c=1 sm=1 tr=0 ts=6a46302e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=DTxyy6x_7cgoCtCqgnsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA5NiBTYWx0ZWRfX8HLP9Ha6xvG4
 T+gEFjo2te5ps/Yr63qDh7StL+S9YeYfhklM8iiv2dlLySNyGpy4tryUXQR+s33+yUHOZzrByIj
 baBu8Ros9OcLDYdlIEgX1LKgLofa6/ktqkqApjlyXJFXELD8czSMwT+00lRtgavcQV54nzsStiO
 R0WqMYnAjIM3Q83Odyl3pZKp2ofhHe+zhFkXJt4lCHWWrjKKY8c2bdqhwb3utHH0QTSr1xiVs3R
 R3NWyguCuOCjTNfO4OpVQpIGy1j/lXNoPiJ3UBZ5sxYs9odt7ZLHR4A+JGQo/MtZVec8xosa/6s
 al4Nz4CGcNtulkI0QV+cXSTb+KVGaZ4UoWkdE3OEJ3DOvgLAK6a+myoZFcnOKv8avlNuRm+sJ1b
 bmJM2kQ1EXz6ZMR+Ov25e/K93jwN44lUZ5Mbg7v0n9uASj+fnyaPX9ZEX/oN9xuzBaLLDyIzfGt
 NcJd2hZn5mmVwuKxtvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA5NiBTYWx0ZWRfX0B2yFJU8RxCd
 p/ArKnzTfUxNNHprTPNYy648dXcgzQd0RA37NyKube/M3YTqMMkSYWxUimD06UV6SsFUI8VUZlB
 yD9+9eDmz719E9cs8l2FwBRkiQdTPMg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38500-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrewjlamarche@gmail.com,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-wireless@vger.kernel.org,m:devicetree@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ernestvanhoecke@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,sipsolutions.net,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 124A86F5610



On 6/30/2026 9:30 PM, Andrew LaMarche wrote:
> ath10k and ath11k support reading calibration variants from the device
> tree to locate the correct Board Description File (BDF). The ath12k-wsi
> binding already describes using qcom,calibration-variant but it is not
> implemented in the driver.
> 
> Many ath12k designs expose all the radios under a single phy, each of
> which typically require a separate BDF. Without this, the radios may not
> come up or will not be calibrated correctly.
> 
> Fix this by parsing the device tree for the generation-agnostic
> qcom,calibration-variant. This allows the driver to properly select,
> read and apply the correct BDF.
> 
> Signed-off-by: Andrew LaMarche <andrewjlamarche@gmail.com>
> ---
> Changes in v2:
> - Drop ath12k-specific binding qcom,ath12k-calibration-variant in favor
>   of generation agnostic qcom,calibration-variant.
> - Link to v1: https://lore.kernel.org/all/20260131003222.2011259-1-andrewjlamarche@gmail.com
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 22 ++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/qmi.c  |  4 ++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 742d4fd1b598..52c28864c63c 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -812,6 +812,28 @@ int ath12k_core_check_smbios(struct ath12k_base *ab)
>  	return 0;
>  }
>  
> +int ath12k_core_check_dt(struct ath12k_base *ab)
> +{
> +	size_t max_len = sizeof(ab->qmi.target.bdf_ext);
> +	const char *variant = NULL;
> +	struct device_node *node;
> +
> +	node = ab->dev->of_node;
> +	if (!node)
> +		return -ENOENT;
> +
> +	of_property_read_string(node, "qcom,calibration-variant",
> +			&variant);
> +	if (!variant)
> +		return -ENODATA;
> +
> +	if (strscpy(ab->qmi.target.bdf_ext, variant, max_len) < 0)
> +		ath12k_dbg(ab, ATH12K_DBG_BOOT,
> +				"bdf variant string is longer than the buffer can accommodate (variant: %s)\n", variant);
> +
> +	return 0;
> +}
> +
>  static int ath12k_core_soc_create(struct ath12k_base *ab)
>  {
>  	int ret;
> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
> index fd762b5d7bb5..3cf39ae06fd3 100644
> --- a/drivers/net/wireless/ath/ath12k/qmi.c
> +++ b/drivers/net/wireless/ath/ath12k/qmi.c
> @@ -2945,6 +2945,10 @@ int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
>  	if (r)
>  		ath12k_dbg(ab, ATH12K_DBG_QMI, "SMBIOS bdf variant name not set.\n");
>  
> +	r = ath12k_core_check_dt(ab);

I understand there are already some variant exacting helper (ACPI, SMBIOS) being called
here, but they really should not. After all, how could a qmi message relates to ACPI or
SMBIOS?

I'd like firstly move the existing helpers out and then add the new DT helper.

> +	if (r)> +		ath12k_dbg(ab, ATH12K_DBG_QMI, "DT bdf variant name not set.\n");
> +
>  	r = ath12k_acpi_start(ab);
>  	if (r)
>  		/* ACPI is optional so continue in case of an error */


