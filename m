Return-Path: <linux-wireless+bounces-32163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBSMG5svnmk/UAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:09:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AAABB18E122
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 00:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 164063013DFA
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBCF343D71;
	Tue, 24 Feb 2026 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBWkKjVY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbN5Po94"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494D29A9C9
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974550; cv=none; b=Wj2u5dcKxiEOwK6te/TYktUZ6GAgZhx9Wya+dMPlknKKHfcf5BYj0wm+nCACFivpXzZb8HEHLOAynPDKRKq250GqileyMgsBKu7kHsNa1Dm1p/LR39BrPBcIjimfn2pYX5Q6OQ+uRLIIxt/zks2ihI5gWOCI9Eb06/zw4vPwnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974550; c=relaxed/simple;
	bh=Y0iSQ7STF9zWPqDMNvY0n0Cxf/rCN/p3IcZJzRsBepg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K7gnlk22G8jhRvdcNVckwNVlvYQuPA6PoXm20/eJdaN0GR/4C6UclGbtq4hvYFIei6CJSiTNEYacKg5GbE98o6+ZfwvPRPEBdF9tjY2FSBTXpLuj5QbxQ60QwAeQOeScING+/m7e/go2cjy9dwp17XPBbsoydaIJS3ojXS6lTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBWkKjVY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PbN5Po94; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OFlGfr4044454
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TytIU7UUBtasiA2tpWwYSNyfQfamatG09lzeXl0656o=; b=dBWkKjVYpdo+eLPv
	YbGX+31ywdDfaqAU2M6oxc6d68uLmybV2vZ2S9A/Di36QYnTAMBSbd7eWkqDizgT
	WDDyh1xJtfHsdIzt6RvWvoilI8kjDrJHbr+iViu95bP7jM3FT391hTu/PrWOjoH6
	n40h2Pege0jdtK36CXI8V+Yxfe0mMWn1oJVxlQhF0r5yXtLQMmRb7k88+mP5i0en
	CrMlUXfq/9DvTN0T8Si86xqF+DzTrpsxkPuQGlQVnMMY5GOpLexJenPgRpocCEp0
	GdpZF2CBBwQ6+xg0CPYCYEhACvNTCpA0GWNzwNivGztTXSEhm3Ql9ycUm1NBUdOA
	bJdyew==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chexehexj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 23:09:08 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d4c1b9061eso63686573a34.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 15:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771974548; x=1772579348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TytIU7UUBtasiA2tpWwYSNyfQfamatG09lzeXl0656o=;
        b=PbN5Po94hxdd4QvHz6MurdoNmZDx2d+ovBDP7Up7immy1rxvR2GWeEi18gHtov3Fc3
         rZF+ZYu+SNNxTTE38X19pykYnHyWNMQEL7hE8bV3JKq4eqpggIrQHjAZZQqQrxtvIuuH
         mQsJWwysryvHPVZOQfAvYe1bhVfaNsvZXkmzBN3A2i8NJBo8U3WKXhfDxqBKhv2czVcP
         Ojb5VLaLm0GRCSurgIF0rxh71dQZTn2WfZ1FwF4uQig2wBHCnb4StStuyttM3ggwOjr8
         e6awQWJbJRR6O8d2C+voC54wnxvjvZOG0/OWjXUpqIZcu0MwxU1FJJdUgbVcP8ppHbM9
         afqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771974548; x=1772579348;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TytIU7UUBtasiA2tpWwYSNyfQfamatG09lzeXl0656o=;
        b=IbYSj3y7k6UFD5X9FGs6JiIXfUR0VXX+PEDHQEX7Ow2uwLGQ3xHi5vuIBJlwUiiOtv
         c+CgoUHvylZrNO0vEICscU78wkj6+1lEEix6kN02GzADZNEL+g8lwhBSjQfdOax9t3JA
         poN4GULvR5MlI0mr6ABrfdf772IZk5xaw/rKZINXrCyFLoyuAOqW87+DWblXCRab5fN5
         tXQZjKgJGiGMImqocVwxOkv+KVA0IHjdhumpnL0gpTtZ/dIn0NyqKWsAfLQbzqqSPEnE
         /5w7O+rxowvlarZ5sDeG1Pt94CnnDC9KbdU9KhnCvlXp+1L9yIlu9Yfbs5aD3O7AWctn
         c8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXo/GO6gsKB9TFob/20+jw2EptZB9PLdWuJY3v+JFjbjcy4BArHFfSIMuAt4TPkFJtHo9DnZj999qM9Zf42wQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8ctvcIKFomEM55wOVpntZJYe+va+Kvw5A5B9gulPfIr5CIQT
	KFhw50KEWguyb826HXoi1LXzuAAednf32Apya86c1tUbyFfIXKANKoYvMk5i+Q+UakZZ/cUatOV
	CS3n0i67i43k9M6wB1FLNnOIVXhCboKBZWWABKguYL5/xCecUTJzEHMGjp5yuW9kWWxR+Sg==
