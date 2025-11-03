Return-Path: <linux-wireless+bounces-28481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7765C29ED7
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 04:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C5E4347027
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 03:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D04B284684;
	Mon,  3 Nov 2025 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ae4dgChw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q4Vp7T9j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5FD79F2
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139660; cv=none; b=l79FV0z17P27y27a/+BIQIkN9Ugloixl1IUy2WutQZl5I0deT/xE5hR+UZfife22A/2fOAYC5BM6lReFbBGnc1+VX7h2y6+VngOsS2AuuPcJvkdVhdF7vxXTMz4Kzqm60o5+8KgRKxcPFlmRY3ad+q4g3p61owvY2jnVOW23+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139660; c=relaxed/simple;
	bh=QSHEnqmFKvho/lEKyHzgFR2hs4DL+DjIGG9CxTxpsEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLvTS77CF/s/7DiA1x7LZNu5rJBGmMGJplRlZzCAI9dH5Vvzn0bvxfY4OvCRFI4c/l/Lcp/rThQ4YdRwrj78yFOMDQRO7rWl84KO3atRWDCjqQGvFsi/dnuuIB1d9i9yT7BidE7m8ebEIPjv4nN4ZYnPPI2eY30nJELcpOhBIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ae4dgChw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q4Vp7T9j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2He2eu925731
	for <linux-wireless@vger.kernel.org>; Mon, 3 Nov 2025 03:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FcCvOyYpj5kIxZcWJPVz3ndDcWqWgYyyK6gtYhwd2B4=; b=Ae4dgChw2X6r1elT
	jMJK9GAiS2n+kcmD9/HMohZDjKahoCyoYkd0RHKBnbIlg8bTGIXxQOc2ZwqZ/VZi
	eX+24OH/xvAX3x9RUnqcVEVElNPfN4B/O53zW0hbQAh5ewLlygCJlm67pwljiF29
	Ry4s0gggPiXOOM8VsoPg9WVFY/mNYIadqhwl9/qoAIDRGN1zEHOe3hPKbTWA+rXw
	88gwXqqLFuxCx+lQx3acCGhe/72LfOOGtZhDteXkbWqxi+IKSCXkdTO+9bH8MH5d
	uYbLf6y4BbXEvpiB3i8d5T3rPVZMseAO79bxk/z1c/i4F4F2ZaUD1n/vUACD6sVE
	FzI5SQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5977b7ud-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 03:14:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2958a134514so10160615ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762139656; x=1762744456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FcCvOyYpj5kIxZcWJPVz3ndDcWqWgYyyK6gtYhwd2B4=;
        b=Q4Vp7T9jpwEGxWe9NQaVClnkzTwFDKvnl+4WpO/3UsGiHVaHvNIaQRRkUqqmfrgqnS
         7jC6rmPwe+YSyLo/oGh1HdoQ9UVh7d6qIWXww+Eqyc+JF07xheZroE8tTvJZwBTdh00i
         aZfg2wl5rGrM1fGLRIURkRA2M1rSJpRNmriNnrgwQdujuxVxsuutjkvzSpUb6e5rDTsT
         Bi270++avZf9SxqnqgaLCCIEv0GUHxGBcJISEJ+n71gbKN/Bb0Rej3ZKLqAnaGey4jq5
         l71/CItXrzmAYlUkiEdDqjyvt67vg1WUkRiM7QqLZNV9byl+wPNQUDvjDC+dOdnGqCN2
         KTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139656; x=1762744456;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcCvOyYpj5kIxZcWJPVz3ndDcWqWgYyyK6gtYhwd2B4=;
        b=gENMfoxE35g+EDDQyGK85CXhlMsjF/aiAODNpBTHF/7BX65+dGuQWFC5vQZKiQ5CIS
         yaFSqauU5yzQR974Borw7yztSX/tsVDjByAtggA2PoqytpAgdxcQZuEj/lLlnbfMOST6
         V3HpjJwOOfUPGlCsL60cvacGZvo94284+lPU37oU7fuU1PH3IcU5oXx9DmYzEukxILSj
         wMl5tPTonOdKS+fJfc5LZRdBEywJxrUUPlsbb0WdRXGROGJWQ5zYweffbVl9Acsd8AHx
         3Pku0Z4b6WMr44M4IePuxRTPHz9lFY/zRDgPRQ5L9TzokdgT9Hv7AaL1E7WJFbnOtK+B
         vVLA==
X-Forwarded-Encrypted: i=1; AJvYcCXDMWCECdmYgLdwlyv2Veh7hmBM7+xdljfwAT5E6RXjLdy9F4f06Y0JYGBWrWU2luJPj2ToJC2SAmX6Z3ahIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NmXq2C51xnHpR6BlENna7BRxWhPT6wJuiremdAnzMfetnP4v
	/a5PiDNWsLKpUMOITeD7PvAbskG83oFiagNFblQGAkqi01PlGSp5LDtc5DQtxnB6AVs3f+thuIO
	WIEG9lqxRr5Ay1DGFA0j/hrX6tFm1ERjIR/72CxwodgWfgeKSPJmdir5yFokWpd0LBeV6AQ==
