Return-Path: <linux-wireless+bounces-32153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XwuJLLfxnWk2SwQAu9opvQ
	(envelope-from <linux-wireless+bounces-32153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 19:45:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 235DA18B893
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 19:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68B8C301C942
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E745287507;
	Tue, 24 Feb 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G43NNqTR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cW5aVSy7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B92DB7BF
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958708; cv=none; b=Ovf5EaYp4MWi/J/4r7/aoriwpGLgsfbc5Ru4iB+/vLbB5qDFOUR4bGvteNxRa2QXt7RdHdIVM8TlT9qdsup3dY3O42rfMUC8kugS7D/V4Xe88bz2hYySe6jmChqsUJDdHK6yQVBOi9JNp7V6ZaED4mIcpjj/mf6ZOGD00RQMxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958708; c=relaxed/simple;
	bh=DDEAYS25x70YUEYDypVQhKKomGUOwKS0+xIErtQ1Z90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3dvX58cWunSsAI7PFpTATm89BtA0Dl8P/sxcWX4gOHG5NQENYFGmNq72kMIQhThwWfhACWUHWFRDoKrwWwTGyzoqMF2m/Lj9mW+pYgxnt3u2HUtprw7ZAhxCEFFUHhxXEpNYSlhH+QZsPtmKHvxJBTGhhlDkEntaZ1EkL63j8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G43NNqTR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cW5aVSy7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OH47eZ583293
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 18:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BxeCJXdWmnPvH38twRCMSvoeo/Adwe2c4HaxA56TZJk=; b=G43NNqTRyLnTJr29
	+njeu4UmorG2ebbXOVe2CodLYcILlPgENNCjokUBTIn+2i7UA82YpLtimQkHfCut
	O6EVUdcyRVnDDGKK2ZwFYF2ALhY3FIByvGVCnVmoKoNwi+1TigqJzLOScVYJ8EGv
	C9mU4dJFCrPM9yj9AQPAyG8Cre/+JZ9bg2PTxFmYpdPeRSd/uAwKOyF1WvI4g1DZ
	kHLR9Dfb6sTnrQ+hMuh3EBIA5U9TSmWfV3jRngNsaxjq13ZXD5yYxxad9dsyWAe4
	ilf65w9PWbPte746v87niX/3gpZFy1sT5zNmh2pomMRa1eiXmlICIZd6eHzFwwUS
	8v8S9Q==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chg2grcsw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 18:45:05 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4c3d9dd70so86647966a34.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771958705; x=1772563505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxeCJXdWmnPvH38twRCMSvoeo/Adwe2c4HaxA56TZJk=;
        b=cW5aVSy77vCBwPIRdahcF/H29c30tuugeO4ACRAlyt8a2GvFaXdUktbSKPrMhVaNqP
         IB0VV4D77AqN3p8hcHlPBsiyTIt+7+CjwkZi5CbGRjuoahR4Az4xPYjkuW0X6uZYt8Hp
         uaZNgkBRKLaVZDOGl+WbH7jRulc7NkYrtC9Hf6C+HtwpT/U6TImWOtYJK+HXjsHklU30
         a//+EOoxZy+DUjkLMHKOEbha1oVtfdtzHjZFKqvaD6X97QN+C2q/aP8LbcmvRhXy5+Je
         a6NQpoVQfF0047qTbC4TRDital/arjFY8NL/mQEUJcbFqRBk2ZZB0dei4FJa6qkvYnec
         UQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958705; x=1772563505;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxeCJXdWmnPvH38twRCMSvoeo/Adwe2c4HaxA56TZJk=;
        b=koKtwd7B5z01IQwN+IT9LP7c3+zz8j1/LBjtHyoBV0Sgtl27Bl81k6UUd8YrDfqAeD
         Wwd0IxIuxbPz9sTASYXze4PDouATVGXvfRxFgz84c5Us6MaFpJKmJVHUGWHwaWDJIdhK
         OWsE5G6hcsmYrCT5oNCDKhPj38nde1egbHgvKYPUKcx+tp70YvXVzxiCOgAVxc5rRZ4a
         hz6aUCmyFDQCL2tuEmsas1GAWiU93fItBBgdO1J6ZqVcIvrMoo4iAj4exM7re23F/PUo
         GW0utZcJ1W0RiHuD8d9LOBObkC2gHHilXujws2aADWN5TaV5pwh0FK8oMGZTD9tyXLae
         /O3g==
X-Forwarded-Encrypted: i=1; AJvYcCV8bIENruWvHtzlkI4wP1YjRgW+UlqjjXW+TpXRMAERZFsOKaOoFvRi8kWzKMN48GwBS7Z4lXjimkg1T15erw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkxhPVgCSNAsNBlVLIFb+KbfyUUff/pTq/XgBhmc37bbbU6/T6
	f7lXKdzM65mkMBWucXop0xpHJZEXsGNCOJR8jFX9xxm4HNQVdde6EMib2OGc2jbx663fee4OORK
	Y11hJuD4LL+KKucix779voFZH9AzNlyRYnHhIOk5FZaXMIGSMnjvV/FCHykN7qlrhjKKTBw==
X-Gm-Gg: AZuq6aJmt0Cmoh9agsmBDMzUtPbgBV/4lg9dPC3V/rQGZTDcsfJ+aBFjq9FGf60sTyt
	LnSjNjfjOwXMLlRhdPqUqgJipTZHuD51FIIb/Jwv3RiYeoswiK8M/Mr2PuqFUuHCHD0CtIzY6wl
	XVSr3ng1QAQax8eyPK9B0Wrb6Oaz3hJzRB9S4vQt3ykDxfY48XsTIt8AFS21qv9FWe20hjZ6GEt
	Nb7OalQDH6ebM+VshwVmBiiT6p8wMYpXgP/mmJIUbUT/WM6Wls41DBiOSBmSaj32TABRc0IEFMe
	7LzBy0TAWFgq6x4nj8gvLYiRw8pyKdFTv2CbMf8Cx5dYfd9dv+bkxVy+EC0oPf7Y+fEbU1Togyb
	6KJNS9uxYeDbuEBciI/0Lz/hvoqvQeY4Q9g2jmyqrU3DAtRRM7VfF0ggipyLfbnjJAf8XxQ+X+E
	5kFPwFYg==
X-Received: by 2002:a05:6830:3153:b0:7d1:853c:83e3 with SMTP id 46e09a7af769-7d52bdf416bmr8862883a34.2.1771958704801;
        Tue, 24 Feb 2026 10:45:04 -0800 (PST)
X-Received: by 2002:a05:6830:3153:b0:7d1:853c:83e3 with SMTP id 46e09a7af769-7d52bdf416bmr8862871a34.2.1771958704479;
        Tue, 24 Feb 2026 10:45:04 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf7874csm11320380a34.1.2026.02.24.10.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 10:45:03 -0800 (PST)
Message-ID: <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 10:45:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Alejandro Colomar <alx@kernel.org>, linux-wireless@vger.kernel.org
Cc: Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <871pibo5fj.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BvkWaWWuXJhTqVA5xnsBvvwReLZFzJP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE2MCBTYWx0ZWRfX5a5VKFicjjag
 uT1run2XRyP1WMYaXbKxlYYHUtTfhu+KJfjbH8nsr73yV1ucO+7gJFkSFdgIp1nGPnvltoYZepT
 DVQB+VaM74HWqa3DGXfQJ5dOBiY6SdEEkgFn4HeyKcFnZ74zKZ1SpjJ8wZb3d5XMpVqdxxA+Y1z
 3/yN5snM63Oj5mCjQ6r8orCzNO30pmi6vJhTZ0TG76/zbmYxEfDwEL1ARAGUpatlLz+S7NVqPiz
 WRC+FswSzTtsdnXEXUJSu+4zRkRE/2rLDuKtHM3iOLI8C8I4i3jF4OPFgzVfYZA3WW99oMGplrA
 KNBWuanVPDKQa5rPRti3YSDHtNsidaqvtpwIQ6ZBfKNtI/QylUkhP9fieHlXvqQSy/TLhtogAo5
 Mvttmb0wQK29sTmLV6/N3UG7Eo4EjKCWmAEX9RQ1nJx6QFEdFHvyhfnA1l72oxDyT3bZ8EiTpF3
 sWoPDcp9FFJnJZNWY2A==
X-Authority-Analysis: v=2.4 cv=ftHRpV4f c=1 sm=1 tr=0 ts=699df1b1 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vmLDa1wCAAAA:8 a=PprNUeorIEg4BUonjt8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=h8Bt5HTj68qkN2fS7gvA:22
X-Proofpoint-GUID: BvkWaWWuXJhTqVA5xnsBvvwReLZFzJP6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32153-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxdriver.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 235DA18B893
X-Rspamd-Action: no action

On 2/23/2026 7:17 AM, Toke Høiland-Jørgensen wrote:
> Alejandro Colomar <alx@kernel.org> writes:
> 
>> This only worked by chance, because all callers of this macro used the
>> same identifiers that were expected by the macro.
>>
>> 	$ grep -rn ath_for_each_chanctx
>> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
>> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx) {
>> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, ctx) {
>> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, ctx) {
>> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, ctx) {
>> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx) {
>> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(_sc, _ctx)                               \
>>
>> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channel context")

I'm dropping the Fixes tag since the existing code actually works and hence
there is no need to backport to LTS kernels.

>> Cc: Rajkumar Manoharan <rmanohar@qti.qualcomm.com>
>> Cc: John W. Linville <linville@tuxdriver.com>
>> Cc: Toke Høiland-Jørgensen <toke@toke.dk>
>> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> 
> Yeah, looks reasonable - thanks!
> 
> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
> 


