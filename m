Return-Path: <linux-wireless+bounces-30238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 965A9CEC217
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 16:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1CB630080F2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 15:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6698A28467C;
	Wed, 31 Dec 2025 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmCWnsdm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QR462rSG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C149319CD1B
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767193351; cv=none; b=N6bWS1Edb0itxkYjOi8XTiXaqkIFXsPWXFsKNjmF6eLZtX1hgeHAxe4NiZP5rtsPUTXAZlwzc6C/7pHxsXLH82JkGsxpdMFRmFaOGvs9y2rErn/oaOiTjvbiEF1j8ST8b6MTFp11UyghHvIO17aGYLztUdi4gUzJ6c7YU9+rTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767193351; c=relaxed/simple;
	bh=hLUjgjU792XdaQ87pmizMNeeyV+aqPmu7RPMcrYMEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYQeM1hKxU90s38IggwYGpyiSlu38ECMz9I7cad3ppXL4mgTT4g23fz24E5O+2WCq9KUbCRV/Qw2WutMmpJP2ZY6yZqDu4K76b+L81Jb3y41TVwiOncgwpMn+k+8FkqcV4iBoT8Gfp0BHe8m2DzGyR4yQM97z/bNiorogsUhUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmCWnsdm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QR462rSG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BV63Qft2054591
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 15:02:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=G2g+Iw+praYQYAElrNxBI/Zb
	2AEqMuCIMvAgbIJNLuE=; b=AmCWnsdmnZJTarH6FB3lZ75DHaNMaWe+mX3YfFrC
	RwugPRQ8L/wp2mosAhJ/xr52DcT84S08xmXj3bh9KovSZEC03Czex8Bmdi96tUna
	dUSMsUrkDw4kJqUNJ3Kg1Y6GNm1zVCZPH5LgDTOeb7YISDEDHUpmjgqASt1nerqA
	s8UurOJxGgOFkq8qtL+2I3TrY8bmZpBnQmsFETWdeD+xy8lqc3mLG2CtXmOuxLX8
	whsQf35lx8CryA9XCcFLCk/BQnkuhe69DNDWfF4sFJowGY2IXSwWMLa/3AV0VRsn
	l039Wz+vrI85Kj6hDv6ubu4E0iku/MWnTSDopKpICrHbqA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bcx748v0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 15:02:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9412512e9abso26150709241.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767193347; x=1767798147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2g+Iw+praYQYAElrNxBI/Zb2AEqMuCIMvAgbIJNLuE=;
        b=QR462rSG+IQHT75y7TYHVhPtbIzUARRZZqh3Dta1PyGLqrp1Ni0Fu5yiTOIRsAzetY
         yYyFxf8lxTJlQfzXWtko54tR4fugQoMOft+kzM7BLxpOF7JiFTB40UySNTIACZOjWCYz
         JBkgTmGQ8MKwpXLpS93vxbMJ6DPC8C7lk08O5wbotH7hfORfjulWylKUVIgVnZUWUpEz
         MPbA6x168usgUYjxbAndvtvvzr+8hQ525DEplgiu1L60+qdc/UBgJib5iN8rENw7y6mZ
         1yw9ZWUAn6okxGmUYgxQV8eGd9NYdDdLDxaagRFSo8mboqOg6DORTTEf3xop71VaoFqj
         zXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767193347; x=1767798147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2g+Iw+praYQYAElrNxBI/Zb2AEqMuCIMvAgbIJNLuE=;
        b=oM0g/X9I9sDsULH5/3LcdrRGNJn6LAK35tGniKzwTSlWc70asD4b1mxXXtYx8pJ7p2
         4fAX4wRYrLpIuIDYMYjgKCR9ajhSPGCwVyUu9YZvCAoYk1nBIQVUeDz8f1EPQdDojTwu
         RJAoWOMvH7LyGj/TWxm5acjniXwL2KaaMTsPINueLl/UYxmlQxLzNGuEG3gtXG0AJ2CT
         SJ5A1p+A+ONwTZjPfh8l0R3g19ZVMzVlbWKk2tnHkVZMUhzXrLjG2IKbtzdyi2GdaN0f
         CK6pB4+s/kgJmX7hD9cePborXqK5vYpa1JYlaabBuTZC9kLmDZd8Jb0ZjBbxCsQsizhj
         VNVw==
X-Forwarded-Encrypted: i=1; AJvYcCXANOJG42gUve5QKtEQSzSNscy7wzQwTx4EzoLEnjMkhRF0L0motJWN1kBixLpk/2e+GX0YYXAo5g95HPQb7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdqdhGF7ftXhoSs5zf9YgQKzhPNqsiLV+xkEmEHxtld7Pl3A6V
	S/FLEH2yopX3jYB79Y6XGqzN12QkG0TPEmyQZWWnHqqGjDkPZFAM9CjwJQwJQB9k0EU5q2ED90T
	rMf2Yigc7Li/cPwvGS6oLW+VJVi6g9h2T6ondoYR17qXRJ6J6qa8VmexRDS6s3ir40/cqXw==
