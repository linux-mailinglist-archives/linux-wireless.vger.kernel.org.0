Return-Path: <linux-wireless+bounces-7021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E18B67FB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 04:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88868285DF6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 02:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C53D27E;
	Tue, 30 Apr 2024 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CNQLRAF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367FBE65;
	Tue, 30 Apr 2024 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443872; cv=none; b=pC8qjcrU+9lyW7pV96cFyxggdpimjoKVUl7ElnxEhHrJj6xOrceFUFY5BRy3I408oDpG4CF8S2AbK1qy8RShldBqThGnax6uSZCn9BIjHCaqcHV822mFvfUIwFfTNmGd4C+koWEbO/3SiPBXNttmIJkqyHceZ24G0JF5KSh8CZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443872; c=relaxed/simple;
	bh=pmwqwsEcd7U/qZHJ+Dc0ucUAvzmGVQhizHBuwyENqAg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nH7HHrTMxNcoyQUe2zukDb+pZo0YwEsptEKF/gytsIuH5hYYmJR6OseXS2w3xkwJ1plSFKlboztz31zVPMjdYcZrDpHhIQb+KSCidj46JsNK1A+imbUFfx6+raUJ3W1qwKNCX26oHbemy98AGZ3listw2HzZeynScW0rdNLxf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CNQLRAF0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TLbejC032540;
	Tue, 30 Apr 2024 02:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=6lrEskrEUqVZMAmiL5Nha
	YKYFsg09GatthIqjRXOHU4=; b=CNQLRAF0YB1UMllen2w3LoURtQQev/OIHvN4R
	2vuL8oyASxSwu/qD0G0YBTFz10l5xFQT6yjvyfuTKGi6MXG8eBzvR4QFOv21q1Mp
	+LpWeX7o2x7dU2tbAScxbRObVoXBp9g0m6J2KodafbVVoud2odERjYXgfGaJZj+I
	LWUEjzkwXjB8Lgkdu413z6+WrEgD/HGit/+Pn27qYfDfAlORTcFXH8LevdKRZ21X
	/WAm18pKibqYXZ7q1U7rUerr1RARUNi+4USg5LqZBI3Kud3mBeSjypc6kP9TG+A3
	VVOTpkFNouq1pi/Nh+4AD8vTyhEz7rBHulVToKS1wFpmvTziQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtd8kjyhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 02:24:21 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U2OJ84024694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 02:24:19 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 19:24:19 -0700
Date: Mon, 29 Apr 2024 19:24:18 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Marc Gonzalez <mgonzalez@freebox.fr>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k <ath10k@lists.infradead.org>,
        wireless
	<linux-wireless@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>, MSM
	<linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        "Arnaud
 Vrac" <avrac@freebox.fr>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Alexey Minnekhanov
	<alexeymin@postmarketos.org>
Subject: Re: [PATCH v3 2/3] wifi: ath10k: do not always wait for MSA_READY
 indicator
Message-ID: <ZjBWUvdEI6aq4s6M@hu-bjorande-lv.qualcomm.com>
References: <ebbda69c-63c1-4003-bf97-c3adf3ccb9e3@freebox.fr>
 <23540303-5816-45d5-a1af-5f09d645a73b@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23540303-5816-45d5-a1af-5f09d645a73b@freebox.fr>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HYKogTH30GHR9Si_6cD6fVVZkiUuS6SK
X-Proofpoint-ORIG-GUID: HYKogTH30GHR9Si_6cD6fVVZkiUuS6SK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300016

On Mon, Apr 29, 2024 at 04:06:29PM +0200, Marc Gonzalez wrote:
> The ath10k driver waits for an "MSA_READY" indicator
> to complete initialization. If the indicator is not
> received, then the device remains unusable.
> 
> Several msm8998-based devices are affected by this issue.
> Oddly, it seems safe to NOT wait for the indicator, and
> proceed immediately when QMI_EVENT_SERVER_ARRIVE.
> 
> fw_version 0x100204b2
> fw_build_timestamp 2019-09-04 03:01
> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.1.0-01202-QCAHLSWMTPLZ-1.221523.2
> 
> Jeff Johnson wrote:
> 
>   The feedback I received was "it might be ok to change all ath10k qmi
>   to skip waiting for msa_ready", and it was pointed out that ath11k
>   (and ath12k) do not wait for it.
> 
>   However with so many deployed devices, "might be ok" isn't a strong
>   argument for changing the default behavior.
> 
> Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
> Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>

As with patch 1, please address the s-o-b and accept my:

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> ---
>  drivers/net/wireless/ath/ath10k/qmi.c | 11 +++++++++++
>  drivers/net/wireless/ath/ath10k/qmi.h |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
> index 38e939f572a9e..f1f33af0170a0 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -1040,6 +1040,10 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
>  		switch (event->type) {
>  		case ATH10K_QMI_EVENT_SERVER_ARRIVE:
>  			ath10k_qmi_event_server_arrive(qmi);
> +			if (qmi->no_msa_ready_indicator) {
> +				ath10k_info(ar, "qmi not waiting for msa_ready indicator");
> +				ath10k_qmi_event_msa_ready(qmi);
> +			}
>  			break;
>  		case ATH10K_QMI_EVENT_SERVER_EXIT:
>  			ath10k_qmi_event_server_exit(qmi);
> @@ -1048,6 +1052,10 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
>  			ath10k_qmi_event_fw_ready_ind(qmi);
>  			break;
>  		case ATH10K_QMI_EVENT_MSA_READY_IND:
> +			if (qmi->no_msa_ready_indicator) {
> +				ath10k_warn(ar, "qmi unexpected msa_ready indicator");
> +				break;
> +			}
>  			ath10k_qmi_event_msa_ready(qmi);
>  			break;
>  		default:
> @@ -1077,6 +1085,9 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
>  	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
>  		qmi->msa_fixed_perm = true;
>  
> +	if (of_property_read_bool(dev->of_node, "qcom,no-msa-ready-indicator"))
> +		qmi->no_msa_ready_indicator = true;
> +
>  	ret = qmi_handle_init(&qmi->qmi_hdl,
>  			      WLFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_MSG_LEN,
>  			      &ath10k_qmi_ops, qmi_msg_handler);
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.h b/drivers/net/wireless/ath/ath10k/qmi.h
> index 89464239fe96a..0816eb4e4a18a 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.h
> +++ b/drivers/net/wireless/ath/ath10k/qmi.h
> @@ -107,6 +107,7 @@ struct ath10k_qmi {
>  	char fw_build_timestamp[MAX_TIMESTAMP_LEN + 1];
>  	struct ath10k_qmi_cal_data cal_data[MAX_NUM_CAL_V01];
>  	bool msa_fixed_perm;
> +	bool no_msa_ready_indicator;
>  	enum ath10k_qmi_state state;
>  };
>  
> -- 
> 2.34.1
> 
> 

