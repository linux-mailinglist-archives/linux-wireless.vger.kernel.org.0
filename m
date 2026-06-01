Return-Path: <linux-wireless+bounces-37261-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADGTNiWPHWrFbwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37261-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 15:54:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DE8620571
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 15:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3034D300D4F0
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C023AE18C;
	Mon,  1 Jun 2026 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLx6/naC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hwqk+Ihx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2AB3AD520
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322081; cv=none; b=hSPTfPa8RyBgOCp4Lb8nMfTO/XEZQppsDFNysh3yKZxpG+3lwHv8cc9FIhecWzTmvz+Zxbkv4BZ2jQWIctXppnTjtBfrNtFsJl2oYbYa8ONOL+5gVdHTDEIlYGmP1cAsHMqSnk6L0aUIdb4fp6HInOyGj1epNHf6NsBHJMj0NBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322081; c=relaxed/simple;
	bh=Q3ZengQ4IRLYGNBWNlpT/D14IZyioia1aG8jgyEp4ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPuegW1tEqdYdtWfIqcRqln899RRVYtLRUuTvq2zs5/dP7fNNH4AJKpbQKikgPl+TW23Rafz4Lsvfj/KUFrCTL1TVIyCP3Fp+tSc9CP+LZo3PqtQMhoScJbdvDaVcqp7DiZNT+IJsk+P1nxvta07N8oJqnFqyAbNtaRri0dE4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLx6/naC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hwqk+Ihx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fIo51257639
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 13:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tsQa+ooxL+KuyWD5mAiKr5e5uyRG+3xbCwHL6U6EsC0=; b=mLx6/naCcM8HzVqR
	G15vzsmGz5ceDbttRzUdtzZPnV3cnSZhAb9Lh2mN7B5zYX82u9gadkBsH/BM60IN
	pqalWF/KsB2nPa4PIohAPjIIr6Cpho/reP0VZnXfvUnO0iXip7sta3H+GFx0i+J4
	u3t7y3czd9oyoUjn0tCGelrAk7djqBKOWfYfoQemk3CoEZgwI9ERP9QEqrEBLZ0X
	nolNi8vXtvR/er1kYX9uAcz2EcjtSVNEhwtvbS0xczHUwEzSh5LmXG3yXAm0chdq
	uS1EuSpkFF0vjAB65FPmeouuE1+A9PFrzeUp4qlmTxfEbayLc7A/7MX+/oenlFXo
	PtfUSQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sss84k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 13:54:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-304f1820babso3788588eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780322079; x=1780926879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsQa+ooxL+KuyWD5mAiKr5e5uyRG+3xbCwHL6U6EsC0=;
        b=Hwqk+Ihxtn0tatYJGeMy2OF9+ls2d+r8k8zQVhW6t0ZZxegjpiNt5hRNsQLhE2BkRv
         Iffu0d3VpN6vppx1FMVd29rR1OQPibSn+actuZg0wlTNt0zRi91Y18F7tUc2+ovTexHr
         SDTtEMGPXnH3IWixkygeZRLkpQst9vv/JrloTfNo48b7wHmrufT6fLFgbEIS+0g6M1Qz
         GrU7sDf/RGkUHxVsfKNE0oF19Kq3o5q3YNxnMs/zUGz/dC+Lhhwjx5Dq6YtxA3aIO6g6
         LTeoM/peL6wGez4suaOOmkBA94tGcSfvqFHRm2vmUDxU5ngMwL6SoPsMEmsMyQRvojVp
         wOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780322079; x=1780926879;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsQa+ooxL+KuyWD5mAiKr5e5uyRG+3xbCwHL6U6EsC0=;
        b=bpy4ypURc6N7my1jTNp6Kavq/GwARNA5bW9PpTvXkSeYGdQP2Du94qE6uMBKaBQ8G0
         nrfqkHXnVjE48TcYeX6oaVYsfVOZOE3/OT8tCohRTNlyFX+AEVa0rwJxYq/ILYMszLYA
         cgzf08bNissWwg0r8H7mYt0USoN6ZSyhbyJfs2h3yLsUQ1aBbNF8NlhWZ6bDwrCSQtKt
         LUgo+7w+MF+/yq2Cb8DKKYnMDeFhflFQcLb6QiSe1n2MJ1/koZyL3u75PwD5AyfxbGWE
         m07RBbNsax70SVFOKM8gsO80lp8Vbp1Lh3h3uYPBZRt1WNNs2ECUYYAdC4QduV5BH+cq
         cpFA==
X-Forwarded-Encrypted: i=1; AFNElJ8CKNdCNR3F8Hh02iVJN8Jg4GRWvC7cxFR2/iA7PeX990GqlDQOPfrDl3rMYaNY2zk4IQo3hjqoVVuVUfiS2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwL7b9MTXmGfME+H3lPdUw73gOxXcIbBoVpZIHRxQ0D57xKBxKV
	tk3c6sVh3IZ5U15Jt4Re52i6ekHqLDJq+cr6+YPZGxnBqfJJLS0t72H8TECex1Yn3Acw9HaARuh
	555UVKGZ4YKdPc/J8UrWD8G3IDmb/mde4HSCUAJr3JtJB4QcPnLktDVznJmyuVEbNV1P2nA==