X-Gm-Gg: AZuq6aIPTDt4ii7VWD7KoSs8qLbIu08WaLxXaa35U4nESFkJ2eBBcG7LzwUHKtpLjca
	Lcbqj6HwLVelbJ/iOQHoycdie+5Kf3wSmTlzCmh09p9dZgEFtVFk6ywNulufoN1hGQryeHs8dlW
	DMOk4907wq3EG/EGi82wZvGpspS52RST8pxBW4smx00gFd8tGSzTiF++XWroULzu/DdjH0wk9iu
	GZri2zkOpRFvYSUQOvY5M3s7veTt57JBIavQF9YCD5mQwKoZRvo/SMHFjWechoi4QiQvWBv+BpN
	wrqdoihwqYjm2Ro2w7r/X/tYPbrUCT+hag3OSGKibWZCFFmxCTaXIejJhEBxsGU2DIe/ZQrO/Q3
	D1aciPbjBHiFCytJEnGCtpQV2+eYxYT+0JXxqmNyJm/JJ2+c075HvmsdqUfgjCYkwziCaSZkUa3
	7AhbO7Fko5I98grA==
X-Received: by 2002:a05:6830:4107:b0:7d1:9160:7b98 with SMTP id 46e09a7af769-7d52be6320cmr9065587a34.15.1771974547760;
        Tue, 24 Feb 2026 15:09:07 -0800 (PST)
X-Received: by 2002:a05:6830:4107:b0:7d1:9160:7b98 with SMTP id 46e09a7af769-7d52be6320cmr9065579a34.15.1771974547406;
        Tue, 24 Feb 2026 15:09:07 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf9f663sm10317593a34.11.2026.02.24.15.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 15:09:06 -0800 (PST)
Message-ID: <828b4d9b-268f-4f7c-ab7c-51aa49c0bde2@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 15:09:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
        "John W. Linville" <linville@tuxdriver.com>, Greg KH <greg@kroah.com>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
 <5e01a680-ebbc-4855-b1f9-e0381b3a8fc8@oss.qualcomm.com>
 <aZ4r6OUVCiHE-hhZ@devuan>
 <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0b9635b8-05ee-4ae4-b4eb-9b83188a0917@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDIwNSBTYWx0ZWRfX9zx/wC/LmreZ
 fo00iCne2s7QDr6gL/b6/q/KxZbPY034ua3ILorkulPYyToJiHdzzFg/PMvE7QgEw5OlM14+BDL
 Qj+yp3QGl1zs2+syd+Xta0oO5Of02wB1kL8+RLfyvIDdVo4MDnMWZi7Z2twwEUiVTn+bwt1nu1Y
 q1A4ZkRJGOBffPFU/+tY6FzNVWqrD8ZiRud5mtyOn4uijw3Xd25uZqLYaQe2g+oP0LwJsX1d4Wi
 PoI4d0MbpaWDhh3dwwsJZYTdk3SY5t1zDORnEmlwzlFm37K4cGZALlwAIN3U2jHC41x2EEZBz+z
 6jOubbtIeAXKyuZ4cvHAdNy82bL6m9BrVRHjIUgAdJNkfStQOuHGtFi2CEK/mgvt3N/ZA6ImeeE
 LUtwbLk/xrLWq1/Mjux6TwosukHoad44SztJYdcl3SN7Ify9EQfrE3j62z6g+pMgbL51vVGp19R
 PQxLJeEfL0Y6EdsmRhA==
