Return-Path: <linux-wireless+bounces-430-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A580590D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5502C281E03
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC05F1F0;
	Tue,  5 Dec 2023 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="agnQBn/d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C483
	for <linux-wireless@vger.kernel.org>; Tue,  5 Dec 2023 07:46:01 -0800 (PST)
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id AUl0rsrMyhqFdAXcXrmG6C; Tue, 05 Dec 2023 15:46:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id AXcWrrUMwRGmSAXcWrdXjZ; Tue, 05 Dec 2023 15:46:00 +0000
X-Authority-Analysis: v=2.4 cv=efcuwpIH c=1 sm=1 tr=0 ts=656f45b8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=c601a17RXwP2wWhsnozrzA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=WzuJIX3iUC1USL5IvykA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NHebt4j7s8OHV/xuSCmvZsKFeNjOFLQ9DgYPRv6+6O8=; b=agnQBn/dUEGSq49ZF5VM6/Hc5V
	oNj2qa1gF12KYyLZcjOYvrvEAXdz1UHWYuUXA4oJin0nC6v4u/1qHh0/J8C20uocjWAJaUdZcqlzo
	Gm8t1qk/21heW3MfKbeq2WcLwEfrJ+uDVZMJjYY++n3rm1uzrJttTuIo3HH9QwCsiPMDM0g2sezyQ
	2X/DPIH+2da/DguJp2tjp5t8QckBJxTk7FCSLO5l1N3zZHKXaDwYBOq9Lg90v9iNOTjrN7n0b7Lvx
	HQRS0xoN1uZzJkkS2PIX9kWPywG7ZNmG6eaG1zhI2xX8yRpzDKuh1CJGoUvm8vkNqFMKe/o0nYcWQ
	fu9IL+8w==;
Received: from 187.184.159.186.cable.dyn.cableonline.com.mx ([187.184.159.186]:42509 helo=[192.168.0.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rAXcV-000tVE-31;
	Tue, 05 Dec 2023 09:46:00 -0600
Message-ID: <30ea9d68-e49e-4727-88aa-547b1b0feebf@embeddedor.com>
Date: Tue, 5 Dec 2023 09:45:57 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath11k: Use DECLARE_FLEX_ARRAY() for
 ath11k_htc_record
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
 <20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
 <4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
 <c5555ad6-6991-4fca-864f-355d2fae9ae1@quicinc.com>
 <87edg0pt17.fsf@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <87edg0pt17.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.186
X-Source-L: No
X-Exim-ID: 1rAXcV-000tVE-31
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.159.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.159.186]:42509
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNXB0A2qcAUvhGzMlnt6/3iQ8UGj9uDfaPCdFdeALVzIApOmSCi3ABwYKkTNbdMc0oqVrfnXASgmgjDwpUyYS6xntQsmb+7oDrVtCwt+8P4qX3myfeYb
 6gg3QDN0WK5eEY8JS5QI2Zoc+7lmaDaE+r4beJTSHoJ9fFThRRXrGpqSi1W+GZc3czYPAKSNHUYbWOF7FK+3AKRsY4l00IkQEl6zH/tUbeY0gNv3WrVf0YQ9



On 12/5/23 09:29, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 11/27/2023 8:23 AM, Gustavo A. R. Silva wrote:
>>
>>>
>>>
>>> On 11/27/23 10:14, Jeff Johnson wrote:
>>>> Transform the zero-length array in ath11k_htc_record into a proper
>>>> flexible array via the DECLARE_FLEX_ARRAY() macro. This helps with
>>>> ongoing efforts to globally enable -Warray-bounds.
>>>>
>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>> ---
>>>>    drivers/net/wireless/ath/ath11k/htc.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
>>>> index 84971cc9251c..e0434b29df70 100644
>>>> --- a/drivers/net/wireless/ath/ath11k/htc.h
>>>> +++ b/drivers/net/wireless/ath/ath11k/htc.h
>>>> @@ -151,7 +151,7 @@ struct ath11k_htc_credit_report {
>>>>    struct ath11k_htc_record {
>>>>    	struct ath11k_htc_record_hdr hdr;
>>>>    	union {
>>>> -		struct ath11k_htc_credit_report credit_report[0];
>>>> +		DECLARE_FLEX_ARRAY(struct ath11k_htc_credit_report, credit_report);
>>>>    	};
>>>
>>> Why not removing the `union` and just do a direct transformation [0] -> [ ] ?
>>
>> No reason other than staying consistent with ath10k.
>> Will see if Kalle has an opinion on this.
> 
> Yeah, I don't see the need for the union and I removed it in the pending
> branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a2faeea1fe0635563187e7821a6d0baf7b40f2c6
> 
> Does it look ok?
> 

Nope.

A direct transformation is just fine:

-	union {
-		struct ath11k_htc_credit_report credit_report[0];
-	};
+	struct ath11k_htc_credit_report credit_report[];

There is no need for DFA in this situation.

Thanks
--
Gustavo

