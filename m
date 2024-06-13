Return-Path: <linux-wireless+bounces-8963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB01290649D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 09:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D209E1C22B7A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F14137C54;
	Thu, 13 Jun 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ia4AMn5U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14393136E1D;
	Thu, 13 Jun 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262662; cv=none; b=Mece4nW/cuhoX4NwvjFrYU8WbP8e2qvTo9w8H2woUJHmXZT69gGvNOANkvJshBWzRnRh4on6nmS7NDO5iRlKifviNc6KMm9pJO8C+jVwdu8sin63cZMSU5AGeW2yjqOxHVF0wH6c8c81LRo/O8YkfFpEhpenuvtAamauM9OA0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262662; c=relaxed/simple;
	bh=mF6O6fpqJsqWtt0TfGDQLA5vIW9BMvsCJpaQv9m8wRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DpeSYADueeTVzxV45GeAUwZg0TuKIBd/nIEaB43hE8s54N2Lbt7XerjyybxV7IHUSaNm1EEmxY6QZIp0qgw9DgzcsipAOskCpSc2ngtRW6JRFyNVbvMuVSadnVHBbtbMYy9PXCejCbNfwPXM/TPaSOxI98+QULvmav+WrUVndjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ia4AMn5U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKnCRL018894;
	Thu, 13 Jun 2024 07:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TzckQVSXwdwfivX07di5KmgXJ9vMucG291Br1p8IWfU=; b=Ia4AMn5UO169ZRPv
	4pP1ZnWYPN3ZjCsGIpTAyPz61jBKEpL36PDJh2sEkfcNbg//Her8YYwmHsZxsLti
	3W7hibrtU25fgdfLAiiFVmAGf4aJpu82+hxP4Qi1Io9Qzt5fSrXUk5IZfJD2jlJI
	fqEgEZ52AgncyqC2mJnvX6bDXTAkHwiiiUXGwahc5AjSLhlRyxsEkL1fKg4IGc3t
	irYT4PdiIky0riFKCECeaFmYLhYFJppz50V/q4aH30fb/ujiOcZecWjsaJW0C9LO
	qE/Iv5tUMbEaw4BcIrJm1TjskkHL0JyrVHWjcFeUF+eXysS5W4C1dxCeBhPoPnV4
	PYPDgQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqbfq9ugf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 07:10:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D7AdjQ017566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 07:10:39 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 00:10:37 -0700
Message-ID: <d49fcc32-bfa8-41d2-8666-af6256b7b4b4@quicinc.com>
Date: Thu, 13 Jun 2024 15:10:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi: Regression after migrating to 6.6.32
To: Fabio Estevam <festevam@gmail.com>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: <miriam.rachel.korenblit@intel.com>, <kvalo@kernel.org>,
        Jakub Kicinski
	<kuba@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAOMZO5A7+nxACoBPY0k8cOpVQByZtEV_N1489MK5wETHF_RXWA@mail.gmail.com>
 <3fbb5317d9ff33ef1b60ca8297537335ce86a79d.camel@sipsolutions.net>
 <CAOMZO5Aufe7zAE7TFVprvRreamYd9=RHjybjaEz2O9WaPksV=Q@mail.gmail.com>
 <95163ee547da95964c16f87a38d3326ae4da3253.camel@sipsolutions.net>
 <CAOMZO5CYDsh70u3To7HYXVki_MzzhFyCCHkigt_Es7o_+XG3oA@mail.gmail.com>
 <7a8e220d77d7e30a0cfaf984404ef2f57eaa785f.camel@sipsolutions.net>
 <CAOMZO5BktgtaSPzCf3WOOnkD2n+fj3FeQEfHeT7CYFL+tCHeaw@mail.gmail.com>
 <fb60b7f5bcf5ba47be54398225075a5bfab7c141.camel@sipsolutions.net>
 <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAOMZO5CMX_juW4-t6CSd2xdzXkFfBiamuSTjsTB80Ly_TUsxRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FNI5ojyu0JtRNzAARz44ct0BTpeYCF6P
X-Proofpoint-ORIG-GUID: FNI5ojyu0JtRNzAARz44ct0BTpeYCF6P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=732 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406130049



On 6/13/2024 3:15 AM, Fabio Estevam wrote:
> Hi Johannes,
> 
> On Wed, Jun 12, 2024 at 4:10 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> 
>> Strange. Is there an IOMMU involved on this platform?
> 
> IOMMU isn't available on i.MX8M as far as I know.
If IOMMU not present, likely the buffer is mapped by SWIOTLB. The iova 4215433216, aka 0xFB426800, is 2K aligned, which also supports such guessing. See definition of IO_TLB_SIZE.

> 
> Interestingly, such a warning does not happen with the 5.10 kernel.
> 
> I only noticed it yesterday, after migrating to 6.6.32.
> 
> Thanks
> 

