Return-Path: <linux-wireless+bounces-25305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21960B0277F
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 01:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDBFA411AC
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88E2236F3;
	Fri, 11 Jul 2025 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fQy/grzz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C32223321
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275421; cv=none; b=IlpR2U5VidpAQANhI2EoZCEIFS2OjuwoOG6PLO1ihdsl0Zh8WcMG0rNfVm70T7pgfSQkkSU/FQKKUr/lPKX00q7ZSDbcs7DJIgemfoHKhIk+Ip3owngVtmQqHvFPEHTepZfqNgAXK1idpSEmxUnzjlWmRJcjJa5D9OWb/VCGFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275421; c=relaxed/simple;
	bh=aMkT7VCR7/G5eL1+EN+sboSxvDAd1jJ/UJlcZ65dpqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c4fPfpMPOs4FErj4IyYAhz8jDU/T0fCuYJXIflu4jPcaKUZK9nBPav2ehH6Cy6oGwl1Wm0iKai76pg3cCvmmOeoJxWXhzPSgnt2Lnv8B9bV4e04Ww/Qi0JMqP2jyCs85NAOb8LNtaTh/E1UYCs7/qHkSCOFholYzlaWqKV6CuoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fQy/grzz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAreQI017350
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 23:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iJaNlSK/GbStS7lb9/17BUr8ds+mo5PWyFhZUdAGzHU=; b=fQy/grzz9xiKmQcY
	a9nS7NT6LgbLz1F96MqwoPoiXvRywypXDx6Sf08cSwryd9uFUVSiYqrOewsHCQ6K
	ZTYKYsQjPHxnBbsnvU2S3LSF9TADqJmEn0byQFJZkdELEI5dbfSpKsFRvr773BEh
	nhtbO+1wzVPcUyf3bkj0rIxAaFy0ra0lNI6u1u988q4kH/DEWPGZy95Vw6GlwYaE
	GbNeMh9C0hOz41mTHqQPMHBeRm8byif+HdRWmxpbx8XOYFgV4ZRLWLjMecQG1CAr
	xUW/C5Dicr/7KlfGcn9lxibMFkT1V13Wt5QPZoG1dAASuem8fVd1/DzwkLSHO6xp
	6+5ajQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smapa3g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 23:10:18 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so1917309a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 16:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752275416; x=1752880216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJaNlSK/GbStS7lb9/17BUr8ds+mo5PWyFhZUdAGzHU=;
        b=JNKuIOtWl9PhM29wzW7lpRIsFy+ndZCWdqt8bYJ3hem7BNfX+gVGx4lYQceTO0fSI3
         sRmKSYNEsWKy5ML093Q0H1MpOJIe5ME4BQPp4hHdW/8m75vfX6rDKjbdnsu4O24fFg7q
         eZht8njX1Ns7+/1KtIV6g0gzMxTz6amyqtUi6b6iVqOcxZdI2QXGn1OVe0UOJ3huIN4c
         O4MgDVcM5YaAzfQcvp78FD5+WAa1BmBCKuCkqfy1zIQzG/3diEzk7/HjLZuHNdbgf7O/
         s5e9NWseWma2VAMxHsZowq0cGzIh0xjxVeWEJjwTx9S2MGIDnfJBpELvr5vmFB7KEfmI
         RlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg791hSGadwwVkL4CoCOvY4ilGu0BXRmdPdlTqqLvnLKGXIsSmwn7Dp1e8/7yYM41D4/L2vr7kWsgGwSHwAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbLUtLP0hQT68RbHgMATrnbEqLvx3CcWtjchbzOBpA2Oz0jc9
	mqk6gj7gXbKpJHEdtLI4FfPfj3S5heX9KGZO+5iEEdZRjRQjUTKG2JVaMH0v04w6wC3u+uTbInX
	gAqc7VXo1xY4a0RdjE58cBVx7XbC33vlow8MaLgvqCySywSZ0b76/lnK6GcbhuYAwJpc8yw==
