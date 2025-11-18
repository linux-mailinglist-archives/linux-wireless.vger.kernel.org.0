Return-Path: <linux-wireless+bounces-29078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E3C67CB4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 07:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A15C54EF359
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB22F12D6;
	Tue, 18 Nov 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="htY29goY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BdMPJghJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD072D47F4
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763448815; cv=none; b=FApQj+p/uTsK1Q4N4cCABpk7moF+INrQm9WxXlONx75XsPNrt3mF8meSNvxCmzsFTkNf6DU/1aRI/gOv47APmjcgi6mOFIJc3vEOh4FUoW+g44cFBE7Go7bPII3uNt0qyIH/R1y9rFwTFZ6V3WKQAnwLXIAYnsZvs51CElBE8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763448815; c=relaxed/simple;
	bh=o7h4PjVNyyYPBJgWSlovxPdj6S7AkOcOj0nH43WmiBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQNieGLagwHs+U7yvLub4mMJa6pV8TqjlJ4YtkKlTbYwfC3UCGGjDHd01yN/ElEFHsbBnnc1xPdCwX17w8ART/5W3NAiJxNvilFnZq6a2R0o+K8H9Z66SoHc3l6DFE92vFOsW145ZJpYqKVIrFx7KZRl6nLdfmvKn7QpjhF0BC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=htY29goY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BdMPJghJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI6NBAf4107917
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 06:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DX+0M+0mWy/BPLyBS36f3e9yT2ekaLn5n3Ig+Sg3x3Y=; b=htY29goY3toDJbWU
	0z5wnuM+bTc6MZbOrVPEAW6XsBSUOHMS9nOr4D7Tl5kBIk/Q87p2UhE1xsRJuxLM
	OPdnWbnxes4VxBSz86UlyCN8VZHbtUAUQqfBYjaZG84XAwn1pCRiYx/2WcBOF5Iz
	X57R4jlyleztfKlQYesTgnuIjkJ/nhM8AobhyneA4Y5sHbgdIAM5MhTmYc3dmYw/
	6ZpJxfgnbUHK5lka6SBuCD32TJcK1K8m8V9iQL85JJSR9jk9oGV37Bkq4/Z35knE
	mjRRu6f2rkKslgON7L1chth/Pjpvtwjf6wIKzCMMOyC03rJlfVdG98j5efcKzXnM
	jRtsFQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag2hpb26t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 06:53:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-297f587dc2eso93263775ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 22:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763448812; x=1764053612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DX+0M+0mWy/BPLyBS36f3e9yT2ekaLn5n3Ig+Sg3x3Y=;
        b=BdMPJghJABfR0ZMxT3BqDx89hhe34V25SZkFd/dJ2GwdjyoGCG6lQ2RqNMWmSfc7Ei
         WvoVrD8T/0PH6K0E9CK2eynyvKWsdLmsWp+YoNzx3d5vUGnmCTYpr6xMDqMm81/9Czv3
         2iTE94FiI+PQWsCSVFpKXg0raQGxjO2XAgHuMen/R6zzyGaYBWkexS53pNI4hOFGXAJM
         skVQlEA7rIkAZYOuFU6S7NUFuR7R5ynzSZyQDhqid9KWN/pNMnnwZBQS8+Jy0Mkf+CBS
         U+PCqjUITUnWqAagBT/IIuY1EwvQKI9Y24wX8Hi+1aCEsAl7CBubdqrBJ8n3D3cgtGcZ
         fJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763448812; x=1764053612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DX+0M+0mWy/BPLyBS36f3e9yT2ekaLn5n3Ig+Sg3x3Y=;
        b=WcysnrtU8MT8IWK+zNxkgI7HtzRVVL5A0MN52s5YfaBMXrmjuwFeRcTN6gB2bkvB1c
         FmgR/cUKjetjcq05q59I0R5aTJ95HsGaPP88LcP3pJftv/e25G/nzTr1DXsRjduLMxAj
         U9b8CyolgomEvg4e/qN8VebgfTcglg5MTt4HMHJTrjNra4eee2IcIRmbXVAsAafxglwY
         7x6HvZM9LzE1T4TZiL2qYP2oFt4o2V3azBYiaHFeD+l7YQ27X3LsLR3pD4weAl9MN6ew
         ykgD80RBxKrUz9A7KSY2hfXTs1xqNe4vRhyaZl6wSUZfUfrbGkUnnRBfJOwk7Tj+f/Xt
         cPag==
