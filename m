Return-Path: <linux-wireless+bounces-23476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5D0AC6EC8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 19:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EF21BC81ED
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B147F28DF29;
	Wed, 28 May 2025 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uf9x7Seb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5B28DF45
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452165; cv=none; b=fGdpcsoPyBmBiYAqOumBN9mdvmWrEYnxSGbHDpHSlf4mMP+uFNgZK8mHjDZuBSf4+b0zBnPLcahic5glvl61tp2jDw04Q7/rOkVDq56y6rTefMxgoMUHaqMVnpmXh/HwficTJnaD7rOo3WCa+cKcHzeFruTw986JwoiIqQh7s3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452165; c=relaxed/simple;
	bh=P5DH6TK68IfewbPbjBNyN3Igm8pnpjna5wIQ96fcUA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ut1ZOFoENp57nqjj32q5zGl2h5NZ9mPwXHJSelrr5hJ3gQruMC8UpU9DO1/LHyQ4c60x2jeif9fXI3T4eqelWPGxtYm+bCy90r99yiZfuTN4qY/54VXIyrbfffOaCUDPnM/YLRCVXweWwwQWpqkm4DB9vTqIhWlex2vYSXWMzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uf9x7Seb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S6qBns021217
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 17:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P5DH6TK68IfewbPbjBNyN3Igm8pnpjna5wIQ96fcUA4=; b=Uf9x7Sebzfaig52F
	HC4yO2gVuSF1ijiG90m7lBmIA440iNrJXYeTVD79Go2NsR+jfLV8PO/Mwy3jmpIw
	j7YD4JlZiVPCfRESLTuA+vvJ5nev8BXObgKO11TFu9xjkuPx6bG0JtCPAL3686Sb
	qGbhx2rRMbOuu/WBP1x3X2UqVCtQNIdW2NGT8qTAsM2klfUT7TBtW1mxJ2CHOBz6
	o2EWw6Q8haso7YzYwNud/+PtJBCjTIH1IenffxUj3BpqBxBLdMyGYgsjMWG3OP78
	3CtxOheYNbHYyGCe/wIpWm68q1vTpCQ+0ACcPyStR/pVMQJ8/6rIFbdLOXgditNt
	wXkqiQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46vmgcye9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 17:09:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-747adea6ddbso35099b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 10:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748452156; x=1749056956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5DH6TK68IfewbPbjBNyN3Igm8pnpjna5wIQ96fcUA4=;
        b=IPSXxH8uk7lfJfEn97TLCCDEORoTN1tqpdSJCEJOgVUfUDI61HAP+ksVhYKnG4Dbx6
         q6xc5MJw7yW086WgNlLbTiKYpFyTPDKkiezm2dYpYCcJ44/+MZ7pOr25276S7/xLFPIY
         AsEM+nRd/v6Ck0AVzVAyswumnPXoo56tgH6f2+/uChyJ4EQw7O2n/nrVlN0j7NQVa2av
         ngay1OryROJDZzzKstbeW7GFZXTAOsEu6YW93cf80agKDWHftLfww4QyulO/CUP6napY
         /Nk6QQyB08TlPMUSSn+io0Uq/v7wsZtT2YvtJovvcy5VoQpIA4AnzdsPGlBM/6xycy6T
         8FiQ==
X-Gm-Message-State: AOJu0Yw3ERRKMdhMs3yO+f/HHJaRsedwY8EllqpXpE9T2f91/ZXyL56P
	mPkhy/aQhFRaj5IChjfLstlLd6RS23h6bxH5knIjTTBRZrtjSmMzf9X5gXE5GV2peKAO0qsKbEs
	NWOvjCaIjEjX0JVCPZ49Hy0NxwKb+M2jb8op1jcB/HrJj6h3BwzRXAHLxqvz/9UUMZT2QNQ==
