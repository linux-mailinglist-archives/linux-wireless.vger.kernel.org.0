Return-Path: <linux-wireless+bounces-30032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C93ACCD331F
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5808A3007FDE
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD372E92C3;
	Sat, 20 Dec 2025 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="powBxEOb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="etd7Mzw6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0012213E6A
	for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766246719; cv=none; b=ENAEnLcKZIBbAw0OnBbu7CdZtlI1S9gPBxu+f7fBIvrwpY0eHuSRdfdsDpRdr2rVrlu2cOsg+7LLJRRFIxKuKqjYR9jDKnAyhVCB5JsSLbg9hGy/X3G5BiD+Cgh74tauemBGomTHwxRxxDrEaLSqiRAHpwx8jMr1roo+LdtG8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766246719; c=relaxed/simple;
	bh=ZzqG0IHbB778OMxQFRTVwAK7+J5xT4Xdltluh9XydQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFOi5xyz27i8ZgP/cg/3B1ANaPcYqeHiBRjnUpDhof6YcCSD8lTpgAa+kWMY84WFtnkOa87mBYSmX4yGtGuwYn/v+FLqM4Nyu6Mqhs3zU+4Hhapa8EhiUhcvodqYELNq+81PTGBmYiLa5GNkWvA0Bq5XlNFPZQl9dODxOtIeyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=powBxEOb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=etd7Mzw6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKBQsbN4098688
	for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 16:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sx7DvDJmvBJJajgCpWJAfurGfDkcJLeLV01NkZc4hv4=; b=powBxEObFMXZnvDe
	IOxY9M46hWsA2j+MXBX7CCNLZXhH+CxQ6crVA/TRVfWE7DBdKkng1Q0xDA/48xsE
	wCa1fy9WghsTIUP+SHdiqjFy8+wozN+HJ7xj6AtXWISF83ftIWuKUgxTQbbIP/P7
	r2r+u54/Rz69LuwCsXaSpahTDyGjxgGm+HTOzeFfV2y6Quwrvpht43l8q+CLoosX
	x5Dr0M98ObA/btre7vc6S+ASc/HXBikuyXMPM4v3qyLTgZKwzplEMsBYa3LoTqqN
	q6gzi8NIFY/RZnh2NS8gkxGX3KDKUd2v+N2JixHuaI0U2KslttK/tVr5q05J/40U
	JvTX9g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mux0w0d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 16:05:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8824292911cso85118056d6.1
        for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766246716; x=1766851516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sx7DvDJmvBJJajgCpWJAfurGfDkcJLeLV01NkZc4hv4=;
        b=etd7Mzw6XYLpeqQYeTkmdJ5l2HDubfXuh7rI4hpGgbMcogVyrjQDJ2E58W9J2uEeRa
         R6KzL1vgdGTVnrvSm/a/ZBOpy3TXaVWVAITYvd/W70GzqtLRTIVm2M+jldw9XeFoMqE3
         n8dj0AUzwlhDkgI2Z5YCGjPr5jXEDRqnFrTLHz29HRKac2vXEOVpw+PEm/1d6+Fi1JJl
         iKhF3boy+JGlRHuWMRGk7qCiiEm4CFsZa6Tk4GE/kwV4E1qGtjG2HIbPD8ulQv7Dk2zY
         VU9Dtmht70lqCPKOys0qBGwswvHNy2QGkq9w/PrSF4iBdnN5nHg9QULeM5XMkhjV3Iqo
         U4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766246716; x=1766851516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx7DvDJmvBJJajgCpWJAfurGfDkcJLeLV01NkZc4hv4=;
        b=CRG0KIg5FXtg2zHgYU4eWP5P8O74yadXWcfX8fB0qGJORm3v297e+NYFdjy8MMlz2O
         0nHjtnZAAovJsm0O5H3nBMG9LobvW/EKQwKqtMcVu9xv2lJfEzURmOKKoVevVRkYB5Lr
         u/ydvBu7P6sYN2BDuwKRJiD0ga1pD/3/i8JlHtTvAWGFQ1GdFUK1HjvwLyk6XJp5H4N5
         lvSJFzmYfkgBE8hCw78FbgucWOxQvKbb+lJCU+aOKNjFMAVcfy/9FdXOjIEF4X7DxjAh
         0xl1W+BJMCJVkFNhxysHT06/tsfPVEI3xmTn85XuF6OPOWtNIMlBbkXOBeCsw+rtlrFY
         lYnw==
X-Forwarded-Encrypted: i=1; AJvYcCVuBLNhnoDyh+f0uL99DoK0jGgSg4o3RszLmY/fBNqqF5dPi1FPKa1/BGtBuc3e19HfQa58/40b9uHLuPGqrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBg8iptTjW3AwMzw18q5/dWgvSrd8LsBSPmPKWZ/vMWQIw0Yl
	TLTCLaQePi1nQk4yVVFzlwHM8ylyXYDgaWVSlPqIXAI4pN7ouy6XTw5UJTs6YWZH8zT70oi7xmT
	+tuwxdPRogcE6BdkYOxVmIIUKm5QYhkWd3GyHVB3GRFWEXiBj23183kwqlP5JnODPiH3Q0A==