X-Forwarded-Encrypted: i=1; AJvYcCWvjUtZ/IQTGRjFxriejMLvdCWFuSLszZwp5sS2FX8vgkwgLcAiYiJSjsxmgypWKuIiOup8+P2DojHxyF+Dmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KNFFG0ZLQ8RCzZkdj0su4sXvi21c+88xn2bBpz4JlWV0y3Rc
	0ZucTLicysKOgr+AtVTougSEz+EH/m7It+5jqV5iWV+bMQWOghbuzPGgdkbGArSCDkJt42nut2d
	LCNBG3+1Zo/u9aiI/4w3omAfkAxsjysrtf5lr2UDCx6XeoNqFJIIo5qKGmESigbh28lMa5IKfQ3
	UG2Q==
X-Gm-Gg: ASbGncvdjtwpyPSWS6nZavhqnmJw2kJYf8TwNPRN2ObTjHkGyM4DqKBQwHkRzwjYv6f
	P6eLL+US09xSLQhVgvHMNQJNVlL3VQVNdztvwFgDdI0bwa11hBlzlkPbZUL/aoGb5TNoEsZJpo1
	12/RPq7BeVfDtfg2dR5mpnUvcuveqobr9Tt7pT9dZBFucObdNijrZ1QcLCtz8CzLvt0cFH2AJoc
	AwJzoUmcto+DRz5P++5JXsAeQkeqMw978wOb4NvW6FRbCdDjOBgIOEdU7dY/oMOxMe2SKMlHkt/
	lHYpfK2WwLNPM3XhOH7sEAUcSTvGRYSz099IQbDGKUY+nqvJ9FTOtAylYp5UjDF9OZixMCcbdjJ
	z/UIo1JRLh4ZlqA==
X-Received: by 2002:a17:902:e84c:b0:297:ebb2:f4a1 with SMTP id d9443c01a7336-2986a73bb6amr162660695ad.38.1763448811916;
        Mon, 17 Nov 2025 22:53:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwLzQEHhETj6zRkHw+TFy4NsmE2cQhY/5PkFmJnlUFOaaGzYA6d6q2qBji1rRTv2fZXXmQCQ==
X-Received: by 2002:a17:902:e84c:b0:297:ebb2:f4a1 with SMTP id d9443c01a7336-2986a73bb6amr162660405ad.38.1763448811396;
        Mon, 17 Nov 2025 22:53:31 -0800 (PST)
