Return-Path: <linux-wireless+bounces-12618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD99896FE60
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 01:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA96284DE5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149915AAC1;
	Fri,  6 Sep 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gPjr+MT7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FE1B85DB;
	Fri,  6 Sep 2024 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725664720; cv=none; b=UB/7PbBWP7uiS3opq56CSa8L4FEGqAqnmtPrJPprp/F0L0PnK9+XUC6cWRe4zMPaeXDYeV/0YE9hoKmLKF7/OPUCNdm7irExi9wjVRw1aasAg43F7UoQufG/A9Sd50C0o/QGleiTrpRqQr4/qg2SP6yqA/0NThbBaURA/270l2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725664720; c=relaxed/simple;
	bh=/HBwAzI28uj/0jAGdZnPKU/RKa4DkvMbbv4IGx4S7z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ne2cl9ZfPSb7B2mJWQ9pDgGC60k+vBnG7pRPCjUEwxwzEhMl/Y4KKfY2xOCcGYv++kfTCrcjmwn31Qot5WizQvpcHVcekm8GmGIsRmiOy4axvnQC6grdTcuT2JJkfjPC4lvQE/TAosJJw8Na8L2AcIJ5U4sptytmWfg4o45ItTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gPjr+MT7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486La20Q021851;
	Fri, 6 Sep 2024 23:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8hUy3HkO73n8a8kkpNa8JB3SE4UQn54cODui1RapG3E=; b=gPjr+MT7wInQfINa
	RTmVGsvD5ouyNMbUcb//XbEFNDNR5h6d/CWaTAj04NEoY5Lb0n71/Sf0McS/Lcs9
	WogDGji8t1UNn1CqfjETXQ2GXu+qmhGqccJTAaFZbhFlEBO8XI/RA25uP4FaaeDl
	1SKgo65aCUZpgAVw3fRYo9R6MgHyCDgRaHs0iY03cNYh2w1DkkXqXXltFR5OPIrX
	dPoPhXVHMS/B/VPsXJjAJJF94zb/zoDBTNz9uZ4sazWl3KCAvXe286t8Ll2Qhln0
	SirwxnbuluhuuabVeymAlYxmmsvn8EsAPCRuT165kpRGBcF9miv/iypqjSNhM8LX
	GOLf8g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhws3k06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 23:17:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 486NHXB8019247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 23:17:34 GMT
Received: from [10.111.181.108] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 16:17:32 -0700
Message-ID: <6f3f79f2-5755-4286-98f6-9950e7e994c8@quicinc.com>
Date: Fri, 6 Sep 2024 16:17:31 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] net: Convert using
 devm_clk_get_enabled()/devm_clk_get_optional_enabled()
To: Li Zetao <lizetao1@huawei.com>, <florian.fainelli@broadcom.com>,
        <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <wens@csie.org>, <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <heiko@sntech.de>, <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <hauke@hauke-m.de>, <alexandre.torgue@foss.st.com>,
        <joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
        <wellslutw@gmail.com>, <radhey.shyam.pandey@amd.com>,
        <michal.simek@amd.com>, <ajay.kathat@microchip.com>,
        <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <jacky_chou@aspeedtech.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-wireless@vger.kernel.org>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240831021334.1907921-1-lizetao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U38JrxGFfwZBLXAiBMSQPWd5WdbUh_11
X-Proofpoint-GUID: U38JrxGFfwZBLXAiBMSQPWd5WdbUh_11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_08,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=849 adultscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060173

On 8/30/2024 7:13 PM, Li Zetao wrote:
> There are many examples[1][2] of clk resource leakage in LTS. The
> reason is that developers need to maintain the allocation and release
> of clk resources themselves, but this will increase the burden on
> developers. Using the API related to devm_clk_get_*_enable ensures
> that the life cycle of clk is consistent with that of the device,
> reducing the risk of unreleased resources like clk.
> 
> Several other developers are also working on converting to more
> secure interfaces, and this patch set is in principle the same as
> theirs.

...

>  drivers/net/dsa/bcm_sf2.c                     | 28 ++----
>  drivers/net/ethernet/allwinner/sun4i-emac.c   | 13 +--
>  drivers/net/ethernet/arc/emac_rockchip.c      | 34 ++-----
>  drivers/net/ethernet/ethoc.c                  | 18 ++--
>  drivers/net/ethernet/faraday/ftgmac100.c      | 27 ++---
>  drivers/net/ethernet/hisilicon/hisi_femac.c   | 17 +---
>  drivers/net/ethernet/lantiq_xrx200.c          | 17 +---
>  .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 98 ++++---------------
>  drivers/net/ethernet/sunplus/spl2sw_driver.c  | 18 +---
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 15 +--
>  .../net/wireless/microchip/wilc1000/sdio.c    | 10 +-
>  drivers/net/wireless/microchip/wilc1000/spi.c |  5 +-

note the wifi driver changes go through the wireless tree and not the net tree
so those should be split out separately


