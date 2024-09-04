Return-Path: <linux-wireless+bounces-12456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C6E96B2BE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA44285588
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711CC130ADA;
	Wed,  4 Sep 2024 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vo2HuwOO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60183146019
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434610; cv=none; b=hJHGBxYfFMODNdOcENhGUHIk4fWvFiA4NmPBPEqKmM2XmyYL3jtBOyJBDlLUwYG8puLJzCXptZNQX4jHVVM7LXw4RppJTvg7iZt02iyIL3vhJh5EvZW4Z2p/4hoPeAIXIvX02WhXYrmGfJipmlyjfnbDuro20UC0jECUPh918pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434610; c=relaxed/simple;
	bh=BnQQqdjlIulzDpVd2SLPEV4qOZI0BE6IYIK2MBdmh/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RgiH7rC3tvNfaMgMnoOP7tK1MbPBZ00+dgb9CdbhcCL2i4kPQdzk1my/rqAX9UD8pstkZww3InDQhqQT+0OOPMhYQ0chPZeEnbAScZy5PoIrOw7KPA0AewQQ+NaENWXKEDSmzdThoc5+UBh9HsZhlFqpms9DuoNsbqfdl3eqooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vo2HuwOO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483L0deo026048;
	Wed, 4 Sep 2024 07:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuox1+60c1BB5UiUAJWGfFhuvc1YXy5uYwQHCjmJhUI=; b=Vo2HuwOOPVrDGPqh
	Kefe5Gj+IKeHh6QBYxFUhfIibklfdTTmG5GJBTuJxcfGmVynR9OqNCQ8aa143c9G
	0/W6+bpujacLjwxqCuf0vUcz8KO7tZZHuaDCmIWKaJw6faqmL1Oy/BCLguvbPz2x
	eqywln7ybEOq25VEpNFDWN67Qaa8rxQodwK52monfsdhLZ8IiFNtIgLa31Pvqaz9
	bGpVT3pWH10P5z4hjdRQjI/cnOFwXt3OdDQQGTeIlWLSF9P6gqZNUZTzGzFb0Qs1
	J+IjPhCkChMene6GwzRogw9InyCIGgLD+TUz4c0c69CgR6fqz2icVCGTrIStSWYv
	GH3oBg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bud2sxwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 07:23:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4847NDNv030834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 07:23:13 GMT
Received: from [10.216.28.224] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 00:23:12 -0700
Message-ID: <cecf0e32-b84c-423e-89c3-61eab9f1928a@quicinc.com>
Date: Wed, 4 Sep 2024 12:53:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Krzysztof Kozlowski <krzk@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240814094323.3927603-1-quic_rajkbhag@quicinc.com>
 <20240814094323.3927603-2-quic_rajkbhag@quicinc.com>
 <6a740dee-464a-4a10-9c25-ee6f0d22b279@kernel.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <6a740dee-464a-4a10-9c25-ee6f0d22b279@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3oCSoZZCKTntLiPE3hUTi7wqpnkK1EOE
X-Proofpoint-ORIG-GUID: 3oCSoZZCKTntLiPE3hUTi7wqpnkK1EOE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040055

On 8/16/2024 11:12 AM, Krzysztof Kozlowski wrote:
> On 14/08/2024 11:43, Raj Kumar Bhagat wrote:
>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>> device.
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> 
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 
Thanks for the information. In next version we will use the script
"scripts/get_maintainers.pl" to get the list.

>> ---
>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 325 ++++++++++++++++++
>>  1 file changed, 325 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> new file mode 100644
>> index 000000000000..8cecc50b6341
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
>> @@ -0,0 +1,325 @@
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
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  interrupts:
>> +    minItems: 32
>> +    maxItems: 56
>> +
>> +  interrupt-names:
>> +    minItems: 32
>> +    maxItems: 56
>> +
>> +  memory-region:
>> +    minItems: 1
>> +    description:
>> +      phandle to a node describing reserved memory (System RAM memory)
>> +      used by ath12k firmware (see bindings/reserved-memory/reserved-memory.txt)
>> +
>> +  qcom,bdf-addr:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      System RAM memory address reserved for board data.
>> +
>> +  qcom,board_id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Board id value, it identifies the variant of ath12k WiFi device.
> 
> Please do not upstream whatever you have in your vendor tree... You even
> copied its style! There is no such property in upstream.
> 
> NAK, you are duplicating compatibles.
> 
> 

qcom,board_id is a new parameter introduced to distinguish between different variants
of ath12k devices that share the same compatible value. This differentiation is crucial
as these variants have different qcom,board_id values (with the same compatible) based
on WiFi frequency bands capability. For example, 2 GHz, 5 GHz, 6 GHz, or multi-band
variants of ath12k devices have different qcom,board_id values.

