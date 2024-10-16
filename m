Return-Path: <linux-wireless+bounces-14058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FB9A0472
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC01F1F264FA
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 08:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8C1FDF90;
	Wed, 16 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nOJdGG+h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229C31FCC74;
	Wed, 16 Oct 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067879; cv=none; b=GQ9bUK7tytib2//grstgZWnJYvgTHqhLxUkGz/WMJFXX8CupzZrI9g1O2kMlZ2j/LBvpE2JAwB1HlNE7gYYmG6gReO5W1ZKWk7nd7EM9ANlKEn29Zs/X5qu4GTdPgliYBMiRINaAn2DJYarFQTRp2pjONGn05ORWgYiaU4U0TNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067879; c=relaxed/simple;
	bh=7ep2j3luir+e1rPvWTOnMNgP+sZjJojHmfq96ukfmwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qS5eK/VD7z7Cr4kLS/h0bJM3wo8PsACJDI55TIP4IHoy9/T4tU1x+9k+zSTt3KlIQE0nLhQIKXinOYZ/yHjj8giLgtO4mjCv/qEjvXk46jNxfTL5Zx3lK67qsJ+dFaf6taaxcJWMlmRXoXv3VYLgbr6vWUoqM3+P/wiK1Kse7Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nOJdGG+h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G8Q4GE020139;
	Wed, 16 Oct 2024 08:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xf6D7uuyfBIi7Eld10jzGs6cAHzqmXBpJ990H0YSMeY=; b=nOJdGG+hJYtqdh61
	81EVUHR5RkQ5Esdqa6mK1dQCe2BNojge/wnYZ3EjBalP5rabbNDuYEbcVBiuIWMF
	5R5Yclf6oHATg07AEgmmEzEjOlIvjxB/ThporYksBcxhWR3zTDzJ1lUVFPXzOgvS
	erNfd8+/jWTPyRgZFbr/Ck1dUyvllHnaWGwOX9V18ZheaeNYry62WoYXOLN0udH4
	gDVo+jFUZrtlVXwnidl4AmRc04kBCzKc8xElD0jFLfMb3rxsQQyfP3Fr0RdwRHNJ
	kMj/YKFvOI0E5chPBr468OGE721ibqxgon4FTmFYjwiHsCGaxtPLNZ2h4TdLiz8x
	SZThQQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429m0fbybr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 08:37:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49G8bm6X020366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 08:37:48 GMT
Received: from [10.50.26.161] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 01:37:44 -0700
Message-ID: <708e9d22-0513-4646-aeac-2187c052e208@quicinc.com>
Date: Wed, 16 Oct 2024 14:07:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-2-quic_rajkbhag@quicinc.com>
 <h4xel7xh3vyljxi7jn2afqasfmbsiqjtgpvqthrviovode6cxt@ey5nnzi4dwtv>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <h4xel7xh3vyljxi7jn2afqasfmbsiqjtgpvqthrviovode6cxt@ey5nnzi4dwtv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4mUBZ8gI4fNnlmLA_oTqlRQi0QgD8ELO
X-Proofpoint-ORIG-GUID: 4mUBZ8gI4fNnlmLA_oTqlRQi0QgD8ELO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160055

On 10/16/2024 12:32 PM, Krzysztof Kozlowski wrote:
> On Tue, Oct 15, 2024 at 11:56:16PM +0530, Raj Kumar Bhagat wrote:
>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>> device.
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
> 
> That's a v2, what changed?
> 
> Did you ignore entire review? Limited review follows because of that (I
> am not going to do the same work twice).
> 

Review comments in version 1 are addressed.

Per-patch version log is not added here. But we have consolidated version log
in the cover-letter. Will include per-patch version log from next version.

Below are the version log for v2:
- "qcom,board_id" property is dropped. This is not the direct dependency for Ath12k
  AHB support, hence it can be taken up separately.
- "qcom,bdf-addr" property is dropped in device-tree and moved to ath12k driver.
- Currently we have only one compatible enum (qcom,ipq5332-wifi), hence conditional
  if() check for defining the binding is removed.
- "reserved-memory" node is dropped from example DTS.
- "status" property is dropped in wifi node of example DTS.

>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 293 ++++++++++++++++++
>>  1 file changed, 293 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> new file mode 100644
>> index 000000000000..54784e396d7e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> @@ -0,0 +1,293 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-ahb.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies ath12k wireless devices (AHB)
>> +
>> +maintainers:
>> +  - Kalle Valo <kvalo@kernel.org>
>> +  - Jeff Johnson <jjohnson@kernel.org>
>> +
>> +description:
>> +  Qualcomm Technologies IEEE 802.11be AHB devices.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,ipq5332-wifi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: XO clock used for copy engine
>> +
>> +  clock-names:
>> +    items:
>> +      - const: gcc_xo_clk
> 
> Drop _clk, drop gcc_. Look how this clock is called *everywhere* else.
> 

Thanks, Based on other bindings example, will rename to "xo"