X-Gm-Gg: ASbGncuNkGaKxQDqake/Vsnfiy3i/CfZXDEH+mBeDoMW208PIYLXX+km2e9wvkIrISg
	zxcGmycDTEOgVzJC63nk86jBIJAjBaqbLT4e+4C2gW+97KaHMkz9Gf+v0g7FCLnEmYsSghRaJlO
	OycNa9yHARiQ5GC/LrYZ4/rEolxX3kiHUfl2mjMXd6CothAkAPDcxGkVvxJx6A0jHXTWQXzh/TP
	/ZJIfObFG7HOR0+cMhQ3JU9mGwJq39cjYnGIK6sw4UzRiVJZOVF4f2rY1N5dRzlvjT0+G9e40Bw
	OalyYhK/3UwSui7cP+bgDsk1VHCJEk0Ku05XqbMxsMABhluWNhazx5pmQqud0fRoK7w=
X-Received: by 2002:a05:6a21:999c:b0:1f5:882e:60f with SMTP id adf61e73a8af0-21aad7b9894mr4036168637.17.1748452155784;
        Wed, 28 May 2025 10:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiaNI+cXJwqMbzrZLRcZ4vITBV+YprctMsQST3aGygOrHCcxmbfduJieT4q4isjK4eQNjCqg==
X-Received: by 2002:a05:6a21:999c:b0:1f5:882e:60f with SMTP id adf61e73a8af0-21aad7b9894mr4036139637.17.1748452155410;
        Wed, 28 May 2025 10:09:15 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2d987283c8sm1247807a12.4.2025.05.28.10.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 10:09:15 -0700 (PDT)
Message-ID: <a3fd78c8-b156-42a3-89e7-f81af1ce4276@oss.qualcomm.com>
Date: Wed, 28 May 2025 10:09:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v11 0/3] wifi: cfg80211/mac80211: Set/get
 wiphy parameters on per-radio basis
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250522053326.4139256-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JQUWdL-JZ33xzxgvMRYhuFtp-Vu77Z7h
X-Proofpoint-GUID: JQUWdL-JZ33xzxgvMRYhuFtp-Vu77Z7h
X-Authority-Analysis: v=2.4 cv=Ws4rMcfv c=1 sm=1 tr=0 ts=6837433d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=UweE6LEfa64jyw4aDRUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0OSBTYWx0ZWRfX+54NVWKV2EV3
 e8BCVYDpppzPAODjrY2hMCWn11PDgRt1pXLiv5liG4r0Bq2VkeoEx8J5BxsB1J6577fNDTegirz
 D/J8gwV5WEkiLZC2OQYY1UIDcVH/Z6oHsFCzi70BQzQlyqoz8pO7L4HCPQ9fme/lQuHdqwe9Mqq
 tJ3jQxPJ6pfRxZN36N7W2nGoAhlJIvxMbBNVu032QMhVIr0JP2bfDlQVpdEZ4UJ7Zmc+Mb6wBmQ
 elHXpdtqTxKYcYo6mCr44xyi22tXjPiunwNCgjBU2HkrcqQAzAaKXy5bACgKOgrzpcdmglMAQzx
 NOctLZhp7sLHdEWEzt6LwWrNZQvGvvkSJlllgs19D1mzsbg+wCQQpzwTznK+Ow+aGdL+i6tzMQe
 FQwMUWA1EFCaNEM3sFiWs6MIzIl76/qdRC/7s1Mf6aZXZG0gZLM/kkzOdwYz9LDxViBghPFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505280149

On 5/21/2025 10:33 PM, Roopni Devanathan wrote:
> Currently wiphy level configurations like RTS threshold, lacks radio
> level get/set support and same value is applied to all radios of wiphy.
> Add support to parse radio id attribute and use the same to apply the

i know this is bike shedding, but IMO we should use consistent terminology and
call this a radio index instead of a radio id. we already have usage of
radio_idx in cfg80211 & mac80211 (and no usage of radio_id), and the proposed
nl attribute is NL80211_ATTR_WIPHY_RADIO_INDEX.

so i suggest a global s/radio id/radio index/ in all descriptions and a global
s/radio_id/radio_idx/ in all code patches in this series.

/jeff