In the next version, I will include the above information in the qcom,board_id
description.

> 
>> +
>> +  qcom,rproc:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      DT entry of a WCSS node. WCSS node is the child node of q6 remoteproc driver.
>> +      (see bindings/remoteproc/qcom,multipd-pil.yaml)
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - memory-region
>> +  - qcom,board_id
>> +  - qcom,rproc
>> +
>> +additionalProperties: false
>> +
>> +allOf:
>> +  - $ref: ieee80211.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq5332-wifi
> 
> Why? You have only one variant, why this if?

sure, in next version we will remove the if handing as we are currently
adding only one compatible.

>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: gcc_xo_clk used for copy engine
>> +            - description: gcc_im_sleep_clk used for q6.
>> +
>> +        clock-names:
>> +          items:
>> +            - const: gcc_xo_clk
>> +            - const: gcc_im_sleep_clk
>> +
>> +        interrupts:
>> +          items:
>> +            - description: misc-pulse1 interrupt events
>> +            - description: misc-latch interrupt events
>> +            - description: sw exception interrupt events
>> +            - description: interrupt event for ring CE0
>> +            - description: interrupt event for ring CE1
>> +            - description: interrupt event for ring CE2
>> +            - description: interrupt event for ring CE3
>> +            - description: interrupt event for ring CE4
>> +            - description: interrupt event for ring CE5
>> +            - description: interrupt event for ring CE6
>> +            - description: interrupt event for ring CE7
>> +            - description: interrupt event for ring CE8
>> +            - description: interrupt event for ring CE9
>> +            - description: interrupt event for ring CE10
>> +            - description: interrupt event for ring CE11
>> +            - description: interrupt event for ring host2wbm-desc-feed
>> +            - description: interrupt event for ring host2reo-re-injection
>> +            - description: interrupt event for ring host2reo-command
>> +            - description: interrupt event for ring host2rxdma-monitor-ring1
>> +            - description: interrupt event for ring reo2ost-exception
>> +            - description: interrupt event for ring wbm2host-rx-release
>> +            - description: interrupt event for ring reo2host-status
>> +            - description: interrupt event for ring reo2host-destination-ring4
>> +            - description: interrupt event for ring reo2host-destination-ring3
>> +            - description: interrupt event for ring reo2host-destination-ring2
>> +            - description: interrupt event for ring reo2host-destination-ring1
>> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac3
>> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac2
>> +            - description: interrupt event for ring rxdma2host-monitor-destination-mac1
>> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
>> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
>> +            - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
>> +            - description: interrupt event for ring host2tcl-input-ring4
>> +            - description: interrupt event for ring host2tcl-input-ring3
>> +            - description: interrupt event for ring host2tcl-input-ring2
>> +            - description: interrupt event for ring host2tcl-input-ring1
>> +            - description: interrupt event for ring wbm2host-tx-completions-ring4
>> +            - description: interrupt event for ring wbm2host-tx-completions-ring3
>> +            - description: interrupt event for ring wbm2host-tx-completions-ring2
>> +            - description: interrupt event for ring wbm2host-tx-completions-ring1
>> +            - description: interrupt event for ring host2tx-monitor-ring1
>> +            - description: interrupt event for ring txmon2host-monitor-destination-mac3
>> +            - description: interrupt event for ring txmon2host-monitor-destination-mac2
>> +            - description: interrupt event for ring txmon2host-monitor-destination-mac1
>> +            - description: interrupt event for umac_reset
>> +        interrupt-names:
>> +          items:
>> +            - const: misc-pulse1
>> +            - const: misc-latch
>> +            - const: sw-exception
>> +            - const: ce0
>> +            - const: ce1
>> +            - const: ce2
>> +            - const: ce3
>> +            - const: ce4
>> +            - const: ce5
>> +            - const: ce6
>> +            - const: ce7
>> +            - const: ce8
>> +            - const: ce9
>> +            - const: ce10
>> +            - const: ce11
>> +            - const: host2wbm-desc-feed
>> +            - const: host2reo-re-injection
>> +            - const: host2reo-command
>> +            - const: host2rxdma-monitor-ring1
>> +            - const: reo2ost-exception
>> +            - const: wbm2host-rx-release
>> +            - const: reo2host-status
>> +            - const: reo2host-destination-ring4
>> +            - const: reo2host-destination-ring3
>> +            - const: reo2host-destination-ring2
>> +            - const: reo2host-destination-ring1
>> +            - const: rxdma2host-monitor-destination-mac3
>> +            - const: rxdma2host-monitor-destination-mac2
>> +            - const: rxdma2host-monitor-destination-mac1
>> +            - const: host2rxdma-host-buf-ring-mac3
>> +            - const: host2rxdma-host-buf-ring-mac2
>> +            - const: host2rxdma-host-buf-ring-mac1
>> +            - const: host2tcl-input-ring4
>> +            - const: host2tcl-input-ring3
>> +            - const: host2tcl-input-ring2
>> +            - const: host2tcl-input-ring1
>> +            - const: wbm2host-tx-completions-ring4
>> +            - const: wbm2host-tx-completions-ring3
>> +            - const: wbm2host-tx-completions-ring2
>> +            - const: wbm2host-tx-completions-ring1
>> +            - const: host2tx-monitor-ring1
>> +            - const: txmon2host-monitor-destination-mac3
>> +            - const: txmon2host-monitor-destination-mac2
>> +            - const: txmon2host-monitor-destination-mac1
>> +            - const: umac_reset
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,ipq5332-wifi
>> +    then:
>> +      required:
>> +        - clocks
>> +        - clock-names
>> +        - interrupts
>> +        - interrupt-names
>> +        - qcom,bdf-addr
>> +
>> +examples:
>> +  - |
>> +
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
>> +
>> +    reserved-memory {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        q6_region: wcnss@4a900000 {
>> +            no-map;
>> +            reg = <0x0 0x4a900000 0x0 0x02300000>;
>> +        };
>> +
>> +        m3_dump: m3_dump@4cc00000 {
>> +            no-map;
>> +            reg = <0x0 0x4CC00000 0x0 0x100000>;
>> +        };
>> +    };
> 
> Drop
> 
Sure, will drop reserved-memory for example.