>> +
>> +  interrupts:
>> +    items:
>> +      - description: Ready interrupt
>> +      - description: Spawn acknowledge interrupt
>> +      - description: Stop acknowledge interrupt
>> +      - description: misc-pulse1 interrupt events
>> +      - description: misc-latch interrupt events
>> +      - description: sw exception interrupt events
>> +      - description: interrupt event for ring CE0
>> +      - description: interrupt event for ring CE1
>> +      - description: interrupt event for ring CE2
>> +      - description: interrupt event for ring CE3
>> +      - description: interrupt event for ring CE4
>> +      - description: interrupt event for ring CE5
>> +      - description: interrupt event for ring CE6
>> +      - description: interrupt event for ring CE7
>> +      - description: interrupt event for ring CE8
>> +      - description: interrupt event for ring CE9
>> +      - description: interrupt event for ring CE10
>> +      - description: interrupt event for ring CE11
>> +      - description: interrupt event for ring host2wbm-desc-feed
>> +      - description: interrupt event for ring host2reo-re-injection
>> +      - description: interrupt event for ring host2reo-command
>> +      - description: interrupt event for ring host2rxdma-monitor-ring1
>> +      - description: interrupt event for ring reo2ost-exception
>> +      - description: interrupt event for ring wbm2host-rx-release
>> +      - description: interrupt event for ring reo2host-status
>> +      - description: interrupt event for ring reo2host-destination-ring4
>> +      - description: interrupt event for ring reo2host-destination-ring3
>> +      - description: interrupt event for ring reo2host-destination-ring2
>> +      - description: interrupt event for ring reo2host-destination-ring1
>> +      - description: interrupt event for ring rxdma2host-monitor-destination-mac3
>> +      - description: interrupt event for ring rxdma2host-monitor-destination-mac2
>> +      - description: interrupt event for ring rxdma2host-monitor-destination-mac1
>> +      - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
>> +      - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
>> +      - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
>> +      - description: interrupt event for ring host2tcl-input-ring4
>> +      - description: interrupt event for ring host2tcl-input-ring3
>> +      - description: interrupt event for ring host2tcl-input-ring2
>> +      - description: interrupt event for ring host2tcl-input-ring1
>> +      - description: interrupt event for ring wbm2host-tx-completions-ring4
>> +      - description: interrupt event for ring wbm2host-tx-completions-ring3
>> +      - description: interrupt event for ring wbm2host-tx-completions-ring2
>> +      - description: interrupt event for ring wbm2host-tx-completions-ring1
>> +      - description: interrupt event for ring host2tx-monitor-ring1
>> +      - description: interrupt event for ring txmon2host-monitor-destination-mac3
>> +      - description: interrupt event for ring txmon2host-monitor-destination-mac2
>> +      - description: interrupt event for ring txmon2host-monitor-destination-mac1
>> +      - description: interrupt event for umac_reset
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: ready
>> +      - const: spawn
>> +      - const: stop-ack
>> +      - const: misc-pulse1
>> +      - const: misc-latch
>> +      - const: sw-exception
>> +      - const: ce0
>> +      - const: ce1
>> +      - const: ce2
>> +      - const: ce3
>> +      - const: ce4
>> +      - const: ce5
>> +      - const: ce6
>> +      - const: ce7
>> +      - const: ce8
>> +      - const: ce9
>> +      - const: ce10
>> +      - const: ce11
>> +      - const: host2wbm-desc-feed
>> +      - const: host2reo-re-injection
>> +      - const: host2reo-command
>> +      - const: host2rxdma-monitor-ring1
>> +      - const: reo2ost-exception
>> +      - const: wbm2host-rx-release
>> +      - const: reo2host-status
>> +      - const: reo2host-destination-ring4
>> +      - const: reo2host-destination-ring3
>> +      - const: reo2host-destination-ring2
>> +      - const: reo2host-destination-ring1
>> +      - const: rxdma2host-monitor-destination-mac3
>> +      - const: rxdma2host-monitor-destination-mac2
>> +      - const: rxdma2host-monitor-destination-mac1
>> +      - const: host2rxdma-host-buf-ring-mac3
>> +      - const: host2rxdma-host-buf-ring-mac2
>> +      - const: host2rxdma-host-buf-ring-mac1
>> +      - const: host2tcl-input-ring4
>> +      - const: host2tcl-input-ring3
>> +      - const: host2tcl-input-ring2
>> +      - const: host2tcl-input-ring1
>> +      - const: wbm2host-tx-completions-ring4
>> +      - const: wbm2host-tx-completions-ring3
>> +      - const: wbm2host-tx-completions-ring2
>> +      - const: wbm2host-tx-completions-ring1
>> +      - const: host2tx-monitor-ring1
>> +      - const: txmon2host-monitor-destination-mac3
>> +      - const: txmon2host-monitor-destination-mac2
>> +      - const: txmon2host-monitor-destination-mac1
>> +      - const: umac_reset
>> +
>> +  memory-region:
>> +    minItems: 1
> 
> upper constraint
> 
>> +    description:
>> +      phandle to a node describing reserved memory (System RAM memory)
>> +      used by ath12k firmware (see bindings/reserved-memory/reserved-memory.txt)
>> +
>> +  qcom,rproc:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      DT entry of a WCSS node. WCSS node is the child node of q6 remoteproc driver.
>> +      (see bindings/remoteproc/qcom,multipd-pil.yaml)
> 
> DT nodes are not children of drivers. But other DT nodes. Explain why
> this phandle is needed, what is it for.
> 
> To me it looks like you incorrectly organized your nodes.
> 

This phandle is required by wifi driver (ath12k) to retrieve the correct remote processor
(rproc_get_by_phandle()). Ath12k driver needs this rproc to interact with the remote
processor (example: booting-up remote processor).

In next version, will correct the description based on existing bindings (qcom,ath11k.yaml).

>> +
>> +  qcom,smem-states:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    description: States used by the AP to signal the remote processor
>> +    items:
>> +      - description: Shutdown WCSS pd
>> +      - description: Stop WCSS pd
>> +      - description: Spawn WCSS pd
>> +
>> +  qcom,smem-state-names:
>> +    description:
>> +      Names of the states used by the AP to signal the remote processor
>> +    items:
>> +      - const: shutdown
>> +      - const: stop
>> +      - const: spawn
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - memory-region
>> +  - qcom,rproc
>> +  - qcom,smem-states
>> +  - qcom,smem-state-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +
> 
> Stray blank line
> 

Will update in next version.

> Best regards,
> Krzysztof
> 


