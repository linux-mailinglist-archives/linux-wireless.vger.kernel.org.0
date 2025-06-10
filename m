Return-Path: <linux-wireless+bounces-23915-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51658AD2C0C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 05:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F73AC84F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 03:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBDC130A54;
	Tue, 10 Jun 2025 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LSUZJxjg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83159460;
	Tue, 10 Jun 2025 03:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749524596; cv=none; b=sYkevT6kck1uUgkqQ/Waw2H3v4dGfPX6BdxNCigosovjD9cLDluBGJu4nofZOhUJy3P52Pu3uDUZPY3UxEpkhv5dlDXhR4xjNI0b8rxBEqCbwXWsoGGk7O7AphrBRnsR2HI/5h/3OTmsJY+DWx4DyLAnTRjCk3g3lz9+LgsyXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749524596; c=relaxed/simple;
	bh=3dKk6SPl34eNEsYEw8G4Gkc3qv2CKIVl9VFP4C0w/Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bVFam0uXi3wsAIiebWrnHbjuk34lZm6yHGy6N6WqURZzXxgkPXCmqQBmfed/AslkjeMHfHiNHCuvEQi+bgJPTPhGvGYqLmoz6QKNtpv+L6p0reU37l6xQmTWkulS4DHjHcehVXcSI1c5fo6b062bN44Ih/d/CeeaoD6AQKTKqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LSUZJxjg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559JDIXY007352;
	Tue, 10 Jun 2025 03:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ArfNvnxR4/D58nIc1VUnd+S5AAkbAYFa23X9JAICe2Y=; b=LSUZJxjgh7L35jxv
	qSv11Yd70mXhRsrqLwoICVuj1VyDHxzzadpJgwBOYy2rRetP0FeOO0xB4Gcx08IT
	hH7W7qTVwxTSLEE72NS0tmGhnAOHEePRZWRxGZ9Iys4pNSn6oK+/j9ZaTJhTz2rZ
	4I+HnHdsnxBzrmDa6TkfTE7cjjaADcv6oCsXf8OMhDsRZn2Z4U5WkNSPJEcFbpz8
	4IhJ2V2FkGVkKktsN4g3iXX80laWFZ6VWcbpk3Re8QGwtaUvWCmMb0qfViiNxBMK
	9rQ+ZFb5yIbxaVY4nbZCNfFAA5oCsnYNmYdOKXwab0mlo8j6/WsBO28d5Oa+JrYY
	d3wHXg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474eqcfrhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:03:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55A3310h026094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:03:01 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 9 Jun 2025
 20:02:59 -0700
Message-ID: <de532ef3-6f24-40dd-9a92-6f2e6c3b4ff5@quicinc.com>
Date: Tue, 10 Jun 2025 11:02:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/2] wifi: ath11k: support usercase-specific
 firmware overrides
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, <jjohnson@kernel.org>,
        <johannes@sipsolutions.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
 <20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDAyMiBTYWx0ZWRfX9+ysD0Ci7QQa
 6h6vgZsUOMgnSNbYlreF5c2GZGSevioggPg1QlNQkh8IO4bIr2GC2XKwYbnHjvCg998jIDKB8i/
 gcknhQqLqLhMYdvsGXs5k0prfec4EB8EQnD2Yv6kXONabzl4cR8KMFk4zICvnPtRt7EraoFrqgA
 J/CrtGk4u/mF2BDtJ1RdtbfuEZ2SswxyBqOTuSpL0KtO+q31MQpf2gWgLQlynrvWMgmrj/drIk0
 RqOhC7f50CY9k1QzgcoZQvFV8hrVdHDXTIgDYqScApfSLcKRKqlTV/2acmR2SgFVgS6dyEot/xQ
 l2/5iBqec0lfvvGZQhzUeCh4Y0n7eIEG7aCi9r4Q6DUORZwUWuE47yqQBX1iwowNYD/4YZtO4Tw
 8gA/nCzDV7bzE/ibi4q4E7wDE8Vy7XZdD+bRXxaWT0sRM7K1LMRtVHejoLsmTzJuSy58+4Bb
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=6847a066 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=J7dR-uFlIZdojmd15SYA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: fRCW05m_DI0nbHLbYFxvVi1U4fBhkiW3
X-Proofpoint-ORIG-GUID: fRCW05m_DI0nbHLbYFxvVi1U4fBhkiW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_01,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=824
 bulkscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100022



On 5/22/2025 9:34 AM, Miaoqing Pan wrote:
> Introduce 'firmware-name' property to allow end-users and/or integrators to
> decide which usecase-specific firmware to run on the WCN6855. This is
> necessary due to resource limitations such as memory capacity and CPU
> capability, or performance and power optimization for different application
> scenarios.
> 
> Currently, there are two firmwares, both files can be executed
> interchangeably.
> For example:
> 
> - ath11k/WCN6855/hw2.0/amss.bin,
>   ath11k/WCN6855/hw2.0/m3.bin
>   ath11k/WCN6855/hw2.0/board-2.bin
> 
> - ath11k/WCN6855/hw2.0/nfa765/amss.bin,
>   ath11k/WCN6855/hw2.0/nfa765/m3.bin
>   ath11k/WCN6855/hw2.0/board-2.bin
> 
> The former is the default firmware, suitable for most WiFi 6 STA functions.
> The latter adds support for commercial-quality SAP and optimizes power
> consumption for IoT applications. And both use the same BDF/regdb data
> within the main board-2.bin.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04479-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 339d4fca1ed5..67b3b6d898fa 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -17,6 +17,7 @@
>  #include <linux/average.h>
>  #include <linux/firmware.h>
>  #include <linux/suspend.h>
> +#include <linux/of.h>
>  
>  #include "qmi.h"
>  #include "htc.h"
> @@ -1320,8 +1321,16 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
>  						    const char *filename,
>  						    void *buf, size_t buf_len)
>  {
> -	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
> -		 ab->hw_params.fw.dir, filename);
> +	const char *fw_name = NULL;
> +
> +	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
> +
> +	if (fw_name && strncmp(filename, "board", 5))
> +		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
> +			 ab->hw_params.fw.dir, fw_name, filename);
> +	else
> +		snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
> +			 ab->hw_params.fw.dir, filename);
>  }
>  
>  static inline const char *ath11k_bus_str(enum ath11k_bus bus)

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>



