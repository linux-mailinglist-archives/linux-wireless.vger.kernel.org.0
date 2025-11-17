Return-Path: <linux-wireless+bounces-29024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3CBC63589
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A5714F3264
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 09:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2065E32779B;
	Mon, 17 Nov 2025 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LPELYkN0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D0wb9Jiv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E9328B4D
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372418; cv=none; b=qZSCsP/bmhpwlCA5EUyq6jSfIl6h43XNi9hXe8gd8On9O5HBoy+sX+ktTNRkVMsYGsZig1+lX8Qmr4P6rMuOGPAEnjWrkhYJKNd45Rbx4ZuKwX4bLHUvumbrKd8ZbctVORHcMylUb7ZlRhq/aai5wAkA1yYRhKwL3pVkOjyg3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372418; c=relaxed/simple;
	bh=7JixjtG6vnwdyUsb9WoFfcMLMOeC6W2mOpMNxQvRKP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNTIRZV0PWa/uccvd6XOCPZ/hzNkvReBgfaTJDua/r9L/qRHYOqA97ukPhfkKvNnSIELJF8Y+XSwmw6NEQTfg2MKu24V2vrMYKrrZ20g3Twlp3ejOfrgkhVGSQoUF+X0S5H7e5y3MQsMYUHgxkThQfkt0iI6bNuliCJ+skDJECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LPELYkN0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D0wb9Jiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH4nu5I2686184
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xbd/M+85Vw8s1cKki8JfY2ECZPNgUg55KrvYQLAi4hU=; b=LPELYkN0qPh8NQVx
	ho7nt7iBoDbMmvC5nuYX1Oom10iPvtqeX4anvlzr66M0t7I7FF5asu0UWTakDuY0
	vzoHVQy7k4K2WOusrA+kkwFDoFFdwSZdweenQpAxzTAlmlKs3gTRCW6A8kfNJdOW
	hXp2DY/Jd1uZcg2CJpbh6ZzBnbXF2S+Ny9l8ca7MvpGCM+cEY8PpnhTt8EgVRvrb
	XW9iANvWA/m3NMVMmdRSxHngAKgON8uZCbPox00Ugg8lIJ1RhanZ9qp+0avsLV2M
	RHbG0iaQJg3gVJWPJYFyPYQus75wz+GgaFF7PmR7wzuOT7cSttH5EmlNs8PQ4pvB
	YTn8Jg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejt5c6b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 09:40:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e66542afso137982445ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 01:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763372415; x=1763977215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xbd/M+85Vw8s1cKki8JfY2ECZPNgUg55KrvYQLAi4hU=;
        b=D0wb9JivuqWHYt3K/+5ysw0sALc2SqagYl6MQYg7ZMIBStyOP5DArASumRYlyyCp2v
         GfkQYryfGCAQMXR3HtV+V1M5nMw1RZ93TivcBC0e6DvpCp8bLVpe6OxYHkS16t9Dyn9j
         RYedGtTiiTkDD5kjsGPCgei+X8WHqT8iZxewqvmyA+rjqPG3md0PezAd1MAf7yj3xQ3f
         HIss7Gf7jy3SNclNzcwNh6oF9GtZrXywC6APBGK2w4A9QSzj7JSoeIcx1N1Z+SODZYDf
         JOu6nWjld6mNP5kP94csY7IZuXtUNj8CzZ9iXqPFStEa2jKs/T5xBys7ho7CNLzSrbRl
         ZF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763372415; x=1763977215;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xbd/M+85Vw8s1cKki8JfY2ECZPNgUg55KrvYQLAi4hU=;
        b=Jcn9zrpM2LaP+VNh1FLH4xY/steOzw++Nd4cyoCWSXnBLPAXE74Reyje8u+1QZMDVs
         Y06mlEb9IptN1t0P3I/ZNPFf9LLJmImJPzbesxSUpZOvgNVAp/Xl4agqdGOM/Hxj9dbb
         aw07ERA8ljBRqtKYhbl77da95BnDUCK6g2qC0wxpDYPnwPn4K7xuggjXyHI+mXEC7F3t
         R8/Le7SbLyF1Y+ySGdSgCMpdLGypBQr2hOx86LFzt9NB5aMpkN7byb6RiAEk0ejsMgAx
         +6KeMYoVrsEUC31L5okcx7/TyyeTZm+wL41LZcAzsMgJW3EWvnuImCFtuqk7bEkop0no
         7gcg==