X-Gm-Gg: ASbGncuIq5DDgULQZ4qrNNDVWJz5FbhtlmcFVbeqtBJ5u0dj3YF+BblHrBLStcwFz1/
	UGAVL07aFsuyJS0b8nx5cBKDtgBKmOksW1H72ZbOqzqVByPcor/2axfGQ2hIE7lQMcxk2i/ODFc
	kbJMVVM61/XxjTVngbAB2fSo1hubnN44/Mdjbf6JPsA2gyntZnov/T38uE+3iRgP0JE4vxtcQ2q
	ByHOWJH84+prCza5vOQ2lkKFA4VCyrZw1fplaJ+uuLVwBdxY0b7TWQKcEu+S2j9dyaeJeyl7Llp
	8c4JHGkdW7Wox7DENo8I83xfhl/O56MlW1Z8/+4IT+Hdvk//H9c41PeRMuwrAHJfDAJqpJbt+gU
	YN/97VKjg1R2d6IJrcOMdsy1KEu8JSPX3qHgsAcis1XLF2pyjh9fFn3yFEDYbcdTD4LfpWgM=
X-Received: by 2002:a17:903:2f87:b0:295:615d:f1d2 with SMTP id d9443c01a7336-295615dfc5amr74639525ad.48.1762139656395;
        Sun, 02 Nov 2025 19:14:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4++0FISgdbKE49ZuiNLI8Dj0TWTNPlqyMmFrX5Wook5O8KJn7oUSf3QxBDSlk3adCE2YEcA==
X-Received: by 2002:a17:903:2f87:b0:295:615d:f1d2 with SMTP id d9443c01a7336-295615dfc5amr74639215ad.48.1762139655842;
        Sun, 02 Nov 2025 19:14:15 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269a8ddcsm99033685ad.91.2025.11.02.19.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 19:14:15 -0800 (PST)
Message-ID: <5d0e6d7b-d127-46be-8985-9be33a490aa0@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 11:14:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
 <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
 <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0a05ccf8-8850-430c-b008-52b3bc2df431@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fehq5ZEfjj_MSDDcUpFzCdsTxW9Fo-iC
X-Proofpoint-ORIG-GUID: fehq5ZEfjj_MSDDcUpFzCdsTxW9Fo-iC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDAyNyBTYWx0ZWRfXwqQyUWlagbgj
 yDsGamR9nBhkapxsCTN2r1+Mgefos9PcNxfJzGIiy8OU9fzzFa2aCK3htOjFExJBuMxcOmrhv19
 AfU+iLadR89SNd0MfrbV0Gd+IEnFh9gtYGTJt8wtEnXDez9J4CLmX34d8RkoNAiOB0/tIuQFFLH
 npmVwrigabRr6JmNARV8bHyeJaJj1B4WR7KSIdM2bpXLQ11WJ9elyenQf9dUZiMpUMTaQxLHKxQ
 1KSOghx/3GI8bhqPOGFCxkag5551kSDUx6vI6yW61/JUja82HR9kcWOKRy16k/k9iChubpmGTYi
 IQJvixofVsvJqu1NeLYa6IX0v4QVkb/RcvfeLXK6DZ911GFEYnVP1OSM0RwDLGUyctGfyc0ANDX
 jHsUkEvCpmksUOreoRJZbeu0sP9l6w==
X-Authority-Analysis: v=2.4 cv=WcABqkhX c=1 sm=1 tr=0 ts=69081e09 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=FMcQbdABRIzOJQOt2JwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030027



On 11/2/2025 5:21 PM, Yu Zhang(Yuriy) wrote:
> 
> 
> On 10/31/2025 10:43 AM, Baochen Qiang wrote:
>>
>>
>> On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:
>>
>>> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>>>               ar = ab->pdevs[i].ar;
>>>               cfr = &ar->cfr;
>>>   +            ath11k_cfr_debug_unregister(ar);
>>>               ath11k_cfr_ring_free(ar);
>>>                 spin_lock_bh(&cfr->lut_lock);
>>> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>>>           }
>>>             cfr->lut_num = num_lut_entries;
>>> +
>>> +        ath11k_cfr_debug_register(ar);
>>>       }
>>>         return 0;
>>
>> miss _debug_unregister() in the error handling?
>>
>>
> The documention for debugfs_create_file() tells us:
>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>  * by this function. Other debugfs functions handle the fact that the "dentry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anyway.
> 
> So IMO any failure to create the file should be ignored.

Maybe I was not clear ...

I was not meaning the error check on ath11k_cfr_debug_register() or debugfs_create_file(),
but was meaning that in the err handling below it, _debug_unregistered needs to be added:

		cfr->lut_num = num_lut_entries;
+
+               ath11k_cfr_debug_register(ar);
	}

	return 0;

err:
	for (i = i - 1; i >= 0; i--) {
		ar = ab->pdevs[i].ar;
		cfr = &ar->cfr;

+		ath11k_cfr_debug_unregister()
		ath11k_cfr_ring_free(ar);

		spin_lock_bh(&cfr->lut_lock);
		kfree(cfr->lut);
		cfr->lut = NULL;
		spin_unlock_bh(&cfr->lut_lock);
	}
	return ret;
}

> 
> 