X-Authority-Analysis: v=2.4 cv=V85wEOni c=1 sm=1 tr=0 ts=699e2f94 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=OSmWWCcvNqIZE99VXz0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: GkcTb2YDsvUq-eAiUhlONfx4W3upBP-_
X-Proofpoint-ORIG-GUID: GkcTb2YDsvUq-eAiUhlONfx4W3upBP-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240205
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32163-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AAABB18E122
X-Rspamd-Action: no action

On 2/24/2026 3:07 PM, Jeff Johnson wrote:
> On 2/24/2026 2:55 PM, Alejandro Colomar wrote:
>> Hi Jeff,
>>
>> On 2026-02-24T13:34:57-0800, Jeff Johnson wrote:
>>> On 2/24/2026 1:27 PM, Alejandro Colomar wrote:
>>>> Hi Jeff,
>>>>
>>>> On 2026-02-24T10:45:02-0800, Jeff Johnson wrote:
>>>>> On 2/23/2026 7:17 AM, Toke Høiland-Jørgensen wrote:
>>>>>> Alejandro Colomar <alx@kernel.org> writes:
>>>>>>
>>>>>>> This only worked by chance, because all callers of this macro used the
>>>>>>> same identifiers that were expected by the macro.
>>>>>>>
>>>>>>> 	$ grep -rn ath_for_each_chanctx
>>>>>>> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
>>>>>>> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx) {
>>>>>>> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, ctx) {
>>>>>>> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, ctx) {
>>>>>>> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, ctx) {
>>>>>>> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx) {
>>>>>>> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(_sc, _ctx)                               \
>>>>>>>
>>>>>>> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channel context")
>>>>>
>>>>> I'm dropping the Fixes tag since the existing code actually works and hence
>>>>> there is no need to backport to LTS kernels.
>>>>
>>>> Sounds reasonable.  Alternatively, a line next to it saying
>>>>
>>>> 	[Do not backport]
>>>>
>>>> would work, I guess.
>>>>
>>>> Greg, I've seen this situation already a few times.  A Fixes tag getting
>>>> removed to avoid triggering a stable backport.  But I think keeping the
>>>> Fixes tag could be useful.  Should we have a standard way to document
>>>> that a patch fixes an old commit without meaning that it should be
>>>> backported?  Maybe something like this?:
>>>>
>>>> 	[Do not backport to stable]
>>>> 	Fixes: ...
>>>>
>>>> In any case, feel free to remove it.
>>>
>>> Looks like we have this:
>>> There furthermore is a variant of the stable tag you can use to make the
>>> stable team’s backporting tools (e.g AUTOSEL or scripts that look for commits
>>> containing a ‘Fixes:’ tag) ignore a change:
>>> Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present
>>>
>>> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
>>>
>>> Do you want to re-spin with that?
>>
>> Would you mind amending to include the following tag?:
>>
>> 	Cc: <stable+noautosel@kernel.org> # the code worked by chance
>>
>> I don't know where I keep the patch, so I'd have to apply it from the
>> email to resend.  Could you amend it yourself?
> 
> sure, I'll amend the patch in my pending branch

I've also updated the Fixes tag to meet the expected format...
Fixes: c4dc0d040e35 ("ath9k: Fetch appropriate operating channel context")

> 
> /jeff


