Return-Path: <linux-wireless+bounces-5392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4563788EE66
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 19:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B292A2898
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3132189;
	Wed, 27 Mar 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="nxDsV4CO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AD1514C4
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564804; cv=none; b=B31uMfE0+ZffyE1Z7f4XmG+9EtOMUgKvUYqnnbsWctrFgdxZ1sPaZLwvnTJJi194K0Vr6f+zoTg0oeLrnubMQgF/gZfZg+lZKttVFCOhfwPMnQs89pGOUHPw6rmn0uEBIaJl54GRMhd1ustmfIk86SbZkXgzakw2Jlh41EyhPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564804; c=relaxed/simple;
	bh=wWGHjeDpZavQDjtU7nfyce/8Gzr5lFSubbp9E1BsPb4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=X6vT3BJFDeN9607wAaG29wZkhfTfW4375+ZP+rqmOExCGFx1JESClTdytVxSwMsgihrHyWLywHvRQmhe3ErRPbqpvqDBpRwJSzxREVIkh5fntPmCfMgTLal/E9p/3cz9c+MokHi4tOM9/HtnGZ/oVioQjYR7PVIyHRKW6HMdA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=nxDsV4CO; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id pWKmrLINBtf2QpYBor3iYa; Wed, 27 Mar 2024 18:39:57 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id pYBnrow4kGDo0pYBor4iZt; Wed, 27 Mar 2024 18:39:56 +0000
X-Authority-Analysis: v=2.4 cv=I+uuR8gg c=1 sm=1 tr=0 ts=660467fc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=zXgy4KOrraTBHT4+ULisNA==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=v8LEnFnaCG9JqxBWnZgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FhDtWBwKqrP+NfoVTgkUPYrjUuTaeWvHamIeomR7TP8=; b=nxDsV4COKwzy/QvEUoQXdXPYYa
	B2ZhbypKNVqUDaJzVjIe4F6zqVBrrfR2TVf5cRu5p2foSZh9qpfii0BAUzyoXr21OnTzhVCJCACW5
	/RpePPrhJwvz7DstKvZfD9oqJh38oK7Lpa6yulSGhmEiKhwmXTmNvvss3uWswDiCcFSNW2EcSNHbJ
	fyCFs2YIaFBX4ELZklgIoekEV9bzy7GgKT49bm0qF9uHU3GhygN1YolFobABcHKSdZgC4qLYzQ5nd
	5BA6s9z+w/E2OCqBusMSSQEVBjToo+3IJEkUMqw168R1CuKZTe1cijlv57+GqnuKil0fh3PUm8SqR
	e5qTmU1w==;
Received: from [201.172.173.147] (port=49700 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rpYBn-003LDL-1K;
	Wed, 27 Mar 2024 13:39:55 -0500
Message-ID: <4e1261a7-25a9-4193-a9e9-9bc137893f08@embeddedor.com>
Date: Wed, 27 Mar 2024 12:39:54 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: wil6210: Annotate a couple of structs with
 __counted_by()
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <ZgRayuCJ0gQinMvr@neat>
 <3f19627e-4472-4ed1-9e2e-b0b427682910@quicinc.com>
 <5a6bdbc6-b37e-4c6b-9bff-470fd560663b@embeddedor.com>
In-Reply-To: <5a6bdbc6-b37e-4c6b-9bff-470fd560663b@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.147
X-Source-L: No
X-Exim-ID: 1rpYBn-003LDL-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.147]:49700
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGO1Ut/Ihq5rCvFnASbY72Oe70Imld/vi/ZHH57BW86NuLoN3jjXctwGVSrnUD7YrGNxwW1rQ38rQFwmFhUCjSCkVD59p8WKwz1kQolACKYENHYKLkk6
 LV3ndnGgK3aneND4bwe22iAhrME8uKP6O9wun2dSQhsDcANN4j89TPrZHZHdZG1Y7ERzcPpkj4Rehq//Stvmf4Bznj1EoCOnkZyLs2zXozkm4KqgJKhqQlqU


>>>   #define WMI_MAX_PNO_SSID_NUM    (16)
>>> @@ -3320,7 +3320,7 @@ struct wmi_set_link_monitor_cmd {
>>>       u8 rssi_hyst;
>>>       u8 reserved[12];
>>>       u8 rssi_thresholds_list_size;
>>> -    s8 rssi_thresholds_list[];
>>> +    s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size);
>>>   } __packed;
>>
>> this looks ok to me, although I think there is another issue associated with
>> this, namely the way the code populates the rssi_thresholds_list is by
>> defining a separate anonymous struct:
>>     struct {
>>         struct wmi_set_link_monitor_cmd cmd;
>>         s8 rssi_thold;
>>     } __packed cmd = {
>>         .cmd = {
>>             .rssi_hyst = rssi_hyst,
>>             .rssi_thresholds_list_size = 1,
>>         },
>>         .rssi_thold = rssi_thold,
>>     };
>>
>> I would expect gcc and clang to both complain about that s8 rssi_thold comes
>> after a flexible array (even though its purpose is to be the value of
>> rssi_thresholds_list[0])
>>

I will merge these two patches together:

https://lore.kernel.org/linux-hardening/ZgODZOB4fOBvKl7R@neat/
https://lore.kernel.org/linux-hardening/ZgOEoCWguq3n1OqQ@neat/

and send these changes together with the DEFINE_FLEX() transformation
in drivers/net/wireless/ath/wil6210/cfg80211.c

diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 71bf2ae27a98..38f64524019e 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -474,7 +474,7 @@ struct wmi_start_scan_cmd {
       struct {
           u8 channel;
           u8 reserved;
-    } channel_list[];
+    } channel_list[] __counted_by(num_channels);
   } __packed;

Thanks
--
Gustavo