X-Gm-Gg: AY/fxX4PxHGxNxJ8DtYHqingg5o35rsdm31ACZLIWX2rL9ROivRlQEH0D5WcVMGV1il
	hjJWk8WULz/CJYtxpmmJBCK6vM00YNXdl/ncvNCAGzW5hay6Qo5XhLTnJJ8Zv3+LVLCIcLsEBLh
	FrAPBIb60OsD8i+yeq4ckg2yRpvpYC13vhNZ3vHDZ3bD8fB22e9dQCcJ4Zrt95rbiEu58cLEwni
	YMAZU3fr4Vjm8e/iqEp45NBflyFxIGR7kF618eKPYMwI65c0teRcWnKC0txjfRxI6h6TyDyJPzn
	sBrMeMcRVt33epEu8H/A/d4dyK6s7+T3nGKPxAhWJ7KaX/DCqeyAbSVV5jBMLOdUw5MUjsUr3+M
	i0HZ8nT9e4UaBNkj/bE3xczVlqRG9UKBWVuJDB+EVuq1pe9Patdyl1aHEB+fTxT4VFYNbnRo3xG
	bjn4Q0RgV4IxF55ICuGT2Td0Q=
X-Received: by 2002:a05:6102:6448:b0:5db:36e5:7b41 with SMTP id ada2fe7eead31-5eb1a6804b7mr12911003137.11.1767193347268;
        Wed, 31 Dec 2025 07:02:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsSSEbdUu35JgF018iIayUPMoHIXc5JQon3MalP8dnesbqXrtvIu+qvSZ2lIdHk7UPLughSQ==
X-Received: by 2002:a05:6102:6448:b0:5db:36e5:7b41 with SMTP id ada2fe7eead31-5eb1a6804b7mr12910910137.11.1767193346827;
        Wed, 31 Dec 2025 07:02:26 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a186282ecsm11141146e87.94.2025.12.31.07.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 07:02:26 -0800 (PST)
Date: Wed, 31 Dec 2025 17:02:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 03/14] Bluetooth: qca: fix ROM version reading on WCN3998
 chips
Message-ID: <5hsxiep24iabr3pw3mlcusv5iifapvzqqdjtralha5npchucgj@xopra3rrxvc3>
References: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
 <20251231-wcn3990-pwrctl-v1-3-1ff4d6028ad5@oss.qualcomm.com>
 <dd020ebb-d005-4322-9321-b09199156a9c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd020ebb-d005-4322-9321-b09199156a9c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: d3umAwKxIFYQUgPnktCx8Ko5ED0uvVTo
X-Proofpoint-GUID: d3umAwKxIFYQUgPnktCx8Ko5ED0uvVTo
X-Authority-Analysis: v=2.4 cv=HNvO14tv c=1 sm=1 tr=0 ts=69553b04 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QZZepdHf_SHC0IKlQlAA:9 a=CjuIK1q_8ugA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMxMDEzMiBTYWx0ZWRfX4DXpuvxNT5/a
 IQn89xrDWwYCs29q4Zeil0ubwvcyVrvWhxE5zDrPrR/uxuASPnb4J7igVC3ga/EXXjweuRLvyKb
 wMTmC/Kgm0YRgaMIG1aEfPWblhw+7X4F3VA0ZkJTUKdgc12V8R7mGQ312XaDQTQR1Vy5Fsgz9EU
 GgSvy/DjSe8DAuqQpqTyQ67gi+VuQ3Qg0u8LpXXUQmWGirspO3opjdIrqIFouBHhw3iAFRDUSu5
 BKzP7TngGrEMtJciimPqemmDaMCZrHs2KqJalvKYwKPtqzzh1n3Jtgy06BBb9tjVLmKDMg3i7K1
 E1HFy9gcF7M91APEa3C6XwZ3Vt/e/Xrhzksy6d+Z0nNnkTAs1GbsPjjorMUB/nI0M2sLJBbvUc3
 qsNvGvmiycUNHg0e+4pvZfSpBfUJTZC6BqJNudoayRB84UTRUConkZgcHgfJEQGRXoWyiQgOxIB
 H/NWzifochjbgyFjA0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-31_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512310132

On Wed, Dec 31, 2025 at 01:04:56PM +0100, Konrad Dybcio wrote:
> On 12/31/25 12:35 AM, Dmitry Baryshkov wrote:
> > WCN3998 uses a bit different format for rom version:
> > 
> > [    5.479978] Bluetooth: hci0: setting up wcn399x
> > [    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
> > [    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
> > [    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
> > [    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
> > [    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
> > [    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> > [    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
> > [    6.842948] Bluetooth: hci0: QCA setup on UART is completed
> > 
> > Fixes: 523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/btqca.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> > index 7c958d6065be..86a48d009d1b 100644
> > --- a/drivers/bluetooth/btqca.c
> > +++ b/drivers/bluetooth/btqca.c
> > @@ -804,6 +804,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
> >  	 */
> >  	if (soc_type == QCA_WCN3988)
> >  		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
> > +	else if (soc_type == QCA_WCN3998)
> > +		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
> >  	else
> >  		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
> 
> This looks like rom_ver is essentially maj|min or so with min = 4lsb and
> maj being a couple bits up.. no big deal in the end, but this could be
> expressed more nicely

Well, I'm also unsure about the WCN39998 one. Maybe I got it incorrectly
(I couldn't find any definite documentation about these versions).

-- 
With best wishes
Dmitry