X-Gm-Gg: AY/fxX5wNEQTrn6NtRJJ+gBFwH5Y06+2w2nNRb0P98DThOCXvG4F3jnX0HMkWTvbQLN
	7Br0vOYsEl/19e+AiLh6OZJrocRXjkcZbxt9Qerq9SNvgWEA44ZpErHfxZjy8ut3r0HYXBAv0Ru
	ff4+NrEnZCGCexIuMVXWmxEge73j9pK3z8W9bKvauusiAVC0Gg+RiDRNW3BfgTojXQx8U/cDY6i
	xkh8q4U2U7LQMURxzu/GdatA7ow0YxoinUbqL75NUofL5ky1IQe+b9xdRJJlAoVraQor91ULZi5
	Fh9B68JQt/TjJgykdR0J4pe14/YkJKiY56YICjDhqs3YJo4eMElSmBsBdoWzLb3+SFOcHRD7hOX
	8hsrbQsnZ2OPDNGy6pP1T7fcO0a1iryiZwtvYcrDUcohc32Ct12IRL02mlJ+qE3s9fXrUXfiw4J
	2uLaqr6PWv7zWcyiDmlIraw68=
X-Received: by 2002:a05:6214:4983:b0:888:7dec:11ff with SMTP id 6a1803df08f44-88d7f5b4884mr104916456d6.0.1766246715851;
        Sat, 20 Dec 2025 08:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Whl4rMKWU7yncCxutDz2fSapgwvmZZq0Bmc+w/O5q1n+gdugc2XguNuuCW4HIlwTrQY/WQ==
X-Received: by 2002:a05:6214:4983:b0:888:7dec:11ff with SMTP id 6a1803df08f44-88d7f5b4884mr104915726d6.0.1766246715402;
        Sat, 20 Dec 2025 08:05:15 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18618d07sm1613067e87.62.2025.12.20.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 08:05:14 -0800 (PST)
Date: Sat, 20 Dec 2025 18:05:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod.linux@nxsw.ie>, jerome.debretagne@gmail.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Dale Whinham <daleyo@gmail.com>
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
Message-ID: <elgdbinyzunhgxaqy432qzxb65qb6yuheiimwutxdtf6q6jjpc@dgcnk3bgwqij>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
 <20251220-fervent-mamba-of-sunshine-f680a8@quoll>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251220-fervent-mamba-of-sunshine-f680a8@quoll>
X-Proofpoint-ORIG-GUID: 9VJSzXpBwq-6ymWm1EVAT7Mg_qYAt1RZ
X-Authority-Analysis: v=2.4 cv=EvnfbCcA c=1 sm=1 tr=0 ts=6946c93c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=QPAgtUUt1aV8ZuakPV0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: 9VJSzXpBwq-6ymWm1EVAT7Mg_qYAt1RZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDEzOSBTYWx0ZWRfXzYFWH5RWBrq4
 Ln0FaEfoln1Y8jPcwgrC0FR7NPU+pqm9TRKYIBLPxF2bwoGu1VZaY4xfiLe71wgzvO/fJaDZSde
 2NXVe/EsGCOFPfpmNVGap9oHwS6I+5SHGgYFMyW0SKAfazOeRXDj65geke0RoqyYFNMYQlP9nkM
 p/x8VbXZA9jqugXaUzCULLPM688aN8TMPaN82nGVXJFEl2qRly/tF5xo3oEKkZp0DXod6RNsLMj
 WXs+e9NVgcHoigbvmOA2ir1IuAvuNPNvpyKsjHSYv3cXGUwUoRiDnWRPIP9hq3VVueh7KHD2X8b
 o351v0TFbP8WFr/v07tCvJ5kHkvTZ9N9wBj04ks7ounu8BptXkFeQ/N58IL2IA/DiIwdMm+EesG
 cdeeCXylUS3qyhfNUa29CAnFpTCk+6/FL+f+UbZszV7n8TO0xRc2dUnX5MsvOUsDUra+4cUqkXi
 QT0OY880QII3ZSICiUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-20_03,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512200139

On Sat, Dec 20, 2025 at 10:12:14AM +0100, Krzysztof Kozlowski wrote:
> On Sat, Dec 20, 2025 at 06:04:00AM +0000, Bryan O'Donoghue wrote:
> > On 20/12/2025 00:21, Jérôme de Bretagne via B4 Relay wrote:
> > > From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> > > 
> > > For some devices, Wi-Fi is entirely hard blocked by default making
> > > the Wi-Fi radio unusable, except if rfkill is disabled as expected
> > > on those models.
> > > 
> > > Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
> > > disabling specific features based on ACPI bitflag") added a way to
> > > support features set via ACPI, including the DISABLE_RFKILL bit.
> > > 
> > > Add a disable-rfkill property to expose the DISABLE_RFKILL bit
> > > equivalent for devices described by a Devicetree instead of ACPI.
> > > 
> > > Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> > > ---
> > >   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > > index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
> > > --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > > +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
> > > @@ -29,6 +29,12 @@ properties:
> > >         different 5 GHz subbands. Using them incorrectly could not work or
> > >         decrease performance noticeably
> > > 
> > > +  disable-rfkill:
> > > +    type: boolean
> > > +    description:
> > > +      Disable rfkill for some devices on which Wi-Fi would be entirely hard
> > > +      blocked by default otherwise
> > > +
> > >   additionalProperties: true
> > > 
> > >   examples:
> > > 
> > > --
> > > 2.47.3
> > > 
> > > 
> > > 
> > 
> > Is this really a hardware description though ?
> > 
> > Its really more of a logical/functional description. It tells the runtime
> > what todo, not what the hardware is.
> > 
> > You could also have a list of quirks in ath12k for this or have a user-space
> > utility look for the appropriate platform device string name and disable
> > rfkill.
> > 
> > I think this logic belongs in drivers/net/wireless/ath/ath12k/ triggering on
> > a compat string.
> 
> This is good point. Either this could be deducible from the compatible
> or this should actually describe the hardware and whatever is there
> wired/configured, not what OS should do.

One of the examples _might_ be broken-rfkill, e.g. if the chip expects
to have the actual rfkill control from the EC, but the board doesn't
provide one.

-- 
With best wishes
Dmitry