>> +
>> +    wifi0: wifi@c0000000 {
>> +        compatible = "qcom,ipq5332-wifi";
>> +        reg = <0xc000000 0x1000000>;
>> +        clocks = <&gcc GCC_XO_CLK>,
>> +                 <&gcc GCC_IM_SLEEP_CLK>;
>> +        clock-names = "gcc_xo_clk",
>> +                      "gcc_im_sleep_clk";
>> +        interrupts = <GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 422 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 425 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 427 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 428 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 429 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 430 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 491 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 493 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 454 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 453 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 484 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 507 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 500 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 499 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 498 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 450 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 447 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 482 IRQ_TYPE_EDGE_RISING>,
>> +                     <GIC_SPI 419 IRQ_TYPE_EDGE_RISING>;
>> +        interrupt-names = "misc-pulse1",
>> +                          "misc-latch",
>> +                          "sw-exception",
>> +                          "ce0",
>> +                          "ce1",
>> +                          "ce2",
>> +                          "ce3",
>> +                          "ce4",
>> +                          "ce5",
>> +                          "ce6",
>> +                          "ce7",
>> +                          "ce8",
>> +                          "ce9",
>> +                          "ce10",
>> +                          "ce11",
>> +                          "host2wbm-desc-feed",
>> +                          "host2reo-re-injection",
>> +                          "host2reo-command",
>> +                          "host2rxdma-monitor-ring1",
>> +                          "reo2ost-exception",
>> +                          "wbm2host-rx-release",
>> +                          "reo2host-status",
>> +                          "reo2host-destination-ring4",
>> +                          "reo2host-destination-ring3",
>> +                          "reo2host-destination-ring2",
>> +                          "reo2host-destination-ring1",
>> +                          "rxdma2host-monitor-destination-mac3",
>> +                          "rxdma2host-monitor-destination-mac2",
>> +                          "rxdma2host-monitor-destination-mac1",
>> +                          "host2rxdma-host-buf-ring-mac3",
>> +                          "host2rxdma-host-buf-ring-mac2",
>> +                          "host2rxdma-host-buf-ring-mac1",
>> +                          "host2tcl-input-ring4",
>> +                          "host2tcl-input-ring3",
>> +                          "host2tcl-input-ring2",
>> +                          "host2tcl-input-ring1",
>> +                          "wbm2host-tx-completions-ring4",
>> +                          "wbm2host-tx-completions-ring3",
>> +                          "wbm2host-tx-completions-ring2",
>> +                          "wbm2host-tx-completions-ring1",
>> +                          "host2tx-monitor-ring1",
>> +                          "txmon2host-monitor-destination-mac3",
>> +                          "txmon2host-monitor-destination-mac2",
>> +                          "txmon2host-monitor-destination-mac1",
>> +                          "umac_reset";
>> +
>> +        memory-region = <&q6_region>;
>> +        qcom,bdf-addr = <0x4B500000>;
>> +        qcom,board_id = <0x12>;
>> +        qcom,rproc = <&q6_wcss_pd1>;
>> +        status = "okay";
> 
> Drop
> 
sure will drop the status.

>> +    };
> 
> Best regards,
> Krzysztof
> 
> 