X-Forwarded-Encrypted: i=1; AJvYcCXQgRxQhzcIkSKY/4hLM0ckF/jaKWTeNefatUmthGdDMIaD3+Y4WRmIqOFyNiECkbIEjUYjwYCBnGj4og1dlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyRD7fawbN7AMCoZX1GE6hwnq10X7OYYFVmWSRoJx3MTJKFUZ
	m2fnARYk5fInfUZfosm2CJ4x/LAAw3c2y1/t7Ufx3rbx0uNsQpsw8TFQDEUVGAFrficuksHPelY
	uSXcFlheMotKO1ByLuF/WgMDirLoh5UAZ+2vJXLzi+ST/qqG5f9Z1J/RN2jq7KQ1Ijw1VkA==
X-Gm-Gg: ASbGncsu44+0hY+dFurGv+o/F1cTQto/RpnQYELw+HkOpPkLS3vF1WOkABVuIRDBPW5
	Y2EVDhwKQaCIYxWCVIG5MXzXFstq3GRc33A14EJ5+8Du6uuV/PuLgmPXEOLRrsE7ElIyqFtInKI
	k09M0FGAEX00GhJbzjq2vzwGjB5HSLX66uS1Zmm/zphSDT/XYRGh61BcjvefdrN7v8KfipHwTCT
	9ppsk5WtBy64lwcBV3p1utayXLzwSc3oehEKDyBcRVNh/adP64sLBu+Qn6wOHzrS0rYTTwuCsz9
	vtRn5yXBvfET2PRSciLSUETfZlQevhIX4y800xT8g6Dp5OoZj5ruNQPgW88CxBVjjupHNQj5E6J
	Ny+lGtpjd3sIvSKssiHEcXY3ODvs/m3ZbwYzKkzXYcmUKvPyn5NlQkD/PH34nnZs0eFtW4DqG
X-Received: by 2002:a17:903:286:b0:290:ab61:6a4a with SMTP id d9443c01a7336-2986a6d0441mr128562385ad.13.1763372414784;
        Mon, 17 Nov 2025 01:40:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFddAeopk9ZsDGbTtYli77j8FC4dnPHKzaKqbT7rUM+u8ZEVTzlfZ/5emnD6ZwaUr3gOC+XcQ==
X-Received: by 2002:a17:903:286:b0:290:ab61:6a4a with SMTP id d9443c01a7336-2986a6d0441mr128562025ad.13.1763372414315;
        Mon, 17 Nov 2025 01:40:14 -0800 (PST)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b11bfsm134601665ad.53.2025.11.17.01.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 01:40:14 -0800 (PST)
Message-ID: <b8277024-f9d4-4f17-946f-c2c390669067@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 17:40:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <2fd84ab2-2e3e-4d05-add5-17930a35fedf@oss.qualcomm.com>
 <jnggqxqv3rjzhyevovnnxzplfhl3t6auhhvmoz7wxmsf6awgdx@dusdgxwsxvts>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <jnggqxqv3rjzhyevovnnxzplfhl3t6auhhvmoz7wxmsf6awgdx@dusdgxwsxvts>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LqmfC3dc c=1 sm=1 tr=0 ts=691aed7f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DkQbIERv6x4r1F1n8LQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: TZlo2_MXbVAKomxtQ1q-bjDg8SQ3RkLw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA4MCBTYWx0ZWRfX/9QLrLn2Jqid
 jnfCF3U94xdjr4jGOqzezG98jiWtqgJH1F8LN23O043R3Do4YUTjgQBLcaZclWXz3i4DfaabYr6
 0AQyrcJiKU/6CC3doCgU3Ljng+BJAMynef+kGZetyjyNsTVPsa5z98Hq6mKWbmKc5l38BTefE94
 AwhowUsK0UhtlbW+E0kmAle3QBNVdHK4LEk7N5YbRhdlY8nT6A+8RX7SYkA2wLuZ5n4JEmy0O+c
 m29r74PSOpMeF8QdhE1zYp8oJkRKzwt06TzoOtN00dE3qk8incF8aAHOCDKFHr4s2QbNL6TWCdM
 BjfboNZO6WaLZXfqnLADVMAKnri1txaEme+1ch1OnZiFdR5OelynC7+H3YIQRyvsVYu7Kz8GcBR
 CK4PzaktUXRNpoEY211HTvcN386I+w==