X-Gm-Gg: Acq92OE3sOK6J+S5TJ5kjSQ0FmykmymKZn78QsIimeCruFl57otdlbg+3nLM3g7PhR9
	oc0tB4KZEFvlItMYn0e9UP7itakJJOemiyYIGREy06IVRtU7ep5nMIbv1lLLpLnW8SNjZ8OVA/2
	5vDDl8vUzb/7xetT/1w2S/xwWkTVzrrwg+YeOZbMI/wPYtTR/BlC1NPAuLvW9EW+coYdjSbbcyv
	2eJLtZVGu8fPASKK+y4Prj9ALBKbLjU5T7MRIyXK+Rfmp/zQE5LH8fQxXca/jF18GIQcybF6TsU
	jiQKROSSn5pk+l7BpKOWR4AXNWmEtQwvv4KEF1Tvmh5My/g448SVo6sBXuouZU3xhsVysi1lV8T
	+n9/QWfYNlHK4/WfVPa5iFzncNmBpeU20Wh4PdcPcuLioOoTnjHEZ2pOvSIbLJtOu/17BPrXIFo
	nggB1QeZrCC8pnOMZZ
X-Received: by 2002:a05:7300:72c5:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-304fa628f82mr5384215eec.22.1780322078815;
        Mon, 01 Jun 2026 06:54:38 -0700 (PDT)
X-Received: by 2002:a05:7300:72c5:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-304fa628f82mr5384181eec.22.1780322078081;
        Mon, 01 Jun 2026 06:54:38 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5a0b7dsm9202218eec.22.2026.06.01.06.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 06:54:37 -0700 (PDT)
Message-ID: <e5b487ea-151f-4d22-b046-b72447c023cf@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 06:54:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] wifi: ath11k: enable support for WCN6851
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
 <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260601-sm8350-wifi-v1-2-242917d88031@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: u2FyRIDP_MeItptVkXY22cWecG5upN6R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEzOSBTYWx0ZWRfX/6EzPD+GYKbJ
 XfbNAtQWPRYz71sh2iVIkig0HhLhGlfSoyyrJM/Ba3J1ByAitSWc3fnMAOBCDjFzx6gA8J5wIzN
 0FQz1O8I5npEafxXm/zhfiulCTtaHgymfWR4Trex3xYEJM4q1pwZh/SpbIdAS4P/Z+O/WdubSn1
 iOtEWqKJjpimptbprh9EKMdNYgLQt+AOF04SHjrSZXzMO9nhMQ6RB4jdXDv0A/FfgGswh/Rl6cW
 mYksasn6TaVveGC31Wyh8kv1UFzSBnM9Qem9YSliJ+G/scw9+5Pu/LDBRPwujiECy75DkSALbWR
 rbzLl+DnJhr3WIFK49CeCE5M6ii76HvwpGveCQ+8HluOfsw62q6ih0Y/O26LI6eYWthvHJGxQZ5
 CLa9w+FSic3NJQcITT5X93aQNNOROJspiwa0xJtr9B3hRmvLnEn+oLQ1/jnWZbokHfmJ7zn9t0O
 WWP4e9NeYW9UXVjofjA==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1d8f1f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=8x70SPmrBkAdAYyFYvgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: u2FyRIDP_MeItptVkXY22cWecG5upN6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010139
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37261-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,msgid.link:url];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,google.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 77DE8620571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 6/1/2026 2:46 AM, Dmitry Baryshkov wrote:
> The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
> WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
> configuration to support hw1.1 version.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 92 ++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  1 +
>  drivers/net/wireless/ath/ath11k/mhi.c  |  1 +
>  drivers/net/wireless/ath/ath11k/pci.c  |  9 ++++
>  drivers/net/wireless/ath/ath11k/pcic.c | 11 ++++
>  5 files changed, 114 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 3f6f4db5b7ee..7e997016cf6e 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -393,6 +393,98 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.cfr_num_stream_bufs = 0,
>  		.cfr_stream_buf_size = 0,
>  	},
> +	{
> +		.name = "wcn6855 hw1.1",
> +		.hw_rev = ATH11K_HW_WCN6855_HW11,
> +		.fw = {
> +			.dir = "WCN6855/hw1.1",
> +			.board_size = 256 * 1024,
> +			.cal_offset = 128 * 1024,
> +		},
...> +		.num_vdevs = 2 + 1,

this value is being modified to 4 in:
https://msgid.link/20260525020711.2590815-1-wei.zhang@oss.qualcomm.com

It is merging into ath-next today and should reach linux-next very soon.

/jeff