X-Gm-Gg: ASbGncu9hydCALy9HRSu2/X9RpMUkQH1cNO8LSFHGXXj0nZ/m3WORNPT2wHl5Ublrrc
	x3lfsUx5SF4jXD67/44mac4XNC1rRrQYLUNMCnLQIe0OEl32rD3xv73whYJGEcOzN+RNwkkn6bs
	f70xJcAVeGAEBaxZ5MGNwNaE1X6CvOzWLlYSkQt1H3/g13xel5V8aEoZ17GqsOeUisPGMAAy+pz
	Xs2nMXVQyFUQIhk0axhU1YzrgtIlPpyNMZ6h1DJ1AoWuXYyRrdXxYyhtBF2S+V2dvNLt4mIvwV/
	iF32FwN7gwzGu9lnbU++B3pMbOqEK0pm5NzfDm9JFmUsCuvzGbG4z7jxNg3TtH2C3/dC
X-Received: by 2002:a17:90b:580c:b0:311:ad7f:3299 with SMTP id 98e67ed59e1d1-31c4cd9d001mr7043614a91.25.1752275415679;
        Fri, 11 Jul 2025 16:10:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Z1TQfgkE3r2PMQwTwfxQjj0gjR9UsVQ1UbIMeevZFsnCWlYfrpvPY3URH71qwyKf5RhBCg==
X-Received: by 2002:a17:90b:580c:b0:311:ad7f:3299 with SMTP id 98e67ed59e1d1-31c4cd9d001mr7043560a91.25.1752275415267;
        Fri, 11 Jul 2025 16:10:15 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.227.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb467d7sm6197116a91.26.2025.07.11.16.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:10:14 -0700 (PDT)
Message-ID: <0bc51460-f25c-4607-bb9c-0e317e362201@oss.qualcomm.com>
Date: Sat, 12 Jul 2025 04:40:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711230240.GA2312867@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250711230240.GA2312867@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ar7u3P9P c=1 sm=1 tr=0 ts=687199da cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=4nqOr+EkFiuPl9GB/B4vcQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=P-IC7800AAAA:8 a=nqD_WAsoW_ZkbJYGnRIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: 5SuWU93SEUJNVHRUq8WJ3l1aq_d14Bx0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3NiBTYWx0ZWRfX8ckIlIP8iyDU
 TREWg+AD1SYqAVb5kn8g8Aj3r9SCF94vrmp7AcoLi4ObXPhw8OooLh+5ly2VjAk/wzoA41fa5hD
 AfiA439Uwm+sAe0hrC7vyTQlyZMWjt/Oo90n8B4cwj3JUVWafCO/OedbpT94iMUajXELu8WJR33
 yl44jasQd3glMdUdLEfENQYvp/HHDADYgOmqKJhw1zbGNBZOB0lU1nMvGrfIQPXw5DAXbSulUnR
 mI2JvNjyeWCvkjZGob9xIFoJRSW3oS2nGTqWy+1HifYqvUZKvRtsLz3I+Vgxb0ZhrXS4z0ycYD4
 8OBXl+DY6fZhyaQmwzokyb715xs0erKpbPKHx8I4oJ2AHsZBiB8o9sLVbh5+92Za1IWVphkGTVV
 6H3ca/MSUwlRVCrjUiNah49dRQv0MEF+CNekgaJG/5cg2NrtD7tgck0Ef7dJhTrwfpBN+2+W
X-Proofpoint-GUID: 5SuWU93SEUJNVHRUq8WJ3l1aq_d14Bx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=831 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110176



On 7/12/2025 4:32 AM, Bjorn Helgaas wrote:
> On Mon, Jun 09, 2025 at 04:21:27PM +0530, Krishna Chaitanya Chundru wrote:
>> ASPM states are not being enabled back with pci_enable_link_state() when
>> they are disabled by pci_disable_link_state(). This is because of the
>> aspm_disable flag is not getting cleared in pci_enable_link_state(), this
>> flag is being properly cleared when ASPM is controlled by sysfs.
> 
> Mention the name of the function where this happens for sysfs so we
> can easily compare them.
it is aspm_attr_store_common()[1], it will be used for all ASPM sysfs

[1] 
https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/pci/pcie/aspm.c#L1595

- Krishna Chaitanya.