X-Proofpoint-GUID: TZlo2_MXbVAKomxtQ1q-bjDg8SQ3RkLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170080



On 11/17/2025 5:00 PM, Manivannan Sadhasivam wrote:
> On Mon, Nov 17, 2025 at 10:36:39AM +0800, Baochen Qiang wrote:
>>
>>
>> On 11/14/2025 6:22 PM, Manivannan Sadhasivam wrote:
>>> Hi,
>>>
>>> This series aims to deprecate the usage of "qcom,*calibration-variant"
>>> devicetree property to select the calibration variant for the WLAN devices. This
>>> is necessary for WLAN devices connected using PCI bus, as hardcoding the device
>>> specific information in PCI devicetree node causes the node to be updated every
>>> time when a new device variant is attached to the PCI slot. This approach is not
>>> scalable and causes bad user experience.
>>
>> I am not very clear about the problem here: is calibration variant device/module specific,
>> or platform specific? If it is module specific, why the lookup is based on the machine
>> 'model' property? While if it is platform specific, why do we need to update devicetree
>> node whenever a new device is attached?
>>
> 
> I think I mixed the usecase of the 'firmware-name' property in the above
> description.
> 
> But nevertheless, the calibration info platform specific, and hardcoding the DT
> property fixes the location of the WLAN card with a specific slot. For instance,
> if the board has a couple of M.2 slots, users should be free to plug the WLAN in
> any slot, not just a single slot where the property was defined in DT.
> 
> Also, if the users plug-in the WLAN card of another vendor, not Qcom, this
> property is irrelevant/wrong.
> 
> PCIe slots should be plug and play i.e., users should plug-in any M.2 card and
> expect it to work.
> 

correct

> However, as I learned from Jeff, calibration variant property is also going to
> be required in cases like router boards where each slot is dedicated to a fixed
> band and the calibration variant is going to be different for each band for the
> platform. So unlike I thought, this DT property cannot be deprecated. But going
> forward, I'd like it to be used only in these special usecases. Most of the
> upstream DTS have a single calibration variant for the platform and for those
> generic usecases, this static table should be used.

If that property is not going to be deprecated, should it take precedence?

> 
> - Mani
> 
>>>
>>> So to avoid relying on the "qcom,*calibration-variant" property, this series
>>> introduces a new static calibration variant table based lookup. The newly
>>> introduced helper, ath_get_calib_variant() will parse the model name from
>>> devicetree and use it to do the variant lookup during runtime. The
>>> ath_calib_variant_table[] will hold all the model and calibration variant
>>> entries for the supported devices.
>>>
>>> Going forward, new entries will be added to this table to support calibration
>>> variants.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> ---
>>> Manivannan Sadhasivam (2):
>>>       wifi: ath: Use static calibration variant table for devicetree platforms
>>>       dt-bindings: wireless: ath: Deprecate 'qcom,calibration-variant' property
>>>
>>>  .../bindings/net/wireless/qcom,ath10k.yaml         |  1 +
>>>  .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  3 +-
>>>  .../bindings/net/wireless/qcom,ath11k.yaml         |  1 +
>>>  .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |  6 +-
>>>  .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  2 +-
>>>  drivers/net/wireless/ath/ath.h                     | 98 ++++++++++++++++++++++
>>>  drivers/net/wireless/ath/ath10k/core.c             |  5 ++
>>>  drivers/net/wireless/ath/ath11k/core.c             |  7 ++
>>>  8 files changed, 115 insertions(+), 8 deletions(-)
>>> ---
>>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
>>> change-id: 20251114-ath-variant-tbl-22865456a527
>>>
>>> Best regards,
>>
> 