Received: from work ([120.60.70.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245da0sm160489625ad.26.2025.11.17.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 22:53:30 -0800 (PST)
Date: Tue, 18 Nov 2025 12:23:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
Message-ID: <trr5j57vwk2dhoibdgdxnlkftnmfcmjkwmicsiltmhybxanjaf@tzaeeqcyz56l>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <2fd84ab2-2e3e-4d05-add5-17930a35fedf@oss.qualcomm.com>
 <jnggqxqv3rjzhyevovnnxzplfhl3t6auhhvmoz7wxmsf6awgdx@dusdgxwsxvts>
 <b8277024-f9d4-4f17-946f-c2c390669067@oss.qualcomm.com>
 <exfmj52dqu3uctwsb2gopcjg7744vq5avlkahtmgfw4opw4mfl@t2svrln72u53>
 <f853d9b2-47f8-47b5-a02d-6aa8f12a4283@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f853d9b2-47f8-47b5-a02d-6aa8f12a4283@oss.qualcomm.com>
X-Proofpoint-GUID: wuFltoKibJU_GJkHa0oQQmsMPemSpjCt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA1MyBTYWx0ZWRfXzf/aCjB17/7m
 FSSuHosxz8j2nV0R9c7vbaMaaxLw7v0/uRS5YP6arecB/f+5wxjWszUPPQqXlJ0Jf2920J59xjx
 HglVrHoWObihPe7GIY6KudBY0l0kdtHxdBjHtBQGGkIabs6wo9JA6oF8NHqh0w4fOXMSHVN9oOX
 wZ35xjlGRXzu6xbdmzFbIJN9Y7uqMOTxwIOFIfnfATL1ZVhKKo+q5MKDxMXquP0cdZpk4D8D4wz
 O1vlyC9hrBmfDXun5mbro//GoHqAhHyLIa2Jd7M85TEOb5ts+ySbzdyj9AJnfhcWdIPiULFQOeZ
 +UR6R4a1a8MKOUqaYtedAb8kjcXqGHjdRAU7ulzKsMDmUcxjQO2TAH/wl0vbsxQja+DGErl/P/l
 0Kgu4Vw7neQzqGvvmaNWyQe5Nk/MsQ==
X-Proofpoint-ORIG-GUID: wuFltoKibJU_GJkHa0oQQmsMPemSpjCt
X-Authority-Analysis: v=2.4 cv=Y5L1cxeN c=1 sm=1 tr=0 ts=691c17ed cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=0K+2RuW+WQ0nQqINzVEGqg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=XiUpprS5y50ibpukT4MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180053

On Mon, Nov 17, 2025 at 09:13:04AM -0800, Jeff Johnson wrote:
> On 11/17/2025 4:45 AM, Manivannan Sadhasivam wrote:
> > On Mon, Nov 17, 2025 at 05:40:06PM +0800, Baochen Qiang wrote:
> >> On 11/17/2025 5:00 PM, Manivannan Sadhasivam wrote:
> >>> On Mon, Nov 17, 2025 at 10:36:39AM +0800, Baochen Qiang wrote:
> >>>> On 11/14/2025 6:22 PM, Manivannan Sadhasivam wrote:
> >>>>> Hi,
> >>>>>
> >>>>> This series aims to deprecate the usage of "qcom,*calibration-variant"
> >>>>> devicetree property to select the calibration variant for the WLAN devices. This
> >>>>> is necessary for WLAN devices connected using PCI bus, as hardcoding the device
> >>>>> specific information in PCI devicetree node causes the node to be updated every
> >>>>> time when a new device variant is attached to the PCI slot. This approach is not
> >>>>> scalable and causes bad user experience.
> >>>>
> >>>> I am not very clear about the problem here: is calibration variant device/module specific,
> >>>> or platform specific? If it is module specific, why the lookup is based on the machine
> >>>> 'model' property? While if it is platform specific, why do we need to update devicetree
> >>>> node whenever a new device is attached?
> >>>>
> >>>
> >>> I think I mixed the usecase of the 'firmware-name' property in the above
> >>> description.
> >>>
> >>> But nevertheless, the calibration info platform specific, and hardcoding the DT
> >>> property fixes the location of the WLAN card with a specific slot. For instance,
> >>> if the board has a couple of M.2 slots, users should be free to plug the WLAN in
> >>> any slot, not just a single slot where the property was defined in DT.
> >>>
> >>> Also, if the users plug-in the WLAN card of another vendor, not Qcom, this
> >>> property is irrelevant/wrong.
> >>>
> >>> PCIe slots should be plug and play i.e., users should plug-in any M.2 card and
> >>> expect it to work.
> >>>
> >>
> >> correct
> >>
> >>> However, as I learned from Jeff, calibration variant property is also going to
> >>> be required in cases like router boards where each slot is dedicated to a fixed
> >>> band and the calibration variant is going to be different for each band for the
> >>> platform. So unlike I thought, this DT property cannot be deprecated. But going
> >>> forward, I'd like it to be used only in these special usecases. Most of the
> >>> upstream DTS have a single calibration variant for the platform and for those
> >>> generic usecases, this static table should be used.
> >>
> >> If that property is not going to be deprecated, should it take precedence?
> >>
> > 
> > If you mean 'it' by this static table, yes, it is going to take precedence as it
> > should cover the generic usecases. For special cases like the multi-band
> > routers, existing DT node fallback will cover.
> Does there need to be a PCI Vendor ID & Device ID as part of this lookup?
> 

I don't think so.

> For example, start with a device that has an ath11k chipset with calibration
> data for that chipset. If the end user replaces that chipset with an ath12k
> chipset then with the current proposal the same calibration variant will
> attempt to be used. But there will not be any calibration data with that
> variant for that chipset.
> 

ath12k doesn't seem to require a calibration variant. But even if the user
replaces ath11k chipset with ath10k one, the calibration variant should be the
same as it is platform specific except for WSI.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

